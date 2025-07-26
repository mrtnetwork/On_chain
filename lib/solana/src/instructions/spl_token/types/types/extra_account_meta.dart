import 'package:blockchain_utils/helper/extensions/extensions.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

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
      : addressConfig = addressConfig.asImmutableBytes;
  factory ExtraAccountMeta.fromJson(Map<String, dynamic> json) {
    return ExtraAccountMeta(
        discriminator: json['discriminator'],
        addressConfig: (json['addressConfig'] as List).cast(),
        isSigner: json['isSigner'],
        isWritable: json['isWritable']);
  }

  static StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.u8(property: 'discriminator'),
    LayoutConst.blob(32, property: 'addressConfig'),
    LayoutConst.boolean(property: 'isSigner'),
    LayoutConst.boolean(property: 'isWritable'),
  ], property: 'extraAccountMeta');
  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'discriminator': discriminator,
      'addressConfig': addressConfig,
      'isSigner': isSigner,
      'isWritable': isWritable
    };
  }

  @override
  String toString() {
    return 'ExtraAccountMeta${serialize()}';
  }
}
