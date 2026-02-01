import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/types/types.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static const List<int> discriminator = [219, 190, 213, 55, 0, 227, 198, 154];
  static StructLayout get layout => LayoutConst.struct([
        LayoutConst.blob(8, property: 'discriminator'),
        SolanaLayoutUtils.publicKey('store'),
        SolanaLayoutUtils.publicKey('sellingResource'),
        SolanaLayoutUtils.publicKey('treasuryMint'),
        SolanaLayoutUtils.publicKey('treasuryHolder'),
        SolanaLayoutUtils.publicKey('treasuryOwner'),
        SolanaLayoutUtils.publicKey('owner'),
        LayoutConst.string(property: 'name'),
        LayoutConst.string(property: 'description'),
        LayoutConst.boolean(property: 'mutable'),
        LayoutConst.u64(property: 'price'),
        LayoutConst.optional(LayoutConst.u64(), property: 'piecesInOneWallet'),
        LayoutConst.u64(property: 'startDate'),
        LayoutConst.optional(LayoutConst.u64(), property: 'endDate'),
        LayoutConst.u8(property: 'state'),
        LayoutConst.u64(property: 'fundsCollected'),
        LayoutConst.optional(GatingConfig.staticLayout,
            property: 'gatingConfig')
      ]);
}

class Market extends BorshLayoutSerializable {
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
    final decode = BorshLayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {'discriminator': _Utils.discriminator});
    return Market(
        store: decode['store'],
        sellingResource: decode['sellingResource'],
        treasuryMint: decode['treasuryMint'],
        treasuryHolder: decode['treasuryHolder'],
        treasuryOwner: decode['treasuryOwner'],
        owner: decode['owner'],
        name: decode['name'],
        description: decode['description'],
        mutable: decode['mutable'],
        price: decode['price'],
        startDate: decode['startDate'],
        marketState: MarketState.fromValue(decode['state']),
        fundsCollected: decode['fundsCollected'],
        endDate: decode['endDate'],
        piecesInOneWallet: decode['piecesInOneWallet'],
        gatekeeper: decode['gatingConfig'] == null
            ? null
            : GatingConfig.fromJson(decode['gatingConfig']));
  }

  @override
  StructLayout get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'discriminator': _Utils.discriminator,
      'gatingConfig': gatekeeper?.serialize(),
      'store': store,
      'sellingResource': sellingResource,
      'treasuryMint': treasuryMint,
      'treasuryHolder': treasuryHolder,
      'treasuryOwner': treasuryOwner,
      'owner': owner,
      'name': name,
      'description': description,
      'mutable': mutable,
      'price': price,
      'piecesInOneWallet': piecesInOneWallet,
      'startDate': startDate,
      'endDate': endDate,
      'state': marketState.value,
      'fundsCollected': fundsCollected,
    };
  }

  @override
  String toString() {
    return 'Market${serialize()}';
  }
}
