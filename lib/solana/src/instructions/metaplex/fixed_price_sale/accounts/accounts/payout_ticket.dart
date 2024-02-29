import 'package:on_chain/solana/src/layout/layout.dart';

class _Utils {
  static const List<int> discriminator = [153, 222, 52, 216, 192, 152, 175, 80];
  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "discriminator"),
    LayoutUtils.boolean(property: "used"),
  ]);
}

class PayoutTicket extends LayoutSerializable {
  static final int size = _Utils.layout.span;
  final bool used;

  const PayoutTicket({required this.used});
  factory PayoutTicket.fromBuffer(List<int> data) {
    final decode = LayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {"discriminator": _Utils.discriminator});
    return PayoutTicket(used: decode["used"]);
  }

  @override
  Structure get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {"discriminator": _Utils.discriminator, "used": used};
  }

  @override
  String toString() {
    return "PayoutTicket${serialize()}";
  }
}
