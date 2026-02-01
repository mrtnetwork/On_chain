import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static StructLayout get layout => LayoutConst.struct([
        LayoutConst.u8(property: 'key'),
        SolanaLayoutUtils.publicKey('masterEdition'),
        LayoutConst.optional(LayoutConst.u64(), property: 'supplySnapshot'),
        LayoutConst.vec(ReservationV1.staticLayout, property: 'reservations'),
        LayoutConst.u64(property: 'totalReservationSpots'),
        LayoutConst.u64(property: 'currentReservationSpots')
      ]);
}

class ReservationListV2 extends BorshLayoutSerializable {
  final MetaDataKey key;
  final SolAddress masterEdition;
  final BigInt? supplySnapshot;
  final List<ReservationV1> reservations;
  final BigInt totalReservationSpots;
  final BigInt currentReservationSpots;

  const ReservationListV2(
      {required this.key,
      required this.masterEdition,
      required this.supplySnapshot,
      required this.reservations,
      required this.currentReservationSpots,
      required this.totalReservationSpots});
  factory ReservationListV2.fromBuffer(List<int> data) {
    final decode =
        BorshLayoutSerializable.decode(bytes: data, layout: _Utils.layout);
    return ReservationListV2(
        key: MetaDataKey.fromValue(decode['key']),
        masterEdition: decode['masterEdition'],
        supplySnapshot: decode['supplySnapshot'],
        reservations: (decode['reservations'] as List)
            .map((e) => ReservationV1.fromJson(e))
            .toList(),
        currentReservationSpots: decode['currentReservationSpots'],
        totalReservationSpots: decode['totalReservationSpots']);
  }

  @override
  StructLayout get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      'key': key.value,
      'masterEdition': masterEdition,
      'supplySnapshot': supplySnapshot,
      'reservations': reservations.map((e) => e.serialize()).toList(),
      'totalReservationSpots': totalReservationSpots,
      'currentReservationSpots': currentReservationSpots
    };
  }
}
