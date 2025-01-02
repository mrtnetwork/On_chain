import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/utils/utils.dart';

class ProgramDerivedAddress {
  factory ProgramDerivedAddress.find(
      {required List<List<int>> seedBytes, required SolAddress programId}) {
    final derive =
        SolanaUtils.findProgramAddress(seeds: seedBytes, programId: programId);
    return ProgramDerivedAddress(address: derive.item1, bump: derive.item2);
  }
  const ProgramDerivedAddress({required this.address, required this.bump});
  final SolAddress address;
  final int bump;

  @override
  String toString() {
    return address.toString();
  }
}
