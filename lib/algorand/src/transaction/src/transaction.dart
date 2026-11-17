import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/algorand/src/address/address.dart';
import 'package:on_chain/algorand/src/utils/layout_utils.dart';
import 'package:on_chain/algorand/src/utils/utils.dart';

import 'fields.dart';

class HashFactory with LayoutSerializable, Equality {
  final BigInt hashType; // t

  const HashFactory({required this.hashType});

  factory HashFactory.deserializeJson(Map<String, dynamic> json) {
    return HashFactory(
      hashType: json.valueAsBigInt("t", onMissing: () => BigInt.zero),
    );
  }

  static MsgPackFixedKeyDynamicLazyValueMapLayout<
    String,
    dynamic,
    LayoutRepository
  >
  layout({String? property}) {
    return MsgPackFixedKeyDynamicLazyValueMapLayout<
      String,
      dynamic,
      LayoutRepository
    >(
      keyLayout: MsgPackStringLayout(),
      sortKeys: true,
      valueLayouts: [
        MapEntry(
          "t",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.defaultU64Layout,
          ),
        ),
      ],
      property: property,
    );
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) =>
      layout(property: property);

  @override
  Map<String, dynamic> toSerializeJson() {
    return {"t": hashType}.notNullValue;
  }

  @override
  List<dynamic> get variables => [hashType];
}

class MerkleArrayProof with LayoutSerializable, Equality {
  final List<BuBytes> path; // pth
  final HashFactory hashFactory; // hsh
  final BigInt treeDepth; // td

  MerkleArrayProof({
    required List<List<int>> path,
    required this.hashFactory,
    required this.treeDepth,
  }) : path = path.map((e) => e.asImmutableBytes).toList().immutable;

  factory MerkleArrayProof.deserializeJson(Map<String, dynamic> json) {
    return MerkleArrayProof(
      path:
          json
              .valueEnsureAsList<List>("pth", onMissing: () => [])
              .map(
                (e) => JsonParser.valueAsBytes<List<int>>(
                  e,
                  encoding: StringEncoding.base64,
                ),
              )
              .toList(),
      hashFactory: json.valueTo<HashFactory, Map<String, dynamic>>(
        key: "hsh",
        onMissing: () => HashFactory(hashType: BigInt.zero),
        parse: HashFactory.deserializeJson,
      ),
      treeDepth: json.valueAsBigInt("td", onMissing: () => BigInt.zero),
    );
  }

  static MsgPackFixedKeyDynamicLazyValueMapLayout<
    String,
    dynamic,
    LayoutRepository
  >
  layout({String? property}) {
    return MsgPackFixedKeyDynamicLazyValueMapLayout<
      String,
      dynamic,
      LayoutRepository
    >(
      keyLayout: MsgPackStringLayout(),
      sortKeys: true,
      valueLayouts: [
        MapEntry(
          "pth",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoLayoutArray.defaultArrayOfBinaryLayout,
          ),
        ),
        MapEntry(
          "hsh",
          LazyMsgPackMapLayoutBuilder(
            layout: (property, _) => HashFactory.layout(property: property),
          ),
        ),
        MapEntry(
          "td",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.defaultU64Layout,
          ),
        ),
      ],
      property: property,
    );
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) =>
      layout(property: property);

  @override
  Map<String, dynamic> toSerializeJson() {
    return {
      "pth": path,
      "hsh": hashFactory.toSerializeJson(),
      "td": treeDepth,
    }.notNullValue;
  }

  @override
  List<dynamic> get variables => [path, hashFactory, treeDepth];
}

class MerkleSignatureVerifier with LayoutSerializable, Equality {
  final BuBytes commitment; // cmt (64)
  final BigInt keyLifetime; // lf

  MerkleSignatureVerifier({
    required List<int> commitment,
    required this.keyLifetime,
  }) : commitment =
           commitment
               .exc(
                 length: CryptoSignerConst.ed25519SignatureLength,
                 operation: "Invalid commitment bytes length.",
               )
               .asImmutableBytes;

  factory MerkleSignatureVerifier.deserializeJson(Map<String, dynamic> json) {
    return MerkleSignatureVerifier(
      commitment: json.valueAsBytes(
        "cmt",
        onMissing: () => List<int>.filled(64, 0),
        encoding: StringEncoding.base64,
      ),
      keyLifetime: json.valueAsBigInt("lf", onMissing: () => BigInt.zero),
    );
  }

  static MsgPackFixedKeyDynamicLazyValueMapLayout<
    String,
    dynamic,
    LayoutRepository
  >
  layout({String? property}) {
    return MsgPackFixedKeyDynamicLazyValueMapLayout<
      String,
      dynamic,
      LayoutRepository
    >(
      keyLayout: MsgPackStringLayout(),
      sortKeys: true,
      valueLayouts: [
        MapEntry(
          "cmt",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.defaultBinary64Layout,
          ),
        ),
        MapEntry(
          "lf",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.defaultU64Layout,
          ),
        ),
      ],
      property: property,
    );
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) =>
      layout(property: property);

  @override
  Map<String, dynamic> toSerializeJson() {
    return {"cmt": commitment, "lf": keyLifetime}.notNullValue;
  }

  @override
  List<dynamic> get variables => [commitment, keyLifetime];
}

class Participant with LayoutSerializable, Equality {
  final MerkleSignatureVerifier pk; // p
  final BigInt weight; // w

  const Participant({required this.pk, required this.weight});

  factory Participant.deserializeJson(Map<String, dynamic> json) {
    return Participant(
      pk: json.valueTo<MerkleSignatureVerifier, Map<String, dynamic>>(
        key: "p",
        onMissing:
            () => MerkleSignatureVerifier(
              commitment: List<int>.filled(64, 0),
              keyLifetime: BigInt.zero,
            ),
        parse: MerkleSignatureVerifier.deserializeJson,
      ),
      weight: json.valueAsBigInt("w", onMissing: () => BigInt.zero),
    );
  }

  static MsgPackFixedKeyDynamicLazyValueMapLayout<
    String,
    dynamic,
    LayoutRepository
  >
  layout({String? property}) {
    return MsgPackFixedKeyDynamicLazyValueMapLayout<
      String,
      dynamic,
      LayoutRepository
    >(
      keyLayout: MsgPackStringLayout(),
      sortKeys: true,
      valueLayouts: [
        MapEntry(
          "p",
          LazyMsgPackMapLayoutBuilder(
            layout:
                (property, _) =>
                    MerkleSignatureVerifier.layout(property: property),
          ),
        ),
        MapEntry(
          "w",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.defaultU64Layout,
          ),
        ),
      ],
      property: property,
    );
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) =>
      layout(property: property);

  @override
  Map<String, dynamic> toSerializeJson() {
    return {"p": pk.toSerializeJson(), "w": weight}.notNullValue;
  }

  @override
  List<dynamic> get variables => [pk, weight];
}

class FalconVerifier with LayoutSerializable, Equality {
  final BuBytes publicKey; // k (0x701 bytes)

  FalconVerifier({required List<int> publicKey})
    : publicKey =
          publicKey
              .exc(length: 0x701, operation: "Invalid publicKey bytes length.")
              .asImmutableBytes;

  factory FalconVerifier.deserializeJson(Map<String, dynamic> json) {
    return FalconVerifier(
      publicKey: json.valueAsBytes(
        "k",
        onMissing: () => List<int>.filled(0x701, 0),
        encoding: StringEncoding.base64,
      ),
    );
  }

  static MsgPackFixedKeyDynamicLazyValueMapLayout<
    String,
    dynamic,
    LayoutRepository
  >
  layout({String? property}) {
    return MsgPackFixedKeyDynamicLazyValueMapLayout<
      String,
      dynamic,
      LayoutRepository
    >(
      keyLayout: MsgPackStringLayout(),
      sortKeys: true,
      valueLayouts: [
        MapEntry(
          "k",
          LazyMsgPackMapLayoutBuilder(
            layout:
                (property, params) => AlgoBinaryLayout.defaultBinaryLayout(
                  property,
                  params,
                  length: 0x701,
                ),
          ),
        ),
      ],
      property: property,
    );
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) =>
      layout(property: property);

  @override
  Map<String, dynamic> toSerializeJson() {
    return {"k": publicKey}.notNullValue;
  }

  @override
  List<dynamic> get variables => [publicKey];
}

class FalconSignatureStruct with LayoutSerializable, Equality {
  final BuBytes signature; // sig
  final BigInt vectorCommitmentIndex; // idx
  final MerkleArrayProof proof; // prf
  final FalconVerifier verifyingKey; // vkey

  FalconSignatureStruct({
    required List<int> signature,
    required this.vectorCommitmentIndex,
    required this.proof,
    required this.verifyingKey,
  }) : signature = signature.asImmutableBytes;

  factory FalconSignatureStruct.deserializeJson(Map<String, dynamic> json) {
    return FalconSignatureStruct(
      signature: json.valueAsBytes(
        "sig",
        onMissing: () => <int>[],
        encoding: StringEncoding.base64,
      ),
      vectorCommitmentIndex: json.valueAsBigInt(
        "idx",
        onMissing: () => BigInt.zero,
      ),
      proof: json.valueTo<MerkleArrayProof, Map<String, dynamic>>(
        key: "prf",
        onMissing:
            () => MerkleArrayProof(
              path: [],
              hashFactory: HashFactory(hashType: BigInt.zero),
              treeDepth: BigInt.zero,
            ),
        parse: MerkleArrayProof.deserializeJson,
      ),
      verifyingKey: json.valueTo<FalconVerifier, Map<String, dynamic>>(
        key: "vkey",
        onMissing: () => FalconVerifier(publicKey: List<int>.filled(0x701, 0)),
        parse: FalconVerifier.deserializeJson,
      ),
    );
  }

  static MsgPackFixedKeyDynamicLazyValueMapLayout<
    String,
    dynamic,
    LayoutRepository
  >
  layout({String? property}) {
    return MsgPackFixedKeyDynamicLazyValueMapLayout<
      String,
      dynamic,
      LayoutRepository
    >(
      keyLayout: MsgPackStringLayout(),
      sortKeys: true,
      valueLayouts: [
        MapEntry(
          "sig",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.defaultBinaryLayout,
          ),
        ),
        MapEntry(
          "idx",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.defaultU64Layout,
          ),
        ),
        MapEntry(
          "prf",
          LazyMsgPackMapLayoutBuilder(
            layout:
                (property, _) => MerkleArrayProof.layout(property: property),
          ),
        ),
        MapEntry(
          "vkey",
          LazyMsgPackMapLayoutBuilder(
            layout: (property, _) => FalconVerifier.layout(property: property),
          ),
        ),
      ],
      property: property,
    );
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) =>
      layout(property: property);

  @override
  Map<String, dynamic> toSerializeJson() {
    return {
      "sig": signature,
      "idx": vectorCommitmentIndex,
      "prf": proof.toSerializeJson(),
      "vkey": verifyingKey.toSerializeJson(),
    }.notNullValue;
  }

  @override
  List<dynamic> get variables => [
    signature,
    vectorCommitmentIndex,
    proof,
    verifyingKey,
  ];
}

class SigslotCommit with LayoutSerializable, Equality {
  final FalconSignatureStruct sig; // s
  final BigInt l; // l

  const SigslotCommit({required this.sig, required this.l});

  factory SigslotCommit.deserializeJson(Map<String, dynamic> json) {
    return SigslotCommit(
      sig: json.valueTo<FalconSignatureStruct, Map<String, dynamic>>(
        key: "s",
        onMissing:
            () => FalconSignatureStruct(
              signature: <int>[],
              vectorCommitmentIndex: BigInt.zero,
              proof: MerkleArrayProof(
                path: [],
                hashFactory: HashFactory(hashType: BigInt.zero),
                treeDepth: BigInt.zero,
              ),
              verifyingKey: FalconVerifier(
                publicKey: List<int>.filled(0x701, 0),
              ),
            ),
        parse: FalconSignatureStruct.deserializeJson,
      ),
      l: json.valueAsBigInt("l", onMissing: () => BigInt.zero),
    );
  }

  static MsgPackFixedKeyDynamicLazyValueMapLayout<
    String,
    dynamic,
    LayoutRepository
  >
  layout({String? property}) {
    return MsgPackFixedKeyDynamicLazyValueMapLayout<
      String,
      dynamic,
      LayoutRepository
    >(
      keyLayout: MsgPackStringLayout(),
      sortKeys: true,
      valueLayouts: [
        MapEntry(
          "s",
          LazyMsgPackMapLayoutBuilder(
            layout:
                (property, _) =>
                    FalconSignatureStruct.layout(property: property),
          ),
        ),
        MapEntry(
          "l",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.defaultU64Layout,
          ),
        ),
      ],
      property: property,
    );
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) =>
      layout(property: property);

  @override
  Map<String, dynamic> toSerializeJson() {
    return {"s": sig.toSerializeJson(), "l": l}.notNullValue;
  }

  @override
  List<dynamic> get variables => [sig, l];
}

class Reveal with LayoutSerializable, Equality {
  final SigslotCommit sigslot; // s
  final Participant participant; // p

  const Reveal({required this.sigslot, required this.participant});

  factory Reveal.deserializeJson(Map<String, dynamic> json) {
    return Reveal(
      sigslot: json.valueTo<SigslotCommit, Map<String, dynamic>>(
        key: "s",
        onMissing:
            () => SigslotCommit(
              sig: FalconSignatureStruct(
                signature: <int>[],
                vectorCommitmentIndex: BigInt.zero,
                proof: MerkleArrayProof(
                  path: [],
                  hashFactory: HashFactory(hashType: BigInt.zero),
                  treeDepth: BigInt.zero,
                ),
                verifyingKey: FalconVerifier(
                  publicKey: List<int>.filled(0x701, 0),
                ),
              ),
              l: BigInt.zero,
            ),
        parse: SigslotCommit.deserializeJson,
      ),
      participant: json.valueTo<Participant, Map<String, dynamic>>(
        key: "p",
        onMissing:
            () => Participant(
              pk: MerkleSignatureVerifier(
                commitment: List<int>.filled(64, 0),
                keyLifetime: BigInt.zero,
              ),
              weight: BigInt.zero,
            ),
        parse: Participant.deserializeJson,
      ),
    );
  }

  static MsgPackFixedKeyDynamicLazyValueMapLayout<
    String,
    dynamic,
    LayoutRepository
  >
  layout({String? property}) {
    return MsgPackFixedKeyDynamicLazyValueMapLayout<
      String,
      dynamic,
      LayoutRepository
    >(
      keyLayout: MsgPackStringLayout(),
      sortKeys: true,
      valueLayouts: [
        MapEntry(
          "s",
          LazyMsgPackMapLayoutBuilder(
            layout: (property, _) => SigslotCommit.layout(property: property),
          ),
        ),
        MapEntry(
          "p",
          LazyMsgPackMapLayoutBuilder(
            layout: (property, _) => Participant.layout(property: property),
          ),
        ),
      ],
      property: property,
    );
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) =>
      layout(property: property);

  @override
  Map<String, dynamic> toSerializeJson() {
    return {
      "s": sigslot.toSerializeJson(),
      "p": participant.toSerializeJson(),
    }.notNullValue;
  }

  @override
  List<dynamic> get variables => [sigslot, participant];
}

class StateProof with LayoutSerializable, Equality {
  final BuBytes sigCommit; // c
  final BigInt signedWeight; // w
  final MerkleArrayProof sigProofs; // S
  final MerkleArrayProof partProofs; // P
  final BigInt merkleSignatureSaltVersion; // v
  final Map<BigInt, Reveal> reveals; // r
  final List<BigInt> positionsToReveal; // pr

  StateProof({
    required List<int> sigCommit,
    required this.signedWeight,
    required this.sigProofs,
    required this.partProofs,
    required this.merkleSignatureSaltVersion,
    required Map<BigInt, Reveal> reveals,
    required List<BigInt> positionsToReveal,
  }) : sigCommit = sigCommit.asImmutableBytes,
       reveals = reveals.immutable,
       positionsToReveal = positionsToReveal.immutable;

  factory StateProof.deserializeJson(Map<String, dynamic> json) {
    final Map revealsRaw = json.valueAsMap(
      "r",
      onMissing: () => <dynamic, dynamic>{},
    );
    final reveals = <BigInt, Reveal>{};
    for (final entry in revealsRaw.entries) {
      reveals[JsonParser.valueAsBigInt<BigInt>(
        entry.key,
      )] = Reveal.deserializeJson(
        JsonParser.valueEnsureAsMap<String, dynamic>(entry.value),
      );
    }

    return StateProof(
      sigCommit: json.valueAsBytes(
        "c",
        onMissing: () => <int>[],
        encoding: StringEncoding.base64,
      ),
      signedWeight: json.valueAsBigInt("w", onMissing: () => BigInt.zero),
      sigProofs: json.valueTo<MerkleArrayProof, Map<String, dynamic>>(
        key: "S",
        onMissing:
            () => MerkleArrayProof(
              path: [],
              hashFactory: HashFactory(hashType: BigInt.zero),
              treeDepth: BigInt.zero,
            ),
        parse: MerkleArrayProof.deserializeJson,
      ),
      partProofs: json.valueTo<MerkleArrayProof, Map<String, dynamic>>(
        key: "P",
        onMissing:
            () => MerkleArrayProof(
              path: [],
              hashFactory: HashFactory(hashType: BigInt.zero),
              treeDepth: BigInt.zero,
            ),
        parse: MerkleArrayProof.deserializeJson,
      ),
      merkleSignatureSaltVersion: json.valueAsBigInt(
        "v",
        onMissing: () => BigInt.zero,
      ),
      reveals: reveals,
      positionsToReveal: json.valueAsList<List<BigInt>>(
        "pr",
        onMissing: () => [],
      ),
    );
  }

  static MsgPackFixedKeyDynamicLazyValueMapLayout<
    String,
    dynamic,
    LayoutRepository
  >
  layout({String? property}) {
    return MsgPackFixedKeyDynamicLazyValueMapLayout<
      String,
      dynamic,
      LayoutRepository
    >(
      keyLayout: MsgPackStringLayout(),
      sortKeys: true,
      valueLayouts: [
        MapEntry(
          "c",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.defaultBinaryLayout,
          ),
        ),
        MapEntry(
          "w",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.defaultU64Layout,
          ),
        ),
        MapEntry(
          "S",
          LazyMsgPackMapLayoutBuilder(
            layout:
                (property, _) => MerkleArrayProof.layout(property: property),
          ),
        ),
        MapEntry(
          "P",
          LazyMsgPackMapLayoutBuilder(
            layout:
                (property, _) => MerkleArrayProof.layout(property: property),
          ),
        ),
        MapEntry(
          "v",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.defaultU64Layout,
          ),
        ),
        MapEntry(
          "r",
          LazyMsgPackMapLayoutBuilder<String, dynamic, LayoutRepository>(
            layout:
                (property, _) => MsgPackFixedKeyFixedLazyValueMapLayout<
                  BigInt,
                  dynamic,
                  LayoutRepository
                >(
                  sortKeys: true,
                  keyLayout: MsgPackBigIntLayout(validator: LayoutConst.u64()),
                  valueLayout: LazyMsgPackMapLayoutBuilder(
                    layout:
                        (property, params) => Reveal.layout(property: property),
                    property: property,
                  ),
                ),
          ),
        ),
        MapEntry(
          "pr",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoLayoutArray.defaultArrayOfU64Layout,
          ),
        ),
      ],
      property: property,
    );
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) =>
      layout(property: property);

  @override
  Map<String, dynamic> toSerializeJson() {
    return {
      "c": sigCommit,
      "w": signedWeight,
      "S": sigProofs.toSerializeJson(),
      "P": partProofs.toSerializeJson(),
      "v": merkleSignatureSaltVersion,
      "r": {for (final e in reveals.entries) e.key: e.value.toSerializeJson()},
      "pr": positionsToReveal,
    }.notNullValue;
  }

  @override
  List<dynamic> get variables => [
    sigCommit,
    signedWeight,
    sigProofs,
    partProofs,
    merkleSignatureSaltVersion,
    reveals,
    positionsToReveal,
  ];
}

class StateProofMessage with LayoutSerializable, Equality {
  final BuBytes blockHeadersCommitment; // b
  final BuBytes votersCommitment; // v
  final BigInt lnProvenWeight; // p
  final BigInt firstAttestedRound; // f
  final BigInt lastAttestedRound; // l

  StateProofMessage({
    required List<int> blockHeadersCommitment,
    required List<int> votersCommitment,
    required this.lnProvenWeight,
    required this.firstAttestedRound,
    required this.lastAttestedRound,
  }) : blockHeadersCommitment = blockHeadersCommitment.asImmutableBytes,
       votersCommitment = votersCommitment.asImmutableBytes;

  factory StateProofMessage.deserializeJson(Map<String, dynamic> json) {
    return StateProofMessage(
      blockHeadersCommitment: json.valueAsBytes(
        "b",
        onMissing: () => <int>[],
        encoding: StringEncoding.base64,
      ),
      votersCommitment: json.valueAsBytes(
        "v",
        onMissing: () => <int>[],
        encoding: StringEncoding.base64,
      ),
      lnProvenWeight: json.valueAsBigInt("p", onMissing: () => BigInt.zero),
      firstAttestedRound: json.valueAsBigInt("f", onMissing: () => BigInt.zero),
      lastAttestedRound: json.valueAsBigInt("l", onMissing: () => BigInt.zero),
    );
  }

  static MsgPackFixedKeyDynamicLazyValueMapLayout<
    String,
    dynamic,
    LayoutRepository
  >
  layout({String? property}) {
    return MsgPackFixedKeyDynamicLazyValueMapLayout<
      String,
      dynamic,
      LayoutRepository
    >(
      keyLayout: MsgPackStringLayout(),
      sortKeys: true,
      valueLayouts: [
        MapEntry(
          "b",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.defaultBinaryLayout,
          ),
        ),
        MapEntry(
          "v",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.defaultBinaryLayout,
          ),
        ),
        MapEntry(
          "p",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.defaultU64Layout,
          ),
        ),
        MapEntry(
          "f",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.defaultU64Layout,
          ),
        ),
        MapEntry(
          "l",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.defaultU64Layout,
          ),
        ),
      ],
      property: property,
    );
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) =>
      layout(property: property);

  @override
  Map<String, dynamic> toSerializeJson() {
    return {
      "b": blockHeadersCommitment,
      "v": votersCommitment,
      "p": lnProvenWeight,
      "f": firstAttestedRound,
      "l": lastAttestedRound,
    }.notNullValue;
  }

  @override
  List<dynamic> get variables => [
    blockHeadersCommitment,
    votersCommitment,
    lnProvenWeight,
    firstAttestedRound,
    lastAttestedRound,
  ];
}

class AssetParams with LayoutSerializable, Equality {
  final BigInt? total; // t
  final BigInt? decimals; // dc
  final bool? defaultFrozen; // df
  final String? unitName; // un
  final String? assetName; // an
  final String? url; // au
  final BuBytes? metadataHash; // am (32)
  final AlgoAddress? manager; // m
  final AlgoAddress? reserve; // r
  final AlgoAddress? freeze; // f
  final AlgoAddress? clawback; // c

  AssetParams({
    this.total,
    this.decimals,
    this.defaultFrozen,
    this.unitName,
    this.assetName,
    this.url,
    List<int>? metadataHash,
    this.manager,
    this.reserve,
    this.freeze,
    this.clawback,
  }) : metadataHash =
           metadataHash
               ?.exc(
                 length: 32,
                 operation: "Invalid metadataHash bytes length.",
               )
               .asImmutableBytes;

  factory AssetParams.deserializeJson(Map<String, dynamic> json) {
    return AssetParams(
      total: json.valueAsBigInt("t"),
      decimals: json.valueAsBigInt("dc"),
      defaultFrozen: json.valueAsBool("df"),
      unitName: json.valueAsString("un"),
      assetName: json.valueAsString("an"),
      url: json.valueAsString("au"),
      metadataHash: json.valueAsBytes("am", encoding: StringEncoding.base64),
      manager: json.valueTo<AlgoAddress?, Object>(
        key: "m",
        parse: (e) => AlgoUtils.parseAddress(e),
      ),
      reserve: json.valueTo<AlgoAddress?, Object>(
        key: "r",
        parse: (e) => AlgoUtils.parseAddress(e),
      ),
      freeze: json.valueTo<AlgoAddress?, Object>(
        key: "f",
        parse: (e) => AlgoUtils.parseAddress(e),
      ),
      clawback: json.valueTo<AlgoAddress?, Object>(
        key: "c",
        parse: (e) => AlgoUtils.parseAddress(e),
      ),
    );
  }

  static MsgPackFixedKeyDynamicLazyValueMapLayout<
    String,
    dynamic,
    LayoutRepository
  >
  layout({String? property}) {
    return MsgPackFixedKeyDynamicLazyValueMapLayout<
      String,
      dynamic,
      LayoutRepository
    >(
      keyLayout: MsgPackStringLayout(),
      sortKeys: true,
      valueLayouts: [
        MapEntry(
          "t",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.optionalDefaultU64Layout,
          ),
        ),
        MapEntry(
          "dc",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.optionalDefaultU64Layout,
          ),
        ),
        MapEntry(
          "df",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBooleanLayout.optionalDefaultBooleanLayout,
          ),
        ),
        MapEntry(
          "un",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoStringLayout.optionalDefaultStringLayout,
          ),
        ),
        MapEntry(
          "an",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoStringLayout.optionalDefaultStringLayout,
          ),
        ),
        MapEntry(
          "au",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoStringLayout.optionalDefaultStringLayout,
          ),
        ),
        MapEntry(
          "am",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.optionalDefaultBinary32Layout,
          ),
        ),
        MapEntry(
          "m",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoAddressLayout.optionalDefaultAddressLayout,
          ),
        ),
        MapEntry(
          "r",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoAddressLayout.optionalDefaultAddressLayout,
          ),
        ),
        MapEntry(
          "f",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoAddressLayout.optionalDefaultAddressLayout,
          ),
        ),
        MapEntry(
          "c",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoAddressLayout.optionalDefaultAddressLayout,
          ),
        ),
      ],
      property: property,
    );
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) =>
      layout(property: property);

  @override
  Map<String, dynamic> toSerializeJson() {
    return {
      "t": total,
      "dc": decimals,
      "df": defaultFrozen,
      "un": unitName,
      "an": assetName,
      "au": url,
      "am": metadataHash,
      "m": manager?.toBytes(),
      "r": reserve?.toBytes(),
      "f": freeze?.toBytes(),
      "c": clawback?.toBytes(),
    }.notNullValue;
  }

  @override
  List<dynamic> get variables => [
    total,
    decimals,
    defaultFrozen,
    unitName,
    assetName,
    url,
    metadataHash,
    manager,
    reserve,
    freeze,
    clawback,
  ];
}

class StateSchema with LayoutSerializable, Equality {
  final BigInt? numUint; // nui
  final BigInt? numByteSlice; // nbs

  const StateSchema({this.numUint, this.numByteSlice});

  factory StateSchema.deserializeJson(Map<String, dynamic> json) {
    return StateSchema(
      numUint: json.valueAsBigInt("nui"),
      numByteSlice: json.valueAsBigInt("nbs"),
    );
  }

  static MsgPackFixedKeyDynamicLazyValueMapLayout<
    String,
    dynamic,
    LayoutRepository
  >
  layout({String? property}) {
    return MsgPackFixedKeyDynamicLazyValueMapLayout<
      String,
      dynamic,
      LayoutRepository
    >(
      keyLayout: MsgPackStringLayout(),
      sortKeys: true,
      valueLayouts: [
        MapEntry(
          "nui",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.optionalDefaultU64Layout,
          ),
        ),
        MapEntry(
          "nbs",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.optionalDefaultU64Layout,
          ),
        ),
      ],
      property: property,
    );
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) =>
      layout(property: property);

  @override
  Map<String, dynamic> toSerializeJson() {
    return {"nui": numUint, "nbs": numByteSlice}.notNullValue;
  }

  @override
  List<dynamic> get variables => [numUint, numByteSlice];
}

class BoxRef with LayoutSerializable, Equality {
  final BigInt index; // i
  final BuBytes name; // n

  BoxRef({required this.index, required List<int> name})
    : name = name.asImmutableBytes;

  factory BoxRef.deserializeJson(Map<String, dynamic> json) {
    return BoxRef(
      index: json.valueAsBigInt("i", onMissing: () => BigInt.zero),
      name: json.valueAsBytes(
        "n",
        onMissing: () => [],
        encoding: StringEncoding.base64,
      ),
    );
  }

  static MsgPackFixedKeyDynamicLazyValueMapLayout<
    String,
    dynamic,
    LayoutRepository
  >
  layout({String? property}) {
    return MsgPackFixedKeyDynamicLazyValueMapLayout<
      String,
      dynamic,
      LayoutRepository
    >(
      keyLayout: MsgPackStringLayout(),
      sortKeys: true,
      valueLayouts: [
        MapEntry(
          "i",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.defaultU64Layout,
          ),
        ),
        MapEntry(
          "n",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.defaultBinaryLayout,
          ),
        ),
      ],
      property: property,
    );
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) =>
      layout(property: property);

  @override
  Map<String, dynamic> toSerializeJson() {
    return {"i": index, "n": name}.notNullValue;
  }

  @override
  List<dynamic> get variables => [index, name];
}

/// The proof carried by a heartbeat transaction (`prf`).
///
class HeartbeatProof with LayoutSerializable, Equality {
  /// Signature of the heartbeat seed under the vote key (`s`, 64 bytes).
  final BuBytes sig;

  /// One-time signature verifier public key (`p`, 32 bytes).
  final BuBytes pk;

  /// Second-level ephemeral public key (`p2`, 32 bytes).
  final BuBytes pk2;

  /// Signature of the subkey id under [pk2] (`p1s`, 64 bytes).
  final BuBytes pk1Sig;

  /// Signature of the batch id under the master key (`p2s`, 64 bytes).
  final BuBytes pk2Sig;

  HeartbeatProof({
    required List<int> sig,
    required List<int> pk,
    required List<int> pk2,
    required List<int> pk1Sig,
    required List<int> pk2Sig,
  }) : sig =
           sig
               .exc(
                 length: CryptoSignerConst.ed25519SignatureLength,
                 operation: "Invalid heartbeat proof signature length.",
               )
               .asImmutableBytes,
       pk =
           pk
               .exc(
                 length: Ed25519KeysConst.pubKeyByteLen,
                 operation: "Invalid heartbeat proof pk length.",
               )
               .asImmutableBytes,
       pk2 =
           pk2
               .exc(
                 length: Ed25519KeysConst.pubKeyByteLen,
                 operation: "Invalid heartbeat proof pk2 length.",
               )
               .asImmutableBytes,
       pk1Sig =
           pk1Sig
               .exc(
                 length: CryptoSignerConst.ed25519SignatureLength,
                 operation: "Invalid heartbeat proof pk1Sig length.",
               )
               .asImmutableBytes,
       pk2Sig =
           pk2Sig
               .exc(
                 length: CryptoSignerConst.ed25519SignatureLength,
                 operation: "Invalid heartbeat proof pk2Sig length.",
               )
               .asImmutableBytes;

  /// A placeholder proof with all fields zeroed (used when `prf` is absent).
  factory HeartbeatProof.zeros() {
    return HeartbeatProof(
      sig: List<int>.filled(CryptoSignerConst.ed25519SignatureLength, 0),
      pk: List<int>.filled(Ed25519KeysConst.pubKeyByteLen, 0),
      pk2: List<int>.filled(Ed25519KeysConst.pubKeyByteLen, 0),
      pk1Sig: List<int>.filled(CryptoSignerConst.ed25519SignatureLength, 0),
      pk2Sig: List<int>.filled(CryptoSignerConst.ed25519SignatureLength, 0),
    );
  }

  factory HeartbeatProof.deserializeJson(Map<String, dynamic> json) {
    return HeartbeatProof(
      sig: json.valueAsBytes(
        "s",
        onMissing:
            () => List<int>.filled(CryptoSignerConst.ed25519SignatureLength, 0),
        encoding: StringEncoding.base64,
      ),
      pk: json.valueAsBytes(
        "p",
        onMissing: () => List<int>.filled(Ed25519KeysConst.pubKeyByteLen, 0),
        encoding: StringEncoding.base64,
      ),
      pk2: json.valueAsBytes(
        "p2",
        onMissing: () => List<int>.filled(Ed25519KeysConst.pubKeyByteLen, 0),
        encoding: StringEncoding.base64,
      ),
      pk1Sig: json.valueAsBytes(
        "p1s",
        onMissing:
            () => List<int>.filled(CryptoSignerConst.ed25519SignatureLength, 0),
        encoding: StringEncoding.base64,
      ),
      pk2Sig: json.valueAsBytes(
        "p2s",
        onMissing:
            () => List<int>.filled(CryptoSignerConst.ed25519SignatureLength, 0),
        encoding: StringEncoding.base64,
      ),
    );
  }

  static MsgPackFixedKeyDynamicLazyValueMapLayout<
    String,
    dynamic,
    LayoutRepository
  >
  layout({String? property}) {
    return MsgPackFixedKeyDynamicLazyValueMapLayout<
      String,
      dynamic,
      LayoutRepository
    >(
      keyLayout: MsgPackStringLayout(),
      sortKeys: true,
      valueLayouts: [
        MapEntry(
          "p",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.defaultBinary32Layout,
          ),
        ),
        MapEntry(
          "p1s",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.defaultBinary64Layout,
          ),
        ),
        MapEntry(
          "p2",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.defaultBinary32Layout,
          ),
        ),
        MapEntry(
          "p2s",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.defaultBinary64Layout,
          ),
        ),
        MapEntry(
          "s",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.defaultBinary64Layout,
          ),
        ),
      ],
      property: property,
    );
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) =>
      layout(property: property);

  @override
  Map<String, dynamic> toSerializeJson() {
    return {
      "p": pk,
      "p1s": pk1Sig,
      "p2": pk2,
      "p2s": pk2Sig,
      "s": sig,
    }.notNullValue;
  }

  @override
  List<dynamic> get variables => [sig, pk, pk2, pk1Sig, pk2Sig];

  /// True when every component is zero (i.e. no proof is present).
  bool get isZero =>
      sig.every((e) => e == 0) &&
      pk.every((e) => e == 0) &&
      pk2.every((e) => e == 0) &&
      pk1Sig.every((e) => e == 0) &&
      pk2Sig.every((e) => e == 0);
}

class Heartbeat with LayoutSerializable, Equality {
  final AlgoAddress hbAddress; // a
  final HeartbeatProof hbProof;
  final BuBytes hbSeed; // sd (32)
  final BuBytes hbVoteId; // vid (32)
  final BigInt hbKeyDilution; // kd
  final bool? hbChallengeDiscount; // c

  Heartbeat({
    required this.hbAddress,
    required this.hbProof,
    required List<int> hbSeed,
    required List<int> hbVoteId,
    required this.hbKeyDilution,
    this.hbChallengeDiscount,
  }) : hbSeed =
           hbSeed
               .exc(length: 32, operation: "Invalid hbSeed bytes length.")
               .asImmutableBytes,
       hbVoteId =
           hbVoteId
               .exc(length: 32, operation: "Invalid hbVoteId bytes length.")
               .asImmutableBytes;

  factory Heartbeat.deserializeJson(Map<String, dynamic> json) {
    return Heartbeat(
      hbAddress: json.valueTo<AlgoAddress, Object>(
        key: "a",
        onMissing: () => AlgoAddress.zero,
        parse: (e) => AlgoUtils.parseAddress(e),
      ),
      hbProof: json.valueTo<HeartbeatProof, Map<String, dynamic>>(
        key: "prf",
        onMissing: () => HeartbeatProof.zeros(),
        parse: HeartbeatProof.deserializeJson,
      ),
      hbSeed: json.valueAsBytes(
        "sd",
        onMissing: () => List<int>.filled(32, 0),
        encoding: StringEncoding.base64,
      ),
      hbVoteId: json.valueAsBytes(
        "vid",
        onMissing: () => List<int>.filled(32, 0),
        encoding: StringEncoding.base64,
      ),
      hbKeyDilution: json.valueAsBigInt("kd", onMissing: () => BigInt.zero),
      hbChallengeDiscount: json.valueAsBool("c"),
    );
  }

  static MsgPackFixedKeyDynamicLazyValueMapLayout<
    String,
    dynamic,
    LayoutRepository
  >
  layout({String? property}) {
    return MsgPackFixedKeyDynamicLazyValueMapLayout<
      String,
      dynamic,
      LayoutRepository
    >(
      keyLayout: MsgPackStringLayout(),
      sortKeys: true,
      valueLayouts: [
        MapEntry(
          "a",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoAddressLayout.defaultAddressLayout,
          ),
        ),
        MapEntry(
          "prf",
          LazyMsgPackMapLayoutBuilder(
            layout:
                (property, params) => AlgoMapLayout.optionalDefaultMapLayout(
                  HeartbeatProof.layout(property: property),
                  params,
                ),
          ),
        ),
        MapEntry(
          "sd",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.defaultBinary32Layout,
          ),
        ),
        MapEntry(
          "vid",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.defaultBinary32Layout,
          ),
        ),
        MapEntry(
          "kd",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.defaultU64Layout,
          ),
        ),
        MapEntry(
          "c",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBooleanLayout.optionalDefaultBooleanLayout,
          ),
        ),
      ],
      property: property,
    );
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) =>
      layout(property: property);

  @override
  Map<String, dynamic> toSerializeJson() {
    return {
      "a": hbAddress.toBytes(),
      "prf": hbProof.isZero ? null : hbProof.toSerializeJson(),
      "sd": hbSeed,
      "vid": hbVoteId,
      "kd": hbKeyDilution,
      "c": hbChallengeDiscount,
    }.notNullValue;
  }

  @override
  List<dynamic> get variables => [
    hbAddress,
    hbProof,
    hbSeed,
    hbVoteId,
    hbKeyDilution,
    hbChallengeDiscount,
  ];
}

// ═══════════════════════════════════════════════════════════════════════════
// AlgoTransaction (flattened)
// ═══════════════════════════════════════════════════════════════════════════

class AlgoTransaction with LayoutSerializable, Equality {
  // Header
  final AlgoTxType type;
  final AlgoAddress sender;
  final BigInt fee;
  final BigInt firstValid;
  final BigInt lastValid;
  final BuBytes? note;
  final String? genesisId;
  final BuBytes genesisHash;
  final BuBytes? group;
  final BuBytes? lease;
  final AlgoAddress? rekeyTo;

  // pay
  final AlgoAddress? receiver;
  final BigInt? amount;
  final AlgoAddress? closeRemainderTo;

  // keyreg
  final BuBytes? votePk;
  final BuBytes? selectionPk;
  final BuBytes? stateProofPk;
  final BigInt? voteFirst;
  final BigInt? voteLast;
  final BigInt? voteKeyDilution;
  final bool? nonparticipation;

  // acfg
  final BigInt? configAsset;
  final AssetParams? assetParams;

  // axfer
  final BigInt? xferAsset;
  final BigInt? assetAmount;
  final AlgoAddress? assetSender;
  final AlgoAddress? assetReceiver;
  final AlgoAddress? assetCloseTo;

  // afrz
  final AlgoAddress? freezeAccount;
  final BigInt? freezeAsset;
  final bool? assetFrozen;

  // appl
  final BigInt? applicationId;
  final BigInt? onCompletion;
  final List<BuBytes>? applicationArgs;
  final List<AlgoAddress>? accounts;
  final List<BigInt>? foreignAssets;
  final List<BigInt>? foreignApps;
  final List<BoxRef>? boxes;
  final StateSchema? localStateSchema;
  final StateSchema? globalStateSchema;
  final BuBytes? approvalProgram;
  final BuBytes? clearStateProgram;
  final BigInt? extraProgramPages;
  final BigInt? rejectVersion;

  // stpf
  final BigInt? stateProofType;
  final StateProof? stateProof;
  final StateProofMessage? message;

  // hb
  final Heartbeat? heartbeat;

  AlgoTransaction({
    required this.type,
    required this.sender,
    required this.fee,
    required this.firstValid,
    required this.lastValid,
    List<int>? note,
    this.genesisId,
    required List<int> genesisHash,
    List<int>? group,
    List<int>? lease,
    this.rekeyTo,
    this.receiver,
    this.amount,
    this.closeRemainderTo,
    List<int>? votePk,
    List<int>? selectionPk,
    List<int>? stateProofPk,
    this.voteFirst,
    this.voteLast,
    this.voteKeyDilution,
    this.nonparticipation,
    this.configAsset,
    this.assetParams,
    this.xferAsset,
    this.assetAmount,
    this.assetSender,
    this.assetReceiver,
    this.assetCloseTo,
    this.freezeAccount,
    this.freezeAsset,
    this.assetFrozen,
    this.applicationId,
    this.onCompletion,
    List<List<int>>? applicationArgs,
    List<AlgoAddress>? accounts,
    List<BigInt>? foreignAssets,
    List<BigInt>? foreignApps,
    List<BoxRef>? boxes,
    this.localStateSchema,
    this.globalStateSchema,
    List<int>? approvalProgram,
    List<int>? clearStateProgram,
    this.extraProgramPages,
    this.rejectVersion,
    this.stateProofType,
    this.stateProof,
    this.message,
    this.heartbeat,
  }) : note = note?.asImmutableBytes,
       genesisHash =
           genesisHash
               .exc(length: 32, operation: "Invalid genesisHash bytes length.")
               .asImmutableBytes,
       group =
           group
               ?.exc(length: 32, operation: "Invalid group bytes length.")
               .asImmutableBytes,
       lease =
           lease
               ?.exc(length: 32, operation: "Invalid lease bytes length.")
               .asImmutableBytes,
       votePk =
           votePk
               ?.exc(length: 32, operation: "Invalid votePk bytes length.")
               .asImmutableBytes,
       selectionPk =
           selectionPk
               ?.exc(length: 32, operation: "Invalid selectionPk bytes length.")
               .asImmutableBytes,
       stateProofPk =
           stateProofPk
               ?.exc(
                 length: 64,
                 operation: "Invalid stateProofPk bytes length.",
               )
               .asImmutableBytes,
       applicationArgs =
           applicationArgs?.map((e) => e.asImmutableBytes).toList().immutable,
       accounts = accounts?.immutable,
       foreignAssets = foreignAssets?.immutable,
       foreignApps = foreignApps?.immutable,
       boxes = boxes?.immutable,
       approvalProgram = approvalProgram?.asImmutableBytes,
       clearStateProgram = clearStateProgram?.asImmutableBytes;

  factory AlgoTransaction.fromFields({
    required TransactionHeader header,
    required AlgoTxFields fields,
  }) {
    return switch (fields) {
      PaymentTxnFields f => AlgoTransaction(
        type: f.type,
        sender: header.sender,
        fee: header.fee,
        firstValid: header.firstValid,
        lastValid: header.lastValid,
        note: header.note,
        genesisId: header.genesisId,
        genesisHash: header.genesisHash,
        group: header.group,
        lease: header.lease,
        rekeyTo: header.rekeyTo,
        receiver: f.receiver,
        amount: f.amount,

        closeRemainderTo: f.closeRemainderTo,
      ),
      KeyregTxnFields f => AlgoTransaction(
        type: f.type,
        sender: header.sender,
        fee: header.fee,
        firstValid: header.firstValid,
        lastValid: header.lastValid,
        note: header.note,
        genesisId: header.genesisId,
        genesisHash: header.genesisHash,
        group: header.group,
        lease: header.lease,
        rekeyTo: header.rekeyTo,
        votePk: f.votePk,
        selectionPk: f.selectionPk,
        stateProofPk: f.stateProofPk,
        voteFirst: f.voteFirst,
        voteLast: f.voteLast,
        voteKeyDilution: f.voteKeyDilution,
        nonparticipation: f.nonparticipation,
      ),
      AssetConfigTxnFields f => AlgoTransaction(
        type: f.type,
        sender: header.sender,
        fee: header.fee,
        firstValid: header.firstValid,
        lastValid: header.lastValid,
        note: header.note,
        genesisId: header.genesisId,
        genesisHash: header.genesisHash,
        group: header.group,
        lease: header.lease,
        rekeyTo: header.rekeyTo,
        configAsset: f.configAsset,
        assetParams: f.assetParams,
      ),
      AssetTransferTxnFields f => AlgoTransaction(
        type: f.type,
        sender: header.sender,
        fee: header.fee,
        firstValid: header.firstValid,
        lastValid: header.lastValid,
        note: header.note,
        genesisId: header.genesisId,
        genesisHash: header.genesisHash,
        group: header.group,
        lease: header.lease,
        rekeyTo: header.rekeyTo,
        xferAsset: f.xferAsset,
        assetAmount: f.assetAmount,
        assetSender: f.assetSender,
        assetReceiver: f.assetReceiver,
        assetCloseTo: f.assetCloseTo,
      ),
      AssetFreezeTxnFields f => AlgoTransaction(
        type: f.type,
        sender: header.sender,
        fee: header.fee,
        firstValid: header.firstValid,
        lastValid: header.lastValid,
        note: header.note,
        genesisId: header.genesisId,
        genesisHash: header.genesisHash,
        group: header.group,
        lease: header.lease,
        rekeyTo: header.rekeyTo,
        freezeAccount: f.freezeAccount,
        freezeAsset: f.freezeAsset,
        assetFrozen: f.assetFrozen,
      ),
      ApplicationCallTxnFields f => AlgoTransaction(
        type: f.type,
        sender: header.sender,
        fee: header.fee,
        firstValid: header.firstValid,
        lastValid: header.lastValid,
        note: header.note,
        genesisId: header.genesisId,
        genesisHash: header.genesisHash,
        group: header.group,
        lease: header.lease,
        rekeyTo: header.rekeyTo,
        applicationId: f.applicationId,
        onCompletion: f.onCompletion,
        applicationArgs: f.applicationArgs,
        accounts: f.accounts,
        foreignAssets: f.foreignAssets,
        foreignApps: f.foreignApps,
        boxes: f.boxes,
        localStateSchema: f.localStateSchema,
        globalStateSchema: f.globalStateSchema,
        approvalProgram: f.approvalProgram,
        clearStateProgram: f.clearStateProgram,
        extraProgramPages: f.extraProgramPages,
        rejectVersion: f.rejectVersion,
      ),
      StateProofTxnFields f => AlgoTransaction(
        type: f.type,
        sender: header.sender,
        fee: header.fee,
        firstValid: header.firstValid,
        lastValid: header.lastValid,
        note: header.note,
        genesisId: header.genesisId,
        genesisHash: header.genesisHash,
        group: header.group,
        lease: header.lease,
        rekeyTo: header.rekeyTo,
        stateProofType: f.stateProofType,
        stateProof: f.stateProof,
        message: f.message,
      ),
      HeartbeatTxnFields f => AlgoTransaction(
        type: f.type,
        sender: header.sender,
        fee: header.fee,
        firstValid: header.firstValid,
        lastValid: header.lastValid,
        note: header.note,
        genesisId: header.genesisId,
        genesisHash: header.genesisHash,
        group: header.group,
        lease: header.lease,
        rekeyTo: header.rekeyTo,
        heartbeat: Heartbeat(
          hbAddress: f.hbAddress,
          hbProof: f.hbProof,
          hbSeed: f.hbSeed,
          hbVoteId: f.hbVoteId,
          hbKeyDilution: f.hbKeyDilution,
          hbChallengeDiscount: f.hbChallengeDiscount,
        ),
      ),
    };
  }
  factory AlgoTransaction.deserialize(List<int> bytes) {
    final decode = LayoutSerializable.deserialize(
      bytes: bytes,
      layout: layout(),
    );
    return AlgoTransaction.deserializeJson(decode);
  }

  factory AlgoTransaction.deserializeJson(Map<String, dynamic> json) {
    return AlgoTransaction(
      // Header
      type: AlgoTxType.fromValue(
        json.valueAsString("type", onMissing: () => ""),
      ),
      sender: json.valueTo<AlgoAddress, Object>(
        key: "snd",
        onMissing: () => AlgoAddress.zero,
        parse: (e) => AlgoUtils.parseAddress(e),
      ),
      fee: json.valueAsBigInt("fee", onMissing: () => BigInt.zero),
      firstValid: json.valueAsBigInt("fv", onMissing: () => BigInt.zero),
      lastValid: json.valueAsBigInt("lv", onMissing: () => BigInt.zero),
      note: json.valueAsBytes("note", encoding: StringEncoding.base64),
      genesisId: json.valueAsString("gen"),
      genesisHash: json.valueAsBytes(
        "gh",
        onMissing: () => List<int>.filled(32, 0),
        encoding: StringEncoding.base64,
      ),
      group: json.valueAsBytes("grp", encoding: StringEncoding.base64),
      lease: json.valueAsBytes("lx", encoding: StringEncoding.base64),
      rekeyTo: json.valueTo<AlgoAddress?, Object>(
        key: "rekey",
        parse: (e) => AlgoUtils.parseAddress(e),
      ),

      // pay
      receiver: json.valueTo<AlgoAddress?, Object>(
        key: "rcv",
        parse: (e) => AlgoUtils.parseAddress(e),
      ),
      amount: json.valueAsBigInt("amt"),
      closeRemainderTo: json.valueTo<AlgoAddress?, Object>(
        key: "close",
        parse: (e) => AlgoUtils.parseAddress(e),
      ),

      // keyreg
      votePk: json.valueAsBytes("votekey", encoding: StringEncoding.base64),
      selectionPk: json.valueAsBytes("selkey", encoding: StringEncoding.base64),
      stateProofPk: json.valueAsBytes(
        "sprfkey",
        encoding: StringEncoding.base64,
      ),
      voteFirst: json.valueAsBigInt("votefst"),
      voteLast: json.valueAsBigInt("votelst"),
      voteKeyDilution: json.valueAsBigInt("votekd"),
      nonparticipation: json.valueAsBool("nonpart"),

      // acfg
      configAsset: json.valueAsBigInt("caid"),
      assetParams: json.valueTo<AssetParams?, Map<String, dynamic>>(
        key: "apar",
        parse: AssetParams.deserializeJson,
      ),

      // axfer
      xferAsset: json.valueAsBigInt("xaid"),
      assetAmount: json.valueAsBigInt("aamt"),
      assetSender: json.valueTo<AlgoAddress?, Object>(
        key: "asnd",
        parse: (e) => AlgoUtils.parseAddress(e),
      ),
      assetReceiver: json.valueTo<AlgoAddress?, Object>(
        key: "arcv",
        parse: (e) => AlgoUtils.parseAddress(e),
      ),
      assetCloseTo: json.valueTo<AlgoAddress?, Object>(
        key: "aclose",
        parse: (e) => AlgoUtils.parseAddress(e),
      ),

      // afrz
      freezeAccount: json.valueTo<AlgoAddress?, Object>(
        key: "fadd",
        parse: (e) => AlgoUtils.parseAddress(e),
      ),
      freezeAsset: json.valueAsBigInt("faid"),
      assetFrozen: json.valueAsBool("afrz"),

      // appl
      applicationId: json.valueAsBigInt("apid"),
      onCompletion: json.valueAsBigInt("apan"),
      applicationArgs:
          json
              .valueAsList<List?>("apaa")
              ?.map(
                (e) => JsonParser.valueAsBytes<List<int>>(
                  e,
                  encoding: StringEncoding.base64,
                ),
              )
              .toList(),
      accounts:
          json
              .valueAsList<List?>("apat")
              ?.map((e) => AlgoUtils.parseAddress(e))
              .toList(),
      foreignAssets: json.valueAsList<List<BigInt>?>("apas"),
      foreignApps: json.valueAsList<List<BigInt>?>("apfa"),
      boxes:
          json
              .valueAsList("apbx")
              ?.map((e) => BoxRef.deserializeJson(e))
              .toList(),
      localStateSchema: json.valueTo<StateSchema?, Map<String, dynamic>>(
        key: "apls",
        parse: StateSchema.deserializeJson,
      ),
      globalStateSchema: json.valueTo<StateSchema?, Map<String, dynamic>>(
        key: "apgs",
        parse: StateSchema.deserializeJson,
      ),
      approvalProgram: json.valueAsBytes(
        "apap",
        encoding: StringEncoding.base64,
      ),
      clearStateProgram: json.valueAsBytes(
        "apsu",
        encoding: StringEncoding.base64,
      ),
      extraProgramPages: json.valueAsBigInt("apep"),
      rejectVersion: json.valueAsBigInt("aprv"),

      // stpf
      stateProofType: json.valueAsBigInt("sptype"),
      stateProof: json.valueTo<StateProof?, Map<String, dynamic>>(
        key: "sp",
        parse: StateProof.deserializeJson,
      ),
      message: json.valueTo<StateProofMessage?, Map<String, dynamic>>(
        key: "spmsg",
        parse: StateProofMessage.deserializeJson,
      ),

      // hb
      heartbeat: json.valueTo<Heartbeat?, Map<String, dynamic>>(
        key: "hb",
        parse: Heartbeat.deserializeJson,
      ),
    );
  }

  static MsgPackFixedKeyDynamicLazyValueMapLayout<
    String,
    dynamic,
    LayoutRepository
  >
  layout({String? property}) {
    // ... same layout as before ...
    return MsgPackFixedKeyDynamicLazyValueMapLayout<
      String,
      dynamic,
      LayoutRepository
    >(
      keyLayout: MsgPackStringLayout(),
      sortKeys: true,
      valueLayouts: [
        MapEntry(
          "type",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoStringLayout.defaultStringLayout,
          ),
        ),
        MapEntry(
          "snd",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoAddressLayout.defaultAddressLayout,
          ),
        ),
        MapEntry(
          "fee",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.defaultU64Layout,
          ),
        ),
        MapEntry(
          "fv",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.defaultU64Layout,
          ),
        ),
        MapEntry(
          "lv",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.defaultU64Layout,
          ),
        ),
        MapEntry(
          "note",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.optionalDefaultBinaryLayout,
          ),
        ),
        MapEntry(
          "gen",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoStringLayout.optionalDefaultStringLayout,
          ),
        ),
        MapEntry(
          "gh",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.optionalDefaultBinary32Layout,
          ),
        ),
        MapEntry(
          "grp",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.optionalDefaultBinary32Layout,
          ),
        ),
        MapEntry(
          "lx",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.optionalDefaultBinary32Layout,
          ),
        ),
        MapEntry(
          "rekey",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoAddressLayout.optionalDefaultAddressLayout,
          ),
        ),
        MapEntry(
          "rcv",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoAddressLayout.optionalDefaultAddressLayout,
          ),
        ),
        MapEntry(
          "amt",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.optionalDefaultU64Layout,
          ),
        ),
        MapEntry(
          "close",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoAddressLayout.optionalDefaultAddressLayout,
          ),
        ),
        MapEntry(
          "votekey",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.optionalDefaultBinary32Layout,
          ),
        ),
        MapEntry(
          "selkey",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.optionalDefaultBinary32Layout,
          ),
        ),
        MapEntry(
          "sprfkey",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.optionalDefaultBinary64Layout,
          ),
        ),
        MapEntry(
          "votefst",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.optionalDefaultU64Layout,
          ),
        ),
        MapEntry(
          "votelst",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.optionalDefaultU64Layout,
          ),
        ),
        MapEntry(
          "votekd",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.optionalDefaultU64Layout,
          ),
        ),
        MapEntry(
          "nonpart",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBooleanLayout.optionalDefaultBooleanLayout,
          ),
        ),
        MapEntry(
          "caid",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.optionalDefaultU64Layout,
          ),
        ),
        MapEntry(
          "apar",
          LazyMsgPackMapLayoutBuilder(
            layout:
                (property, params) => AlgoMapLayout.optionalDefaultMapLayout(
                  AssetParams.layout(property: property),
                  params,
                ),
          ),
        ),
        MapEntry(
          "xaid",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.optionalDefaultU64Layout,
          ),
        ),
        MapEntry(
          "aamt",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.optionalDefaultU64Layout,
          ),
        ),
        MapEntry(
          "asnd",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoAddressLayout.optionalDefaultAddressLayout,
          ),
        ),
        MapEntry(
          "arcv",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoAddressLayout.optionalDefaultAddressLayout,
          ),
        ),
        MapEntry(
          "aclose",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoAddressLayout.optionalDefaultAddressLayout,
          ),
        ),
        MapEntry(
          "fadd",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoAddressLayout.optionalDefaultAddressLayout,
          ),
        ),
        MapEntry(
          "faid",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.optionalDefaultU64Layout,
          ),
        ),
        MapEntry(
          "afrz",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBooleanLayout.optionalDefaultBooleanLayout,
          ),
        ),
        MapEntry(
          "apid",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.optionalDefaultU64Layout,
          ),
        ),
        MapEntry(
          "apan",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.optionalDefaultU64Layout,
          ),
        ),
        MapEntry(
          "apaa",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoLayoutArray.optionalDefaultArrayOfBinaryLayout,
          ),
        ),
        MapEntry(
          "apat",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoLayoutArray.optionalDefaultArrayOfAddressLayout,
          ),
        ),
        MapEntry(
          "apas",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoLayoutArray.optionalDefaultArrayOfU64Layout,
          ),
        ),
        MapEntry(
          "apfa",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoLayoutArray.optionalDefaultArrayOfU64Layout,
          ),
        ),
        MapEntry(
          "apbx",
          LazyMsgPackMapLayoutBuilder(
            layout:
                (property, params) => AlgoLayoutArray.defaultArrayLayout(
                  BoxRef.layout(),
                  property,
                  params,
                  optional: true,
                ),
          ),
        ),
        MapEntry(
          "apls",
          LazyMsgPackMapLayoutBuilder(
            layout:
                (property, params) => AlgoMapLayout.optionalDefaultMapLayout(
                  StateSchema.layout(property: property),
                  params,
                ),
          ),
        ),
        MapEntry(
          "apgs",
          LazyMsgPackMapLayoutBuilder(
            layout:
                (property, params) => AlgoMapLayout.optionalDefaultMapLayout(
                  StateSchema.layout(property: property),
                  params,
                ),
          ),
        ),
        MapEntry(
          "apap",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.optionalDefaultBinaryLayout,
          ),
        ),
        MapEntry(
          "apsu",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.optionalDefaultBinaryLayout,
          ),
        ),
        MapEntry(
          "apep",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.optionalDefaultU64Layout,
          ),
        ),
        MapEntry(
          "aprv",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.optionalDefaultU64Layout,
          ),
        ),
        MapEntry(
          "sptype",
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.optionalDefaultU64Layout,
          ),
        ),
        MapEntry(
          "sp",
          LazyMsgPackMapLayoutBuilder(
            layout:
                (property, params) => AlgoMapLayout.optionalDefaultMapLayout(
                  StateProof.layout(property: property),
                  params,
                ),
          ),
        ),
        MapEntry(
          "spmsg",
          LazyMsgPackMapLayoutBuilder(
            layout:
                (property, params) => AlgoMapLayout.optionalDefaultMapLayout(
                  StateProofMessage.layout(property: property),
                  params,
                ),
          ),
        ),
        MapEntry(
          "hb",
          LazyMsgPackMapLayoutBuilder(
            layout:
                (property, params) => AlgoMapLayout.optionalDefaultMapLayout(
                  Heartbeat.layout(property: property),
                  params,
                ),
          ),
        ),
      ],
      property: property,
    );
  }

  AlgoTransaction copyWith({
    AlgoTxType? type,
    AlgoAddress? sender,
    BigInt? fee,
    BigInt? firstValid,
    BigInt? lastValid,
    List<int>? note,
    String? genesisId,
    List<int>? genesisHash,
    List<int>? group,
    List<int>? lease,
    AlgoAddress? rekeyTo,

    AlgoAddress? receiver,
    BigInt? amount,
    AlgoAddress? closeRemainderTo,

    List<int>? votePk,
    List<int>? selectionPk,
    List<int>? stateProofPk,
    BigInt? voteFirst,
    BigInt? voteLast,
    BigInt? voteKeyDilution,
    bool? nonparticipation,

    BigInt? configAsset,
    AssetParams? assetParams,

    BigInt? xferAsset,
    BigInt? assetAmount,
    AlgoAddress? assetSender,
    AlgoAddress? assetReceiver,
    AlgoAddress? assetCloseTo,

    AlgoAddress? freezeAccount,
    BigInt? freezeAsset,
    bool? assetFrozen,

    BigInt? applicationId,
    BigInt? onCompletion,
    List<List<int>>? applicationArgs,
    List<AlgoAddress>? accounts,
    List<BigInt>? foreignAssets,
    List<BigInt>? foreignApps,
    List<BoxRef>? boxes,
    StateSchema? localStateSchema,
    StateSchema? globalStateSchema,
    List<int>? approvalProgram,
    List<int>? clearStateProgram,
    BigInt? extraProgramPages,
    BigInt? rejectVersion,
    BigInt? stateProofType,
    StateProof? stateProof,
    StateProofMessage? message,
    Heartbeat? heartbeat,

    bool replaceGroup = false,
  }) {
    return AlgoTransaction(
      type: type ?? this.type,
      sender: sender ?? this.sender,
      fee: fee ?? this.fee,
      firstValid: firstValid ?? this.firstValid,
      lastValid: lastValid ?? this.lastValid,
      note: note ?? this.note,
      genesisId: genesisId ?? this.genesisId,
      genesisHash: genesisHash ?? this.genesisHash,
      group: replaceGroup ? group : group ?? this.group,
      lease: lease ?? this.lease,
      rekeyTo: rekeyTo ?? this.rekeyTo,

      receiver: receiver ?? this.receiver,
      amount: amount ?? this.amount,
      closeRemainderTo: closeRemainderTo ?? this.closeRemainderTo,

      votePk: votePk ?? this.votePk,
      selectionPk: selectionPk ?? this.selectionPk,
      stateProofPk: stateProofPk ?? this.stateProofPk,
      voteFirst: voteFirst ?? this.voteFirst,
      voteLast: voteLast ?? this.voteLast,
      voteKeyDilution: voteKeyDilution ?? this.voteKeyDilution,
      nonparticipation: nonparticipation ?? this.nonparticipation,

      configAsset: configAsset ?? this.configAsset,
      assetParams: assetParams ?? this.assetParams,

      xferAsset: xferAsset ?? this.xferAsset,
      assetAmount: assetAmount ?? this.assetAmount,
      assetSender: assetSender ?? this.assetSender,
      assetReceiver: assetReceiver ?? this.assetReceiver,
      assetCloseTo: assetCloseTo ?? this.assetCloseTo,

      freezeAccount: freezeAccount ?? this.freezeAccount,
      freezeAsset: freezeAsset ?? this.freezeAsset,
      assetFrozen: assetFrozen ?? this.assetFrozen,

      applicationId: applicationId ?? this.applicationId,
      onCompletion: onCompletion ?? this.onCompletion,
      applicationArgs: applicationArgs ?? this.applicationArgs,
      accounts: accounts ?? this.accounts,
      foreignAssets: foreignAssets ?? this.foreignAssets,
      foreignApps: foreignApps ?? this.foreignApps,
      boxes: boxes ?? this.boxes,
      localStateSchema: localStateSchema ?? this.localStateSchema,
      globalStateSchema: globalStateSchema ?? this.globalStateSchema,
      approvalProgram: approvalProgram ?? this.approvalProgram,
      clearStateProgram: clearStateProgram ?? this.clearStateProgram,
      extraProgramPages: extraProgramPages ?? this.extraProgramPages,
      rejectVersion: rejectVersion ?? this.rejectVersion,

      stateProofType: stateProofType ?? this.stateProofType,
      stateProof: stateProof ?? this.stateProof,
      message: message ?? this.message,

      heartbeat: heartbeat ?? this.heartbeat,
    );
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) =>
      layout(property: property);

  @override
  Map<String, dynamic> toSerializeJson() {
    return {
      "type": type.value,
      "snd": sender.toBytes(),
      "fee": fee,
      "fv": firstValid,
      "lv": lastValid,
      "note": note,
      "gen": genesisId,
      "gh": genesisHash,
      "grp": group,
      "lx": lease,
      "rekey": rekeyTo?.toBytes(),
      "rcv": receiver?.toBytes(),
      "amt": amount,
      "close": closeRemainderTo?.toBytes(),
      "votekey": votePk,
      "selkey": selectionPk,
      "sprfkey": stateProofPk,
      "votefst": voteFirst,
      "votelst": voteLast,
      "votekd": voteKeyDilution,
      "nonpart": nonparticipation,
      "caid": configAsset,
      "apar": assetParams?.toSerializeJson(),
      "xaid": xferAsset,
      "aamt": assetAmount,
      "asnd": assetSender?.toBytes(),
      "arcv": assetReceiver?.toBytes(),
      "aclose": assetCloseTo?.toBytes(),
      "fadd": freezeAccount?.toBytes(),
      "faid": freezeAsset,
      "afrz": assetFrozen,
      "apid": applicationId,
      "apan": onCompletion,
      "apaa": applicationArgs,
      "apat": accounts?.map((a) => a.toBytes()).toList(),
      "apas": foreignAssets,
      "apfa": foreignApps,
      "apbx": boxes?.map((b) => b.toSerializeJson()).toList(),
      "apls": localStateSchema?.toSerializeJson(),
      "apgs": globalStateSchema?.toSerializeJson(),
      "apap": approvalProgram,
      "apsu": clearStateProgram,
      "apep": extraProgramPages,
      "aprv": rejectVersion,
      "sptype": stateProofType,
      "sp": stateProof?.toSerializeJson(),
      "spmsg": message?.toSerializeJson(),
      "hb": heartbeat?.toSerializeJson(),
    }.notNullValue;
  }

  @override
  List<dynamic> get variables => [
    type,
    sender,
    fee,
    firstValid,
    lastValid,
    note,
    genesisId,
    genesisHash,
    group,
    lease,
    rekeyTo,
    receiver,
    amount,
    closeRemainderTo,
    votePk,
    selectionPk,
    stateProofPk,
    voteFirst,
    voteLast,
    voteKeyDilution,
    nonparticipation,
    configAsset,
    assetParams,
    xferAsset,
    assetAmount,
    assetReceiver,
    assetSender,
    assetCloseTo,
    freezeAccount,
    freezeAsset,
    assetFrozen,
    applicationId,
    onCompletion,
    applicationArgs,
    accounts,
    foreignAssets,
    foreignApps,
    boxes,
    localStateSchema,
    globalStateSchema,
    approvalProgram,
    clearStateProgram,
    extraProgramPages,
    rejectVersion,
    stateProofType,
    stateProof,
    message,
    heartbeat,
  ];

  List<int> rawTransactionBytesToSign() => [
    ...AlgoUtils.txidPrefix,
    ...toSerializeBytes(),
  ];

  List<int> transactionID() {
    return QuickCrypto.sha512256Hash(rawTransactionBytesToSign());
  }

  String transactionIDString() {
    return Base32Encoder.encodeNoPaddingBytes(transactionID());
  }
}
