import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/payload.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class MetaplexTokenMetaDataDelegateLockedTransferV1Layout
    extends MetaplexTokenMetaDataDelegateProgramLayout {
  final Payload? authorizationData;
  final BigInt amount;
  final SolAddress lockedAddress;
  static const int discriminator = 7;
  const MetaplexTokenMetaDataDelegateLockedTransferV1Layout({
    required this.amount,
    required this.lockedAddress,
    this.authorizationData,
  });

  factory MetaplexTokenMetaDataDelegateLockedTransferV1Layout.fromBuffer(
      List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .delegateLockedTransferV1.insturction,
        discriminator: discriminator);
    return MetaplexTokenMetaDataDelegateLockedTransferV1Layout(
        authorizationData: decode['authorizationData'] == null
            ? null
            : Payload.fromJson(decode['authorizationData']),
        lockedAddress: decode['lockedAddress'],
        amount: decode['amount']);
  }

  static StructLayout get _layout => LayoutConst.struct([
        LayoutConst.u8(property: 'instruction'),
        LayoutConst.u8(property: 'discriminator'),
        LayoutConst.u64(property: 'amount'),
        SolanaLayoutUtils.publicKey('lockedAddress'),
        LayoutConst.optional(Payload.staticLayout,
            property: 'authorizationData'),
      ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexTokenMetaDataProgramInstruction get instruction =>
      MetaplexTokenMetaDataProgramInstruction.delegateDataV1;

  @override
  Map<String, dynamic> serialize() {
    return {
      'authorizationData': authorizationData?.serialize(),
      'discriminator': discriminator,
      'amount': amount,
      'lockedAddress': lockedAddress
    };
  }
}
