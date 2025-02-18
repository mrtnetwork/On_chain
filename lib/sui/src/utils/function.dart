import 'package:on_chain/sui/src/address/address/address.dart';
import 'package:on_chain/sui/src/exception/exception.dart';
import 'package:on_chain/sui/src/transaction/types/types.dart';

/// Utility class for parsing and handling sui type tag arguments
class SuiTypeTagUtils {
  static SuiTypeInput parseTag(String name) {
    final type = SuiTypeInputs.find(name);
    switch (type) {
      case SuiTypeInputs.boolean:
      case SuiTypeInputs.u8:
      case SuiTypeInputs.u16:
      case SuiTypeInputs.u32:
      case SuiTypeInputs.u64:
      case SuiTypeInputs.u128:
      case SuiTypeInputs.u256:
        return SuiTypeInputPrimitive(type!);
      case SuiTypeInputs.address:
        return SuiTypeInputAddress();
      case SuiTypeInputs.signer:
        return SuiTypeInputSigner();
      default:
        final typeName = _extractObjectName(name);
        if (_isStruct(typeName)) {
          final data = typeName!.split("::");
          final address = SuiAddress(data[0]);
          final moduleName = _toIdentifier(data[1]);
          final functionName = _toIdentifier(data[2]);
          if (moduleName == null) {
            throw DartSuiPluginException(
                "Unable to parse struct tag: Invalid module name: '${data[1]}'");
          }
          if (functionName == null) {
            throw DartSuiPluginException(
                "Unable to parse struct tag: Invalid function name: '${data[2]}'");
          }
          List<SuiTypeInput> typeArgs = [];
          if (name.length != typeName.length) {
            final rawParts =
                _extractFirstGeneric(name.substring(typeName.length));
            List<String> genericParts = [];
            if (rawParts != null) {
              int bracketCount = 0;
              int lastSplit = 0;
              for (int i = 0; i < rawParts.length; i++) {
                if (rawParts[i] == '<') bracketCount++;
                if (rawParts[i] == '>') bracketCount--;
                if (rawParts[i] == ',' && bracketCount == 0) {
                  genericParts.add(rawParts.substring(lastSplit, i).trim());
                  lastSplit = i + 1;
                }
              }
              genericParts.add(rawParts.substring(lastSplit).trim());
            }
            if (genericParts.isEmpty) {
              throw DartSuiPluginException(
                  "Invalid type arguments generic parts.",
                  details: {"parts": name.substring(typeName.length)});
            }
            try {
              typeArgs = genericParts.map((e) => parseTag(e)).toList();
            } catch (e) {
              throw DartSuiPluginException(
                  "Failed to parse type arguments from parts: $genericParts. "
                  "Error: ${e.toString()}");
            }
          }

          return SuiTypeInputStruct(SuiStructInput(
              address: address,
              module: moduleName,
              name: functionName,
              typeParams: typeArgs));
        }
        if (_isVector(name)) {
          final c = _extractFirstGeneric(name);
          return SuiTypeInputVector(parseTag(c!));
        }
        throw DartSuiPluginException(
            "Unknown type tag. Failed to parse the provided input: '$name'.");
    }
  }

  static String? _extractFirstGeneric(String input) {
    RegExp regExp = RegExp(r'<([^<]*(?:<[^>]*>[^<]*)*)>');
    Iterable<Match> matches = regExp.allMatches(input);
    if (matches.isEmpty) return null;
    return matches.first.group(1);
  }

  static String? _extractObjectName(String input) {
    RegExp regExp = RegExp(r'^[^<]*');
    Iterable<Match> matches = regExp.allMatches(input);
    if (matches.isEmpty) return null;
    return matches.first.group(0);
  }

  static bool _isStruct(String? input) {
    if (input?.split("::").length == 3) return true;
    return false;
  }

  static bool _isVector(String? input) {
    if (input == null) return false;
    final type = _extractObjectName(input);
    final argType = SuiTypeInputs.find(type);
    return argType == SuiTypeInputs.vector;
  }

  static String? _toIdentifier(String? input) {
    if (input == null) return null;
    RegExp regExp = RegExp(r'^[a-zA-Z_][a-zA-Z0-9_]*$');
    if (regExp.hasMatch(input)) return input;
    return null;
  }
}
