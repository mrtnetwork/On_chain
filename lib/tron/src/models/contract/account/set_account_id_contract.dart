import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';

class SetAccountIdContract extends TronBaseContract {
  /// Create a new [SetAccountIdContract] instance by parsing a JSON map.
  factory SetAccountIdContract.fromJson(Map<String, dynamic> json) {
    return SetAccountIdContract(
      accountId: StringUtils.encode(json["account_id"]),
      ownerAddress: TronAddress(json["owner_address"]),
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
    }..removeWhere((key, value) => value == null);
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
