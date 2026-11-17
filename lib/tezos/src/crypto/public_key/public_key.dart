import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/tezos/src/address/address.dart';
import 'package:on_chain/tezos/src/crypto/types/types.dart';
import 'package:on_chain/tezos/src/crypto/utils/utils.dart';

abstract class TezosPublicKey with Equality {
  final TezosKeyType type;
  TezosPublicKey({required this.type});
  factory TezosPublicKey.decode(String base58) {
    final key = TezosCryptoUtils.decodePubkey(base58);
    return key.cast();
  }

  /// Raw public key bytes (curve-specific).
  BuBytes toBytes();

  /// Verify [signature] over [message].
  bool verify(List<int> message, List<int> signature);

  T cast<T extends TezosPublicKey>() {
    if (this is! T) {
      throw OnChainErrors.tezosPlugin(
        "TezosPublicKey.cast",
        reason: "Invalid key cast.",
        details: {"expected": "$T", "actual": "$runtimeType"},
      );
    }
    return this as T;
  }

  String encode() {
    return TezosCryptoUtils.encodePublicKey(this);
  }

  TezosAddress toAddress() =>
      TezosAddress.fromPublickey(publicKey: toBytes(), keyType: type);
}
