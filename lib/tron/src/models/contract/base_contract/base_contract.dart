import 'package:on_chain/tron/src/models/contract/base_contract/common.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/encoder.dart';

import 'transaction_type.dart';

/// Abstract class providing a common implementation for encoding Tron models using minimal protobuf encoding.
abstract class TronProtocolBufferImpl {
  /// List of dynamic values to be encoded.
  abstract final List<dynamic> values;

  /// List of field IDs corresponding to the values.
  abstract final List<int> fieldIds;

  /// Converts the data to a JSON representation.
  Map<String, dynamic> toJson();

  /// Converts the protocol buffer data to a byte buffer.
  List<int> toBuffer() {
    if (values.length != fieldIds.length) {
      throw MessageException(
          "The values and field IDs must have the same length.",
          details: {
            "values": values,
            "fieldIds": fieldIds,
            "class": runtimeType.toString(),
          });
    }
    final bytes = DynamicByteTracker();
    for (int i = 0; i < values.length; i++) {
      final value = values[i];
      final tagNumber = fieldIds[i];
      List<int> encode;
      if (value == null) continue;
      if (value is TronBaseContract) {
        encode = ProtocolBufferEncoder.encode(tagNumber, value.toBuffer());
      } else if (value is TronEnumerate) {
        encode = ProtocolBufferEncoder.encode(tagNumber, value.value);
      } else {
        encode = ProtocolBufferEncoder.encode(tagNumber, value);
      }

      bytes.add(encode);
    }
    return bytes.toBytes();
  }

  /// Gets the hexadecimal representation of the protocol buffer data.
  String get toHex => BytesUtils.toHexString(toBuffer());
}

/// contracts
abstract class TronBaseContract extends TronProtocolBufferImpl {
  TransactionContractType get contractType;
  String get typeURL => "type.googleapis.com/protocol.${contractType.name}";
}
