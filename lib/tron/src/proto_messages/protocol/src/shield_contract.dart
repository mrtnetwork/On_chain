import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/proto_messages/types.dart';
import 'package:on_chain/tron/src/serialization/protobuf/proto.dart';

/// Specify the name of the package that generated the Java file
/// option java_outer_classname = "ShieldedTransferContract"; //Specify the class name of the generated Java file
/// for shielded transaction
class TronAuthenticationPath extends TronProtoMessage {
  final List<bool> value;

  const TronAuthenticationPath({this.value = const []});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.bool,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [value];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {'value': value.map((e) => e).toList()}.notNullValue;
  }

  factory TronAuthenticationPath.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronAuthenticationPath(
      value:
          (json.valueEnsureAsList<dynamic>(
            'value',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => JsonParser.valueAsBool<bool>(e)).toList(),
    );
  }

  factory TronAuthenticationPath.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronAuthenticationPath(value: decode.getListOrEmpty<bool>(1));
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolAuthenticationPath;
}

class TronMerklePath extends TronProtoMessage {
  final List<TronAuthenticationPath> authenticationPaths;

  final List<bool> index;

  final List<int>? rt;

  const TronMerklePath({
    this.authenticationPaths = const [],
    this.index = const [],
    this.rt,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.bool,
        ),
        ProtoFieldConfig.bytes(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [authenticationPaths, index, rt];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'authentication_paths':
          authenticationPaths.map((e) => config.encodeMessage(e)).toList(),
      'index': index.map((e) => e).toList(),
      'rt': config.encodeBinary(rt),
    }.notNullValue;
  }

  factory TronMerklePath.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronMerklePath(
      authenticationPaths:
          (json.valueEnsureAsList<dynamic>(
                'authentication_paths',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronAuthenticationPath, Object>(
                  value: e,
                  parse:
                      (v) => TronAuthenticationPath.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      index:
          (json.valueEnsureAsList<dynamic>(
            'index',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => JsonParser.valueAsBool<bool>(e)).toList(),
      rt: config.decodeBinary<List<int>?>(
        json.valueAs('rt', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronMerklePath.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronMerklePath(
      authenticationPaths:
          decode
              .getListOfBytes(1)
              .map((b) => TronAuthenticationPath.deserialize(b))
              .toList(),
      index: decode.getListOrEmpty<bool>(2),
      rt: decode.getBytes<List<int>?>(3),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolMerklePath;
}

class TronOutputPoint extends TronProtoMessage {
  final List<int>? hash;

  final int? index;

  const TronOutputPoint({this.hash, this.index});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bytes(1), ProtoFieldConfig.int32(2)],
    );
  }

  @override
  List<Object?> get protoValues => [hash, index];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {'hash': config.encodeBinary(hash), 'index': index}.notNullValue;
  }

  factory TronOutputPoint.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronOutputPoint(
      hash: config.decodeBinary<List<int>?>(
        json.valueAs('hash', normalizeKeyLookup: config.normalizeKeys),
      ),
      index: json.valueAsInt<int?>(
        'index',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronOutputPoint.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronOutputPoint(
      hash: decode.getBytes<List<int>?>(1),
      index: decode.getInt<int?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolOutputPoint;
}

class TronOutputPointInfo extends TronProtoMessage {
  final List<TronOutputPoint> outPoints;

  final int? blockNum;

  const TronOutputPointInfo({this.outPoints = const [], this.blockNum});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.int32(2),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [outPoints, blockNum];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'out_points': outPoints.map((e) => config.encodeMessage(e)).toList(),
      'block_num': blockNum,
    }.notNullValue;
  }

  factory TronOutputPointInfo.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronOutputPointInfo(
      outPoints:
          (json.valueEnsureAsList<dynamic>(
                'out_points',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronOutputPoint, Object>(
                  value: e,
                  parse:
                      (v) => TronOutputPoint.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      blockNum: json.valueAsInt<int?>(
        'block_num',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronOutputPointInfo.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronOutputPointInfo(
      outPoints:
          decode
              .getListOfBytes(1)
              .map((b) => TronOutputPoint.deserialize(b))
              .toList(),
      blockNum: decode.getInt<int?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolOutputPointInfo;
}

class TronPedersenHash extends TronProtoMessage {
  final List<int>? content;

  const TronPedersenHash({this.content});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bytes(1)],
    );
  }

  @override
  List<Object?> get protoValues => [content];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {'content': config.encodeBinary(content)}.notNullValue;
  }

  factory TronPedersenHash.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronPedersenHash(
      content: config.decodeBinary<List<int>?>(
        json.valueAs('content', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronPedersenHash.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronPedersenHash(content: decode.getBytes<List<int>?>(1));
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolPedersenHash;
}

class TronIncrementalMerkleTree extends TronProtoMessage {
  final TronPedersenHash? left;

  final TronPedersenHash? right;

  final List<TronPedersenHash> parents;

  const TronIncrementalMerkleTree({
    this.left,
    this.right,
    this.parents = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.message,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [left, right, parents];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'left': config.encodeMessage(left),
      'right': config.encodeMessage(right),
      'parents': parents.map((e) => config.encodeMessage(e)).toList(),
    }.notNullValue;
  }

  factory TronIncrementalMerkleTree.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronIncrementalMerkleTree(
      left: json.valueTo<TronPedersenHash?, Object>(
        key: 'left',
        parse:
            (v) => TronPedersenHash.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      right: json.valueTo<TronPedersenHash?, Object>(
        key: 'right',
        parse:
            (v) => TronPedersenHash.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      parents:
          (json.valueEnsureAsList<dynamic>(
                'parents',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronPedersenHash, Object>(
                  value: e,
                  parse:
                      (v) => TronPedersenHash.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory TronIncrementalMerkleTree.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronIncrementalMerkleTree(
      left: decode.messageTo<TronPedersenHash?>(
        1,
        (b) => TronPedersenHash.deserialize(b),
      ),
      right: decode.messageTo<TronPedersenHash?>(
        2,
        (b) => TronPedersenHash.deserialize(b),
      ),
      parents:
          decode
              .getListOfBytes(3)
              .map((b) => TronPedersenHash.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolIncrementalMerkleTree;
}

class TronIncrementalMerkleVoucher extends TronProtoMessage {
  final TronIncrementalMerkleTree? tree;

  final List<TronPedersenHash> filled;

  final TronIncrementalMerkleTree? cursor;

  final BigInt? cursorDepth;

  final List<int>? rt;

  final TronOutputPoint? outputPoint;

  const TronIncrementalMerkleVoucher({
    this.tree,
    this.filled = const [],
    this.cursor,
    this.cursorDepth,
    this.rt,
    this.outputPoint,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.int64(4),
        ProtoFieldConfig.bytes(5),
        ProtoFieldConfig.message(10),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    tree,
    filled,
    cursor,
    cursorDepth,
    rt,
    outputPoint,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'tree': config.encodeMessage(tree),
      'filled': filled.map((e) => config.encodeMessage(e)).toList(),
      'cursor': config.encodeMessage(cursor),
      'cursor_depth': config.encodeBigint(cursorDepth),
      'rt': config.encodeBinary(rt),
      'output_point': config.encodeMessage(outputPoint),
    }.notNullValue;
  }

  factory TronIncrementalMerkleVoucher.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronIncrementalMerkleVoucher(
      tree: json.valueTo<TronIncrementalMerkleTree?, Object>(
        key: 'tree',
        parse:
            (v) => TronIncrementalMerkleTree.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      filled:
          (json.valueEnsureAsList<dynamic>(
                'filled',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronPedersenHash, Object>(
                  value: e,
                  parse:
                      (v) => TronPedersenHash.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      cursor: json.valueTo<TronIncrementalMerkleTree?, Object>(
        key: 'cursor',
        parse:
            (v) => TronIncrementalMerkleTree.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      cursorDepth: json.valueAsBigInt<BigInt?>(
        'cursor_depth',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      rt: config.decodeBinary<List<int>?>(
        json.valueAs('rt', normalizeKeyLookup: config.normalizeKeys),
      ),
      outputPoint: json.valueTo<TronOutputPoint?, Object>(
        key: 'output_point',
        parse:
            (v) =>
                TronOutputPoint.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronIncrementalMerkleVoucher.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronIncrementalMerkleVoucher(
      tree: decode.messageTo<TronIncrementalMerkleTree?>(
        1,
        (b) => TronIncrementalMerkleTree.deserialize(b),
      ),
      filled:
          decode
              .getListOfBytes(2)
              .map((b) => TronPedersenHash.deserialize(b))
              .toList(),
      cursor: decode.messageTo<TronIncrementalMerkleTree?>(
        3,
        (b) => TronIncrementalMerkleTree.deserialize(b),
      ),
      cursorDepth: decode.getBigInt<BigInt?>(4),
      rt: decode.getBytes<List<int>?>(5),
      outputPoint: decode.messageTo<TronOutputPoint?>(
        10,
        (b) => TronOutputPoint.deserialize(b),
      ),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolIncrementalMerkleVoucher;
}

class TronIncrementalMerkleVoucherInfo extends TronProtoMessage {
  final List<TronIncrementalMerkleVoucher> vouchers;

  final List<List<int>> paths;

  const TronIncrementalMerkleVoucherInfo({
    this.vouchers = const [],
    this.paths = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.bytes,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [vouchers, paths];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'vouchers': vouchers.map((e) => config.encodeMessage(e)).toList(),
      'paths': paths.map((e) => config.encodeBinary(e)).toList(),
    }.notNullValue;
  }

  factory TronIncrementalMerkleVoucherInfo.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronIncrementalMerkleVoucherInfo(
      vouchers:
          (json.valueEnsureAsList<dynamic>(
                'vouchers',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronIncrementalMerkleVoucher, Object>(
                  value: e,
                  parse:
                      (v) => TronIncrementalMerkleVoucher.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      paths:
          (json.valueEnsureAsList<dynamic>(
            'paths',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => config.decodeBinary<List<int>>(e)).toList(),
    );
  }

  factory TronIncrementalMerkleVoucherInfo.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronIncrementalMerkleVoucherInfo(
      vouchers:
          decode
              .getListOfBytes(1)
              .map((b) => TronIncrementalMerkleVoucher.deserialize(b))
              .toList(),
      paths: decode.getListOfBytes(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolIncrementalMerkleVoucherInfo;
}

class TronSpendDescription extends TronProtoMessage {
  final List<int>? valueCommitment;

  final List<int>? anchor;

  /// merkle root
  final List<int>? nullifier;

  /// used for check double spend
  final List<int>? rk;

  /// used for check spend authority signature
  final List<int>? zkproof;

  final List<int>? spendAuthoritySignature;

  const TronSpendDescription({
    this.valueCommitment,
    this.anchor,
    this.nullifier,
    this.rk,
    this.zkproof,
    this.spendAuthoritySignature,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.bytes(4),
        ProtoFieldConfig.bytes(5),
        ProtoFieldConfig.bytes(6),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    valueCommitment,
    anchor,
    nullifier,
    rk,
    zkproof,
    spendAuthoritySignature,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'value_commitment': config.encodeBinary(valueCommitment),
      'anchor': config.encodeBinary(anchor),
      'nullifier': config.encodeBinary(nullifier),
      'rk': config.encodeBinary(rk),
      'zkproof': config.encodeBinary(zkproof),
      'spend_authority_signature': config.encodeBinary(spendAuthoritySignature),
    }.notNullValue;
  }

  factory TronSpendDescription.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronSpendDescription(
      valueCommitment: config.decodeBinary<List<int>?>(
        json.valueAs(
          'value_commitment',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      anchor: config.decodeBinary<List<int>?>(
        json.valueAs('anchor', normalizeKeyLookup: config.normalizeKeys),
      ),
      nullifier: config.decodeBinary<List<int>?>(
        json.valueAs('nullifier', normalizeKeyLookup: config.normalizeKeys),
      ),
      rk: config.decodeBinary<List<int>?>(
        json.valueAs('rk', normalizeKeyLookup: config.normalizeKeys),
      ),
      zkproof: config.decodeBinary<List<int>?>(
        json.valueAs('zkproof', normalizeKeyLookup: config.normalizeKeys),
      ),
      spendAuthoritySignature: config.decodeBinary<List<int>?>(
        json.valueAs(
          'spend_authority_signature',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
    );
  }

  factory TronSpendDescription.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronSpendDescription(
      valueCommitment: decode.getBytes<List<int>?>(1),
      anchor: decode.getBytes<List<int>?>(2),
      nullifier: decode.getBytes<List<int>?>(3),
      rk: decode.getBytes<List<int>?>(4),
      zkproof: decode.getBytes<List<int>?>(5),
      spendAuthoritySignature: decode.getBytes<List<int>?>(6),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolSpendDescription;
}

class TronReceiveDescription extends TronProtoMessage {
  final List<int>? valueCommitment;

  final List<int>? noteCommitment;

  final List<int>? epk;

  /// for Encryption
  final List<int>? cEnc;

  /// Encryption for incoming, decrypt it with ivk
  final List<int>? cOut;

  /// Encryption for audit, decrypt it with ovk
  final List<int>? zkproof;

  const TronReceiveDescription({
    this.valueCommitment,
    this.noteCommitment,
    this.epk,
    this.cEnc,
    this.cOut,
    this.zkproof,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.bytes(4),
        ProtoFieldConfig.bytes(5),
        ProtoFieldConfig.bytes(6),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    valueCommitment,
    noteCommitment,
    epk,
    cEnc,
    cOut,
    zkproof,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'value_commitment': config.encodeBinary(valueCommitment),
      'note_commitment': config.encodeBinary(noteCommitment),
      'epk': config.encodeBinary(epk),
      'c_enc': config.encodeBinary(cEnc),
      'c_out': config.encodeBinary(cOut),
      'zkproof': config.encodeBinary(zkproof),
    }.notNullValue;
  }

  factory TronReceiveDescription.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronReceiveDescription(
      valueCommitment: config.decodeBinary<List<int>?>(
        json.valueAs(
          'value_commitment',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      noteCommitment: config.decodeBinary<List<int>?>(
        json.valueAs(
          'note_commitment',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      epk: config.decodeBinary<List<int>?>(
        json.valueAs('epk', normalizeKeyLookup: config.normalizeKeys),
      ),
      cEnc: config.decodeBinary<List<int>?>(
        json.valueAs('c_enc', normalizeKeyLookup: config.normalizeKeys),
      ),
      cOut: config.decodeBinary<List<int>?>(
        json.valueAs('c_out', normalizeKeyLookup: config.normalizeKeys),
      ),
      zkproof: config.decodeBinary<List<int>?>(
        json.valueAs('zkproof', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronReceiveDescription.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronReceiveDescription(
      valueCommitment: decode.getBytes<List<int>?>(1),
      noteCommitment: decode.getBytes<List<int>?>(2),
      epk: decode.getBytes<List<int>?>(3),
      cEnc: decode.getBytes<List<int>?>(4),
      cOut: decode.getBytes<List<int>?>(5),
      zkproof: decode.getBytes<List<int>?>(6),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolReceiveDescription;
}

class TronWalletGetMerkleTreeVoucherInfo extends TronProtoMessage
    with ITronProtoServiceMessage<TronIncrementalMerkleVoucherInfo> {
  final TronProtoJsonConfig jsonConfig;

  final TronOutputPointInfo? getMerkleTreeVoucherInfo;

  const TronWalletGetMerkleTreeVoucherInfo({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getMerkleTreeVoucherInfo,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getMerkleTreeVoucherInfo?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getMerkleTreeVoucherInfo?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getMerkleTreeVoucherInfo) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetMerkleTreeVoucherInfo;
  @override
  TronIncrementalMerkleVoucherInfo onServiceResponse(List<int> bytes) {
    return TronIncrementalMerkleVoucherInfo.deserialize(bytes);
  }

  @override
  TronIncrementalMerkleVoucherInfo onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return TronIncrementalMerkleVoucherInfo.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityGetMerkleTreeVoucherInfo extends TronProtoMessage
    with ITronProtoServiceMessage<TronIncrementalMerkleVoucherInfo> {
  final TronProtoJsonConfig jsonConfig;

  final TronOutputPointInfo? getMerkleTreeVoucherInfo;

  const TronWalletSolidityGetMerkleTreeVoucherInfo({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getMerkleTreeVoucherInfo,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getMerkleTreeVoucherInfo?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getMerkleTreeVoucherInfo?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getMerkleTreeVoucherInfo) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityGetMerkleTreeVoucherInfo;
  @override
  TronIncrementalMerkleVoucherInfo onServiceResponse(List<int> bytes) {
    return TronIncrementalMerkleVoucherInfo.deserialize(bytes);
  }

  @override
  TronIncrementalMerkleVoucherInfo onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return TronIncrementalMerkleVoucherInfo.fromJson(json, config: jsonConfig);
  }
}
