import 'package:blockchain_utils/encoding/encoding.dart';
import 'package:blockchain_utils/utils/utils.dart';

class NEPPRefixConst {
  static const int actionableMessagePrefix = 1073741824;
  static const int metadataTransaction = 366;
}

class NEPPrefix with LayoutSerializable {
  final int prefix;
  const NEPPrefix(this.prefix);
  factory NEPPrefix.deserializeJson(Map<String, dynamic> json) {
    return NEPPrefix(json.valueAsInt("prefix"));
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.u32(property: "prefix"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {"prefix": prefix};
  }
}

class ActionableMessagePrefix extends NEPPrefix {
  const ActionableMessagePrefix.raw(super.prefix);
  ActionableMessagePrefix(int prefix)
    : super(NEPPRefixConst.actionableMessagePrefix + prefix);
  factory ActionableMessagePrefix.deserializeJson(Map<String, dynamic> json) {
    return ActionableMessagePrefix.raw(json.valueAsInt("prefix"));
  }
}

class DelegateActionPrefix extends ActionableMessagePrefix {
  DelegateActionPrefix() : super(NEPPRefixConst.metadataTransaction);
  const DelegateActionPrefix.raw(super.prefix) : super.raw();
  factory DelegateActionPrefix.deserializeJson(Map<String, dynamic> json) {
    return DelegateActionPrefix.raw(json.valueAsInt("prefix"));
  }
  factory DelegateActionPrefix.deserialize(List<int> bytes) {
    final decode = LayoutSerializable.deserialize(
      bytes: bytes,
      layout: NEPPrefix.layout(),
    );
    return DelegateActionPrefix.deserializeJson(decode);
  }
}
