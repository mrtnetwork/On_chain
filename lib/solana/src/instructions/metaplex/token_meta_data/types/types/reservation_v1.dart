import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class ReservationV1 extends LayoutSerializable {
  const ReservationV1(
      {required this.address,
      required this.spotsRemaining,
      required this.totalSpots});
  factory ReservationV1.fromJson(Map<String, dynamic> json) {
    return ReservationV1(
        address: json["address"],
        spotsRemaining: json["spotsRemaining"],
        totalSpots: json["totalSpots"]);
  }
  final SolAddress address;
  final int spotsRemaining;
  final int totalSpots;

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.publicKey("address"),
    LayoutUtils.u8("spotsRemaining"),
    LayoutUtils.u8("totalSpots"),
  ], "reservationV1");

  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "address": address,
      "spotsRemaining": spotsRemaining,
      "totalSpots": totalSpots
    };
  }
}
