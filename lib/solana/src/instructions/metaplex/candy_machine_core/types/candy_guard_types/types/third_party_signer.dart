import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class ThirdPartySigner extends LayoutSerializable {
  final SolAddress signerKey;

  const ThirdPartySigner({required this.signerKey});
  factory ThirdPartySigner.fromJson(Map<String, dynamic> json) {
    return ThirdPartySigner(signerKey: json["signerKey"]);
  }

  static final Structure staticLayout = LayoutUtils.struct(
      [LayoutUtils.publicKey("signerKey")], "thirdPartySigner");

  @override
  Structure get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"signerKey": signerKey};
  }

  @override
  String toString() {
    return "ThirdPartySigner${serialize()}";
  }
}
