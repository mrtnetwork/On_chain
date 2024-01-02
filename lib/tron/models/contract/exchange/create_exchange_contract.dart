import 'package:on_chain/tron/address/tron_address.dart';
import 'package:on_chain/tron/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

/// Creates a trading pair.
class ExchangeCreateContract extends TronBaseContract {
  /// Create a new [ExchangeCreateContract] instance by parsing a JSON map.
  factory ExchangeCreateContract.fromJson(Map<String, dynamic> json) {
    return ExchangeCreateContract(
      ownerAddress: TronAddress(json["owner_address"]),
      firstTokenId: BytesUtils.tryFromHexString(json["first_token_id"]),
      firstTokenBalance: BigintUtils.tryParse(json["first_token_balance"]),
      secondTokenId: BytesUtils.tryFromHexString(json["second_token_id"]),
      secondTokenBalance: BigintUtils.tryParse(json["second_token_balance"]),
    );
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
      "first_token_id": BytesUtils.tryToHexString(firstTokenId),
      "first_token_balance": firstTokenBalance?.toString(),
      "second_token_id": BytesUtils.tryToHexString(secondTokenId),
      "second_token_balance": secondTokenBalance?.toString(),
    };
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
