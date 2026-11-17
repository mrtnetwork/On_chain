import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/proto_messages/types.dart';
import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';

/// Copyright (c) Mysten Labs, Inc.
/// SPDX-License-Identifier: Apache-2.0
/// DNF filter for transactions: any term may match, and each term is an AND
/// of signed literals.
/// An absent filter matches everything. A present filter must have at least one
/// term.
class SuiTransactionFilter extends SuiProtoMessage {
    /// Terms are ORed together.
  final List<SuiTransactionTerm> terms;

  const SuiTransactionFilter({
    this.terms = const [],
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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        terms,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'terms': terms.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory SuiTransactionFilter.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiTransactionFilter(
      terms: (json.valueEnsureAsList<dynamic>('terms', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<SuiTransactionTerm, Object>(
          value: e,
          parse: (v) => SuiTransactionTerm.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory SuiTransactionFilter.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiTransactionFilter(
      terms: decode.getListOfBytes(1).map((b) => SuiTransactionTerm.deserialize(b)).toList(),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2TransactionFilter;

}


/// One conjunction in a transaction DNF filter.
class SuiTransactionTerm extends SuiProtoMessage {
    /// Literals are ANDed together.
  final List<SuiTransactionLiteral> literals;

  const SuiTransactionTerm({
    this.literals = const [],
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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        literals,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'literals': literals.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory SuiTransactionTerm.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiTransactionTerm(
      literals: (json.valueEnsureAsList<dynamic>('literals', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<SuiTransactionLiteral, Object>(
          value: e,
          parse: (v) => SuiTransactionLiteral.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory SuiTransactionTerm.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiTransactionTerm(
      literals: decode.getListOfBytes(1).map((b) => SuiTransactionLiteral.deserialize(b)).toList(),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2TransactionTerm;

}


/// One signed transaction predicate literal: a predicate, optionally negated.
class SuiTransactionLiteral extends SuiProtoMessage {
    /// When true, the literal matches transactions that the predicate does *not*
  /// match.
  final bool? negated;

    /// The transaction-index predicate to match.
  /// Match transactions sent by the specified address.
  final SuiSenderFilter? sender;

    /// Match transactions where the specified address's state moved as a side
  /// effect: it owns an object after the txn, owned an object before the
  /// txn that was mutated/transferred away/deleted/wrapped, or its
  /// address-balance changed via an accumulator event.
  final SuiAffectedAddressFilter? affectedAddress;

    /// Match transactions whose effects include a change for the specified
  /// object.
  final SuiAffectedObjectFilter? affectedObject;

    /// Match transactions that made a Move call matching the specified filter.
  final SuiMoveCallFilter? moveCall;

    /// Match transactions that emitted an event whose package/module fields
  /// match the specified filter.
  final SuiEmitModuleFilter? emitModule;

    /// Match transactions that emitted an event with a type matching the
  /// specified filter.
  final SuiEventTypeFilter? eventType;

    /// Match transactions that wrote to the specified authenticated event
  /// stream head.
  final SuiEventStreamHeadFilter? eventStreamHead;

    /// Match transactions that wrote a Move package — a first publish or an
  /// upgrade, of any package.
  final SuiPackageWriteFilter? packageWrite;

  const SuiTransactionLiteral({
    this.negated,
    this.sender,
    this.affectedAddress,
    this.affectedObject,
    this.moveCall,
    this.emitModule,
    this.eventType,
    this.eventStreamHead,
    this.packageWrite,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bool(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.message(5),
        ProtoFieldConfig.message(6),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.message(8),
        ProtoFieldConfig.message(9),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        negated,
        sender,
        affectedAddress,
        affectedObject,
        moveCall,
        emitModule,
        eventType,
        eventStreamHead,
        packageWrite,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'negated': negated,
      'sender': config.encodeMessage(sender),
      'affected_address': config.encodeMessage(affectedAddress),
      'affected_object': config.encodeMessage(affectedObject),
      'move_call': config.encodeMessage(moveCall),
      'emit_module': config.encodeMessage(emitModule),
      'event_type': config.encodeMessage(eventType),
      'event_stream_head': config.encodeMessage(eventStreamHead),
      'package_write': config.encodeMessage(packageWrite),
    };
  }


  factory SuiTransactionLiteral.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiTransactionLiteral(
      negated: json.valueAsBool<bool?>('negated', normalizeKeyLookup: config.normalizeKeys),
      sender: json.valueTo<SuiSenderFilter?, Object>(
        key: 'sender',
        parse: (v) => SuiSenderFilter.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      affectedAddress: json.valueTo<SuiAffectedAddressFilter?, Object>(
        key: 'affected_address',
        parse: (v) => SuiAffectedAddressFilter.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      affectedObject: json.valueTo<SuiAffectedObjectFilter?, Object>(
        key: 'affected_object',
        parse: (v) => SuiAffectedObjectFilter.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      moveCall: json.valueTo<SuiMoveCallFilter?, Object>(
        key: 'move_call',
        parse: (v) => SuiMoveCallFilter.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      emitModule: json.valueTo<SuiEmitModuleFilter?, Object>(
        key: 'emit_module',
        parse: (v) => SuiEmitModuleFilter.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      eventType: json.valueTo<SuiEventTypeFilter?, Object>(
        key: 'event_type',
        parse: (v) => SuiEventTypeFilter.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      eventStreamHead: json.valueTo<SuiEventStreamHeadFilter?, Object>(
        key: 'event_stream_head',
        parse: (v) => SuiEventStreamHeadFilter.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      packageWrite: json.valueTo<SuiPackageWriteFilter?, Object>(
        key: 'package_write',
        parse: (v) => SuiPackageWriteFilter.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory SuiTransactionLiteral.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiTransactionLiteral(
      negated: decode.getBool<bool?>(1),
      sender: decode.messageTo<SuiSenderFilter?>(2, (b) => SuiSenderFilter.deserialize(b)),
      affectedAddress: decode.messageTo<SuiAffectedAddressFilter?>(3, (b) => SuiAffectedAddressFilter.deserialize(b)),
      affectedObject: decode.messageTo<SuiAffectedObjectFilter?>(4, (b) => SuiAffectedObjectFilter.deserialize(b)),
      moveCall: decode.messageTo<SuiMoveCallFilter?>(5, (b) => SuiMoveCallFilter.deserialize(b)),
      emitModule: decode.messageTo<SuiEmitModuleFilter?>(6, (b) => SuiEmitModuleFilter.deserialize(b)),
      eventType: decode.messageTo<SuiEventTypeFilter?>(7, (b) => SuiEventTypeFilter.deserialize(b)),
      eventStreamHead: decode.messageTo<SuiEventStreamHeadFilter?>(8, (b) => SuiEventStreamHeadFilter.deserialize(b)),
      packageWrite: decode.messageTo<SuiPackageWriteFilter?>(9, (b) => SuiPackageWriteFilter.deserialize(b)),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2TransactionLiteral;

}


/// DNF filter for events: any term may match, and each term is an AND of
/// signed literals. Sender predicates match all events from matching
/// transactions; emit-module, event-type, and event-stream-head predicates match
/// individual event-space dimensions. An absent filter matches everything. A
/// present filter must have at least one term.
class SuiEventFilter extends SuiProtoMessage {
    /// Terms are ORed together.
  final List<SuiEventTerm> terms;

  const SuiEventFilter({
    this.terms = const [],
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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        terms,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'terms': terms.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory SuiEventFilter.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiEventFilter(
      terms: (json.valueEnsureAsList<dynamic>('terms', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<SuiEventTerm, Object>(
          value: e,
          parse: (v) => SuiEventTerm.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory SuiEventFilter.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiEventFilter(
      terms: decode.getListOfBytes(1).map((b) => SuiEventTerm.deserialize(b)).toList(),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2EventFilter;

}


/// One conjunction in an event DNF filter.
class SuiEventTerm extends SuiProtoMessage {
    /// Literals are ANDed together.
  final List<SuiEventLiteral> literals;

  const SuiEventTerm({
    this.literals = const [],
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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        literals,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'literals': literals.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory SuiEventTerm.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiEventTerm(
      literals: (json.valueEnsureAsList<dynamic>('literals', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<SuiEventLiteral, Object>(
          value: e,
          parse: (v) => SuiEventLiteral.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory SuiEventTerm.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiEventTerm(
      literals: decode.getListOfBytes(1).map((b) => SuiEventLiteral.deserialize(b)).toList(),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2EventTerm;

}


/// One signed event predicate literal: a predicate, optionally negated.
class SuiEventLiteral extends SuiProtoMessage {
    /// When true, the literal matches events that the predicate does *not* match.
  final bool? negated;

    /// The event-index predicate to match.
  /// Match events from transactions sent by the specified address.
  final SuiSenderFilter? sender;

    /// Match events whose package/module fields match the specified filter.
  final SuiEmitModuleFilter? emitModule;

    /// Match events whose type matches the specified filter.
  final SuiEventTypeFilter? eventType;

    /// Match events committed to the specified authenticated event stream head.
  final SuiEventStreamHeadFilter? eventStreamHead;

  const SuiEventLiteral({
    this.negated,
    this.sender,
    this.emitModule,
    this.eventType,
    this.eventStreamHead,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bool(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.message(5),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        negated,
        sender,
        emitModule,
        eventType,
        eventStreamHead,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'negated': negated,
      'sender': config.encodeMessage(sender),
      'emit_module': config.encodeMessage(emitModule),
      'event_type': config.encodeMessage(eventType),
      'event_stream_head': config.encodeMessage(eventStreamHead),
    };
  }


  factory SuiEventLiteral.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiEventLiteral(
      negated: json.valueAsBool<bool?>('negated', normalizeKeyLookup: config.normalizeKeys),
      sender: json.valueTo<SuiSenderFilter?, Object>(
        key: 'sender',
        parse: (v) => SuiSenderFilter.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      emitModule: json.valueTo<SuiEmitModuleFilter?, Object>(
        key: 'emit_module',
        parse: (v) => SuiEmitModuleFilter.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      eventType: json.valueTo<SuiEventTypeFilter?, Object>(
        key: 'event_type',
        parse: (v) => SuiEventTypeFilter.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      eventStreamHead: json.valueTo<SuiEventStreamHeadFilter?, Object>(
        key: 'event_stream_head',
        parse: (v) => SuiEventStreamHeadFilter.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory SuiEventLiteral.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiEventLiteral(
      negated: decode.getBool<bool?>(1),
      sender: decode.messageTo<SuiSenderFilter?>(2, (b) => SuiSenderFilter.deserialize(b)),
      emitModule: decode.messageTo<SuiEmitModuleFilter?>(3, (b) => SuiEmitModuleFilter.deserialize(b)),
      eventType: decode.messageTo<SuiEventTypeFilter?>(4, (b) => SuiEventTypeFilter.deserialize(b)),
      eventStreamHead: decode.messageTo<SuiEventStreamHeadFilter?>(5, (b) => SuiEventStreamHeadFilter.deserialize(b)),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2EventLiteral;

}


/// Match by transaction sender address.
class SuiSenderFilter extends SuiProtoMessage {
    /// The sender address (hex-encoded).
  final String? address;

  const SuiSenderFilter({
    this.address,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        address,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'address': address,
    };
  }


  factory SuiSenderFilter.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiSenderFilter(
      address: json.valueAsString<String?>('address', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory SuiSenderFilter.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiSenderFilter(
      address: decode.getString<String?>(1),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2SenderFilter;

}


/// Match by any address whose state moved as a side effect of the
/// transaction: object ownership changes (in either direction), prior
/// owners of removed/wrapped objects, and address-balance changes via
/// accumulator events.
class SuiAffectedAddressFilter extends SuiProtoMessage {
    /// The affected address (hex-encoded).
  final String? address;

  const SuiAffectedAddressFilter({
    this.address,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        address,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'address': address,
    };
  }


  factory SuiAffectedAddressFilter.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiAffectedAddressFilter(
      address: json.valueAsString<String?>('address', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory SuiAffectedAddressFilter.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiAffectedAddressFilter(
      address: decode.getString<String?>(1),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2AffectedAddressFilter;

}


/// Match by changed object ID.
class SuiAffectedObjectFilter extends SuiProtoMessage {
    /// The changed object ID (hex-encoded).
  final String? objectId;

  const SuiAffectedObjectFilter({
    this.objectId,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        objectId,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'object_id': objectId,
    };
  }


  factory SuiAffectedObjectFilter.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiAffectedObjectFilter(
      objectId: json.valueAsString<String?>('object_id', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory SuiAffectedObjectFilter.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiAffectedObjectFilter(
      objectId: decode.getString<String?>(1),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2AffectedObjectFilter;

}


/// Match by Move function call, specified as a `::`-delimited Move path.
///
/// Specificity levels:
/// "0xpkg"                        -&gt; matches any call in the package
/// "0xpkg::module"                -&gt; matches any call in the module
/// "0xpkg::module::function"      -&gt; matches calls to the exact function
class SuiMoveCallFilter extends SuiProtoMessage {
    /// Required. Move path of the form `package[::module[::function]]`.
  final String? function;

  const SuiMoveCallFilter({
    this.function,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        function,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'function': function,
    };
  }


  factory SuiMoveCallFilter.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiMoveCallFilter(
      function: json.valueAsString<String?>('function', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory SuiMoveCallFilter.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiMoveCallFilter(
      function: decode.getString<String?>(1),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2MoveCallFilter;

}


/// Match by an event's package/module fields, specified as a `::`-delimited
/// Move path. These identify the top-level Move call that triggered the event.
///
/// Specificity levels:
/// "0xpkg"               -&gt; matches events with this package_id
/// "0xpkg::module"       -&gt; matches events with this package_id and module
class SuiEmitModuleFilter extends SuiProtoMessage {
    /// Required. Move path of the form `package[::module]`.
  final String? module;

  const SuiEmitModuleFilter({
    this.module,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        module,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'module': module,
    };
  }


  factory SuiEmitModuleFilter.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiEmitModuleFilter(
      module: json.valueAsString<String?>('module', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory SuiEmitModuleFilter.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiEmitModuleFilter(
      module: decode.getString<String?>(1),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2EmitModuleFilter;

}


/// Match by event struct type, specified as a Move type string.
///
/// Specificity levels:
/// "0xaddr"                              -&gt; matches events whose type is defined at this address
/// "0xaddr::module"                      -&gt; matches events whose type is in this module
/// "0xaddr::module::Name"                -&gt; matches events with this type name (any instantiation)
/// "0xaddr::module::Name&lt;T1, T2&gt;"        -&gt; matches events with this exact generic instantiation
class SuiEventTypeFilter extends SuiProtoMessage {
    /// Required. Move type string of the form
  /// `address[::module[::Name[&lt;type_params&gt;]]]`.
  final String? eventType;

  const SuiEventTypeFilter({
    this.eventType,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        eventType,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'event_type': eventType,
    };
  }


  factory SuiEventTypeFilter.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiEventTypeFilter(
      eventType: json.valueAsString<String?>('event_type', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory SuiEventTypeFilter.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiEventTypeFilter(
      eventType: decode.getString<String?>(1),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2EventTypeFilter;

}


/// Match by authenticated event stream head.
class SuiEventStreamHeadFilter extends SuiProtoMessage {
    /// The stream id address (hex-encoded).
  final String? streamId;

  const SuiEventStreamHeadFilter({
    this.streamId,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.string(1, hasOptionalFlags: true),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        streamId,
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'stream_id': streamId,
    };
  }


  factory SuiEventStreamHeadFilter.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiEventStreamHeadFilter(
      streamId: json.valueAsString<String?>('stream_id', normalizeKeyLookup: config.normalizeKeys),
    );
  }

  factory SuiEventStreamHeadFilter.deserialize(List<int> bytes) {
    final decode = SuiProtoMessage.decode(bytes, protoConfigStatic());
    return SuiEventStreamHeadFilter(
      streamId: decode.getString<String?>(1),
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2EventStreamHeadFilter;

}


/// Match transactions that wrote a Move package.
class SuiPackageWriteFilter extends SuiProtoMessage {
  const SuiPackageWriteFilter();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
      ];


  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
    };
  }


  factory SuiPackageWriteFilter.fromJson(Map<String, dynamic> json, {ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return SuiPackageWriteFilter(
    );
  }

  factory SuiPackageWriteFilter.deserialize(List<int> bytes) {
    return SuiPackageWriteFilter(
    );
  }

  @override
DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.suiRpcV2PackageWriteFilter;

}


