import 'package:blockchain_utils/exception/exception.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class InterestBearingMintInstruction extends LayoutSerializable {
  const InterestBearingMintInstruction._(this.name);
  final String name;
  static const InterestBearingMintInstruction initialize =
      InterestBearingMintInstruction._("Initialize");
  static const InterestBearingMintInstruction updateRate =
      InterestBearingMintInstruction._("UpdateRate");

  static const List<InterestBearingMintInstruction> values = [
    initialize,
    updateRate
  ];

  static Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.rustEnum(
        values.map((e) => LayoutUtils.none(e.name)).toList(), LayoutUtils.u8(),
        property: "interestBearingMint")
  ]);
  @override
  Structure get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      "interestBearingMint": {name: null}
    };
  }

  factory InterestBearingMintInstruction.fromJson(Map<String, dynamic> json) {
    return fromName(json["interestBearingMint"]["key"]);
  }
  static InterestBearingMintInstruction fromName(String? value) {
    return values.firstWhere(
      (element) => element.name == value,
      orElse: () => throw MessageException(
          "No InterestBearingMint found matching the specified value",
          details: {"value": value}),
    );
  }

  @override
  String toString() {
    return "InterestBearingMint${serialize()}";
  }
}
