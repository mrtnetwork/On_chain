// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors, unused_import

import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import '../../utils/utils.dart';

/// Candid type alias `GetArchivesResult`.
typedef ICRC3GetArchivesResult = List<ICRC3GetArchivesResultItem>;

/// CType for alias `GetArchivesResult`.
abstract final class ICRC3GetArchivesResultCandid {
  static CType get ctype => CType.vec(ICRC3GetArchivesResultItem.ctype);
}

/// Candid type alias `GetBlocksArgs`.
typedef ICRC3GetBlocksArgs = List<ICRC3GetBlocksArgsItem>;

/// CType for alias `GetBlocksArgs`.
abstract final class ICRC3GetBlocksArgsCandid {
  static CType get ctype => CType.vec(ICRC3GetBlocksArgsItem.ctype);
}

/// Candid record `ICRC3Value.Map`.
final class ICRC3ValueMap with CandidSerializable {
  final String field0;
  final ICRC3Value field1;

  const ICRC3ValueMap({required this.field0, required this.field1});

  static CType get ctype => CType.record([
    Field(Label.id(0), CType.text),
    LazyField(Label.id(1), () => ICRC3Value.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'0': field0, '1': field1.candidValue};

  Map<String, dynamic> toJson() => {'0': field0, '1': field1.toJson()};

  factory ICRC3ValueMap.fromCandid(Map<String, dynamic> json) {
    return ICRC3ValueMap(
      field0: json.valueAsString<String>('0'),
      field1: json.valueTo<ICRC3Value, Map>(
        key: '1',
        parse:
            (e) => ICRC3Value.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory ICRC3ValueMap.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC3ValueMap.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ICRC3GetArchivesResult.item`.
final class ICRC3GetArchivesResultItem with CandidSerializable {
  final IcpPrincipalAddress canisterId;
  final BigInt start;
  final BigInt end;

  const ICRC3GetArchivesResultItem({
    required this.canisterId,
    required this.start,
    required this.end,
  });

  static CType get ctype => CType.record([
    Field(Label.named('canister_id'), CType.principal),
    Field(Label.named('start'), CType.nat),
    Field(Label.named('end'), CType.nat),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'canister_id': canisterId,
    'start': start,
    'end': end,
  };

  Map<String, dynamic> toJson() => {
    'canister_id': canisterId.address,
    'start': start,
    'end': end,
  };

  factory ICRC3GetArchivesResultItem.fromCandid(Map<String, dynamic> json) {
    return ICRC3GetArchivesResultItem(
      canisterId: json.valueTo<IcpPrincipalAddress, dynamic>(
        key: 'canister_id',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
      start: json.valueAsBigInt<BigInt>('start'),
      end: json.valueAsBigInt<BigInt>('end'),
    );
  }

  factory ICRC3GetArchivesResultItem.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC3GetArchivesResultItem.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ICRC3GetBlocksArgs.item`.
final class ICRC3GetBlocksArgsItem with CandidSerializable {
  final BigInt start;
  final BigInt length;

  const ICRC3GetBlocksArgsItem({required this.start, required this.length});

  static CType get ctype => CType.record([
    Field(Label.named('start'), CType.nat),
    Field(Label.named('length'), CType.nat),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'start': start, 'length': length};

  Map<String, dynamic> toJson() => {'start': start, 'length': length};

  factory ICRC3GetBlocksArgsItem.fromCandid(Map<String, dynamic> json) {
    return ICRC3GetBlocksArgsItem(
      start: json.valueAsBigInt<BigInt>('start'),
      length: json.valueAsBigInt<BigInt>('length'),
    );
  }

  factory ICRC3GetBlocksArgsItem.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC3GetBlocksArgsItem.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ICRC3GetBlocksResult.blocks`.
final class ICRC3GetBlocksResultBlocks with CandidSerializable {
  final BigInt id;
  final ICRC3Value block;

  const ICRC3GetBlocksResultBlocks({required this.id, required this.block});

  static CType get ctype => CType.record([
    Field(Label.named('id'), CType.nat),
    LazyField(Label.named('block'), () => ICRC3Value.ctype),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'id': id, 'block': block.candidValue};

  Map<String, dynamic> toJson() => {'id': id, 'block': block.toJson()};

  factory ICRC3GetBlocksResultBlocks.fromCandid(Map<String, dynamic> json) {
    return ICRC3GetBlocksResultBlocks(
      id: json.valueAsBigInt<BigInt>('id'),
      block: json.valueTo<ICRC3Value, Map>(
        key: 'block',
        parse:
            (e) => ICRC3Value.fromCandid(
              JsonParser.valueEnsureAsMap<String, dynamic>(e),
            ),
      ),
    );
  }

  factory ICRC3GetBlocksResultBlocks.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC3GetBlocksResultBlocks.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ICRC3GetBlocksResult.archived_blocks`.
final class ICRC3GetBlocksResultArchivedBlocks with CandidSerializable {
  final ICRC3GetBlocksArgs args;
  final FuncRef callback;

  const ICRC3GetBlocksResultArchivedBlocks({
    required this.args,
    required this.callback,
  });

  static CType get ctype => CType.record([
    LazyField(Label.named('args'), () => ICRC3GetBlocksArgsCandid.ctype),
    Field(Label.named('callback'), CType.func(const FunctionType([], [], []))),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'args': args.map((el) => el.candidValue).toList(),
    'callback': callback,
  };

  Map<String, dynamic> toJson() => {
    'args': args.map((el) => el.toJson()).toList(),
    'callback': callback,
  };

  factory ICRC3GetBlocksResultArchivedBlocks.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC3GetBlocksResultArchivedBlocks(
      args: json.valueTo<List<ICRC3GetBlocksArgsItem>, List>(
        key: 'args',
        parse:
            (e) =>
                e
                    .map<ICRC3GetBlocksArgsItem>(
                      (x) => ICRC3GetBlocksArgsItem.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      callback: json['callback'],
    );
  }

  factory ICRC3GetBlocksResultArchivedBlocks.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC3GetBlocksResultArchivedBlocks.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `ICRC3Icrc3SupportedBlockTypes.response`.
final class ICRC3Icrc3SupportedBlockTypesResponse with CandidSerializable {
  final String blockType;
  final String url;

  const ICRC3Icrc3SupportedBlockTypesResponse({
    required this.blockType,
    required this.url,
  });

  static CType get ctype => CType.record([
    Field(Label.named('block_type'), CType.text),
    Field(Label.named('url'), CType.text),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'block_type': blockType, 'url': url};

  Map<String, dynamic> toJson() => {'block_type': blockType, 'url': url};

  factory ICRC3Icrc3SupportedBlockTypesResponse.fromCandid(
    Map<String, dynamic> json,
  ) {
    return ICRC3Icrc3SupportedBlockTypesResponse(
      blockType: json.valueAsString<String>('block_type'),
      url: json.valueAsString<String>('url'),
    );
  }

  factory ICRC3Icrc3SupportedBlockTypesResponse.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC3Icrc3SupportedBlockTypesResponse.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid variant `Value`.
sealed class ICRC3Value with CandidSerializable {
  const ICRC3Value();

  static CType get ctype => CType.variant([
    Field(Label.named('Blob'), CType.vec(CType.nat8)),
    Field(Label.named('Text'), CType.text),
    Field(Label.named('Nat'), CType.nat),
    Field(Label.named('Int'), CType.int_),
    LazyField(Label.named('Array'), () => CType.vec(ICRC3Value.ctype)),
    LazyField(Label.named('Map'), () => CType.vec(ICRC3ValueMap.ctype)),
  ]);

  @override
  CType get candidType => ctype;

  Map<String, dynamic> toJson();

  factory ICRC3Value.fromCandid(Map<String, dynamic> json) {
    if (json.containsKey('Blob')) {
      return ICRC3ValueBlob(
        json.valueAsBytes<List<int>>('Blob', encoding: StringEncoding.base64),
      );
    }
    if (json.containsKey('Text')) {
      return ICRC3ValueText(json.valueAsString<String>('Text'));
    }
    if (json.containsKey('Nat')) {
      return ICRC3ValueNat(json.valueAsBigInt<BigInt>('Nat'));
    }
    if (json.containsKey('Int')) {
      return ICRC3ValueInt(json.valueAsBigInt<BigInt>('Int'));
    }
    if (json.containsKey('Array')) {
      return ICRC3ValueArray(
        json.valueTo<List<ICRC3Value>, List>(
          key: 'Array',
          parse:
              (e) =>
                  e
                      .map<ICRC3Value>(
                        (x) => ICRC3Value.fromCandid(
                          JsonParser.valueEnsureAsMap<String, dynamic>(x),
                        ),
                      )
                      .toList(),
        ),
      );
    }
    if (json.containsKey('Map')) {
      return ICRC3ValueMap2(
        json.valueTo<List<ICRC3ValueMap>, List>(
          key: 'Map',
          parse:
              (e) =>
                  e
                      .map<ICRC3ValueMap>(
                        (x) => ICRC3ValueMap.fromCandid(
                          JsonParser.valueEnsureAsMap<String, dynamic>(x),
                        ),
                      )
                      .toList(),
        ),
      );
    }
    throw OnChainErrors.icpCandid(
      'ICRC3Value.fromCandid',
      reason: 'Unknown ICRC3Value arm',
    );
  }

  factory ICRC3Value.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC3Value.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Variant arm `Value.Blob`.
final class ICRC3ValueBlob extends ICRC3Value {
  final List<int> value;
  const ICRC3ValueBlob(this.value);

  @override
  CType get candidType => ICRC3Value.ctype;

  @override
  dynamic get candidValue => Variant('Blob', value);

  @override
  Map<String, dynamic> toJson() => {'Blob': value};
}

/// Variant arm `Value.Text`.
final class ICRC3ValueText extends ICRC3Value {
  final String value;
  const ICRC3ValueText(this.value);

  @override
  CType get candidType => ICRC3Value.ctype;

  @override
  dynamic get candidValue => Variant('Text', value);

  @override
  Map<String, dynamic> toJson() => {'Text': value};
}

/// Variant arm `Value.Nat`.
final class ICRC3ValueNat extends ICRC3Value {
  final BigInt value;
  const ICRC3ValueNat(this.value);

  @override
  CType get candidType => ICRC3Value.ctype;

  @override
  dynamic get candidValue => Variant('Nat', value);

  @override
  Map<String, dynamic> toJson() => {'Nat': value};
}

/// Variant arm `Value.Int`.
final class ICRC3ValueInt extends ICRC3Value {
  final BigInt value;
  const ICRC3ValueInt(this.value);

  @override
  CType get candidType => ICRC3Value.ctype;

  @override
  dynamic get candidValue => Variant('Int', value);

  @override
  Map<String, dynamic> toJson() => {'Int': value};
}

/// Variant arm `Value.Array`.
final class ICRC3ValueArray extends ICRC3Value {
  final List<ICRC3Value> value;
  const ICRC3ValueArray(this.value);

  @override
  CType get candidType => ICRC3Value.ctype;

  @override
  dynamic get candidValue =>
      Variant('Array', value.map((el) => el.candidValue).toList());

  @override
  Map<String, dynamic> toJson() => {
    'Array': value.map((el) => el.toJson()).toList(),
  };
}

/// Variant arm `Value.Map`.
final class ICRC3ValueMap2 extends ICRC3Value {
  final List<ICRC3ValueMap> value;
  const ICRC3ValueMap2(this.value);

  @override
  CType get candidType => ICRC3Value.ctype;

  @override
  dynamic get candidValue =>
      Variant('Map', value.map((el) => el.candidValue).toList());

  @override
  Map<String, dynamic> toJson() => {
    'Map': value.map((el) => el.toJson()).toList(),
  };
}

/// Candid record `GetArchivesArgs`.
final class ICRC3GetArchivesArgs with CandidSerializable {
  final IcpPrincipalAddress? from;

  const ICRC3GetArchivesArgs({this.from});

  static CType get ctype =>
      CType.record([Field(Label.named('from'), CType.opt(CType.principal))]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {'from': from};

  Map<String, dynamic> toJson() => {'from': from?.address};

  factory ICRC3GetArchivesArgs.fromCandid(Map<String, dynamic> json) {
    return ICRC3GetArchivesArgs(
      from: json.valueTo<IcpPrincipalAddress?, dynamic>(
        key: 'from',
        parse: (e) => GeneratorParserUtils.principalFromCandid(e),
      ),
    );
  }

  factory ICRC3GetArchivesArgs.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC3GetArchivesArgs.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `GetBlocksResult`.
final class ICRC3GetBlocksResult with CandidSerializable {
  final BigInt logLength;
  final List<ICRC3GetBlocksResultBlocks> blocks;
  final List<ICRC3GetBlocksResultArchivedBlocks> archivedBlocks;

  const ICRC3GetBlocksResult({
    required this.logLength,
    required this.blocks,
    required this.archivedBlocks,
  });

  static CType get ctype => CType.record([
    Field(Label.named('log_length'), CType.nat),
    LazyField(
      Label.named('blocks'),
      () => CType.vec(ICRC3GetBlocksResultBlocks.ctype),
    ),
    LazyField(
      Label.named('archived_blocks'),
      () => CType.vec(ICRC3GetBlocksResultArchivedBlocks.ctype),
    ),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'log_length': logLength,
    'blocks': blocks.map((el) => el.candidValue).toList(),
    'archived_blocks': archivedBlocks.map((el) => el.candidValue).toList(),
  };

  Map<String, dynamic> toJson() => {
    'log_length': logLength,
    'blocks': blocks.map((el) => el.toJson()).toList(),
    'archived_blocks': archivedBlocks.map((el) => el.toJson()).toList(),
  };

  factory ICRC3GetBlocksResult.fromCandid(Map<String, dynamic> json) {
    return ICRC3GetBlocksResult(
      logLength: json.valueAsBigInt<BigInt>('log_length'),
      blocks: json.valueTo<List<ICRC3GetBlocksResultBlocks>, List>(
        key: 'blocks',
        parse:
            (e) =>
                e
                    .map<ICRC3GetBlocksResultBlocks>(
                      (x) => ICRC3GetBlocksResultBlocks.fromCandid(
                        JsonParser.valueEnsureAsMap<String, dynamic>(x),
                      ),
                    )
                    .toList(),
      ),
      archivedBlocks: json
          .valueTo<List<ICRC3GetBlocksResultArchivedBlocks>, List>(
            key: 'archived_blocks',
            parse:
                (e) =>
                    e
                        .map<ICRC3GetBlocksResultArchivedBlocks>(
                          (x) => ICRC3GetBlocksResultArchivedBlocks.fromCandid(
                            JsonParser.valueEnsureAsMap<String, dynamic>(x),
                          ),
                        )
                        .toList(),
          ),
    );
  }

  factory ICRC3GetBlocksResult.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC3GetBlocksResult.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}

/// Candid record `DataCertificate`.
final class ICRC3DataCertificate with CandidSerializable {
  final List<int> certificate;
  final List<int> hashTree;

  const ICRC3DataCertificate({
    required this.certificate,
    required this.hashTree,
  });

  static CType get ctype => CType.record([
    Field(Label.named('certificate'), CType.vec(CType.nat8)),
    Field(Label.named('hash_tree'), CType.vec(CType.nat8)),
  ]);

  @override
  CType get candidType => ctype;

  @override
  dynamic get candidValue => {
    'certificate': certificate,
    'hash_tree': hashTree,
  };

  Map<String, dynamic> toJson() => {
    'certificate': certificate,
    'hash_tree': hashTree,
  };

  factory ICRC3DataCertificate.fromCandid(Map<String, dynamic> json) {
    return ICRC3DataCertificate(
      certificate: json.valueAsBytes<List<int>>(
        'certificate',
        encoding: StringEncoding.base64,
      ),
      hashTree: json.valueAsBytes<List<int>>(
        'hash_tree',
        encoding: StringEncoding.base64,
      ),
    );
  }

  factory ICRC3DataCertificate.fromBytes(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, ctype);
    return ICRC3DataCertificate.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(raw),
    );
  }
}
