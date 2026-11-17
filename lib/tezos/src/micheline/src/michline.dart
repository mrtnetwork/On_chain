import 'package:blockchain_utils/helper/helper.dart';

import 'package:blockchain_utils/encoding/encoding.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/tezos/src/micheline/src/utils.dart';
import 'package:on_chain/tezos/src/micheline/src/primitives.dart';
import 'package:on_chain/tezos/src/operations/layouts/utils.dart';
import 'package:on_chain/tezos/src/serialization/serialization.dart';

sealed class MichelineExpr extends OctezSerializable<MichelineExpr>
    with Equality {
  const MichelineExpr();

  /// Binary decode (`025-PsUshuai.script.expr`).
  factory MichelineExpr.deserialize(List<int> bytes) =>
      layout().deserialize(bytes).value;

  /// JSON decode. Accepts Octez-codec / RPC Micheline JSON.
  ///
  /// - int:    `{"int": "42"}`
  /// - string: `{"string": "hello"}`
  /// - bytes:  `{"bytes": "deadbeef"}`  (hex)
  /// - seq:    `[ ... ]`
  /// - prim:   `{"prim": <int|name>, "args"?: [...], "annots"?: [...]}`
  ///
  factory MichelineExpr.deserializeJson(dynamic json) {
    if (json is List) {
      return MichelineSequence(
        json.map((e) => MichelineExpr.deserializeJson(e)).toList(),
      );
    }
    if (json is! Map) {
      throw OnChainErrors.tezosMicheline(
        "MichelineExpr.deserializeJson",
        reason: "Unknown MichelineExpr JSON.",
        details: {"type": "${json.runtimeType}"},
      );
    }
    if (json.hasValue('int')) {
      return MichelineInt(json.valueAsBigInt("int"));
    }
    if (json.hasValue('string')) {
      return MichelineString(json.valueAsString("string"));
    }
    if (json.hasValue('bytes')) {
      return MichelineBytes(json.valueAsBytes("bytes", allowHex: true));
    }
    if (json.hasValue('prim')) {
      final prim = MichelsonPrimitives.from(json.valueAs<Object?>("prim"));
      final args =
          json
              .valueEnsureAsList("args", onMissing: () => [])
              .map(MichelineExpr.deserializeJson)
              .toList();
      final List<String> annots = json.valueEnsureAsList<String>(
        "annots",
        onMissing: () => [],
      );
      final hasAnnots = annots.isNotEmpty;
      switch (args.length) {
        case 0:
          return hasAnnots
              ? MichelinePrimNoArgsSomeAnnots(prim, annots)
              : MichelinePrimNoArgsNoAnnots(prim);
        case 1:
          return hasAnnots
              ? MichelinePrim1ArgSomeAnnots(prim, args[0], annots)
              : MichelinePrim1ArgNoAnnots(prim, args[0]);
        case 2:
          return hasAnnots
              ? MichelinePrim2ArgsSomeAnnots(prim, args[0], args[1], annots)
              : MichelinePrim2ArgsNoAnnots(prim, args[0], args[1]);
        default:
          return MichelinePrimGeneric(prim, args, annots);
      }
    }
    throw OnChainErrors.tezosMicheline(
      "MichelineExpr.deserializeJson",
      reason: "Unknown MichelineExpr JSON.",
      details: {"type": "${json.runtimeType}"},
    );
  }

  static TaggedUnionLayout<MichelineExpr>
  layout() => TaggedUnionLayout<MichelineExpr>(
    tagLayout: TezosLayoutUtils.tzUint8,
    tagFor:
        (e) => switch (e) {
          MichelineInt _ => 0,
          MichelineString _ => 1,
          MichelineSequence _ => 2,
          MichelinePrimNoArgsNoAnnots _ => 3,
          MichelinePrimNoArgsSomeAnnots _ => 4,
          MichelinePrim1ArgNoAnnots _ => 5,
          MichelinePrim1ArgSomeAnnots _ => 6,
          MichelinePrim2ArgsNoAnnots _ => 7,
          MichelinePrim2ArgsSomeAnnots _ => 8,
          MichelinePrimGeneric _ => 9,
          MichelineBytes _ => 10,
        },
    cases: [
      // 0 Int — Zarith
      UnionCase<MichelineExpr>(
        0,
        ConvLayout<MichelineInt, BigInt>(
          TezosLayoutUtils.tzZ,
          toWire: (e) => e.value,
          fromWire: MichelineInt.new,
        ),
      ),
      // 1 String — uint30 + UTF-8 bytes (not Dart codeUnits)
      UnionCase<MichelineExpr>(
        1,
        ConvLayout<MichelineString, List<int>>(
          const DynamicBytesLayout(),
          toWire: (e) => StringUtils.encode(e.value),
          fromWire: (b) => MichelineString(StringUtils.decode(b)),
        ),
      ),
      // 2 Sequence — uint30 + concatenated exprs
      UnionCase<MichelineExpr>(
        2,
        ObjSeqLayout<MichelineSequence>(
          [DynamicSizeLayout(RemainderListLayout(MichelineUtils.layout()))],
          build: (v) => MichelineSequence((v[0] as List).cast<MichelineExpr>()),
          unbuild: (v) => [v.items],
        ),
      ),
      // 3 Prim 0 args, no annots
      UnionCase<MichelineExpr>(
        3,
        ObjSeqLayout<MichelinePrimNoArgsNoAnnots>(
          [TezosLayoutUtils.tzUint8],
          build:
              (v) =>
                  MichelinePrimNoArgsNoAnnots(MichelsonPrimitives.nameOf(v[0])),
          unbuild: (v) => [MichelsonPrimitives.tagOf(v.prim)],
        ),
      ),
      // 4 Prim 0 args + annots
      UnionCase<MichelineExpr>(
        4,
        ObjSeqLayout<MichelinePrimNoArgsSomeAnnots>(
          [TezosLayoutUtils.tzUint8, MichelineUtils.annotslayout()],
          build:
              (v) => MichelinePrimNoArgsSomeAnnots(
                MichelsonPrimitives.nameOf(v[0]),
                (v[1] as List).cast<String>(),
              ),
          unbuild: (v) => [MichelsonPrimitives.tagOf(v.prim), v.annots],
        ),
      ),
      // 5 Prim 1 arg, no annots
      UnionCase<MichelineExpr>(
        5,
        ObjSeqLayout<MichelinePrim1ArgNoAnnots>(
          [TezosLayoutUtils.tzUint8, MichelineUtils.layout()],
          build:
              (v) => MichelinePrim1ArgNoAnnots(
                MichelsonPrimitives.nameOf(v[0]),
                v[1] as MichelineExpr,
              ),
          unbuild: (v) => [MichelsonPrimitives.tagOf(v.prim), v.arg],
        ),
      ),
      // 6 Prim 1 arg + annots
      UnionCase<MichelineExpr>(
        6,
        ObjSeqLayout<MichelinePrim1ArgSomeAnnots>(
          [
            TezosLayoutUtils.tzUint8,
            MichelineUtils.layout(),
            MichelineUtils.annotslayout(),
          ],
          build:
              (v) => MichelinePrim1ArgSomeAnnots(
                MichelsonPrimitives.nameOf(v[0]),
                v[1] as MichelineExpr,
                (v[2] as List).cast<String>(),
              ),
          unbuild: (v) => [MichelsonPrimitives.tagOf(v.prim), v.arg, v.annots],
        ),
      ),
      // 7 Prim 2 args, no annots
      UnionCase<MichelineExpr>(
        7,
        ObjSeqLayout<MichelinePrim2ArgsNoAnnots>(
          [
            TezosLayoutUtils.tzUint8,
            MichelineUtils.layout(),
            MichelineUtils.layout(),
          ],
          build:
              (v) => MichelinePrim2ArgsNoAnnots(
                MichelsonPrimitives.nameOf(v[0]),
                v[1] as MichelineExpr,
                v[2] as MichelineExpr,
              ),
          unbuild: (v) => [MichelsonPrimitives.tagOf(v.prim), v.arg1, v.arg2],
        ),
      ),
      // 8 Prim 2 args + annots
      UnionCase<MichelineExpr>(
        8,
        ObjSeqLayout<MichelinePrim2ArgsSomeAnnots>(
          [
            TezosLayoutUtils.tzUint8,
            MichelineUtils.layout(),
            MichelineUtils.layout(),
            MichelineUtils.annotslayout(),
          ],
          build:
              (v) => MichelinePrim2ArgsSomeAnnots(
                MichelsonPrimitives.nameOf(v[0]),
                v[1] as MichelineExpr,
                v[2] as MichelineExpr,
                (v[3] as List).cast<String>(),
              ),
          unbuild:
              (v) => [
                MichelsonPrimitives.tagOf(v.prim),
                v.arg1,
                v.arg2,
                v.annots,
              ],
        ),
      ),
      // 9 Prim generic
      UnionCase<MichelineExpr>(
        9,
        ObjSeqLayout<MichelinePrimGeneric>(
          [
            TezosLayoutUtils.tzUint8,
            DynamicSizeLayout(RemainderListLayout(MichelineUtils.layout())),
            MichelineUtils.annotslayout(),
          ],
          build:
              (v) => MichelinePrimGeneric(
                MichelsonPrimitives.nameOf(v[0]),
                (v[1] as List).cast<MichelineExpr>(),
                (v[2] as List).cast<String>(),
              ),
          unbuild: (v) => [MichelsonPrimitives.tagOf(v.prim), v.args, v.annots],
        ),
      ),
      // 10 Bytes
      UnionCase<MichelineExpr>(
        10,
        ConvLayout<MichelineBytes, List<int>>(
          const DynamicBytesLayout(),
          toWire: (e) => e.value,
          fromWire: MichelineBytes.new,
        ),
      ),
    ],
  );

  @override
  Layout<MichelineExpr> toLayot() => layout();
}

// ----- 0 Int ---------------------------------------------------------------

class MichelineInt extends MichelineExpr {
  final BigInt value;

  const MichelineInt(this.value);

  factory MichelineInt.deserialize(List<int> bytes) =>
      MichelineExpr.deserialize(bytes) as MichelineInt;

  factory MichelineInt.deserializeJson(Map<String, dynamic> json) =>
      MichelineInt(json.valueAsBigInt("int"));

  @override
  Map<String, dynamic> toJson() => {'int': value.toString()};

  @override
  List<dynamic> get variables => [value];
}

// ----- 1 String ------------------------------------------------------------

class MichelineString extends MichelineExpr {
  final String value;

  const MichelineString(this.value);

  factory MichelineString.deserialize(List<int> bytes) =>
      MichelineExpr.deserialize(bytes) as MichelineString;

  factory MichelineString.deserializeJson(Map<String, dynamic> json) =>
      MichelineString(json.valueAsString("string"));

  @override
  Map<String, dynamic> toJson() => {'string': value};

  @override
  List<dynamic> get variables => [value];
}

// ----- 2 Sequence ----------------------------------------------------------

class MichelineSequence extends MichelineExpr {
  final List<MichelineExpr> items;

  const MichelineSequence(this.items);

  factory MichelineSequence.deserialize(List<int> bytes) =>
      MichelineExpr.deserialize(bytes) as MichelineSequence;

  factory MichelineSequence.deserializeJson(List<dynamic> json) =>
      MichelineSequence(json.map(MichelineExpr.deserializeJson).toList());

  @override
  List<dynamic> toJson() => items.map((e) => e.toJson()).toList();

  @override
  List<dynamic> get variables => [items];
}

// ----- 3 Prim 0 args, no annots --------------------------------------------

sealed class MichelinePrim extends MichelineExpr {
  String get prim;
  List<String> get annots => [];
  List<MichelineExpr> get args => [];
  const MichelinePrim();
}

class MichelinePrimNoArgsNoAnnots extends MichelinePrim {
  @override
  final String prim;
  const MichelinePrimNoArgsNoAnnots.unit() : prim = "Unit";

  MichelinePrimNoArgsNoAnnots(String prim)
    : prim = MichelsonPrimitives.ensureIsValidPrimitives(prim);

  factory MichelinePrimNoArgsNoAnnots.deserialize(List<int> bytes) =>
      MichelineExpr.deserialize(bytes) as MichelinePrimNoArgsNoAnnots;

  @override
  Map<String, dynamic> toJson() => {'prim': prim};

  @override
  List<dynamic> get variables => [prim];
}

// ----- 4 Prim 0 args + annots ----------------------------------------------

class MichelinePrimNoArgsSomeAnnots extends MichelinePrim {
  @override
  final String prim;
  @override
  final List<String> annots;

  MichelinePrimNoArgsSomeAnnots(String prim, this.annots)
    : prim = MichelsonPrimitives.ensureIsValidPrimitives(prim);

  factory MichelinePrimNoArgsSomeAnnots.deserialize(List<int> bytes) =>
      MichelineExpr.deserialize(bytes) as MichelinePrimNoArgsSomeAnnots;

  @override
  Map<String, dynamic> toJson() => {'prim': prim, 'annots': annots};

  @override
  List<dynamic> get variables => [prim, annots];
}

// ----- 5 Prim 1 arg, no annots ---------------------------------------------

class MichelinePrim1ArgNoAnnots extends MichelinePrim {
  @override
  final String prim;
  final MichelineExpr arg;

  MichelinePrim1ArgNoAnnots(String prim, this.arg)
    : prim = MichelsonPrimitives.ensureIsValidPrimitives(prim);

  factory MichelinePrim1ArgNoAnnots.deserialize(List<int> bytes) =>
      MichelineExpr.deserialize(bytes) as MichelinePrim1ArgNoAnnots;

  @override
  Map<String, dynamic> toJson() => {
    'prim': prim,
    'args': [arg.toJson()],
  };

  @override
  List<dynamic> get variables => [prim, arg];
  @override
  List<MichelineExpr> get args => [arg];
}

// ----- 6 Prim 1 arg + annots -----------------------------------------------

class MichelinePrim1ArgSomeAnnots extends MichelinePrim {
  @override
  final String prim;
  final MichelineExpr arg;
  @override
  final List<String> annots;

  MichelinePrim1ArgSomeAnnots(String prim, this.arg, this.annots)
    : prim = MichelsonPrimitives.ensureIsValidPrimitives(prim);

  factory MichelinePrim1ArgSomeAnnots.deserialize(List<int> bytes) =>
      MichelineExpr.deserialize(bytes) as MichelinePrim1ArgSomeAnnots;

  @override
  Map<String, dynamic> toJson() => {
    'prim': prim,
    'args': [arg.toJson()],
    'annots': annots,
  };

  @override
  List<dynamic> get variables => [prim, arg, annots];

  @override
  List<MichelineExpr> get args => [arg];
}

// ----- 7 Prim 2 args, no annots --------------------------------------------

class MichelinePrim2ArgsNoAnnots extends MichelinePrim {
  @override
  final String prim;
  final MichelineExpr arg1;
  final MichelineExpr arg2;

  MichelinePrim2ArgsNoAnnots(String prim, this.arg1, this.arg2)
    : prim = MichelsonPrimitives.ensureIsValidPrimitives(prim);

  factory MichelinePrim2ArgsNoAnnots.deserialize(List<int> bytes) =>
      MichelineExpr.deserialize(bytes) as MichelinePrim2ArgsNoAnnots;

  @override
  Map<String, dynamic> toJson() => {
    'prim': prim,
    'args': [arg1.toJson(), arg2.toJson()],
  };

  @override
  List<dynamic> get variables => [prim, arg1, arg2];

  @override
  List<MichelineExpr> get args => [arg1, arg2];
}

// ----- 8 Prim 2 args + annots ----------------------------------------------

class MichelinePrim2ArgsSomeAnnots extends MichelinePrim {
  @override
  final String prim;
  final MichelineExpr arg1;
  final MichelineExpr arg2;
  @override
  final List<String> annots;

  MichelinePrim2ArgsSomeAnnots(String prim, this.arg1, this.arg2, this.annots)
    : prim = MichelsonPrimitives.ensureIsValidPrimitives(prim);

  factory MichelinePrim2ArgsSomeAnnots.deserialize(List<int> bytes) =>
      MichelineExpr.deserialize(bytes) as MichelinePrim2ArgsSomeAnnots;

  @override
  Map<String, dynamic> toJson() => {
    'prim': prim,
    'args': [arg1.toJson(), arg2.toJson()],
    'annots': annots,
  };

  @override
  List<dynamic> get variables => [prim, arg1, arg2, annots];

  @override
  List<MichelineExpr> get args => [arg1, arg2];
}

// ----- 9 Prim generic (n≠0,1,2 args and/or leftover cases) -----------------

class MichelinePrimGeneric extends MichelinePrim {
  @override
  final String prim;
  @override
  final List<MichelineExpr> args;
  @override
  final List<String> annots;

  MichelinePrimGeneric(String prim, this.args, this.annots)
    : prim = MichelsonPrimitives.ensureIsValidPrimitives(prim);

  factory MichelinePrimGeneric.deserialize(List<int> bytes) =>
      MichelineExpr.deserialize(bytes) as MichelinePrimGeneric;

  @override
  Map<String, dynamic> toJson() {
    final m = <String, dynamic>{
      'prim': prim,
      'args': args.map((e) => e.toJson()).toList(),
    };
    if (annots.isNotEmpty) m['annots'] = annots;
    return m;
  }

  @override
  List<dynamic> get variables => [prim, args, annots];
}

// ----- 10 Bytes ------------------------------------------------------------

class MichelineBytes extends MichelineExpr {
  final List<int> value;

  MichelineBytes(List<int> value) : value = value.asImmutableBytes;

  factory MichelineBytes.deserialize(List<int> bytes) =>
      MichelineExpr.deserialize(bytes) as MichelineBytes;

  factory MichelineBytes.deserializeJson(Map<String, dynamic> json) {
    return MichelineBytes(json.valueAsBytes("bytes", allowHex: true));
  }

  @override
  Map<String, dynamic> toJson() => {'bytes': BytesUtils.toHexString(value)};

  @override
  List<dynamic> get variables => [value];
}
