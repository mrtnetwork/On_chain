import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/google/protobuf/src/wrappers.dart" as google_protobuf_wrappers;

/// -
///  * ‌
///  * Hedera Network Services Protobuf
///  * ​
///  * Copyright (C) 2018 - 2022 Hedera Hashgraph, LLC
///  * ​
///  * Licensed under the Apache License, Version 2.0 (the "License");
///  * you may not use this file except in compliance with the License.
///  * You may obtain a copy of the License at
///  *
///  *      http://www.apache.org/licenses/LICENSE-2.0
///  *
///  * Unless required by applicable law or agreed to in writing, software
///  * distributed under the License is distributed on an "AS IS" BASIS,
///  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
///  * See the License for the specific language governing permissions and
///  * limitations under the License.
///  * ‍
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.streams"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
class HederaContractStateChanges extends HederaProtoMessage with Equality {
  final List<HederaContractStateChange> contractStateChanges;

  const HederaContractStateChanges({
    this.contractStateChanges = const [],
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
        contractStateChanges,
      ];


HederaContractStateChanges copyWith(
{List<HederaContractStateChange>? contractStateChanges,

}) {
    return HederaContractStateChanges(
contractStateChanges: contractStateChanges ?? this.contractStateChanges,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'contract_state_changes': contractStateChanges.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaContractStateChanges.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaContractStateChanges(
      contractStateChanges: (json.valueEnsureAsList<dynamic>('contract_state_changes', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaContractStateChange, Object>(
          value: e,
          parse: (v) => HederaContractStateChange.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaContractStateChanges.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaContractStateChanges(
      contractStateChanges: decode.getListOfBytes(1).map((b) => HederaContractStateChange.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoContractStateChanges;

}


/// *
///  * The storage changes to a smart contract's storage as a side effect of the function call.
class HederaContractStateChange extends HederaProtoMessage with Equality {
    /// *
  ///    * The contract to which the storage changes apply to
  final proto_basic_types.HederaContractID? contractId;

    /// *
  ///    * The list of storage changes.
  final List<HederaStorageChange> storageChanges;

  const HederaContractStateChange({
    this.contractId,
    this.storageChanges = const [],
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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        contractId,
        storageChanges,
      ];


HederaContractStateChange copyWith(
{proto_basic_types.HederaContractID? contractId,

List<HederaStorageChange>? storageChanges,

}) {
    return HederaContractStateChange(
contractId: contractId ?? this.contractId,
storageChanges: storageChanges ?? this.storageChanges,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'contract_id': config.encodeMessage(contractId),
      'storage_changes': storageChanges.map((e) => config.encodeMessage(e)).toList(),
    };
  }


  factory HederaContractStateChange.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaContractStateChange(
      contractId: json.valueTo<proto_basic_types.HederaContractID?, Object>(
        key: 'contract_id',
        parse: (v) => proto_basic_types.HederaContractID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      storageChanges: (json.valueEnsureAsList<dynamic>('storage_changes', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => JsonParser.valueTo<HederaStorageChange, Object>(
          value: e,
          parse: (v) => HederaStorageChange.fromJson(JsonParser.valueAs(v), config: config),
        )).toList(),
    );
  }

  factory HederaContractStateChange.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaContractStateChange(
      contractId: decode.messageTo<proto_basic_types.HederaContractID?>(1, (b) => proto_basic_types.HederaContractID.deserialize(b)),
      storageChanges: decode.getListOfBytes(2).map((b) => HederaStorageChange.deserialize(b)).toList(),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoContractStateChange;

}


/// *
///  * A storage slot change description.
class HederaStorageChange extends HederaProtoMessage with Equality {
    /// *
  ///    * The storage slot changed.  Up to 32 bytes, big-endian, zero bytes left trimmed.
  final List<int>? slot;

    /// *
  ///    * The value read from the storage slot.  Up to 32 bytes, big-endian, zero bytes left trimmed.
  ///    *
  ///    * Because of the way SSTORE operations are charged the slot is always read before being written to.
  final List<int>? valueRead;

    /// *
  ///    * The new value written to the slot.  Up to 32 bytes, big-endian, zero bytes left trimmed.
  ///    *
  ///    * If a value of zero is written the valueWritten will be present but the inner value will be absent.
  ///    *
  ///    * If a value was read and not written this value will not be present.
  final google_protobuf_wrappers.HederaBytesValue? valueWritten;

  const HederaStorageChange({
    this.slot,
    this.valueRead,
    this.valueWritten,
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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        slot,
        valueRead,
        valueWritten,
      ];


HederaStorageChange copyWith(
{List<int>? slot,

List<int>? valueRead,

google_protobuf_wrappers.HederaBytesValue? valueWritten,

}) {
    return HederaStorageChange(
slot: slot ?? this.slot,
valueRead: valueRead ?? this.valueRead,
valueWritten: valueWritten ?? this.valueWritten,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'slot': config.encodeBinary(slot),
      'value_read': config.encodeBinary(valueRead),
      'value_written': config.encodeMessage(valueWritten),
    };
  }


  factory HederaStorageChange.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaStorageChange(
      slot: config.decodeBinary<List<int>?>(json.valueAs('slot', normalizeKeyLookup: config.normalizeKeys)),
      valueRead: config.decodeBinary<List<int>?>(json.valueAs('value_read', normalizeKeyLookup: config.normalizeKeys)),
      valueWritten: json.valueTo<google_protobuf_wrappers.HederaBytesValue?, Object>(
        key: 'value_written',
        parse: (v) => google_protobuf_wrappers.HederaBytesValue.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaStorageChange.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaStorageChange(
      slot: decode.getBytes<List<int>?>(1),
      valueRead: decode.getBytes<List<int>?>(2),
      valueWritten: decode.messageTo<google_protobuf_wrappers.HederaBytesValue?>(3, (b) => google_protobuf_wrappers.HederaBytesValue.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoStorageChange;

}


