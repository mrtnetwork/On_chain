import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class _Utils {
  static StructLayout get layout =>
      LayoutConst.struct([LayoutConst.u16(property: 'count')]);
}

class MintCounterAccount extends BorshLayoutSerializable {
  const MintCounterAccount({required this.count});
  factory MintCounterAccount.fromBuffer(List<int> data) {
    final decode =
        BorshLayoutSerializable.decode(bytes: data, layout: _Utils.layout);
    return MintCounterAccount(count: decode['count']);
  }
  final int count;

  @override
  StructLayout get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {'count': count};
  }

  @override
  String toString() {
    return 'MintCounterAccount${serialize()}';
  }
}
