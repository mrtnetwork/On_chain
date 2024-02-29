import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

/// Participate the transaction of exchange pair
class ExchangeTransactionContract extends TronBaseContract {
  /// Create a new [ExchangeTransactionContract] instance by parsing a JSON map.
  factory ExchangeTransactionContract.fromJson(Map<String, dynamic> json) {
    return ExchangeTransactionContract(
      ownerAddress: TronAddress(json["owner_address"]),
      exchangeId: BigintUtils.tryParse(json["exchange_id"]),
      tokenId: BytesUtils.fromHexString(json["token_id"]),
      quant: BigintUtils.tryParse(json["quant"]),
      expected: BigintUtils.tryParse(json["expected"]),
    );
  }

  /// Create a new [ExchangeTransactionContract] instance with specified parameters.
  ExchangeTransactionContract(
      {required this.ownerAddress,
      this.exchangeId,
      List<int>? tokenId,
      this.quant,
      this.expected})
      : tokenId = BytesUtils.tryToBytes(tokenId);

  /// Trader's wallet address
  final TronAddress ownerAddress;

  /// Transaction Pair ID
  final BigInt? exchangeId;

  /// ID of the sold token
  final List<int>? tokenId;

  /// Quantity of the token being sold. If TRX being sold, need to express in units of SUN.
  final BigInt? quant;

  /// Expected quantity of the token being purchased.
  final BigInt? expected;

  @override
  List<int> get fieldIds => [1, 2, 3, 4, 5];

  @override
  List get values => [ownerAddress, exchangeId, tokenId, quant, expected];

  /// Convert the [ExchangeTransactionContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress.toString(),
      "exchange_id": exchangeId?.toString(),
      "token_id": BytesUtils.tryToHexString(tokenId),
      "quant": quant?.toString(),
      "expected": expected?.toString(),
    }..removeWhere((key, value) => value == null);
  }

  /// Convert the [ExchangeTransactionContract] object to its string representation.
  @override
  String toString() {
    return "ExchangeTransactionContract{${toJson()}}";
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.exchangeTransactionContract;
}
