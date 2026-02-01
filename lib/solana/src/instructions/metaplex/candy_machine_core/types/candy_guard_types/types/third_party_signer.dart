import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class ThirdPartySigner extends BorshLayoutSerializable {
  final SolAddress signerKey;

  const ThirdPartySigner({required this.signerKey});
  factory ThirdPartySigner.fromJson(Map<String, dynamic> json) {
    return ThirdPartySigner(signerKey: json['signerKey']);
  }

  static StructLayout get staticLayout =>
      LayoutConst.struct([SolanaLayoutUtils.publicKey('signerKey')],
          property: 'thirdPartySigner');

  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {'signerKey': signerKey};
  }

  @override
  String toString() {
    return 'ThirdPartySigner${serialize()}';
  }
}
