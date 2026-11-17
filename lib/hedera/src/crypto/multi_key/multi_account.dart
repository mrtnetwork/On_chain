import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/hedera/src/crypto/private_key/secret_key.dart';
import 'package:on_chain/hedera/src/crypto/public_key/public_key.dart';
import 'package:on_chain/hedera/src/crypto/types/types.dart';
import 'package:on_chain/hedera/src/crypto/utils/utils.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/src/transaction.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/src/transaction_contents.dart';

abstract class HederaMultiAccountPublicKey {
  List<HederaPublicKey> get publicKeys;
  int get threshold;
  HederaKey toHederaKey();
  bool verify({
    required List<int> message,
    required List<HederaSignaturePair> signatures,
  });
}

/// M-of-N threshold public account.
class HederaThresholdAccountPublicKey implements HederaMultiAccountPublicKey {
  @override
  final List<HederaPublicKey> publicKeys;
  @override
  final int threshold;

  HederaThresholdAccountPublicKey._({
    required List<HederaPublicKey> publicKeys,
    required this.threshold,
  }) : publicKeys = publicKeys.immutable;

  factory HederaThresholdAccountPublicKey({
    required List<HederaPublicKey> publicKeys,
    required int threshold,
  }) {
    if (publicKeys.isEmpty) {
      throw OnChainErrors.hederaPlugin(
        'HederaThresholdAccountPublicKey',
        reason: 'publicKeys cannot be empty.',
      );
    }
    if (threshold <= 0 || threshold > publicKeys.length) {
      throw OnChainErrors.hederaPlugin(
        'HederaThresholdAccountPublicKey',
        reason:
            'Invalid threshold $threshold for ${publicKeys.length} public keys.',
      );
    }
    final seen = <HederaPublicKey>{};
    for (final pk in publicKeys) {
      if (!seen.add(pk)) {
        throw OnChainErrors.hederaPlugin(
          'HederaThresholdAccountPublicKey',
          reason: 'Duplicate public key in participant list.',
        );
      }
    }
    return HederaThresholdAccountPublicKey._(
      publicKeys: publicKeys,
      threshold: threshold,
    );
  }

  static HederaThresholdAccountPublicKey? fromHederaKey(HederaKey key) {
    try {
      final tk = key.thresholdKey;
      if (tk == null || tk.keys == null) return null;
      final t = tk.threshold;
      if (t == null || t <= 0) return null;
      final pks = <HederaPublicKey>[];
      for (final k in tk.keys!.keys) {
        final pk = HederaPublicKey.fromHederaKey(k);
        if (pk == null) return null;
        pks.add(pk);
      }
      if (pks.isEmpty) return null;
      return HederaThresholdAccountPublicKey(publicKeys: pks, threshold: t);
    } catch (_) {
      return null;
    }
  }

  @override
  HederaKey toHederaKey() {
    return HederaKey(
      thresholdKey: HederaThresholdKey(
        threshold: threshold,
        keys: HederaKeyList(
          keys: publicKeys.map((e) => e.toHederaKey()).toList(),
        ),
      ),
    );
  }

  @override
  bool verify({
    required List<int> message,
    required List<HederaSignaturePair> signatures,
  }) {
    return countValidSignatures(message: message, signatures: signatures) >=
        threshold;
  }

  int countValidSignatures({
    required List<int> message,
    required List<HederaSignaturePair> signatures,
  }) {
    var valid = 0;
    final used = <HederaPublicKey>{};
    for (final pair in signatures) {
      final matched = matchParticipant(pair);
      if (matched == null) continue;
      if (used.contains(matched)) continue;
      final sigBytes = HederaCryptoUtils.signatureBytesOf(pair);
      if (sigBytes == null || sigBytes.isEmpty) continue;
      if (!matched.verifySignature(message, sigBytes)) continue;
      used.add(matched);
      valid++;
    }
    return valid;
  }

  HederaPublicKey? matchParticipant(HederaSignaturePair pair) {
    final prefix = pair.pubKeyPrefix;
    if (prefix == null || prefix.isEmpty) return null;
    for (final pk in publicKeys) {
      final b = pk.toBytes();
      if (b.length >= prefix.length &&
          BytesUtils.bytesEqual(b.sublist(0, prefix.length), prefix)) {
        return pk;
      }
    }
    return null;
  }
}

/// N-of-N KeyList public account.
class HederaKeyListAccountPublicKey implements HederaMultiAccountPublicKey {
  @override
  final List<HederaPublicKey> publicKeys;

  HederaKeyListAccountPublicKey._(List<HederaPublicKey> publicKeys)
    : publicKeys = publicKeys.immutable;

  factory HederaKeyListAccountPublicKey({
    required List<HederaPublicKey> publicKeys,
  }) {
    if (publicKeys.isEmpty) {
      throw OnChainErrors.hederaPlugin(
        'HederaKeyListAccountPublicKey',
        reason: 'publicKeys cannot be empty.',
      );
    }
    final seen = <HederaPublicKey>{};
    for (final pk in publicKeys) {
      if (!seen.add(pk)) {
        throw OnChainErrors.hederaPlugin(
          'HederaKeyListAccountPublicKey',
          reason: 'Duplicate public key in list.',
        );
      }
    }
    return HederaKeyListAccountPublicKey._(publicKeys);
  }

  @override
  int get threshold => publicKeys.length;

  static HederaKeyListAccountPublicKey? fromHederaKey(HederaKey key) {
    try {
      final list = key.keyList;
      if (list == null || list.keys.isEmpty) return null;
      final pks = <HederaPublicKey>[];
      for (final k in list.keys) {
        final pk = HederaPublicKey.fromHederaKey(k);
        if (pk == null) return null;
        pks.add(pk);
      }
      return HederaKeyListAccountPublicKey(publicKeys: pks);
    } catch (_) {
      return null;
    }
  }

  @override
  HederaKey toHederaKey() {
    return HederaKey(
      keyList: HederaKeyList(
        keys: publicKeys.map((e) => e.toHederaKey()).toList(),
      ),
    );
  }

  @override
  bool verify({
    required List<int> message,
    required List<HederaSignaturePair> signatures,
  }) {
    return HederaThresholdAccountPublicKey(
      publicKeys: publicKeys,
      threshold: publicKeys.length,
    ).verify(message: message, signatures: signatures);
  }
}

class HederaMultiSigAccount implements HederaSigner {
  final HederaMultiAccountPublicKey publicKeyAccount;
  final List<HederaSecretKey> signers;

  const HederaMultiSigAccount(this.publicKeyAccount, {this.signers = const []});

  factory HederaMultiSigAccount.threshold({
    required List<HederaPublicKey> publicKeys,
    required int threshold,
    List<HederaSecretKey> signers = const [],
  }) {
    return HederaMultiSigAccount(
      HederaThresholdAccountPublicKey(
        publicKeys: publicKeys,
        threshold: threshold,
      ),
      signers: signers,
    );
  }

  factory HederaMultiSigAccount.keyList({
    required List<HederaPublicKey> publicKeys,
    List<HederaSecretKey> signers = const [],
  }) {
    return HederaMultiSigAccount(
      HederaKeyListAccountPublicKey(publicKeys: publicKeys),
      signers: signers,
    );
  }

  /// One signature pair from a local secret key.
  HederaSignaturePair singleSign(List<int> message, HederaSecretKey signer) {
    final pk = signer.toPublicKey();
    if (!_contains(pk)) {
      throw OnChainErrors.hederaPlugin(
        'singleSign',
        reason: 'Signer public key is not a multi-account participant.',
      );
    }
    return signer.signToPair(message);
  }

  List<HederaSignaturePair> signMessage(
    List<int> message, {
    List<HederaSecretKey> availableSigners = const [],
    bool stopAfterThreshold = true,
    bool requireThreshold = true,
    bool simulate = false,
  }) {
    final needed = publicKeyAccount.threshold;
    final pairs = <HederaSignaturePair>[];
    final used = <HederaPublicKey>{};

    if (simulate) {
      final placeholder = List<int>.filled(64, 1);
      for (
        var i = 0;
        i < needed && i < publicKeyAccount.publicKeys.length;
        i++
      ) {
        final pk = publicKeyAccount.publicKeys[i];
        pairs.add(
          HederaCryptoUtils.buildSignaturePair(
            type: pk.type,
            publicKeyBytes: pk.toBytes(),
            signature: placeholder,
          ),
        );
      }
      return pairs;
    }

    final allSigners = [...availableSigners, ...signers];
    var count = 0;

    for (final pk in publicKeyAccount.publicKeys) {
      if (used.contains(pk)) continue;
      HederaSecretKey? match;
      for (final s in allSigners) {
        if (s.toPublicKey() == pk) {
          match = s;
          break;
        }
      }
      if (match == null) continue;

      pairs.add(singleSign(message, match));
      used.add(pk);
      count++;
      if (stopAfterThreshold && count >= needed) break;
    }

    if (requireThreshold && count < needed) {
      throw OnChainErrors.hederaPlugin(
        'signMessage',
        reason: 'Not enough signers for threshold ($count / $needed).',
      );
    }
    return pairs;
  }

  List<HederaSignaturePair> buildSignedSignatures({
    required List<int> message,
    required List<HederaSignaturePair> availableSignatures,
    bool stopAfterThreshold = true,
    bool requireThreshold = true,
    bool verifySignatures = true,
  }) {
    final pairs = <HederaSignaturePair>[];
    final used = <HederaPublicKey>{};
    var count = 0;
    final needed = publicKeyAccount.threshold;

    for (final pk in publicKeyAccount.publicKeys) {
      if (used.contains(pk)) continue;
      HederaSignaturePair? match;
      for (final p in availableSignatures) {
        final prefix = p.pubKeyPrefix;
        if (prefix == null || prefix.isEmpty) continue;
        final b = pk.toBytes();
        if (b.length >= prefix.length &&
            BytesUtils.bytesEqual(b.sublist(0, prefix.length), prefix)) {
          match = p;
          break;
        }
      }
      if (match == null) continue;

      if (verifySignatures) {
        final sig = HederaCryptoUtils.signatureBytesOf(match);
        if (sig == null || sig.isEmpty || !pk.verifySignature(message, sig)) {
          continue;
        }
      }

      pairs.add(match);
      used.add(pk);
      count++;
      if (stopAfterThreshold && count >= needed) break;
    }

    if (requireThreshold && count < needed) {
      throw OnChainErrors.hederaPlugin(
        'buildSignedSignatures',
        reason: 'Not enough valid signatures ($count / $needed).',
      );
    }
    return pairs;
  }

  static List<HederaSignaturePair> mergeSignatures(
    List<List<HederaSignaturePair>> batches,
  ) {
    final seen = <String>{};
    final out = <HederaSignaturePair>[];
    for (final batch in batches) {
      for (final p in batch) {
        final prefix = p.pubKeyPrefix;
        final id =
            (prefix == null || prefix.isEmpty)
                ? 'empty-${out.length}'
                : BytesUtils.toHexString(prefix);
        if (seen.add(id)) out.add(p);
      }
    }
    return out;
  }

  @override
  Future<List<HederaSignaturePair>> signTransaction(
    HederaTransactionBody txBody, {
    List<HederaSecretKey> availableSigners = const [],
    bool stopAfterThreshold = true,
    bool requireThreshold = true,
  }) async {
    return signMessage(
      txBody.toBuffer(),
      availableSigners: availableSigners,
      stopAfterThreshold: stopAfterThreshold,
      requireThreshold: requireThreshold,
    );
  }

  @override
  Future<HederaTransaction> signQueryPaymentTransaction({
    required HederaTransactionBody body,
    required dynamic query,
    required BigInt cost,
  }) async {
    final pairs = await signTransaction(body);
    final signed = HederaSignedTransaction(
      bodyBytes: body.toBuffer(),
      sigMap: HederaSignatureMap(sigPair: pairs),
    );
    return HederaTransaction(signedTransactionBytes: signed.toBuffer());
  }

  Future<List<HederaSignaturePair>> signSimulateTransaction(
    HederaTransactionBody body,
  ) async {
    return signMessage(body.toBuffer(), simulate: true);
  }

  bool _contains(HederaPublicKey pk) =>
      publicKeyAccount.publicKeys.contains(pk);
}
