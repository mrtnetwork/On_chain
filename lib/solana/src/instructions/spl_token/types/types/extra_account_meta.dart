import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class ExtraAccountMeta extends LayoutSerializable {
  final int discriminator;
  final List<int> addressConfig;
  final bool isSigner;
  final bool isWritable;
  ExtraAccountMeta(
      {required this.discriminator,
      required List<int> addressConfig,
      required this.isSigner,
      required this.isWritable})
      : addressConfig = BytesUtils.toBytes(addressConfig, unmodifiable: true);
  factory ExtraAccountMeta.fromJson(Map<String, dynamic> json) {
    return ExtraAccountMeta(
        discriminator: json["discriminator"],
        addressConfig: (json["addressConfig"] as List).cast(),
        isSigner: json["isSigner"],
        isWritable: json["isWritable"]);
  }

  static Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.u8('discriminator'),
    LayoutUtils.blob(32, property: 'addressConfig'),
    LayoutUtils.boolean(property: 'isSigner'),
    LayoutUtils.boolean(property: 'isWritable'),
  ], "extraAccountMeta");
  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "discriminator": discriminator,
      "addressConfig": addressConfig,
      "isSigner": isSigner,
      "isWritable": isWritable
    };
  }

  @override
  String toString() {
    return "ExtraAccountMeta${serialize()}";
  }
}
