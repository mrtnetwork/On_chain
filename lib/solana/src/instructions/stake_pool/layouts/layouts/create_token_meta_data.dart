import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/solana/src/instructions/stake_pool/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/stake_pool/constant.dart';

/// Create token metadata for the stake-pool token in the
/// metaplex-token program layout.
class StakePoolCreateTokenMetaDataLayout extends StakePoolProgramLayout {
  /// Token name
  final String name;

  /// URI of the uploaded metadata of the spl-token
  final String uri;

  /// Token symbol e.g. stkSOL
  final String symbol;
  const StakePoolCreateTokenMetaDataLayout._(this.name, this.uri, this.symbol);

  factory StakePoolCreateTokenMetaDataLayout({
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
      throw const SolanaPluginException(
          'Some fields exceed the maximum data limit.',
          details: {
            'metadataMaxNameLength':
                StakePoolProgramConst.metadataMaxNameLength,
            'metadataMaxUriLength': StakePoolProgramConst.metadataMaxUriLength,
            'metadataMaxSymbolLength':
                StakePoolProgramConst.metadataMaxSymbolLength
          });
    }

    return StakePoolCreateTokenMetaDataLayout._(name, uri, symbol);
  }
  factory StakePoolCreateTokenMetaDataLayout.fromBuffer(List<int> data) {
    final Map<String, dynamic> decode = ProgramLayout.decodeAndValidateStruct(
        layout: staticLayout,
        bytes: data,
        instruction:
            StakePoolProgramInstruction.createTokenMetaData.insturction);
    return StakePoolCreateTokenMetaDataLayout(
        name: decode['name'], uri: decode['uri'], symbol: decode['symbol']);
  }
  static final StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.string(property: 'name'),
    LayoutConst.string(property: 'symbol'),
    LayoutConst.string(property: 'uri'),
  ]);

  @override
  StructLayout get layout => staticLayout;

  @override
  StakePoolProgramInstruction get instruction =>
      StakePoolProgramInstruction.createTokenMetaData;

  @override
  Map<String, dynamic> serialize() {
    return {
      'name': name,
      'symbol': symbol,
      'uri': uri,
    };
  }
}
