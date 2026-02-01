import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class StartDate extends BorshLayoutSerializable {
  final BigInt date;

  const StartDate({required this.date});
  factory StartDate.fromJson(Map<String, dynamic> json) {
    return StartDate(date: json['date']);
  }

  static StructLayout get staticLayout =>
      LayoutConst.struct([LayoutConst.i64(property: 'date')],
          property: 'startDate');

  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {'date': date};
  }

  @override
  String toString() {
    return 'StartDate${serialize()}';
  }
}
