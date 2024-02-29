import 'package:blockchain_utils/blockchain_utils.dart';

class MembershipModel {
  final String name;
  final int value;
  const MembershipModel._(this.name, this.value);

  static final wallet = MembershipModel._("Wallet", 0);
  static final token = MembershipModel._("Token", 1);
  static final nft = MembershipModel._("NFT", 2);
  static final List<MembershipModel> values = [wallet, token, nft];

  static MembershipModel fromValue(int? value) {
    try {
      return values.firstWhere((element) => element.value == value);
    } on StateError {
      throw MessageException(
          "No MembershipModel found matching the specified value",
          details: {"value": value});
    }
  }

  @override
  String toString() {
    return "MembershipModel.$name";
  }
}
