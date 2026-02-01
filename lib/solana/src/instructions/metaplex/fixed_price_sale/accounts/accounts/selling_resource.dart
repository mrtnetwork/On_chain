import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/types/types.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static const List<int> discriminator = [15, 32, 69, 235, 249, 39, 18, 167];

  static StructLayout get layout => LayoutConst.struct([
        LayoutConst.blob(8, property: 'discriminator'),
        SolanaLayoutUtils.publicKey('store'),
        SolanaLayoutUtils.publicKey('owner'),
        SolanaLayoutUtils.publicKey('resource'),
        SolanaLayoutUtils.publicKey('vault'),
        SolanaLayoutUtils.publicKey('vaultOwner'),
        LayoutConst.u64(property: 'supply'),
        LayoutConst.optional(LayoutConst.u64(), property: 'maxSupply'),
        LayoutConst.u8(property: 'state')
      ]);
}

class SellingResource extends BorshLayoutSerializable {
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
    final decode = BorshLayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {'discriminator': _Utils.discriminator});
    return SellingResource(
        store: decode['store'],
        owner: decode['owner'],
        resource: decode['resource'],
        vault: decode['vault'],
        vaultOwner: decode['vaultOwner'],
        supply: decode['supply'],
        sellingResourceState: SellingResourceState.fromValue(decode['state']),
        maxSupply: decode['maxSupply']);
  }

  @override
  StructLayout get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'discriminator': _Utils.discriminator,
      'store': store,
      'owner': owner,
      'resource': resource,
      'vault': vault,
      'vaultOwner': vaultOwner,
      'supply': supply,
      'maxSupply': maxSupply,
      'state': sellingResourceState.value
    };
  }

  @override
  String toString() {
    return 'SellingResource${serialize()}';
  }
}
