import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';
import 'package:on_chain/utils/utils.dart';

class SetAccountIdContract extends TronBaseContract {
  /// Create a new [SetAccountIdContract] instance by parsing a JSON map.
  factory SetAccountIdContract.fromJson(Map<String, dynamic> json) {
    return SetAccountIdContract(
      accountId: OnChainUtils.parseBytes(
          value: json["account_id"], name: "account_id"),
      ownerAddress: OnChainUtils.parseTronAddress(
          value: json["owner_address"], name: "owner_address"),
    );
  }

  /// Factory method to create a new [SetAccountIdContract] instance with specified parameters.
  SetAccountIdContract({
    required List<int> accountId,
    required this.ownerAddress,
  }) : accountId = BytesUtils.toBytes(accountId, unmodifiable: true);

  factory SetAccountIdContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return SetAccountIdContract(
        accountId: decode.getField(1),
        ownerAddress: TronAddress.fromBytes(decode.getField(2)));
  }
  final List<int> accountId;
  @override
  final TronAddress ownerAddress;

  @override
  List<int> get fieldIds => [1, 2];

  @override
  List get values => [accountId, ownerAddress];

  /// Convert the [SetAccountIdContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress.toString(),
      "account_id": StringUtils.decode(accountId)
    };
  }

  /// Convert the [SetAccountIdContract] object to its string representation.
  @override
  String toString() {
    return "SetAccountIdContract{${toJson()}}";
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.setAccountIdContract;
}
