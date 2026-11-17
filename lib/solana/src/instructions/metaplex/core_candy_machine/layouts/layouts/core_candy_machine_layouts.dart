// Borsh layouts for the Core Candy Machine + Core Candy Guard.
// Anchor discriminants (verified: sha256("global:<name>")[0..8]).
// Complex structs (CandyMachineData, MintAssetArgs, RouteArgs, guard sets)
// travel as raw Borsh bytes; scalar/vector fields are typed.
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/metaplex/core_candy_machine/layouts/instruction/instructions.dart';

/// Config line for AddConfigLines.
class CoreCandyMachineConfigLine extends BorshLayoutSerializable {
  final String name;
  final String uri;
  const CoreCandyMachineConfigLine({required this.name, required this.uri});

  static StructLayout get staticLayout => LayoutConst.struct([
    LayoutConst.string(property: 'name'),
    LayoutConst.string(property: 'uri'),
  ]);

  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() => {'name': name, 'uri': uri};

  factory CoreCandyMachineConfigLine.fromJson(Map<String, dynamic> json) {
    return CoreCandyMachineConfigLine(name: json['name'], uri: json['uri']);
  }
}

/// Shared base for Core Candy layouts.
abstract class CoreCandyMachineProgramLayout extends ProgramLayout {
  const CoreCandyMachineProgramLayout();
}

/// AddConfigLines (machine).
class CoreCandyMachineAddConfigLinesLayout
    extends CoreCandyMachineProgramLayout {
  final int index;
  final List<CoreCandyMachineConfigLine> configLines;
  CoreCandyMachineAddConfigLinesLayout({
    required this.index,
    required List<CoreCandyMachineConfigLine> configLines,
  }) : configLines = List<CoreCandyMachineConfigLine>.unmodifiable(configLines);

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.blob(8, property: 'instruction'),
    LayoutConst.u32(property: 'index'),
    LayoutConst.vec(
      CoreCandyMachineConfigLine.staticLayout,
      property: 'configLines',
    ),
  ]);

  factory CoreCandyMachineAddConfigLinesLayout.fromBuffer(List<int> data) {
    final decode = CoreCandyMachineProgramLayoutBase.decodeAndValidate(
      layout: _layout,
      bytes: data,
      instruction:
          CoreCandyMachineProgramInstruction.addConfigLines.instruction,
    );
    return CoreCandyMachineAddConfigLinesLayout(
      index: decode['index'],
      configLines:
          (decode['configLines'] as List)
              .map(
                (e) => CoreCandyMachineConfigLine.fromJson(
                  (e as Map).cast<String, dynamic>(),
                ),
              )
              .toList(),
    );
  }

  @override
  StructLayout get layout => _layout;

  @override
  final CoreCandyMachineProgramInstruction instruction =
      CoreCandyMachineProgramInstruction.addConfigLines;

  @override
  Map<String, dynamic> serialize() {
    return {
      'index': index,
      'configLines': configLines.map((e) => e.serialize()).toList(),
    };
  }
}

/// Raw-bytes layout for complex Anchor args. The 8-byte Anchor
/// discriminant is stored explicitly so machine/guard aliases encode
/// correctly; decode validates it in program_layout.dart.
class CoreCandyMachineRawArgsLayout extends CoreCandyMachineProgramLayout {
  @override
  final ProgramLayoutInstruction instruction;
  final List<int> discriminant;
  final List<int> argsBytes;
  CoreCandyMachineRawArgsLayout({
    required this.instruction,
    required List<int> discriminant,
    List<int> argsBytes = const [],
  }) : discriminant = discriminant.asImmutableBytes,
       argsBytes = argsBytes.asImmutableBytes;

  static StructLayout get _layout =>
      LayoutConst.struct([LayoutConst.blob(8, property: 'instruction')]);

  @override
  StructLayout get layout => _layout;

  @override
  Map<String, dynamic> serialize() => {'argsBytes': argsBytes};

  @override
  BuBytes toBytes() {
    final data = BuBytes.fill(discriminant.length + argsBytes.length, 0);
    data.setAll(0, discriminant);
    data.setAll(discriminant.length, argsBytes);
    return data;
  }

  /// Validate the discriminant and capture trailing raw args.
  static CoreCandyMachineRawArgsLayout fromBuffer(
    List<int> data,
    ProgramLayoutInstruction instruction,
    List<int> discriminant,
  ) {
    CoreCandyMachineProgramLayoutBase.decodeAndValidate(
      layout: _layout,
      bytes: data,
      instruction: discriminant,
    );
    return CoreCandyMachineRawArgsLayout(
      instruction: instruction,
      discriminant: discriminant,
      argsBytes: data.sublist(discriminant.length),
    );
  }
}

/// SetAuthority (machine + guard share the shape).
class CoreCandyMachineSetAuthorityLayout extends CoreCandyMachineProgramLayout {
  final ProgramLayoutInstruction programInstruction;
  final SolAddress newAuthority;
  const CoreCandyMachineSetAuthorityLayout({
    required this.programInstruction,
    required this.newAuthority,
  });

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.blob(8, property: 'instruction'),
    LayoutConst.blob(32, property: 'newAuthority'),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  ProgramLayoutInstruction get instruction => programInstruction;

  @override
  Map<String, dynamic> serialize() => {'newAuthority': newAuthority.toBytes()};

  /// Decode with the machine or guard SetAuthority discriminant.
  factory CoreCandyMachineSetAuthorityLayout.fromBuffer(
    List<int> data,
    ProgramLayoutInstruction instruction,
    List<int> discriminant,
  ) {
    final decode = CoreCandyMachineProgramLayoutBase.decodeAndValidate(
      layout: _layout,
      bytes: data,
      instruction: discriminant,
    );
    return CoreCandyMachineSetAuthorityLayout(
      programInstruction: instruction,
      newAuthority: SolAddress.uncheckBytes(
        (decode['newAuthority'] as List).cast<int>(),
      ),
    );
  }
}

/// MintV1 (guard): len-prefixed mint args + optional label.
class CoreCandyGuardMintV1Layout extends CoreCandyMachineProgramLayout {
  final List<int> mintArgs;
  final String? label;
  CoreCandyGuardMintV1Layout({required List<int> mintArgs, required this.label})
    : mintArgs = mintArgs.asImmutableBytes;

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.blob(8, property: 'instruction'),
    LayoutConst.vecU8(property: 'mintArgs'),
    LayoutConst.optional(LayoutConst.string(), property: 'label'),
  ]);

  factory CoreCandyGuardMintV1Layout.fromBuffer(List<int> data) {
    final decode = CoreCandyMachineProgramLayoutBase.decodeAndValidate(
      layout: _layout,
      bytes: data,
      instruction: CoreCandyGuardProgramInstruction.mintV1.instruction,
    );
    return CoreCandyGuardMintV1Layout(
      mintArgs: (decode['mintArgs'] as List).cast<int>(),
      label: decode['label'],
    );
  }

  @override
  StructLayout get layout => _layout;

  @override
  final CoreCandyGuardProgramInstruction instruction =
      CoreCandyGuardProgramInstruction.mintV1;

  @override
  Map<String, dynamic> serialize() {
    return {'mintArgs': mintArgs, 'label': label};
  }
}

/// Empty layouts (SetCollection, SetMintAuthority, Withdraw x2,
/// Wrap, Unwrap).
class CoreCandyMachineEmptyLayout extends CoreCandyMachineProgramLayout {
  final ProgramLayoutInstruction programInstruction;
  const CoreCandyMachineEmptyLayout({required this.programInstruction});

  static StructLayout get _layout =>
      LayoutConst.struct([LayoutConst.blob(8, property: 'instruction')]);

  @override
  StructLayout get layout => _layout;

  @override
  ProgramLayoutInstruction get instruction => programInstruction;

  @override
  Map<String, dynamic> serialize() => {};

  /// Validate the discriminant for empty layouts.
  factory CoreCandyMachineEmptyLayout.fromBuffer(
    List<int> data,
    ProgramLayoutInstruction instruction,
    List<int> discriminant,
  ) {
    CoreCandyMachineProgramLayoutBase.decodeAndValidate(
      layout: _layout,
      bytes: data,
      instruction: discriminant,
    );
    return CoreCandyMachineEmptyLayout(programInstruction: instruction);
  }
}

/// Discriminant validation helper.
abstract class CoreCandyMachineProgramLayoutBase {
  static Map<String, dynamic> decodeAndValidate({
    required StructLayout layout,
    required List<int> bytes,
    required List<int> instruction,
  }) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: layout,
      bytes: bytes,
    );
    final List<int> actual = (decode['instruction'] as List).cast<int>();
    if (actual.length != instruction.length) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'Invalid Core Candy instruction bytes.',
      );
    }
    for (var i = 0; i < instruction.length; i++) {
      if (actual[i] != instruction[i]) {
        throw BuError(
          DefaultErrorType.invalidArgument,
          'Invalid Core Candy instruction bytes.',
        );
      }
    }
    return decode;
  }
}
