import 'package:on_chain/solana/src/exception/exception.dart';

class MembershipModel {
  final String name;
  final int value;
  const MembershipModel._(this.name, this.value);

  static const wallet = MembershipModel._('Wallet', 0);
  static const token = MembershipModel._('Token', 1);
  static const nft = MembershipModel._('NFT', 2);
  static final List<MembershipModel> values = [wallet, token, nft];

  static MembershipModel fromValue(int? value) {
    try {
      return values.firstWhere((element) => element.value == value);
    } on StateError {
      throw SolanaPluginException(
          'No MembershipModel found matching the specified value',
          details: {'value': value});
    }
  }

  @override
  String toString() {
    return 'MembershipModel.$name';
  }
}
