import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static const List<int> discriminator = [190, 117, 218, 114, 66, 112, 56, 41];

  static final StructLayout layout = LayoutConst.struct([
    LayoutConst.blob(8, property: 'discriminator'),
    SolanaLayoutUtils.publicKey('market'),
    SolanaLayoutUtils.publicKey('wallet'),
    LayoutConst.u64(property: 'alreadyBought'),
  ]);
}

class TradeHistory extends LayoutSerializable {
  static int get size => _Utils.layout.span;
  final SolAddress market;
  final SolAddress wallet;
  final BigInt alreadyBought;

  const TradeHistory({
    required this.wallet,
    required this.market,
    required this.alreadyBought,
  });
  factory TradeHistory.fromBuffer(List<int> data) {
    final decode = LayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {'discriminator': _Utils.discriminator});
    return TradeHistory(
        market: decode['market'],
        wallet: decode['wallet'],
        alreadyBought: decode['alreadyBought']);
  }

  @override
  StructLayout get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'discriminator': _Utils.discriminator,
      'alreadyBought': alreadyBought,
      'wallet': wallet,
      'market': market
    };
  }

  @override
  String toString() {
    return 'TradeHistory${serialize()}';
  }
}
