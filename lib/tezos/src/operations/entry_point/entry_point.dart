import 'package:blockchain_utils/encoding/encoding.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/tezos/src/micheline/src/michline.dart';
import 'package:on_chain/tezos/src/micheline/src/utils.dart';
import 'package:on_chain/tezos/src/operations/layouts/utils.dart';
import 'package:on_chain/tezos/src/serialization/src/octez.dart';

/// Binary tag of a Tezos entrypoint.
///
/// [value] is the forge tag byte; [tag] is the RPC/JSON entrypoint name.
enum TezosEntrypointTag {
  default_(0x00, 'default'),
  root(0x01, 'root'),
  do_(0x02, 'do'),
  setDelegate(0x03, 'set_delegate'),
  removeDelegate(0x04, 'remove_delegate'),
  deposit(0x05, 'deposit'),
  stake(0x06, 'stake'),
  unstake(0x07, 'unstake'),
  finalizeUnstake(0x08, 'finalize_unstake'),
  setDelegateParameters(0x09, 'set_delegate_parameters'),

  /// Custom entrypoint name (`0xFF` followed by a length-prefixed UTF-8 name).
  name(0xFF, 'name');

  const TezosEntrypointTag(this.value, this.tag);

  /// Forge tag byte.
  final int value;

  /// RPC/JSON entrypoint name.
  final String tag;

  /// Look up a tag by its RPC/JSON [name]; unknown names map to [name].
  static TezosEntrypointTag fromTag(String tag) {
    return values.firstWhere(
      (e) => e.tag == tag,
      orElse: () => TezosEntrypointTag.name,
    );
  }
}

/// A Tezos contract entrypoint.
sealed class TezosEntrypoint extends OctezSerializable<TezosEntrypoint>
    with Equality {
  /// Binary tag of the entrypoint.
  final TezosEntrypointTag tag;
  const TezosEntrypoint(this.tag);

  /// RPC/JSON entrypoint name.
  String get name => tag.tag;

  factory TezosEntrypoint.deserialize(List<int> bytes) {
    return layout().deserialize(bytes).value;
  }
  factory TezosEntrypoint.deserializeJson(String name) {
    final tag = TezosEntrypointTag.fromTag(name);
    return switch (tag) {
      TezosEntrypointTag.default_ => const TezosEntrypointDefault(),
      TezosEntrypointTag.root => const TezosEntrypointRoot(),
      TezosEntrypointTag.do_ => const TezosEntrypointDo(),
      TezosEntrypointTag.setDelegate => const TezosEntrypointSetDelegate(),
      TezosEntrypointTag.removeDelegate =>
        const TezosEntrypointRemoveDelegate(),
      TezosEntrypointTag.deposit => const TezosEntrypointDeposit(),
      TezosEntrypointTag.stake => const TezosEntrypointStake(),
      TezosEntrypointTag.unstake => const TezosEntrypointUnstake(),
      TezosEntrypointTag.finalizeUnstake =>
        const TezosEntrypointFinalizeUnstake(),
      TezosEntrypointTag.setDelegateParameters =>
        const TezosEntrypointSetDelegateParameters(),
      _ => TezosEntrypointNamed(name),
    };
  }
  static Layout<TezosEntrypoint> layout() => TaggedUnionLayout<TezosEntrypoint>(
    tagLayout: TezosLayoutUtils.tzUint8,
    tagFor: (ep) => ep.tag.value,
    cases: [
      UnionCase<TezosEntrypoint>(
        TezosEntrypointTag.default_.value,
        TezosEntrypointDefault.layout(),
      ),
      UnionCase<TezosEntrypoint>(
        TezosEntrypointTag.root.value,
        TezosEntrypointRoot.layout(),
      ),
      UnionCase<TezosEntrypoint>(
        TezosEntrypointTag.do_.value,
        TezosEntrypointDo.layout(),
      ),
      UnionCase<TezosEntrypoint>(
        TezosEntrypointTag.setDelegate.value,
        TezosEntrypointSetDelegate.layout(),
      ),
      UnionCase<TezosEntrypoint>(
        TezosEntrypointTag.removeDelegate.value,
        TezosEntrypointRemoveDelegate.layout(),
      ),
      UnionCase<TezosEntrypoint>(
        TezosEntrypointTag.deposit.value,
        TezosEntrypointDeposit.layout(),
      ),
      UnionCase<TezosEntrypoint>(
        TezosEntrypointTag.stake.value,
        TezosEntrypointStake.layout(),
      ),
      UnionCase<TezosEntrypoint>(
        TezosEntrypointTag.unstake.value,
        TezosEntrypointUnstake.layout(),
      ),
      UnionCase<TezosEntrypoint>(
        TezosEntrypointTag.finalizeUnstake.value,
        TezosEntrypointFinalizeUnstake.layout(),
      ),
      UnionCase<TezosEntrypoint>(
        TezosEntrypointTag.setDelegateParameters.value,
        TezosEntrypointSetDelegateParameters.layout(),
      ),
      UnionCase<TezosEntrypoint>(
        TezosEntrypointTag.name.value,
        TezosEntrypointNamed.layout(),
      ),
    ],
  );

  @override
  String toJson() {
    return name;
  }

  @override
  Layout<TezosEntrypoint> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [tag];
}

/// Reserved entrypoints (tag only, no extra payload).
final class TezosEntrypointDefault extends TezosEntrypoint {
  const TezosEntrypointDefault() : super(TezosEntrypointTag.default_);

  static Layout<TezosEntrypointDefault> layout() =>
      const EmptyLayout<TezosEntrypointDefault>(TezosEntrypointDefault());
}

final class TezosEntrypointRoot extends TezosEntrypoint {
  const TezosEntrypointRoot() : super(TezosEntrypointTag.root);

  static Layout<TezosEntrypointRoot> layout() =>
      const EmptyLayout<TezosEntrypointRoot>(TezosEntrypointRoot());
}

final class TezosEntrypointDo extends TezosEntrypoint {
  const TezosEntrypointDo() : super(TezosEntrypointTag.do_);

  static Layout<TezosEntrypointDo> layout() =>
      const EmptyLayout<TezosEntrypointDo>(TezosEntrypointDo());
}

final class TezosEntrypointSetDelegate extends TezosEntrypoint {
  const TezosEntrypointSetDelegate() : super(TezosEntrypointTag.setDelegate);

  static Layout<TezosEntrypointSetDelegate> layout() =>
      const EmptyLayout<TezosEntrypointSetDelegate>(
        TezosEntrypointSetDelegate(),
      );
}

final class TezosEntrypointRemoveDelegate extends TezosEntrypoint {
  const TezosEntrypointRemoveDelegate()
    : super(TezosEntrypointTag.removeDelegate);

  static Layout<TezosEntrypointRemoveDelegate> layout() =>
      const EmptyLayout<TezosEntrypointRemoveDelegate>(
        TezosEntrypointRemoveDelegate(),
      );
}

final class TezosEntrypointDeposit extends TezosEntrypoint {
  const TezosEntrypointDeposit() : super(TezosEntrypointTag.deposit);

  static Layout<TezosEntrypointDeposit> layout() =>
      const EmptyLayout<TezosEntrypointDeposit>(TezosEntrypointDeposit());
}

final class TezosEntrypointStake extends TezosEntrypoint {
  const TezosEntrypointStake() : super(TezosEntrypointTag.stake);

  static Layout<TezosEntrypointStake> layout() =>
      const EmptyLayout<TezosEntrypointStake>(TezosEntrypointStake());
}

final class TezosEntrypointUnstake extends TezosEntrypoint {
  const TezosEntrypointUnstake() : super(TezosEntrypointTag.unstake);

  static Layout<TezosEntrypointUnstake> layout() =>
      const EmptyLayout<TezosEntrypointUnstake>(TezosEntrypointUnstake());
}

final class TezosEntrypointFinalizeUnstake extends TezosEntrypoint {
  const TezosEntrypointFinalizeUnstake()
    : super(TezosEntrypointTag.finalizeUnstake);

  static Layout<TezosEntrypointFinalizeUnstake> layout() =>
      const EmptyLayout<TezosEntrypointFinalizeUnstake>(
        TezosEntrypointFinalizeUnstake(),
      );
}

final class TezosEntrypointSetDelegateParameters extends TezosEntrypoint {
  const TezosEntrypointSetDelegateParameters()
    : super(TezosEntrypointTag.setDelegateParameters);

  static Layout<TezosEntrypointSetDelegateParameters> layout() =>
      const EmptyLayout<TezosEntrypointSetDelegateParameters>(
        TezosEntrypointSetDelegateParameters(),
      );
}

/// Custom named entrypoint (`0xFF` followed by a length-prefixed UTF-8 name).
final class TezosEntrypointNamed extends TezosEntrypoint {
  const TezosEntrypointNamed(this.name) : super(TezosEntrypointTag.name);

  @override
  final String name;

  static Layout<TezosEntrypointNamed> layout() =>
      ObjSeqLayout<TezosEntrypointNamed>(
        [
          ConvLayout<String, List<int>>(
            DynamicBytesLayout(discriminator: LayoutConst.u8()),
            toWire: (s) => StringUtils.encode(s),
            fromWire: (b) => StringUtils.decode(b),
          ),
        ],
        build: (values) => TezosEntrypointNamed(values[0] as String),
        unbuild: (value) => [value.name],
      );

  @override
  List<dynamic> get variables => [tag, name];
}

class TezosContractParameters extends OctezSerializable<TezosContractParameters>
    with Equality {
  final TezosEntrypoint entrypoint;
  final MichelineExpr? value;
  TezosContractParameters({required this.entrypoint, required this.value});
  factory TezosContractParameters.deserializeJson(Map<String, dynamic> json) {
    return TezosContractParameters(
      entrypoint: TezosEntrypoint.deserializeJson(
        json.valueAsString("entrypoint"),
      ),
      value: json.valueTo<MichelineExpr?, Object>(
        key: "value",
        parse: MichelineExpr.deserializeJson,
      ),
    );
  }
  factory TezosContractParameters.deserialize(List<int> bytes) {
    return layout().deserialize(bytes).value;
  }

  bool isDefault() =>
      entrypoint == const TezosEntrypointDefault() &&
      (value == null || value == const MichelinePrimNoArgsNoAnnots.unit());

  @override
  Map<String, dynamic> toJson() {
    final MichelineExpr expr = (value ?? MichelineUtils.unit());
    return {"entrypoint": entrypoint.name, "value": expr.toJson()};
  }

  static Layout<TezosContractParameters> layout() {
    return ObjSeqLayout<TezosContractParameters>(
      [TezosEntrypoint.layout(), const DynamicBytesLayout()],
      build: (values) {
        final List<int>? valueBytes = values.elementAtOrNull(1);
        return TezosContractParameters(
          entrypoint: values[0] as TezosEntrypoint,
          value:
              valueBytes == null ? null : MichelineExpr.deserialize(valueBytes),
        );
      },
      unbuild: (v) {
        return [
          v.entrypoint,
          (v.value ?? MichelineUtils.unit()).serializeBytes(),
        ];
      },
    );
  }

  @override
  List<int> serializeBytes() {
    if (isDefault()) return [];
    return super.serializeBytes();
  }

  @override
  Layout<TezosContractParameters> toLayot() {
    return layout();
  }

  @override
  List<dynamic> get variables => [entrypoint, value];
}
