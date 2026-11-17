// Typed scalar enums for MPL Core (orders match the official mpl_core IDL).
import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Plugin type discriminant (Borsh u8, IDL order).
class MplCorePluginType {
  final String name;
  final int value;
  const MplCorePluginType._(this.name, this.value);
  static const MplCorePluginType royalties = MplCorePluginType._(
    'Royalties',
    0,
  );
  static const MplCorePluginType freezeDelegate = MplCorePluginType._(
    'FreezeDelegate',
    1,
  );
  static const MplCorePluginType burnDelegate = MplCorePluginType._(
    'BurnDelegate',
    2,
  );
  static const MplCorePluginType transferDelegate = MplCorePluginType._(
    'TransferDelegate',
    3,
  );
  static const MplCorePluginType updateDelegate = MplCorePluginType._(
    'UpdateDelegate',
    4,
  );
  static const MplCorePluginType permanentFreezeDelegate = MplCorePluginType._(
    'PermanentFreezeDelegate',
    5,
  );
  static const MplCorePluginType attributes = MplCorePluginType._(
    'Attributes',
    6,
  );
  static const MplCorePluginType permanentTransferDelegate =
      MplCorePluginType._('PermanentTransferDelegate', 7);
  static const MplCorePluginType permanentBurnDelegate = MplCorePluginType._(
    'PermanentBurnDelegate',
    8,
  );
  static const MplCorePluginType edition = MplCorePluginType._('Edition', 9);
  static const MplCorePluginType masterEdition = MplCorePluginType._(
    'MasterEdition',
    10,
  );
  static const MplCorePluginType addBlocker = MplCorePluginType._(
    'AddBlocker',
    11,
  );
  static const MplCorePluginType immutableMetadata = MplCorePluginType._(
    'ImmutableMetadata',
    12,
  );
  static const MplCorePluginType verifiedCreators = MplCorePluginType._(
    'VerifiedCreators',
    13,
  );
  static const MplCorePluginType autograph = MplCorePluginType._(
    'Autograph',
    14,
  );
  static const MplCorePluginType bubblegumV2 = MplCorePluginType._(
    'BubblegumV2',
    15,
  );
  static const MplCorePluginType freezeExecute = MplCorePluginType._(
    'FreezeExecute',
    16,
  );
  static const MplCorePluginType permanentFreezeExecute = MplCorePluginType._(
    'PermanentFreezeExecute',
    17,
  );
  static const MplCorePluginType groups = MplCorePluginType._('Groups', 18);

  static const List<MplCorePluginType> values = [
    royalties,
    freezeDelegate,
    burnDelegate,
    transferDelegate,
    updateDelegate,
    permanentFreezeDelegate,
    attributes,
    permanentTransferDelegate,
    permanentBurnDelegate,
    edition,
    masterEdition,
    addBlocker,
    immutableMetadata,
    verifiedCreators,
    autograph,
    bubblegumV2,
    freezeExecute,
    permanentFreezeExecute,
    groups,
  ];

  static MplCorePluginType fromValue(int? value) {
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                OnChainErrorType.solanaPlugin,
                'No MplCorePluginType found for value',
                details: {'value': value?.toString()},
              ),
    );
  }
}

/// Data state discriminant (Borsh u8, IDL order).
class MplCoreDataState {
  final String name;
  final int value;
  const MplCoreDataState._(this.name, this.value);
  static const MplCoreDataState accountState = MplCoreDataState._(
    'AccountState',
    0,
  );
  static const MplCoreDataState ledgerState = MplCoreDataState._(
    'LedgerState',
    1,
  );
  static const List<MplCoreDataState> values = [accountState, ledgerState];

  static MplCoreDataState fromValue(int? value) {
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                OnChainErrorType.solanaPlugin,
                'No MplCoreDataState found for value',
                details: {'value': value?.toString()},
              ),
    );
  }
}

/// Collection-info update discriminant (Borsh u8, IDL order).
class MplCoreUpdateType {
  final String name;
  final int value;
  const MplCoreUpdateType._(this.name, this.value);
  static const MplCoreUpdateType mint = MplCoreUpdateType._('Mint', 0);
  static const MplCoreUpdateType add = MplCoreUpdateType._('Add', 1);
  static const MplCoreUpdateType remove = MplCoreUpdateType._('Remove', 2);
  static const List<MplCoreUpdateType> values = [mint, add, remove];

  static MplCoreUpdateType fromValue(int? value) {
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                OnChainErrorType.solanaPlugin,
                'No MplCoreUpdateType found for value',
                details: {'value': value?.toString()},
              ),
    );
  }
}

/// Plugin authority (Borsh rust enum, IDL order).
class MplCoreAuthority extends BorshLayoutSerializable {
  final String name;
  final SolAddress? address;
  const MplCoreAuthority._(this.name, this.address);

  static const MplCoreAuthority none = MplCoreAuthority._('None', null);
  static const MplCoreAuthority owner = MplCoreAuthority._('Owner', null);
  static const MplCoreAuthority updateAuthority = MplCoreAuthority._(
    'UpdateAuthority',
    null,
  );
  factory MplCoreAuthority.address(SolAddress address) =>
      MplCoreAuthority._('Address', address);

  static StructLayout get staticLayout => LayoutConst.struct([
    LayoutConst.rustEnum([
      LayoutConst.none(property: 'None'),
      LayoutConst.none(property: 'Owner'),
      LayoutConst.none(property: 'UpdateAuthority'),
      LayoutConst.tuple([
        LayoutConst.blob(32, property: 'address'),
      ], property: 'Address'),
    ], property: 'authority'),
  ]);

  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() => {
    'authority': {
      name: address == null ? null : [address!.toBytes()],
    },
  };

  factory MplCoreAuthority.fromJson(Map<String, dynamic> json) {
    final key = json['authority']['key'] as String;
    switch (key) {
      case 'None':
        return none;
      case 'Owner':
        return owner;
      case 'UpdateAuthority':
        return updateAuthority;
      case 'Address':
        final List<dynamic> value = json['authority']['value'];
        final List<int> bytes = (value[0] as List).cast<int>();
        return MplCoreAuthority.address(SolAddress.uncheckBytes(bytes));
      default:
        throw BuError(
          OnChainErrorType.solanaPlugin,
          'No MplCoreAuthority found for key',
          details: {'value': key},
        );
    }
  }
}

/// Update authority (Borsh rust enum, IDL order).
class MplCoreUpdateAuthority extends BorshLayoutSerializable {
  final String name;
  final SolAddress? address;
  const MplCoreUpdateAuthority._(this.name, this.address);

  static const MplCoreUpdateAuthority none = MplCoreUpdateAuthority._(
    'None',
    null,
  );
  factory MplCoreUpdateAuthority.address(SolAddress address) =>
      MplCoreUpdateAuthority._('Address', address);
  factory MplCoreUpdateAuthority.collection(SolAddress collection) =>
      MplCoreUpdateAuthority._('Collection', collection);

  static StructLayout get staticLayout => LayoutConst.struct([
    LayoutConst.rustEnum([
      LayoutConst.none(property: 'None'),
      LayoutConst.tuple([
        LayoutConst.blob(32, property: 'address'),
      ], property: 'Address'),
      LayoutConst.tuple([
        LayoutConst.blob(32, property: 'address'),
      ], property: 'Collection'),
    ], property: 'updateAuthority'),
  ]);

  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() => {
    'updateAuthority': {
      name: address == null ? null : [address!.toBytes()],
    },
  };

  factory MplCoreUpdateAuthority.fromJson(Map<String, dynamic> json) {
    final key = json['updateAuthority']['key'] as String;
    switch (key) {
      case 'None':
        return none;
      case 'Address':
      case 'Collection':
        final List<dynamic> value = json['updateAuthority']['value'];
        final List<int> bytes = (value[0] as List).cast<int>();
        final addr = SolAddress.uncheckBytes(bytes);
        return key == 'Address'
            ? MplCoreUpdateAuthority.address(addr)
            : MplCoreUpdateAuthority.collection(addr);
      default:
        throw BuError(
          OnChainErrorType.solanaPlugin,
          'No MplCoreUpdateAuthority found for key',
          details: {'value': key},
        );
    }
  }
}
