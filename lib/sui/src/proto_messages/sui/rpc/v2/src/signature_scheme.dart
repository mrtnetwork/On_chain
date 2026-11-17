import 'package:blockchain_utils/blockchain_utils.dart';

/// Copyright (c) Mysten Labs, Inc.
/// SPDX-License-Identifier: Apache-2.0
/// Flag use to disambiguate the signature schemes supported by Sui.
///
/// Note: the enum values defined by this proto message exactly match their
/// expected BCS serialized values when serialized as a u8. See
/// [enum.SignatureScheme](https://mystenlabs.github.io/sui-rust-sdk/sui_sdk_types/enum.SignatureScheme.html)
/// for more information about signature schemes.
enum SuiSignatureScheme implements ProtoEnumVariant {
  ed25519(0, 'ED25519'),
  secp256k1(1, 'SECP256K1'),
  secp256r1(2, 'SECP256R1'),
  multisig(3, 'MULTISIG'),
  bls12381(4, 'BLS12381'),
  zklogin(5, 'ZKLOGIN'),
  passkey(6, 'PASSKEY');

  const SuiSignatureScheme(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static SuiSignatureScheme fromValue(int? value) {
    value ??= 0;
    return SuiSignatureScheme.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiSignatureScheme found for the given value. $value",
                details: {
                  "name": "SuiSignatureScheme",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static SuiSignatureScheme from(Object? value) {
    value ??= 0;
    return SuiSignatureScheme.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SuiSignatureScheme found for the given value. $value",
                details: {
                  "name": "SuiSignatureScheme",
                  "value": value?.toString(),
                },
              ),
    );
  }
}
