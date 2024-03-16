// import 'package:blockchain_utils/cbor/cbor.dart';
// import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';

// class PlutusScriptSourceType with ADASerialization {
//   final String name;
//   final int value;
//   const PlutusScriptSourceType._(this.name, this.value);
//   static const PlutusScriptSourceType script =
//       PlutusScriptSourceType._("Script", 0);
//   static const PlutusScriptSourceType refInput =
//       PlutusScriptSourceType._("RefInput", 1);

//   @override
//   String toString() {
//     return "PlutusScriptSourceTypes.$name";
//   }

//   @override
//   CborObject toCbor() {
//     return CborIntValue(value);
//   }

//   @override
//   String toJson() {
//     return name;
//   }
// }
