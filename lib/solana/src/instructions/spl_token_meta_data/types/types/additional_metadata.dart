import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Any additional metadata about the token as key-value pairs. The program
/// must avoid storing the same key twice.
class AdditionalMetadata extends LayoutSerializable {
  const AdditionalMetadata({required this.value, required this.key});
  final String key;
  final String value;
  factory AdditionalMetadata.fromJson(Map<String, dynamic> json) {
    final List<String> values = (json["values"] as List).cast();
    if (values.length != 2) {
      throw const SolanaPluginException(
          "invalid AdditionalMetadata data length");
    }
    return AdditionalMetadata(key: values[0], value: values[1]);
  }

  static final staticLayout = LayoutConst.struct([
    LayoutConst.tuple([
      LayoutConst.string(property: "key"),
      LayoutConst.string(property: "value"),
    ], property: "values")
  ], property: "additionalMetadata");

  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "values": <String>[key, value]
    };
  }
}
