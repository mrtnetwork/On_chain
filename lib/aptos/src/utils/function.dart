import 'package:on_chain/aptos/src/address/address/address.dart';
import 'package:on_chain/aptos/src/exception/exception.dart';
import 'package:on_chain/aptos/src/provider/models/models/types.dart';
import 'package:on_chain/aptos/src/transaction/types/types.dart';
import 'package:on_chain/bcs/move/types/types.dart';

/// Utility class for parsing and handling Aptos function entry arguments
class AptosFunctionEntryArgumentUtils {
  /// Parses the provided dynamic values into a list of [AptosEntryFunctionArguments]
  /// that match the expected argument types of the given [function].
  ///
  /// - [function]: The Aptos Move function definition containing metadata about expected argument types.
  /// - [values]: The actual argument values to be parsed and converted.
  /// - [genericTypeArgs]: Optional list of generic type arguments (type tags) to handle generic Move functions.
  ///
  /// Returns a list of [AptosEntryFunctionArguments] ready for transaction execution.
  static List<AptosEntryFunctionArguments> parseArguments(
      {required AptosApiMoveFunction function,
      required List<Object?> values,
      List<AptosTypeTag> genericTypeArgs = const []}) {
    int signerIndex =
        function.params.indexWhere((e) => e != "&signer" && e != "signer");
    List<String> paramsString = function.params;
    if (signerIndex >= 0) {
      paramsString = paramsString.sublist(signerIndex);
    }
    final tags = paramsString
        .map((e) => AptosFunctionEntryArgumentUtils._parseTag(e))
        .toList();
    if (tags.length != values.length) {
      throw DartAptosPluginException(
          "Mismatch between parameters and values: expected ${tags.length} parameters, but got ${values.length} values.");
    }

    return List.generate(tags.length, (index) {
      final type = tags[index];
      final value = values[index];
      try {
        return type.toEntryFunctionArguments(
            value: value, genericTypeArgs: genericTypeArgs);
      } catch (e) {
        throw DartAptosPluginException(
            "Parsing argument failed at index $index.",
            details: {"message": e.toString(), "type": type, "value": value});
      }
    });
  }

  static AptosTypeTag _parseTag(String name) {
    if (name.startsWith("&")) {
      return AptosTypeTagReference(_parseTag(name.substring(1)));
    }
    final type = AptosTypeTags.find(name);
    switch (type) {
      case AptosTypeTags.u8:
        return AptosTypeTagNumeric.u8();
      case AptosTypeTags.u16:
        return AptosTypeTagNumeric.u16();
      case AptosTypeTags.u32:
        return AptosTypeTagNumeric.u32();
      case AptosTypeTags.u64:
        return AptosTypeTagNumeric.u64();
      case AptosTypeTags.u128:
        return AptosTypeTagNumeric.u128();
      case AptosTypeTags.u256:
        return AptosTypeTagNumeric.u256();
      case AptosTypeTags.address:
        return AptosTypeTagAddress();
      case AptosTypeTags.signer:
        return AptosTypeTagSigner();
      case AptosTypeTags.boolean:
        return AptosTypeTagBoolean();
      default:
        final typeName = _extractObjectName(name);
        if (_isStruct(typeName)) {
          final data = typeName!.split("::");
          final address = AptosAddress(data[0]);
          final moduleName = _toIdentifier(data[1]);
          final functionName = _toIdentifier(data[2]);
          if (moduleName == null) {
            throw DartAptosPluginException(
                "Unable to parse struct tag: Invalid module name: '${data[1]}'");
          }
          if (functionName == null) {
            throw DartAptosPluginException(
                "Unable to parse struct tag: Invalid function name: '${data[2]}'");
          }
          List<AptosTypeTag> typeArgs = [];
          if (name.length != typeName.length) {
            final rawParts =
                _extractFirstGeneric(name.substring(typeName.length));
            final parts = rawParts
                ?.split(",")
                .map((e) => e.trim())
                .where((e) => e.isNotEmpty)
                .toList();

            if (parts == null || parts.isEmpty) {
              throw DartAptosPluginException(
                  "Invalid type arguments extracted from '$name' after removing '$typeName'. "
                  "Expected comma-separated values, but got: '${rawParts ?? 'null'}'.");
            }
            try {
              typeArgs = parts.map((e) => _parseTag(e)).toList();
            } catch (e) {
              throw DartAptosPluginException(
                  "Failed to parse type arguments from parts: $parts. "
                  "Error: ${e.toString()}");
            }
          }
          return AptosTypeTagStruct(AptosStructTag(
              address: address,
              moduleName: moduleName,
              name: functionName,
              typeArgs: typeArgs));
        }
        if (_isGeneric(name)) {
          return AptosTypeTagGeneric(int.parse(name.substring(1)));
        }
        if (_isVector(name)) {
          final c = _extractFirstGeneric(name);
          return AptosTypeTagVector(_parseTag(c!));
        }
        throw DartAptosPluginException(
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

  static bool _isGeneric(String? input) {
    if (input == null) return false;
    RegExp regExp = RegExp(r'T\d');
    return regExp.hasMatch(input);
  }

  static bool _isVector(String? input) {
    if (input == null) return false;
    final type = _extractObjectName(input);
    final argType = AptosTypeTags.find(type);
    return argType == AptosTypeTags.vector;
  }

  static String? _toIdentifier(String? input) {
    if (input == null) return null;
    RegExp regExp = RegExp(r'^[a-zA-Z_][a-zA-Z0-9_]*$');
    if (regExp.hasMatch(input)) return input;
    return null;
  }
}
