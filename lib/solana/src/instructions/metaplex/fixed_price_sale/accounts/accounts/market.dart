import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/types/types.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static const List<int> discriminator = [219, 190, 213, 55, 0, 227, 198, 154];
  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "discriminator"),
    LayoutUtils.publicKey("store"),
    LayoutUtils.publicKey("sellingResource"),
    LayoutUtils.publicKey("treasuryMint"),
    LayoutUtils.publicKey("treasuryHolder"),
    LayoutUtils.publicKey("treasuryOwner"),
    LayoutUtils.publicKey("owner"),
    LayoutUtils.string("name"),
    LayoutUtils.string("description"),
    LayoutUtils.boolean(property: "mutable"),
    LayoutUtils.u64("price"),
    LayoutUtils.optional(LayoutUtils.u64(), property: "piecesInOneWallet"),
    LayoutUtils.u64("startDate"),
    LayoutUtils.optional(LayoutUtils.u64(), property: "endDate"),
    LayoutUtils.u8("state"),
    LayoutUtils.u64("fundsCollected"),
    LayoutUtils.optional(GatingConfig.staticLayout, property: "gatingConfig")
  ]);
}

class Market extends LayoutSerializable {
  final SolAddress store;
  final SolAddress sellingResource;
  final SolAddress treasuryMint;
  final SolAddress treasuryHolder;
  final SolAddress treasuryOwner;
  final SolAddress owner;
  final String name;
  final String description;
  final bool mutable;
  final BigInt price;
  final BigInt? piecesInOneWallet;
  final BigInt startDate;
  final BigInt? endDate;
  final MarketState marketState;
  final BigInt fundsCollected;
  final GatingConfig? gatekeeper;

  const Market(
      {required this.store,
      required this.sellingResource,
      required this.treasuryMint,
      required this.treasuryHolder,
      required this.treasuryOwner,
      required this.owner,
      required this.name,
      required this.description,
      required this.mutable,
      required this.price,
      this.piecesInOneWallet,
      required this.startDate,
      this.endDate,
      required this.marketState,
      required this.fundsCollected,
      this.gatekeeper});
  factory Market.fromBuffer(List<int> data) {
    final decode = LayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {"discriminator": _Utils.discriminator});
    return Market(
        store: decode["store"],
        sellingResource: decode["sellingResource"],
        treasuryMint: decode["treasuryMint"],
        treasuryHolder: decode["treasuryHolder"],
        treasuryOwner: decode["treasuryOwner"],
        owner: decode["owner"],
        name: decode["name"],
        description: decode["description"],
        mutable: decode["mutable"],
        price: decode["price"],
        startDate: decode["startDate"],
        marketState: MarketState.fromValue(decode["state"]),
        fundsCollected: decode["fundsCollected"],
        endDate: decode["endDate"],
        piecesInOneWallet: decode["piecesInOneWallet"],
        gatekeeper: decode["gatingConfig"] == null
            ? null
            : GatingConfig.fromJson(decode["gatingConfig"]));
  }

  @override
  Structure get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "discriminator": _Utils.discriminator,
      "gatingConfig": gatekeeper?.serialize(),
      "store": store,
      "sellingResource": sellingResource,
      "treasuryMint": treasuryMint,
      "treasuryHolder": treasuryHolder,
      "treasuryOwner": treasuryOwner,
      "owner": owner,
      "name": name,
      "description": description,
      "mutable": mutable,
      "price": price,
      "piecesInOneWallet": piecesInOneWallet,
      "startDate": startDate,
      "endDate": endDate,
      "state": marketState.value,
      "fundsCollected": fundsCollected,
    };
  }

  @override
  String toString() {
    return "Market${serialize()}";
  }
}
