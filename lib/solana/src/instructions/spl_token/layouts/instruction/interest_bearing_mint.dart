import 'package:blockchain_utils/exception/exception.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

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

  static StructLayout staticLayout = LayoutConst.struct([
    LayoutConst.rustEnum(
        values.map((e) => LayoutConst.none(property: e.name)).toList(),
        property: "interestBearingMint")
  ]);
  @override
  StructLayout get layout => staticLayout;

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
