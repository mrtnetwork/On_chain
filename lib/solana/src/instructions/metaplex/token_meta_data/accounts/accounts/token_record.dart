import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static final StructLayout layout = LayoutConst.struct([
    LayoutConst.u8(property: "key"),
    LayoutConst.u8(property: "bump"),
    LayoutConst.wrap(TokenState.staticLayout, property: "state"),
    LayoutConst.optional(LayoutConst.u64(), property: "ruleSetRevision"),
    SolanaLayoutUtils.optionPubkey(property: "delegate"),
    LayoutConst.optional(TokenDelegateRole.staticLayout,
        property: "delegateRole"),
    SolanaLayoutUtils.optionPubkey(property: "lockedTransfer"),
  ]);
}

class TokenRecord extends LayoutSerializable {
  final MetaDataKey key;
  final int bump;
  final TokenState state;
  final BigInt? ruleSetRevision;
  final SolAddress? delegate;
  final TokenDelegateRole? delegateRole;
  final SolAddress? lockedTransfer;

  const TokenRecord(
      {required this.key,
      required this.bump,
      required this.state,
      required this.ruleSetRevision,
      required this.delegate,
      required this.delegateRole,
      required this.lockedTransfer});
  factory TokenRecord.fromBuffer(List<int> data) {
    final decode =
        LayoutSerializable.decode(bytes: data, layout: _Utils.layout);
    return TokenRecord(
        key: MetaDataKey.fromValue(decode["key"]),
        bump: decode["bump"],
        state: TokenState.fromJson(decode["state"]),
        ruleSetRevision: decode["ruleSetRevision"],
        delegate: decode["delegate"],
        delegateRole: TokenDelegateRole.fromJson(decode["delegateRole"]),
        lockedTransfer: decode["lockedTransfer"]);
  }

  @override
  StructLayout get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "key": key.value,
      "bump": bump,
      "state": state.serialize(),
      "ruleSetRevision": ruleSetRevision,
      "delegate": delegate,
      "delegateRole": delegateRole?.serialize(),
      "lockedTransfer": lockedTransfer
    };
  }
}
