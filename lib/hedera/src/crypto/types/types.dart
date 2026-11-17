import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/src/transaction.dart';

/// Primitive key algorithms supported by this package.
enum HederaKeyType {
  ed25519(0),
  secp256k1(1),
  ecdsa384(2),
  rsa3072(3);

  final int value;
  const HederaKeyType(this.value);

  static HederaKeyType fromValue(int value) {
    return HederaKeyType.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw OnChainErrors.hederaPlugin(
                "HederaKeyType.fromValue",
                reason: "Invalid Hedera key type value.",
                details: {"value": "$value"},
              ),
    );
  }

  static HederaKeyType fromName(String keyName) {
    return HederaKeyType.values.firstWhere(
      (e) => e.name == keyName,
      orElse:
          () =>
              throw OnChainErrors.hederaPlugin(
                "HederaKeyType.fromName",
                reason: "Invalid Hedera key type name.",
                details: {"name": keyName},
              ),
    );
  }
}

/// Signs Hedera transaction bodies and query-payment transactions.
abstract class HederaSigner {
  /// Sign a regular transaction body; returns one or more [HederaSignaturePair]s.
  Future<List<HederaSignaturePair>> signTransaction(
    HederaTransactionBody txBody,
  );

  /// Sign the payment transaction attached to a paid query.
  Future<HederaTransaction> signQueryPaymentTransaction({
    required HederaTransactionBody body,
    required dynamic query, // IHederaQuery
    required BigInt cost,
  });
}

/// Signs Hedera transaction bodies and query-payment transactions.
abstract class HederaEthereumSigner {
  /// Sign a regular Ethereum transaction, EIP-155
  Future<List<int>> signEthereum(List<int> message, {List<int>? extraEntropy});
}
