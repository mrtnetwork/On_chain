import 'package:blockchain_utils/blockchain_utils.dart';

/// Copyright (c) Mysten Labs, Inc.
/// SPDX-License-Identifier: Apache-2.0
enum SuiErrorReason implements ProtoEnumVariant {
  errorReasonUnknown(0, 'ERROR_REASON_UNKNOWN'),
  fieldInvalid(1, 'FIELD_INVALID'),
  fieldMissing(2, 'FIELD_MISSING');

  const SuiErrorReason(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static SuiErrorReason fromValue(int? value) {
    value ??= 0;
    return SuiErrorReason.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiErrorReason found for the given value. $value",
                details: {"name": "SuiErrorReason", "value": value?.toString()},
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiErrorReason from(Object? value) {
    value ??= 0;
    return SuiErrorReason.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiErrorReason found for the given value. $value",
                details: {"name": "SuiErrorReason", "value": value?.toString()},
              ),
    );
  }
}
