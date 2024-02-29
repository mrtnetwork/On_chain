import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/instructions/stake_pool/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';
import 'package:on_chain/solana/src/instructions/stake_pool/constant.dart';
import 'package:on_chain/solana/src/instructions/stake_pool/layouts/layouts/create_token_meta_data.dart';

/// Update token metadata for the stake-pool token in the
/// metaplex-token program layout.
class StakePoolUpdateTokenMetaDataLayout extends StakePoolProgramLayout {
  /// Token name
  final String name;

  /// URI of the uploaded metadata of the spl-token
  final String uri;

  /// Token symbol e.g. stkSOL
  final String symbol;
  const StakePoolUpdateTokenMetaDataLayout._(this.name, this.uri, this.symbol);
  factory StakePoolUpdateTokenMetaDataLayout({
    required String name,
    required String uri,
    required String symbol,
  }) {
    final nameBytesLength = StringUtils.encode(name).length;
    final uriBytesLength = StringUtils.encode(uri).length;
    final symbolBytesLength = StringUtils.encode(symbol).length;
    if (nameBytesLength > StakePoolProgramConst.metadataMaxNameLength ||
        uriBytesLength > StakePoolProgramConst.metadataMaxUriLength ||
        symbolBytesLength > StakePoolProgramConst.metadataMaxSymbolLength) {
      throw MessageException("Some fields exceed the maximum data limit.",
          details: {
            "metadataMaxNameLength":
                StakePoolProgramConst.metadataMaxNameLength,
            "metadataMaxUriLength": StakePoolProgramConst.metadataMaxUriLength,
            "metadataMaxSymbolLength":
                StakePoolProgramConst.metadataMaxSymbolLength
          });
    }
    return StakePoolUpdateTokenMetaDataLayout._(name, uri, symbol);
  }
  factory StakePoolUpdateTokenMetaDataLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: StakePoolCreateTokenMetaDataLayout.staticLayout,
        bytes: data,
        instruction:
            StakePoolProgramInstruction.updateTokenMetaData.insturction);

    return StakePoolUpdateTokenMetaDataLayout(
        name: decode["name"], uri: decode["uri"], symbol: decode["symbol"]);
  }
  @override
  Structure get layout => StakePoolCreateTokenMetaDataLayout.staticLayout;

  @override
  int get instruction =>
      StakePoolProgramInstruction.updateTokenMetaData.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"name": name, "symbol": symbol, "uri": uri};
  }
}
