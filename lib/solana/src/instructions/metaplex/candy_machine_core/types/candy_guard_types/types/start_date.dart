import 'package:on_chain/solana/src/layout/layout.dart';

class StartDate extends LayoutSerializable {
  final BigInt date;

  const StartDate({required this.date});
  factory StartDate.fromJson(Map<String, dynamic> json) {
    return StartDate(date: json["date"]);
  }

  static final Structure staticLayout =
      LayoutUtils.struct([LayoutUtils.i64("date")], "startDate");

  @override
  Structure get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {"date": date};
  }

  @override
  String toString() {
    return "StartDate${serialize()}";
  }
}
