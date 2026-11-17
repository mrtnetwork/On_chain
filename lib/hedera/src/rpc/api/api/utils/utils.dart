import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/models.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/rpc/models/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

class HederaClientUtils {
  static bool queryPaymentRequired(IHederaQuery query) {
    {
      return switch (query) {
        HederaCryptoGetAccountBalanceQuery() => false,
        HederaTransactionGetReceiptQuery() => false,
        _ => true,
      };
    }
  }

  static DefaultHederaProtoTypeUrl getQueryServiceTypeUrl(IHederaQuery type) {
    return switch (type) {
      HederaGetBySolidityIDQuery() =>
        DefaultHederaProtoTypeUrl
            .protoServiceSmartContractServiceGetBySolidityID,

      HederaContractCallLocalQuery() =>
        DefaultHederaProtoTypeUrl
            .protoServiceSmartContractServiceContractCallLocalMethod,

      HederaContractGetInfoQuery() =>
        DefaultHederaProtoTypeUrl
            .protoServiceSmartContractServiceGetContractInfo,

      HederaContractGetBytecodeQuery() =>
        DefaultHederaProtoTypeUrl
            .protoServiceSmartContractServiceContractGetBytecode,

      HederaContractGetRecordsQuery() =>
        DefaultHederaProtoTypeUrl
            .protoServiceSmartContractServiceGetTxRecordByContractID,

      HederaCryptoGetAccountBalanceQuery() =>
        DefaultHederaProtoTypeUrl.protoServiceCryptoServiceCryptoGetBalance,

      HederaCryptoGetAccountRecordsQuery() =>
        DefaultHederaProtoTypeUrl.protoServiceCryptoServiceGetAccountRecords,

      HederaCryptoGetInfoQuery() =>
        DefaultHederaProtoTypeUrl.protoServiceCryptoServiceGetAccountInfo,

      HederaCryptoGetLiveHashQuery() =>
        DefaultHederaProtoTypeUrl.protoServiceCryptoServiceGetLiveHash,

      HederaFileGetContentsQuery() =>
        DefaultHederaProtoTypeUrl.protoServiceFileServiceGetFileContent,

      HederaFileGetInfoQuery() =>
        DefaultHederaProtoTypeUrl.protoServiceFileServiceGetFileInfo,

      HederaTransactionGetReceiptQuery() =>
        DefaultHederaProtoTypeUrl
            .protoServiceCryptoServiceGetTransactionReceipts,

      HederaTransactionGetRecordQuery() =>
        DefaultHederaProtoTypeUrl.protoServiceCryptoServiceGetTxRecordByTxID,

      HederaConsensusGetTopicInfoQuery() =>
        DefaultHederaProtoTypeUrl.protoServiceConsensusServiceGetTopicInfo,

      HederaNetworkGetVersionInfoQuery() =>
        DefaultHederaProtoTypeUrl.protoServiceNetworkServiceGetVersionInfo,

      HederaNetworkGetExecutionTimeQuery() =>
        DefaultHederaProtoTypeUrl.protoServiceNetworkServiceGetExecutionTime,

      HederaGetAccountDetailsQuery() =>
        DefaultHederaProtoTypeUrl.protoServiceNetworkServiceGetAccountDetails,

      HederaTokenGetInfoQuery() =>
        DefaultHederaProtoTypeUrl.protoServiceTokenServiceGetTokenInfo,

      HederaTokenGetNftInfoQuery() =>
        DefaultHederaProtoTypeUrl.protoServiceTokenServiceGetTokenNftInfo,

      HederaScheduleGetInfoQuery() =>
        DefaultHederaProtoTypeUrl.protoServiceScheduleServiceGetScheduleInfo,

      _ =>
        throw OnChainErrors.hederaPlugin(
          "getQueryServiceTypeUrl",
          reason: "Unsupported query type: ${type.declarationId.typeUrl}",
        ),
    };
  }

  static IHederaQueryRespone? extractQueryResponse(
    IHederaQuery query,
    HederaResponse response,
  ) {
    return switch (query) {
      HederaGetByKeyQuery() => response.getByKey,
      HederaGetBySolidityIDQuery() => response.getBySolidityID,
      HederaContractCallLocalQuery() => response.contractCallLocal,
      HederaContractGetInfoQuery() => response.contractGetInfo,
      HederaContractGetBytecodeQuery() => response.contractGetBytecodeResponse,
      HederaContractGetRecordsQuery() => response.contractGetRecordsResponse,
      HederaCryptoGetAccountBalanceQuery() => response.cryptogetAccountBalance,
      HederaCryptoGetAccountRecordsQuery() => response.cryptoGetAccountRecords,
      HederaCryptoGetInfoQuery() => response.cryptoGetInfo,
      HederaCryptoGetLiveHashQuery() => response.cryptoGetLiveHash,
      HederaCryptoGetStakersQuery() => response.cryptoGetProxyStakers,
      HederaFileGetContentsQuery() => response.fileGetContents,
      HederaFileGetInfoQuery() => response.fileGetInfo,
      HederaTransactionGetReceiptQuery() => response.transactionGetReceipt,
      HederaTransactionGetRecordQuery() => response.transactionGetRecord,
      HederaTransactionGetFastRecordQuery() =>
        response.transactionGetFastRecord,
      HederaConsensusGetTopicInfoQuery() => response.consensusGetTopicInfo,
      HederaNetworkGetVersionInfoQuery() => response.networkGetVersionInfo,
      HederaTokenGetInfoQuery() => response.tokenGetInfo,
      HederaScheduleGetInfoQuery() => response.scheduleGetInfo,
      HederaTokenGetAccountNftInfosQuery() => response.tokenGetAccountNftInfos,
      HederaTokenGetNftInfoQuery() => response.tokenGetNftInfo,
      HederaTokenGetNftInfosQuery() => response.tokenGetNftInfos,
      HederaNetworkGetExecutionTimeQuery() => response.networkGetExecutionTime,
      HederaGetAccountDetailsQuery() => response.accountDetails,

      _ =>
        throw OnChainErrors.hederaPlugin(
          "getQueryServiceTypeUrl",
          reason: "Unsupported query type: ${query.declarationId.typeUrl}",
        ),
    };
  }

  static List<int>? _mirrorHexKey(String key, {int? minLength}) {
    final bytes = BytesUtils.tryFromHexString(key);
    if (bytes != null) {
      if (minLength == null || bytes.length == minLength) return bytes;
    }
    return null;
  }

  static List<int>? _mirrorBase32Key(String key, {int? minLength}) {
    try {
      final bytes = Base32Decoder.decode(key);
      if (minLength == null || bytes.length == minLength) return bytes;
    } catch (_) {}
    return null;
  }

  static List<int>? _mirrorKeyAsBytes(String key, {int? minLength}) {
    return _mirrorHexKey(key, minLength: minLength) ??
        _mirrorBase32Key(key, minLength: minLength);
  }

  static HederaKey? hederaMirrorTypesKeyToHederaKey(
    HederaMirrorTypesKey mirroKey,
  ) {
    final key = mirroKey.key;
    final type = mirroKey.type;
    if (key == null || type == null || key.trim().isEmpty) return null;
    if (type == HederaMirrorTypesKeyType.eCDSASECP256K1) {
      final bytes = _mirrorKeyAsBytes(
        key,
        minLength: EcdsaKeysConst.pubKeyCompressedByteLen,
      );
      if (bytes?.length == EcdsaKeysConst.pubKeyCompressedByteLen ||
          bytes?.length == EcdsaKeysConst.pubKeyUncompressedByteLen) {
        return HederaKey(ecdsaSecp256k1: bytes);
      }
    } else if (type == HederaMirrorTypesKeyType.eD25519) {
      final bytes = _mirrorKeyAsBytes(
        key,
        minLength: Ed25519KeysConst.pubKeyByteLen,
      );
      if (bytes?.length == Ed25519KeysConst.pubKeyByteLen) {
        return HederaKey(ed25519: bytes);
      }
    } else {
      final bytes = _mirrorKeyAsBytes(
        key,
        minLength: Ed25519KeysConst.pubKeyByteLen,
      );
      if (bytes != null) {
        try {
          return HederaKey.deserialize(bytes);
        } catch (_) {}
      }
    }
    return null;
  }

  /// Maps a [HederaTransactionBody] to the correct HAPI gRPC service message.
  ///
  /// Each consensus service method expects the signed [HederaTransaction] on a
  /// dedicated RPC wrapper (CryptoService, TokenService, …). Submitting every
  /// body through CryptoTransfer is incorrect and will fail precheck for
  /// non-transfer operations.
  static IHederaServiceMessage<HederaTransactionResponse>
  hederaServiceMessageForTransaction({
    required HederaTransaction transaction,
    required HederaTransactionBody body,
  }) {
    // ── Crypto ───────────────────────────────────────────────────────────────
    if (body.cryptoTransfer != null) {
      return HederaServiceCryptoServiceCryptoTransfer(
        cryptoTransfer: transaction,
      );
    }
    if (body.cryptoCreateAccount != null) {
      return HederaServiceCryptoServiceCreateAccount(
        createAccount: transaction,
      );
    }
    if (body.cryptoUpdateAccount != null) {
      return HederaServiceCryptoServiceUpdateAccount(
        updateAccount: transaction,
      );
    }
    if (body.cryptoDelete != null) {
      return HederaServiceCryptoServiceCryptoDelete(cryptoDelete: transaction);
    }
    if (body.cryptoApproveAllowance != null) {
      return HederaServiceCryptoServiceApproveAllowances(
        approveAllowances: transaction,
      );
    }
    if (body.cryptoDeleteAllowance != null) {
      return HederaServiceCryptoServiceDeleteAllowances(
        deleteAllowances: transaction,
      );
    }
    if (body.cryptoAddLiveHash != null) {
      return HederaServiceCryptoServiceAddLiveHash(addLiveHash: transaction);
    }
    if (body.cryptoDeleteLiveHash != null) {
      return HederaServiceCryptoServiceDeleteLiveHash(
        deleteLiveHash: transaction,
      );
    }

    // ── Smart contract ───────────────────────────────────────────────────────
    if (body.contractCall != null) {
      return HederaServiceSmartContractServiceContractCallMethod(
        contractCallMethod: transaction,
      );
    }
    if (body.contractCreateInstance != null) {
      return HederaServiceSmartContractServiceCreateContract(
        createContract: transaction,
      );
    }
    if (body.contractUpdateInstance != null) {
      return HederaServiceSmartContractServiceUpdateContract(
        updateContract: transaction,
      );
    }
    if (body.contractDeleteInstance != null) {
      return HederaServiceSmartContractServiceDeleteContract(
        deleteContract: transaction,
      );
    }
    if (body.ethereumTransaction != null) {
      return HederaServiceSmartContractServiceCallEthereum(
        callEthereum: transaction,
      );
    }

    // ── File ─────────────────────────────────────────────────────────────────
    if (body.fileCreate != null) {
      return HederaServiceFileServiceCreateFile(createFile: transaction);
    }
    if (body.fileUpdate != null) {
      return HederaServiceFileServiceUpdateFile(updateFile: transaction);
    }
    if (body.fileDelete != null) {
      return HederaServiceFileServiceDeleteFile(deleteFile: transaction);
    }
    if (body.fileAppend != null) {
      return HederaServiceFileServiceAppendContent(appendContent: transaction);
    }

    // ── System delete / undelete (file or contract target) ───────────────────
    if (body.systemDelete != null) {
      final sd = body.systemDelete!;
      if (sd.contractID != null) {
        return HederaServiceSmartContractServiceSystemDelete(
          systemDelete: transaction,
        );
      }
      return HederaServiceFileServiceSystemDelete(systemDelete: transaction);
    }
    if (body.systemUndelete != null) {
      final su = body.systemUndelete!;
      if (su.contractID != null) {
        return HederaServiceSmartContractServiceSystemUndelete(
          systemUndelete: transaction,
        );
      }
      return HederaServiceFileServiceSystemUndelete(
        systemUndelete: transaction,
      );
    }

    // ── Consensus ────────────────────────────────────────────────────────────
    if (body.consensusCreateTopic != null) {
      return HederaServiceConsensusServiceCreateTopic(createTopic: transaction);
    }
    if (body.consensusUpdateTopic != null) {
      return HederaServiceConsensusServiceUpdateTopic(updateTopic: transaction);
    }
    if (body.consensusDeleteTopic != null) {
      return HederaServiceConsensusServiceDeleteTopic(deleteTopic: transaction);
    }
    if (body.consensusSubmitMessage != null) {
      return HederaServiceConsensusServiceSubmitMessage(
        submitMessage: transaction,
      );
    }

    // ── Token ────────────────────────────────────────────────────────────────
    if (body.tokenCreation != null) {
      return HederaServiceTokenServiceCreateToken(createToken: transaction);
    }
    if (body.tokenUpdate != null) {
      return HederaServiceTokenServiceUpdateToken(updateToken: transaction);
    }
    if (body.tokenMint != null) {
      return HederaServiceTokenServiceMintToken(mintToken: transaction);
    }
    if (body.tokenBurn != null) {
      return HederaServiceTokenServiceBurnToken(burnToken: transaction);
    }
    if (body.tokenDeletion != null) {
      return HederaServiceTokenServiceDeleteToken(deleteToken: transaction);
    }
    if (body.tokenWipe != null) {
      return HederaServiceTokenServiceWipeTokenAccount(
        wipeTokenAccount: transaction,
      );
    }
    if (body.tokenFreeze != null) {
      return HederaServiceTokenServiceFreezeTokenAccount(
        freezeTokenAccount: transaction,
      );
    }
    if (body.tokenUnfreeze != null) {
      return HederaServiceTokenServiceUnfreezeTokenAccount(
        unfreezeTokenAccount: transaction,
      );
    }
    if (body.tokenGrantKyc != null) {
      return HederaServiceTokenServiceGrantKycToTokenAccount(
        grantKycToTokenAccount: transaction,
      );
    }
    if (body.tokenRevokeKyc != null) {
      return HederaServiceTokenServiceRevokeKycFromTokenAccount(
        revokeKycFromTokenAccount: transaction,
      );
    }
    if (body.tokenAssociate != null) {
      return HederaServiceTokenServiceAssociateTokens(
        associateTokens: transaction,
      );
    }
    if (body.tokenDissociate != null) {
      return HederaServiceTokenServiceDissociateTokens(
        dissociateTokens: transaction,
      );
    }
    if (body.tokenFeeScheduleUpdate != null) {
      return HederaServiceTokenServiceUpdateTokenFeeSchedule(
        updateTokenFeeSchedule: transaction,
      );
    }
    if (body.tokenPause != null) {
      return HederaServiceTokenServicePauseToken(pauseToken: transaction);
    }
    if (body.tokenUnpause != null) {
      return HederaServiceTokenServiceUnpauseToken(unpauseToken: transaction);
    }
    if (body.tokenUpdateNfts != null) {
      return HederaServiceTokenServiceUpdateNfts(updateNfts: transaction);
    }
    if (body.tokenReject != null) {
      return HederaServiceTokenServiceRejectToken(rejectToken: transaction);
    }
    if (body.tokenAirdrop != null) {
      return HederaServiceTokenServiceAirdropTokens(airdropTokens: transaction);
    }
    if (body.tokenCancelAirdrop != null) {
      return HederaServiceTokenServiceCancelAirdrop(cancelAirdrop: transaction);
    }
    if (body.tokenClaimAirdrop != null) {
      return HederaServiceTokenServiceClaimAirdrop(claimAirdrop: transaction);
    }

    // ── Schedule ─────────────────────────────────────────────────────────────
    if (body.scheduleCreate != null) {
      return HederaServiceScheduleServiceCreateSchedule(
        createSchedule: transaction,
      );
    }
    if (body.scheduleSign != null) {
      return HederaServiceScheduleServiceSignSchedule(
        signSchedule: transaction,
      );
    }
    if (body.scheduleDelete != null) {
      return HederaServiceScheduleServiceDeleteSchedule(
        deleteSchedule: transaction,
      );
    }

    // ── Freeze / network ─────────────────────────────────────────────────────
    if (body.freeze != null) {
      return HederaServiceFreezeServiceFreeze(freeze: transaction);
    }
    if (body.uncheckedSubmit != null) {
      return HederaServiceNetworkServiceUncheckedSubmit(
        uncheckedSubmit: transaction,
      );
    }

    // ── Hooks ────────────────────────────────────────────────────────────────
    if (body.hookStore != null) {
      return HederaServiceSmartContractServiceHookStore(hookStore: transaction);
    }

    // utilPrng / other bodies without a dedicated generated service wrapper:
    // no UtilService* class is present in generated protos — surface a clear error.
    throw OnChainErrors.hederaPlugin(
      "hederaServiceMessageForTransaction",
      reason: "No HAPI service mapping for this transaction body.",
      details: {'body': '${body.runtimeType}'},
    );
  }
}
