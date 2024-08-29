import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';
import 'package:on_chain/utils/utils.dart';

/// Injects capital into the transaction.
/// The purpose of injecting capital into the trading pair
/// is to prevent price fluctuation from affecting the transaction.
class ExchangeInjectContract extends TronBaseContract {
  /// Create a new [ExchangeInjectContract] instance by parsing a JSON map.
  factory ExchangeInjectContract.fromJson(Map<String, dynamic> json) {
    return ExchangeInjectContract(
      ownerAddress: OnChainUtils.parseTronAddress(
          value: json["owner_address"], name: "owner_address"),
      exchangeId: OnChainUtils.parseBigInt(
          value: json["exchange_id"], name: "exchange_id"),
      tokenId:
          OnChainUtils.parseBytes(value: json["token_id"], name: "token_id"),
      quant: OnChainUtils.parseBigInt(value: json["quant"], name: "quant"),
    );
  }
  factory ExchangeInjectContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return ExchangeInjectContract(
        ownerAddress: TronAddress.fromBytes(decode.getField(1)),
        exchangeId: decode.getField(2),
        tokenId: decode.getField(3),
        quant: decode.getField(4));
  }

  /// Create a new [ExchangeInjectContract] instance with specified parameters.
  ExchangeInjectContract(
      {required this.ownerAddress,
      this.exchangeId,
      List<int>? tokenId,
      this.quant})
      : tokenId = BytesUtils.tryToBytes(tokenId);

  /// Account address
  @override
  final TronAddress ownerAddress;

  /// Exchange id
  final BigInt? exchangeId;

  /// The id of the token to be injected
  final List<int>? tokenId;

  /// The amount of tokens to be injected
  final BigInt? quant;

  @override
  List<int> get fieldIds => [1, 2, 3, 4];

  @override
  List get values => [ownerAddress, exchangeId, tokenId, quant];

  /// Convert the [ExchangeInjectContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress.toString(),
      "exchange_id": exchangeId?.toString(),
      "token_id": BytesUtils.tryToHexString(tokenId),
      "quant": quant?.toString(),
    }..removeWhere((key, value) => value == null);
  }

  /// Convert the [ExchangeInjectContract] object to its string representation.
  @override
  String toString() {
    return "ExchangeInjectContract{${toJson()}}";
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.exchangeInjectContract;
}
