import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;

/// *
///  * # EVM Contract Slot
///  * Information regarding EVM storage "slot"s for the
///  * Hedera Smart Contract service.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in [RFC2119](https://www.ietf.org/rfc/rfc2119)
///  * and clarified in [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.state.contract"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * The key of a storage slot. A slot is scoped to a specific contract ID.
///  *
///  * For each contract, its EVM storage is a mapping of 256-bit keys (or "words")
///  * to 256-bit values.
class HederaSlotKey extends HederaProtoMessage with Equality {
    /// *
  ///      * The Contract ID of the contract that owns (and pays for) this slot.
  final proto_basic_types.HederaContractID? contractID;

    /// *
  ///      * The EVM key of this slot, left-padded with zeros to form a 256-bit word.
  final List<int>? key;

  const HederaSlotKey({
    this.contractID,
    this.key,
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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        contractID,
        key,
      ];


HederaSlotKey copyWith(
{proto_basic_types.HederaContractID? contractID,

List<int>? key,

}) {
    return HederaSlotKey(
contractID: contractID ?? this.contractID,
key: key ?? this.key,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'contractID': config.encodeMessage(contractID),
      'key': config.encodeBinary(key),
    };
  }


  factory HederaSlotKey.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaSlotKey(
      contractID: json.valueTo<proto_basic_types.HederaContractID?, Object>(
        key: 'contractID',
        parse: (v) => proto_basic_types.HederaContractID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      key: config.decodeBinary<List<int>?>(json.valueAs('key', normalizeKeyLookup: config.normalizeKeys)),
    );
  }

  factory HederaSlotKey.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaSlotKey(
      contractID: decode.messageTo<proto_basic_types.HederaContractID?>(1, (b) => proto_basic_types.HederaContractID.deserialize(b)),
      key: decode.getBytes<List<int>?>(2),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoSlotKey;

}


/// *
///  * The value of a contract storage slot. For the EVM, this is a single "word".
///  *
///  * Because we iterate through all the storage slots for an expired contract
///  * when purging it from state, our slot values also include the words of the
///  * previous and next keys in this contract's storage "virtual linked list".
class HederaSlotValue extends HederaProtoMessage with Equality {
    /// *
  ///      * The EVM value in this slot, left-padded with zeros to form a 256-bit word.
  final List<int>? value;

    /// *
  ///      * The word of the previous key in this contract's storage list (if any).
  final List<int>? previousKey;

    /// *
  ///      * The word of the next key in this contract's storage list (if any).
  final List<int>? nextKey;

  const HederaSlotValue({
    this.value,
    this.previousKey,
    this.nextKey,
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
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        value,
        previousKey,
        nextKey,
      ];


HederaSlotValue copyWith(
{List<int>? value,

List<int>? previousKey,

List<int>? nextKey,

}) {
    return HederaSlotValue(
value: value ?? this.value,
previousKey: previousKey ?? this.previousKey,
nextKey: nextKey ?? this.nextKey,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'value': config.encodeBinary(value),
      'previous_key': config.encodeBinary(previousKey),
      'next_key': config.encodeBinary(nextKey),
    };
  }


  factory HederaSlotValue.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaSlotValue(
      value: config.decodeBinary<List<int>?>(json.valueAs('value', normalizeKeyLookup: config.normalizeKeys)),
      previousKey: config.decodeBinary<List<int>?>(json.valueAs('previous_key', normalizeKeyLookup: config.normalizeKeys)),
      nextKey: config.decodeBinary<List<int>?>(json.valueAs('next_key', normalizeKeyLookup: config.normalizeKeys)),
    );
  }

  factory HederaSlotValue.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaSlotValue(
      value: decode.getBytes<List<int>?>(1),
      previousKey: decode.getBytes<List<int>?>(2),
      nextKey: decode.getBytes<List<int>?>(3),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoSlotValue;

}


