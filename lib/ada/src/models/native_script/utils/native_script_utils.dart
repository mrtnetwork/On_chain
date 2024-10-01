import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/ada/src/models/native_script/core/native_script_type.dart';

/// Utility class for native script operations.
class NativeScriptUtils {
  /// Validates the CBOR object for the specified native script type.
  static void validateCborTypeObject(CborObject cbor, NativeScriptType type) {
    // Check if the CBOR object is an integer value
    if (cbor is! CborIntValue) {
      throw ADAPluginException("Invalid CBOR type for native script type.",
          details: {"Type": cbor.runtimeType});
    }

    // Deserialize the CBOR object to a native script type
    final cborType = NativeScriptType.deserialize(cbor);

    // Check if the deserialized type matches the expected type
    if (cborType != type) {
      throw ADAPluginException("Invalid Native Script type.",
          details: {"Expected": type, "Actual": cborType});
    }
  }
}
