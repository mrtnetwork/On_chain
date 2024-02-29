// Imports the necessary package for interacting with blockchain utilities.
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Represents a field in SPL token metadata.
class SPLTokenMetaDataField extends LayoutSerializable {
  /// Constructs a new instance of `SPLTokenMetaDataField` with the provided instruction and value.
  const SPLTokenMetaDataField._(
    this.instruction,
    this.key,
    this.value,
  );

  /// The instruction associated with the field.
  final int instruction;

  /// The value representing the field.
  final String key;

  final dynamic value;

  /// Represents the 'name' field in SPL token metadata.
  factory SPLTokenMetaDataField.name({required String name}) {
    return SPLTokenMetaDataField._(0, "Name", name);
  }

  /// Represents the 'symbol' field in SPL token metadata.
  factory SPLTokenMetaDataField.symbol({required String symbol}) {
    return SPLTokenMetaDataField._(1, "Symbol", symbol);
  }

  /// Represents the 'uri' field in SPL token metadata.
  factory SPLTokenMetaDataField.uri({required String uri}) {
    return SPLTokenMetaDataField._(2, "Uri", uri);
  }

  /// Represents the 'custom' field in SPL token metadata.
  factory SPLTokenMetaDataField.customField(
      {required String keyName, required String value}) {
    return SPLTokenMetaDataField._(3, keyName, value);
  }
  factory SPLTokenMetaDataField.fromJson(Map<String, dynamic> json) {
    final key = json["tokenMetaDataField"]["key"];
    final value = json["tokenMetaDataField"]["value"];
    switch (key) {
      case "Name":
        return SPLTokenMetaDataField.name(name: value);
      case "Symbol":
        return SPLTokenMetaDataField.symbol(symbol: value);
      case "Uri":
        return SPLTokenMetaDataField.uri(uri: value);
      case "Field":
        return SPLTokenMetaDataField.customField(
            keyName: value["key"], value: value["value"]);
      default:
        throw MessageException("invalid SPLTokenMetaDataField",
            details: {"data": json});
    }
  }

  static Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.rustEnum([
      LayoutUtils.string("Name"),
      LayoutUtils.string("Symbol"),
      LayoutUtils.string("Uri"),
      LayoutUtils.struct([
        LayoutUtils.string("key"),
        LayoutUtils.string("value"),
      ], "Field")
    ], LayoutUtils.u8(), property: "tokenMetaDataField")
  ]);

  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "tokenMetaDataField": instruction == 3
          ? {
              "Field": {"key": key, "value": value}
            }
          : {key: value}
    };
  }
}
