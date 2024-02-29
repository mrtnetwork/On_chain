import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.u8("key"),
    LayoutUtils.u8("bump"),
    LayoutUtils.wrap(TokenState.staticLayout, property: "state"),
    LayoutUtils.optional(LayoutUtils.u64(), property: "ruleSetRevision"),
    LayoutUtils.optionPubkey(property: "delegate"),
    LayoutUtils.optional(TokenDelegateRole.staticLayout,
        property: "delegateRole"),
    LayoutUtils.optionPubkey(property: "lockedTransfer"),
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
  Structure get layout => _Utils.layout;
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
