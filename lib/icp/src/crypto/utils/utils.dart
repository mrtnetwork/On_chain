import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/icp/src/crypto/crypto.dart';
import 'package:on_chain/icp/src/rpc/types/types.dart';
import 'package:on_chain/icp/src/service/certificate/src/icp_certificate.dart';
import 'package:on_chain/icp/src/service/http/types/icp_http_content.dart';
import 'package:on_chain/icp/src/service/http/types/icp_http_responses.dart';

class ICPCryptoUtils {
  static List<int> hashName(String name) {
    return QuickCrypto.sha256Hash(StringUtils.encode(name));
  }

  static List<int> hashBlob(List<int> value) {
    return QuickCrypto.sha256Hash(value);
  }

  static List<int> hashText(String value) {
    return QuickCrypto.sha256Hash(StringUtils.encode(value));
  }

  static List<int> hashNat(BigInt value) {
    return QuickCrypto.sha256Hash(
      LayoutConst.lebBigInteger(LayoutConst.u128()).serialize(value),
    );
  }

  static List<int> hashInt(BigInt value) {
    return QuickCrypto.sha256Hash(
      LayoutConst.lebBigInteger(LayoutConst.i128()).serialize(value),
    );
  }

  static List<int> hashArray(List<dynamic> values) {
    final data = <int>[];

    for (final value in values) {
      data.addAll(hashValue(value));
    }

    return QuickCrypto.sha256Hash(data);
  }

  static List<int> hashNestedMap(Map<String, dynamic> value) {
    return hashMap(value);
  }

  static List<int> hashValue(dynamic value) {
    if (value is String) {
      return hashText(value);
    }

    if (value is List<int>) {
      return hashBlob(value);
    }

    if (value is BigInt) {
      if (value.isNegative) {
        return hashInt(value);
      }
      return hashNat(value);
    }

    if (value is int) {
      final v = BigInt.from(value);
      if (v.isNegative) {
        return hashInt(v);
      }
      return hashNat(v);
    }

    if (value is List) {
      return hashArray(value);
    }

    if (value is Map<String, dynamic>) {
      return hashNestedMap(value);
    }
    throw OnChainErrors.icpPlugin(
      "ICPCryptoUtils.hashValue",
      reason:
          'Unsupported value type for ICP representation-independent hashing.',
      details: {'type': '${value.runtimeType}'},
    );
  }

  static List<int> hashMap(Map<String, dynamic> map) {
    final entries = <List<int>>[];
    for (final entry in map.entries) {
      // Optional fields that are absent are represented by null in Dart.
      // They must NOT be included.
      if (entry.value == null) {
        continue;
      }

      final fieldHash = hashName(entry.key);
      final valueHash = hashValue(entry.value);

      entries.add([...fieldHash, ...valueHash]);
    }
    entries.sort(BytesUtils.compareBytes);
    final data = <int>[];
    for (final entry in entries) {
      data.addAll(entry);
    }
    return QuickCrypto.sha256Hash(data);
  }

  static List<int> hashContent(ICPHttpContent content) {
    final entries = <List<int>>[];

    // ---------- helpers ----------
    void addText(String key, String value) {
      final keyHash = hashText(key);
      final valueHash = hashText(value);
      entries.add([...keyHash, ...valueHash]);
    }

    void addBytes(String key, List<int> value) {
      final keyHash = hashText(key);
      final valueHash = hashBlob(value);
      entries.add([...keyHash, ...valueHash]);
    }

    void addNat(String key, BigInt value) {
      final keyHash = hashText(key);
      final valueHash = hashNat(value);
      entries.add([...keyHash, ...valueHash]);
    }

    /// Hash the whole paths field (array of paths)
    void addPaths(String key, List<List<List<int>>> paths) {
      final keyHash = QuickCrypto.sha256Hash(StringUtils.encode(key));
      // final pathHashes = paths.map(hashArray).expand((e) => e).toList();
      final valueHash = hashArray(paths);
      entries.add([...keyHash, ...valueHash]);
    }

    /// Hash a nested map (sender_info)
    void addMap(String key, Map<String, dynamic> map) {
      final keyHash = QuickCrypto.sha256Hash(StringUtils.encode(key));
      // recursively compute representation-independent hash of the map
      final mapHash = hashMap(map);
      entries.add([...keyHash, ...mapHash]);
    }

    addText('request_type', content.type.value);

    switch (content) {
      case ICPHttpCallContent(
        :final canisterId,
        :final methodName,
        :final arg,
        :final senderInfo,
      ):
        addBytes('canister_id', canisterId.toBytes());
        addText('method_name', methodName);
        addBytes('arg', arg);
        if (senderInfo != null) {
          addMap('sender_info', {
            'info': senderInfo.info,
            'signer': senderInfo.signer.toBytes(),
            'sig': senderInfo.sig,
          });
        }
        break;

      case ICPHttpReadStateContent(:final paths):
        addPaths('paths', paths);
        break;

      case ICPHttpQueryContent(
        :final canisterId,
        :final methodName,
        :final arg,
        :final senderInfo,
      ):
        addBytes('canister_id', canisterId.toBytes());
        addText('method_name', methodName);
        addBytes('arg', arg);
        if (senderInfo != null) {
          addMap('sender_info', {
            'info': senderInfo.info,
            'signer': senderInfo.signer.toBytes(),
            'sig': senderInfo.sig,
          });
        }
        break;
    }

    addBytes('sender', content.sender.toBytes());
    addNat('ingress_expiry', content.ingressExpiry);

    final nonce = content.nonce;
    if (nonce != null) {
      addBytes('nonce', nonce);
    }

    entries.sort(BytesUtils.compareBytes);

    final data = <int>[];
    for (final entry in entries) {
      data.addAll(entry);
    }
    return QuickCrypto.sha256Hash(data);
  }

  static List<int> domainSeparator(String domain, List<int> data) {
    final bytes = StringUtils.encode(domain);
    return [bytes.length, ...bytes, ...data];
  }

  static List<int> hashDomainSeparator(String domain, List<int> data) {
    return QuickCrypto.sha256Hash(domainSeparator(domain, data));
  }

  static List<int> signContent(ICPHttpContent content) {
    const separator = 'ic-request';
    return domainSeparator(separator, hashContent(content));
  }

  static List<int> hashQueryResponsePayload({
    required ICPDecodedQueryResponse response,
    required List<int> requestId,
    required ICPHttpNodeSignature signature,
  }) {
    final Map<String, dynamic> map = switch (response) {
      ICPDecodedQueryResponseErr(:final error) => {
        "status": "rejected",
        "reject_code": error.rejectCode,
        "reject_message": error.rejectMessage,
        if (error.errorCode != null) "error_code": error.errorCode,
        "timestamp": signature.timestamp,
        "request_id": requestId,
      },
      ICPDecodedQueryResponseReplied(:final arg) => {
        "status": "replied",
        "reply": {"arg": arg},
        "timestamp": signature.timestamp,
        "request_id": requestId,
      },
    };
    return ICPCryptoUtils.hashMap(map);
  }

  static List<int> getQueryResponseSignedMessage({
    required ICPDecodedQueryResponse response,
    required List<int> requestId,
    required ICPHttpNodeSignature signature,
  }) {
    final payload = hashQueryResponsePayload(
      response: response,
      requestId: requestId,
      signature: signature,
    );
    const label = 'ic-response';
    return domainSeparator(label, payload);
  }

  static Future<bool> verify({
    required ICPCertificate certificate,
    required List<int> rootKey,
    CbBlsVerificationKey? verificationKey,
    CbED25519Verification? ed25519Verification,
    List<ICPFullDecodedQueryResponse> queries = const [],
  }) async {
    final result = await certificate.verify(
      rootKey: rootKey,
      verificationKey: verificationKey,
    );
    if (!result) return false;
    for (final q in queries) {
      for (final i in q.response.signatures) {
        final pubkey = certificate.tryGetNodePublicKey(
          nodeId: i.identity,
          rootKey: rootKey,
        );
        if (pubkey == null) return false;
        final message = ICPCryptoUtils.getQueryResponseSignedMessage(
          response: q.response,
          requestId: q.id,
          signature: i,
        );
        bool verify = switch (ed25519Verification) {
          null => ICPEd25519PublicKey.froDer(
            pubkey,
          ).verify(message, i.signature),
          _ => await ed25519Verification(pubkey, i.signature),
        };
        if (!verify) return false;
      }
    }

    return true;
  }

  static List<int> selfAuthenticatingHash(List<int> derPublicKey) {
    return ICPAddrUtils.selfAuthenticated(derPublicKey);
  }

  /// BLS domain separator for state root signatures
  static List<int> icStateRootMessage(List<int> rootHash) {
    const domain = 'ic-state-root'; // 13 bytes
    return domainSeparator(domain, rootHash);
  }
}
