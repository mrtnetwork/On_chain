/// Common return / result types used by the high-level API mixins.
///
/// Includes [FilExecReturn], Multisig propose/approve returns,
/// [FilEmptyReturn], and [TxResultWithMessageId].
library;

import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/fil/src/address/address.dart';
import 'package:on_chain/fil/src/crypto/cid/cid.dart';
import 'package:on_chain/fil/src/crypto/types/types.dart';
import 'package:on_chain/fil/src/types/message/message.dart';

/// Init.Exec / Exec4 return
class FilExecReturn {
  final FilAddress idAddress;
  final FilAddress robustAddress;

  const FilExecReturn({required this.idAddress, required this.robustAddress});

  factory FilExecReturn.deserialize(
    List<int> bytes, {
    FilNetwork network = FilNetwork.mainnet,
  }) {
    try {
      final data = CborListValue.decode(bytes);
      if (data.value.length == 2) {
        return FilExecReturn(
          idAddress: FilAddress.fromBytes(
            data.objectAt<CborBytesValue>(0).value,
            network: network,
            type: FilAddrType.id,
          ),
          robustAddress: FilAddress.fromBytes(
            data.objectAt<CborBytesValue>(1).value,
            network: network,
            type: FilAddrType.actor,
          ),
        );
      }
    } catch (_) {}
    throw OnChainErrors.filPlugin(
      'FilExecReturn.deserialize',
      reason: 'Invalid ExecReturn CBOR bytes.',
    );
  }

  @override
  String toString() => 'FilExecReturn($idAddress, $robustAddress)';
}

/// Multisig.Propose return
/// [ TxnID, Applied, Code, Ret ]
class FilMultisigProposeReturn {
  final BigInt txnId;
  final bool applied;
  final BigInt code; // exit code of inner apply (0 if not applied / ok)
  final BuBytes ret; // return bytes of applied message
  final BuBytes proposalHash;
  FilMultisigProposeReturn({
    required this.txnId,
    required this.applied,
    required this.code,
    required List<int> ret,
    required List<int> proposalHash,
  }) : ret = ret.asImmutableBytes,
       proposalHash = proposalHash.asImmutableBytes;

  factory FilMultisigProposeReturn.deserialize({
    required List<int> bytes,
    required List<int> proposalHash,
  }) {
    try {
      final data = CborListValue.decode(bytes);
      if (data.value.length >= 4) {
        return FilMultisigProposeReturn(
          txnId: data.objectAt<CborNumeric>(0).toBigInt(),
          applied: data.rawValueAt(1),
          code: data.objectAt<CborNumeric>(2).toBigInt(),
          ret: data.objectAt<CborBytesValue>(3).value,
          proposalHash: proposalHash,
        );
      }
    } catch (_) {}
    throw OnChainErrors.filPlugin(
      'FilMultisigProposeReturn.deserialize',
      reason: 'Invalid ProposeReturn CBOR bytes.',
    );
  }

  @override
  String toString() =>
      'FilMultisigProposeReturn(txnId=$txnId, applied=$applied, code=$code)';
}

/// Multisig.Approve return
/// [ Applied, Code, Ret ]
class FilMultisigApproveReturn {
  final bool applied;
  final BigInt code;
  final BuBytes ret;

  FilMultisigApproveReturn({
    required this.applied,
    required this.code,
    required List<int> ret,
  }) : ret = ret.asImmutableBytes;

  factory FilMultisigApproveReturn.deserialize(List<int> bytes) {
    try {
      final data = CborListValue.decode(bytes);
      if (data.value.length >= 3) {
        return FilMultisigApproveReturn(
          applied: data.objectAt<CborBooleanValue>(0).value,
          code: data.objectAt<CborNumeric>(1).toBigInt(),
          ret: data.objectAt<CborBytesValue>(2).value,
        );
      }
    } catch (_) {}
    throw OnChainErrors.filPlugin(
      'FilMultisigApproveReturn.deserialize',
      reason: 'Invalid ApproveReturn CBOR bytes.',
    );
  }

  @override
  String toString() => 'FilMultisigApproveReturn(applied=$applied, code=$code)';
}

/// Empty return (Cancel, AddSigner, RemoveSigner, SwapSigner,
/// ChangeNumApprovalsThreshold, LockBalance)
class FilEmptyReturn {
  const FilEmptyReturn();

  factory FilEmptyReturn.deserialize(List<int>? bytes) {
    // empty CBOR or null is fine
    if (bytes == null || bytes.isEmpty) return const FilEmptyReturn();
    try {
      // sometimes empty array / null
      CborObject.fromCbor(bytes);
      return const FilEmptyReturn();
    } catch (_) {
      throw OnChainErrors.filPlugin(
        'FilEmptyReturn.deserialize',
        reason: 'Invalid empty return CBOR bytes.',
      );
    }
  }

  @override
  String toString() => 'FilEmptyReturn()';
}

/// Signer + on-chain address used as `From` for Propose/Approve.
class FilSignerWithAddress {
  final FilAddress address;
  final FilSigner signer;

  const FilSignerWithAddress({required this.address, required this.signer});
}

class FilMultisigOneShotResult {
  final BigInt txnId;
  final TxResultWithMessageId<FilMultisigProposeReturn> propose;
  final List<TxResultWithMessageId<FilMultisigApproveReturn>> approvals;
  final bool applied;
  final BigInt? latestCode;
  final BuBytes? latestRet;

  FilMultisigOneShotResult({
    required this.txnId,
    required this.propose,
    required this.approvals,
    required this.applied,
    required this.latestCode,
    required List<int>? latestRet,
  }) : latestRet = latestRet?.asImmutableBytes;

  @override
  String toString() =>
      'FilMultisigOneShotResult(txnId=$txnId, applied=$applied, '
      'approvals=${approvals.length}, latestCode=$latestCode)';
}

class TxResultWithMessageId<T extends Object?> {
  final FilSignedMessage message;
  final T result;
  final BuBytes? rawData;
  final Cid messageId;
  TxResultWithMessageId({
    required this.message,
    required this.result,
    required List<int>? rawData,
    required this.messageId,
  }) : rawData = rawData?.asImmutableBytes;
}
