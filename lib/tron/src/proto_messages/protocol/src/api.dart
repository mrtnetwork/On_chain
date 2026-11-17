import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/proto_messages/types.dart';
import 'package:on_chain/tron/src/serialization/protobuf/proto.dart';
import "package:on_chain/tron/src/proto_messages/protocol/src/tron.dart"
    as protocol_tron;
import "package:on_chain/tron/src/models/contracts/contracts.dart"
    as protocol_contracts;
import "package:on_chain/tron/src/proto_messages/protocol/src/shield_contract.dart"
    as protocol_shield_contract;
import "package:on_chain/tron/src/proto_messages/protocol/src/smart_contract.dart"
    as protocol_smart_contract;

enum TronReturnresponseCode implements ProtoEnumVariant {
  success(0, 'SUCCESS'),
  sigerror(1, 'SIGERROR'),

  /// error in signature
  contractValidateError(2, 'CONTRACT_VALIDATE_ERROR'),
  contractExeError(3, 'CONTRACT_EXE_ERROR'),
  bandwithError(4, 'BANDWITH_ERROR'),
  dupTransactionError(5, 'DUP_TRANSACTION_ERROR'),
  taposError(6, 'TAPOS_ERROR'),
  tooBigTransactionError(7, 'TOO_BIG_TRANSACTION_ERROR'),
  transactionExpirationError(8, 'TRANSACTION_EXPIRATION_ERROR'),
  serverBusy(9, 'SERVER_BUSY'),
  noConnection(10, 'NO_CONNECTION'),
  notEnoughEffectiveConnection(11, 'NOT_ENOUGH_EFFECTIVE_CONNECTION'),
  blockUnsolidified(12, 'BLOCK_UNSOLIDIFIED'),
  otherError(20, 'OTHER_ERROR');

  const TronReturnresponseCode(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static TronReturnresponseCode fromValue(int? value) {
    value ??= 0;
    return TronReturnresponseCode.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TronReturnresponseCode found for the given value. $value",
                details: {
                  "name": "TronReturnresponseCode",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static TronReturnresponseCode from(Object? value) {
    value ??= 0;
    return TronReturnresponseCode.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TronReturnresponseCode found for the given value. $value",
                details: {
                  "name": "TronReturnresponseCode",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

enum TronTransactionSignWeightResultresponseCode implements ProtoEnumVariant {
  enoughPermission(0, 'ENOUGH_PERMISSION'),
  notEnoughPermission(1, 'NOT_ENOUGH_PERMISSION'),

  /// error in
  signatureFormatError(2, 'SIGNATURE_FORMAT_ERROR'),
  computeAddressError(3, 'COMPUTE_ADDRESS_ERROR'),
  permissionError(4, 'PERMISSION_ERROR'),

  /// The key is not in permission
  otherError(20, 'OTHER_ERROR');

  const TronTransactionSignWeightResultresponseCode(this.value, this.protoName);

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static TronTransactionSignWeightResultresponseCode fromValue(int? value) {
    value ??= 0;
    return TronTransactionSignWeightResultresponseCode.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TronTransactionSignWeightResultresponseCode found for the given value. $value",
                details: {
                  "name": "TronTransactionSignWeightResultresponseCode",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static TronTransactionSignWeightResultresponseCode from(Object? value) {
    value ??= 0;
    return TronTransactionSignWeightResultresponseCode.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TronTransactionSignWeightResultresponseCode found for the given value. $value",
                details: {
                  "name": "TronTransactionSignWeightResultresponseCode",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

enum TronTransactionApprovedListResultresponseCode implements ProtoEnumVariant {
  success(0, 'SUCCESS'),
  signatureFormatError(1, 'SIGNATURE_FORMAT_ERROR'),
  computeAddressError(2, 'COMPUTE_ADDRESS_ERROR'),
  otherError(20, 'OTHER_ERROR');

  const TronTransactionApprovedListResultresponseCode(
    this.value,
    this.protoName,
  );

  /// The original proto wire value for this enum constant.
  @override
  final int value;

  /// The original proto identifier, e.g. "VOTE_OPTION_UNSPECIFIED".
  @override
  final String protoName;

  /// Looks up a value by its proto wire int. Throws if not found.
  static TronTransactionApprovedListResultresponseCode fromValue(int? value) {
    value ??= 0;
    return TronTransactionApprovedListResultresponseCode.values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TronTransactionApprovedListResultresponseCode found for the given value. $value",
                details: {
                  "name": "TronTransactionApprovedListResultresponseCode",
                  "value": value?.toString(),
                },
              ),
    );
  }

  /// Looks up a value by wire int, Dart enum name, or original proto
  /// name (whichever [value] happens to be). Throws if not found.
  static TronTransactionApprovedListResultresponseCode from(Object? value) {
    value ??= 0;
    return TronTransactionApprovedListResultresponseCode.values.firstWhere(
      (e) => e.value == value || e.name == value || e.protoName == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TronTransactionApprovedListResultresponseCode found for the given value. $value",
                details: {
                  "name": "TronTransactionApprovedListResultresponseCode",
                  "value": value?.toString(),
                },
              ),
    );
  }
}

class TronReturn extends TronProtoMessage {
  final bool? result;

  final TronReturnresponseCode? code;

  final List<int>? message;

  const TronReturn({this.result, this.code, this.message});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bool(1),
        ProtoFieldConfig.enumType(2),
        ProtoFieldConfig.bytes(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [result, code, message];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'result': result,
      'code': config.encodeEnum(code),
      'message': config.encodeBinary(message),
    }.notNullValue;
  }

  factory TronReturn.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronReturn(
      result: json.valueAsBool<bool?>(
        'result',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      code: json.valueTo<TronReturnresponseCode?, Object?>(
        key: 'code',
        parse: (v) => TronReturnresponseCode.from(v),
      ),
      message: config.decodeBinary<List<int>?>(
        json.valueAs('message', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronReturn.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronReturn(
      result: decode.getBool<bool?>(1),
      code: decode.getEnum<TronReturnresponseCode?>(
        2,
        TronReturnresponseCode.values,
      ),
      message: decode.getBytes<List<int>?>(3),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolReturn;
}

class TronBlockReference extends TronProtoMessage {
  final BigInt? blockNum;

  final List<int>? blockHash;

  const TronBlockReference({this.blockNum, this.blockHash});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.int64(1), ProtoFieldConfig.bytes(2)],
    );
  }

  @override
  List<Object?> get protoValues => [blockNum, blockHash];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'block_num': config.encodeBigint(blockNum),
      'block_hash': config.encodeBinary(blockHash),
    }.notNullValue;
  }

  factory TronBlockReference.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronBlockReference(
      blockNum: json.valueAsBigInt<BigInt?>(
        'block_num',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      blockHash: config.decodeBinary<List<int>?>(
        json.valueAs('block_hash', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronBlockReference.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronBlockReference(
      blockNum: decode.getBigInt<BigInt?>(1),
      blockHash: decode.getBytes<List<int>?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolBlockReference;
}

class TronWitnessList extends TronProtoMessage {
  final List<protocol_tron.TronWitness> witnesses;

  const TronWitnessList({this.witnesses = const []});

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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [witnesses];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'witnesses': witnesses.map((e) => config.encodeMessage(e)).toList(),
    }.notNullValue;
  }

  factory TronWitnessList.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronWitnessList(
      witnesses:
          (json.valueEnsureAsList<dynamic>(
                'witnesses',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<protocol_tron.TronWitness, Object>(
                  value: e,
                  parse:
                      (v) => protocol_tron.TronWitness.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory TronWitnessList.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronWitnessList(
      witnesses:
          decode
              .getListOfBytes(1)
              .map((b) => protocol_tron.TronWitness.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWitnessList;
}

class TronProposalList extends TronProtoMessage {
  final List<protocol_tron.TronProposal> proposals;

  const TronProposalList({this.proposals = const []});

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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [proposals];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'proposals': proposals.map((e) => config.encodeMessage(e)).toList(),
    }.notNullValue;
  }

  factory TronProposalList.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronProposalList(
      proposals:
          (json.valueEnsureAsList<dynamic>(
                'proposals',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<protocol_tron.TronProposal, Object>(
                  value: e,
                  parse:
                      (v) => protocol_tron.TronProposal.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory TronProposalList.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronProposalList(
      proposals:
          decode
              .getListOfBytes(1)
              .map((b) => protocol_tron.TronProposal.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolProposalList;
}

class TronExchangeList extends TronProtoMessage {
  final List<protocol_tron.TronExchange> exchanges;

  const TronExchangeList({this.exchanges = const []});

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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [exchanges];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'exchanges': exchanges.map((e) => config.encodeMessage(e)).toList(),
    }.notNullValue;
  }

  factory TronExchangeList.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronExchangeList(
      exchanges:
          (json.valueEnsureAsList<dynamic>(
                'exchanges',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<protocol_tron.TronExchange, Object>(
                  value: e,
                  parse:
                      (v) => protocol_tron.TronExchange.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory TronExchangeList.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronExchangeList(
      exchanges:
          decode
              .getListOfBytes(1)
              .map((b) => protocol_tron.TronExchange.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolExchangeList;
}

class TronAssetIssueList extends TronProtoMessage {
  final List<protocol_contracts.TronAssetIssueContract> assetIssue;

  const TronAssetIssueList({this.assetIssue = const []});

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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [assetIssue];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'assetIssue': assetIssue.map((e) => config.encodeMessage(e)).toList(),
    }.notNullValue;
  }

  factory TronAssetIssueList.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronAssetIssueList(
      assetIssue:
          (json.valueEnsureAsList<dynamic>(
                'assetIssue',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  protocol_contracts.TronAssetIssueContract,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => protocol_contracts.TronAssetIssueContract.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory TronAssetIssueList.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronAssetIssueList(
      assetIssue:
          decode
              .getListOfBytes(1)
              .map(
                (b) => protocol_contracts.TronAssetIssueContract.deserialize(b),
              )
              .toList(),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolAssetIssueList;
}

class TronBlockList extends TronProtoMessage {
  final List<protocol_tron.TronBlock> block;

  const TronBlockList({this.block = const []});

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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [block];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'block': block.map((e) => config.encodeMessage(e)).toList(),
    }.notNullValue;
  }

  factory TronBlockList.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronBlockList(
      block:
          (json.valueEnsureAsList<dynamic>(
                'block',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<protocol_tron.TronBlock, Object>(
                  value: e,
                  parse:
                      (v) => protocol_tron.TronBlock.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory TronBlockList.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronBlockList(
      block:
          decode
              .getListOfBytes(1)
              .map((b) => protocol_tron.TronBlock.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolBlockList;
}

class TronTransactionList extends TronProtoMessage {
  final List<protocol_contracts.TronTransaction> transaction;

  const TronTransactionList({this.transaction = const []});

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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [transaction];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'transaction': transaction.map((e) => config.encodeMessage(e)).toList(),
    }.notNullValue;
  }

  factory TronTransactionList.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronTransactionList(
      transaction:
          (json.valueEnsureAsList<dynamic>(
                'transaction',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  protocol_contracts.TronTransaction,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => protocol_contracts.TronTransaction.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory TronTransactionList.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronTransactionList(
      transaction:
          decode
              .getListOfBytes(1)
              .map((b) => protocol_contracts.TronTransaction.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolTransactionList;
}

class TronTransactionIdList extends TronProtoMessage {
  final List<String> txId;

  const TronTransactionIdList({this.txId = const []});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 1,
          elementType: ProtoFieldType.string,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [txId];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {'txId': txId.map((e) => e).toList()}.notNullValue;
  }

  factory TronTransactionIdList.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronTransactionIdList(
      txId:
          (json.valueEnsureAsList<dynamic>(
            'txId',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => JsonParser.valueAsString<String>(e)).toList(),
    );
  }

  factory TronTransactionIdList.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronTransactionIdList(txId: decode.getListOrEmpty<String>(1));
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolTransactionIdList;
}

class TronDelegatedResourceMessage extends TronProtoMessage {
  final List<int>? fromAddress;

  final List<int>? toAddress;

  const TronDelegatedResourceMessage({this.fromAddress, this.toAddress});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bytes(1), ProtoFieldConfig.bytes(2)],
    );
  }

  @override
  List<Object?> get protoValues => [fromAddress, toAddress];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'fromAddress': config.encodeBinary(fromAddress),
      'toAddress': config.encodeBinary(toAddress),
    }.notNullValue;
  }

  factory TronDelegatedResourceMessage.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronDelegatedResourceMessage(
      fromAddress: config.decodeBinary<List<int>?>(
        json.valueAs('fromAddress', normalizeKeyLookup: config.normalizeKeys),
      ),
      toAddress: config.decodeBinary<List<int>?>(
        json.valueAs('toAddress', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronDelegatedResourceMessage.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronDelegatedResourceMessage(
      fromAddress: decode.getBytes<List<int>?>(1),
      toAddress: decode.getBytes<List<int>?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolDelegatedResourceMessage;
}

class TronDelegatedResourceList extends TronProtoMessage {
  final List<protocol_tron.TronDelegatedResource> delegatedResource;

  const TronDelegatedResourceList({this.delegatedResource = const []});

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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [delegatedResource];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'delegatedResource':
          delegatedResource.map((e) => config.encodeMessage(e)).toList(),
    }.notNullValue;
  }

  factory TronDelegatedResourceList.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronDelegatedResourceList(
      delegatedResource:
          (json.valueEnsureAsList<dynamic>(
                'delegatedResource',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  protocol_tron.TronDelegatedResource,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => protocol_tron.TronDelegatedResource.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory TronDelegatedResourceList.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronDelegatedResourceList(
      delegatedResource:
          decode
              .getListOfBytes(1)
              .map((b) => protocol_tron.TronDelegatedResource.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolDelegatedResourceList;
}

class TronGetAvailableUnfreezeCountRequestMessage extends TronProtoMessage {
  final List<int>? ownerAddress;

  const TronGetAvailableUnfreezeCountRequestMessage({this.ownerAddress});

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
  List<Object?> get protoValues => [ownerAddress];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {'owner_address': config.encodeBinary(ownerAddress)}.notNullValue;
  }

  factory TronGetAvailableUnfreezeCountRequestMessage.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronGetAvailableUnfreezeCountRequestMessage(
      ownerAddress: config.decodeBinary<List<int>?>(
        json.valueAs('owner_address', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronGetAvailableUnfreezeCountRequestMessage.deserialize(
    List<int> bytes,
  ) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronGetAvailableUnfreezeCountRequestMessage(
      ownerAddress: decode.getBytes<List<int>?>(1),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolGetAvailableUnfreezeCountRequestMessage;
}

class TronGetAvailableUnfreezeCountResponseMessage extends TronProtoMessage {
  final BigInt? count;

  const TronGetAvailableUnfreezeCountResponseMessage({this.count});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.int64(1)],
    );
  }

  @override
  List<Object?> get protoValues => [count];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {'count': config.encodeBigint(count)}.notNullValue;
  }

  factory TronGetAvailableUnfreezeCountResponseMessage.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronGetAvailableUnfreezeCountResponseMessage(
      count: json.valueAsBigInt<BigInt?>(
        'count',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronGetAvailableUnfreezeCountResponseMessage.deserialize(
    List<int> bytes,
  ) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronGetAvailableUnfreezeCountResponseMessage(
      count: decode.getBigInt<BigInt?>(1),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolGetAvailableUnfreezeCountResponseMessage;
}

class TronCanDelegatedMaxSizeRequestMessage extends TronProtoMessage {
  final int? type;

  final List<int>? ownerAddress;

  const TronCanDelegatedMaxSizeRequestMessage({this.type, this.ownerAddress});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.int32(1), ProtoFieldConfig.bytes(2)],
    );
  }

  @override
  List<Object?> get protoValues => [type, ownerAddress];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'type': type,
      'owner_address': config.encodeBinary(ownerAddress),
    }.notNullValue;
  }

  factory TronCanDelegatedMaxSizeRequestMessage.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronCanDelegatedMaxSizeRequestMessage(
      type: json.valueAsInt<int?>(
        'type',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      ownerAddress: config.decodeBinary<List<int>?>(
        json.valueAs('owner_address', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronCanDelegatedMaxSizeRequestMessage.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronCanDelegatedMaxSizeRequestMessage(
      type: decode.getInt<int?>(1),
      ownerAddress: decode.getBytes<List<int>?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolCanDelegatedMaxSizeRequestMessage;
}

class TronCanDelegatedMaxSizeResponseMessage extends TronProtoMessage {
  final BigInt? maxSize;

  const TronCanDelegatedMaxSizeResponseMessage({this.maxSize});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.int64(1)],
    );
  }

  @override
  List<Object?> get protoValues => [maxSize];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {'max_size': config.encodeBigint(maxSize)}.notNullValue;
  }

  factory TronCanDelegatedMaxSizeResponseMessage.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronCanDelegatedMaxSizeResponseMessage(
      maxSize: json.valueAsBigInt<BigInt?>(
        'max_size',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronCanDelegatedMaxSizeResponseMessage.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronCanDelegatedMaxSizeResponseMessage(
      maxSize: decode.getBigInt<BigInt?>(1),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolCanDelegatedMaxSizeResponseMessage;
}

class TronCanWithdrawUnfreezeAmountRequestMessage extends TronProtoMessage {
  final List<int>? ownerAddress;

  final BigInt? timestamp;

  const TronCanWithdrawUnfreezeAmountRequestMessage({
    this.ownerAddress,
    this.timestamp,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bytes(1), ProtoFieldConfig.int64(2)],
    );
  }

  @override
  List<Object?> get protoValues => [ownerAddress, timestamp];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'owner_address': config.encodeBinary(ownerAddress),
      'timestamp': config.encodeBigint(timestamp),
    }.notNullValue;
  }

  factory TronCanWithdrawUnfreezeAmountRequestMessage.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronCanWithdrawUnfreezeAmountRequestMessage(
      ownerAddress: config.decodeBinary<List<int>?>(
        json.valueAs('owner_address', normalizeKeyLookup: config.normalizeKeys),
      ),
      timestamp: json.valueAsBigInt<BigInt?>(
        'timestamp',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronCanWithdrawUnfreezeAmountRequestMessage.deserialize(
    List<int> bytes,
  ) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronCanWithdrawUnfreezeAmountRequestMessage(
      ownerAddress: decode.getBytes<List<int>?>(1),
      timestamp: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolCanWithdrawUnfreezeAmountRequestMessage;
}

class TronCanWithdrawUnfreezeAmountResponseMessage extends TronProtoMessage {
  final BigInt? amount;

  const TronCanWithdrawUnfreezeAmountResponseMessage({this.amount});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.int64(1)],
    );
  }

  @override
  List<Object?> get protoValues => [amount];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {'amount': config.encodeBigint(amount)}.notNullValue;
  }

  factory TronCanWithdrawUnfreezeAmountResponseMessage.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronCanWithdrawUnfreezeAmountResponseMessage(
      amount: json.valueAsBigInt<BigInt?>(
        'amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronCanWithdrawUnfreezeAmountResponseMessage.deserialize(
    List<int> bytes,
  ) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronCanWithdrawUnfreezeAmountResponseMessage(
      amount: decode.getBigInt<BigInt?>(1),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolCanWithdrawUnfreezeAmountResponseMessage;
}

class TronPricesResponseMessage extends TronProtoMessage {
  final String? prices;

  const TronPricesResponseMessage({this.prices});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.string(1)],
    );
  }

  @override
  List<Object?> get protoValues => [prices];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {'prices': prices}.notNullValue;
  }

  factory TronPricesResponseMessage.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronPricesResponseMessage(
      prices: json.valueAsString<String?>(
        'prices',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronPricesResponseMessage.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronPricesResponseMessage(prices: decode.getString<String?>(1));
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolPricesResponseMessage;
}

/// Gossip node list
class TronNodeList extends TronProtoMessage {
  final List<TronNode> nodes;

  const TronNodeList({this.nodes = const []});

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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [nodes];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'nodes': nodes.map((e) => config.encodeMessage(e)).toList(),
    }.notNullValue;
  }

  factory TronNodeList.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronNodeList(
      nodes:
          (json.valueEnsureAsList<dynamic>(
                'nodes',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronNode, Object>(
                  value: e,
                  parse:
                      (v) => TronNode.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory TronNodeList.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronNodeList(
      nodes:
          decode.getListOfBytes(1).map((b) => TronNode.deserialize(b)).toList(),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolNodeList;
}

/// Gossip node
class TronNode extends TronProtoMessage {
  final TronNodeAddress? address;

  const TronNode({this.address});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1)],
    );
  }

  @override
  List<Object?> get protoValues => [address];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {'address': config.encodeMessage(address)}.notNullValue;
  }

  factory TronNode.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronNode(
      address: json.valueTo<TronNodeAddress?, Object>(
        key: 'address',
        parse:
            (v) =>
                TronNodeAddress.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronNode.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronNode(
      address: decode.messageTo<TronNodeAddress?>(
        1,
        (b) => TronNodeAddress.deserialize(b),
      ),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolNode;
}

/// Gossip node address
class TronNodeAddress extends TronProtoMessage {
  final List<int>? host;

  final int? port;

  const TronNodeAddress({this.host, this.port});

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
  List<Object?> get protoValues => [host, port];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {'host': config.encodeBinary(host), 'port': port}.notNullValue;
  }

  factory TronNodeAddress.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronNodeAddress(
      host: config.decodeBinary<List<int>?>(
        json.valueAs('host', normalizeKeyLookup: config.normalizeKeys),
      ),
      port: json.valueAsInt<int?>(
        'port',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronNodeAddress.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronNodeAddress(
      host: decode.getBytes<List<int>?>(1),
      port: decode.getInt<int?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolAddress;
}

class TronEmptyMessage extends TronProtoMessage {
  const TronEmptyMessage();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [],
    );
  }

  @override
  List<Object?> get protoValues => [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {};
  }

  factory TronEmptyMessage.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronEmptyMessage();
  }

  factory TronEmptyMessage.deserialize(List<int> bytes) {
    return TronEmptyMessage();
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolEmptyMessage;
}

class TronNumberMessage extends TronProtoMessage {
  final BigInt? num;

  const TronNumberMessage({this.num});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.int64(1)],
    );
  }

  @override
  List<Object?> get protoValues => [num];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {'num': config.encodeBigint(num)}.notNullValue;
  }

  factory TronNumberMessage.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronNumberMessage(
      num: json.valueAsBigInt<BigInt?>(
        'num',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronNumberMessage.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronNumberMessage(num: decode.getBigInt<BigInt?>(1));
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolNumberMessage;
}

class TronBytesMessage extends TronProtoMessage {
  final List<int>? value;

  const TronBytesMessage({this.value});

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
  List<Object?> get protoValues => [value];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {'value': config.encodeBinary(value)}.notNullValue;
  }

  factory TronBytesMessage.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronBytesMessage(
      value: config.decodeBinary<List<int>?>(
        json.valueAs('value', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronBytesMessage.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronBytesMessage(value: decode.getBytes<List<int>?>(1));
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolBytesMessage;
}

class TronTimeMessage extends TronProtoMessage {
  final BigInt? beginInMilliseconds;

  final BigInt? endInMilliseconds;

  const TronTimeMessage({this.beginInMilliseconds, this.endInMilliseconds});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.int64(1), ProtoFieldConfig.int64(2)],
    );
  }

  @override
  List<Object?> get protoValues => [beginInMilliseconds, endInMilliseconds];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'beginInMilliseconds': config.encodeBigint(beginInMilliseconds),
      'endInMilliseconds': config.encodeBigint(endInMilliseconds),
    }.notNullValue;
  }

  factory TronTimeMessage.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronTimeMessage(
      beginInMilliseconds: json.valueAsBigInt<BigInt?>(
        'beginInMilliseconds',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      endInMilliseconds: json.valueAsBigInt<BigInt?>(
        'endInMilliseconds',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronTimeMessage.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronTimeMessage(
      beginInMilliseconds: decode.getBigInt<BigInt?>(1),
      endInMilliseconds: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolTimeMessage;
}

class TronBlockReq extends TronProtoMessage {
  final String? idOrNum;

  final bool? detail;

  const TronBlockReq({this.idOrNum, this.detail});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.string(1), ProtoFieldConfig.bool(2)],
    );
  }

  @override
  List<Object?> get protoValues => [idOrNum, detail];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {'id_or_num': idOrNum, 'detail': detail}.notNullValue;
  }

  factory TronBlockReq.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronBlockReq(
      idOrNum: json.valueAsString<String?>(
        'id_or_num',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      detail: json.valueAsBool<bool?>(
        'detail',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronBlockReq.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronBlockReq(
      idOrNum: decode.getString<String?>(1),
      detail: decode.getBool<bool?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolBlockReq;
}

class TronBlockLimit extends TronProtoMessage {
  final BigInt? startNum;

  final BigInt? endNum;

  const TronBlockLimit({this.startNum, this.endNum});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.int64(1), ProtoFieldConfig.int64(2)],
    );
  }

  @override
  List<Object?> get protoValues => [startNum, endNum];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'startNum': config.encodeBigint(startNum),
      'endNum': config.encodeBigint(endNum),
    }.notNullValue;
  }

  factory TronBlockLimit.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronBlockLimit(
      startNum: json.valueAsBigInt<BigInt?>(
        'startNum',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      endNum: json.valueAsBigInt<BigInt?>(
        'endNum',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronBlockLimit.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronBlockLimit(
      startNum: decode.getBigInt<BigInt?>(1),
      endNum: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolBlockLimit;
}

class TronTransactionLimit extends TronProtoMessage {
  final List<int>? transactionId;

  final BigInt? limitNum;

  const TronTransactionLimit({this.transactionId, this.limitNum});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bytes(1), ProtoFieldConfig.int64(2)],
    );
  }

  @override
  List<Object?> get protoValues => [transactionId, limitNum];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'transactionId': config.encodeBinary(transactionId),
      'limitNum': config.encodeBigint(limitNum),
    }.notNullValue;
  }

  factory TronTransactionLimit.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronTransactionLimit(
      transactionId: config.decodeBinary<List<int>?>(
        json.valueAs('transactionId', normalizeKeyLookup: config.normalizeKeys),
      ),
      limitNum: json.valueAsBigInt<BigInt?>(
        'limitNum',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronTransactionLimit.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronTransactionLimit(
      transactionId: decode.getBytes<List<int>?>(1),
      limitNum: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolTransactionLimit;
}

class TronAccountPaginated extends TronProtoMessage {
  final protocol_tron.TronAccount? account;

  final BigInt? offset;

  final BigInt? limit;

  const TronAccountPaginated({this.account, this.offset, this.limit});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.int64(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [account, offset, limit];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'account': config.encodeMessage(account),
      'offset': config.encodeBigint(offset),
      'limit': config.encodeBigint(limit),
    }.notNullValue;
  }

  factory TronAccountPaginated.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronAccountPaginated(
      account: json.valueTo<protocol_tron.TronAccount?, Object>(
        key: 'account',
        parse:
            (v) => protocol_tron.TronAccount.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      offset: json.valueAsBigInt<BigInt?>(
        'offset',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      limit: json.valueAsBigInt<BigInt?>(
        'limit',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronAccountPaginated.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronAccountPaginated(
      account: decode.messageTo<protocol_tron.TronAccount?>(
        1,
        (b) => protocol_tron.TronAccount.deserialize(b),
      ),
      offset: decode.getBigInt<BigInt?>(2),
      limit: decode.getBigInt<BigInt?>(3),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolAccountPaginated;
}

class TronTimePaginatedMessage extends TronProtoMessage {
  final TronTimeMessage? timeMessage;

  final BigInt? offset;

  final BigInt? limit;

  const TronTimePaginatedMessage({this.timeMessage, this.offset, this.limit});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.int64(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [timeMessage, offset, limit];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'timeMessage': config.encodeMessage(timeMessage),
      'offset': config.encodeBigint(offset),
      'limit': config.encodeBigint(limit),
    }.notNullValue;
  }

  factory TronTimePaginatedMessage.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronTimePaginatedMessage(
      timeMessage: json.valueTo<TronTimeMessage?, Object>(
        key: 'timeMessage',
        parse:
            (v) =>
                TronTimeMessage.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      offset: json.valueAsBigInt<BigInt?>(
        'offset',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      limit: json.valueAsBigInt<BigInt?>(
        'limit',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronTimePaginatedMessage.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronTimePaginatedMessage(
      timeMessage: decode.messageTo<TronTimeMessage?>(
        1,
        (b) => TronTimeMessage.deserialize(b),
      ),
      offset: decode.getBigInt<BigInt?>(2),
      limit: decode.getBigInt<BigInt?>(3),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolTimePaginatedMessage;
}

/// deprecated
class TronAccountNetMessage extends TronProtoMessage {
  final BigInt? freeNetUsed;

  final BigInt? freeNetLimit;

  final BigInt? netUsed;

  final BigInt? netLimit;

  final Map<String, BigInt> assetNetUsed;

  final Map<String, BigInt> assetNetLimit;

  final BigInt? totalNetLimit;

  final BigInt? totalNetWeight;

  const TronAccountNetMessage({
    this.freeNetUsed,
    this.freeNetLimit,
    this.netUsed,
    this.netLimit,
    this.assetNetUsed = const {},
    this.assetNetLimit = const {},
    this.totalNetLimit,
    this.totalNetWeight,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.int64(4),
        ProtoFieldConfig.map(
          fieldNumber: 5,
          keyType: ProtoFieldType.string,
          valueType: ProtoFieldType.int64,
        ),
        ProtoFieldConfig.map(
          fieldNumber: 6,
          keyType: ProtoFieldType.string,
          valueType: ProtoFieldType.int64,
        ),
        ProtoFieldConfig.int64(7),
        ProtoFieldConfig.int64(8),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    freeNetUsed,
    freeNetLimit,
    netUsed,
    netLimit,
    assetNetUsed,
    assetNetLimit,
    totalNetLimit,
    totalNetWeight,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'freeNetUsed': config.encodeBigint(freeNetUsed),
      'freeNetLimit': config.encodeBigint(freeNetLimit),
      'NetUsed': config.encodeBigint(netUsed),
      'NetLimit': config.encodeBigint(netLimit),
      'assetNetUsed': config.encodeMap(
        assetNetUsed,
        (k, v) => MapEntry(k, config.encodeBigint(v)),
      ),
      'assetNetLimit': config.encodeMap(
        assetNetLimit,
        (k, v) => MapEntry(k, config.encodeBigint(v)),
      ),
      'TotalNetLimit': config.encodeBigint(totalNetLimit),
      'TotalNetWeight': config.encodeBigint(totalNetWeight),
    }.notNullValue;
  }

  factory TronAccountNetMessage.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronAccountNetMessage(
      freeNetUsed: json.valueAsBigInt<BigInt?>(
        'freeNetUsed',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      freeNetLimit: json.valueAsBigInt<BigInt?>(
        'freeNetLimit',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      netUsed: json.valueAsBigInt<BigInt?>(
        'NetUsed',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      netLimit: json.valueAsBigInt<BigInt?>(
        'NetLimit',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      assetNetUsed: config.decodeMap(
        json.valueAs('assetNetUsed', normalizeKeyLookup: config.normalizeKeys),
        (k, v) => MapEntry(
          JsonParser.valueAsString<String>(k),
          JsonParser.valueAsBigInt<BigInt>(v),
        ),
      ),
      assetNetLimit: config.decodeMap(
        json.valueAs('assetNetLimit', normalizeKeyLookup: config.normalizeKeys),
        (k, v) => MapEntry(
          JsonParser.valueAsString<String>(k),
          JsonParser.valueAsBigInt<BigInt>(v),
        ),
      ),
      totalNetLimit: json.valueAsBigInt<BigInt?>(
        'TotalNetLimit',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      totalNetWeight: json.valueAsBigInt<BigInt?>(
        'TotalNetWeight',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronAccountNetMessage.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronAccountNetMessage(
      freeNetUsed: decode.getBigInt<BigInt?>(1),
      freeNetLimit: decode.getBigInt<BigInt?>(2),
      netUsed: decode.getBigInt<BigInt?>(3),
      netLimit: decode.getBigInt<BigInt?>(4),
      assetNetUsed: decode.getMap<String, BigInt>(5),
      assetNetLimit: decode.getMap<String, BigInt>(6),
      totalNetLimit: decode.getBigInt<BigInt?>(7),
      totalNetWeight: decode.getBigInt<BigInt?>(8),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolAccountNetMessage;
}

class TronPaginatedMessage extends TronProtoMessage {
  final BigInt? offset;

  final BigInt? limit;

  const TronPaginatedMessage({this.offset, this.limit});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.int64(1), ProtoFieldConfig.int64(2)],
    );
  }

  @override
  List<Object?> get protoValues => [offset, limit];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'offset': config.encodeBigint(offset),
      'limit': config.encodeBigint(limit),
    }.notNullValue;
  }

  factory TronPaginatedMessage.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronPaginatedMessage(
      offset: json.valueAsBigInt<BigInt?>(
        'offset',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      limit: json.valueAsBigInt<BigInt?>(
        'limit',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronPaginatedMessage.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronPaginatedMessage(
      offset: decode.getBigInt<BigInt?>(1),
      limit: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolPaginatedMessage;
}

class TronTransactionExtention extends TronProtoMessage {
  final protocol_contracts.TronTransaction? transaction;

  final List<int>? txid;

  /// transaction id =  sha256(transaction.rowdata)
  final List<List<int>> constantResult;

  final TronReturn? result;

  final BigInt? energyUsed;

  final List<protocol_tron.TronTransactionInfoLog> logs;

  final List<protocol_tron.TronInternalTransaction> internalTransactions;

  final BigInt? energyPenalty;

  const TronTransactionExtention({
    this.transaction,
    this.txid,
    this.constantResult = const [],
    this.result,
    this.energyUsed,
    this.logs = const [],
    this.internalTransactions = const [],
    this.energyPenalty,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.bytes,
        ),
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.int64(5),
        ProtoFieldConfig.repeated(
          fieldNumber: 6,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 7,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.int64(8),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    transaction,
    txid,
    constantResult,
    result,
    energyUsed,
    logs,
    internalTransactions,
    energyPenalty,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'transaction': config.encodeMessage(transaction),
      'txid': config.encodeBinary(txid),
      'constant_result':
          constantResult.map((e) => config.encodeBinary(e)).toList(),
      'result': config.encodeMessage(result),
      'energy_used': config.encodeBigint(energyUsed),
      'logs': logs.map((e) => config.encodeMessage(e)).toList(),
      'internal_transactions':
          internalTransactions.map((e) => config.encodeMessage(e)).toList(),
      'energy_penalty': config.encodeBigint(energyPenalty),
    }.notNullValue;
  }

  factory TronTransactionExtention.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronTransactionExtention(
      transaction: json.valueTo<protocol_contracts.TronTransaction?, Object>(
        key: 'transaction',
        parse:
            (v) => protocol_contracts.TronTransaction.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      txid: config.decodeBinary<List<int>?>(
        json.valueAs('txid', normalizeKeyLookup: config.normalizeKeys),
      ),
      constantResult:
          (json.valueEnsureAsList<dynamic>(
            'constant_result',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => config.decodeBinary<List<int>>(e)).toList(),
      result: json.valueTo<TronReturn?, Object>(
        key: 'result',
        parse:
            (v) => TronReturn.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      energyUsed: json.valueAsBigInt<BigInt?>(
        'energy_used',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      logs:
          (json.valueEnsureAsList<dynamic>(
                'logs',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  protocol_tron.TronTransactionInfoLog,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => protocol_tron.TronTransactionInfoLog.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      internalTransactions:
          (json.valueEnsureAsList<dynamic>(
                'internal_transactions',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  protocol_tron.TronInternalTransaction,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => protocol_tron.TronInternalTransaction.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      energyPenalty: json.valueAsBigInt<BigInt?>(
        'energy_penalty',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronTransactionExtention.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronTransactionExtention(
      transaction: decode.messageTo<protocol_contracts.TronTransaction?>(
        1,
        (b) => protocol_contracts.TronTransaction.deserialize(b),
      ),
      txid: decode.getBytes<List<int>?>(2),
      constantResult: decode.getListOfBytes(3),
      result: decode.messageTo<TronReturn?>(
        4,
        (b) => TronReturn.deserialize(b),
      ),
      energyUsed: decode.getBigInt<BigInt?>(5),
      logs:
          decode
              .getListOfBytes(6)
              .map((b) => protocol_tron.TronTransactionInfoLog.deserialize(b))
              .toList(),
      internalTransactions:
          decode
              .getListOfBytes(7)
              .map((b) => protocol_tron.TronInternalTransaction.deserialize(b))
              .toList(),
      energyPenalty: decode.getBigInt<BigInt?>(8),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolTransactionExtention;
}

class TronEstimateEnergyMessage extends TronProtoMessage {
  final TronReturn? result;

  final BigInt? energyRequired;

  const TronEstimateEnergyMessage({this.result, this.energyRequired});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.int64(2)],
    );
  }

  @override
  List<Object?> get protoValues => [result, energyRequired];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'result': config.encodeMessage(result),
      'energy_required': config.encodeBigint(energyRequired),
    }.notNullValue;
  }

  factory TronEstimateEnergyMessage.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronEstimateEnergyMessage(
      result: json.valueTo<TronReturn?, Object>(
        key: 'result',
        parse:
            (v) => TronReturn.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      energyRequired: json.valueAsBigInt<BigInt?>(
        'energy_required',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronEstimateEnergyMessage.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronEstimateEnergyMessage(
      result: decode.messageTo<TronReturn?>(
        1,
        (b) => TronReturn.deserialize(b),
      ),
      energyRequired: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolEstimateEnergyMessage;
}

class TronBlockExtention extends TronProtoMessage {
  final List<TronTransactionExtention> transactions;

  final protocol_tron.TronBlockHeader? blockHeader;

  final List<int>? blockid;

  const TronBlockExtention({
    this.transactions = const [],
    this.blockHeader,
    this.blockid,
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
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.bytes(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [transactions, blockHeader, blockid];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'transactions': transactions.map((e) => config.encodeMessage(e)).toList(),
      'block_header': config.encodeMessage(blockHeader),
      'blockid': config.encodeBinary(blockid),
    }.notNullValue;
  }

  factory TronBlockExtention.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronBlockExtention(
      transactions:
          (json.valueEnsureAsList<dynamic>(
                'transactions',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronTransactionExtention, Object>(
                  value: e,
                  parse:
                      (v) => TronTransactionExtention.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      blockHeader: json.valueTo<protocol_tron.TronBlockHeader?, Object>(
        key: 'block_header',
        parse:
            (v) => protocol_tron.TronBlockHeader.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      blockid: config.decodeBinary<List<int>?>(
        json.valueAs('blockid', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronBlockExtention.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronBlockExtention(
      transactions:
          decode
              .getListOfBytes(1)
              .map((b) => TronTransactionExtention.deserialize(b))
              .toList(),
      blockHeader: decode.messageTo<protocol_tron.TronBlockHeader?>(
        2,
        (b) => protocol_tron.TronBlockHeader.deserialize(b),
      ),
      blockid: decode.getBytes<List<int>?>(3),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolBlockExtention;
}

class TronBlockListExtention extends TronProtoMessage {
  final List<TronBlockExtention> block;

  const TronBlockListExtention({this.block = const []});

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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [block];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'block': block.map((e) => config.encodeMessage(e)).toList(),
    }.notNullValue;
  }

  factory TronBlockListExtention.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronBlockListExtention(
      block:
          (json.valueEnsureAsList<dynamic>(
                'block',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronBlockExtention, Object>(
                  value: e,
                  parse:
                      (v) => TronBlockExtention.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory TronBlockListExtention.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronBlockListExtention(
      block:
          decode
              .getListOfBytes(1)
              .map((b) => TronBlockExtention.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolBlockListExtention;
}

class TronTransactionListExtention extends TronProtoMessage {
  final List<TronTransactionExtention> transaction;

  const TronTransactionListExtention({this.transaction = const []});

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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [transaction];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'transaction': transaction.map((e) => config.encodeMessage(e)).toList(),
    }.notNullValue;
  }

  factory TronTransactionListExtention.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronTransactionListExtention(
      transaction:
          (json.valueEnsureAsList<dynamic>(
                'transaction',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronTransactionExtention, Object>(
                  value: e,
                  parse:
                      (v) => TronTransactionExtention.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory TronTransactionListExtention.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronTransactionListExtention(
      transaction:
          decode
              .getListOfBytes(1)
              .map((b) => TronTransactionExtention.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolTransactionListExtention;
}

class TronBlockIncrementalMerkleTree extends TronProtoMessage {
  final BigInt? number;

  final protocol_shield_contract.TronIncrementalMerkleTree? merkleTree;

  const TronBlockIncrementalMerkleTree({this.number, this.merkleTree});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.int64(1), ProtoFieldConfig.message(2)],
    );
  }

  @override
  List<Object?> get protoValues => [number, merkleTree];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'number': config.encodeBigint(number),
      'merkleTree': config.encodeMessage(merkleTree),
    }.notNullValue;
  }

  factory TronBlockIncrementalMerkleTree.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronBlockIncrementalMerkleTree(
      number: json.valueAsBigInt<BigInt?>(
        'number',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      merkleTree: json
          .valueTo<protocol_shield_contract.TronIncrementalMerkleTree?, Object>(
            key: 'merkleTree',
            parse:
                (v) =>
                    protocol_shield_contract.TronIncrementalMerkleTree.fromJson(
                      JsonParser.valueAs(v),
                      config: config,
                    ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
    );
  }

  factory TronBlockIncrementalMerkleTree.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronBlockIncrementalMerkleTree(
      number: decode.getBigInt<BigInt?>(1),
      merkleTree: decode
          .messageTo<protocol_shield_contract.TronIncrementalMerkleTree?>(
            2,
            (b) => protocol_shield_contract
                .TronIncrementalMerkleTree.deserialize(b),
          ),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolBlockIncrementalMerkleTree;
}

class TronTransactionSignWeight extends TronProtoMessage {
  final protocol_contracts.TronPermission? permission;

  final List<List<int>> approvedList;

  final BigInt? currentWeight;

  final TronTransactionSignWeightResult? result;

  final TronTransactionExtention? transaction;

  const TronTransactionSignWeight({
    this.permission,
    this.approvedList = const [],
    this.currentWeight,
    this.result,
    this.transaction,
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
          elementType: ProtoFieldType.bytes,
        ),
        ProtoFieldConfig.int64(3),
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.message(5),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    permission,
    approvedList,
    currentWeight,
    result,
    transaction,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'permission': config.encodeMessage(permission),
      'approved_list': approvedList.map((e) => config.encodeBinary(e)).toList(),
      'current_weight': config.encodeBigint(currentWeight),
      'result': config.encodeMessage(result),
      'transaction': config.encodeMessage(transaction),
    }.notNullValue;
  }

  factory TronTransactionSignWeight.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronTransactionSignWeight(
      permission: json.valueTo<protocol_contracts.TronPermission?, Object>(
        key: 'permission',
        parse:
            (v) => protocol_contracts.TronPermission.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      approvedList:
          (json.valueEnsureAsList<dynamic>(
            'approved_list',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => config.decodeBinary<List<int>>(e)).toList(),
      currentWeight: json.valueAsBigInt<BigInt?>(
        'current_weight',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      result: json.valueTo<TronTransactionSignWeightResult?, Object>(
        key: 'result',
        parse:
            (v) => TronTransactionSignWeightResult.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      transaction: json.valueTo<TronTransactionExtention?, Object>(
        key: 'transaction',
        parse:
            (v) => TronTransactionExtention.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronTransactionSignWeight.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronTransactionSignWeight(
      permission: decode.messageTo<protocol_contracts.TronPermission?>(
        1,
        (b) => protocol_contracts.TronPermission.deserialize(b),
      ),
      approvedList: decode.getListOfBytes(2),
      currentWeight: decode.getBigInt<BigInt?>(3),
      result: decode.messageTo<TronTransactionSignWeightResult?>(
        4,
        (b) => TronTransactionSignWeightResult.deserialize(b),
      ),
      transaction: decode.messageTo<TronTransactionExtention?>(
        5,
        (b) => TronTransactionExtention.deserialize(b),
      ),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolTransactionSignWeight;
}

class TronTransactionSignWeightResult extends TronProtoMessage {
  final TronTransactionSignWeightResultresponseCode? code;

  final String? message;

  const TronTransactionSignWeightResult({this.code, this.message});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.enumType(1), ProtoFieldConfig.string(2)],
    );
  }

  @override
  List<Object?> get protoValues => [code, message];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {'code': config.encodeEnum(code), 'message': message}.notNullValue;
  }

  factory TronTransactionSignWeightResult.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronTransactionSignWeightResult(
      code: json.valueTo<TronTransactionSignWeightResultresponseCode?, Object?>(
        key: 'code',
        parse: (v) => TronTransactionSignWeightResultresponseCode.from(v),
      ),
      message: json.valueAsString<String?>(
        'message',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronTransactionSignWeightResult.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronTransactionSignWeightResult(
      code: decode.getEnum<TronTransactionSignWeightResultresponseCode?>(
        1,
        TronTransactionSignWeightResultresponseCode.values,
      ),
      message: decode.getString<String?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolTransactionSignWeightResult;
}

class TronTransactionApprovedList extends TronProtoMessage {
  final List<List<int>> approvedList;

  final TronTransactionApprovedListResult? result;

  final TronTransactionExtention? transaction;

  const TronTransactionApprovedList({
    this.approvedList = const [],
    this.result,
    this.transaction,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.bytes,
        ),
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.message(5),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [approvedList, result, transaction];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'approved_list': approvedList.map((e) => config.encodeBinary(e)).toList(),
      'result': config.encodeMessage(result),
      'transaction': config.encodeMessage(transaction),
    }.notNullValue;
  }

  factory TronTransactionApprovedList.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronTransactionApprovedList(
      approvedList:
          (json.valueEnsureAsList<dynamic>(
            'approved_list',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => config.decodeBinary<List<int>>(e)).toList(),
      result: json.valueTo<TronTransactionApprovedListResult?, Object>(
        key: 'result',
        parse:
            (v) => TronTransactionApprovedListResult.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      transaction: json.valueTo<TronTransactionExtention?, Object>(
        key: 'transaction',
        parse:
            (v) => TronTransactionExtention.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronTransactionApprovedList.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronTransactionApprovedList(
      approvedList: decode.getListOfBytes(2),
      result: decode.messageTo<TronTransactionApprovedListResult?>(
        4,
        (b) => TronTransactionApprovedListResult.deserialize(b),
      ),
      transaction: decode.messageTo<TronTransactionExtention?>(
        5,
        (b) => TronTransactionExtention.deserialize(b),
      ),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolTransactionApprovedList;
}

class TronTransactionApprovedListResult extends TronProtoMessage {
  final TronTransactionApprovedListResultresponseCode? code;

  final String? message;

  const TronTransactionApprovedListResult({this.code, this.message});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.enumType(1), ProtoFieldConfig.string(2)],
    );
  }

  @override
  List<Object?> get protoValues => [code, message];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {'code': config.encodeEnum(code), 'message': message}.notNullValue;
  }

  factory TronTransactionApprovedListResult.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronTransactionApprovedListResult(
      code: json
          .valueTo<TronTransactionApprovedListResultresponseCode?, Object?>(
            key: 'code',
            parse: (v) => TronTransactionApprovedListResultresponseCode.from(v),
          ),
      message: json.valueAsString<String?>(
        'message',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronTransactionApprovedListResult.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronTransactionApprovedListResult(
      code: decode.getEnum<TronTransactionApprovedListResultresponseCode?>(
        1,
        TronTransactionApprovedListResultresponseCode.values,
      ),
      message: decode.getString<String?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolTransactionApprovedListResult;
}

class TronIvkDecryptParameters extends TronProtoMessage {
  final BigInt? startBlockIndex;

  final BigInt? endBlockIndex;

  final List<int>? ivk;

  const TronIvkDecryptParameters({
    this.startBlockIndex,
    this.endBlockIndex,
    this.ivk,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.bytes(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [startBlockIndex, endBlockIndex, ivk];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'start_block_index': config.encodeBigint(startBlockIndex),
      'end_block_index': config.encodeBigint(endBlockIndex),
      'ivk': config.encodeBinary(ivk),
    }.notNullValue;
  }

  factory TronIvkDecryptParameters.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronIvkDecryptParameters(
      startBlockIndex: json.valueAsBigInt<BigInt?>(
        'start_block_index',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      endBlockIndex: json.valueAsBigInt<BigInt?>(
        'end_block_index',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      ivk: config.decodeBinary<List<int>?>(
        json.valueAs('ivk', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronIvkDecryptParameters.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronIvkDecryptParameters(
      startBlockIndex: decode.getBigInt<BigInt?>(1),
      endBlockIndex: decode.getBigInt<BigInt?>(2),
      ivk: decode.getBytes<List<int>?>(3),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolIvkDecryptParameters;
}

class TronIvkDecryptAndMarkParameters extends TronProtoMessage {
  final BigInt? startBlockIndex;

  final BigInt? endBlockIndex;

  final List<int>? ivk;

  final List<int>? ak;

  final List<int>? nk;

  const TronIvkDecryptAndMarkParameters({
    this.startBlockIndex,
    this.endBlockIndex,
    this.ivk,
    this.ak,
    this.nk,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.bytes(5),
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.bytes(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    startBlockIndex,
    endBlockIndex,
    ivk,
    ak,
    nk,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'start_block_index': config.encodeBigint(startBlockIndex),
      'end_block_index': config.encodeBigint(endBlockIndex),
      'ivk': config.encodeBinary(ivk),
      'ak': config.encodeBinary(ak),
      'nk': config.encodeBinary(nk),
    }.notNullValue;
  }

  factory TronIvkDecryptAndMarkParameters.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronIvkDecryptAndMarkParameters(
      startBlockIndex: json.valueAsBigInt<BigInt?>(
        'start_block_index',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      endBlockIndex: json.valueAsBigInt<BigInt?>(
        'end_block_index',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      ivk: config.decodeBinary<List<int>?>(
        json.valueAs('ivk', normalizeKeyLookup: config.normalizeKeys),
      ),
      ak: config.decodeBinary<List<int>?>(
        json.valueAs('ak', normalizeKeyLookup: config.normalizeKeys),
      ),
      nk: config.decodeBinary<List<int>?>(
        json.valueAs('nk', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronIvkDecryptAndMarkParameters.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronIvkDecryptAndMarkParameters(
      startBlockIndex: decode.getBigInt<BigInt?>(1),
      endBlockIndex: decode.getBigInt<BigInt?>(2),
      ivk: decode.getBytes<List<int>?>(5),
      ak: decode.getBytes<List<int>?>(3),
      nk: decode.getBytes<List<int>?>(4),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolIvkDecryptAndMarkParameters;
}

class TronOvkDecryptParameters extends TronProtoMessage {
  final BigInt? startBlockIndex;

  final BigInt? endBlockIndex;

  final List<int>? ovk;

  const TronOvkDecryptParameters({
    this.startBlockIndex,
    this.endBlockIndex,
    this.ovk,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.bytes(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [startBlockIndex, endBlockIndex, ovk];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'start_block_index': config.encodeBigint(startBlockIndex),
      'end_block_index': config.encodeBigint(endBlockIndex),
      'ovk': config.encodeBinary(ovk),
    }.notNullValue;
  }

  factory TronOvkDecryptParameters.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronOvkDecryptParameters(
      startBlockIndex: json.valueAsBigInt<BigInt?>(
        'start_block_index',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      endBlockIndex: json.valueAsBigInt<BigInt?>(
        'end_block_index',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      ovk: config.decodeBinary<List<int>?>(
        json.valueAs('ovk', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronOvkDecryptParameters.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronOvkDecryptParameters(
      startBlockIndex: decode.getBigInt<BigInt?>(1),
      endBlockIndex: decode.getBigInt<BigInt?>(2),
      ovk: decode.getBytes<List<int>?>(3),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolOvkDecryptParameters;
}

class TronDecryptNotes extends TronProtoMessage {
  /// the index of note in receive
  final List<TronDecryptNotesNoteTx> noteTxs;

  const TronDecryptNotes({this.noteTxs = const []});

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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [noteTxs];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'noteTxs': noteTxs.map((e) => config.encodeMessage(e)).toList(),
    }.notNullValue;
  }

  factory TronDecryptNotes.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronDecryptNotes(
      noteTxs:
          (json.valueEnsureAsList<dynamic>(
                'noteTxs',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronDecryptNotesNoteTx, Object>(
                  value: e,
                  parse:
                      (v) => TronDecryptNotesNoteTx.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory TronDecryptNotes.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronDecryptNotes(
      noteTxs:
          decode
              .getListOfBytes(1)
              .map((b) => TronDecryptNotesNoteTx.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolDecryptNotes;
}

class TronDecryptNotesNoteTx extends TronProtoMessage {
  final TronNote? note;

  final List<int>? txid;

  /// transaction id =  sha256(transaction.rowdata)
  final int? index;

  const TronDecryptNotesNoteTx({this.note, this.txid, this.index});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.int32(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [note, txid, index];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'note': config.encodeMessage(note),
      'txid': config.encodeBinary(txid),
      'index': index,
    }.notNullValue;
  }

  factory TronDecryptNotesNoteTx.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronDecryptNotesNoteTx(
      note: json.valueTo<TronNote?, Object>(
        key: 'note',
        parse: (v) => TronNote.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      txid: config.decodeBinary<List<int>?>(
        json.valueAs('txid', normalizeKeyLookup: config.normalizeKeys),
      ),
      index: json.valueAsInt<int?>(
        'index',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronDecryptNotesNoteTx.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronDecryptNotesNoteTx(
      note: decode.messageTo<TronNote?>(1, (b) => TronNote.deserialize(b)),
      txid: decode.getBytes<List<int>?>(2),
      index: decode.getInt<int?>(3),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolDecryptNotesNoteTx;
}

class TronDecryptNotesMarked extends TronProtoMessage {
  final List<TronDecryptNotesMarkedNoteTx> noteTxs;

  const TronDecryptNotesMarked({this.noteTxs = const []});

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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [noteTxs];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'noteTxs': noteTxs.map((e) => config.encodeMessage(e)).toList(),
    }.notNullValue;
  }

  factory TronDecryptNotesMarked.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronDecryptNotesMarked(
      noteTxs:
          (json.valueEnsureAsList<dynamic>(
                'noteTxs',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronDecryptNotesMarkedNoteTx, Object>(
                  value: e,
                  parse:
                      (v) => TronDecryptNotesMarkedNoteTx.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory TronDecryptNotesMarked.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronDecryptNotesMarked(
      noteTxs:
          decode
              .getListOfBytes(1)
              .map((b) => TronDecryptNotesMarkedNoteTx.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolDecryptNotesMarked;
}

class TronDecryptNotesMarkedNoteTx extends TronProtoMessage {
  final TronNote? note;

  final List<int>? txid;

  /// transaction id =  sha256(transaction.rowdata)
  final int? index;

  /// the index of note in receive
  final bool? isSpend;

  const TronDecryptNotesMarkedNoteTx({
    this.note,
    this.txid,
    this.index,
    this.isSpend,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.int32(3),
        ProtoFieldConfig.bool(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [note, txid, index, isSpend];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'note': config.encodeMessage(note),
      'txid': config.encodeBinary(txid),
      'index': index,
      'is_spend': isSpend,
    }.notNullValue;
  }

  factory TronDecryptNotesMarkedNoteTx.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronDecryptNotesMarkedNoteTx(
      note: json.valueTo<TronNote?, Object>(
        key: 'note',
        parse: (v) => TronNote.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      txid: config.decodeBinary<List<int>?>(
        json.valueAs('txid', normalizeKeyLookup: config.normalizeKeys),
      ),
      index: json.valueAsInt<int?>(
        'index',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      isSpend: json.valueAsBool<bool?>(
        'is_spend',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronDecryptNotesMarkedNoteTx.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronDecryptNotesMarkedNoteTx(
      note: decode.messageTo<TronNote?>(1, (b) => TronNote.deserialize(b)),
      txid: decode.getBytes<List<int>?>(2),
      index: decode.getInt<int?>(3),
      isSpend: decode.getBool<bool?>(4),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolDecryptNotesMarkedNoteTx;
}

class TronNote extends TronProtoMessage {
  final BigInt? value;

  final String? paymentAddress;

  final List<int>? rcm;

  /// random 32
  final List<int>? memo;

  const TronNote({this.value, this.paymentAddress, this.rcm, this.memo});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.string(2),
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.bytes(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [value, paymentAddress, rcm, memo];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'value': config.encodeBigint(value),
      'payment_address': paymentAddress,
      'rcm': config.encodeBinary(rcm),
      'memo': config.encodeBinary(memo),
    }.notNullValue;
  }

  factory TronNote.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronNote(
      value: json.valueAsBigInt<BigInt?>(
        'value',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      paymentAddress: json.valueAsString<String?>(
        'payment_address',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      rcm: config.decodeBinary<List<int>?>(
        json.valueAs('rcm', normalizeKeyLookup: config.normalizeKeys),
      ),
      memo: config.decodeBinary<List<int>?>(
        json.valueAs('memo', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronNote.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronNote(
      value: decode.getBigInt<BigInt?>(1),
      paymentAddress: decode.getString<String?>(2),
      rcm: decode.getBytes<List<int>?>(3),
      memo: decode.getBytes<List<int>?>(4),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolNote;
}

class TronSpendNote extends TronProtoMessage {
  final TronNote? note;

  final List<int>? alpha;

  /// random number for spend authority signature
  final protocol_shield_contract.TronIncrementalMerkleVoucher? voucher;

  final List<int>? path;

  const TronSpendNote({this.note, this.alpha, this.voucher, this.path});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.bytes(4),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.bytes(6),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [note, alpha, voucher, path];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'note': config.encodeMessage(note),
      'alpha': config.encodeBinary(alpha),
      'voucher': config.encodeMessage(voucher),
      'path': config.encodeBinary(path),
    }.notNullValue;
  }

  factory TronSpendNote.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronSpendNote(
      note: json.valueTo<TronNote?, Object>(
        key: 'note',
        parse: (v) => TronNote.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      alpha: config.decodeBinary<List<int>?>(
        json.valueAs('alpha', normalizeKeyLookup: config.normalizeKeys),
      ),
      voucher: json.valueTo<
        protocol_shield_contract.TronIncrementalMerkleVoucher?,
        Object
      >(
        key: 'voucher',
        parse:
            (v) =>
                protocol_shield_contract.TronIncrementalMerkleVoucher.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      path: config.decodeBinary<List<int>?>(
        json.valueAs('path', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronSpendNote.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronSpendNote(
      note: decode.messageTo<TronNote?>(3, (b) => TronNote.deserialize(b)),
      alpha: decode.getBytes<List<int>?>(4),
      voucher: decode
          .messageTo<protocol_shield_contract.TronIncrementalMerkleVoucher?>(
            5,
            (b) => protocol_shield_contract
                .TronIncrementalMerkleVoucher.deserialize(b),
          ),
      path: decode.getBytes<List<int>?>(6),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolSpendNote;
}

/// path for cm from leaf to root in merkle tree
class TronReceiveNote extends TronProtoMessage {
  final TronNote? note;

  const TronReceiveNote({this.note});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1)],
    );
  }

  @override
  List<Object?> get protoValues => [note];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {'note': config.encodeMessage(note)}.notNullValue;
  }

  factory TronReceiveNote.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronReceiveNote(
      note: json.valueTo<TronNote?, Object>(
        key: 'note',
        parse: (v) => TronNote.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronReceiveNote.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronReceiveNote(
      note: decode.messageTo<TronNote?>(1, (b) => TronNote.deserialize(b)),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolReceiveNote;
}

class TronPrivateParameters extends TronProtoMessage {
  final List<int>? transparentFromAddress;

  final List<int>? ask;

  final List<int>? nsk;

  final List<int>? ovk;

  final BigInt? fromAmount;

  final List<TronSpendNote> shieldedSpends;

  final List<TronReceiveNote> shieldedReceives;

  final List<int>? transparentToAddress;

  final BigInt? toAmount;

  final BigInt? timeout;

  const TronPrivateParameters({
    this.transparentFromAddress,
    this.ask,
    this.nsk,
    this.ovk,
    this.fromAmount,
    this.shieldedSpends = const [],
    this.shieldedReceives = const [],
    this.transparentToAddress,
    this.toAmount,
    this.timeout,
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
        ProtoFieldConfig.int64(5),
        ProtoFieldConfig.repeated(
          fieldNumber: 6,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 7,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.bytes(8),
        ProtoFieldConfig.int64(9),
        ProtoFieldConfig.int64(10),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    transparentFromAddress,
    ask,
    nsk,
    ovk,
    fromAmount,
    shieldedSpends,
    shieldedReceives,
    transparentToAddress,
    toAmount,
    timeout,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'transparent_from_address': config.encodeBinary(transparentFromAddress),
      'ask': config.encodeBinary(ask),
      'nsk': config.encodeBinary(nsk),
      'ovk': config.encodeBinary(ovk),
      'from_amount': config.encodeBigint(fromAmount),
      'shielded_spends':
          shieldedSpends.map((e) => config.encodeMessage(e)).toList(),
      'shielded_receives':
          shieldedReceives.map((e) => config.encodeMessage(e)).toList(),
      'transparent_to_address': config.encodeBinary(transparentToAddress),
      'to_amount': config.encodeBigint(toAmount),
      'timeout': config.encodeBigint(timeout),
    }.notNullValue;
  }

  factory TronPrivateParameters.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronPrivateParameters(
      transparentFromAddress: config.decodeBinary<List<int>?>(
        json.valueAs(
          'transparent_from_address',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      ask: config.decodeBinary<List<int>?>(
        json.valueAs('ask', normalizeKeyLookup: config.normalizeKeys),
      ),
      nsk: config.decodeBinary<List<int>?>(
        json.valueAs('nsk', normalizeKeyLookup: config.normalizeKeys),
      ),
      ovk: config.decodeBinary<List<int>?>(
        json.valueAs('ovk', normalizeKeyLookup: config.normalizeKeys),
      ),
      fromAmount: json.valueAsBigInt<BigInt?>(
        'from_amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      shieldedSpends:
          (json.valueEnsureAsList<dynamic>(
                'shielded_spends',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronSpendNote, Object>(
                  value: e,
                  parse:
                      (v) => TronSpendNote.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      shieldedReceives:
          (json.valueEnsureAsList<dynamic>(
                'shielded_receives',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronReceiveNote, Object>(
                  value: e,
                  parse:
                      (v) => TronReceiveNote.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      transparentToAddress: config.decodeBinary<List<int>?>(
        json.valueAs(
          'transparent_to_address',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      toAmount: json.valueAsBigInt<BigInt?>(
        'to_amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      timeout: json.valueAsBigInt<BigInt?>(
        'timeout',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronPrivateParameters.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronPrivateParameters(
      transparentFromAddress: decode.getBytes<List<int>?>(1),
      ask: decode.getBytes<List<int>?>(2),
      nsk: decode.getBytes<List<int>?>(3),
      ovk: decode.getBytes<List<int>?>(4),
      fromAmount: decode.getBigInt<BigInt?>(5),
      shieldedSpends:
          decode
              .getListOfBytes(6)
              .map((b) => TronSpendNote.deserialize(b))
              .toList(),
      shieldedReceives:
          decode
              .getListOfBytes(7)
              .map((b) => TronReceiveNote.deserialize(b))
              .toList(),
      transparentToAddress: decode.getBytes<List<int>?>(8),
      toAmount: decode.getBigInt<BigInt?>(9),
      timeout: decode.getBigInt<BigInt?>(10),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolPrivateParameters;
}

/// timeout in seconds, it works only when it bigger than 0
class TronPrivateParametersWithoutAsk extends TronProtoMessage {
  final List<int>? transparentFromAddress;

  final List<int>? ak;

  final List<int>? nsk;

  final List<int>? ovk;

  final BigInt? fromAmount;

  final List<TronSpendNote> shieldedSpends;

  final List<TronReceiveNote> shieldedReceives;

  final List<int>? transparentToAddress;

  final BigInt? toAmount;

  final BigInt? timeout;

  const TronPrivateParametersWithoutAsk({
    this.transparentFromAddress,
    this.ak,
    this.nsk,
    this.ovk,
    this.fromAmount,
    this.shieldedSpends = const [],
    this.shieldedReceives = const [],
    this.transparentToAddress,
    this.toAmount,
    this.timeout,
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
        ProtoFieldConfig.int64(5),
        ProtoFieldConfig.repeated(
          fieldNumber: 6,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 7,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.bytes(8),
        ProtoFieldConfig.int64(9),
        ProtoFieldConfig.int64(10),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    transparentFromAddress,
    ak,
    nsk,
    ovk,
    fromAmount,
    shieldedSpends,
    shieldedReceives,
    transparentToAddress,
    toAmount,
    timeout,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'transparent_from_address': config.encodeBinary(transparentFromAddress),
      'ak': config.encodeBinary(ak),
      'nsk': config.encodeBinary(nsk),
      'ovk': config.encodeBinary(ovk),
      'from_amount': config.encodeBigint(fromAmount),
      'shielded_spends':
          shieldedSpends.map((e) => config.encodeMessage(e)).toList(),
      'shielded_receives':
          shieldedReceives.map((e) => config.encodeMessage(e)).toList(),
      'transparent_to_address': config.encodeBinary(transparentToAddress),
      'to_amount': config.encodeBigint(toAmount),
      'timeout': config.encodeBigint(timeout),
    }.notNullValue;
  }

  factory TronPrivateParametersWithoutAsk.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronPrivateParametersWithoutAsk(
      transparentFromAddress: config.decodeBinary<List<int>?>(
        json.valueAs(
          'transparent_from_address',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      ak: config.decodeBinary<List<int>?>(
        json.valueAs('ak', normalizeKeyLookup: config.normalizeKeys),
      ),
      nsk: config.decodeBinary<List<int>?>(
        json.valueAs('nsk', normalizeKeyLookup: config.normalizeKeys),
      ),
      ovk: config.decodeBinary<List<int>?>(
        json.valueAs('ovk', normalizeKeyLookup: config.normalizeKeys),
      ),
      fromAmount: json.valueAsBigInt<BigInt?>(
        'from_amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      shieldedSpends:
          (json.valueEnsureAsList<dynamic>(
                'shielded_spends',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronSpendNote, Object>(
                  value: e,
                  parse:
                      (v) => TronSpendNote.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      shieldedReceives:
          (json.valueEnsureAsList<dynamic>(
                'shielded_receives',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronReceiveNote, Object>(
                  value: e,
                  parse:
                      (v) => TronReceiveNote.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      transparentToAddress: config.decodeBinary<List<int>?>(
        json.valueAs(
          'transparent_to_address',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      toAmount: json.valueAsBigInt<BigInt?>(
        'to_amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      timeout: json.valueAsBigInt<BigInt?>(
        'timeout',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronPrivateParametersWithoutAsk.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronPrivateParametersWithoutAsk(
      transparentFromAddress: decode.getBytes<List<int>?>(1),
      ak: decode.getBytes<List<int>?>(2),
      nsk: decode.getBytes<List<int>?>(3),
      ovk: decode.getBytes<List<int>?>(4),
      fromAmount: decode.getBigInt<BigInt?>(5),
      shieldedSpends:
          decode
              .getListOfBytes(6)
              .map((b) => TronSpendNote.deserialize(b))
              .toList(),
      shieldedReceives:
          decode
              .getListOfBytes(7)
              .map((b) => TronReceiveNote.deserialize(b))
              .toList(),
      transparentToAddress: decode.getBytes<List<int>?>(8),
      toAmount: decode.getBigInt<BigInt?>(9),
      timeout: decode.getBigInt<BigInt?>(10),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolPrivateParametersWithoutAsk;
}

/// timeout in seconds, it works only when it bigger than 0
class TronSpendAuthSigParameters extends TronProtoMessage {
  final List<int>? ask;

  final List<int>? txHash;

  final List<int>? alpha;

  const TronSpendAuthSigParameters({this.ask, this.txHash, this.alpha});

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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [ask, txHash, alpha];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'ask': config.encodeBinary(ask),
      'tx_hash': config.encodeBinary(txHash),
      'alpha': config.encodeBinary(alpha),
    }.notNullValue;
  }

  factory TronSpendAuthSigParameters.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronSpendAuthSigParameters(
      ask: config.decodeBinary<List<int>?>(
        json.valueAs('ask', normalizeKeyLookup: config.normalizeKeys),
      ),
      txHash: config.decodeBinary<List<int>?>(
        json.valueAs('tx_hash', normalizeKeyLookup: config.normalizeKeys),
      ),
      alpha: config.decodeBinary<List<int>?>(
        json.valueAs('alpha', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronSpendAuthSigParameters.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronSpendAuthSigParameters(
      ask: decode.getBytes<List<int>?>(1),
      txHash: decode.getBytes<List<int>?>(2),
      alpha: decode.getBytes<List<int>?>(3),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolSpendAuthSigParameters;
}

class TronNfParameters extends TronProtoMessage {
  final TronNote? note;

  final protocol_shield_contract.TronIncrementalMerkleVoucher? voucher;

  final List<int>? ak;

  final List<int>? nk;

  const TronNfParameters({this.note, this.voucher, this.ak, this.nk});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.bytes(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [note, voucher, ak, nk];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'note': config.encodeMessage(note),
      'voucher': config.encodeMessage(voucher),
      'ak': config.encodeBinary(ak),
      'nk': config.encodeBinary(nk),
    }.notNullValue;
  }

  factory TronNfParameters.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronNfParameters(
      note: json.valueTo<TronNote?, Object>(
        key: 'note',
        parse: (v) => TronNote.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      voucher: json.valueTo<
        protocol_shield_contract.TronIncrementalMerkleVoucher?,
        Object
      >(
        key: 'voucher',
        parse:
            (v) =>
                protocol_shield_contract.TronIncrementalMerkleVoucher.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      ak: config.decodeBinary<List<int>?>(
        json.valueAs('ak', normalizeKeyLookup: config.normalizeKeys),
      ),
      nk: config.decodeBinary<List<int>?>(
        json.valueAs('nk', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronNfParameters.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronNfParameters(
      note: decode.messageTo<TronNote?>(1, (b) => TronNote.deserialize(b)),
      voucher: decode
          .messageTo<protocol_shield_contract.TronIncrementalMerkleVoucher?>(
            2,
            (b) => protocol_shield_contract
                .TronIncrementalMerkleVoucher.deserialize(b),
          ),
      ak: decode.getBytes<List<int>?>(3),
      nk: decode.getBytes<List<int>?>(4),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolNfParameters;
}

class TronExpandedSpendingKeyMessage extends TronProtoMessage {
  final List<int>? ask;

  final List<int>? nsk;

  final List<int>? ovk;

  const TronExpandedSpendingKeyMessage({this.ask, this.nsk, this.ovk});

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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [ask, nsk, ovk];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'ask': config.encodeBinary(ask),
      'nsk': config.encodeBinary(nsk),
      'ovk': config.encodeBinary(ovk),
    }.notNullValue;
  }

  factory TronExpandedSpendingKeyMessage.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronExpandedSpendingKeyMessage(
      ask: config.decodeBinary<List<int>?>(
        json.valueAs('ask', normalizeKeyLookup: config.normalizeKeys),
      ),
      nsk: config.decodeBinary<List<int>?>(
        json.valueAs('nsk', normalizeKeyLookup: config.normalizeKeys),
      ),
      ovk: config.decodeBinary<List<int>?>(
        json.valueAs('ovk', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronExpandedSpendingKeyMessage.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronExpandedSpendingKeyMessage(
      ask: decode.getBytes<List<int>?>(1),
      nsk: decode.getBytes<List<int>?>(2),
      ovk: decode.getBytes<List<int>?>(3),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolExpandedSpendingKeyMessage;
}

class TronViewingKeyMessage extends TronProtoMessage {
  final List<int>? ak;

  final List<int>? nk;

  const TronViewingKeyMessage({this.ak, this.nk});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bytes(1), ProtoFieldConfig.bytes(2)],
    );
  }

  @override
  List<Object?> get protoValues => [ak, nk];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'ak': config.encodeBinary(ak),
      'nk': config.encodeBinary(nk),
    }.notNullValue;
  }

  factory TronViewingKeyMessage.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronViewingKeyMessage(
      ak: config.decodeBinary<List<int>?>(
        json.valueAs('ak', normalizeKeyLookup: config.normalizeKeys),
      ),
      nk: config.decodeBinary<List<int>?>(
        json.valueAs('nk', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronViewingKeyMessage.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronViewingKeyMessage(
      ak: decode.getBytes<List<int>?>(1),
      nk: decode.getBytes<List<int>?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolViewingKeyMessage;
}

class TronIncomingViewingKeyMessage extends TronProtoMessage {
  final List<int>? ivk;

  const TronIncomingViewingKeyMessage({this.ivk});

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
  List<Object?> get protoValues => [ivk];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {'ivk': config.encodeBinary(ivk)}.notNullValue;
  }

  factory TronIncomingViewingKeyMessage.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronIncomingViewingKeyMessage(
      ivk: config.decodeBinary<List<int>?>(
        json.valueAs('ivk', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronIncomingViewingKeyMessage.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronIncomingViewingKeyMessage(ivk: decode.getBytes<List<int>?>(1));
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolIncomingViewingKeyMessage;
}

class TronDiversifierMessage extends TronProtoMessage {
  final List<int>? d;

  const TronDiversifierMessage({this.d});

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
  List<Object?> get protoValues => [d];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {'d': config.encodeBinary(d)}.notNullValue;
  }

  factory TronDiversifierMessage.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronDiversifierMessage(
      d: config.decodeBinary<List<int>?>(
        json.valueAs('d', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory TronDiversifierMessage.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronDiversifierMessage(d: decode.getBytes<List<int>?>(1));
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolDiversifierMessage;
}

class TronIncomingViewingKeyDiversifierMessage extends TronProtoMessage {
  final TronIncomingViewingKeyMessage? ivk;

  final TronDiversifierMessage? d;

  const TronIncomingViewingKeyDiversifierMessage({this.ivk, this.d});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.message(2)],
    );
  }

  @override
  List<Object?> get protoValues => [ivk, d];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'ivk': config.encodeMessage(ivk),
      'd': config.encodeMessage(d),
    }.notNullValue;
  }

  factory TronIncomingViewingKeyDiversifierMessage.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronIncomingViewingKeyDiversifierMessage(
      ivk: json.valueTo<TronIncomingViewingKeyMessage?, Object>(
        key: 'ivk',
        parse:
            (v) => TronIncomingViewingKeyMessage.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      d: json.valueTo<TronDiversifierMessage?, Object>(
        key: 'd',
        parse:
            (v) => TronDiversifierMessage.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronIncomingViewingKeyDiversifierMessage.deserialize(
    List<int> bytes,
  ) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronIncomingViewingKeyDiversifierMessage(
      ivk: decode.messageTo<TronIncomingViewingKeyMessage?>(
        1,
        (b) => TronIncomingViewingKeyMessage.deserialize(b),
      ),
      d: decode.messageTo<TronDiversifierMessage?>(
        2,
        (b) => TronDiversifierMessage.deserialize(b),
      ),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolIncomingViewingKeyDiversifierMessage;
}

class TronPaymentAddressMessage extends TronProtoMessage {
  final TronDiversifierMessage? d;

  final List<int>? pkD;

  final String? paymentAddress;

  const TronPaymentAddressMessage({this.d, this.pkD, this.paymentAddress});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.string(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [d, pkD, paymentAddress];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'd': config.encodeMessage(d),
      'pkD': config.encodeBinary(pkD),
      'payment_address': paymentAddress,
    }.notNullValue;
  }

  factory TronPaymentAddressMessage.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronPaymentAddressMessage(
      d: json.valueTo<TronDiversifierMessage?, Object>(
        key: 'd',
        parse:
            (v) => TronDiversifierMessage.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      pkD: config.decodeBinary<List<int>?>(
        json.valueAs('pkD', normalizeKeyLookup: config.normalizeKeys),
      ),
      paymentAddress: json.valueAsString<String?>(
        'payment_address',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronPaymentAddressMessage.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronPaymentAddressMessage(
      d: decode.messageTo<TronDiversifierMessage?>(
        1,
        (b) => TronDiversifierMessage.deserialize(b),
      ),
      pkD: decode.getBytes<List<int>?>(2),
      paymentAddress: decode.getString<String?>(3),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolPaymentAddressMessage;
}

class TronShieldedAddressInfo extends TronProtoMessage {
  final List<int>? sk;

  final List<int>? ask;

  final List<int>? nsk;

  final List<int>? ovk;

  final List<int>? ak;

  final List<int>? nk;

  final List<int>? ivk;

  final List<int>? d;

  final List<int>? pkD;

  final String? paymentAddress;

  const TronShieldedAddressInfo({
    this.sk,
    this.ask,
    this.nsk,
    this.ovk,
    this.ak,
    this.nk,
    this.ivk,
    this.d,
    this.pkD,
    this.paymentAddress,
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
        ProtoFieldConfig.bytes(7),
        ProtoFieldConfig.bytes(8),
        ProtoFieldConfig.bytes(9),
        ProtoFieldConfig.string(10),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    sk,
    ask,
    nsk,
    ovk,
    ak,
    nk,
    ivk,
    d,
    pkD,
    paymentAddress,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'sk': config.encodeBinary(sk),
      'ask': config.encodeBinary(ask),
      'nsk': config.encodeBinary(nsk),
      'ovk': config.encodeBinary(ovk),
      'ak': config.encodeBinary(ak),
      'nk': config.encodeBinary(nk),
      'ivk': config.encodeBinary(ivk),
      'd': config.encodeBinary(d),
      'pkD': config.encodeBinary(pkD),
      'payment_address': paymentAddress,
    }.notNullValue;
  }

  factory TronShieldedAddressInfo.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronShieldedAddressInfo(
      sk: config.decodeBinary<List<int>?>(
        json.valueAs('sk', normalizeKeyLookup: config.normalizeKeys),
      ),
      ask: config.decodeBinary<List<int>?>(
        json.valueAs('ask', normalizeKeyLookup: config.normalizeKeys),
      ),
      nsk: config.decodeBinary<List<int>?>(
        json.valueAs('nsk', normalizeKeyLookup: config.normalizeKeys),
      ),
      ovk: config.decodeBinary<List<int>?>(
        json.valueAs('ovk', normalizeKeyLookup: config.normalizeKeys),
      ),
      ak: config.decodeBinary<List<int>?>(
        json.valueAs('ak', normalizeKeyLookup: config.normalizeKeys),
      ),
      nk: config.decodeBinary<List<int>?>(
        json.valueAs('nk', normalizeKeyLookup: config.normalizeKeys),
      ),
      ivk: config.decodeBinary<List<int>?>(
        json.valueAs('ivk', normalizeKeyLookup: config.normalizeKeys),
      ),
      d: config.decodeBinary<List<int>?>(
        json.valueAs('d', normalizeKeyLookup: config.normalizeKeys),
      ),
      pkD: config.decodeBinary<List<int>?>(
        json.valueAs('pkD', normalizeKeyLookup: config.normalizeKeys),
      ),
      paymentAddress: json.valueAsString<String?>(
        'payment_address',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronShieldedAddressInfo.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronShieldedAddressInfo(
      sk: decode.getBytes<List<int>?>(1),
      ask: decode.getBytes<List<int>?>(2),
      nsk: decode.getBytes<List<int>?>(3),
      ovk: decode.getBytes<List<int>?>(4),
      ak: decode.getBytes<List<int>?>(5),
      nk: decode.getBytes<List<int>?>(6),
      ivk: decode.getBytes<List<int>?>(7),
      d: decode.getBytes<List<int>?>(8),
      pkD: decode.getBytes<List<int>?>(9),
      paymentAddress: decode.getString<String?>(10),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolShieldedAddressInfo;
}

class TronNoteParameters extends TronProtoMessage {
  final List<int>? ak;

  final List<int>? nk;

  final TronNote? note;

  final List<int>? txid;

  final int? index;

  const TronNoteParameters({
    this.ak,
    this.nk,
    this.note,
    this.txid,
    this.index,
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
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.bytes(4),
        ProtoFieldConfig.int32(5),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [ak, nk, note, txid, index];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'ak': config.encodeBinary(ak),
      'nk': config.encodeBinary(nk),
      'note': config.encodeMessage(note),
      'txid': config.encodeBinary(txid),
      'index': index,
    }.notNullValue;
  }

  factory TronNoteParameters.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronNoteParameters(
      ak: config.decodeBinary<List<int>?>(
        json.valueAs('ak', normalizeKeyLookup: config.normalizeKeys),
      ),
      nk: config.decodeBinary<List<int>?>(
        json.valueAs('nk', normalizeKeyLookup: config.normalizeKeys),
      ),
      note: json.valueTo<TronNote?, Object>(
        key: 'note',
        parse: (v) => TronNote.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      txid: config.decodeBinary<List<int>?>(
        json.valueAs('txid', normalizeKeyLookup: config.normalizeKeys),
      ),
      index: json.valueAsInt<int?>(
        'index',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronNoteParameters.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronNoteParameters(
      ak: decode.getBytes<List<int>?>(1),
      nk: decode.getBytes<List<int>?>(2),
      note: decode.messageTo<TronNote?>(3, (b) => TronNote.deserialize(b)),
      txid: decode.getBytes<List<int>?>(4),
      index: decode.getInt<int?>(5),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolNoteParameters;
}

class TronSpendResult extends TronProtoMessage {
  final bool? result;

  final String? message;

  const TronSpendResult({this.result, this.message});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bool(1), ProtoFieldConfig.string(2)],
    );
  }

  @override
  List<Object?> get protoValues => [result, message];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {'result': result, 'message': message}.notNullValue;
  }

  factory TronSpendResult.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronSpendResult(
      result: json.valueAsBool<bool?>(
        'result',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      message: json.valueAsString<String?>(
        'message',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronSpendResult.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronSpendResult(
      result: decode.getBool<bool?>(1),
      message: decode.getString<String?>(2),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolSpendResult;
}

class TronTransactionInfoList extends TronProtoMessage {
  final List<protocol_tron.TronTransactionInfo> transactionInfo;

  const TronTransactionInfoList({this.transactionInfo = const []});

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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [transactionInfo];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'transactionInfo':
          transactionInfo.map((e) => config.encodeMessage(e)).toList(),
    }.notNullValue;
  }

  factory TronTransactionInfoList.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronTransactionInfoList(
      transactionInfo:
          (json.valueEnsureAsList<dynamic>(
                'transactionInfo',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  protocol_tron.TronTransactionInfo,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => protocol_tron.TronTransactionInfo.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory TronTransactionInfoList.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronTransactionInfoList(
      transactionInfo:
          decode
              .getListOfBytes(1)
              .map((b) => protocol_tron.TronTransactionInfo.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolTransactionInfoList;
}

class TronSpendNoteTRC20 extends TronProtoMessage {
  final TronNote? note;

  final List<int>? alpha;

  final List<int>? root;

  final List<int>? path;

  final BigInt? pos;

  const TronSpendNoteTRC20({
    this.note,
    this.alpha,
    this.root,
    this.path,
    this.pos,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.bytes(4),
        ProtoFieldConfig.int64(5),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [note, alpha, root, path, pos];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'note': config.encodeMessage(note),
      'alpha': config.encodeBinary(alpha),
      'root': config.encodeBinary(root),
      'path': config.encodeBinary(path),
      'pos': config.encodeBigint(pos),
    }.notNullValue;
  }

  factory TronSpendNoteTRC20.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronSpendNoteTRC20(
      note: json.valueTo<TronNote?, Object>(
        key: 'note',
        parse: (v) => TronNote.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      alpha: config.decodeBinary<List<int>?>(
        json.valueAs('alpha', normalizeKeyLookup: config.normalizeKeys),
      ),
      root: config.decodeBinary<List<int>?>(
        json.valueAs('root', normalizeKeyLookup: config.normalizeKeys),
      ),
      path: config.decodeBinary<List<int>?>(
        json.valueAs('path', normalizeKeyLookup: config.normalizeKeys),
      ),
      pos: json.valueAsBigInt<BigInt?>(
        'pos',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronSpendNoteTRC20.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronSpendNoteTRC20(
      note: decode.messageTo<TronNote?>(1, (b) => TronNote.deserialize(b)),
      alpha: decode.getBytes<List<int>?>(2),
      root: decode.getBytes<List<int>?>(3),
      path: decode.getBytes<List<int>?>(4),
      pos: decode.getBigInt<BigInt?>(5),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolSpendNoteTRC20;
}

class TronPrivateShieldedTRC20Parameters extends TronProtoMessage {
  final List<int>? ask;

  final List<int>? nsk;

  final List<int>? ovk;

  final String? fromAmount;

  final List<TronSpendNoteTRC20> shieldedSpends;

  final List<TronReceiveNote> shieldedReceives;

  final List<int>? transparentToAddress;

  final String? toAmount;

  final List<int>? shieldedTrc20ContractAddress;

  const TronPrivateShieldedTRC20Parameters({
    this.ask,
    this.nsk,
    this.ovk,
    this.fromAmount,
    this.shieldedSpends = const [],
    this.shieldedReceives = const [],
    this.transparentToAddress,
    this.toAmount,
    this.shieldedTrc20ContractAddress,
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
        ProtoFieldConfig.string(4),
        ProtoFieldConfig.repeated(
          fieldNumber: 5,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 6,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.bytes(7),
        ProtoFieldConfig.string(8),
        ProtoFieldConfig.bytes(9),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    ask,
    nsk,
    ovk,
    fromAmount,
    shieldedSpends,
    shieldedReceives,
    transparentToAddress,
    toAmount,
    shieldedTrc20ContractAddress,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'ask': config.encodeBinary(ask),
      'nsk': config.encodeBinary(nsk),
      'ovk': config.encodeBinary(ovk),
      'from_amount': fromAmount,
      'shielded_spends':
          shieldedSpends.map((e) => config.encodeMessage(e)).toList(),
      'shielded_receives':
          shieldedReceives.map((e) => config.encodeMessage(e)).toList(),
      'transparent_to_address': config.encodeBinary(transparentToAddress),
      'to_amount': toAmount,
      'shielded_TRC20_contract_address': config.encodeBinary(
        shieldedTrc20ContractAddress,
      ),
    }.notNullValue;
  }

  factory TronPrivateShieldedTRC20Parameters.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronPrivateShieldedTRC20Parameters(
      ask: config.decodeBinary<List<int>?>(
        json.valueAs('ask', normalizeKeyLookup: config.normalizeKeys),
      ),
      nsk: config.decodeBinary<List<int>?>(
        json.valueAs('nsk', normalizeKeyLookup: config.normalizeKeys),
      ),
      ovk: config.decodeBinary<List<int>?>(
        json.valueAs('ovk', normalizeKeyLookup: config.normalizeKeys),
      ),
      fromAmount: json.valueAsString<String?>(
        'from_amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      shieldedSpends:
          (json.valueEnsureAsList<dynamic>(
                'shielded_spends',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronSpendNoteTRC20, Object>(
                  value: e,
                  parse:
                      (v) => TronSpendNoteTRC20.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      shieldedReceives:
          (json.valueEnsureAsList<dynamic>(
                'shielded_receives',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronReceiveNote, Object>(
                  value: e,
                  parse:
                      (v) => TronReceiveNote.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      transparentToAddress: config.decodeBinary<List<int>?>(
        json.valueAs(
          'transparent_to_address',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      toAmount: json.valueAsString<String?>(
        'to_amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      shieldedTrc20ContractAddress: config.decodeBinary<List<int>?>(
        json.valueAs(
          'shielded_TRC20_contract_address',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
    );
  }

  factory TronPrivateShieldedTRC20Parameters.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronPrivateShieldedTRC20Parameters(
      ask: decode.getBytes<List<int>?>(1),
      nsk: decode.getBytes<List<int>?>(2),
      ovk: decode.getBytes<List<int>?>(3),
      fromAmount: decode.getString<String?>(4),
      shieldedSpends:
          decode
              .getListOfBytes(5)
              .map((b) => TronSpendNoteTRC20.deserialize(b))
              .toList(),
      shieldedReceives:
          decode
              .getListOfBytes(6)
              .map((b) => TronReceiveNote.deserialize(b))
              .toList(),
      transparentToAddress: decode.getBytes<List<int>?>(7),
      toAmount: decode.getString<String?>(8),
      shieldedTrc20ContractAddress: decode.getBytes<List<int>?>(9),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolPrivateShieldedTRC20Parameters;
}

class TronPrivateShieldedTRC20ParametersWithoutAsk extends TronProtoMessage {
  final List<int>? ak;

  final List<int>? nsk;

  final List<int>? ovk;

  final String? fromAmount;

  final List<TronSpendNoteTRC20> shieldedSpends;

  final List<TronReceiveNote> shieldedReceives;

  final List<int>? transparentToAddress;

  final String? toAmount;

  final List<int>? shieldedTrc20ContractAddress;

  const TronPrivateShieldedTRC20ParametersWithoutAsk({
    this.ak,
    this.nsk,
    this.ovk,
    this.fromAmount,
    this.shieldedSpends = const [],
    this.shieldedReceives = const [],
    this.transparentToAddress,
    this.toAmount,
    this.shieldedTrc20ContractAddress,
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
        ProtoFieldConfig.string(4),
        ProtoFieldConfig.repeated(
          fieldNumber: 5,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 6,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.bytes(7),
        ProtoFieldConfig.string(8),
        ProtoFieldConfig.bytes(9),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    ak,
    nsk,
    ovk,
    fromAmount,
    shieldedSpends,
    shieldedReceives,
    transparentToAddress,
    toAmount,
    shieldedTrc20ContractAddress,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'ak': config.encodeBinary(ak),
      'nsk': config.encodeBinary(nsk),
      'ovk': config.encodeBinary(ovk),
      'from_amount': fromAmount,
      'shielded_spends':
          shieldedSpends.map((e) => config.encodeMessage(e)).toList(),
      'shielded_receives':
          shieldedReceives.map((e) => config.encodeMessage(e)).toList(),
      'transparent_to_address': config.encodeBinary(transparentToAddress),
      'to_amount': toAmount,
      'shielded_TRC20_contract_address': config.encodeBinary(
        shieldedTrc20ContractAddress,
      ),
    }.notNullValue;
  }

  factory TronPrivateShieldedTRC20ParametersWithoutAsk.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronPrivateShieldedTRC20ParametersWithoutAsk(
      ak: config.decodeBinary<List<int>?>(
        json.valueAs('ak', normalizeKeyLookup: config.normalizeKeys),
      ),
      nsk: config.decodeBinary<List<int>?>(
        json.valueAs('nsk', normalizeKeyLookup: config.normalizeKeys),
      ),
      ovk: config.decodeBinary<List<int>?>(
        json.valueAs('ovk', normalizeKeyLookup: config.normalizeKeys),
      ),
      fromAmount: json.valueAsString<String?>(
        'from_amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      shieldedSpends:
          (json.valueEnsureAsList<dynamic>(
                'shielded_spends',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronSpendNoteTRC20, Object>(
                  value: e,
                  parse:
                      (v) => TronSpendNoteTRC20.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      shieldedReceives:
          (json.valueEnsureAsList<dynamic>(
                'shielded_receives',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronReceiveNote, Object>(
                  value: e,
                  parse:
                      (v) => TronReceiveNote.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      transparentToAddress: config.decodeBinary<List<int>?>(
        json.valueAs(
          'transparent_to_address',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      toAmount: json.valueAsString<String?>(
        'to_amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      shieldedTrc20ContractAddress: config.decodeBinary<List<int>?>(
        json.valueAs(
          'shielded_TRC20_contract_address',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
    );
  }

  factory TronPrivateShieldedTRC20ParametersWithoutAsk.deserialize(
    List<int> bytes,
  ) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronPrivateShieldedTRC20ParametersWithoutAsk(
      ak: decode.getBytes<List<int>?>(1),
      nsk: decode.getBytes<List<int>?>(2),
      ovk: decode.getBytes<List<int>?>(3),
      fromAmount: decode.getString<String?>(4),
      shieldedSpends:
          decode
              .getListOfBytes(5)
              .map((b) => TronSpendNoteTRC20.deserialize(b))
              .toList(),
      shieldedReceives:
          decode
              .getListOfBytes(6)
              .map((b) => TronReceiveNote.deserialize(b))
              .toList(),
      transparentToAddress: decode.getBytes<List<int>?>(7),
      toAmount: decode.getString<String?>(8),
      shieldedTrc20ContractAddress: decode.getBytes<List<int>?>(9),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolPrivateShieldedTRC20ParametersWithoutAsk;
}

class TronShieldedTRC20Parameters extends TronProtoMessage {
  final List<protocol_shield_contract.TronSpendDescription> spendDescription;

  final List<protocol_shield_contract.TronReceiveDescription>
  receiveDescription;

  final List<int>? bindingSignature;

  final List<int>? messageHash;

  final String? triggerContractInput;

  final String? parameterType;

  const TronShieldedTRC20Parameters({
    this.spendDescription = const [],
    this.receiveDescription = const [],
    this.bindingSignature,
    this.messageHash,
    this.triggerContractInput,
    this.parameterType,
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
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.bytes(4),
        ProtoFieldConfig.string(5),
        ProtoFieldConfig.string(6),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    spendDescription,
    receiveDescription,
    bindingSignature,
    messageHash,
    triggerContractInput,
    parameterType,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'spend_description':
          spendDescription.map((e) => config.encodeMessage(e)).toList(),
      'receive_description':
          receiveDescription.map((e) => config.encodeMessage(e)).toList(),
      'binding_signature': config.encodeBinary(bindingSignature),
      'message_hash': config.encodeBinary(messageHash),
      'trigger_contract_input': triggerContractInput,
      'parameter_type': parameterType,
    }.notNullValue;
  }

  factory TronShieldedTRC20Parameters.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronShieldedTRC20Parameters(
      spendDescription:
          (json.valueEnsureAsList<dynamic>(
                'spend_description',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  protocol_shield_contract.TronSpendDescription,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => protocol_shield_contract
                          .TronSpendDescription.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      receiveDescription:
          (json.valueEnsureAsList<dynamic>(
                'receive_description',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  protocol_shield_contract.TronReceiveDescription,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => protocol_shield_contract
                          .TronReceiveDescription.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      bindingSignature: config.decodeBinary<List<int>?>(
        json.valueAs(
          'binding_signature',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      messageHash: config.decodeBinary<List<int>?>(
        json.valueAs('message_hash', normalizeKeyLookup: config.normalizeKeys),
      ),
      triggerContractInput: json.valueAsString<String?>(
        'trigger_contract_input',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      parameterType: json.valueAsString<String?>(
        'parameter_type',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronShieldedTRC20Parameters.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronShieldedTRC20Parameters(
      spendDescription:
          decode
              .getListOfBytes(1)
              .map(
                (b) => protocol_shield_contract
                    .TronSpendDescription.deserialize(b),
              )
              .toList(),
      receiveDescription:
          decode
              .getListOfBytes(2)
              .map(
                (b) => protocol_shield_contract
                    .TronReceiveDescription.deserialize(b),
              )
              .toList(),
      bindingSignature: decode.getBytes<List<int>?>(3),
      messageHash: decode.getBytes<List<int>?>(4),
      triggerContractInput: decode.getString<String?>(5),
      parameterType: decode.getString<String?>(6),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolShieldedTRC20Parameters;
}

class TronIvkDecryptTRC20Parameters extends TronProtoMessage {
  final BigInt? startBlockIndex;

  final BigInt? endBlockIndex;

  final List<int>? shieldedTrc20ContractAddress;

  final List<int>? ivk;

  final List<int>? ak;

  final List<int>? nk;

  final List<String> events;

  const TronIvkDecryptTRC20Parameters({
    this.startBlockIndex,
    this.endBlockIndex,
    this.shieldedTrc20ContractAddress,
    this.ivk,
    this.ak,
    this.nk,
    this.events = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.bytes(4),
        ProtoFieldConfig.bytes(5),
        ProtoFieldConfig.bytes(6),
        ProtoFieldConfig.repeated(
          fieldNumber: 7,
          elementType: ProtoFieldType.string,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    startBlockIndex,
    endBlockIndex,
    shieldedTrc20ContractAddress,
    ivk,
    ak,
    nk,
    events,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'start_block_index': config.encodeBigint(startBlockIndex),
      'end_block_index': config.encodeBigint(endBlockIndex),
      'shielded_TRC20_contract_address': config.encodeBinary(
        shieldedTrc20ContractAddress,
      ),
      'ivk': config.encodeBinary(ivk),
      'ak': config.encodeBinary(ak),
      'nk': config.encodeBinary(nk),
      'events': events.map((e) => e).toList(),
    }.notNullValue;
  }

  factory TronIvkDecryptTRC20Parameters.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronIvkDecryptTRC20Parameters(
      startBlockIndex: json.valueAsBigInt<BigInt?>(
        'start_block_index',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      endBlockIndex: json.valueAsBigInt<BigInt?>(
        'end_block_index',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      shieldedTrc20ContractAddress: config.decodeBinary<List<int>?>(
        json.valueAs(
          'shielded_TRC20_contract_address',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      ivk: config.decodeBinary<List<int>?>(
        json.valueAs('ivk', normalizeKeyLookup: config.normalizeKeys),
      ),
      ak: config.decodeBinary<List<int>?>(
        json.valueAs('ak', normalizeKeyLookup: config.normalizeKeys),
      ),
      nk: config.decodeBinary<List<int>?>(
        json.valueAs('nk', normalizeKeyLookup: config.normalizeKeys),
      ),
      events:
          (json.valueEnsureAsList<dynamic>(
            'events',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => JsonParser.valueAsString<String>(e)).toList(),
    );
  }

  factory TronIvkDecryptTRC20Parameters.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronIvkDecryptTRC20Parameters(
      startBlockIndex: decode.getBigInt<BigInt?>(1),
      endBlockIndex: decode.getBigInt<BigInt?>(2),
      shieldedTrc20ContractAddress: decode.getBytes<List<int>?>(3),
      ivk: decode.getBytes<List<int>?>(4),
      ak: decode.getBytes<List<int>?>(5),
      nk: decode.getBytes<List<int>?>(6),
      events: decode.getListOrEmpty<String>(7),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolIvkDecryptTRC20Parameters;
}

class TronOvkDecryptTRC20Parameters extends TronProtoMessage {
  final BigInt? startBlockIndex;

  final BigInt? endBlockIndex;

  final List<int>? ovk;

  final List<int>? shieldedTrc20ContractAddress;

  final List<String> events;

  const TronOvkDecryptTRC20Parameters({
    this.startBlockIndex,
    this.endBlockIndex,
    this.ovk,
    this.shieldedTrc20ContractAddress,
    this.events = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int64(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.bytes(4),
        ProtoFieldConfig.repeated(
          fieldNumber: 5,
          elementType: ProtoFieldType.string,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    startBlockIndex,
    endBlockIndex,
    ovk,
    shieldedTrc20ContractAddress,
    events,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'start_block_index': config.encodeBigint(startBlockIndex),
      'end_block_index': config.encodeBigint(endBlockIndex),
      'ovk': config.encodeBinary(ovk),
      'shielded_TRC20_contract_address': config.encodeBinary(
        shieldedTrc20ContractAddress,
      ),
      'events': events.map((e) => e).toList(),
    }.notNullValue;
  }

  factory TronOvkDecryptTRC20Parameters.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronOvkDecryptTRC20Parameters(
      startBlockIndex: json.valueAsBigInt<BigInt?>(
        'start_block_index',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      endBlockIndex: json.valueAsBigInt<BigInt?>(
        'end_block_index',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      ovk: config.decodeBinary<List<int>?>(
        json.valueAs('ovk', normalizeKeyLookup: config.normalizeKeys),
      ),
      shieldedTrc20ContractAddress: config.decodeBinary<List<int>?>(
        json.valueAs(
          'shielded_TRC20_contract_address',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      events:
          (json.valueEnsureAsList<dynamic>(
            'events',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => JsonParser.valueAsString<String>(e)).toList(),
    );
  }

  factory TronOvkDecryptTRC20Parameters.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronOvkDecryptTRC20Parameters(
      startBlockIndex: decode.getBigInt<BigInt?>(1),
      endBlockIndex: decode.getBigInt<BigInt?>(2),
      ovk: decode.getBytes<List<int>?>(3),
      shieldedTrc20ContractAddress: decode.getBytes<List<int>?>(4),
      events: decode.getListOrEmpty<String>(5),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolOvkDecryptTRC20Parameters;
}

class TronDecryptNotesTRC20 extends TronProtoMessage {
  final List<TronDecryptNotesTRC20NoteTx> noteTxs;

  const TronDecryptNotesTRC20({this.noteTxs = const []});

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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [noteTxs];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'noteTxs': noteTxs.map((e) => config.encodeMessage(e)).toList(),
    }.notNullValue;
  }

  factory TronDecryptNotesTRC20.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronDecryptNotesTRC20(
      noteTxs:
          (json.valueEnsureAsList<dynamic>(
                'noteTxs',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronDecryptNotesTRC20NoteTx, Object>(
                  value: e,
                  parse:
                      (v) => TronDecryptNotesTRC20NoteTx.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
    );
  }

  factory TronDecryptNotesTRC20.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronDecryptNotesTRC20(
      noteTxs:
          decode
              .getListOfBytes(1)
              .map((b) => TronDecryptNotesTRC20NoteTx.deserialize(b))
              .toList(),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolDecryptNotesTRC20;
}

class TronDecryptNotesTRC20NoteTx extends TronProtoMessage {
  final TronNote? note;

  final BigInt? position;

  final bool? isSpent;

  final List<int>? txid;

  final int? index;

  /// the index of note in txid
  final String? toAmount;

  final List<int>? transparentToAddress;

  const TronDecryptNotesTRC20NoteTx({
    this.note,
    this.position,
    this.isSpent,
    this.txid,
    this.index,
    this.toAmount,
    this.transparentToAddress,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.bool(3),
        ProtoFieldConfig.bytes(4),
        ProtoFieldConfig.int32(5),
        ProtoFieldConfig.string(6),
        ProtoFieldConfig.bytes(7),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    note,
    position,
    isSpent,
    txid,
    index,
    toAmount,
    transparentToAddress,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'note': config.encodeMessage(note),
      'position': config.encodeBigint(position),
      'is_spent': isSpent,
      'txid': config.encodeBinary(txid),
      'index': index,
      'to_amount': toAmount,
      'transparent_to_address': config.encodeBinary(transparentToAddress),
    }.notNullValue;
  }

  factory TronDecryptNotesTRC20NoteTx.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronDecryptNotesTRC20NoteTx(
      note: json.valueTo<TronNote?, Object>(
        key: 'note',
        parse: (v) => TronNote.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      position: json.valueAsBigInt<BigInt?>(
        'position',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      isSpent: json.valueAsBool<bool?>(
        'is_spent',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      txid: config.decodeBinary<List<int>?>(
        json.valueAs('txid', normalizeKeyLookup: config.normalizeKeys),
      ),
      index: json.valueAsInt<int?>(
        'index',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      toAmount: json.valueAsString<String?>(
        'to_amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      transparentToAddress: config.decodeBinary<List<int>?>(
        json.valueAs(
          'transparent_to_address',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
    );
  }

  factory TronDecryptNotesTRC20NoteTx.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronDecryptNotesTRC20NoteTx(
      note: decode.messageTo<TronNote?>(1, (b) => TronNote.deserialize(b)),
      position: decode.getBigInt<BigInt?>(2),
      isSpent: decode.getBool<bool?>(3),
      txid: decode.getBytes<List<int>?>(4),
      index: decode.getInt<int?>(5),
      toAmount: decode.getString<String?>(6),
      transparentToAddress: decode.getBytes<List<int>?>(7),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolDecryptNotesTRC20NoteTx;
}

class TronNfTRC20Parameters extends TronProtoMessage {
  final TronNote? note;

  final List<int>? ak;

  final List<int>? nk;

  final BigInt? position;

  final List<int>? shieldedTrc20ContractAddress;

  const TronNfTRC20Parameters({
    this.note,
    this.ak,
    this.nk,
    this.position,
    this.shieldedTrc20ContractAddress,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.int64(4),
        ProtoFieldConfig.bytes(5),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    note,
    ak,
    nk,
    position,
    shieldedTrc20ContractAddress,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'note': config.encodeMessage(note),
      'ak': config.encodeBinary(ak),
      'nk': config.encodeBinary(nk),
      'position': config.encodeBigint(position),
      'shielded_TRC20_contract_address': config.encodeBinary(
        shieldedTrc20ContractAddress,
      ),
    }.notNullValue;
  }

  factory TronNfTRC20Parameters.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronNfTRC20Parameters(
      note: json.valueTo<TronNote?, Object>(
        key: 'note',
        parse: (v) => TronNote.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      ak: config.decodeBinary<List<int>?>(
        json.valueAs('ak', normalizeKeyLookup: config.normalizeKeys),
      ),
      nk: config.decodeBinary<List<int>?>(
        json.valueAs('nk', normalizeKeyLookup: config.normalizeKeys),
      ),
      position: json.valueAsBigInt<BigInt?>(
        'position',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      shieldedTrc20ContractAddress: config.decodeBinary<List<int>?>(
        json.valueAs(
          'shielded_TRC20_contract_address',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
    );
  }

  factory TronNfTRC20Parameters.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronNfTRC20Parameters(
      note: decode.messageTo<TronNote?>(1, (b) => TronNote.deserialize(b)),
      ak: decode.getBytes<List<int>?>(2),
      nk: decode.getBytes<List<int>?>(3),
      position: decode.getBigInt<BigInt?>(4),
      shieldedTrc20ContractAddress: decode.getBytes<List<int>?>(5),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolNfTRC20Parameters;
}

class TronNullifierResult extends TronProtoMessage {
  final bool? isSpent;

  const TronNullifierResult({this.isSpent});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bool(1)],
    );
  }

  @override
  List<Object?> get protoValues => [isSpent];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {'is_spent': isSpent}.notNullValue;
  }

  factory TronNullifierResult.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronNullifierResult(
      isSpent: json.valueAsBool<bool?>(
        'is_spent',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronNullifierResult.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronNullifierResult(isSpent: decode.getBool<bool?>(1));
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolNullifierResult;
}

class TronShieldedTRC20TriggerContractParameters extends TronProtoMessage {
  final TronShieldedTRC20Parameters? shieldedTrc20Parameters;

  final List<TronBytesMessage> spendAuthoritySignature;

  final String? amount;

  final List<int>? transparentToAddress;

  const TronShieldedTRC20TriggerContractParameters({
    this.shieldedTrc20Parameters,
    this.spendAuthoritySignature = const [],
    this.amount,
    this.transparentToAddress,
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
        ProtoFieldConfig.string(3),
        ProtoFieldConfig.bytes(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    shieldedTrc20Parameters,
    spendAuthoritySignature,
    amount,
    transparentToAddress,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'shielded_TRC20_Parameters': config.encodeMessage(
        shieldedTrc20Parameters,
      ),
      'spend_authority_signature':
          spendAuthoritySignature.map((e) => config.encodeMessage(e)).toList(),
      'amount': amount,
      'transparent_to_address': config.encodeBinary(transparentToAddress),
    }.notNullValue;
  }

  factory TronShieldedTRC20TriggerContractParameters.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronShieldedTRC20TriggerContractParameters(
      shieldedTrc20Parameters: json
          .valueTo<TronShieldedTRC20Parameters?, Object>(
            key: 'shielded_TRC20_Parameters',
            parse:
                (v) => TronShieldedTRC20Parameters.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      spendAuthoritySignature:
          (json.valueEnsureAsList<dynamic>(
                'spend_authority_signature',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<TronBytesMessage, Object>(
                  value: e,
                  parse:
                      (v) => TronBytesMessage.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      amount: json.valueAsString<String?>(
        'amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      transparentToAddress: config.decodeBinary<List<int>?>(
        json.valueAs(
          'transparent_to_address',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
    );
  }

  factory TronShieldedTRC20TriggerContractParameters.deserialize(
    List<int> bytes,
  ) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronShieldedTRC20TriggerContractParameters(
      shieldedTrc20Parameters: decode.messageTo<TronShieldedTRC20Parameters?>(
        1,
        (b) => TronShieldedTRC20Parameters.deserialize(b),
      ),
      spendAuthoritySignature:
          decode
              .getListOfBytes(2)
              .map((b) => TronBytesMessage.deserialize(b))
              .toList(),
      amount: decode.getString<String?>(3),
      transparentToAddress: decode.getBytes<List<int>?>(4),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolShieldedTRC20TriggerContractParameters;
}

class TronWalletGetMarketOrderById extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_tron.TronMarketOrder> {
  final TronProtoJsonConfig jsonConfig;

  final TronBytesMessage? getMarketOrderById;

  const TronWalletGetMarketOrderById({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getMarketOrderById,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getMarketOrderById?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getMarketOrderById?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getMarketOrderById) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetMarketOrderById;
  @override
  protocol_tron.TronMarketOrder onServiceResponse(List<int> bytes) {
    return protocol_tron.TronMarketOrder.deserialize(bytes);
  }

  @override
  protocol_tron.TronMarketOrder onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_tron.TronMarketOrder.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetMarketOrderByAccount extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_tron.TronMarketOrderList> {
  final TronProtoJsonConfig jsonConfig;

  final TronBytesMessage? getMarketOrderByAccount;

  const TronWalletGetMarketOrderByAccount({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getMarketOrderByAccount,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getMarketOrderByAccount?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getMarketOrderByAccount?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getMarketOrderByAccount) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetMarketOrderByAccount;
  @override
  protocol_tron.TronMarketOrderList onServiceResponse(List<int> bytes) {
    return protocol_tron.TronMarketOrderList.deserialize(bytes);
  }

  @override
  protocol_tron.TronMarketOrderList onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_tron.TronMarketOrderList.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetMarketPairList extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_tron.TronMarketOrderPairList> {
  final TronProtoJsonConfig jsonConfig;

  final TronEmptyMessage? getMarketPairList;

  const TronWalletGetMarketPairList({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getMarketPairList,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getMarketPairList?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getMarketPairList?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getMarketPairList) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetMarketPairList;
  @override
  protocol_tron.TronMarketOrderPairList onServiceResponse(List<int> bytes) {
    return protocol_tron.TronMarketOrderPairList.deserialize(bytes);
  }

  @override
  protocol_tron.TronMarketOrderPairList onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_tron.TronMarketOrderPairList.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletListNodes extends TronProtoMessage
    with ITronProtoServiceMessage<TronNodeList> {
  final TronProtoJsonConfig jsonConfig;

  final TronEmptyMessage? listNodes;

  const TronWalletListNodes({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.listNodes,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      listNodes?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => listNodes?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(listNodes) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletListNodes;
  @override
  TronNodeList onServiceResponse(List<int> bytes) {
    return TronNodeList.deserialize(bytes);
  }

  @override
  TronNodeList onServiceResponseJson(Map<String, dynamic> json) {
    return TronNodeList.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetAssetIssueByName extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_contracts.TronAssetIssueContract> {
  final TronProtoJsonConfig jsonConfig;

  final TronBytesMessage? getAssetIssueByName;

  const TronWalletGetAssetIssueByName({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getAssetIssueByName,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getAssetIssueByName?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getAssetIssueByName?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getAssetIssueByName) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetAssetIssueByName;
  @override
  protocol_contracts.TronAssetIssueContract onServiceResponse(List<int> bytes) {
    return protocol_contracts.TronAssetIssueContract.deserialize(bytes);
  }

  @override
  protocol_contracts.TronAssetIssueContract onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_contracts.TronAssetIssueContract.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletGetAssetIssueListByName extends TronProtoMessage
    with ITronProtoServiceMessage<TronAssetIssueList> {
  final TronProtoJsonConfig jsonConfig;

  final TronBytesMessage? getAssetIssueListByName;

  const TronWalletGetAssetIssueListByName({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getAssetIssueListByName,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getAssetIssueListByName?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getAssetIssueListByName?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getAssetIssueListByName) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetAssetIssueListByName;
  @override
  TronAssetIssueList onServiceResponse(List<int> bytes) {
    return TronAssetIssueList.deserialize(bytes);
  }

  @override
  TronAssetIssueList onServiceResponseJson(Map<String, dynamic> json) {
    return TronAssetIssueList.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetAssetIssueById extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_contracts.TronAssetIssueContract> {
  final TronProtoJsonConfig jsonConfig;

  final TronBytesMessage? getAssetIssueById;

  const TronWalletGetAssetIssueById({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getAssetIssueById,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getAssetIssueById?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getAssetIssueById?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getAssetIssueById) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetAssetIssueById;
  @override
  protocol_contracts.TronAssetIssueContract onServiceResponse(List<int> bytes) {
    return protocol_contracts.TronAssetIssueContract.deserialize(bytes);
  }

  @override
  protocol_contracts.TronAssetIssueContract onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_contracts.TronAssetIssueContract.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletGetNowBlock extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_tron.TronBlock> {
  final TronProtoJsonConfig jsonConfig;

  /// Please use GetNowBlock2 instead of this function.
  final TronEmptyMessage? getNowBlock;

  const TronWalletGetNowBlock({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getNowBlock,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getNowBlock?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getNowBlock?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getNowBlock) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetNowBlock;
  @override
  protocol_tron.TronBlock onServiceResponse(List<int> bytes) {
    return protocol_tron.TronBlock.deserialize(bytes);
  }

  @override
  protocol_tron.TronBlock onServiceResponseJson(Map<String, dynamic> json) {
    return protocol_tron.TronBlock.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetNowBlock2 extends TronProtoMessage
    with ITronProtoServiceMessage<TronBlockExtention> {
  final TronProtoJsonConfig jsonConfig;

  /// Use this function instead of GetNowBlock.
  final TronEmptyMessage? getNowBlock2;

  const TronWalletGetNowBlock2({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getNowBlock2,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getNowBlock2?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getNowBlock2?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getNowBlock2) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetNowBlock2;
  @override
  TronBlockExtention onServiceResponse(List<int> bytes) {
    return TronBlockExtention.deserialize(bytes);
  }

  @override
  TronBlockExtention onServiceResponseJson(Map<String, dynamic> json) {
    return TronBlockExtention.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetBlockByNum extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_tron.TronBlock> {
  final TronProtoJsonConfig jsonConfig;

  /// Please use GetBlockByNum2 instead of this function.
  final TronNumberMessage? getBlockByNum;

  const TronWalletGetBlockByNum({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getBlockByNum,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getBlockByNum?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getBlockByNum?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getBlockByNum) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetBlockByNum;
  @override
  protocol_tron.TronBlock onServiceResponse(List<int> bytes) {
    return protocol_tron.TronBlock.deserialize(bytes);
  }

  @override
  protocol_tron.TronBlock onServiceResponseJson(Map<String, dynamic> json) {
    return protocol_tron.TronBlock.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetBlockByNum2 extends TronProtoMessage
    with ITronProtoServiceMessage<TronBlockExtention> {
  final TronProtoJsonConfig jsonConfig;

  /// Use this function instead of GetBlockByNum.
  final TronNumberMessage? getBlockByNum2;

  const TronWalletGetBlockByNum2({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getBlockByNum2,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getBlockByNum2?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getBlockByNum2?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getBlockByNum2) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetBlockByNum2;
  @override
  TronBlockExtention onServiceResponse(List<int> bytes) {
    return TronBlockExtention.deserialize(bytes);
  }

  @override
  TronBlockExtention onServiceResponseJson(Map<String, dynamic> json) {
    return TronBlockExtention.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetTransactionCountByBlockNum extends TronProtoMessage
    with ITronProtoServiceMessage<TronNumberMessage> {
  final TronProtoJsonConfig jsonConfig;

  final TronNumberMessage? getTransactionCountByBlockNum;

  const TronWalletGetTransactionCountByBlockNum({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getTransactionCountByBlockNum,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getTransactionCountByBlockNum?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues =>
      getTransactionCountByBlockNum?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getTransactionCountByBlockNum) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetTransactionCountByBlockNum;
  @override
  TronNumberMessage onServiceResponse(List<int> bytes) {
    return TronNumberMessage.deserialize(bytes);
  }

  @override
  TronNumberMessage onServiceResponseJson(Map<String, dynamic> json) {
    return TronNumberMessage.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetBlockById extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_tron.TronBlock> {
  final TronProtoJsonConfig jsonConfig;

  final TronBytesMessage? getBlockById;

  const TronWalletGetBlockById({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getBlockById,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getBlockById?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getBlockById?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getBlockById) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetBlockById;
  @override
  protocol_tron.TronBlock onServiceResponse(List<int> bytes) {
    return protocol_tron.TronBlock.deserialize(bytes);
  }

  @override
  protocol_tron.TronBlock onServiceResponseJson(Map<String, dynamic> json) {
    return protocol_tron.TronBlock.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetBlockByLimitNext extends TronProtoMessage
    with ITronProtoServiceMessage<TronBlockList> {
  final TronProtoJsonConfig jsonConfig;

  /// Please use GetBlockByLimitNext2 instead of this function.
  final TronBlockLimit? getBlockByLimitNext;

  const TronWalletGetBlockByLimitNext({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getBlockByLimitNext,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getBlockByLimitNext?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getBlockByLimitNext?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getBlockByLimitNext) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetBlockByLimitNext;
  @override
  TronBlockList onServiceResponse(List<int> bytes) {
    return TronBlockList.deserialize(bytes);
  }

  @override
  TronBlockList onServiceResponseJson(Map<String, dynamic> json) {
    return TronBlockList.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetBlockByLimitNext2 extends TronProtoMessage
    with ITronProtoServiceMessage<TronBlockListExtention> {
  final TronProtoJsonConfig jsonConfig;

  /// Use this function instead of GetBlockByLimitNext.
  final TronBlockLimit? getBlockByLimitNext2;

  const TronWalletGetBlockByLimitNext2({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getBlockByLimitNext2,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getBlockByLimitNext2?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getBlockByLimitNext2?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getBlockByLimitNext2) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetBlockByLimitNext2;
  @override
  TronBlockListExtention onServiceResponse(List<int> bytes) {
    return TronBlockListExtention.deserialize(bytes);
  }

  @override
  TronBlockListExtention onServiceResponseJson(Map<String, dynamic> json) {
    return TronBlockListExtention.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetBlockByLatestNum extends TronProtoMessage
    with ITronProtoServiceMessage<TronBlockList> {
  final TronProtoJsonConfig jsonConfig;

  /// Please use GetBlockByLatestNum2 instead of this function.
  final TronNumberMessage? getBlockByLatestNum;

  const TronWalletGetBlockByLatestNum({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getBlockByLatestNum,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getBlockByLatestNum?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getBlockByLatestNum?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getBlockByLatestNum) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetBlockByLatestNum;
  @override
  TronBlockList onServiceResponse(List<int> bytes) {
    return TronBlockList.deserialize(bytes);
  }

  @override
  TronBlockList onServiceResponseJson(Map<String, dynamic> json) {
    return TronBlockList.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetBlockByLatestNum2 extends TronProtoMessage
    with ITronProtoServiceMessage<TronBlockListExtention> {
  final TronProtoJsonConfig jsonConfig;

  /// Use this function instead of GetBlockByLatestNum.
  final TronNumberMessage? getBlockByLatestNum2;

  const TronWalletGetBlockByLatestNum2({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getBlockByLatestNum2,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getBlockByLatestNum2?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getBlockByLatestNum2?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getBlockByLatestNum2) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetBlockByLatestNum2;
  @override
  TronBlockListExtention onServiceResponse(List<int> bytes) {
    return TronBlockListExtention.deserialize(bytes);
  }

  @override
  TronBlockListExtention onServiceResponseJson(Map<String, dynamic> json) {
    return TronBlockListExtention.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetTransactionById extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_contracts.TronTransaction> {
  final TronProtoJsonConfig jsonConfig;

  final TronBytesMessage? getTransactionById;

  const TronWalletGetTransactionById({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getTransactionById,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getTransactionById?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getTransactionById?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getTransactionById) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetTransactionById;
  @override
  protocol_contracts.TronTransaction onServiceResponse(List<int> bytes) {
    return protocol_contracts.TronTransaction.deserialize(bytes);
  }

  @override
  protocol_contracts.TronTransaction onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_contracts.TronTransaction.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletGetContract extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_contracts.TronSmartContract> {
  final TronProtoJsonConfig jsonConfig;

  final TronBytesMessage? getContract;

  const TronWalletGetContract({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getContract,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getContract?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getContract?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getContract) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetContract;
  @override
  protocol_contracts.TronSmartContract onServiceResponse(List<int> bytes) {
    return protocol_contracts.TronSmartContract.deserialize(bytes);
  }

  @override
  protocol_contracts.TronSmartContract onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_contracts.TronSmartContract.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletGetContractInfo extends TronProtoMessage
    with
        ITronProtoServiceMessage<
          protocol_smart_contract.TronSmartContractDataWrapper
        > {
  final TronProtoJsonConfig jsonConfig;

  final TronBytesMessage? getContractInfo;

  const TronWalletGetContractInfo({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getContractInfo,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getContractInfo?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getContractInfo?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getContractInfo) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetContractInfo;
  @override
  protocol_smart_contract.TronSmartContractDataWrapper onServiceResponse(
    List<int> bytes,
  ) {
    return protocol_smart_contract.TronSmartContractDataWrapper.deserialize(
      bytes,
    );
  }

  @override
  protocol_smart_contract.TronSmartContractDataWrapper onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_smart_contract.TronSmartContractDataWrapper.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletListWitnesses extends TronProtoMessage
    with ITronProtoServiceMessage<TronWitnessList> {
  final TronProtoJsonConfig jsonConfig;

  final TronEmptyMessage? listWitnesses;

  const TronWalletListWitnesses({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.listWitnesses,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      listWitnesses?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => listWitnesses?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(listWitnesses) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletListWitnesses;
  @override
  TronWitnessList onServiceResponse(List<int> bytes) {
    return TronWitnessList.deserialize(bytes);
  }

  @override
  TronWitnessList onServiceResponseJson(Map<String, dynamic> json) {
    return TronWitnessList.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetPaginatedNowWitnessList extends TronProtoMessage
    with ITronProtoServiceMessage<TronWitnessList> {
  final TronProtoJsonConfig jsonConfig;

  final TronPaginatedMessage? getPaginatedNowWitnessList;

  const TronWalletGetPaginatedNowWitnessList({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getPaginatedNowWitnessList,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getPaginatedNowWitnessList?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues =>
      getPaginatedNowWitnessList?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getPaginatedNowWitnessList) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetPaginatedNowWitnessList;
  @override
  TronWitnessList onServiceResponse(List<int> bytes) {
    return TronWitnessList.deserialize(bytes);
  }

  @override
  TronWitnessList onServiceResponseJson(Map<String, dynamic> json) {
    return TronWitnessList.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetDelegatedResource extends TronProtoMessage
    with ITronProtoServiceMessage<TronDelegatedResourceList> {
  final TronProtoJsonConfig jsonConfig;

  final TronDelegatedResourceMessage? getDelegatedResource;

  const TronWalletGetDelegatedResource({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getDelegatedResource,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getDelegatedResource?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getDelegatedResource?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getDelegatedResource) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetDelegatedResource;
  @override
  TronDelegatedResourceList onServiceResponse(List<int> bytes) {
    return TronDelegatedResourceList.deserialize(bytes);
  }

  @override
  TronDelegatedResourceList onServiceResponseJson(Map<String, dynamic> json) {
    return TronDelegatedResourceList.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetDelegatedResourceV2 extends TronProtoMessage
    with ITronProtoServiceMessage<TronDelegatedResourceList> {
  final TronProtoJsonConfig jsonConfig;

  final TronDelegatedResourceMessage? getDelegatedResourceV2;

  const TronWalletGetDelegatedResourceV2({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getDelegatedResourceV2,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getDelegatedResourceV2?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getDelegatedResourceV2?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getDelegatedResourceV2) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetDelegatedResourceV2;
  @override
  TronDelegatedResourceList onServiceResponse(List<int> bytes) {
    return TronDelegatedResourceList.deserialize(bytes);
  }

  @override
  TronDelegatedResourceList onServiceResponseJson(Map<String, dynamic> json) {
    return TronDelegatedResourceList.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetDelegatedResourceAccountIndex extends TronProtoMessage
    with
        ITronProtoServiceMessage<
          protocol_tron.TronDelegatedResourceAccountIndex
        > {
  final TronProtoJsonConfig jsonConfig;

  final TronBytesMessage? getDelegatedResourceAccountIndex;

  const TronWalletGetDelegatedResourceAccountIndex({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getDelegatedResourceAccountIndex,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getDelegatedResourceAccountIndex?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues =>
      getDelegatedResourceAccountIndex?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getDelegatedResourceAccountIndex) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetDelegatedResourceAccountIndex;
  @override
  protocol_tron.TronDelegatedResourceAccountIndex onServiceResponse(
    List<int> bytes,
  ) {
    return protocol_tron.TronDelegatedResourceAccountIndex.deserialize(bytes);
  }

  @override
  protocol_tron.TronDelegatedResourceAccountIndex onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_tron.TronDelegatedResourceAccountIndex.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletGetDelegatedResourceAccountIndexV2 extends TronProtoMessage
    with
        ITronProtoServiceMessage<
          protocol_tron.TronDelegatedResourceAccountIndex
        > {
  final TronProtoJsonConfig jsonConfig;

  final TronBytesMessage? getDelegatedResourceAccountIndexV2;

  const TronWalletGetDelegatedResourceAccountIndexV2({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getDelegatedResourceAccountIndexV2,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getDelegatedResourceAccountIndexV2?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues =>
      getDelegatedResourceAccountIndexV2?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getDelegatedResourceAccountIndexV2) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetDelegatedResourceAccountIndexV2;
  @override
  protocol_tron.TronDelegatedResourceAccountIndex onServiceResponse(
    List<int> bytes,
  ) {
    return protocol_tron.TronDelegatedResourceAccountIndex.deserialize(bytes);
  }

  @override
  protocol_tron.TronDelegatedResourceAccountIndex onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_tron.TronDelegatedResourceAccountIndex.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletGetCanDelegatedMaxSize extends TronProtoMessage
    with ITronProtoServiceMessage<TronCanDelegatedMaxSizeResponseMessage> {
  final TronProtoJsonConfig jsonConfig;

  final TronCanDelegatedMaxSizeRequestMessage? getCanDelegatedMaxSize;

  const TronWalletGetCanDelegatedMaxSize({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getCanDelegatedMaxSize,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getCanDelegatedMaxSize?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getCanDelegatedMaxSize?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getCanDelegatedMaxSize) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetCanDelegatedMaxSize;
  @override
  TronCanDelegatedMaxSizeResponseMessage onServiceResponse(List<int> bytes) {
    return TronCanDelegatedMaxSizeResponseMessage.deserialize(bytes);
  }

  @override
  TronCanDelegatedMaxSizeResponseMessage onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return TronCanDelegatedMaxSizeResponseMessage.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletGetAvailableUnfreezeCount extends TronProtoMessage
    with
        ITronProtoServiceMessage<TronGetAvailableUnfreezeCountResponseMessage> {
  final TronProtoJsonConfig jsonConfig;

  final TronGetAvailableUnfreezeCountRequestMessage? getAvailableUnfreezeCount;

  const TronWalletGetAvailableUnfreezeCount({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getAvailableUnfreezeCount,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getAvailableUnfreezeCount?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getAvailableUnfreezeCount?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getAvailableUnfreezeCount) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetAvailableUnfreezeCount;
  @override
  TronGetAvailableUnfreezeCountResponseMessage onServiceResponse(
    List<int> bytes,
  ) {
    return TronGetAvailableUnfreezeCountResponseMessage.deserialize(bytes);
  }

  @override
  TronGetAvailableUnfreezeCountResponseMessage onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return TronGetAvailableUnfreezeCountResponseMessage.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletGetCanWithdrawUnfreezeAmount extends TronProtoMessage
    with
        ITronProtoServiceMessage<TronCanWithdrawUnfreezeAmountResponseMessage> {
  final TronProtoJsonConfig jsonConfig;

  final TronCanWithdrawUnfreezeAmountRequestMessage?
  getCanWithdrawUnfreezeAmount;

  const TronWalletGetCanWithdrawUnfreezeAmount({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getCanWithdrawUnfreezeAmount,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getCanWithdrawUnfreezeAmount?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues =>
      getCanWithdrawUnfreezeAmount?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getCanWithdrawUnfreezeAmount) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetCanWithdrawUnfreezeAmount;
  @override
  TronCanWithdrawUnfreezeAmountResponseMessage onServiceResponse(
    List<int> bytes,
  ) {
    return TronCanWithdrawUnfreezeAmountResponseMessage.deserialize(bytes);
  }

  @override
  TronCanWithdrawUnfreezeAmountResponseMessage onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return TronCanWithdrawUnfreezeAmountResponseMessage.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletListProposals extends TronProtoMessage
    with ITronProtoServiceMessage<TronProposalList> {
  final TronProtoJsonConfig jsonConfig;

  final TronEmptyMessage? listProposals;

  const TronWalletListProposals({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.listProposals,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      listProposals?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => listProposals?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(listProposals) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletListProposals;
  @override
  TronProposalList onServiceResponse(List<int> bytes) {
    return TronProposalList.deserialize(bytes);
  }

  @override
  TronProposalList onServiceResponseJson(Map<String, dynamic> json) {
    return TronProposalList.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetPaginatedProposalList extends TronProtoMessage
    with ITronProtoServiceMessage<TronProposalList> {
  final TronProtoJsonConfig jsonConfig;

  final TronPaginatedMessage? getPaginatedProposalList;

  const TronWalletGetPaginatedProposalList({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getPaginatedProposalList,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getPaginatedProposalList?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getPaginatedProposalList?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getPaginatedProposalList) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetPaginatedProposalList;
  @override
  TronProposalList onServiceResponse(List<int> bytes) {
    return TronProposalList.deserialize(bytes);
  }

  @override
  TronProposalList onServiceResponseJson(Map<String, dynamic> json) {
    return TronProposalList.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetProposalById extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_tron.TronProposal> {
  final TronProtoJsonConfig jsonConfig;

  final TronBytesMessage? getProposalById;

  const TronWalletGetProposalById({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getProposalById,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getProposalById?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getProposalById?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getProposalById) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetProposalById;
  @override
  protocol_tron.TronProposal onServiceResponse(List<int> bytes) {
    return protocol_tron.TronProposal.deserialize(bytes);
  }

  @override
  protocol_tron.TronProposal onServiceResponseJson(Map<String, dynamic> json) {
    return protocol_tron.TronProposal.fromJson(json, config: jsonConfig);
  }
}

class TronWalletListExchanges extends TronProtoMessage
    with ITronProtoServiceMessage<TronExchangeList> {
  final TronProtoJsonConfig jsonConfig;

  final TronEmptyMessage? listExchanges;

  const TronWalletListExchanges({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.listExchanges,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      listExchanges?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => listExchanges?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(listExchanges) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletListExchanges;
  @override
  TronExchangeList onServiceResponse(List<int> bytes) {
    return TronExchangeList.deserialize(bytes);
  }

  @override
  TronExchangeList onServiceResponseJson(Map<String, dynamic> json) {
    return TronExchangeList.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetPaginatedExchangeList extends TronProtoMessage
    with ITronProtoServiceMessage<TronExchangeList> {
  final TronProtoJsonConfig jsonConfig;

  final TronPaginatedMessage? getPaginatedExchangeList;

  const TronWalletGetPaginatedExchangeList({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getPaginatedExchangeList,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getPaginatedExchangeList?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getPaginatedExchangeList?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getPaginatedExchangeList) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetPaginatedExchangeList;
  @override
  TronExchangeList onServiceResponse(List<int> bytes) {
    return TronExchangeList.deserialize(bytes);
  }

  @override
  TronExchangeList onServiceResponseJson(Map<String, dynamic> json) {
    return TronExchangeList.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetExchangeById extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_tron.TronExchange> {
  final TronProtoJsonConfig jsonConfig;

  final TronBytesMessage? getExchangeById;

  const TronWalletGetExchangeById({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getExchangeById,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getExchangeById?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getExchangeById?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getExchangeById) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetExchangeById;
  @override
  protocol_tron.TronExchange onServiceResponse(List<int> bytes) {
    return protocol_tron.TronExchange.deserialize(bytes);
  }

  @override
  protocol_tron.TronExchange onServiceResponseJson(Map<String, dynamic> json) {
    return protocol_tron.TronExchange.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetChainParameters extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_tron.TronChainParameters> {
  final TronProtoJsonConfig jsonConfig;

  final TronEmptyMessage? getChainParameters;

  const TronWalletGetChainParameters({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getChainParameters,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getChainParameters?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getChainParameters?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getChainParameters) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetChainParameters;
  @override
  protocol_tron.TronChainParameters onServiceResponse(List<int> bytes) {
    return protocol_tron.TronChainParameters.deserialize(bytes);
  }

  @override
  protocol_tron.TronChainParameters onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_tron.TronChainParameters.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetAssetIssueList extends TronProtoMessage
    with ITronProtoServiceMessage<TronAssetIssueList> {
  final TronProtoJsonConfig jsonConfig;

  final TronEmptyMessage? getAssetIssueList;

  const TronWalletGetAssetIssueList({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getAssetIssueList,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getAssetIssueList?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getAssetIssueList?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getAssetIssueList) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetAssetIssueList;
  @override
  TronAssetIssueList onServiceResponse(List<int> bytes) {
    return TronAssetIssueList.deserialize(bytes);
  }

  @override
  TronAssetIssueList onServiceResponseJson(Map<String, dynamic> json) {
    return TronAssetIssueList.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetPaginatedAssetIssueList extends TronProtoMessage
    with ITronProtoServiceMessage<TronAssetIssueList> {
  final TronProtoJsonConfig jsonConfig;

  final TronPaginatedMessage? getPaginatedAssetIssueList;

  const TronWalletGetPaginatedAssetIssueList({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getPaginatedAssetIssueList,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getPaginatedAssetIssueList?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues =>
      getPaginatedAssetIssueList?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getPaginatedAssetIssueList) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetPaginatedAssetIssueList;
  @override
  TronAssetIssueList onServiceResponse(List<int> bytes) {
    return TronAssetIssueList.deserialize(bytes);
  }

  @override
  TronAssetIssueList onServiceResponseJson(Map<String, dynamic> json) {
    return TronAssetIssueList.fromJson(json, config: jsonConfig);
  }
}

class TronWalletTotalTransaction extends TronProtoMessage
    with ITronProtoServiceMessage<TronNumberMessage> {
  final TronProtoJsonConfig jsonConfig;

  final TronEmptyMessage? totalTransaction;

  const TronWalletTotalTransaction({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.totalTransaction,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      totalTransaction?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => totalTransaction?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(totalTransaction) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletTotalTransaction;
  @override
  TronNumberMessage onServiceResponse(List<int> bytes) {
    return TronNumberMessage.deserialize(bytes);
  }

  @override
  TronNumberMessage onServiceResponseJson(Map<String, dynamic> json) {
    return TronNumberMessage.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetNextMaintenanceTime extends TronProtoMessage
    with ITronProtoServiceMessage<TronNumberMessage> {
  final TronProtoJsonConfig jsonConfig;

  final TronEmptyMessage? getNextMaintenanceTime;

  const TronWalletGetNextMaintenanceTime({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getNextMaintenanceTime,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getNextMaintenanceTime?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getNextMaintenanceTime?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getNextMaintenanceTime) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetNextMaintenanceTime;
  @override
  TronNumberMessage onServiceResponse(List<int> bytes) {
    return TronNumberMessage.deserialize(bytes);
  }

  @override
  TronNumberMessage onServiceResponseJson(Map<String, dynamic> json) {
    return TronNumberMessage.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetTransactionInfoById extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_tron.TronTransactionInfo> {
  final TronProtoJsonConfig jsonConfig;

  final TronBytesMessage? getTransactionInfoById;

  const TronWalletGetTransactionInfoById({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getTransactionInfoById,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getTransactionInfoById?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getTransactionInfoById?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getTransactionInfoById) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetTransactionInfoById;
  @override
  protocol_tron.TronTransactionInfo onServiceResponse(List<int> bytes) {
    return protocol_tron.TronTransactionInfo.deserialize(bytes);
  }

  @override
  protocol_tron.TronTransactionInfo onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_tron.TronTransactionInfo.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetNodeInfo extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_tron.TronNodeInfo> {
  final TronProtoJsonConfig jsonConfig;

  final TronEmptyMessage? getNodeInfo;

  const TronWalletGetNodeInfo({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getNodeInfo,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getNodeInfo?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getNodeInfo?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getNodeInfo) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetNodeInfo;
  @override
  protocol_tron.TronNodeInfo onServiceResponse(List<int> bytes) {
    return protocol_tron.TronNodeInfo.deserialize(bytes);
  }

  @override
  protocol_tron.TronNodeInfo onServiceResponseJson(Map<String, dynamic> json) {
    return protocol_tron.TronNodeInfo.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetRewardInfo extends TronProtoMessage
    with ITronProtoServiceMessage<TronNumberMessage> {
  final TronProtoJsonConfig jsonConfig;

  final TronBytesMessage? getRewardInfo;

  const TronWalletGetRewardInfo({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getRewardInfo,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getRewardInfo?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getRewardInfo?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getRewardInfo) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetRewardInfo;
  @override
  TronNumberMessage onServiceResponse(List<int> bytes) {
    return TronNumberMessage.deserialize(bytes);
  }

  @override
  TronNumberMessage onServiceResponseJson(Map<String, dynamic> json) {
    return TronNumberMessage.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetBrokerageInfo extends TronProtoMessage
    with ITronProtoServiceMessage<TronNumberMessage> {
  final TronProtoJsonConfig jsonConfig;

  final TronBytesMessage? getBrokerageInfo;

  const TronWalletGetBrokerageInfo({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getBrokerageInfo,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getBrokerageInfo?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getBrokerageInfo?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getBrokerageInfo) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetBrokerageInfo;
  @override
  TronNumberMessage onServiceResponse(List<int> bytes) {
    return TronNumberMessage.deserialize(bytes);
  }

  @override
  TronNumberMessage onServiceResponseJson(Map<String, dynamic> json) {
    return TronNumberMessage.fromJson(json, config: jsonConfig);
  }
}

class TronWalletCreateShieldedTransaction extends TronProtoMessage
    with ITronProtoServiceMessage<TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  /// for shieldedTransaction
  final TronPrivateParameters? createShieldedTransaction;

  const TronWalletCreateShieldedTransaction({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.createShieldedTransaction,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      createShieldedTransaction?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => createShieldedTransaction?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(createShieldedTransaction) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletCreateShieldedTransaction;
  @override
  TronTransactionExtention onServiceResponse(List<int> bytes) {
    return TronTransactionExtention.deserialize(bytes);
  }

  @override
  TronTransactionExtention onServiceResponseJson(Map<String, dynamic> json) {
    return TronTransactionExtention.fromJson(json, config: jsonConfig);
  }
}

class TronWalletScanNoteByIvk extends TronProtoMessage
    with ITronProtoServiceMessage<TronDecryptNotes> {
  final TronProtoJsonConfig jsonConfig;

  final TronIvkDecryptParameters? scanNoteByIvk;

  const TronWalletScanNoteByIvk({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.scanNoteByIvk,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      scanNoteByIvk?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => scanNoteByIvk?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(scanNoteByIvk) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletScanNoteByIvk;
  @override
  TronDecryptNotes onServiceResponse(List<int> bytes) {
    return TronDecryptNotes.deserialize(bytes);
  }

  @override
  TronDecryptNotes onServiceResponseJson(Map<String, dynamic> json) {
    return TronDecryptNotes.fromJson(json, config: jsonConfig);
  }
}

class TronWalletScanAndMarkNoteByIvk extends TronProtoMessage
    with ITronProtoServiceMessage<TronDecryptNotesMarked> {
  final TronProtoJsonConfig jsonConfig;

  final TronIvkDecryptAndMarkParameters? scanAndMarkNoteByIvk;

  const TronWalletScanAndMarkNoteByIvk({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.scanAndMarkNoteByIvk,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      scanAndMarkNoteByIvk?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => scanAndMarkNoteByIvk?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(scanAndMarkNoteByIvk) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletScanAndMarkNoteByIvk;
  @override
  TronDecryptNotesMarked onServiceResponse(List<int> bytes) {
    return TronDecryptNotesMarked.deserialize(bytes);
  }

  @override
  TronDecryptNotesMarked onServiceResponseJson(Map<String, dynamic> json) {
    return TronDecryptNotesMarked.fromJson(json, config: jsonConfig);
  }
}

class TronWalletScanNoteByOvk extends TronProtoMessage
    with ITronProtoServiceMessage<TronDecryptNotes> {
  final TronProtoJsonConfig jsonConfig;

  final TronOvkDecryptParameters? scanNoteByOvk;

  const TronWalletScanNoteByOvk({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.scanNoteByOvk,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      scanNoteByOvk?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => scanNoteByOvk?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(scanNoteByOvk) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletScanNoteByOvk;
  @override
  TronDecryptNotes onServiceResponse(List<int> bytes) {
    return TronDecryptNotes.deserialize(bytes);
  }

  @override
  TronDecryptNotes onServiceResponseJson(Map<String, dynamic> json) {
    return TronDecryptNotes.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetSpendingKey extends TronProtoMessage
    with ITronProtoServiceMessage<TronBytesMessage> {
  final TronProtoJsonConfig jsonConfig;

  final TronEmptyMessage? getSpendingKey;

  const TronWalletGetSpendingKey({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getSpendingKey,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getSpendingKey?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getSpendingKey?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getSpendingKey) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetSpendingKey;
  @override
  TronBytesMessage onServiceResponse(List<int> bytes) {
    return TronBytesMessage.deserialize(bytes);
  }

  @override
  TronBytesMessage onServiceResponseJson(Map<String, dynamic> json) {
    return TronBytesMessage.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetExpandedSpendingKey extends TronProtoMessage
    with ITronProtoServiceMessage<TronExpandedSpendingKeyMessage> {
  final TronProtoJsonConfig jsonConfig;

  final TronBytesMessage? getExpandedSpendingKey;

  const TronWalletGetExpandedSpendingKey({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getExpandedSpendingKey,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getExpandedSpendingKey?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getExpandedSpendingKey?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getExpandedSpendingKey) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetExpandedSpendingKey;
  @override
  TronExpandedSpendingKeyMessage onServiceResponse(List<int> bytes) {
    return TronExpandedSpendingKeyMessage.deserialize(bytes);
  }

  @override
  TronExpandedSpendingKeyMessage onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return TronExpandedSpendingKeyMessage.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetAkFromAsk extends TronProtoMessage
    with ITronProtoServiceMessage<TronBytesMessage> {
  final TronProtoJsonConfig jsonConfig;

  final TronBytesMessage? getAkFromAsk;

  const TronWalletGetAkFromAsk({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getAkFromAsk,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getAkFromAsk?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getAkFromAsk?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getAkFromAsk) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetAkFromAsk;
  @override
  TronBytesMessage onServiceResponse(List<int> bytes) {
    return TronBytesMessage.deserialize(bytes);
  }

  @override
  TronBytesMessage onServiceResponseJson(Map<String, dynamic> json) {
    return TronBytesMessage.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetNkFromNsk extends TronProtoMessage
    with ITronProtoServiceMessage<TronBytesMessage> {
  final TronProtoJsonConfig jsonConfig;

  final TronBytesMessage? getNkFromNsk;

  const TronWalletGetNkFromNsk({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getNkFromNsk,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getNkFromNsk?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getNkFromNsk?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getNkFromNsk) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetNkFromNsk;
  @override
  TronBytesMessage onServiceResponse(List<int> bytes) {
    return TronBytesMessage.deserialize(bytes);
  }

  @override
  TronBytesMessage onServiceResponseJson(Map<String, dynamic> json) {
    return TronBytesMessage.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetIncomingViewingKey extends TronProtoMessage
    with ITronProtoServiceMessage<TronIncomingViewingKeyMessage> {
  final TronProtoJsonConfig jsonConfig;

  final TronViewingKeyMessage? getIncomingViewingKey;

  const TronWalletGetIncomingViewingKey({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getIncomingViewingKey,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getIncomingViewingKey?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getIncomingViewingKey?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getIncomingViewingKey) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetIncomingViewingKey;
  @override
  TronIncomingViewingKeyMessage onServiceResponse(List<int> bytes) {
    return TronIncomingViewingKeyMessage.deserialize(bytes);
  }

  @override
  TronIncomingViewingKeyMessage onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return TronIncomingViewingKeyMessage.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetDiversifier extends TronProtoMessage
    with ITronProtoServiceMessage<TronDiversifierMessage> {
  final TronProtoJsonConfig jsonConfig;

  final TronEmptyMessage? getDiversifier;

  const TronWalletGetDiversifier({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getDiversifier,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getDiversifier?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getDiversifier?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getDiversifier) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetDiversifier;
  @override
  TronDiversifierMessage onServiceResponse(List<int> bytes) {
    return TronDiversifierMessage.deserialize(bytes);
  }

  @override
  TronDiversifierMessage onServiceResponseJson(Map<String, dynamic> json) {
    return TronDiversifierMessage.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetNewShieldedAddress extends TronProtoMessage
    with ITronProtoServiceMessage<TronShieldedAddressInfo> {
  final TronProtoJsonConfig jsonConfig;

  final TronEmptyMessage? getNewShieldedAddress;

  const TronWalletGetNewShieldedAddress({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getNewShieldedAddress,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getNewShieldedAddress?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getNewShieldedAddress?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getNewShieldedAddress) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetNewShieldedAddress;
  @override
  TronShieldedAddressInfo onServiceResponse(List<int> bytes) {
    return TronShieldedAddressInfo.deserialize(bytes);
  }

  @override
  TronShieldedAddressInfo onServiceResponseJson(Map<String, dynamic> json) {
    return TronShieldedAddressInfo.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetZenPaymentAddress extends TronProtoMessage
    with ITronProtoServiceMessage<TronPaymentAddressMessage> {
  final TronProtoJsonConfig jsonConfig;

  final TronIncomingViewingKeyDiversifierMessage? getZenPaymentAddress;

  const TronWalletGetZenPaymentAddress({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getZenPaymentAddress,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getZenPaymentAddress?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getZenPaymentAddress?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getZenPaymentAddress) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetZenPaymentAddress;
  @override
  TronPaymentAddressMessage onServiceResponse(List<int> bytes) {
    return TronPaymentAddressMessage.deserialize(bytes);
  }

  @override
  TronPaymentAddressMessage onServiceResponseJson(Map<String, dynamic> json) {
    return TronPaymentAddressMessage.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetRcm extends TronProtoMessage
    with ITronProtoServiceMessage<TronBytesMessage> {
  final TronProtoJsonConfig jsonConfig;

  final TronEmptyMessage? getRcm;

  const TronWalletGetRcm({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getRcm,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getRcm?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getRcm?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getRcm) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetRcm;
  @override
  TronBytesMessage onServiceResponse(List<int> bytes) {
    return TronBytesMessage.deserialize(bytes);
  }

  @override
  TronBytesMessage onServiceResponseJson(Map<String, dynamic> json) {
    return TronBytesMessage.fromJson(json, config: jsonConfig);
  }
}

class TronWalletIsSpend extends TronProtoMessage
    with ITronProtoServiceMessage<TronSpendResult> {
  final TronProtoJsonConfig jsonConfig;

  final TronNoteParameters? isSpend;

  const TronWalletIsSpend({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.isSpend,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      isSpend?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => isSpend?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(isSpend) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletIsSpend;
  @override
  TronSpendResult onServiceResponse(List<int> bytes) {
    return TronSpendResult.deserialize(bytes);
  }

  @override
  TronSpendResult onServiceResponseJson(Map<String, dynamic> json) {
    return TronSpendResult.fromJson(json, config: jsonConfig);
  }
}

class TronWalletCreateShieldedTransactionWithoutSpendAuthSig
    extends TronProtoMessage
    with ITronProtoServiceMessage<TronTransactionExtention> {
  final TronProtoJsonConfig jsonConfig;

  final TronPrivateParametersWithoutAsk?
  createShieldedTransactionWithoutSpendAuthSig;

  const TronWalletCreateShieldedTransactionWithoutSpendAuthSig({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.createShieldedTransactionWithoutSpendAuthSig,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      createShieldedTransactionWithoutSpendAuthSig?.protoConfig() ??
      ProtoMessageConfig();

  @override
  List<Object?> get protoValues =>
      createShieldedTransactionWithoutSpendAuthSig?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(createShieldedTransactionWithoutSpendAuthSig) ??
        {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl
          .protocolWalletCreateShieldedTransactionWithoutSpendAuthSig;
  @override
  TronTransactionExtention onServiceResponse(List<int> bytes) {
    return TronTransactionExtention.deserialize(bytes);
  }

  @override
  TronTransactionExtention onServiceResponseJson(Map<String, dynamic> json) {
    return TronTransactionExtention.fromJson(json, config: jsonConfig);
  }
}

class TronWalletCreateSpendAuthSig extends TronProtoMessage
    with ITronProtoServiceMessage<TronBytesMessage> {
  final TronProtoJsonConfig jsonConfig;

  final TronSpendAuthSigParameters? createSpendAuthSig;

  const TronWalletCreateSpendAuthSig({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.createSpendAuthSig,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      createSpendAuthSig?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => createSpendAuthSig?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(createSpendAuthSig) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletCreateSpendAuthSig;
  @override
  TronBytesMessage onServiceResponse(List<int> bytes) {
    return TronBytesMessage.deserialize(bytes);
  }

  @override
  TronBytesMessage onServiceResponseJson(Map<String, dynamic> json) {
    return TronBytesMessage.fromJson(json, config: jsonConfig);
  }
}

class TronWalletCreateShieldNullifier extends TronProtoMessage
    with ITronProtoServiceMessage<TronBytesMessage> {
  final TronProtoJsonConfig jsonConfig;

  final TronNfParameters? createShieldNullifier;

  const TronWalletCreateShieldNullifier({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.createShieldNullifier,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      createShieldNullifier?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => createShieldNullifier?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(createShieldNullifier) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletCreateShieldNullifier;
  @override
  TronBytesMessage onServiceResponse(List<int> bytes) {
    return TronBytesMessage.deserialize(bytes);
  }

  @override
  TronBytesMessage onServiceResponseJson(Map<String, dynamic> json) {
    return TronBytesMessage.fromJson(json, config: jsonConfig);
  }
}

class TronWalletCreateShieldedContractParameters extends TronProtoMessage
    with ITronProtoServiceMessage<TronShieldedTRC20Parameters> {
  final TronProtoJsonConfig jsonConfig;

  /// for shielded contract
  final TronPrivateShieldedTRC20Parameters? createShieldedContractParameters;

  const TronWalletCreateShieldedContractParameters({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.createShieldedContractParameters,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      createShieldedContractParameters?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues =>
      createShieldedContractParameters?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(createShieldedContractParameters) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletCreateShieldedContractParameters;
  @override
  TronShieldedTRC20Parameters onServiceResponse(List<int> bytes) {
    return TronShieldedTRC20Parameters.deserialize(bytes);
  }

  @override
  TronShieldedTRC20Parameters onServiceResponseJson(Map<String, dynamic> json) {
    return TronShieldedTRC20Parameters.fromJson(json, config: jsonConfig);
  }
}

class TronWalletCreateShieldedContractParametersWithoutAsk
    extends TronProtoMessage
    with ITronProtoServiceMessage<TronShieldedTRC20Parameters> {
  final TronProtoJsonConfig jsonConfig;

  final TronPrivateShieldedTRC20ParametersWithoutAsk?
  createShieldedContractParametersWithoutAsk;

  const TronWalletCreateShieldedContractParametersWithoutAsk({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.createShieldedContractParametersWithoutAsk,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      createShieldedContractParametersWithoutAsk?.protoConfig() ??
      ProtoMessageConfig();

  @override
  List<Object?> get protoValues =>
      createShieldedContractParametersWithoutAsk?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(createShieldedContractParametersWithoutAsk) ??
        {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl
          .protocolWalletCreateShieldedContractParametersWithoutAsk;
  @override
  TronShieldedTRC20Parameters onServiceResponse(List<int> bytes) {
    return TronShieldedTRC20Parameters.deserialize(bytes);
  }

  @override
  TronShieldedTRC20Parameters onServiceResponseJson(Map<String, dynamic> json) {
    return TronShieldedTRC20Parameters.fromJson(json, config: jsonConfig);
  }
}

class TronWalletScanShieldedTRC20NotesByIvk extends TronProtoMessage
    with ITronProtoServiceMessage<TronDecryptNotesTRC20> {
  final TronProtoJsonConfig jsonConfig;

  final TronIvkDecryptTRC20Parameters? scanShieldedTRC20NotesByIvk;

  const TronWalletScanShieldedTRC20NotesByIvk({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.scanShieldedTRC20NotesByIvk,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      scanShieldedTRC20NotesByIvk?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues =>
      scanShieldedTRC20NotesByIvk?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(scanShieldedTRC20NotesByIvk) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletScanShieldedTRC20NotesByIvk;
  @override
  TronDecryptNotesTRC20 onServiceResponse(List<int> bytes) {
    return TronDecryptNotesTRC20.deserialize(bytes);
  }

  @override
  TronDecryptNotesTRC20 onServiceResponseJson(Map<String, dynamic> json) {
    return TronDecryptNotesTRC20.fromJson(json, config: jsonConfig);
  }
}

class TronWalletScanShieldedTRC20NotesByOvk extends TronProtoMessage
    with ITronProtoServiceMessage<TronDecryptNotesTRC20> {
  final TronProtoJsonConfig jsonConfig;

  final TronOvkDecryptTRC20Parameters? scanShieldedTRC20NotesByOvk;

  const TronWalletScanShieldedTRC20NotesByOvk({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.scanShieldedTRC20NotesByOvk,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      scanShieldedTRC20NotesByOvk?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues =>
      scanShieldedTRC20NotesByOvk?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(scanShieldedTRC20NotesByOvk) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletScanShieldedTRC20NotesByOvk;
  @override
  TronDecryptNotesTRC20 onServiceResponse(List<int> bytes) {
    return TronDecryptNotesTRC20.deserialize(bytes);
  }

  @override
  TronDecryptNotesTRC20 onServiceResponseJson(Map<String, dynamic> json) {
    return TronDecryptNotesTRC20.fromJson(json, config: jsonConfig);
  }
}

class TronWalletIsShieldedTRC20ContractNoteSpent extends TronProtoMessage
    with ITronProtoServiceMessage<TronNullifierResult> {
  final TronProtoJsonConfig jsonConfig;

  final TronNfTRC20Parameters? isShieldedTRC20ContractNoteSpent;

  const TronWalletIsShieldedTRC20ContractNoteSpent({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.isShieldedTRC20ContractNoteSpent,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      isShieldedTRC20ContractNoteSpent?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues =>
      isShieldedTRC20ContractNoteSpent?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(isShieldedTRC20ContractNoteSpent) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletIsShieldedTRC20ContractNoteSpent;
  @override
  TronNullifierResult onServiceResponse(List<int> bytes) {
    return TronNullifierResult.deserialize(bytes);
  }

  @override
  TronNullifierResult onServiceResponseJson(Map<String, dynamic> json) {
    return TronNullifierResult.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetTriggerInputForShieldedTRC20Contract extends TronProtoMessage
    with ITronProtoServiceMessage<TronBytesMessage> {
  final TronProtoJsonConfig jsonConfig;

  final TronShieldedTRC20TriggerContractParameters?
  getTriggerInputForShieldedTRC20Contract;

  const TronWalletGetTriggerInputForShieldedTRC20Contract({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getTriggerInputForShieldedTRC20Contract,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getTriggerInputForShieldedTRC20Contract?.protoConfig() ??
      ProtoMessageConfig();

  @override
  List<Object?> get protoValues =>
      getTriggerInputForShieldedTRC20Contract?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getTriggerInputForShieldedTRC20Contract) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl
          .protocolWalletGetTriggerInputForShieldedTRC20Contract;
  @override
  TronBytesMessage onServiceResponse(List<int> bytes) {
    return TronBytesMessage.deserialize(bytes);
  }

  @override
  TronBytesMessage onServiceResponseJson(Map<String, dynamic> json) {
    return TronBytesMessage.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetTransactionInfoByBlockNum extends TronProtoMessage
    with ITronProtoServiceMessage<TronTransactionInfoList> {
  final TronProtoJsonConfig jsonConfig;

  final TronNumberMessage? getTransactionInfoByBlockNum;

  const TronWalletGetTransactionInfoByBlockNum({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getTransactionInfoByBlockNum,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getTransactionInfoByBlockNum?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues =>
      getTransactionInfoByBlockNum?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getTransactionInfoByBlockNum) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetTransactionInfoByBlockNum;
  @override
  TronTransactionInfoList onServiceResponse(List<int> bytes) {
    return TronTransactionInfoList.deserialize(bytes);
  }

  @override
  TronTransactionInfoList onServiceResponseJson(Map<String, dynamic> json) {
    return TronTransactionInfoList.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetBurnTrx extends TronProtoMessage
    with ITronProtoServiceMessage<TronNumberMessage> {
  final TronProtoJsonConfig jsonConfig;

  final TronEmptyMessage? getBurnTrx;

  const TronWalletGetBurnTrx({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getBurnTrx,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getBurnTrx?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getBurnTrx?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getBurnTrx) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetBurnTrx;
  @override
  TronNumberMessage onServiceResponse(List<int> bytes) {
    return TronNumberMessage.deserialize(bytes);
  }

  @override
  TronNumberMessage onServiceResponseJson(Map<String, dynamic> json) {
    return TronNumberMessage.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetTransactionFromPending extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_contracts.TronTransaction> {
  final TronProtoJsonConfig jsonConfig;

  final TronBytesMessage? getTransactionFromPending;

  const TronWalletGetTransactionFromPending({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getTransactionFromPending,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getTransactionFromPending?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getTransactionFromPending?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getTransactionFromPending) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetTransactionFromPending;
  @override
  protocol_contracts.TronTransaction onServiceResponse(List<int> bytes) {
    return protocol_contracts.TronTransaction.deserialize(bytes);
  }

  @override
  protocol_contracts.TronTransaction onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_contracts.TronTransaction.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletGetTransactionListFromPending extends TronProtoMessage
    with ITronProtoServiceMessage<TronTransactionIdList> {
  final TronProtoJsonConfig jsonConfig;

  final TronEmptyMessage? getTransactionListFromPending;

  const TronWalletGetTransactionListFromPending({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getTransactionListFromPending,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getTransactionListFromPending?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues =>
      getTransactionListFromPending?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getTransactionListFromPending) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetTransactionListFromPending;
  @override
  TronTransactionIdList onServiceResponse(List<int> bytes) {
    return TronTransactionIdList.deserialize(bytes);
  }

  @override
  TronTransactionIdList onServiceResponseJson(Map<String, dynamic> json) {
    return TronTransactionIdList.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetPendingSize extends TronProtoMessage
    with ITronProtoServiceMessage<TronNumberMessage> {
  final TronProtoJsonConfig jsonConfig;

  final TronEmptyMessage? getPendingSize;

  const TronWalletGetPendingSize({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getPendingSize,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getPendingSize?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getPendingSize?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getPendingSize) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetPendingSize;
  @override
  TronNumberMessage onServiceResponse(List<int> bytes) {
    return TronNumberMessage.deserialize(bytes);
  }

  @override
  TronNumberMessage onServiceResponseJson(Map<String, dynamic> json) {
    return TronNumberMessage.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetBlock extends TronProtoMessage
    with ITronProtoServiceMessage<TronBlockExtention> {
  final TronProtoJsonConfig jsonConfig;

  final TronBlockReq? getBlock;

  const TronWalletGetBlock({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getBlock,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getBlock?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getBlock?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getBlock) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetBlock;
  @override
  TronBlockExtention onServiceResponse(List<int> bytes) {
    return TronBlockExtention.deserialize(bytes);
  }

  @override
  TronBlockExtention onServiceResponseJson(Map<String, dynamic> json) {
    return TronBlockExtention.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetBandwidthPrices extends TronProtoMessage
    with ITronProtoServiceMessage<TronPricesResponseMessage> {
  final TronProtoJsonConfig jsonConfig;

  final TronEmptyMessage? getBandwidthPrices;

  const TronWalletGetBandwidthPrices({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getBandwidthPrices,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getBandwidthPrices?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getBandwidthPrices?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getBandwidthPrices) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetBandwidthPrices;
  @override
  TronPricesResponseMessage onServiceResponse(List<int> bytes) {
    return TronPricesResponseMessage.deserialize(bytes);
  }

  @override
  TronPricesResponseMessage onServiceResponseJson(Map<String, dynamic> json) {
    return TronPricesResponseMessage.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetEnergyPrices extends TronProtoMessage
    with ITronProtoServiceMessage<TronPricesResponseMessage> {
  final TronProtoJsonConfig jsonConfig;

  final TronEmptyMessage? getEnergyPrices;

  const TronWalletGetEnergyPrices({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getEnergyPrices,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getEnergyPrices?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getEnergyPrices?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getEnergyPrices) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetEnergyPrices;
  @override
  TronPricesResponseMessage onServiceResponse(List<int> bytes) {
    return TronPricesResponseMessage.deserialize(bytes);
  }

  @override
  TronPricesResponseMessage onServiceResponseJson(Map<String, dynamic> json) {
    return TronPricesResponseMessage.fromJson(json, config: jsonConfig);
  }
}

class TronWalletGetMemoFee extends TronProtoMessage
    with ITronProtoServiceMessage<TronPricesResponseMessage> {
  final TronProtoJsonConfig jsonConfig;

  final TronEmptyMessage? getMemoFee;

  const TronWalletGetMemoFee({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getMemoFee,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getMemoFee?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getMemoFee?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getMemoFee) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletGetMemoFee;
  @override
  TronPricesResponseMessage onServiceResponse(List<int> bytes) {
    return TronPricesResponseMessage.deserialize(bytes);
  }

  @override
  TronPricesResponseMessage onServiceResponseJson(Map<String, dynamic> json) {
    return TronPricesResponseMessage.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityListWitnesses extends TronProtoMessage
    with ITronProtoServiceMessage<TronWitnessList> {
  final TronProtoJsonConfig jsonConfig;

  final TronEmptyMessage? listWitnesses;

  const TronWalletSolidityListWitnesses({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.listWitnesses,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      listWitnesses?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => listWitnesses?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(listWitnesses) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityListWitnesses;
  @override
  TronWitnessList onServiceResponse(List<int> bytes) {
    return TronWitnessList.deserialize(bytes);
  }

  @override
  TronWitnessList onServiceResponseJson(Map<String, dynamic> json) {
    return TronWitnessList.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityGetPaginatedNowWitnessList extends TronProtoMessage
    with ITronProtoServiceMessage<TronWitnessList> {
  final TronProtoJsonConfig jsonConfig;

  final TronPaginatedMessage? getPaginatedNowWitnessList;

  const TronWalletSolidityGetPaginatedNowWitnessList({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getPaginatedNowWitnessList,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getPaginatedNowWitnessList?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues =>
      getPaginatedNowWitnessList?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getPaginatedNowWitnessList) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityGetPaginatedNowWitnessList;
  @override
  TronWitnessList onServiceResponse(List<int> bytes) {
    return TronWitnessList.deserialize(bytes);
  }

  @override
  TronWitnessList onServiceResponseJson(Map<String, dynamic> json) {
    return TronWitnessList.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityGetAssetIssueList extends TronProtoMessage
    with ITronProtoServiceMessage<TronAssetIssueList> {
  final TronProtoJsonConfig jsonConfig;

  final TronEmptyMessage? getAssetIssueList;

  const TronWalletSolidityGetAssetIssueList({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getAssetIssueList,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getAssetIssueList?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getAssetIssueList?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getAssetIssueList) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityGetAssetIssueList;
  @override
  TronAssetIssueList onServiceResponse(List<int> bytes) {
    return TronAssetIssueList.deserialize(bytes);
  }

  @override
  TronAssetIssueList onServiceResponseJson(Map<String, dynamic> json) {
    return TronAssetIssueList.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityGetPaginatedAssetIssueList extends TronProtoMessage
    with ITronProtoServiceMessage<TronAssetIssueList> {
  final TronProtoJsonConfig jsonConfig;

  final TronPaginatedMessage? getPaginatedAssetIssueList;

  const TronWalletSolidityGetPaginatedAssetIssueList({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getPaginatedAssetIssueList,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getPaginatedAssetIssueList?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues =>
      getPaginatedAssetIssueList?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getPaginatedAssetIssueList) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityGetPaginatedAssetIssueList;
  @override
  TronAssetIssueList onServiceResponse(List<int> bytes) {
    return TronAssetIssueList.deserialize(bytes);
  }

  @override
  TronAssetIssueList onServiceResponseJson(Map<String, dynamic> json) {
    return TronAssetIssueList.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityGetAssetIssueByName extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_contracts.TronAssetIssueContract> {
  final TronProtoJsonConfig jsonConfig;

  final TronBytesMessage? getAssetIssueByName;

  const TronWalletSolidityGetAssetIssueByName({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getAssetIssueByName,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getAssetIssueByName?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getAssetIssueByName?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getAssetIssueByName) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityGetAssetIssueByName;
  @override
  protocol_contracts.TronAssetIssueContract onServiceResponse(List<int> bytes) {
    return protocol_contracts.TronAssetIssueContract.deserialize(bytes);
  }

  @override
  protocol_contracts.TronAssetIssueContract onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_contracts.TronAssetIssueContract.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletSolidityGetAssetIssueListByName extends TronProtoMessage
    with ITronProtoServiceMessage<TronAssetIssueList> {
  final TronProtoJsonConfig jsonConfig;

  final TronBytesMessage? getAssetIssueListByName;

  const TronWalletSolidityGetAssetIssueListByName({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getAssetIssueListByName,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getAssetIssueListByName?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getAssetIssueListByName?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getAssetIssueListByName) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityGetAssetIssueListByName;
  @override
  TronAssetIssueList onServiceResponse(List<int> bytes) {
    return TronAssetIssueList.deserialize(bytes);
  }

  @override
  TronAssetIssueList onServiceResponseJson(Map<String, dynamic> json) {
    return TronAssetIssueList.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityGetAssetIssueById extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_contracts.TronAssetIssueContract> {
  final TronProtoJsonConfig jsonConfig;

  final TronBytesMessage? getAssetIssueById;

  const TronWalletSolidityGetAssetIssueById({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getAssetIssueById,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getAssetIssueById?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getAssetIssueById?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getAssetIssueById) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityGetAssetIssueById;
  @override
  protocol_contracts.TronAssetIssueContract onServiceResponse(List<int> bytes) {
    return protocol_contracts.TronAssetIssueContract.deserialize(bytes);
  }

  @override
  protocol_contracts.TronAssetIssueContract onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_contracts.TronAssetIssueContract.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletSolidityGetNowBlock extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_tron.TronBlock> {
  final TronProtoJsonConfig jsonConfig;

  /// Please use GetNowBlock2 instead of this function.
  final TronEmptyMessage? getNowBlock;

  const TronWalletSolidityGetNowBlock({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getNowBlock,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getNowBlock?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getNowBlock?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getNowBlock) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityGetNowBlock;
  @override
  protocol_tron.TronBlock onServiceResponse(List<int> bytes) {
    return protocol_tron.TronBlock.deserialize(bytes);
  }

  @override
  protocol_tron.TronBlock onServiceResponseJson(Map<String, dynamic> json) {
    return protocol_tron.TronBlock.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityGetNowBlock2 extends TronProtoMessage
    with ITronProtoServiceMessage<TronBlockExtention> {
  final TronProtoJsonConfig jsonConfig;

  /// Use this function instead of GetNowBlock.
  final TronEmptyMessage? getNowBlock2;

  const TronWalletSolidityGetNowBlock2({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getNowBlock2,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getNowBlock2?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getNowBlock2?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getNowBlock2) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityGetNowBlock2;
  @override
  TronBlockExtention onServiceResponse(List<int> bytes) {
    return TronBlockExtention.deserialize(bytes);
  }

  @override
  TronBlockExtention onServiceResponseJson(Map<String, dynamic> json) {
    return TronBlockExtention.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityGetBlockByNum extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_tron.TronBlock> {
  final TronProtoJsonConfig jsonConfig;

  /// Please use GetBlockByNum2 instead of this function.
  final TronNumberMessage? getBlockByNum;

  const TronWalletSolidityGetBlockByNum({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getBlockByNum,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getBlockByNum?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getBlockByNum?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getBlockByNum) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityGetBlockByNum;
  @override
  protocol_tron.TronBlock onServiceResponse(List<int> bytes) {
    return protocol_tron.TronBlock.deserialize(bytes);
  }

  @override
  protocol_tron.TronBlock onServiceResponseJson(Map<String, dynamic> json) {
    return protocol_tron.TronBlock.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityGetBlockByNum2 extends TronProtoMessage
    with ITronProtoServiceMessage<TronBlockExtention> {
  final TronProtoJsonConfig jsonConfig;

  /// Use this function instead of GetBlockByNum.
  final TronNumberMessage? getBlockByNum2;

  const TronWalletSolidityGetBlockByNum2({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getBlockByNum2,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getBlockByNum2?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getBlockByNum2?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getBlockByNum2) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityGetBlockByNum2;
  @override
  TronBlockExtention onServiceResponse(List<int> bytes) {
    return TronBlockExtention.deserialize(bytes);
  }

  @override
  TronBlockExtention onServiceResponseJson(Map<String, dynamic> json) {
    return TronBlockExtention.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityGetTransactionCountByBlockNum extends TronProtoMessage
    with ITronProtoServiceMessage<TronNumberMessage> {
  final TronProtoJsonConfig jsonConfig;

  final TronNumberMessage? getTransactionCountByBlockNum;

  const TronWalletSolidityGetTransactionCountByBlockNum({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getTransactionCountByBlockNum,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getTransactionCountByBlockNum?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues =>
      getTransactionCountByBlockNum?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getTransactionCountByBlockNum) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl
          .protocolWalletSolidityGetTransactionCountByBlockNum;
  @override
  TronNumberMessage onServiceResponse(List<int> bytes) {
    return TronNumberMessage.deserialize(bytes);
  }

  @override
  TronNumberMessage onServiceResponseJson(Map<String, dynamic> json) {
    return TronNumberMessage.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityGetDelegatedResource extends TronProtoMessage
    with ITronProtoServiceMessage<TronDelegatedResourceList> {
  final TronProtoJsonConfig jsonConfig;

  final TronDelegatedResourceMessage? getDelegatedResource;

  const TronWalletSolidityGetDelegatedResource({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getDelegatedResource,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getDelegatedResource?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getDelegatedResource?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getDelegatedResource) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityGetDelegatedResource;
  @override
  TronDelegatedResourceList onServiceResponse(List<int> bytes) {
    return TronDelegatedResourceList.deserialize(bytes);
  }

  @override
  TronDelegatedResourceList onServiceResponseJson(Map<String, dynamic> json) {
    return TronDelegatedResourceList.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityGetDelegatedResourceV2 extends TronProtoMessage
    with ITronProtoServiceMessage<TronDelegatedResourceList> {
  final TronProtoJsonConfig jsonConfig;

  final TronDelegatedResourceMessage? getDelegatedResourceV2;

  const TronWalletSolidityGetDelegatedResourceV2({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getDelegatedResourceV2,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getDelegatedResourceV2?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getDelegatedResourceV2?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getDelegatedResourceV2) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityGetDelegatedResourceV2;
  @override
  TronDelegatedResourceList onServiceResponse(List<int> bytes) {
    return TronDelegatedResourceList.deserialize(bytes);
  }

  @override
  TronDelegatedResourceList onServiceResponseJson(Map<String, dynamic> json) {
    return TronDelegatedResourceList.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityGetDelegatedResourceAccountIndex
    extends TronProtoMessage
    with
        ITronProtoServiceMessage<
          protocol_tron.TronDelegatedResourceAccountIndex
        > {
  final TronProtoJsonConfig jsonConfig;

  final TronBytesMessage? getDelegatedResourceAccountIndex;

  const TronWalletSolidityGetDelegatedResourceAccountIndex({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getDelegatedResourceAccountIndex,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getDelegatedResourceAccountIndex?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues =>
      getDelegatedResourceAccountIndex?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getDelegatedResourceAccountIndex) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl
          .protocolWalletSolidityGetDelegatedResourceAccountIndex;
  @override
  protocol_tron.TronDelegatedResourceAccountIndex onServiceResponse(
    List<int> bytes,
  ) {
    return protocol_tron.TronDelegatedResourceAccountIndex.deserialize(bytes);
  }

  @override
  protocol_tron.TronDelegatedResourceAccountIndex onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_tron.TronDelegatedResourceAccountIndex.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletSolidityGetDelegatedResourceAccountIndexV2
    extends TronProtoMessage
    with
        ITronProtoServiceMessage<
          protocol_tron.TronDelegatedResourceAccountIndex
        > {
  final TronProtoJsonConfig jsonConfig;

  final TronBytesMessage? getDelegatedResourceAccountIndexV2;

  const TronWalletSolidityGetDelegatedResourceAccountIndexV2({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getDelegatedResourceAccountIndexV2,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getDelegatedResourceAccountIndexV2?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues =>
      getDelegatedResourceAccountIndexV2?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getDelegatedResourceAccountIndexV2) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl
          .protocolWalletSolidityGetDelegatedResourceAccountIndexV2;
  @override
  protocol_tron.TronDelegatedResourceAccountIndex onServiceResponse(
    List<int> bytes,
  ) {
    return protocol_tron.TronDelegatedResourceAccountIndex.deserialize(bytes);
  }

  @override
  protocol_tron.TronDelegatedResourceAccountIndex onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_tron.TronDelegatedResourceAccountIndex.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletSolidityGetCanDelegatedMaxSize extends TronProtoMessage
    with ITronProtoServiceMessage<TronCanDelegatedMaxSizeResponseMessage> {
  final TronProtoJsonConfig jsonConfig;

  final TronCanDelegatedMaxSizeRequestMessage? getCanDelegatedMaxSize;

  const TronWalletSolidityGetCanDelegatedMaxSize({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getCanDelegatedMaxSize,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getCanDelegatedMaxSize?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getCanDelegatedMaxSize?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getCanDelegatedMaxSize) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityGetCanDelegatedMaxSize;
  @override
  TronCanDelegatedMaxSizeResponseMessage onServiceResponse(List<int> bytes) {
    return TronCanDelegatedMaxSizeResponseMessage.deserialize(bytes);
  }

  @override
  TronCanDelegatedMaxSizeResponseMessage onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return TronCanDelegatedMaxSizeResponseMessage.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletSolidityGetAvailableUnfreezeCount extends TronProtoMessage
    with
        ITronProtoServiceMessage<TronGetAvailableUnfreezeCountResponseMessage> {
  final TronProtoJsonConfig jsonConfig;

  final TronGetAvailableUnfreezeCountRequestMessage? getAvailableUnfreezeCount;

  const TronWalletSolidityGetAvailableUnfreezeCount({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getAvailableUnfreezeCount,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getAvailableUnfreezeCount?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getAvailableUnfreezeCount?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getAvailableUnfreezeCount) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityGetAvailableUnfreezeCount;
  @override
  TronGetAvailableUnfreezeCountResponseMessage onServiceResponse(
    List<int> bytes,
  ) {
    return TronGetAvailableUnfreezeCountResponseMessage.deserialize(bytes);
  }

  @override
  TronGetAvailableUnfreezeCountResponseMessage onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return TronGetAvailableUnfreezeCountResponseMessage.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletSolidityGetCanWithdrawUnfreezeAmount extends TronProtoMessage
    with
        ITronProtoServiceMessage<TronCanWithdrawUnfreezeAmountResponseMessage> {
  final TronProtoJsonConfig jsonConfig;

  final TronCanWithdrawUnfreezeAmountRequestMessage?
  getCanWithdrawUnfreezeAmount;

  const TronWalletSolidityGetCanWithdrawUnfreezeAmount({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getCanWithdrawUnfreezeAmount,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getCanWithdrawUnfreezeAmount?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues =>
      getCanWithdrawUnfreezeAmount?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getCanWithdrawUnfreezeAmount) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl
          .protocolWalletSolidityGetCanWithdrawUnfreezeAmount;
  @override
  TronCanWithdrawUnfreezeAmountResponseMessage onServiceResponse(
    List<int> bytes,
  ) {
    return TronCanWithdrawUnfreezeAmountResponseMessage.deserialize(bytes);
  }

  @override
  TronCanWithdrawUnfreezeAmountResponseMessage onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return TronCanWithdrawUnfreezeAmountResponseMessage.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletSolidityGetExchangeById extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_tron.TronExchange> {
  final TronProtoJsonConfig jsonConfig;

  final TronBytesMessage? getExchangeById;

  const TronWalletSolidityGetExchangeById({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getExchangeById,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getExchangeById?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getExchangeById?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getExchangeById) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityGetExchangeById;
  @override
  protocol_tron.TronExchange onServiceResponse(List<int> bytes) {
    return protocol_tron.TronExchange.deserialize(bytes);
  }

  @override
  protocol_tron.TronExchange onServiceResponseJson(Map<String, dynamic> json) {
    return protocol_tron.TronExchange.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityListExchanges extends TronProtoMessage
    with ITronProtoServiceMessage<TronExchangeList> {
  final TronProtoJsonConfig jsonConfig;

  final TronEmptyMessage? listExchanges;

  const TronWalletSolidityListExchanges({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.listExchanges,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      listExchanges?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => listExchanges?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(listExchanges) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityListExchanges;
  @override
  TronExchangeList onServiceResponse(List<int> bytes) {
    return TronExchangeList.deserialize(bytes);
  }

  @override
  TronExchangeList onServiceResponseJson(Map<String, dynamic> json) {
    return TronExchangeList.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityGetTransactionById extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_contracts.TronTransaction> {
  final TronProtoJsonConfig jsonConfig;

  final TronBytesMessage? getTransactionById;

  const TronWalletSolidityGetTransactionById({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getTransactionById,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getTransactionById?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getTransactionById?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getTransactionById) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityGetTransactionById;
  @override
  protocol_contracts.TronTransaction onServiceResponse(List<int> bytes) {
    return protocol_contracts.TronTransaction.deserialize(bytes);
  }

  @override
  protocol_contracts.TronTransaction onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_contracts.TronTransaction.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletSolidityGetTransactionInfoById extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_tron.TronTransactionInfo> {
  final TronProtoJsonConfig jsonConfig;

  final TronBytesMessage? getTransactionInfoById;

  const TronWalletSolidityGetTransactionInfoById({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getTransactionInfoById,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getTransactionInfoById?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getTransactionInfoById?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getTransactionInfoById) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityGetTransactionInfoById;
  @override
  protocol_tron.TronTransactionInfo onServiceResponse(List<int> bytes) {
    return protocol_tron.TronTransactionInfo.deserialize(bytes);
  }

  @override
  protocol_tron.TronTransactionInfo onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_tron.TronTransactionInfo.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityScanNoteByIvk extends TronProtoMessage
    with ITronProtoServiceMessage<TronDecryptNotes> {
  final TronProtoJsonConfig jsonConfig;

  final TronIvkDecryptParameters? scanNoteByIvk;

  const TronWalletSolidityScanNoteByIvk({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.scanNoteByIvk,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      scanNoteByIvk?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => scanNoteByIvk?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(scanNoteByIvk) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityScanNoteByIvk;
  @override
  TronDecryptNotes onServiceResponse(List<int> bytes) {
    return TronDecryptNotes.deserialize(bytes);
  }

  @override
  TronDecryptNotes onServiceResponseJson(Map<String, dynamic> json) {
    return TronDecryptNotes.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityScanAndMarkNoteByIvk extends TronProtoMessage
    with ITronProtoServiceMessage<TronDecryptNotesMarked> {
  final TronProtoJsonConfig jsonConfig;

  final TronIvkDecryptAndMarkParameters? scanAndMarkNoteByIvk;

  const TronWalletSolidityScanAndMarkNoteByIvk({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.scanAndMarkNoteByIvk,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      scanAndMarkNoteByIvk?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => scanAndMarkNoteByIvk?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(scanAndMarkNoteByIvk) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityScanAndMarkNoteByIvk;
  @override
  TronDecryptNotesMarked onServiceResponse(List<int> bytes) {
    return TronDecryptNotesMarked.deserialize(bytes);
  }

  @override
  TronDecryptNotesMarked onServiceResponseJson(Map<String, dynamic> json) {
    return TronDecryptNotesMarked.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityScanNoteByOvk extends TronProtoMessage
    with ITronProtoServiceMessage<TronDecryptNotes> {
  final TronProtoJsonConfig jsonConfig;

  final TronOvkDecryptParameters? scanNoteByOvk;

  const TronWalletSolidityScanNoteByOvk({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.scanNoteByOvk,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      scanNoteByOvk?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => scanNoteByOvk?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(scanNoteByOvk) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityScanNoteByOvk;
  @override
  TronDecryptNotes onServiceResponse(List<int> bytes) {
    return TronDecryptNotes.deserialize(bytes);
  }

  @override
  TronDecryptNotes onServiceResponseJson(Map<String, dynamic> json) {
    return TronDecryptNotes.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityIsSpend extends TronProtoMessage
    with ITronProtoServiceMessage<TronSpendResult> {
  final TronProtoJsonConfig jsonConfig;

  final TronNoteParameters? isSpend;

  const TronWalletSolidityIsSpend({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.isSpend,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      isSpend?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => isSpend?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(isSpend) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityIsSpend;
  @override
  TronSpendResult onServiceResponse(List<int> bytes) {
    return TronSpendResult.deserialize(bytes);
  }

  @override
  TronSpendResult onServiceResponseJson(Map<String, dynamic> json) {
    return TronSpendResult.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityScanShieldedTRC20NotesByIvk extends TronProtoMessage
    with ITronProtoServiceMessage<TronDecryptNotesTRC20> {
  final TronProtoJsonConfig jsonConfig;

  final TronIvkDecryptTRC20Parameters? scanShieldedTRC20NotesByIvk;

  const TronWalletSolidityScanShieldedTRC20NotesByIvk({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.scanShieldedTRC20NotesByIvk,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      scanShieldedTRC20NotesByIvk?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues =>
      scanShieldedTRC20NotesByIvk?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(scanShieldedTRC20NotesByIvk) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityScanShieldedTRC20NotesByIvk;
  @override
  TronDecryptNotesTRC20 onServiceResponse(List<int> bytes) {
    return TronDecryptNotesTRC20.deserialize(bytes);
  }

  @override
  TronDecryptNotesTRC20 onServiceResponseJson(Map<String, dynamic> json) {
    return TronDecryptNotesTRC20.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityScanShieldedTRC20NotesByOvk extends TronProtoMessage
    with ITronProtoServiceMessage<TronDecryptNotesTRC20> {
  final TronProtoJsonConfig jsonConfig;

  final TronOvkDecryptTRC20Parameters? scanShieldedTRC20NotesByOvk;

  const TronWalletSolidityScanShieldedTRC20NotesByOvk({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.scanShieldedTRC20NotesByOvk,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      scanShieldedTRC20NotesByOvk?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues =>
      scanShieldedTRC20NotesByOvk?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(scanShieldedTRC20NotesByOvk) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityScanShieldedTRC20NotesByOvk;
  @override
  TronDecryptNotesTRC20 onServiceResponse(List<int> bytes) {
    return TronDecryptNotesTRC20.deserialize(bytes);
  }

  @override
  TronDecryptNotesTRC20 onServiceResponseJson(Map<String, dynamic> json) {
    return TronDecryptNotesTRC20.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityIsShieldedTRC20ContractNoteSpent
    extends TronProtoMessage
    with ITronProtoServiceMessage<TronNullifierResult> {
  final TronProtoJsonConfig jsonConfig;

  final TronNfTRC20Parameters? isShieldedTRC20ContractNoteSpent;

  const TronWalletSolidityIsShieldedTRC20ContractNoteSpent({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.isShieldedTRC20ContractNoteSpent,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      isShieldedTRC20ContractNoteSpent?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues =>
      isShieldedTRC20ContractNoteSpent?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(isShieldedTRC20ContractNoteSpent) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl
          .protocolWalletSolidityIsShieldedTRC20ContractNoteSpent;
  @override
  TronNullifierResult onServiceResponse(List<int> bytes) {
    return TronNullifierResult.deserialize(bytes);
  }

  @override
  TronNullifierResult onServiceResponseJson(Map<String, dynamic> json) {
    return TronNullifierResult.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityGetRewardInfo extends TronProtoMessage
    with ITronProtoServiceMessage<TronNumberMessage> {
  final TronProtoJsonConfig jsonConfig;

  final TronBytesMessage? getRewardInfo;

  const TronWalletSolidityGetRewardInfo({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getRewardInfo,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getRewardInfo?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getRewardInfo?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getRewardInfo) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityGetRewardInfo;
  @override
  TronNumberMessage onServiceResponse(List<int> bytes) {
    return TronNumberMessage.deserialize(bytes);
  }

  @override
  TronNumberMessage onServiceResponseJson(Map<String, dynamic> json) {
    return TronNumberMessage.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityGetBrokerageInfo extends TronProtoMessage
    with ITronProtoServiceMessage<TronNumberMessage> {
  final TronProtoJsonConfig jsonConfig;

  final TronBytesMessage? getBrokerageInfo;

  const TronWalletSolidityGetBrokerageInfo({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getBrokerageInfo,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getBrokerageInfo?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getBrokerageInfo?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getBrokerageInfo) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityGetBrokerageInfo;
  @override
  TronNumberMessage onServiceResponse(List<int> bytes) {
    return TronNumberMessage.deserialize(bytes);
  }

  @override
  TronNumberMessage onServiceResponseJson(Map<String, dynamic> json) {
    return TronNumberMessage.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityGetTransactionInfoByBlockNum extends TronProtoMessage
    with ITronProtoServiceMessage<TronTransactionInfoList> {
  final TronProtoJsonConfig jsonConfig;

  final TronNumberMessage? getTransactionInfoByBlockNum;

  const TronWalletSolidityGetTransactionInfoByBlockNum({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getTransactionInfoByBlockNum,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getTransactionInfoByBlockNum?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues =>
      getTransactionInfoByBlockNum?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getTransactionInfoByBlockNum) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl
          .protocolWalletSolidityGetTransactionInfoByBlockNum;
  @override
  TronTransactionInfoList onServiceResponse(List<int> bytes) {
    return TronTransactionInfoList.deserialize(bytes);
  }

  @override
  TronTransactionInfoList onServiceResponseJson(Map<String, dynamic> json) {
    return TronTransactionInfoList.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityGetMarketOrderById extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_tron.TronMarketOrder> {
  final TronProtoJsonConfig jsonConfig;

  final TronBytesMessage? getMarketOrderById;

  const TronWalletSolidityGetMarketOrderById({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getMarketOrderById,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getMarketOrderById?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getMarketOrderById?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getMarketOrderById) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityGetMarketOrderById;
  @override
  protocol_tron.TronMarketOrder onServiceResponse(List<int> bytes) {
    return protocol_tron.TronMarketOrder.deserialize(bytes);
  }

  @override
  protocol_tron.TronMarketOrder onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_tron.TronMarketOrder.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityGetMarketOrderByAccount extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_tron.TronMarketOrderList> {
  final TronProtoJsonConfig jsonConfig;

  final TronBytesMessage? getMarketOrderByAccount;

  const TronWalletSolidityGetMarketOrderByAccount({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getMarketOrderByAccount,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getMarketOrderByAccount?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getMarketOrderByAccount?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getMarketOrderByAccount) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityGetMarketOrderByAccount;
  @override
  protocol_tron.TronMarketOrderList onServiceResponse(List<int> bytes) {
    return protocol_tron.TronMarketOrderList.deserialize(bytes);
  }

  @override
  protocol_tron.TronMarketOrderList onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_tron.TronMarketOrderList.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityGetMarketPairList extends TronProtoMessage
    with ITronProtoServiceMessage<protocol_tron.TronMarketOrderPairList> {
  final TronProtoJsonConfig jsonConfig;

  final TronEmptyMessage? getMarketPairList;

  const TronWalletSolidityGetMarketPairList({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getMarketPairList,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getMarketPairList?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getMarketPairList?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getMarketPairList) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityGetMarketPairList;
  @override
  protocol_tron.TronMarketOrderPairList onServiceResponse(List<int> bytes) {
    return protocol_tron.TronMarketOrderPairList.deserialize(bytes);
  }

  @override
  protocol_tron.TronMarketOrderPairList onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return protocol_tron.TronMarketOrderPairList.fromJson(
      json,
      config: jsonConfig,
    );
  }
}

class TronWalletSolidityGetBurnTrx extends TronProtoMessage
    with ITronProtoServiceMessage<TronNumberMessage> {
  final TronProtoJsonConfig jsonConfig;

  final TronEmptyMessage? getBurnTrx;

  const TronWalletSolidityGetBurnTrx({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getBurnTrx,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getBurnTrx?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getBurnTrx?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getBurnTrx) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityGetBurnTrx;
  @override
  TronNumberMessage onServiceResponse(List<int> bytes) {
    return TronNumberMessage.deserialize(bytes);
  }

  @override
  TronNumberMessage onServiceResponseJson(Map<String, dynamic> json) {
    return TronNumberMessage.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityGetBlock extends TronProtoMessage
    with ITronProtoServiceMessage<TronBlockExtention> {
  final TronProtoJsonConfig jsonConfig;

  final TronBlockReq? getBlock;

  const TronWalletSolidityGetBlock({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getBlock,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getBlock?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getBlock?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getBlock) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityGetBlock;
  @override
  TronBlockExtention onServiceResponse(List<int> bytes) {
    return TronBlockExtention.deserialize(bytes);
  }

  @override
  TronBlockExtention onServiceResponseJson(Map<String, dynamic> json) {
    return TronBlockExtention.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityGetBandwidthPrices extends TronProtoMessage
    with ITronProtoServiceMessage<TronPricesResponseMessage> {
  final TronProtoJsonConfig jsonConfig;

  final TronEmptyMessage? getBandwidthPrices;

  const TronWalletSolidityGetBandwidthPrices({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getBandwidthPrices,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getBandwidthPrices?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getBandwidthPrices?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getBandwidthPrices) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityGetBandwidthPrices;
  @override
  TronPricesResponseMessage onServiceResponse(List<int> bytes) {
    return TronPricesResponseMessage.deserialize(bytes);
  }

  @override
  TronPricesResponseMessage onServiceResponseJson(Map<String, dynamic> json) {
    return TronPricesResponseMessage.fromJson(json, config: jsonConfig);
  }
}

class TronWalletSolidityGetEnergyPrices extends TronProtoMessage
    with ITronProtoServiceMessage<TronPricesResponseMessage> {
  final TronProtoJsonConfig jsonConfig;

  final TronEmptyMessage? getEnergyPrices;

  const TronWalletSolidityGetEnergyPrices({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getEnergyPrices,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getEnergyPrices?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getEnergyPrices?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getEnergyPrices) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletSolidityGetEnergyPrices;
  @override
  TronPricesResponseMessage onServiceResponse(List<int> bytes) {
    return TronPricesResponseMessage.deserialize(bytes);
  }

  @override
  TronPricesResponseMessage onServiceResponseJson(Map<String, dynamic> json) {
    return TronPricesResponseMessage.fromJson(json, config: jsonConfig);
  }
}

class TronWalletExtensionGetTransactionsFromThis extends TronProtoMessage
    with ITronProtoServiceMessage<TronTransactionList> {
  final TronProtoJsonConfig jsonConfig;

  /// Please use GetTransactionsFromThis2 instead of this function.
  final TronAccountPaginated? getTransactionsFromThis;

  const TronWalletExtensionGetTransactionsFromThis({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getTransactionsFromThis,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getTransactionsFromThis?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getTransactionsFromThis?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getTransactionsFromThis) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletExtensionGetTransactionsFromThis;
  @override
  TronTransactionList onServiceResponse(List<int> bytes) {
    return TronTransactionList.deserialize(bytes);
  }

  @override
  TronTransactionList onServiceResponseJson(Map<String, dynamic> json) {
    return TronTransactionList.fromJson(json, config: jsonConfig);
  }
}

class TronWalletExtensionGetTransactionsFromThis2 extends TronProtoMessage
    with ITronProtoServiceMessage<TronTransactionListExtention> {
  final TronProtoJsonConfig jsonConfig;

  /// Use this function instead of GetTransactionsFromThis.
  final TronAccountPaginated? getTransactionsFromThis2;

  const TronWalletExtensionGetTransactionsFromThis2({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getTransactionsFromThis2,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getTransactionsFromThis2?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getTransactionsFromThis2?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getTransactionsFromThis2) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletExtensionGetTransactionsFromThis2;
  @override
  TronTransactionListExtention onServiceResponse(List<int> bytes) {
    return TronTransactionListExtention.deserialize(bytes);
  }

  @override
  TronTransactionListExtention onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return TronTransactionListExtention.fromJson(json, config: jsonConfig);
  }
}

class TronWalletExtensionGetTransactionsToThis extends TronProtoMessage
    with ITronProtoServiceMessage<TronTransactionList> {
  final TronProtoJsonConfig jsonConfig;

  /// Please use GetTransactionsToThis2 instead of this function.
  final TronAccountPaginated? getTransactionsToThis;

  const TronWalletExtensionGetTransactionsToThis({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getTransactionsToThis,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getTransactionsToThis?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getTransactionsToThis?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getTransactionsToThis) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletExtensionGetTransactionsToThis;
  @override
  TronTransactionList onServiceResponse(List<int> bytes) {
    return TronTransactionList.deserialize(bytes);
  }

  @override
  TronTransactionList onServiceResponseJson(Map<String, dynamic> json) {
    return TronTransactionList.fromJson(json, config: jsonConfig);
  }
}

class TronWalletExtensionGetTransactionsToThis2 extends TronProtoMessage
    with ITronProtoServiceMessage<TronTransactionListExtention> {
  final TronProtoJsonConfig jsonConfig;

  /// Use this function instead of GetTransactionsToThis.
  final TronAccountPaginated? getTransactionsToThis2;

  const TronWalletExtensionGetTransactionsToThis2({
    this.jsonConfig = TronProtoJsonConfig.config,
    this.getTransactionsToThis2,
  });

  @override
  ProtoMessageConfig protoConfig() =>
      getTransactionsToThis2?.protoConfig() ?? ProtoMessageConfig();

  @override
  List<Object?> get protoValues => getTransactionsToThis2?.protoValues ?? [];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return config.encodeMessage(getTransactionsToThis2) ?? {};
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolWalletExtensionGetTransactionsToThis2;
  @override
  TronTransactionListExtention onServiceResponse(List<int> bytes) {
    return TronTransactionListExtention.deserialize(bytes);
  }

  @override
  TronTransactionListExtention onServiceResponseJson(
    Map<String, dynamic> json,
  ) {
    return TronTransactionListExtention.fromJson(json, config: jsonConfig);
  }
}
