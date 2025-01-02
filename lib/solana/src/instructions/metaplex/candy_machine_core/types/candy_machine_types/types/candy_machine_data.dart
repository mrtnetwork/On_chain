import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/types/candy_machine_types/types/config_line_settings.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/types/candy_machine_types/types/hidden_settings.dart';
import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/types/types/creator.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class CandyMachineData extends LayoutSerializable {
  final BigInt itemsAvailable;
  final String symbol;
  final int sellerFeeBasisPoints;
  final BigInt maxSupply;
  final bool isMutable;
  final List<Creator> creators;
  final ConfigLineSettings? configLineSettings;
  final CandyMachineHiddenSettings? hiddenSettings;
  CandyMachineData(
      {required this.itemsAvailable,
      required this.symbol,
      required this.sellerFeeBasisPoints,
      required this.maxSupply,
      required this.isMutable,
      required this.creators,
      this.configLineSettings,
      this.hiddenSettings});
  factory CandyMachineData.fromJson(Map<String, dynamic> json) {
    return CandyMachineData(
        itemsAvailable: json['itemsAvailable'],
        symbol: json['symbol'],
        sellerFeeBasisPoints: json['sellerFeeBasisPoints'],
        maxSupply: json['maxSupply'],
        isMutable: json['isMutable'],
        creators:
            (json['creators'] as List).map((e) => Creator.fromJson(e)).toList(),
        configLineSettings: json['configLineSettings'] == null
            ? null
            : ConfigLineSettings.fromJson(json['configLineSettings']),
        hiddenSettings: json['hiddenSettings'] == null
            ? null
            : CandyMachineHiddenSettings.fromJson(json['hiddenSettings']));
  }

  static final StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.u64(property: 'itemsAvailable'),
    LayoutConst.string(property: 'symbol'),
    LayoutConst.u16(property: 'sellerFeeBasisPoints'),
    LayoutConst.u64(property: 'maxSupply'),
    LayoutConst.boolean(property: 'isMutable'),
    LayoutConst.vec(Creator.creatorLayout, property: 'creators'),
    LayoutConst.optional(ConfigLineSettings.staticLayout,
        property: 'configLineSettings'),
    LayoutConst.optional(CandyMachineHiddenSettings.staticLayout,
        property: 'hiddenSettings')
  ], property: 'candyMachineData');

  @override
  Map<String, dynamic> serialize() {
    return {
      'itemsAvailable': itemsAvailable,
      'symbol': symbol,
      'sellerFeeBasisPoints': sellerFeeBasisPoints,
      'maxSupply': maxSupply,
      'isMutable': isMutable,
      'creators': creators.map((e) => e.serialize()).toList(),
      'configLineSettings': configLineSettings?.serialize(),
      'hiddenSettings': hiddenSettings?.serialize()
    };
  }

  @override
  StructLayout get layout => staticLayout;

  @override
  String toString() {
    return 'CandyMachineData${serialize()}';
  }
}
