import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class ReservationV1 extends BorshLayoutSerializable {
  const ReservationV1(
      {required this.address,
      required this.spotsRemaining,
      required this.totalSpots});
  factory ReservationV1.fromJson(Map<String, dynamic> json) {
    return ReservationV1(
        address: json['address'],
        spotsRemaining: json['spotsRemaining'],
        totalSpots: json['totalSpots']);
  }
  final SolAddress address;
  final int spotsRemaining;
  final int totalSpots;

  static StructLayout get staticLayout => LayoutConst.struct([
        SolanaLayoutUtils.publicKey('address'),
        LayoutConst.u8(property: 'spotsRemaining'),
        LayoutConst.u8(property: 'totalSpots'),
      ], property: 'reservationV1');

  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'address': address,
      'spotsRemaining': spotsRemaining,
      'totalSpots': totalSpots
    };
  }
}
