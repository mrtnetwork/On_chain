import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/mpl_core/layouts/instruction/instructions.dart';
import 'package:on_chain/solana/src/instructions/mpl_core/layouts/layouts/mpl_core_types.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

/// Shared base + raw-tail helpers for MPL Core layouts.
abstract class MplCoreProgramLayoutBase extends ProgramLayout {
  const MplCoreProgramLayoutBase();

  /// Slice trailing raw Borsh after a typed prefix struct.
  static List<int> tailOf({
    required StructLayout layout,
    required List<int> bytes,
    required Map<String, dynamic> decode,
  }) {
    final headLength = layout.serialize(decode).length;
    return bytes.sublist(headLength);
  }

  /// Encode a typed prefix struct plus trailing raw Borsh.
  static BuBytes concatHeadTail({
    required StructLayout layout,
    required Map<String, dynamic> fields,
    required List<int> tail,
  }) {
    final head = layout.serialize(fields);
    final data = BuBytes.fill(head.length + tail.length, 0);
    data.setAll(0, head);
    data.setAll(head.length, tail);
    return data;
  }
}

/// CreateV1 (0). Typed prefix: dataState, name, uri.
/// `pluginArgs` is the raw Borsh of `Option<Vec<PluginAuthorityPair>>`.
class MplCoreCreateV1Layout extends MplCoreProgramLayoutBase {
  final MplCoreDataState dataState;
  final String name;
  final String uri;
  final List<int> pluginArgs;
  MplCoreCreateV1Layout({
    required this.dataState,
    required this.name,
    required this.uri,
    List<int> pluginArgs = const [0],
  }) : pluginArgs = pluginArgs.asImmutableBytes;

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u8(property: 'dataState'),
    LayoutConst.string(property: 'name'),
    LayoutConst.string(property: 'uri'),
  ]);

  factory MplCoreCreateV1Layout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: MplCoreProgramInstruction.createV1.instruction,
    );
    return MplCoreCreateV1Layout(
      dataState: MplCoreDataState.fromValue(decode['dataState']),
      name: decode['name'],
      uri: decode['uri'],
      pluginArgs: MplCoreProgramLayoutBase.tailOf(
        layout: _layout,
        bytes: bytes,
        decode: decode,
      ),
    );
  }

  @override
  StructLayout get layout => _layout;

  @override
  final MplCoreProgramInstruction instruction =
      MplCoreProgramInstruction.createV1;

  @override
  Map<String, dynamic> serialize() {
    return {'dataState': dataState.value, 'name': name, 'uri': uri};
  }

  @override
  BuBytes toBytes() {
    return MplCoreProgramLayoutBase.concatHeadTail(
      layout: _layout,
      fields: {'instruction': instruction.instruction, ...serialize()},
      tail: pluginArgs,
    );
  }
}

/// CreateCollectionV1 (1).
class MplCoreCreateCollectionV1Layout extends MplCoreProgramLayoutBase {
  final String name;
  final String uri;
  final List<int> pluginArgs;
  MplCoreCreateCollectionV1Layout({
    required this.name,
    required this.uri,
    List<int> pluginArgs = const [0],
  }) : pluginArgs = pluginArgs.asImmutableBytes;

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.string(property: 'name'),
    LayoutConst.string(property: 'uri'),
  ]);

  factory MplCoreCreateCollectionV1Layout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: MplCoreProgramInstruction.createCollectionV1.instruction,
    );
    return MplCoreCreateCollectionV1Layout(
      name: decode['name'],
      uri: decode['uri'],
      pluginArgs: MplCoreProgramLayoutBase.tailOf(
        layout: _layout,
        bytes: bytes,
        decode: decode,
      ),
    );
  }

  @override
  StructLayout get layout => _layout;

  @override
  final MplCoreProgramInstruction instruction =
      MplCoreProgramInstruction.createCollectionV1;

  @override
  Map<String, dynamic> serialize() {
    return {'name': name, 'uri': uri};
  }

  @override
  BuBytes toBytes() {
    return MplCoreProgramLayoutBase.concatHeadTail(
      layout: _layout,
      fields: {'instruction': instruction.instruction, ...serialize()},
      tail: pluginArgs,
    );
  }
}

/// Whole-args raw layouts (Add/Update plugin + external
/// adapters, DecompressV1, Write*Data). `argsBytes` is the exact Borsh of
/// the IDL args struct (e.g. `AddPluginV1Args{plugin, initAuthority}`).
class MplCoreRawArgsLayout extends MplCoreProgramLayoutBase {
  @override
  final MplCoreProgramInstruction instruction;
  final List<int> argsBytes;
  MplCoreRawArgsLayout({
    required this.instruction,
    List<int> argsBytes = const [],
  }) : argsBytes = argsBytes.asImmutableBytes;

  static StructLayout get _layout =>
      LayoutConst.struct([LayoutConst.u8(property: 'instruction')]);

  factory MplCoreRawArgsLayout.fromBuffer(
    List<int> bytes,
    MplCoreProgramInstruction instruction,
  ) {
    ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: instruction.instruction,
    );
    return MplCoreRawArgsLayout(
      instruction: instruction,
      argsBytes: bytes.sublist(1),
    );
  }

  @override
  StructLayout get layout => _layout;

  @override
  Map<String, dynamic> serialize() => {};

  @override
  BuBytes toBytes() {
    return MplCoreProgramLayoutBase.concatHeadTail(
      layout: _layout,
      fields: {'instruction': instruction.instruction},
      tail: argsBytes,
    );
  }
}

/// RemovePluginV1 (4) / RemoveCollectionPluginV1 (5).
class MplCoreRemovePluginLayout extends MplCoreProgramLayoutBase {
  @override
  final MplCoreProgramInstruction instruction;
  final MplCorePluginType pluginType;
  const MplCoreRemovePluginLayout({
    required this.instruction,
    required this.pluginType,
  });

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u8(property: 'pluginType'),
  ]);

  factory MplCoreRemovePluginLayout.fromBuffer(
    List<int> bytes,
    MplCoreProgramInstruction instruction,
  ) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: instruction.instruction,
    );
    return MplCoreRemovePluginLayout(
      instruction: instruction,
      pluginType: MplCorePluginType.fromValue(decode['pluginType']),
    );
  }

  @override
  StructLayout get layout => _layout;

  @override
  Map<String, dynamic> serialize() => {'pluginType': pluginType.value};
}

/// ApprovePluginAuthorityV1 (8) / ApproveCollection (9).
class MplCoreApprovePluginAuthorityLayout extends MplCoreProgramLayoutBase {
  @override
  final MplCoreProgramInstruction instruction;
  final MplCorePluginType pluginType;
  final MplCoreAuthority newAuthority;
  const MplCoreApprovePluginAuthorityLayout({
    required this.instruction,
    required this.pluginType,
    required this.newAuthority,
  });

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u8(property: 'pluginType'),
    LayoutConst.wrap(MplCoreAuthority.staticLayout, property: 'newAuthority'),
  ]);

  factory MplCoreApprovePluginAuthorityLayout.fromBuffer(
    List<int> bytes,
    MplCoreProgramInstruction instruction,
  ) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: instruction.instruction,
    );
    return MplCoreApprovePluginAuthorityLayout(
      instruction: instruction,
      pluginType: MplCorePluginType.fromValue(decode['pluginType']),
      newAuthority: MplCoreAuthority.fromJson(decode['newAuthority']),
    );
  }

  @override
  StructLayout get layout => _layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'pluginType': pluginType.value,
      'newAuthority': newAuthority.serialize(),
    };
  }
}

/// RevokePluginAuthorityV1 (10) / RevokeCollection (11).
class MplCoreRevokePluginAuthorityLayout extends MplCoreProgramLayoutBase {
  @override
  final MplCoreProgramInstruction instruction;
  final MplCorePluginType pluginType;
  const MplCoreRevokePluginAuthorityLayout({
    required this.instruction,
    required this.pluginType,
  });

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u8(property: 'pluginType'),
  ]);

  factory MplCoreRevokePluginAuthorityLayout.fromBuffer(
    List<int> bytes,
    MplCoreProgramInstruction instruction,
  ) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: instruction.instruction,
    );
    return MplCoreRevokePluginAuthorityLayout(
      instruction: instruction,
      pluginType: MplCorePluginType.fromValue(decode['pluginType']),
    );
  }

  @override
  StructLayout get layout => _layout;

  @override
  Map<String, dynamic> serialize() => {'pluginType': pluginType.value};
}

/// Optional-compression-proof layouts: BurnV1 (12),
/// BurnCollectionV1 (13), TransferV1 (14). `compressionProof` is the raw
/// Borsh of `Option<CompressionProof>` (null encodes None = 0x00).
class MplCoreCompressionProofLayout extends MplCoreProgramLayoutBase {
  @override
  final MplCoreProgramInstruction instruction;
  final List<int>? compressionProof;
  MplCoreCompressionProofLayout({
    required this.instruction,
    List<int>? compressionProof,
  }) : compressionProof = compressionProof?.asImmutableBytes;

  static StructLayout get _layout =>
      LayoutConst.struct([LayoutConst.u8(property: 'instruction')]);

  factory MplCoreCompressionProofLayout.fromBuffer(
    List<int> bytes,
    MplCoreProgramInstruction instruction,
  ) {
    ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: instruction.instruction,
    );
    final tail = bytes.sublist(1);
    return MplCoreCompressionProofLayout(
      instruction: instruction,
      compressionProof: tail.isEmpty ? null : tail,
    );
  }

  @override
  StructLayout get layout => _layout;

  @override
  Map<String, dynamic> serialize() => {};

  @override
  BuBytes toBytes() {
    return MplCoreProgramLayoutBase.concatHeadTail(
      layout: _layout,
      fields: {'instruction': instruction.instruction},
      tail: compressionProof ?? const [0],
    );
  }
}

/// UpdateV1 (15) / UpdateV2 (30).
class MplCoreUpdateLayout extends MplCoreProgramLayoutBase {
  @override
  final MplCoreProgramInstruction instruction;
  final String? newName;
  final String? newUri;
  final MplCoreUpdateAuthority? newUpdateAuthority;
  const MplCoreUpdateLayout({
    required this.instruction,
    this.newName,
    this.newUri,
    this.newUpdateAuthority,
  });

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.optional(LayoutConst.string(), property: 'newName'),
    LayoutConst.optional(LayoutConst.string(), property: 'newUri'),
    LayoutConst.optional(
      MplCoreUpdateAuthority.staticLayout,
      property: 'newUpdateAuthority',
    ),
  ]);

  factory MplCoreUpdateLayout.fromBuffer(
    List<int> bytes,
    MplCoreProgramInstruction instruction,
  ) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: instruction.instruction,
    );
    final dynamic authorityJson = decode['newUpdateAuthority'];
    return MplCoreUpdateLayout(
      instruction: instruction,
      newName: decode['newName'],
      newUri: decode['newUri'],
      newUpdateAuthority:
          authorityJson == null
              ? null
              : MplCoreUpdateAuthority.fromJson(
                authorityJson as Map<String, dynamic>,
              ),
    );
  }

  @override
  StructLayout get layout => _layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'newName': newName,
      'newUri': newUri,
      'newUpdateAuthority': newUpdateAuthority?.serialize(),
    };
  }
}

/// UpdateCollectionV1 (16) / UpdateGroupV1 (41).
class MplCoreUpdateNameUriLayout extends MplCoreProgramLayoutBase {
  @override
  final MplCoreProgramInstruction instruction;
  final String? newName;
  final String? newUri;
  const MplCoreUpdateNameUriLayout({
    required this.instruction,
    this.newName,
    this.newUri,
  });

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.optional(LayoutConst.string(), property: 'newName'),
    LayoutConst.optional(LayoutConst.string(), property: 'newUri'),
  ]);

  factory MplCoreUpdateNameUriLayout.fromBuffer(
    List<int> bytes,
    MplCoreProgramInstruction instruction,
  ) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: instruction.instruction,
    );
    return MplCoreUpdateNameUriLayout(
      instruction: instruction,
      newName: decode['newName'],
      newUri: decode['newUri'],
    );
  }

  @override
  StructLayout get layout => _layout;

  @override
  Map<String, dynamic> serialize() {
    return {'newName': newName, 'newUri': newUri};
  }
}

/// Empty-payload layouts: CompressV1 (17), Collect (19),
/// AddCollectionsToGroupV1 (33), AddAssetsToGroupV1 (35),
/// CloseGroupV1 (40, empty CloseGroupV1Args).
class MplCoreEmptyLayout extends MplCoreProgramLayoutBase {
  @override
  final MplCoreProgramInstruction instruction;
  const MplCoreEmptyLayout({required this.instruction});

  static StructLayout get _layout =>
      LayoutConst.struct([LayoutConst.u8(property: 'instruction')]);

  factory MplCoreEmptyLayout.fromBuffer(
    List<int> bytes,
    MplCoreProgramInstruction instruction,
  ) {
    ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: instruction.instruction,
    );
    return MplCoreEmptyLayout(instruction: instruction);
  }

  @override
  StructLayout get layout => _layout;

  @override
  Map<String, dynamic> serialize() => {};
}

/// CreateV2 (20).
class MplCoreCreateV2Layout extends MplCoreProgramLayoutBase {
  final MplCoreDataState dataState;
  final String name;
  final String uri;
  final List<int> pluginArgs;
  MplCoreCreateV2Layout({
    required this.dataState,
    required this.name,
    required this.uri,
    List<int> pluginArgs = const [0, 0],
  }) : pluginArgs = pluginArgs.asImmutableBytes;

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u8(property: 'dataState'),
    LayoutConst.string(property: 'name'),
    LayoutConst.string(property: 'uri'),
  ]);

  factory MplCoreCreateV2Layout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: MplCoreProgramInstruction.createV2.instruction,
    );
    return MplCoreCreateV2Layout(
      dataState: MplCoreDataState.fromValue(decode['dataState']),
      name: decode['name'],
      uri: decode['uri'],
      pluginArgs: MplCoreProgramLayoutBase.tailOf(
        layout: _layout,
        bytes: bytes,
        decode: decode,
      ),
    );
  }

  @override
  StructLayout get layout => _layout;

  @override
  final MplCoreProgramInstruction instruction =
      MplCoreProgramInstruction.createV2;

  @override
  Map<String, dynamic> serialize() {
    return {'dataState': dataState.value, 'name': name, 'uri': uri};
  }

  @override
  BuBytes toBytes() {
    return MplCoreProgramLayoutBase.concatHeadTail(
      layout: _layout,
      fields: {'instruction': instruction.instruction, ...serialize()},
      tail: pluginArgs,
    );
  }
}

/// CreateCollectionV2 (21).
class MplCoreCreateCollectionV2Layout extends MplCoreProgramLayoutBase {
  final String name;
  final String uri;
  final List<int> pluginArgs;
  MplCoreCreateCollectionV2Layout({
    required this.name,
    required this.uri,
    List<int> pluginArgs = const [0, 0],
  }) : pluginArgs = pluginArgs.asImmutableBytes;

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.string(property: 'name'),
    LayoutConst.string(property: 'uri'),
  ]);

  factory MplCoreCreateCollectionV2Layout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: MplCoreProgramInstruction.createCollectionV2.instruction,
    );
    return MplCoreCreateCollectionV2Layout(
      name: decode['name'],
      uri: decode['uri'],
      pluginArgs: MplCoreProgramLayoutBase.tailOf(
        layout: _layout,
        bytes: bytes,
        decode: decode,
      ),
    );
  }

  @override
  StructLayout get layout => _layout;

  @override
  final MplCoreProgramInstruction instruction =
      MplCoreProgramInstruction.createCollectionV2;

  @override
  Map<String, dynamic> serialize() {
    return {'name': name, 'uri': uri};
  }

  @override
  BuBytes toBytes() {
    return MplCoreProgramLayoutBase.concatHeadTail(
      layout: _layout,
      fields: {'instruction': instruction.instruction, ...serialize()},
      tail: pluginArgs,
    );
  }
}

/// ExecuteV1 (31). `instructionData` is Anchor `bytes`
/// (u32 length prefix + bytes).
class MplCoreExecuteV1Layout extends MplCoreProgramLayoutBase {
  final List<int> instructionData;
  MplCoreExecuteV1Layout({required List<int> instructionData})
    : instructionData = instructionData.asImmutableBytes;

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.vecU8(property: 'instructionData'),
  ]);

  factory MplCoreExecuteV1Layout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: MplCoreProgramInstruction.executeV1.instruction,
    );
    return MplCoreExecuteV1Layout(
      instructionData: (decode['instructionData'] as List).cast<int>(),
    );
  }

  @override
  StructLayout get layout => _layout;

  @override
  final MplCoreProgramInstruction instruction =
      MplCoreProgramInstruction.executeV1;

  @override
  Map<String, dynamic> serialize() {
    return {'instructionData': instructionData};
  }
}

/// UpdateCollectionInfoV1 (32).
class MplCoreUpdateCollectionInfoV1Layout extends MplCoreProgramLayoutBase {
  final MplCoreUpdateType updateType;
  final int amount;
  const MplCoreUpdateCollectionInfoV1Layout({
    required this.updateType,
    required this.amount,
  });

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u8(property: 'updateType'),
    LayoutConst.u32(property: 'amount'),
  ]);

  factory MplCoreUpdateCollectionInfoV1Layout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: MplCoreProgramInstruction.updateCollectionInfoV1.instruction,
    );
    return MplCoreUpdateCollectionInfoV1Layout(
      updateType: MplCoreUpdateType.fromValue(decode['updateType']),
      amount: decode['amount'],
    );
  }

  @override
  StructLayout get layout => _layout;

  @override
  final MplCoreProgramInstruction instruction =
      MplCoreProgramInstruction.updateCollectionInfoV1;

  @override
  Map<String, dynamic> serialize() {
    return {'updateType': updateType.value, 'amount': amount};
  }
}

/// Pubkey-vec layouts: RemoveCollectionsFromGroupV1 (34),
/// RemoveAssetsFromGroupV1 (36), AddGroupsToGroupV1 (37),
/// RemoveGroupsFromGroupV1 (38).
class MplCorePubkeyVecLayout extends MplCoreProgramLayoutBase {
  @override
  final MplCoreProgramInstruction instruction;
  final List<SolAddress> pubkeys;
  MplCorePubkeyVecLayout({
    required this.instruction,
    required List<SolAddress> pubkeys,
  }) : pubkeys = List<SolAddress>.unmodifiable(pubkeys);

  static StructLayout _layoutFor(String property) => LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.vec(SolanaLayoutUtils.publicKey(), property: property),
  ]);

  @override
  StructLayout get layout => _layoutFor(_property);

  String get _property {
    switch (instruction) {
      case MplCoreProgramInstruction.removeCollectionsFromGroupV1:
        return 'collections';
      case MplCoreProgramInstruction.removeAssetsFromGroupV1:
        return 'assets';
      default:
        return 'groups';
    }
  }

  factory MplCorePubkeyVecLayout.fromBuffer(
    List<int> bytes,
    MplCoreProgramInstruction instruction,
  ) {
    String property;
    switch (instruction) {
      case MplCoreProgramInstruction.removeCollectionsFromGroupV1:
        property = 'collections';
        break;
      case MplCoreProgramInstruction.removeAssetsFromGroupV1:
        property = 'assets';
        break;
      default:
        property = 'groups';
    }
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layoutFor(property),
      bytes: bytes,
      instruction: instruction.instruction,
    );
    return MplCorePubkeyVecLayout(
      instruction: instruction,
      pubkeys: (decode[property] as List).cast<SolAddress>(),
    );
  }

  @override
  Map<String, dynamic> serialize() {
    return {_property: pubkeys};
  }
}

/// CreateGroupV1 (39). Typed name/uri plus raw `relationships`
/// (`Vec<GroupRelationship>`) suffix.
class MplCoreCreateGroupV1Layout extends MplCoreProgramLayoutBase {
  final String name;
  final String uri;
  final List<int> relationshipArgs;
  MplCoreCreateGroupV1Layout({
    required this.name,
    required this.uri,
    List<int> relationshipArgs = const [0, 0, 0, 0],
  }) : relationshipArgs = relationshipArgs.asImmutableBytes;

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.string(property: 'name'),
    LayoutConst.string(property: 'uri'),
  ]);

  factory MplCoreCreateGroupV1Layout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction: MplCoreProgramInstruction.createGroupV1.instruction,
    );
    return MplCoreCreateGroupV1Layout(
      name: decode['name'],
      uri: decode['uri'],
      relationshipArgs: MplCoreProgramLayoutBase.tailOf(
        layout: _layout,
        bytes: bytes,
        decode: decode,
      ),
    );
  }

  @override
  StructLayout get layout => _layout;

  @override
  final MplCoreProgramInstruction instruction =
      MplCoreProgramInstruction.createGroupV1;

  @override
  Map<String, dynamic> serialize() {
    return {'name': name, 'uri': uri};
  }

  @override
  BuBytes toBytes() {
    return MplCoreProgramLayoutBase.concatHeadTail(
      layout: _layout,
      fields: {'instruction': instruction.instruction, ...serialize()},
      tail: relationshipArgs,
    );
  }
}
