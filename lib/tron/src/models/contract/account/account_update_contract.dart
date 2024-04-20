import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';

/// Modify account name
class AccountUpdateContract extends TronBaseContract {
  /// Create a new [AccountUpdateContract] instance by parsing a JSON map.
  factory AccountUpdateContract.fromJson(Map<String, dynamic> json) {
    return AccountUpdateContract(
        ownerAddress: TronAddress(json["owner_address"]),
        accountName: StringUtils.encode(json["account_name"]));
  }

  /// Factory method to create a new [AccountUpdateContract] instance with specified parameters.
  AccountUpdateContract({
    required this.ownerAddress,
    required List<int> accountName,
  }) : accountName = BytesUtils.toBytes(accountName, unmodifiable: true);

  factory AccountUpdateContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return AccountUpdateContract(
        ownerAddress: TronAddress.fromBytes(decode.getField(1)),
        accountName: decode.getField(2));
  }

  /// Owner_address is the account address to be modified
  final TronAddress ownerAddress;

  /// Account_name is the name of the account
  final List<int> accountName;

  @override
  List<int> get fieldIds => [1, 2];

  @override
  List get values => [accountName, ownerAddress];

  /// Convert the [AccountUpdateContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress.toString(),
      "account_name": StringUtils.tryDecode(accountName),
    }..removeWhere((key, value) => value == null);
  }

  /// Convert the [AccountUpdateContract] object to its string representation.
  @override
  String toString() {
    return "AccountUpdateContract{${toJson()}}";
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.accountUpdateContract;
}
