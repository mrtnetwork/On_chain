import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class PrintSupply extends LayoutSerializable {
  final List<BigInt>? fields;
  final String name;
  final int kind;
  const PrintSupply._(this.fields, this.name, this.kind);

  static const PrintSupply zero = PrintSupply._(null, "Zero", 0);
  static const PrintSupply unlimited = PrintSupply._(null, "Unlimited", 2);
  factory PrintSupply.limited({required List<BigInt> fields}) {
    if (fields.length != 1) {
      throw MessageException(
          "The fields list must contain exactly one element for a limited print supply.");
    }
    return PrintSupply._(fields, "Limited", 1);
  }
  factory PrintSupply.fromJson({required Map<String, dynamic> json}) {
    final field = json["print_supply"]["key"];
    switch (field) {
      case "Zero":
        return zero;
      case "Unlimited":
        return unlimited;
      default:
        return PrintSupply.limited(
            fields: (json["print_supply"]["value"] as List).cast());
    }
  }

  @override
  String toString() {
    return "PrintSupply.$kind";
  }

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.rustEnum([
      LayoutUtils.none("Zero"),
      LayoutUtils.tuple([LayoutUtils.u64()], property: "Limited"),
      LayoutUtils.none("Unlimited"),
    ], LayoutUtils.u8(), property: "print_supply")
  ]);

  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "print_supply": {name: fields}
    };
  }
}
