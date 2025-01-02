import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class _Utils {
  static final StructLayout layout =
      LayoutConst.struct([LayoutConst.i64(property: 'timestamp')]);
}

class AllowListProofAccount extends LayoutSerializable {
  final BigInt timestamp;
  const AllowListProofAccount({required this.timestamp});
  factory AllowListProofAccount.fromBuffer(List<int> data) {
    final decode =
        LayoutSerializable.decode(bytes: data, layout: _Utils.layout);
    return AllowListProofAccount(timestamp: decode['timestamp']);
  }

  @override
  StructLayout get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {'timestamp': timestamp};
  }

  @override
  String toString() {
    return 'AllowListProofAccount${serialize()}';
  }
}
