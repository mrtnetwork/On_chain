import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';
import 'package:on_chain/utils/utils/utils.dart';

/// Withdraws the transaction pair.
class ExchangeWithdrawContract extends TronBaseContract {
  /// Create a new [ExchangeWithdrawContract] instance by parsing a JSON map.
  factory ExchangeWithdrawContract.fromJson(Map<String, dynamic> json) {
    return ExchangeWithdrawContract(
      ownerAddress: OnChainUtils.parseTronAddress(
          value: json["owner_address"], name: "owner_address"),
      exchangeId: OnChainUtils.parseBigInt(
          value: json["exchange_id"], name: "exchange_id"),
      tokenId:
          OnChainUtils.parseBytes(value: json["token_id"], name: "token_id"),
      quant: OnChainUtils.parseBigInt(value: json["quant"], name: "quant"),
    );
  }
  factory ExchangeWithdrawContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return ExchangeWithdrawContract(
        ownerAddress: TronAddress.fromBytes(decode.getField(1)),
        exchangeId: decode.getField(2),
        tokenId: decode.getField(3),
        quant: decode.getField(4));
  }

  /// Create a new [ExchangeWithdrawContract] instance with specified parameters.
  ExchangeWithdrawContract(
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

  /// The id of the token to be withdrawn
  final List<int>? tokenId;

  /// 	The amount of tokens to be withdrawn
  final BigInt? quant;

  @override
  List<int> get fieldIds => [1, 2, 3, 4];

  @override
  List get values => [ownerAddress, exchangeId, tokenId, quant];

  /// Convert the [ExchangeWithdrawContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress,
      "exchange_id": exchangeId,
      "token_id": BytesUtils.tryToHexString(tokenId),
      "quant": quant,
    }..removeWhere((key, value) => value == null);
  }

  /// Convert the [ExchangeWithdrawContract] object to its string representation.
  @override
  String toString() {
    return "ExchangeWithdrawContract{${toJson()}}";
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.exchangeWithdrawContract;
}
