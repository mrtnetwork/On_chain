import 'package:blockchain_utils/exception/exception.dart';

/// Defines the AuthorityType class to represent different types of authorities.
class AuthorityType {
  /// The integer value representing the authority type.
  final int value;

  /// The name of the authority type.
  final String name;

  /// Constructs an AuthorityType instance with the provided value and name.
  const AuthorityType._(this.value, this.name);

  /// Authority type for minting tokens.
  static const AuthorityType mintTokens = AuthorityType._(0, 'MintTokens');

  /// Authority type for freezing an account.
  static const AuthorityType freezeAccount =
      AuthorityType._(1, 'FreezeAccount');

  /// Authority type for account owner.
  static const AuthorityType accountOwner = AuthorityType._(2, 'AccountOwner');

  /// Authority type for closing an account.
  static const AuthorityType closeAccount = AuthorityType._(3, 'CloseAccount');

  /// Authority type for transfer fee configuration.
  static const AuthorityType transferFeeConfig =
      AuthorityType._(4, 'TransferFeeConfig');

  /// Authority type for withheld withdrawal.
  static const AuthorityType withheldWithdraw =
      AuthorityType._(5, 'WithheldWithdraw');

  /// Authority type for closing a mint.
  static const AuthorityType closeMint = AuthorityType._(6, 'CloseMint');

  /// Authority type for interest rate.
  static const AuthorityType interestRate = AuthorityType._(7, 'InterestRate');

  /// Authority type for permanent delegate.
  static const AuthorityType permanentDelegate =
      AuthorityType._(8, 'PermanentDelegate');

  /// Authority type for confidential transfer mint.
  static const AuthorityType confidentialTransferMint =
      AuthorityType._(9, 'ConfidentialTransferMint');

  /// Authority type for transfer hook program ID.
  static const AuthorityType transferHookProgramId =
      AuthorityType._(10, 'TransferHookProgramId');

  /// Authority type for confidential transfer fee configuration.
  static const AuthorityType confidentialTransferFeeConfig =
      AuthorityType._(11, 'ConfidentialTransferFeeConfig');

  /// Authority type for metadata pointer.
  static const AuthorityType metadataPointer =
      AuthorityType._(12, 'MetadataPointer');

  /// List of all AuthorityType values.
  static const List<AuthorityType> values = [
    mintTokens,
    freezeAccount,
    accountOwner,
    closeAccount,
    transferFeeConfig,
    withheldWithdraw,
    closeMint,
    interestRate,
    permanentDelegate,
    confidentialTransferMint,
    transferHookProgramId,
    confidentialTransferFeeConfig,
    metadataPointer,
  ];

  /// Creates an AuthorityType instance from the provided value.
  ///
  /// Throws a [MessageException] if no AuthorityType is found for the given value.
  static AuthorityType fromValue(int? value) {
    try {
      return values.firstWhere((element) => element.value == value);
    } on StateError {
      throw MessageException("No AuthorityType found for the given value.",
          details: {"value": value});
    }
  }
}
