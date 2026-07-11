import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';

/// Modify account name
class AccountUpdateContract extends TronBaseContract {
  /// Create a new [AccountUpdateContract] instance by parsing a JSON map.
  factory AccountUpdateContract.fromJson(Map<String, dynamic> json) {
    return AccountUpdateContract(
      ownerAddress: TronAddress(json.valueAs("owner_address")),
      accountName: json.valueAsBytes(
        "account_name",
        encoding: StringEncoding.utf8,
      ),
    );
  }

  /// Factory method to create a new [AccountUpdateContract] instance with specified parameters.
  AccountUpdateContract({
    required this.ownerAddress,
    required List<int> accountName,
  }) : accountName = accountName.asImmutableBytes;

  factory AccountUpdateContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return AccountUpdateContract(
      ownerAddress: TronAddress.fromBytes(decode.getField(1)),
      accountName: decode.getField(2),
    );
  }

  /// Owner_address is the account address to be modified
  @override
  final TronAddress ownerAddress;

  /// Account_name is the name of the account
  final List<int> accountName;

  @override
  List<int> get fieldIds => [1, 2];

  @override
  List get values => [accountName, ownerAddress];

  /// Convert the [AccountUpdateContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson({bool visible = true}) {
    return {
      'owner_address': ownerAddress.toAddress(visible),
      'account_name': StringUtils.tryDecode(accountName),
    };
  }

  /// Convert the [AccountUpdateContract] object to its string representation.
  @override
  String toString() {
    return 'AccountUpdateContract{${toJson()}}';
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.accountUpdateContract;
}
