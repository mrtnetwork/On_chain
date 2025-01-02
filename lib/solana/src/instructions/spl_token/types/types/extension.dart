import 'package:on_chain/solana/src/exception/exception.dart';

/// Defines the ExtensionType class to represent different types of extensions.
class ExtensionType {
  /// The integer value representing the extension type.
  final int value;

  /// The name of the extension type.
  final String name;

  final int? layoutSize;

  /// Constructs an ExtensionType instance with the provided value and name.
  const ExtensionType._(this.value, this.name, this.layoutSize);

  /// Extension type for uninitialized.
  static const ExtensionType uninitialized =
      ExtensionType._(0, 'Uninitialized', 0);

  /// Extension type for transfer fee configuration.
  static const ExtensionType transferFeeConfig =
      ExtensionType._(1, 'TransferFeeConfig', 108);

  /// Extension type for transfer fee amount.
  static const ExtensionType transferFeeAmount =
      ExtensionType._(2, 'TransferFeeAmount', 8);

  /// Extension type for mint close authority.
  static const ExtensionType mintCloseAuthority =
      ExtensionType._(3, 'MintCloseAuthority', 32);

  /// Extension type for confidential transfer mint.
  static const ExtensionType confidentialTransferMint =
      ExtensionType._(4, 'ConfidentialTransferMint', 97);

  /// Extension type for confidential transfer account.
  static const ExtensionType confidentialTransferAccount =
      ExtensionType._(5, 'ConfidentialTransferAccount', 286);

  /// Extension type for default account state.
  static const ExtensionType defaultAccountState =
      ExtensionType._(6, 'DefaultAccountState', 1);

  /// Extension type for immutable owner.
  static const ExtensionType immutableOwner =
      ExtensionType._(7, 'ImmutableOwner', 0);

  /// Extension type for memo transfer.
  static const ExtensionType memoTransfer =
      ExtensionType._(8, 'MemoTransfer', 1);

  /// Extension type for non-transferable.
  static const ExtensionType nonTransferable =
      ExtensionType._(9, 'NonTransferable', 0);

  /// Extension type for interest-bearing configuration.
  static const ExtensionType interestBearingConfig =
      ExtensionType._(10, 'InterestBearingConfig', 52);

  /// Extension type for CPI guard.
  static const ExtensionType cpiGuard = ExtensionType._(11, 'CpiGuard', 1);

  /// Extension type for permanent delegate.
  static const ExtensionType permanentDelegate =
      ExtensionType._(12, 'PermanentDelegate', 32);

  /// Extension type for non-transferable account.
  static const ExtensionType nonTransferableAccount =
      ExtensionType._(13, 'NonTransferableAccount', 0);

  /// Extension type for transfer hook.
  static const ExtensionType transferHook =
      ExtensionType._(14, 'TransferHook', 64);

  /// Extension type for transfer hook account.
  static const ExtensionType transferHookAccount =
      ExtensionType._(15, 'TransferHookAccount', 1);

  /// Extension type for metadata pointer.
  static const ExtensionType metadataPointer =
      ExtensionType._(18, 'MetadataPointer', 64);

  /// Extension type for token metadata.
  static const ExtensionType tokenMetadata =
      ExtensionType._(19, 'TokenMetadata', null);

  static const ExtensionType groupPointer =
      ExtensionType._(20, 'GroupPointer', 64);

  /// Extension type for token metadata.
  static const ExtensionType groupMemberPointer =
      ExtensionType._(21, 'GroupMemberPointer', 64);

  /// List of all ExtensionType values.
  static const List<ExtensionType> values = [
    uninitialized,
    transferFeeConfig,
    transferFeeAmount,
    mintCloseAuthority,
    confidentialTransferMint,
    confidentialTransferAccount,
    defaultAccountState,
    immutableOwner,
    memoTransfer,
    nonTransferable,
    interestBearingConfig,
    cpiGuard,
    permanentDelegate,
    nonTransferableAccount,
    transferHook,
    transferHookAccount,
    metadataPointer,
    tokenMetadata
  ];

  /// Creates an ExtensionType instance from the provided value.
  ///
  /// Throws a [SolanaPluginException] if no ExtensionType is found for the given value.
  factory ExtensionType.fromValue(int v) {
    try {
      return values.firstWhere((element) => element.value == v);
    } on StateError {
      throw SolanaPluginException('No ExtensionType found for the given value.',
          details: {'value': v});
    }
  }

  bool get isMintExtension {
    switch (this) {
      case ExtensionType.transferFeeConfig:
      case ExtensionType.mintCloseAuthority:
      case ExtensionType.confidentialTransferMint:
      case ExtensionType.defaultAccountState:
      case ExtensionType.nonTransferable:
      case ExtensionType.interestBearingConfig:
      case ExtensionType.permanentDelegate:
      case ExtensionType.transferHook:
      case ExtensionType.metadataPointer:
      case ExtensionType.tokenMetadata:
        return true;
      default:
        return false;
    }
  }

  bool get isAccountExtension {
    switch (this) {
      case ExtensionType.transferFeeAmount:
      case ExtensionType.confidentialTransferAccount:
      case ExtensionType.immutableOwner:
      case ExtensionType.memoTransfer:
      case ExtensionType.cpiGuard:
      case ExtensionType.nonTransferableAccount:
      case ExtensionType.transferHookAccount:
        return true;
      default:
        return false;
    }
  }

  ExtensionType get accountTypeOfMintType {
    switch (this) {
      case ExtensionType.transferFeeConfig:
        return ExtensionType.transferFeeAmount;
      case ExtensionType.confidentialTransferMint:
        return ExtensionType.confidentialTransferAccount;
      case ExtensionType.nonTransferable:
        return ExtensionType.nonTransferableAccount;
      case ExtensionType.transferHook:
        return ExtensionType.transferHookAccount;
      case ExtensionType.transferFeeAmount:
      case ExtensionType.confidentialTransferAccount:
      case ExtensionType.cpiGuard:
      case ExtensionType.defaultAccountState:
      case ExtensionType.immutableOwner:
      case ExtensionType.memoTransfer:
      case ExtensionType.mintCloseAuthority:
      case ExtensionType.metadataPointer:
      case ExtensionType.tokenMetadata:
      case ExtensionType.uninitialized:
      case ExtensionType.interestBearingConfig:
      case ExtensionType.permanentDelegate:
      case ExtensionType.nonTransferableAccount:
      case ExtensionType.transferHookAccount:
        return ExtensionType.uninitialized;
      default:
        throw SolanaPluginException('unsuported type',
            details: {'ExtensionType': name});
    }
  }

  @override
  String toString() {
    return 'ExtensionType.$name';
  }
}
