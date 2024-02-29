import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static final Structure layout =
      LayoutUtils.struct([LayoutUtils.u16("count")]);
}

class MintCounterAccount extends LayoutSerializable {
  const MintCounterAccount({required this.count});
  factory MintCounterAccount.fromBuffer(List<int> data) {
    final decode =
        LayoutSerializable.decode(bytes: data, layout: _Utils.layout);
    return MintCounterAccount(count: decode["count"]);
  }
  final int count;

  @override
  Structure get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {"count": count};
  }

  @override
  String toString() {
    return "MintCounterAccount${serialize()}";
  }
}
