import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/tezos/src/address/address.dart';
import 'package:on_chain/tezos/src/crypto/crypto.dart';

/// Known Tezos Base58 payload kinds (prefix + expected payload length).
enum TezosBase58Kind {
  /// Block hash `B…` — 32 bytes.
  blockHash([0x01, 0x34], 32, 'B'),

  /// Operation hash `o…` — 32 bytes.
  operationHash([0x05, 0x74], 32, 'o'),

  /// Protocol hash `P…` — 32 bytes.
  protocolHash([0x02, 0xaa], 32, 'P'),

  /// Context hash `Co…` — 32 bytes.
  contextHash([0x4f, 0xc7], 32, 'Co'),

  nonceHash([0x0A, 0xE1, 0xC7], 32, 'nce'),

  /// Script expression hash `expr…` — 32 bytes.
  scriptExpr([0x0d, 0x2c, 0x40, 0x1b], 32, 'expr'),

  chainId([0x57, 0x52, 0x00], 4, 'Net'),

  /// Smart rollup state hash `srs1…` — 32 bytes.
  smartRollupState([0x11, 0xa5, 0xeb, 0xf0], 32, 'srs1'),

  /// Smart rollup commitment hash `src1…` — 32 bytes.
  smartRollupCommitment([0x11, 0xa5, 0x86, 0x8a], 32, 'src1'),

  /// Generic signature `sig…` — 64 bytes (unprefixed curve).
  genericSignature([0x04, 0x82, 0x2b], 64, 'sig'),
  valueHash([1, 106, 242], null, 'vh'),

  lloHash([0x1D, 0x9F, 0x6D], 32, 'LLo'),
  dalCommitment([0x0A, 0xD9], 48, 'sh');

  /// Raw Base58Check prefix bytes.
  final List<int> prefix;
  final int? payloadLength;
  final String textPrefix;

  const TezosBase58Kind(this.prefix, this.payloadLength, this.textPrefix);

  static TezosBase58Kind? tryDetect(String base58) {
    // Longest prefix match on text prefix.
    TezosBase58Kind? best;
    for (final k in values) {
      if (base58.startsWith(k.textPrefix)) {
        if (best == null || k.textPrefix.length > best.textPrefix.length) {
          best = k;
        }
      }
    }
    return best;
  }
}

/// Encode / decode Tezos Base58Check strings for forge and signing.
class TezosUtils {
  const TezosUtils._();

  /// Decode [base58] and return payload bytes (prefix stripped).
  static List<int> decode(String base58, TezosBase58Kind kind) {
    return _decode(base58, kind.prefix, payloadLength: kind.payloadLength);
  }

  /// Decode [base58] and return payload bytes (prefix stripped).
  static List<int> _decode(
    String base58,
    List<int> prefix, {
    String? kind,
    int? payloadLength,
  }) {
    try {
      final raw = Base58Decoder.decodeWithChecksum(base58);
      if (raw.length >= prefix.length) {
        final content = raw.sublist(prefix.length);
        final p = raw.sublist(0, prefix.length);
        if (BytesUtils.bytesEqual(p, prefix)) {
          if (payloadLength != null && content.length != payloadLength) {
            throw OnChainErrors.tezosPlugin(
              'TezosUtils.decode',
              reason: 'Invalid payload length.',
              details: {'value': base58, 'kind': kind},
            );
          }
          return content;
        }
      }
      throw OnChainErrors.tezosPlugin(
        'TezosUtils.decode',
        reason: 'Base58 kind mismatch.',
        details: {'value': base58, 'kind': kind},
      );
    } on BuError {
      rethrow;
    } catch (e) {
      throw OnChainErrors.tezosPlugin(
        'TezosUtils.decode',
        reason: 'Invalid Base58Check string.',
        internalError: e,
        details: {'value': base58},
      );
    }
  }

  static String encodeScriptExprFromMicheline(List<int> michelineBinary) {
    final packed = [0x05, ...michelineBinary];
    final digest = QuickCrypto.blake2b256Hash(packed);
    return encode(TezosBase58Kind.scriptExpr, digest);
  }

  static String encodeScriptExpr(List<int> digest) {
    return encode(TezosBase58Kind.scriptExpr, digest);
  }

  static List<int> decodeScriptExpr(String digest) {
    return decode(digest, TezosBase58Kind.scriptExpr);
  }

  static String encodeLLo(List<int> digest) {
    return encode(TezosBase58Kind.lloHash, digest);
  }

  static List<int> decodeLLo(String digest) {
    return decode(digest, TezosBase58Kind.lloHash);
  }

  static String encodeDalCommitment(List<int> digest) {
    return encode(TezosBase58Kind.dalCommitment, digest);
  }

  static List<int> decodeDalCommitment(String digest) {
    return decode(digest, TezosBase58Kind.dalCommitment);
  }

  static String encodeNonceHash(List<int> digest) {
    return encode(TezosBase58Kind.nonceHash, digest);
  }

  static List<int> decodeNonceHash(String digest) {
    return decode(digest, TezosBase58Kind.nonceHash);
  }

  static String encodeContext(List<int> digest) {
    return encode(TezosBase58Kind.contextHash, digest);
  }

  static List<int> decodeContext(String digest) {
    return decode(digest, TezosBase58Kind.contextHash);
  }

  static String _encode(
    List<int> prefix,
    List<int> payload, {
    int? payloadLength,
  }) {
    if (payloadLength != null && payload.length != payloadLength) {
      throw OnChainErrors.tezosPlugin(
        'TezosUtils.encode',
        reason: 'Invalid payload length.',
      );
    }
    return Base58Encoder.encodeWithChecksum([...prefix, ...payload]);
  }

  /// Encode [payload] with [kind] prefix + Base58Check.
  static String encode(TezosBase58Kind kind, List<int> payload) {
    if (kind.payloadLength != null && payload.length != kind.payloadLength) {
      throw OnChainErrors.tezosPlugin(
        'TezosUtils.encode',
        reason: 'Invalid payload length.',
        details: {"kind": kind.name},
      );
    }
    return _encode(kind.prefix, payload);
  }

  static String encodeBlockHash(List<int> bytes32) =>
      encode(TezosBase58Kind.blockHash, bytes32);

  static List<int> decodeBlockHash(String branch) =>
      decode(branch, TezosBase58Kind.blockHash);

  static String encodeProtocol(List<int> bytes32) =>
      encode(TezosBase58Kind.protocolHash, bytes32);

  static List<int> decodeProtocol(String branch) =>
      decode(branch, TezosBase58Kind.protocolHash);

  static String encodeValueHash(List<int> hash) =>
      encode(TezosBase58Kind.valueHash, hash);

  static List<int> decodeValueHash(String hash) =>
      decode(hash, TezosBase58Kind.valueHash);

  static String encodeOperationHash(List<int> bytes32) =>
      encode(TezosBase58Kind.operationHash, bytes32);

  static List<int> decodeOperationHash(String opHash) =>
      decode(opHash, TezosBase58Kind.operationHash);

  static String encodeSmartRollupState(List<int> bytes32) =>
      encode(TezosBase58Kind.smartRollupState, bytes32);

  static List<int> decodeSmartRollupState(String srs1) =>
      decode(srs1, TezosBase58Kind.smartRollupState);

  static String encodeSmartRollupCommitment(List<int> bytes32) =>
      encode(TezosBase58Kind.smartRollupCommitment, bytes32);

  static List<int> decodeSmartRollupCommitment(String src1) =>
      decode(src1, TezosBase58Kind.smartRollupCommitment);

  static String encodePublicKey(TezosKeyType type, List<int> keyBytes) =>
      _encode(type.publicKeyPrefixBytes, keyBytes);

  static String encodeSignature(TezosKeyType? type, List<int> sigBytes) =>
      _encode(
        type?.signaturePrefixBytes ?? TezosBase58Kind.genericSignature.prefix,
        sigBytes,
      );

  static List<int> decodeSignature(String base58, {TezosKeyType? type}) {
    type ??= TezosKeyType.fromSignatureOrNull(base58);
    return _decode(
      base58,
      type?.signaturePrefixBytes ?? TezosBase58Kind.genericSignature.prefix,
    );
  }

  static List<int> encodeDestinationAddr(TezosAddress address) {
    if (address.isContract) {
      return [0x01, ...address.hashBytes, 0x00];
    }
    if (address.isSmartRollup) {
      // Smart-rollup address in manager ops is the raw 20-byte hash (no tag).
      return [...address.hashBytes];
    }
    // implicit
    return [0x00, ...address.toPublicKeyHashBytes()];
  }

  static TezosAddress decodeDestinationAddr(List<int> bytes) {
    if (bytes.length == 20) {
      return TezosAddress.smartRollupBytes(bytes);
    }

    if (bytes.length == 22 && bytes[0] == 0x00) {
      return TezosAddress.fromBytes(bytes.sublist(1)).ensureIsPubAddress();
    }

    if (bytes.length == 22 && bytes[0] == 0x01 && bytes[21] == 0x00) {
      return TezosAddress.contractBytes(bytes.sublist(1, 21));
    }

    throw OnChainErrors.tezosPlugin(
      'TezosUtils.decodeDestinationAddr',
      reason: 'Invalid destination address bytes',
    );
  }
}

extension ExtTezosAddress on TezosAddress {
  TezosAddress ensureIsPubAddress() {
    if (type.pubKeyTag == null) {
      throw OnChainErrors.tezosPlugin(
        'ensureIsPubAddress',
        reason: "Invalid Tezos public key hash address.",
      );
    }
    return this;
  }

  TezosAddress ensureIsContractAddress() {
    return ensureIsAddress(XtzAddrPrefixes.kt1);
  }

  TezosAddress ensureIsRollUp() {
    return ensureIsAddress(XtzAddrPrefixes.sr1);
  }

  TezosAddress ensureIsAddress(XtzAddrPrefixes type) {
    if (this.type != type) {
      throw OnChainErrors.tezosPlugin(
        'ensureIsAddress',
        reason: 'Invalid Tezos ${type.name} address.',
        details: {"type": this.type.name},
      );
    }
    return this;
  }

  TezosAddress ensureIsZkRollUp() {
    return ensureIsAddress(XtzAddrPrefixes.epx1);
  }
}
