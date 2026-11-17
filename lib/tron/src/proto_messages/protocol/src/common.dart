import 'package:blockchain_utils/blockchain_utils.dart';

/// Specify the name of the package that generated the Java file
/// option java_outer_classname = "common"; //Specify the class name of the generated Java file
enum TronResourceCode implements ProtoEnumVariant {
  bandwidth(0, 'BANDWIDTH'),
  energy(1, 'ENERGY'),
  tronPower(2, 'TRON_POWER');

  const TronResourceCode(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static TronResourceCode fromValue(int? value) {
    value ??= 0;
    return TronResourceCode.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(DefaultErrorType.notFound, "No matching TronResourceCode found for the given value. $value", details: {"name": "TronResourceCode", "value": value?.toString()}),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static TronResourceCode from(Object? value) {
    value ??= 0;
    return TronResourceCode.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(DefaultErrorType.notFound, "No matching TronResourceCode found for the given value. $value", details: {"name": "TronResourceCode", "value": value?.toString()}),
    );
  }
}
