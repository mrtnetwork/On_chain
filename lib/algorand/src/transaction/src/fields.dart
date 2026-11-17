import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/algorand/src/address/address.dart';

import 'transaction.dart';

enum AlgoTxType {
  pay('pay'),
  keyreg('keyreg'),
  acfg('acfg'),
  axfer('axfer'),
  afrz('afrz'),
  appl('appl'),
  stpf('stpf'),
  hb('hb');

  final String value;
  const AlgoTxType(this.value);

  @override
  String toString() => value;

  static AlgoTxType? tryParse(String s) {
    for (final e in AlgoTxType.values) {
      if (e.value == s) return e;
    }
    return null;
  }

  static AlgoTxType fromValue(String? value) {
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                'Invalid AlgoTxType value.',
                details: {'value': value},
              ),
    );
  }

  static bool isTransactionType(String s) => tryParse(s) != null;
}

sealed class AlgoTxFields {
  final AlgoTxType type;
  const AlgoTxFields(this.type);
}

class PaymentTxnFields extends AlgoTxFields {
  final AlgoAddress receiver;
  final BigInt amount;
  final AlgoAddress? closeRemainderTo;

  const PaymentTxnFields({
    required this.receiver,
    required this.amount,
    this.closeRemainderTo,
  }) : super(AlgoTxType.pay);
}

class KeyregTxnFields extends AlgoTxFields {
  final BuBytes? votePk;
  final BuBytes? selectionPk;
  final BuBytes? stateProofPk;
  final BigInt? voteFirst;
  final BigInt? voteLast;
  final BigInt? voteKeyDilution;
  final bool? nonparticipation;

  KeyregTxnFields({
    List<int>? votePk,
    List<int>? selectionPk,
    List<int>? stateProofPk,
    this.voteFirst,
    this.voteLast,
    this.voteKeyDilution,
    this.nonparticipation,
  }) : stateProofPk = stateProofPk?.asImmutableBytes,
       selectionPk = selectionPk?.asImmutableBytes,
       votePk = votePk?.asImmutableBytes,
       super(AlgoTxType.keyreg);
}

class AssetConfigTxnFields extends AlgoTxFields {
  final BigInt? configAsset; // caid (0 / null = create)
  final AssetParams? assetParams; // apar (null = destroy)

  const AssetConfigTxnFields({this.configAsset, this.assetParams})
    : super(AlgoTxType.acfg);
}

class AssetTransferTxnFields extends AlgoTxFields {
  final BigInt xferAsset; // xaid
  final BigInt assetAmount; // aamt
  final AlgoAddress? assetSender; // asnd (clawback)
  final AlgoAddress assetReceiver; // arcv
  final AlgoAddress? assetCloseTo; // aclose

  const AssetTransferTxnFields({
    required this.xferAsset,
    required this.assetAmount,
    this.assetSender,
    required this.assetReceiver,
    this.assetCloseTo,
  }) : super(AlgoTxType.axfer);
}

class AssetFreezeTxnFields extends AlgoTxFields {
  final AlgoAddress freezeAccount; // fadd
  final BigInt freezeAsset; // faid
  final bool assetFrozen; // afrz

  const AssetFreezeTxnFields({
    required this.freezeAccount,
    required this.freezeAsset,
    required this.assetFrozen,
  }) : super(AlgoTxType.afrz);
}

class ApplicationCallTxnFields extends AlgoTxFields {
  final BigInt applicationId; // apid
  final BigInt onCompletion; // apan
  final List<BuBytes>? applicationArgs; // apaa
  final List<AlgoAddress>? accounts; // apat
  final List<BigInt>? foreignAssets; // apas
  final List<BigInt>? foreignApps; // apfa
  final List<BoxRef>? boxes; // apbx
  final StateSchema? localStateSchema; // apls
  final StateSchema? globalStateSchema; // apgs
  final BuBytes? approvalProgram; // apap
  final BuBytes? clearStateProgram; // apsu
  final BigInt? extraProgramPages; // apep
  final BigInt? rejectVersion; // aprv

  ApplicationCallTxnFields({
    required this.applicationId,
    required this.onCompletion,
    List<List<int>>? applicationArgs,
    this.accounts,
    this.foreignAssets,
    this.foreignApps,
    this.boxes,
    this.localStateSchema,
    this.globalStateSchema,
    List<int>? approvalProgram,
    List<int>? clearStateProgram,
    this.extraProgramPages,
    this.rejectVersion,
  }) : clearStateProgram = clearStateProgram?.asImmutableBytes,
       approvalProgram = approvalProgram?.asImmutableBytes,
       applicationArgs =
           applicationArgs?.map((e) => e.asImmutableBytes).toImutableList,
       super(AlgoTxType.appl);
}

class StateProofTxnFields extends AlgoTxFields {
  final BigInt stateProofType; // sptype
  final StateProof stateProof; // sp
  final StateProofMessage message; // spmsg

  const StateProofTxnFields({
    required this.stateProofType,
    required this.stateProof,
    required this.message,
  }) : super(AlgoTxType.stpf);
}

class HeartbeatTxnFields extends AlgoTxFields {
  final AlgoAddress hbAddress; // a
  final HeartbeatProof hbProof; // prf
  final BuBytes hbSeed; // sd
  final BuBytes hbVoteId; // vid
  final BigInt hbKeyDilution; // kd
  final bool? hbChallengeDiscount; // c

  HeartbeatTxnFields({
    required this.hbAddress,
    required this.hbProof,
    required List<int> hbSeed,
    required List<int> hbVoteId,
    required this.hbKeyDilution,
    this.hbChallengeDiscount,
  }) : hbVoteId = hbVoteId.asImmutableBytes,
       hbSeed = hbSeed.asImmutableBytes,
       super(AlgoTxType.hb);
}

class TransactionHeader {
  final AlgoAddress sender;
  final BigInt fee;
  final BigInt firstValid;
  final BigInt lastValid;
  final BuBytes? note;
  final String? genesisId;
  final BuBytes genesisHash;
  final BuBytes? group;
  final BuBytes? lease;
  final AlgoAddress? rekeyTo;

  TransactionHeader({
    required this.sender,
    required this.fee,
    required this.firstValid,
    required this.lastValid,
    List<int>? note,
    this.genesisId,
    required List<int> genesisHash,
    List<int>? group,
    List<int>? lease,
    this.rekeyTo,
  }) : lease = lease?.asImmutableBytes,
       group = group?.asImmutableBytes,
       genesisHash = genesisHash.asImmutableBytes,
       note = note?.asImmutableBytes;
}
