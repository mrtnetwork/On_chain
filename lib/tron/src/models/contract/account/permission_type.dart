import 'package:on_chain/tron/src/exception/exception.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/common.dart';

/// Enum representing different types of permissions within a Tron account.
///
/// The available permission types are:
/// - [owner]: Represents the owner permission of a Tron account.
/// - [witness]: Represents the witness permission of a Tron account.
/// - [active]: Represents the active permission of a Tron account
class PermissionType implements TronEnumerate {
  /// Internal constructor to create a [PermissionType] instance.
  const PermissionType._(this.name, this.value);

  /// The name associated with the permission type.
  final String name;
  @override
  final int value;

  /// Represents the owner permission of a Tron account.
  static const PermissionType owner = PermissionType._('Owner', 0);

  /// Represents the witness permission of a Tron account.
  static const PermissionType witness = PermissionType._('Witness', 1);

  /// Represents the active permission of a Tron account.
  static const PermissionType active = PermissionType._('Active', 2);

  /// List of all available permission types.
  static const List<PermissionType> values = [owner, witness, active];

  @override
  String toString() {
    return name;
  }

  /// Returns the [PermissionType] associated with the given [name].
  ///
  /// Returns `null` if no match is found.
  static PermissionType fromName(String? name,
      {PermissionType? defaultPermission}) {
    return values.firstWhere((element) => element.name == name, orElse: () {
      if (defaultPermission != null) return defaultPermission;
      throw const TronPluginException('No permission Type is found.');
    });
  }

  /// Returns the [PermissionType] associated with the given [value].
  ///
  /// Throws an error if no match is found.
  static PermissionType fromValue(int? value,
      {PermissionType? defaultPermission}) {
    return values.firstWhere((element) => element.value == value, orElse: () {
      if (defaultPermission != null) return defaultPermission;
      throw const TronPluginException('No permission Type is found.');
    });
  }
}
