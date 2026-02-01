import 'package:on_chain/solana/src/instructions/spl_token/types/types.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class _Utils {
  static StructLayout layout = LayoutConst.struct([
    LayoutConst.u64(property: 'instructionDiscriminator'),
    LayoutConst.u32(property: 'length'),
    ExtraAccountMetaList.staticLayout,
  ], property: 'extraAccountMetaList');
}

class ExtraAccountMetaAccountData extends BorshLayoutSerializable {
  ExtraAccountMetaAccountData({
    required this.instructionDiscriminator,
    required this.length,
    required this.extraAccountMetaList,
  });
  final BigInt instructionDiscriminator;
  final int length;
  final ExtraAccountMetaList extraAccountMetaList;
  factory ExtraAccountMetaAccountData.fromBuffer(List<int> accountBytes) {
    final decode = BorshLayoutSerializable.decode(
        bytes: accountBytes, layout: _Utils.layout);
    return ExtraAccountMetaAccountData(
        instructionDiscriminator: decode['instructionDiscriminator'],
        length: decode['length'],
        extraAccountMetaList:
            ExtraAccountMetaList.fromJson(decode['extraAccountMetaList']));
  }

  @override
  StructLayout get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'instructionDiscriminator': instructionDiscriminator,
      'length': length,
      'extraAccountMetaList': extraAccountMetaList.serialize(),
    };
  }

  @override
  String toString() {
    return 'ExtraAccountMetaAccountData${serialize()}';
  }

  List<ExtraAccountMeta> get extraAccountMetas {
    return extraAccountMetaList.extraAccounts
        .sublist(0, extraAccountMetaList.count);
  }
}
