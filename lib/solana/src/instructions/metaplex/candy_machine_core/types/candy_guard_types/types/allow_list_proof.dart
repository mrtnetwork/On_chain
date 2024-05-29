import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class AllowListProof extends LayoutSerializable {
  final BigInt timestamp;

  const AllowListProof({required this.timestamp});
  factory AllowListProof.fromJson(Map<String, dynamic> json) {
    return AllowListProof(timestamp: json["timestamp"]);
  }

  static final StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.i64(property: "timestamp"),
  ], property: "allowListProof");

  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"timestamp": timestamp};
  }

  @override
  String toString() {
    return "AllowListProof${serialize()}";
  }
}
