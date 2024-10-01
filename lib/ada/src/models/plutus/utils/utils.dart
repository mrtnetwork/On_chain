import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';
import 'package:on_chain/ada/src/models/plutus/cost_model/cost_model.dart';
import 'package:on_chain/ada/src/models/plutus/plutus/core/plutus_data.dart';
import 'package:on_chain/ada/src/models/plutus/plutus/core/plutus_json_schame.dart';
import 'package:on_chain/ada/src/models/plutus/plutus/types/constr_plutus_data.dart';
import 'package:on_chain/ada/src/models/plutus/plutus/types/integer.dart';
import 'package:on_chain/ada/src/models/plutus/plutus/types/bytes.dart';
import 'package:on_chain/ada/src/models/plutus/plutus/types/list.dart';
import 'package:on_chain/ada/src/models/plutus/plutus/types/map.dart';
import 'package:on_chain/ada/src/models/plutus/plutus_script/language/language.dart';
import 'package:on_chain/ada/src/models/plutus/plutus_script/redeemer_tag/redeemer.dart';

class PlutusDataUtils {
  // static PlutusJsonSchema findSchame(Map<String, dynamic> json) {}
  static ScriptDataHash scriptDatahash(
      {required List<Redeemer> redeemers,
      required Costmdls costmdls,
      PlutusList? datums}) {
    if (redeemers.isEmpty && datums != null) {
      return ScriptDataHash(
          QuickCrypto.blake2b256Hash([0x80, ...datums.serialize(), 0xA0]));
    }
    final List<int> redeemersBytes =
        CborListValue.fixedLength(redeemers.map((e) => e.toCbor()).toList())
            .encode();
    return ScriptDataHash(QuickCrypto.blake2b256Hash([
      ...redeemersBytes,
      ...datums?.serialize() ?? <int>[],
      ...costmdls.languageViewEncoding().encode()
    ]));
  }

  static int costModelKeyLength(Language language) {
    if (language == Language.plutusV1) {
      return 2;
    }
    return 1;
  }

  static const int generalFormTag = 102;
  static const int chunkSize = 64;
  static int? alternativeToCborTag(BigInt alternative) {
    if (alternative <= BigInt.from(6)) {
      return (alternative + BigInt.from(121)).toInt();
    } else if (alternative > BigInt.from(6) &&
        alternative <= BigInt.from(127)) {
      return (alternative + BigInt.from(1273)).toInt();
    }
    return null;
  }

  static BigInt? cborTagToAlternative(int tag) {
    if (tag >= 121 && tag <= 127) {
      return BigInt.from(tag - 121);
    } else if (tag >= 1280 && tag <= 1400) {
      return BigInt.from(tag - 1280 + 7);
    }
    return null;
  }

  static PlutusData parsePlutus(dynamic value, PlutusJsonSchema schame) {
    _validateType(value);
    if (schame == PlutusJsonSchema.basicConversions) {
      if (value is int || value is BigInt) {
        return _encodeNumbers(value);
      } else if (value is String) {
        return _encodeString(value: value, schame: schame, isKey: false);
      } else if (value is List) {
        return _encodeArray(value, schame);
      }
      return _encodeMap(value, schame);
    }

    return _parseDetailed(value, schame);
  }

  static PlutusInteger _encodeNumbers(dynamic value) {
    if (value is int) return PlutusInteger(BigInt.from(value));
    return PlutusInteger(value);
  }

  static PlutusData _encodeString(
      {required PlutusJsonSchema schame,
      required dynamic value,
      required bool isKey}) {
    if (value is! String) {
      throw ADAPluginException("Invalid string format.",
          details: {"Value": "$value", "Type": "${value.runtimeType}"});
    }
    switch (schame) {
      case PlutusJsonSchema.basicConversions:
        if (value.startsWith("0x")) {
          return PlutusBytes(value: BytesUtils.fromHexString(value));
        } else if (isKey) {
          final inBigInt = BigInt.tryParse(value);
          if (inBigInt != null) {
            return PlutusInteger(inBigInt);
          }
          return PlutusBytes(value: StringUtils.encode(value));
        }
        return PlutusBytes(value: StringUtils.encode(value));
      default:
        if (value.startsWith("0x")) {
          throw ADAPluginException(
              "Hex byte strings in detailed schema should NOT start with 0x",
              details: {"Value": value});
        }
        return PlutusBytes(value: BytesUtils.fromHexString(value));
    }
  }

  static PlutusData _encodeArray(dynamic value, PlutusJsonSchema jsonSchema) {
    if (value is! List) {
      throw ADAPluginException("Invalid list type.", details: {"value": value});
    }
    return PlutusList(value.map((e) => parsePlutus(e, jsonSchema)).toList());
  }

  static void _validateType(dynamic val) {
    if (val != null) {
      if (val is int ||
          val is BigInt ||
          val is String ||
          val is List ||
          val is Map) return;
    }
    if (val != null) {
      throw ADAPluginException("Invalid plutus format. type not allowed.",
          details: {"Value": val, "Type": "${val.runtimeType}"});
    }
    throw const ADAPluginException("null not allowed in plutus data");
  }

  static PlutusData _encodeMap(Map value, PlutusJsonSchema jsonSchema) {
    Map<PlutusData, PlutusData> values = {};
    for (final i in value.entries) {
      PlutusData key =
          _encodeString(schame: jsonSchema, value: i.key, isKey: true);
      values.addAll({key: parsePlutus(i.value, jsonSchema)});
    }
    return PlutusMap(values);
  }

  static PlutusData _parseDetailed(dynamic value, PlutusJsonSchema schame) {
    if (value is! Map<String, dynamic>) {
      throw const ADAPluginException(
          "DetailedSchema requires types to be tagged objects");
    }
    if (value.length == 1) {
      final entry = value.entries.first;
      final String key = entry.key;
      final v = entry.value;
      switch (key) {
        case "int":
          return _encodeNumbers(v);
        case "list":
          return _encodeArray(v, schame);
        case "bytes":
          return _encodeString(schame: schame, value: v, isKey: false);
        case "map":
          if (v is! List) {
            throw const ADAPluginException(
              r"entry format in detailed schema map object not correct. Needs to be of form '{'k': 'key', 'v': 'value'}'",
            );
          }
          final Map<PlutusData, PlutusData> values = {};
          for (final i in v) {
            if (i is! Map) {
              throw const ADAPluginException(
                r"entry format in detailed schema map object not correct. Needs to be of form '{'k': 'key', 'v': 'value'}'",
              );
            }
            if (!i.containsKey("k") || !i.containsKey("v")) {
              throw const ADAPluginException(
                r"entry format in detailed schema map object not correct. Needs to be of form '{'k': 'key', 'v': 'value'}'",
              );
            }
            values.addAll(
                {parsePlutus(i["k"], schame): parsePlutus(i["v"], schame)});
          }
          return PlutusMap(values);
        default:
          throw ADAPluginException("key is not valid.", details: {"Key": key});
      }
    } else {
      if (value.length != 2) {
        throw const ADAPluginException(
            "detailed schemas must either have only one of the following keys: \"int\", \"bytes\", \"list\" or \"map\", or both of these 2 keys: \"constructor\" + \"fields\"");
      }
      final constructor = value["constructor"];
      if (constructor is! int && constructor is! BigInt) {
        throw const ADAPluginException(
            "tagged constructors must contain an unsigned integer called \"constructor\"");
      }
      final fileds = value["fields"];
      if (fileds is! List) {
        throw const ADAPluginException(
            "tagged constructors must contian a list called \"fields\"");
      }
      final List<PlutusData> plutusList = [];
      for (final i in fileds) {
        plutusList.add(parsePlutus(i, schame));
      }
      return ConstrPlutusData(
          alternative:
              constructor is int ? BigInt.from(constructor) : constructor,
          data: PlutusList(plutusList));
    }
  }
}
