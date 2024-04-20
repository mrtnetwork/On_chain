import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/models/contract/account/account_type.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';

/// Activate an account. Uses an already activated account to activate a new account.
/// or just simply transfer TRX to it.
class AccountCreateContract extends TronBaseContract {
  factory AccountCreateContract.fromJson(Map<String, dynamic> json) {
    return AccountCreateContract(
      /// Transaction initiator address
      ownerAddress: TronAddress(json["owner_address"]),

      /// Account address to be activated
      accountAddress: TronAddress(json["account_address"]),

      /// Account type. The external account type is Normal, and this field will not be displayed in the return value
      type: AccountType.fromName(json["type"]) ?? AccountType.normal,
    );
  }
  factory AccountCreateContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return AccountCreateContract(
      /// Transaction initiator address
      ownerAddress: TronAddress.fromBytes(decode.getField(1)),

      /// Account address to be activated
      accountAddress: TronAddress.fromBytes(decode.getField(2)),

      /// Account type. The external account type is Normal, and this field will not be displayed in the return value
      type: decode
              .getResult(3)
              ?.to<AccountType, int>((e) => AccountType.fromValue(e)) ??
          AccountType.normal,
    );
  }
  AccountCreateContract(
      {required this.ownerAddress, required this.accountAddress, this.type});

  /// Transaction initiator address
  final TronAddress ownerAddress;

  /// Account address to be activated
  final TronAddress accountAddress;

  /// Account type.
  final AccountType? type;
  @override
  List<int> get fieldIds => [1, 2, 3];

  @override
  List get values => [ownerAddress, accountAddress, type];

  /// Convert the [AccountCreateContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress,
      "account_address": accountAddress,
      "type": type?.name,
    }..removeWhere((key, value) => value == null);
  }

  /// Convert the [AccountCreateContract] object to its string representation.
  @override
  String toString() {
    return "AccountCreateContract{${toJson()}}";
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.accountCreateContract;
}
