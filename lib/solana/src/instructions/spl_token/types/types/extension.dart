import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/exception/onchain_error.dart';

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
  static const ExtensionType uninitialized = ExtensionType._(
    0,
    'Uninitialized',
    0,
  );

  /// Extension type for transfer fee configuration.
  static const ExtensionType transferFeeConfig = ExtensionType._(
    1,
    'TransferFeeConfig',
    108,
  );

  /// Extension type for transfer fee amount.
  static const ExtensionType transferFeeAmount = ExtensionType._(
    2,
    'TransferFeeAmount',
    8,
  );

  /// Extension type for mint close authority.
  static const ExtensionType mintCloseAuthority = ExtensionType._(
    3,
    'MintCloseAuthority',
    32,
  );

  /// Extension type for confidential transfer mint.
  static const ExtensionType confidentialTransferMint = ExtensionType._(
    4,
    'ConfidentialTransferMint',
    97,
  );

  /// Extension type for confidential transfer account.
  static const ExtensionType confidentialTransferAccount = ExtensionType._(
    5,
    'ConfidentialTransferAccount',
    286,
  );

  /// Extension type for default account state.
  static const ExtensionType defaultAccountState = ExtensionType._(
    6,
    'DefaultAccountState',
    1,
  );

  /// Extension type for immutable owner.
  static const ExtensionType immutableOwner = ExtensionType._(
    7,
    'ImmutableOwner',
    0,
  );

  /// Extension type for memo transfer.
  static const ExtensionType memoTransfer = ExtensionType._(
    8,
    'MemoTransfer',
    1,
  );

  /// Extension type for non-transferable.
  static const ExtensionType nonTransferable = ExtensionType._(
    9,
    'NonTransferable',
    0,
  );

  /// Extension type for interest-bearing configuration.
  static const ExtensionType interestBearingConfig = ExtensionType._(
    10,
    'InterestBearingConfig',
    52,
  );

  /// Extension type for CPI guard.
  static const ExtensionType cpiGuard = ExtensionType._(11, 'CpiGuard', 1);

  /// Extension type for permanent delegate.
  static const ExtensionType permanentDelegate = ExtensionType._(
    12,
    'PermanentDelegate',
    32,
  );

  /// Extension type for non-transferable account.
  static const ExtensionType nonTransferableAccount = ExtensionType._(
    13,
    'NonTransferableAccount',
    0,
  );

  /// Extension type for transfer hook.
  static const ExtensionType transferHook = ExtensionType._(
    14,
    'TransferHook',
    64,
  );

  /// Extension type for transfer hook account.
  static const ExtensionType transferHookAccount = ExtensionType._(
    15,
    'TransferHookAccount',
    1,
  );

  /// Extension type for metadata pointer.
  static const ExtensionType metadataPointer = ExtensionType._(
    18,
    'MetadataPointer',
    64,
  );

  /// Extension type for token metadata.
  static const ExtensionType tokenMetadata = ExtensionType._(
    19,
    'TokenMetadata',
    null,
  );

  static const ExtensionType groupPointer = ExtensionType._(
    20,
    'GroupPointer',
    64,
  );

  static const ExtensionType tokenGroup = ExtensionType._(
    21,
    'TokenGroup',
    null,
  );

  static const ExtensionType groupMemberPointer = ExtensionType._(
    22,
    'GroupMemberPointer',
    64,
  );

  static const ExtensionType tokenGroupMember = ExtensionType._(
    23,
    'TokenGroupMember',
    null,
  );

  static const ExtensionType confidentialTransferFeeConfig = ExtensionType._(
    16,
    'ConfidentialTransferFeeConfig',
    null,
  );

  static const ExtensionType confidentialTransferFeeAmount = ExtensionType._(
    17,
    'ConfidentialTransferFeeAmount',
    null,
  );

  static const ExtensionType confidentialMintBurn = ExtensionType._(
    24,
    'ConfidentialMintBurn',
    null,
  );

  static const ExtensionType scaledUiAmount = ExtensionType._(
    25,
    'ScaledUiAmount',
    null,
  );

  static const ExtensionType pausable = ExtensionType._(26, 'Pausable', null);

  static const ExtensionType pausableAccount = ExtensionType._(
    27,
    'PausableAccount',
    0,
  );

  static const ExtensionType permissionedBurn = ExtensionType._(
    28,
    'PermissionedBurn',
    null,
  );

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
    confidentialTransferFeeConfig,
    confidentialTransferFeeAmount,
    metadataPointer,
    tokenMetadata,
    groupPointer,
    tokenGroup,
    groupMemberPointer,
    tokenGroupMember,
    confidentialMintBurn,
    scaledUiAmount,
    pausable,
    pausableAccount,
    permissionedBurn,
  ];

  /// Creates an ExtensionType instance from the provided value.
  ///
  /// Throws a [BuError] if no ExtensionType is found for the given value.
  factory ExtensionType.fromValue(int v) {
    return values.firstWhere(
      (element) => element.value == v,
      orElse: () {
        throw BuError(
          OnChainErrorType.solanaPlugin,
          'No ExtensionType found for the given value.',
          details: {'value': v.toString()},
        );
      },
    );
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
      case ExtensionType.groupPointer:
      case ExtensionType.tokenGroup:
      case ExtensionType.groupMemberPointer:
      case ExtensionType.tokenGroupMember:
      case ExtensionType.confidentialTransferFeeConfig:
      case ExtensionType.confidentialMintBurn:
      case ExtensionType.scaledUiAmount:
      case ExtensionType.pausable:
      case ExtensionType.permissionedBurn:
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
      case ExtensionType.confidentialTransferFeeAmount:
      case ExtensionType.pausableAccount:
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
      case ExtensionType.confidentialTransferFeeConfig:
        return ExtensionType.confidentialTransferFeeAmount;
      case ExtensionType.pausable:
        return ExtensionType.pausableAccount;
      case ExtensionType.tokenGroup:
        return ExtensionType.tokenGroupMember;
      case ExtensionType.groupPointer:
        return ExtensionType.groupMemberPointer;
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
      case ExtensionType.confidentialTransferFeeAmount:
      case ExtensionType.tokenGroupMember:
      case ExtensionType.groupMemberPointer:
      case ExtensionType.confidentialMintBurn:
      case ExtensionType.scaledUiAmount:
      case ExtensionType.pausableAccount:
      case ExtensionType.permissionedBurn:
        return ExtensionType.uninitialized;
      default:
        throw BuError(
          OnChainErrorType.solanaPlugin,
          'unsuported type',
          details: {'ExtensionType': name},
        );
    }
  }

  @override
  String toString() {
    return 'ExtensionType.$name';
  }
}
