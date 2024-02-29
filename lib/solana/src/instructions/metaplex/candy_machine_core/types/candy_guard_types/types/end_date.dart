import 'package:on_chain/solana/src/layout/layout.dart';

class EndDate extends LayoutSerializable {
  final BigInt date;

  const EndDate({required this.date});
  factory EndDate.fromJson(Map<String, dynamic> json) {
    return EndDate(date: json["date"]);
  }

  static final Structure staticLayout =
      LayoutUtils.struct([LayoutUtils.i64("date")], "endDate");

  @override
  Structure get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"date": date};
  }

  @override
  String toString() {
    return "EndDate${serialize()}";
  }
}
