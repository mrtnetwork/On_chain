import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.u8("key"),
    LayoutUtils.publicKey("masterEdition"),
    LayoutUtils.optional(LayoutUtils.u64(), property: "supplySnapshot"),
    LayoutUtils.vec(ReservationV1.staticLayout, property: "reservations")
  ]);
}

class ReservationListV1 extends LayoutSerializable {
  final MetaDataKey key;
  final SolAddress masterEdition;
  final BigInt? supplySnapshot;
  final List<ReservationV1> reservations;

  const ReservationListV1(
      {required this.key,
      required this.masterEdition,
      required this.supplySnapshot,
      required this.reservations});
  factory ReservationListV1.fromBuffer(List<int> data) {
    final decode =
        LayoutSerializable.decode(bytes: data, layout: _Utils.layout);
    return ReservationListV1(
        key: MetaDataKey.fromValue(decode["key"]),
        masterEdition: decode["masterEdition"],
        supplySnapshot: decode["supplySnapshot"],
        reservations: (decode["reservations"] as List)
            .map((e) => ReservationV1.fromJson(e))
            .toList());
  }

  @override
  Structure get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "key": key.value,
      "masterEdition": masterEdition,
      "supplySnapshot": supplySnapshot,
      "reservations": reservations.map((e) => e.serialize()).toList()
    };
  }
}
