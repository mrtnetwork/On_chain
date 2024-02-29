import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static final Structure layout =
      LayoutUtils.struct([LayoutUtils.i64("timestamp")]);
}

class AllowListProofAccount extends LayoutSerializable {
  final BigInt timestamp;
  const AllowListProofAccount({required this.timestamp});
  factory AllowListProofAccount.fromBuffer(List<int> data) {
    final decode =
        LayoutSerializable.decode(bytes: data, layout: _Utils.layout);
    return AllowListProofAccount(timestamp: decode["timestamp"]);
  }

  @override
  Structure get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {"timestamp": timestamp};
  }

  @override
  String toString() {
    return "AllowListProofAccount${serialize()}";
  }
}
