import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/proto_messages/types.dart';
import 'package:on_chain/tron/src/serialization/protobuf/proto.dart';

/// Specify the name of the package that generated the Java file
/// Specify the class name of the generated Java file
class TronInventoryItems extends TronProtoMessage {
  final int? type;

  final List<List<int>> items;

  const TronInventoryItems({
    this.type,
    this.items = const [],
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.int32(1),
        ProtoFieldConfig.repeated(
          fieldNumber: 2,
          elementType: ProtoFieldType.bytes,
        ),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        type,
        items,
      ];


  @override
  Map<String, dynamic> toJson({TronProtoJsonConfig config = TronProtoJsonConfig.config}) {
    return {
      'type': type,
      'items': items.map((e) => config.encodeBinary(e)).toList(),
    }.notNullValue;
  }


  factory TronInventoryItems.fromJson(Map<String, dynamic> json, {TronProtoJsonConfig config = TronProtoJsonConfig.config}) {
    return TronInventoryItems(
      type: json.valueAsInt<int?>('type', normalizeKeyLookup: config.normalizeKeys),
      items: (json.valueEnsureAsList<dynamic>('items', normalizeKeyLookup: config.normalizeKeys , onMissing: ()=>[])).map((e) => config.decodeBinary<List<int>>(e)).toList(),
    );
  }

  factory TronInventoryItems.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronInventoryItems(
      type: decode.getInt<int?>(1),
      items: decode.getListOfBytes(2),
    );
  }

  @override
DefaultTronProtoTypeUrl get declarationId => DefaultTronProtoTypeUrl.protocolInventoryItems;

}


