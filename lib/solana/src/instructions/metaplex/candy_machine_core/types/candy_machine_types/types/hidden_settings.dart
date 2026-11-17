import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class CandyMachineHiddenSettings extends BorshLayoutSerializable {
  final String name;
  final String uri;
  final List<int> hash;
  CandyMachineHiddenSettings({
    required this.name,
    required this.uri,
    required List<int> hash,
  }) : hash =
           hash.length == 32
               ? hash.asImmutableBytes
               : throw const BuError(
                 DefaultErrorType.invalidArgument,
                 'Hash must be exactly 32 bytes.',
               );
  factory CandyMachineHiddenSettings.fromJson(Map<String, dynamic> json) {
    return CandyMachineHiddenSettings(
      name: json['name'],
      uri: json['uri'],
      hash: json['hash'],
    );
  }

  static StructLayout get staticLayout => LayoutConst.struct([
    LayoutConst.string(property: 'name'),
    LayoutConst.string(property: 'uri'),
    LayoutConst.blob(32, property: 'hash'),
  ], property: 'hiddenSettings');

  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {'name': name, 'uri': uri, 'hash': hash};
  }

  @override
  String toString() {
    return 'CandyMachineHiddenSettings${serialize()}';
  }
}
