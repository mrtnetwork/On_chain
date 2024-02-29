import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/types/types.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static const List<int> discriminator = [15, 32, 69, 235, 249, 39, 18, 167];

  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "discriminator"),
    LayoutUtils.publicKey("store"),
    LayoutUtils.publicKey("owner"),
    LayoutUtils.publicKey("resource"),
    LayoutUtils.publicKey("vault"),
    LayoutUtils.publicKey("vaultOwner"),
    LayoutUtils.u64("supply"),
    LayoutUtils.optional(LayoutUtils.u64(), property: "maxSupply"),
    LayoutUtils.u8("state")
  ]);
}

class SellingResource extends LayoutSerializable {
  final SolAddress store;
  final SolAddress owner;
  final SolAddress resource;
  final SolAddress vault;
  final SolAddress vaultOwner;
  final BigInt supply;
  final BigInt? maxSupply;
  final SellingResourceState sellingResourceState;

  const SellingResource({
    required this.store,
    required this.owner,
    required this.resource,
    required this.vault,
    required this.vaultOwner,
    required this.supply,
    this.maxSupply,
    required this.sellingResourceState,
  });
  factory SellingResource.fromBuffer(List<int> data) {
    final decode = LayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {"discriminator": _Utils.discriminator});
    return SellingResource(
        store: decode["store"],
        owner: decode["owner"],
        resource: decode["resource"],
        vault: decode["vault"],
        vaultOwner: decode["vaultOwner"],
        supply: decode["supply"],
        sellingResourceState: SellingResourceState.fromValue(decode["state"]),
        maxSupply: decode["maxSupply"]);
  }

  @override
  Structure get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "discriminator": _Utils.discriminator,
      "store": store,
      "owner": owner,
      "resource": resource,
      "vault": vault,
      "vaultOwner": vaultOwner,
      "supply": supply,
      "maxSupply": maxSupply,
      "state": sellingResourceState.value
    };
  }

  @override
  String toString() {
    return "SellingResource${serialize()}";
  }
}
