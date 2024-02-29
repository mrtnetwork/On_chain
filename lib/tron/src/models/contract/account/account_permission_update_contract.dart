import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/models/contract/account/permission.dart';

/// Update the account's permission.
class AccountPermissionUpdateContract extends TronBaseContract {
  /// Create a new [AccountPermissionUpdateContract] instance by parsing a JSON map.
  factory AccountPermissionUpdateContract.fromJson(Map<String, dynamic> json) {
    return AccountPermissionUpdateContract(
        ownerAddress: TronAddress(json["owner_address"]),
        owner: Permission.fromJson(json["owner"]),
        witness: json["witness"] == null
            ? null
            : Permission.fromJson(json["witness"]),
        actives: (json["actives"] as List?)
                ?.map((e) => Permission.fromJson(e))
                .toList() ??
            <Permission>[]);
  }

  /// Create a new [AccountPermissionUpdateContract] instance with specified parameters.
  AccountPermissionUpdateContract(
      {required this.ownerAddress,
      required this.owner,
      this.witness,
      required List<Permission> actives})
      : actives = List<Permission>.unmodifiable(actives);

  /// account address
  final TronAddress ownerAddress;

  /// The owner permission of the account.
  final Permission owner;

  /// Account witness permissions
  final Permission? witness;

  /// List of active permissions for the account
  final List<Permission> actives;

  /// Create a new [AccountPermissionUpdateContract] instance by copying the existing one
  /// and replacing specified fields with new values.
  AccountPermissionUpdateContract copyWith({
    TronAddress? ownerAddress,
    Permission? owner,
    Permission? witness,
    List<Permission>? actives,
  }) {
    return AccountPermissionUpdateContract(
      ownerAddress: ownerAddress ?? this.ownerAddress,
      owner: owner ?? this.owner,
      witness: witness ?? this.witness,
      actives: actives ?? this.actives,
    );
  }

  @override

  /// Convert the [AccountPermissionUpdateContract] object to a JSON representation.
  Map<String, dynamic> toJson() {
    return {
      "owner_address": ownerAddress.toString(),
      "actives": actives.map((e) => e.toJson()).toList(),
      "owner": owner.toJson(),
      "witness": witness?.toJson(),
    }..removeWhere((key, value) => value == null);
  }

  @override
  List<int> get fieldIds => [1, 2, 3, 4];

  @override
  List get values => [ownerAddress, owner, witness, actives];

  /// Convert the [AccountPermissionUpdateContract] object to its string representation.
  @override
  String toString() {
    return "AccountPermissionUpdateContract{${toJson()}}";
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.accountPermissionUpdateContract;
}
