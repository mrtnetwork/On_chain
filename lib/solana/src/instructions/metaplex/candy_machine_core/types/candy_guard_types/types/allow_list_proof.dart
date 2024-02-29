import 'package:on_chain/solana/src/layout/layout.dart';

class AllowListProof extends LayoutSerializable {
  final BigInt timestamp;

  const AllowListProof({required this.timestamp});
  factory AllowListProof.fromJson(Map<String, dynamic> json) {
    return AllowListProof(timestamp: json["timestamp"]);
  }

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.i64("timestamp"),
  ], "allowListProof");

  @override
  Structure get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"timestamp": timestamp};
  }

  @override
  String toString() {
    return "AllowListProof${serialize()}";
  }
}
