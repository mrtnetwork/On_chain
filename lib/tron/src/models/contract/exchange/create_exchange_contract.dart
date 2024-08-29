import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';
import 'package:on_chain/utils/utils.dart';

/// Creates a trading pair.
class ExchangeCreateContract extends TronBaseContract {
  /// Create a new [ExchangeCreateContract] instance by parsing a JSON map.
  factory ExchangeCreateContract.fromJson(Map<String, dynamic> json) {
    return ExchangeCreateContract(
      ownerAddress: OnChainUtils.parseTronAddress(
          value: json["owner_address"], name: "owner_address"),
      firstTokenId: OnChainUtils.parseBytes(
          value: json["first_token_id"], name: "first_token_id"),
      firstTokenBalance: OnChainUtils.parseBigInt(
          value: json["first_token_balance"], name: "first_token_balance"),
      secondTokenId: OnChainUtils.parseBytes(
          value: json["second_token_id"], name: "second_token_id"),
      secondTokenBalance: OnChainUtils.parseBigInt(
          value: json["second_token_balance"], name: "second_token_balance"),
    );
  }
  factory ExchangeCreateContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return ExchangeCreateContract(
        ownerAddress: TronAddress.fromBytes(decode.getField(1)),
        firstTokenId: decode.getField(2),
        firstTokenBalance: decode.getField(3),
        secondTokenId: decode.getField(4),
        secondTokenBalance: decode.getField(5));
  }

  /// Create a new [ExchangeCreateContract] instance with specified parameters.
  ExchangeCreateContract(
      {required this.ownerAddress,
      this.firstTokenBalance,
      List<int>? firstTokenId,
      this.secondTokenBalance,
      List<int>? secondTokenId})
      : firstTokenId = BytesUtils.tryToBytes(firstTokenId, unmodifiable: true),
        secondTokenId =
            BytesUtils.tryToBytes(secondTokenId, unmodifiable: true);

  /// Account address
  @override
  final TronAddress ownerAddress;

  /// First token id
  final List<int>? firstTokenId;

  /// First token balance
  final BigInt? firstTokenBalance;

  /// Second token id
  final List<int>? secondTokenId;

  /// Second token balance
  final BigInt? secondTokenBalance;

  @override
  List<int> get fieldIds => [1, 2, 3, 4, 5];

  @override
  List get values => [
        ownerAddress,
        firstTokenId,
        firstTokenBalance,
        secondTokenId,
        secondTokenBalance
      ];

  /// Convert the [ExchangeCreateContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress.toString(),
      "first_token_id": StringUtils.tryDecode(firstTokenId),
      "first_token_balance": firstTokenBalance?.toString(),
      "second_token_id": StringUtils.tryDecode(secondTokenId),
      "second_token_balance": secondTokenBalance?.toString(),
    }..removeWhere((key, value) => value == null);
  }

  /// Convert the [ExchangeCreateContract] object to its string representation.
  @override
  String toString() {
    return 'ExchangeCreateContract{${toJson()}}';
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.exchangeCreateContract;
}
