import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class EndDate extends LayoutSerializable {
  final BigInt date;

  const EndDate({required this.date});
  factory EndDate.fromJson(Map<String, dynamic> json) {
    return EndDate(date: json['date']);
  }

  static final StructLayout staticLayout = LayoutConst.struct(
      [LayoutConst.i64(property: 'date')],
      property: 'endDate');

  @override
  StructLayout get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {'date': date};
  }

  @override
  String toString() {
    return 'EndDate${serialize()}';
  }
}
