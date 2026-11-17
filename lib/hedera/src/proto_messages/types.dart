import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

enum DefaultHederaProtoTypeUrl implements HederaProtoTypeUrl {
  comHederaHapiBlockStreamBlockProof(
    typeUrl: '/com.hedera.hapi.block.stream.BlockProof',
  ),
  comHederaHapiBlockStreamMerkleSiblingHash(
    typeUrl: '/com.hedera.hapi.block.stream.MerkleSiblingHash',
  ),
  comHederaHapiBlockStreamBlock(typeUrl: '/com.hedera.hapi.block.stream.Block'),
  comHederaHapiBlockStreamRecordFileItem(
    typeUrl: '/com.hedera.hapi.block.stream.RecordFileItem',
  ),
  comHederaHapiBlockStreamRecordFileSignature(
    typeUrl: '/com.hedera.hapi.block.stream.RecordFileSignature',
  ),
  comHederaHapiBlockStreamBlockItem(
    typeUrl: '/com.hedera.hapi.block.stream.BlockItem',
  ),
  comHederaHapiBlockStreamFilteredItemHash(
    typeUrl: '/com.hedera.hapi.block.stream.FilteredItemHash',
  ),
  comHederaHapiBlockStreamInputEventHeader(
    typeUrl: '/com.hedera.hapi.block.stream.input.EventHeader',
  ),
  comHederaHapiBlockStreamInputParentEventReference(
    typeUrl: '/com.hedera.hapi.block.stream.input.ParentEventReference',
  ),
  comHederaHapiBlockStreamInputRoundHeader(
    typeUrl: '/com.hedera.hapi.block.stream.input.RoundHeader',
  ),
  comHederaHapiBlockStreamOutputAppendFileOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.AppendFileOutput',
  ),
  comHederaHapiBlockStreamOutputCreateFileOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.CreateFileOutput',
  ),
  comHederaHapiBlockStreamOutputDeleteFileOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.DeleteFileOutput',
  ),
  comHederaHapiBlockStreamOutputUpdateFileOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.UpdateFileOutput',
  ),
  comHederaHapiBlockStreamOutputSystemDeleteOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.SystemDeleteOutput',
  ),
  comHederaHapiBlockStreamOutputSystemUndeleteOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.SystemUndeleteOutput',
  ),
  comHederaHapiBlockStreamOutputTransactionOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.TransactionOutput',
  ),
  comHederaHapiBlockStreamOutputUtilPrngOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.UtilPrngOutput',
  ),
  comHederaHapiBlockStreamOutputCreateTopicOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.CreateTopicOutput',
  ),
  comHederaHapiBlockStreamOutputUpdateTopicOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.UpdateTopicOutput',
  ),
  comHederaHapiBlockStreamOutputDeleteTopicOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.DeleteTopicOutput',
  ),
  comHederaHapiBlockStreamOutputSubmitMessageOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.SubmitMessageOutput',
  ),
  comHederaHapiBlockStreamOutputUpdateNodeStakeOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.UpdateNodeStakeOutput',
  ),
  comHederaHapiBlockStreamOutputFreezeOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.FreezeOutput',
  ),
  comHederaHapiBlockStreamOutputCreateTokenOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.CreateTokenOutput',
  ),
  comHederaHapiBlockStreamOutputFreezeTokenAccountOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.FreezeTokenAccountOutput',
  ),
  comHederaHapiBlockStreamOutputUnfreezeTokenAccountOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.UnfreezeTokenAccountOutput',
  ),
  comHederaHapiBlockStreamOutputGrantTokenKycOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.GrantTokenKycOutput',
  ),
  comHederaHapiBlockStreamOutputRevokeTokenKycOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.RevokeTokenKycOutput',
  ),
  comHederaHapiBlockStreamOutputDeleteTokenOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.DeleteTokenOutput',
  ),
  comHederaHapiBlockStreamOutputUpdateTokenOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.UpdateTokenOutput',
  ),
  comHederaHapiBlockStreamOutputMintTokenOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.MintTokenOutput',
  ),
  comHederaHapiBlockStreamOutputBurnTokenOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.BurnTokenOutput',
  ),
  comHederaHapiBlockStreamOutputWipeTokenAccountOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.WipeTokenAccountOutput',
  ),
  comHederaHapiBlockStreamOutputAssociateTokenOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.AssociateTokenOutput',
  ),
  comHederaHapiBlockStreamOutputDissociateTokenOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.DissociateTokenOutput',
  ),
  comHederaHapiBlockStreamOutputUpdateTokenFeeScheduleOutput(
    typeUrl:
        '/com.hedera.hapi.block.stream.output.UpdateTokenFeeScheduleOutput',
  ),
  comHederaHapiBlockStreamOutputPauseTokenOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.PauseTokenOutput',
  ),
  comHederaHapiBlockStreamOutputUnpauseTokenOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.UnpauseTokenOutput',
  ),
  comHederaHapiBlockStreamOutputUpdateTokenNftsOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.UpdateTokenNftsOutput',
  ),
  comHederaHapiBlockStreamOutputTokenAirdropOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.TokenAirdropOutput',
  ),
  comHederaHapiBlockStreamOutputCreateScheduleOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.CreateScheduleOutput',
  ),
  comHederaHapiBlockStreamOutputDeleteScheduleOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.DeleteScheduleOutput',
  ),
  comHederaHapiBlockStreamOutputSignScheduleOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.SignScheduleOutput',
  ),
  comHederaHapiBlockStreamOutputTransactionResult(
    typeUrl: '/com.hedera.hapi.block.stream.output.TransactionResult',
  ),
  comHederaHapiBlockStreamOutputCallContractOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.CallContractOutput',
  ),
  comHederaHapiBlockStreamOutputCreateContractOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.CreateContractOutput',
  ),
  comHederaHapiBlockStreamOutputUpdateContractOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.UpdateContractOutput',
  ),
  comHederaHapiBlockStreamOutputDeleteContractOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.DeleteContractOutput',
  ),
  comHederaHapiBlockStreamOutputSystemUnDeleteContractOutput(
    typeUrl:
        '/com.hedera.hapi.block.stream.output.SystemUnDeleteContractOutput',
  ),
  comHederaHapiBlockStreamOutputSystemDeleteContractOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.SystemDeleteContractOutput',
  ),
  comHederaHapiBlockStreamOutputEthereumOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.EthereumOutput',
  ),
  comHederaHapiBlockStreamOutputApproveAllowanceOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.ApproveAllowanceOutput',
  ),
  comHederaHapiBlockStreamOutputDeleteAllowanceOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.DeleteAllowanceOutput',
  ),
  comHederaHapiBlockStreamOutputCreateAccountOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.CreateAccountOutput',
  ),
  comHederaHapiBlockStreamOutputDeleteAccountOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.DeleteAccountOutput',
  ),
  comHederaHapiBlockStreamOutputCryptoTransferOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.CryptoTransferOutput',
  ),
  comHederaHapiBlockStreamOutputUpdateAccountOutput(
    typeUrl: '/com.hedera.hapi.block.stream.output.UpdateAccountOutput',
  ),
  comHederaHapiBlockStreamOutputBlockHeader(
    typeUrl: '/com.hedera.hapi.block.stream.output.BlockHeader',
  ),
  comHederaHapiBlockStreamOutputStateChanges(
    typeUrl: '/com.hedera.hapi.block.stream.output.StateChanges',
  ),
  comHederaHapiBlockStreamOutputStateChange(
    typeUrl: '/com.hedera.hapi.block.stream.output.StateChange',
  ),
  comHederaHapiBlockStreamOutputNewStateChange(
    typeUrl: '/com.hedera.hapi.block.stream.output.NewStateChange',
  ),
  comHederaHapiBlockStreamOutputRemovedStateChange(
    typeUrl: '/com.hedera.hapi.block.stream.output.RemovedStateChange',
  ),
  comHederaHapiBlockStreamOutputSingletonUpdateChange(
    typeUrl: '/com.hedera.hapi.block.stream.output.SingletonUpdateChange',
  ),
  comHederaHapiBlockStreamOutputMapUpdateChange(
    typeUrl: '/com.hedera.hapi.block.stream.output.MapUpdateChange',
  ),
  comHederaHapiBlockStreamOutputMapDeleteChange(
    typeUrl: '/com.hedera.hapi.block.stream.output.MapDeleteChange',
  ),
  comHederaHapiBlockStreamOutputMapChangeKey(
    typeUrl: '/com.hedera.hapi.block.stream.output.MapChangeKey',
  ),
  comHederaHapiBlockStreamOutputMapChangeValue(
    typeUrl: '/com.hedera.hapi.block.stream.output.MapChangeValue',
  ),
  comHederaHapiBlockStreamOutputQueuePushChange(
    typeUrl: '/com.hedera.hapi.block.stream.output.QueuePushChange',
  ),
  comHederaHapiBlockStreamOutputQueuePopChange(
    typeUrl: '/com.hedera.hapi.block.stream.output.QueuePopChange',
  ),
  comHederaHapiBlockPublishStreamRequest(
    typeUrl: '/com.hedera.hapi.block.PublishStreamRequest',
  ),
  comHederaHapiBlockBlockItemSet(
    typeUrl: '/com.hedera.hapi.block.BlockItemSet',
  ),
  comHederaHapiBlockPublishStreamResponse(
    typeUrl: '/com.hedera.hapi.block.PublishStreamResponse',
  ),
  comHederaHapiBlockPublishStreamResponseAcknowledgement(
    typeUrl: '/com.hedera.hapi.block.PublishStreamResponse.Acknowledgement',
  ),
  comHederaHapiBlockPublishStreamResponseBlockAcknowledgement(
    typeUrl:
        '/com.hedera.hapi.block.PublishStreamResponse.BlockAcknowledgement',
  ),
  comHederaHapiBlockPublishStreamResponseSkipBlock(
    typeUrl: '/com.hedera.hapi.block.PublishStreamResponse.SkipBlock',
  ),
  comHederaHapiBlockPublishStreamResponseResendBlock(
    typeUrl: '/com.hedera.hapi.block.PublishStreamResponse.ResendBlock',
  ),
  comHederaHapiBlockPublishStreamResponseEndOfStream(
    typeUrl: '/com.hedera.hapi.block.PublishStreamResponse.EndOfStream',
  ),
  comHederaHapiBlockSingleBlockRequest(
    typeUrl: '/com.hedera.hapi.block.SingleBlockRequest',
  ),
  comHederaHapiBlockSingleBlockResponse(
    typeUrl: '/com.hedera.hapi.block.SingleBlockResponse',
  ),
  comHederaHapiBlockSubscribeStreamRequest(
    typeUrl: '/com.hedera.hapi.block.SubscribeStreamRequest',
  ),
  comHederaHapiBlockSubscribeStreamResponse(
    typeUrl: '/com.hedera.hapi.block.SubscribeStreamResponse',
  ),
  comHederaHapiBlockStateSnapshotRequest(
    typeUrl: '/com.hedera.hapi.block.StateSnapshotRequest',
  ),
  comHederaHapiBlockStateSnapshotResponse(
    typeUrl: '/com.hedera.hapi.block.StateSnapshotResponse',
  ),
  comHederaHapiBlockServerStatusRequest(
    typeUrl: '/com.hedera.hapi.block.ServerStatusRequest',
  ),
  comHederaHapiBlockServerStatusResponse(
    typeUrl: '/com.hedera.hapi.block.ServerStatusResponse',
  ),
  comHederaHapiBlockBlockNodeVersions(
    typeUrl: '/com.hedera.hapi.block.BlockNodeVersions',
  ),
  comHederaHapiPlatformEventEventDescriptor(
    typeUrl: '/com.hedera.hapi.platform.event.EventDescriptor',
  ),
  comHederaHapiPlatformEventEventTransaction(
    typeUrl: '/com.hedera.hapi.platform.event.EventTransaction',
  ),
  comHederaHapiPlatformEventGossipEvent(
    typeUrl: '/com.hedera.hapi.platform.event.GossipEvent',
  ),
  comHederaHapiPlatformEventStateSignatureTransaction(
    typeUrl: '/com.hedera.hapi.platform.event.StateSignatureTransaction',
  ),
  comHederaHapiPlatformEventEventCore(
    typeUrl: '/com.hedera.hapi.platform.event.EventCore',
  ),
  comHederaHapiPlatformEventEventConsensusData(
    typeUrl: '/com.hedera.hapi.platform.event.EventConsensusData',
  ),
  comHederaHapiPlatformStatePlatformState(
    typeUrl: '/com.hedera.hapi.platform.state.PlatformState',
  ),
  comHederaHapiPlatformStateConsensusSnapshot(
    typeUrl: '/com.hedera.hapi.platform.state.ConsensusSnapshot',
  ),
  comHederaHapiPlatformStateJudgeId(
    typeUrl: '/com.hedera.hapi.platform.state.JudgeId',
  ),
  comHederaHapiPlatformStateMinimumJudgeInfo(
    typeUrl: '/com.hedera.hapi.platform.state.MinimumJudgeInfo',
  ),
  comHederaHapiPlatformStateNodeId(
    typeUrl: '/com.hedera.hapi.platform.state.NodeId',
  ),
  protoTransactionList(typeUrl: '/proto.TransactionList'),
  protoConsensusDeleteTopicTransactionBody(
    typeUrl: '/proto.ConsensusDeleteTopicTransactionBody',
  ),
  protoCryptoCreateTransactionBody(
    typeUrl: '/proto.CryptoCreateTransactionBody',
  ),
  protoCryptoGetAccountBalanceQuery(
    typeUrl: '/proto.CryptoGetAccountBalanceQuery',
  ),
  protoCryptoGetAccountBalanceResponse(
    typeUrl: '/proto.CryptoGetAccountBalanceResponse',
  ),
  protoFreezeTransactionBody(typeUrl: '/proto.FreezeTransactionBody'),
  protoNetworkGetExecutionTimeQuery(
    typeUrl: '/proto.NetworkGetExecutionTimeQuery',
  ),
  protoNetworkGetExecutionTimeResponse(
    typeUrl: '/proto.NetworkGetExecutionTimeResponse',
  ),
  protoConsensusCreateTopicTransactionBody(
    typeUrl: '/proto.ConsensusCreateTopicTransactionBody',
  ),
  protoDuration(typeUrl: '/proto.Duration'),
  protoContractUpdateTransactionBody(
    typeUrl: '/proto.ContractUpdateTransactionBody',
  ),
  protoCryptoGetAccountRecordsQuery(
    typeUrl: '/proto.CryptoGetAccountRecordsQuery',
  ),
  protoCryptoGetAccountRecordsResponse(
    typeUrl: '/proto.CryptoGetAccountRecordsResponse',
  ),
  protoSchedulableTransactionBody(typeUrl: '/proto.SchedulableTransactionBody'),
  protoGetByKeyQuery(typeUrl: '/proto.GetByKeyQuery'),
  protoEntityID(typeUrl: '/proto.EntityID'),
  protoGetByKeyResponse(typeUrl: '/proto.GetByKeyResponse'),
  protoTokenUnfreezeAccountTransactionBody(
    typeUrl: '/proto.TokenUnfreezeAccountTransactionBody',
  ),
  protoInternalCallContext(typeUrl: '/proto.InternalCallContext'),
  protoEvmTransactionResult(typeUrl: '/proto.EvmTransactionResult'),
  protoContractNonceInfo(typeUrl: '/proto.ContractNonceInfo'),
  protoContractLoginfo(typeUrl: '/proto.ContractLoginfo'),
  protoContractFunctionResult(typeUrl: '/proto.ContractFunctionResult'),
  protoUncheckedSubmitBody(typeUrl: '/proto.UncheckedSubmitBody'),
  protoTokenGetAccountNftInfosQuery(
    typeUrl: '/proto.TokenGetAccountNftInfosQuery',
  ),
  protoTokenGetAccountNftInfosResponse(
    typeUrl: '/proto.TokenGetAccountNftInfosResponse',
  ),
  protoTransactionResponse(typeUrl: '/proto.TransactionResponse'),
  protoCryptoDeleteAllowanceTransactionBody(
    typeUrl: '/proto.CryptoDeleteAllowanceTransactionBody',
  ),
  protoNftRemoveAllowance(typeUrl: '/proto.NftRemoveAllowance'),
  protoTokenDeleteTransactionBody(typeUrl: '/proto.TokenDeleteTransactionBody'),
  protoSystemDeleteTransactionBody(
    typeUrl: '/proto.SystemDeleteTransactionBody',
  ),
  protoTokenUpdateTransactionBody(typeUrl: '/proto.TokenUpdateTransactionBody'),
  protoCryptoGetLiveHashQuery(typeUrl: '/proto.CryptoGetLiveHashQuery'),
  protoCryptoGetLiveHashResponse(typeUrl: '/proto.CryptoGetLiveHashResponse'),
  protoTokenFreezeAccountTransactionBody(
    typeUrl: '/proto.TokenFreezeAccountTransactionBody',
  ),
  protoGetBySolidityIDQuery(typeUrl: '/proto.GetBySolidityIDQuery'),
  protoGetBySolidityIDResponse(typeUrl: '/proto.GetBySolidityIDResponse'),
  protoTokenGrantKycTransactionBody(
    typeUrl: '/proto.TokenGrantKycTransactionBody',
  ),
  protoTransactionRecord(typeUrl: '/proto.TransactionRecord'),
  protoPendingAirdropRecord(typeUrl: '/proto.PendingAirdropRecord'),
  protoTokenWipeAccountTransactionBody(
    typeUrl: '/proto.TokenWipeAccountTransactionBody',
  ),
  protoResponseHeader(typeUrl: '/proto.ResponseHeader'),
  protoCryptoDeleteLiveHashTransactionBody(
    typeUrl: '/proto.CryptoDeleteLiveHashTransactionBody',
  ),
  protoTokenRejectTransactionBody(typeUrl: '/proto.TokenRejectTransactionBody'),
  protoTokenReference(typeUrl: '/proto.TokenReference'),
  protoTokenAssociateTransactionBody(
    typeUrl: '/proto.TokenAssociateTransactionBody',
  ),
  protoConsensusUpdateTopicTransactionBody(
    typeUrl: '/proto.ConsensusUpdateTopicTransactionBody',
  ),
  protoTokenGetNftInfoQuery(typeUrl: '/proto.TokenGetNftInfoQuery'),
  protoTokenNftInfo(typeUrl: '/proto.TokenNftInfo'),
  protoTokenGetNftInfoResponse(typeUrl: '/proto.TokenGetNftInfoResponse'),
  protoTokenUpdateNftsTransactionBody(
    typeUrl: '/proto.TokenUpdateNftsTransactionBody',
  ),
  protoShardID(typeUrl: '/proto.ShardID'),
  protoRealmID(typeUrl: '/proto.RealmID'),
  protoTokenID(typeUrl: '/proto.TokenID'),
  protoAccountID(typeUrl: '/proto.AccountID'),
  protoNftID(typeUrl: '/proto.NftID'),
  protoFileID(typeUrl: '/proto.FileID'),
  protoContractID(typeUrl: '/proto.ContractID'),
  protoTopicID(typeUrl: '/proto.TopicID'),
  protoScheduleID(typeUrl: '/proto.ScheduleID'),
  protoTransactionID(typeUrl: '/proto.TransactionID'),
  protoHookId(typeUrl: '/proto.HookId'),
  protoHookEntityId(typeUrl: '/proto.HookEntityId'),
  protoHookCall(typeUrl: '/proto.HookCall'),
  protoEvmHookCall(typeUrl: '/proto.EvmHookCall'),
  protoAccountAmount(typeUrl: '/proto.AccountAmount'),
  protoTransferList(typeUrl: '/proto.TransferList'),
  protoNftTransfer(typeUrl: '/proto.NftTransfer'),
  protoTokenTransferList(typeUrl: '/proto.TokenTransferList'),
  protoFraction(typeUrl: '/proto.Fraction'),
  protoKey(typeUrl: '/proto.Key'),
  protoThresholdKey(typeUrl: '/proto.ThresholdKey'),
  protoKeyList(typeUrl: '/proto.KeyList'),
  protoSignature(typeUrl: '/proto.Signature'),
  protoThresholdSignature(typeUrl: '/proto.ThresholdSignature'),
  protoSignatureList(typeUrl: '/proto.SignatureList'),
  protoSignaturePair(typeUrl: '/proto.SignaturePair'),
  protoSignatureMap(typeUrl: '/proto.SignatureMap'),
  protoFeeComponents(typeUrl: '/proto.FeeComponents'),
  protoTransactionFeeSchedule(typeUrl: '/proto.TransactionFeeSchedule'),
  protoFeeData(typeUrl: '/proto.FeeData'),
  protoFeeSchedule(typeUrl: '/proto.FeeSchedule'),
  protoCurrentAndNextFeeSchedule(typeUrl: '/proto.CurrentAndNextFeeSchedule'),
  protoServiceEndpoint(typeUrl: '/proto.ServiceEndpoint'),
  protoNodeAddress(typeUrl: '/proto.NodeAddress'),
  protoNodeAddressBook(typeUrl: '/proto.NodeAddressBook'),
  protoSemanticVersion(typeUrl: '/proto.SemanticVersion'),
  protoSetting(typeUrl: '/proto.Setting'),
  protoServicesConfigurationList(typeUrl: '/proto.ServicesConfigurationList'),
  protoTokenRelationship(typeUrl: '/proto.TokenRelationship'),
  protoTokenBalance(typeUrl: '/proto.TokenBalance'),
  protoTokenBalances(typeUrl: '/proto.TokenBalances'),
  protoTokenAssociation(typeUrl: '/proto.TokenAssociation'),
  protoAccountTokenAssociation(typeUrl: '/proto.AccountTokenAssociation'),
  protoStakingInfo(typeUrl: '/proto.StakingInfo'),
  protoPendingAirdropId(typeUrl: '/proto.PendingAirdropId'),
  protoPendingAirdropValue(typeUrl: '/proto.PendingAirdropValue'),
  protoScheduleCreateTransactionBody(
    typeUrl: '/proto.ScheduleCreateTransactionBody',
  ),
  protoScheduleGetInfoQuery(typeUrl: '/proto.ScheduleGetInfoQuery'),
  protoScheduleInfo(typeUrl: '/proto.ScheduleInfo'),
  protoScheduleGetInfoResponse(typeUrl: '/proto.ScheduleGetInfoResponse'),
  protoLiveHash(typeUrl: '/proto.LiveHash'),
  protoCryptoAddLiveHashTransactionBody(
    typeUrl: '/proto.CryptoAddLiveHashTransactionBody',
  ),
  protoFileGetInfoQuery(typeUrl: '/proto.FileGetInfoQuery'),
  protoFileGetInfoResponse(typeUrl: '/proto.FileGetInfoResponse'),
  protoFileGetInfoResponseFileInfo(
    typeUrl: '/proto.FileGetInfoResponse.FileInfo',
  ),
  protoTokenClaimAirdropTransactionBody(
    typeUrl: '/proto.TokenClaimAirdropTransactionBody',
  ),
  protoUtilPrngTransactionBody(typeUrl: '/proto.UtilPrngTransactionBody'),
  protoTokenBurnTransactionBody(typeUrl: '/proto.TokenBurnTransactionBody'),
  protoCryptoGetInfoQuery(typeUrl: '/proto.CryptoGetInfoQuery'),
  protoCryptoGetInfoResponse(typeUrl: '/proto.CryptoGetInfoResponse'),
  protoCryptoGetInfoResponseAccountInfo(
    typeUrl: '/proto.CryptoGetInfoResponse.AccountInfo',
  ),
  protoTokenMintTransactionBody(typeUrl: '/proto.TokenMintTransactionBody'),
  protoTransaction(typeUrl: '/proto.Transaction'),
  protoTransactionBody(typeUrl: '/proto.TransactionBody'),
  protoAtomicBatchTransactionBody(typeUrl: '/proto.AtomicBatchTransactionBody'),
  protoServiceFileServiceCreateFile(
    typeUrl: '/proto.ServiceFileServiceCreateFile',
    serviceUrl: "/proto.FileService/createFile",
  ),
  protoServiceFileServiceUpdateFile(
    typeUrl: '/proto.ServiceFileServiceUpdateFile',
    serviceUrl: "/proto.FileService/updateFile",
  ),
  protoServiceFileServiceDeleteFile(
    typeUrl: '/proto.ServiceFileServiceDeleteFile',
    serviceUrl: "/proto.FileService/deleteFile",
  ),
  protoServiceFileServiceAppendContent(
    typeUrl: '/proto.ServiceFileServiceAppendContent',
    serviceUrl: "/proto.FileService/appendContent",
  ),
  protoServiceFileServiceSystemDelete(
    typeUrl: '/proto.ServiceFileServiceSystemDelete',
    serviceUrl: "/proto.FileService/systemDelete",
  ),
  protoServiceFileServiceSystemUndelete(
    typeUrl: '/proto.ServiceFileServiceSystemUndelete',
    serviceUrl: "/proto.FileService/systemUndelete",
  ),
  protoServiceConsensusServiceCreateTopic(
    typeUrl: '/proto.ServiceConsensusServiceCreateTopic',
    serviceUrl: "/proto.ConsensusService/createTopic",
  ),
  protoServiceConsensusServiceUpdateTopic(
    typeUrl: '/proto.ServiceConsensusServiceUpdateTopic',
    serviceUrl: "/proto.ConsensusService/updateTopic",
  ),
  protoServiceConsensusServiceDeleteTopic(
    typeUrl: '/proto.ServiceConsensusServiceDeleteTopic',
    serviceUrl: "/proto.ConsensusService/deleteTopic",
  ),
  protoServiceConsensusServiceSubmitMessage(
    typeUrl: '/proto.ServiceConsensusServiceSubmitMessage',
    serviceUrl: "/proto.ConsensusService/submitMessage",
  ),
  protoServiceNetworkServiceUncheckedSubmit(
    typeUrl: '/proto.ServiceNetworkServiceUncheckedSubmit',
    serviceUrl: "/proto.NetworkService/uncheckedSubmit",
  ),
  protoServiceTokenServiceCreateToken(
    typeUrl: '/proto.ServiceTokenServiceCreateToken',
    serviceUrl: "/proto.TokenService/createToken",
  ),
  protoServiceTokenServiceUpdateToken(
    typeUrl: '/proto.ServiceTokenServiceUpdateToken',
    serviceUrl: "/proto.TokenService/updateToken",
  ),
  protoServiceTokenServiceMintToken(
    typeUrl: '/proto.ServiceTokenServiceMintToken',
    serviceUrl: "/proto.TokenService/mintToken",
  ),
  protoServiceTokenServiceBurnToken(
    typeUrl: '/proto.ServiceTokenServiceBurnToken',
    serviceUrl: "/proto.TokenService/burnToken",
  ),
  protoServiceTokenServiceDeleteToken(
    typeUrl: '/proto.ServiceTokenServiceDeleteToken',
    serviceUrl: "/proto.TokenService/deleteToken",
  ),
  protoServiceTokenServiceWipeTokenAccount(
    typeUrl: '/proto.ServiceTokenServiceWipeTokenAccount',
    serviceUrl: "/proto.TokenService/wipeTokenAccount",
  ),
  protoServiceTokenServiceFreezeTokenAccount(
    typeUrl: '/proto.ServiceTokenServiceFreezeTokenAccount',
    serviceUrl: "/proto.TokenService/freezeTokenAccount",
  ),
  protoServiceTokenServiceUnfreezeTokenAccount(
    typeUrl: '/proto.ServiceTokenServiceUnfreezeTokenAccount',
    serviceUrl: "/proto.TokenService/unfreezeTokenAccount",
  ),
  protoServiceTokenServiceGrantKycToTokenAccount(
    typeUrl: '/proto.ServiceTokenServiceGrantKycToTokenAccount',
    serviceUrl: "/proto.TokenService/grantKycToTokenAccount",
  ),
  protoServiceTokenServiceRevokeKycFromTokenAccount(
    typeUrl: '/proto.ServiceTokenServiceRevokeKycFromTokenAccount',
    serviceUrl: "/proto.TokenService/revokeKycFromTokenAccount",
  ),
  protoServiceTokenServiceAssociateTokens(
    typeUrl: '/proto.ServiceTokenServiceAssociateTokens',
    serviceUrl: "/proto.TokenService/associateTokens",
  ),
  protoServiceTokenServiceDissociateTokens(
    typeUrl: '/proto.ServiceTokenServiceDissociateTokens',
    serviceUrl: "/proto.TokenService/dissociateTokens",
  ),
  protoServiceTokenServiceUpdateTokenFeeSchedule(
    typeUrl: '/proto.ServiceTokenServiceUpdateTokenFeeSchedule',
    serviceUrl: "/proto.TokenService/updateTokenFeeSchedule",
  ),
  protoServiceTokenServicePauseToken(
    typeUrl: '/proto.ServiceTokenServicePauseToken',
    serviceUrl: "/proto.TokenService/pauseToken",
  ),
  protoServiceTokenServiceUnpauseToken(
    typeUrl: '/proto.ServiceTokenServiceUnpauseToken',
    serviceUrl: "/proto.TokenService/unpauseToken",
  ),
  protoServiceTokenServiceUpdateNfts(
    typeUrl: '/proto.ServiceTokenServiceUpdateNfts',
    serviceUrl: "/proto.TokenService/updateNfts",
  ),
  protoServiceTokenServiceRejectToken(
    typeUrl: '/proto.ServiceTokenServiceRejectToken',
    serviceUrl: "/proto.TokenService/rejectToken",
  ),
  protoServiceTokenServiceAirdropTokens(
    typeUrl: '/proto.ServiceTokenServiceAirdropTokens',
    serviceUrl: "/proto.TokenService/airdropTokens",
  ),
  protoServiceTokenServiceCancelAirdrop(
    typeUrl: '/proto.ServiceTokenServiceCancelAirdrop',
    serviceUrl: "/proto.TokenService/cancelAirdrop",
  ),
  protoServiceTokenServiceClaimAirdrop(
    typeUrl: '/proto.ServiceTokenServiceClaimAirdrop',
    serviceUrl: "/proto.TokenService/claimAirdrop",
  ),
  protoServiceScheduleServiceCreateSchedule(
    typeUrl: '/proto.ServiceScheduleServiceCreateSchedule',
    serviceUrl: "/proto.ScheduleService/createSchedule",
  ),
  protoServiceScheduleServiceSignSchedule(
    typeUrl: '/proto.ServiceScheduleServiceSignSchedule',
    serviceUrl: "/proto.ScheduleService/signSchedule",
  ),
  protoServiceScheduleServiceDeleteSchedule(
    typeUrl: '/proto.ServiceScheduleServiceDeleteSchedule',
    serviceUrl: "/proto.ScheduleService/deleteSchedule",
  ),
  protoServiceFreezeServiceFreeze(
    typeUrl: '/proto.ServiceFreezeServiceFreeze',
    serviceUrl: "/proto.FreezeService/freeze",
  ),
  protoServiceSmartContractServiceCreateContract(
    typeUrl: '/proto.ServiceSmartContractServiceCreateContract',
    serviceUrl: "/proto.SmartContractService/createContract",
  ),
  protoServiceSmartContractServiceUpdateContract(
    typeUrl: '/proto.ServiceSmartContractServiceUpdateContract',
    serviceUrl: "/proto.SmartContractService/updateContract",
  ),
  protoServiceSmartContractServiceContractCallMethod(
    typeUrl: '/proto.ServiceSmartContractServiceContractCallMethod',
    serviceUrl: "/proto.SmartContractService/contractCallMethod",
  ),
  protoServiceSmartContractServiceDeleteContract(
    typeUrl: '/proto.ServiceSmartContractServiceDeleteContract',
    serviceUrl: "/proto.SmartContractService/deleteContract",
  ),
  protoServiceSmartContractServiceSystemDelete(
    typeUrl: '/proto.ServiceSmartContractServiceSystemDelete',
    serviceUrl: "/proto.SmartContractService/systemDelete",
  ),
  protoServiceSmartContractServiceSystemUndelete(
    typeUrl: '/proto.ServiceSmartContractServiceSystemUndelete',
    serviceUrl: "/proto.SmartContractService/systemUndelete",
  ),
  protoServiceSmartContractServiceCallEthereum(
    typeUrl: '/proto.ServiceSmartContractServiceCallEthereum',
    serviceUrl: "/proto.SmartContractService/callEthereum",
  ),
  protoServiceSmartContractServiceHookStore(
    typeUrl: '/proto.ServiceSmartContractServiceHookStore',
    serviceUrl: "/proto.SmartContractService/hookStore",
  ),
  protoServiceCryptoServiceCreateAccount(
    typeUrl: '/proto.ServiceCryptoServiceCreateAccount',
    serviceUrl: "/proto.CryptoService/createAccount",
  ),
  protoServiceCryptoServiceUpdateAccount(
    typeUrl: '/proto.ServiceCryptoServiceUpdateAccount',
    serviceUrl: "/proto.CryptoService/updateAccount",
  ),
  protoServiceCryptoServiceCryptoTransfer(
    typeUrl: '/proto.ServiceCryptoServiceCryptoTransfer',
    serviceUrl: "/proto.CryptoService/cryptoTransfer",
  ),
  protoServiceCryptoServiceCryptoDelete(
    typeUrl: '/proto.ServiceCryptoServiceCryptoDelete',
    serviceUrl: "/proto.CryptoService/cryptoDelete",
  ),
  protoServiceCryptoServiceApproveAllowances(
    typeUrl: '/proto.ServiceCryptoServiceApproveAllowances',
    serviceUrl: "/proto.CryptoService/approveAllowances",
  ),
  protoServiceCryptoServiceDeleteAllowances(
    typeUrl: '/proto.ServiceCryptoServiceDeleteAllowances',
    serviceUrl: "/proto.CryptoService/deleteAllowances",
  ),
  protoServiceCryptoServiceAddLiveHash(
    typeUrl: '/proto.ServiceCryptoServiceAddLiveHash',
    serviceUrl: "/proto.CryptoService/addLiveHash",
  ),
  protoServiceCryptoServiceDeleteLiveHash(
    typeUrl: '/proto.ServiceCryptoServiceDeleteLiveHash',
    serviceUrl: "/proto.CryptoService/deleteLiveHash",
  ),
  protoSignedTransaction(typeUrl: '/proto.SignedTransaction'),
  protoConsensusGetTopicInfoQuery(typeUrl: '/proto.ConsensusGetTopicInfoQuery'),
  protoConsensusGetTopicInfoResponse(
    typeUrl: '/proto.ConsensusGetTopicInfoResponse',
  ),
  protoTokenGetInfoQuery(typeUrl: '/proto.TokenGetInfoQuery'),
  protoTokenInfo(typeUrl: '/proto.TokenInfo'),
  protoTokenGetInfoResponse(typeUrl: '/proto.TokenGetInfoResponse'),
  protoExchangeRate(typeUrl: '/proto.ExchangeRate'),
  protoExchangeRateSet(typeUrl: '/proto.ExchangeRateSet'),
  protoConsensusTopicInfo(typeUrl: '/proto.ConsensusTopicInfo'),
  protoContractDeleteTransactionBody(
    typeUrl: '/proto.ContractDeleteTransactionBody',
  ),
  protoTokenCancelAirdropTransactionBody(
    typeUrl: '/proto.TokenCancelAirdropTransactionBody',
  ),
  protoNetworkGetVersionInfoQuery(typeUrl: '/proto.NetworkGetVersionInfoQuery'),
  protoNetworkGetVersionInfoResponse(
    typeUrl: '/proto.NetworkGetVersionInfoResponse',
  ),
  protoResponse(typeUrl: '/proto.Response'),
  protoTransactionGetRecordQuery(typeUrl: '/proto.TransactionGetRecordQuery'),
  protoTransactionGetRecordResponse(
    typeUrl: '/proto.TransactionGetRecordResponse',
  ),
  protoConsensusMessageChunkInfo(typeUrl: '/proto.ConsensusMessageChunkInfo'),
  protoConsensusSubmitMessageTransactionBody(
    typeUrl: '/proto.ConsensusSubmitMessageTransactionBody',
  ),
  protoContractGetBytecodeQuery(typeUrl: '/proto.ContractGetBytecodeQuery'),
  protoContractGetBytecodeResponse(
    typeUrl: '/proto.ContractGetBytecodeResponse',
  ),
  protoThrottleGroup(typeUrl: '/proto.ThrottleGroup'),
  protoThrottleBucket(typeUrl: '/proto.ThrottleBucket'),
  protoThrottleDefinitions(typeUrl: '/proto.ThrottleDefinitions'),
  protoContractCallTransactionBody(
    typeUrl: '/proto.ContractCallTransactionBody',
  ),
  protoFileUpdateTransactionBody(typeUrl: '/proto.FileUpdateTransactionBody'),
  protoContractGetRecordsQuery(typeUrl: '/proto.ContractGetRecordsQuery'),
  protoContractGetRecordsResponse(typeUrl: '/proto.ContractGetRecordsResponse'),
  protoTokenUnpauseTransactionBody(
    typeUrl: '/proto.TokenUnpauseTransactionBody',
  ),
  protoContractCallLocalQuery(typeUrl: '/proto.ContractCallLocalQuery'),
  protoContractCallLocalResponse(typeUrl: '/proto.ContractCallLocalResponse'),
  protoCryptoApproveAllowanceTransactionBody(
    typeUrl: '/proto.CryptoApproveAllowanceTransactionBody',
  ),
  protoCryptoAllowance(typeUrl: '/proto.CryptoAllowance'),
  protoNftAllowance(typeUrl: '/proto.NftAllowance'),
  protoTokenAllowance(typeUrl: '/proto.TokenAllowance'),
  protoContractGetInfoQuery(typeUrl: '/proto.ContractGetInfoQuery'),
  protoContractGetInfoResponse(typeUrl: '/proto.ContractGetInfoResponse'),
  protoContractGetInfoResponseContractInfo(
    typeUrl: '/proto.ContractGetInfoResponse.ContractInfo',
  ),
  protoEthereumTransactionBody(typeUrl: '/proto.EthereumTransactionBody'),
  protoTokenPauseTransactionBody(typeUrl: '/proto.TokenPauseTransactionBody'),
  protoTransactionGetFastRecordQuery(
    typeUrl: '/proto.TransactionGetFastRecordQuery',
  ),
  protoTransactionGetFastRecordResponse(
    typeUrl: '/proto.TransactionGetFastRecordResponse',
  ),
  protoQueryHeader(typeUrl: '/proto.QueryHeader'),
  protoFileDeleteTransactionBody(typeUrl: '/proto.FileDeleteTransactionBody'),
  protoSchedule(typeUrl: '/proto.Schedule'),
  protoScheduleList(typeUrl: '/proto.ScheduleList'),
  protoScheduleIdList(typeUrl: '/proto.ScheduleIdList'),
  protoScheduledCounts(typeUrl: '/proto.ScheduledCounts'),
  protoScheduledOrder(typeUrl: '/proto.ScheduledOrder'),
  protoSlotKey(typeUrl: '/proto.SlotKey'),
  protoSlotValue(typeUrl: '/proto.SlotValue'),
  protoBytecode(typeUrl: '/proto.Bytecode'),
  protoTopic(typeUrl: '/proto.Topic'),
  protoTransactionRecordEntry(typeUrl: '/proto.TransactionRecordEntry'),
  protoTransactionReceiptEntry(typeUrl: '/proto.TransactionReceiptEntry'),
  protoTransactionReceiptEntries(typeUrl: '/proto.TransactionReceiptEntries'),
  protoEntityNumber(typeUrl: '/proto.EntityNumber'),
  protoEntityIDPair(typeUrl: '/proto.EntityIDPair'),
  protoFile(typeUrl: '/proto.File'),
  protoCongestionLevelStarts(typeUrl: '/proto.CongestionLevelStarts'),
  protoThrottleUsageSnapshots(typeUrl: '/proto.ThrottleUsageSnapshots'),
  protoThrottleUsageSnapshot(typeUrl: '/proto.ThrottleUsageSnapshot'),
  protoProtoLong(typeUrl: '/proto.ProtoLong'),
  protoProtoInteger(typeUrl: '/proto.ProtoInteger'),
  protoProtoBoolean(typeUrl: '/proto.ProtoBoolean'),
  protoProtoString(typeUrl: '/proto.ProtoString'),
  protoProtoBytes(typeUrl: '/proto.ProtoBytes'),
  protoRunningHashes(typeUrl: '/proto.RunningHashes'),
  protoNodeMigrationRootHashVote(typeUrl: '/proto.NodeMigrationRootHashVote'),
  protoBlockInfo(typeUrl: '/proto.BlockInfo'),
  protoToken(typeUrl: '/proto.Token'),
  protoNetworkStakingRewards(typeUrl: '/proto.NetworkStakingRewards'),
  protoNodeRewards(typeUrl: '/proto.NodeRewards'),
  protoNodeActivity(typeUrl: '/proto.NodeActivity'),
  protoStakingNodeInfo(typeUrl: '/proto.StakingNodeInfo'),
  protoAccount(typeUrl: '/proto.Account'),
  protoAccountApprovalForAllAllowance(
    typeUrl: '/proto.AccountApprovalForAllAllowance',
  ),
  protoAccountFungibleTokenAllowance(
    typeUrl: '/proto.AccountFungibleTokenAllowance',
  ),
  protoAccountCryptoAllowance(typeUrl: '/proto.AccountCryptoAllowance'),
  protoAccountPendingAirdrop(typeUrl: '/proto.AccountPendingAirdrop'),
  protoTokenRelation(typeUrl: '/proto.TokenRelation'),
  protoNft(typeUrl: '/proto.Nft'),
  protoContractCreateTransactionBody(
    typeUrl: '/proto.ContractCreateTransactionBody',
  ),
  protoFileAppendTransactionBody(typeUrl: '/proto.FileAppendTransactionBody'),
  protoTokenGetNftInfosQuery(typeUrl: '/proto.TokenGetNftInfosQuery'),
  protoTokenGetNftInfosResponse(typeUrl: '/proto.TokenGetNftInfosResponse'),
  protoTokenAirdropTransactionBody(
    typeUrl: '/proto.TokenAirdropTransactionBody',
  ),
  protoQuery(typeUrl: '/proto.Query'),
  protoServiceFileServiceGetFileContent(
    typeUrl: '/proto.ServiceFileServiceGetFileContent',
    serviceUrl: "/proto.FileService/getFileContent",
  ),
  protoServiceFileServiceGetFileInfo(
    typeUrl: '/proto.ServiceFileServiceGetFileInfo',
    serviceUrl: "/proto.FileService/getFileInfo",
  ),
  protoServiceConsensusServiceGetTopicInfo(
    typeUrl: '/proto.ServiceConsensusServiceGetTopicInfo',
    serviceUrl: "/proto.ConsensusService/getTopicInfo",
  ),
  protoServiceNetworkServiceGetVersionInfo(
    typeUrl: '/proto.ServiceNetworkServiceGetVersionInfo',
    serviceUrl: "/proto.NetworkService/getVersionInfo",
  ),
  protoServiceNetworkServiceGetAccountDetails(
    typeUrl: '/proto.ServiceNetworkServiceGetAccountDetails',
    serviceUrl: "/proto.NetworkService/getAccountDetails",
  ),
  protoServiceNetworkServiceGetExecutionTime(
    typeUrl: '/proto.ServiceNetworkServiceGetExecutionTime',
    serviceUrl: "/proto.NetworkService/getExecutionTime",
  ),
  protoServiceTokenServiceGetTokenInfo(
    typeUrl: '/proto.ServiceTokenServiceGetTokenInfo',
    serviceUrl: "/proto.TokenService/getTokenInfo",
  ),
  protoServiceTokenServiceGetTokenNftInfo(
    typeUrl: '/proto.ServiceTokenServiceGetTokenNftInfo',
    serviceUrl: "/proto.TokenService/getTokenNftInfo",
  ),
  protoServiceScheduleServiceGetScheduleInfo(
    typeUrl: '/proto.ServiceScheduleServiceGetScheduleInfo',
    serviceUrl: "/proto.ScheduleService/getScheduleInfo",
  ),
  protoServiceSmartContractServiceContractCallLocalMethod(
    typeUrl: '/proto.ServiceSmartContractServiceContractCallLocalMethod',
    serviceUrl: "/proto.SmartContractService/contractCallLocalMethod",
  ),
  protoServiceSmartContractServiceGetContractInfo(
    typeUrl: '/proto.ServiceSmartContractServiceGetContractInfo',
    serviceUrl: "/proto.SmartContractService/getContractInfo",
  ),
  protoServiceSmartContractServiceContractGetBytecode(
    typeUrl: '/proto.ServiceSmartContractServiceContractGetBytecode',
    serviceUrl: "/proto.SmartContractService/ContractGetBytecode",
  ),
  protoServiceSmartContractServiceGetBySolidityID(
    typeUrl: '/proto.ServiceSmartContractServiceGetBySolidityID',
    serviceUrl: "/proto.SmartContractService/getBySolidityID",
  ),
  protoServiceSmartContractServiceGetTxRecordByContractID(
    typeUrl: '/proto.ServiceSmartContractServiceGetTxRecordByContractID',
    serviceUrl: "/proto.SmartContractService/getTxRecordByContractID",
  ),
  protoServiceCryptoServiceGetLiveHash(
    typeUrl: '/proto.ServiceCryptoServiceGetLiveHash',
    serviceUrl: "/proto.CryptoService/getLiveHash",
  ),
  protoServiceCryptoServiceGetAccountRecords(
    typeUrl: '/proto.ServiceCryptoServiceGetAccountRecords',
    serviceUrl: "/proto.CryptoService/getAccountRecords",
  ),
  protoServiceCryptoServiceCryptoGetBalance(
    typeUrl: '/proto.ServiceCryptoServiceCryptoGetBalance',
    serviceUrl: "/proto.CryptoService/cryptoGetBalance",
  ),
  protoServiceCryptoServiceGetAccountInfo(
    typeUrl: '/proto.ServiceCryptoServiceGetAccountInfo',
    serviceUrl: "/proto.CryptoService/getAccountInfo",
  ),
  protoServiceCryptoServiceGetTransactionReceipts(
    typeUrl: '/proto.ServiceCryptoServiceGetTransactionReceipts',
    serviceUrl: "/proto.CryptoService/getTransactionReceipts",
  ),
  protoServiceCryptoServiceGetTxRecordByTxID(
    typeUrl: '/proto.ServiceCryptoServiceGetTxRecordByTxID',
    serviceUrl: "/proto.CryptoService/getTxRecordByTxID",
  ),
  protoCryptoTransferTransactionBody(
    typeUrl: '/proto.CryptoTransferTransactionBody',
  ),
  protoFractionalFee(typeUrl: '/proto.FractionalFee'),
  protoFixedFee(typeUrl: '/proto.FixedFee'),
  protoRoyaltyFee(typeUrl: '/proto.RoyaltyFee'),
  protoCustomFee(typeUrl: '/proto.CustomFee'),
  protoAssessedCustomFee(typeUrl: '/proto.AssessedCustomFee'),
  protoFixedCustomFee(typeUrl: '/proto.FixedCustomFee'),
  protoFixedCustomFeeList(typeUrl: '/proto.FixedCustomFeeList'),
  protoFeeExemptKeyList(typeUrl: '/proto.FeeExemptKeyList'),
  protoCustomFeeLimit(typeUrl: '/proto.CustomFeeLimit'),
  protoScheduleSignTransactionBody(
    typeUrl: '/proto.ScheduleSignTransactionBody',
  ),
  protoGetAccountDetailsQuery(typeUrl: '/proto.GetAccountDetailsQuery'),
  protoGetAccountDetailsResponse(typeUrl: '/proto.GetAccountDetailsResponse'),
  protoGetAccountDetailsResponseAccountDetails(
    typeUrl: '/proto.GetAccountDetailsResponse.AccountDetails',
  ),
  protoGrantedCryptoAllowance(typeUrl: '/proto.GrantedCryptoAllowance'),
  protoGrantedNftAllowance(typeUrl: '/proto.GrantedNftAllowance'),
  protoGrantedTokenAllowance(typeUrl: '/proto.GrantedTokenAllowance'),
  protoCryptoUpdateTransactionBody(
    typeUrl: '/proto.CryptoUpdateTransactionBody',
  ),
  protoNodeStakeUpdateTransactionBody(
    typeUrl: '/proto.NodeStakeUpdateTransactionBody',
  ),
  protoNodeStake(typeUrl: '/proto.NodeStake'),
  protoSystemUndeleteTransactionBody(
    typeUrl: '/proto.SystemUndeleteTransactionBody',
  ),
  protoTokenCreateTransactionBody(typeUrl: '/proto.TokenCreateTransactionBody'),
  protoScheduleDeleteTransactionBody(
    typeUrl: '/proto.ScheduleDeleteTransactionBody',
  ),
  protoTokenDissociateTransactionBody(
    typeUrl: '/proto.TokenDissociateTransactionBody',
  ),
  protoTimestamp(typeUrl: '/proto.Timestamp'),
  protoTimestampSeconds(typeUrl: '/proto.TimestampSeconds'),
  protoTokenFeeScheduleUpdateTransactionBody(
    typeUrl: '/proto.TokenFeeScheduleUpdateTransactionBody',
  ),
  protoTransactionGetReceiptQuery(typeUrl: '/proto.TransactionGetReceiptQuery'),
  protoTransactionGetReceiptResponse(
    typeUrl: '/proto.TransactionGetReceiptResponse',
  ),
  protoCryptoDeleteTransactionBody(
    typeUrl: '/proto.CryptoDeleteTransactionBody',
  ),
  protoTokenRevokeKycTransactionBody(
    typeUrl: '/proto.TokenRevokeKycTransactionBody',
  ),
  protoTransactionReceipt(typeUrl: '/proto.TransactionReceipt'),
  protoFileCreateTransactionBody(typeUrl: '/proto.FileCreateTransactionBody'),
  protoCryptoGetStakersQuery(typeUrl: '/proto.CryptoGetStakersQuery'),
  protoProxyStaker(typeUrl: '/proto.ProxyStaker'),
  protoAllProxyStakers(typeUrl: '/proto.AllProxyStakers'),
  protoCryptoGetStakersResponse(typeUrl: '/proto.CryptoGetStakersResponse'),
  protoFileGetContentsQuery(typeUrl: '/proto.FileGetContentsQuery'),
  protoFileGetContentsResponse(typeUrl: '/proto.FileGetContentsResponse'),
  protoFileGetContentsResponseFileContents(
    typeUrl: '/proto.FileGetContentsResponse.FileContents',
  ),
  protoContractActions(typeUrl: '/proto.ContractActions'),
  protoContractAction(typeUrl: '/proto.ContractAction'),
  protoSignatureFile(typeUrl: '/proto.SignatureFile'),
  protoSignatureObject(typeUrl: '/proto.SignatureObject'),
  protoContractBytecode(typeUrl: '/proto.ContractBytecode'),
  protoHashObject(typeUrl: '/proto.HashObject'),
  protoTokenUnitBalance(typeUrl: '/proto.TokenUnitBalance'),
  protoSingleAccountBalances(typeUrl: '/proto.SingleAccountBalances'),
  protoAllAccountBalances(typeUrl: '/proto.AllAccountBalances'),
  protoRecordStreamFile(typeUrl: '/proto.RecordStreamFile'),
  protoRecordStreamItem(typeUrl: '/proto.RecordStreamItem'),
  protoSidecarMetadata(typeUrl: '/proto.SidecarMetadata'),
  protoContractStateChanges(typeUrl: '/proto.ContractStateChanges'),
  protoContractStateChange(typeUrl: '/proto.ContractStateChange'),
  protoStorageChange(typeUrl: '/proto.StorageChange'),
  protoSidecarFile(typeUrl: '/proto.SidecarFile'),
  protoTransactionSidecarRecord(typeUrl: '/proto.TransactionSidecarRecord'),
  orgHieroHapiSupportFeesHIP1261FeeSchedule(
    typeUrl: '/org.hiero.hapi.support.fees.HIP1261FeeSchedule',
  ),
  orgHieroHapiSupportFeesExtraFeeDefinition(
    typeUrl: '/org.hiero.hapi.support.fees.ExtraFeeDefinition',
  ),
  orgHieroHapiSupportFeesNodeFee(
    typeUrl: '/org.hiero.hapi.support.fees.NodeFee',
  ),
  orgHieroHapiSupportFeesNetworkFee(
    typeUrl: '/org.hiero.hapi.support.fees.NetworkFee',
  ),
  orgHieroHapiSupportFeesServiceFeeSchedule(
    typeUrl: '/org.hiero.hapi.support.fees.ServiceFeeSchedule',
  ),
  orgHieroHapiSupportFeesServiceFeeDefinition(
    typeUrl: '/org.hiero.hapi.support.fees.ServiceFeeDefinition',
  ),
  orgHieroHapiSupportFeesExtraFeeReference(
    typeUrl: '/org.hiero.hapi.support.fees.ExtraFeeReference',
  ),
  orgHieroHapiSupportFeesUnreadableTransactionFee(
    typeUrl: '/org.hiero.hapi.support.fees.UnreadableTransactionFee',
  ),
  orgHieroHapiSupportFeesVariableRateDefinition(
    typeUrl: '/org.hiero.hapi.support.fees.VariableRateDefinition',
  ),
  orgHieroHapiSupportFeesPricingCurve(
    typeUrl: '/org.hiero.hapi.support.fees.PricingCurve',
  ),
  orgHieroHapiSupportFeesPiecewiseLinearCurve(
    typeUrl: '/org.hiero.hapi.support.fees.PiecewiseLinearCurve',
  ),
  orgHieroHapiSupportFeesPiecewiseLinearPoint(
    typeUrl: '/org.hiero.hapi.support.fees.PiecewiseLinearPoint',
  ),
  comHederaHapiNodeHooksHookStoreTransactionBody(
    typeUrl: '/com.hedera.hapi.node.hooks.HookStoreTransactionBody',
  ),
  comHederaHapiNodeHooksHookDispatchTransactionBody(
    typeUrl: '/com.hedera.hapi.node.hooks.HookDispatchTransactionBody',
  ),
  comHederaHapiNodeHooksHookExecution(
    typeUrl: '/com.hedera.hapi.node.hooks.HookExecution',
  ),
  comHederaHapiNodeHooksHookCreation(
    typeUrl: '/com.hedera.hapi.node.hooks.HookCreation',
  ),
  comHederaHapiNodeHooksHookCreationDetails(
    typeUrl: '/com.hedera.hapi.node.hooks.HookCreationDetails',
  ),
  comHederaHapiNodeHooksEvmHook(typeUrl: '/com.hedera.hapi.node.hooks.EvmHook'),
  comHederaHapiNodeHooksEvmHookSpec(
    typeUrl: '/com.hedera.hapi.node.hooks.EvmHookSpec',
  ),
  comHederaHapiNodeHooksEvmHookStorageUpdate(
    typeUrl: '/com.hedera.hapi.node.hooks.EvmHookStorageUpdate',
  ),
  comHederaHapiNodeHooksEvmHookMappingEntries(
    typeUrl: '/com.hedera.hapi.node.hooks.EvmHookMappingEntries',
  ),
  comHederaHapiNodeHooksEvmHookMappingEntry(
    typeUrl: '/com.hedera.hapi.node.hooks.EvmHookMappingEntry',
  ),
  comHederaHapiNodeHooksEvmHookStorageSlot(
    typeUrl: '/com.hedera.hapi.node.hooks.EvmHookStorageSlot',
  ),
  comHederaHapiNodeAddressbookRegisteredNodeUpdateTransactionBody(
    typeUrl:
        '/com.hedera.hapi.node.addressbook.RegisteredNodeUpdateTransactionBody',
  ),
  comHederaHapiNodeAddressbookNodeCreateTransactionBody(
    typeUrl: '/com.hedera.hapi.node.addressbook.NodeCreateTransactionBody',
  ),
  comHederaHapiNodeAddressbookNodeDeleteTransactionBody(
    typeUrl: '/com.hedera.hapi.node.addressbook.NodeDeleteTransactionBody',
  ),
  comHederaHapiNodeAddressbookNodeUpdateTransactionBody(
    typeUrl: '/com.hedera.hapi.node.addressbook.NodeUpdateTransactionBody',
  ),
  comHederaHapiNodeAddressbookAssociatedRegisteredNodeList(
    typeUrl: '/com.hedera.hapi.node.addressbook.AssociatedRegisteredNodeList',
  ),
  comHederaHapiNodeAddressbookRegisteredNodeCreateTransactionBody(
    typeUrl:
        '/com.hedera.hapi.node.addressbook.RegisteredNodeCreateTransactionBody',
  ),
  comHederaHapiNodeAddressbookRegisteredServiceEndpoint(
    typeUrl: '/com.hedera.hapi.node.addressbook.RegisteredServiceEndpoint',
  ),
  comHederaHapiNodeAddressbookRegisteredServiceEndpointBlockNodeEndpoint(
    typeUrl:
        '/com.hedera.hapi.node.addressbook.RegisteredServiceEndpoint.BlockNodeEndpoint',
  ),
  comHederaHapiNodeAddressbookRegisteredServiceEndpointMirrorNodeEndpoint(
    typeUrl:
        '/com.hedera.hapi.node.addressbook.RegisteredServiceEndpoint.MirrorNodeEndpoint',
  ),
  comHederaHapiNodeAddressbookRegisteredServiceEndpointRpcRelayEndpoint(
    typeUrl:
        '/com.hedera.hapi.node.addressbook.RegisteredServiceEndpoint.RpcRelayEndpoint',
  ),
  comHederaHapiNodeAddressbookRegisteredServiceEndpointGeneralServiceEndpoint(
    typeUrl:
        '/com.hedera.hapi.node.addressbook.RegisteredServiceEndpoint.GeneralServiceEndpoint',
  ),
  comHederaHapiNodeAddressbookRegisteredNodeDeleteTransactionBody(
    typeUrl:
        '/com.hedera.hapi.node.addressbook.RegisteredNodeDeleteTransactionBody',
  ),
  comHederaHapiNodeTssLedgerIdPublicationTransactionBody(
    typeUrl: '/com.hedera.hapi.node.tss.LedgerIdPublicationTransactionBody',
  ),
  comHederaHapiNodeTssLedgerIdNodeContribution(
    typeUrl: '/com.hedera.hapi.node.tss.LedgerIdNodeContribution',
  ),
  comHederaHapiServicesAuxiliaryTssTssVoteTransactionBody(
    typeUrl: '/com.hedera.hapi.services.auxiliary.tss.TssVoteTransactionBody',
  ),
  comHederaHapiServicesAuxiliaryTssTssMessageTransactionBody(
    typeUrl:
        '/com.hedera.hapi.services.auxiliary.tss.TssMessageTransactionBody',
  ),
  comHederaHapiServicesAuxiliaryTssTssEncryptionKeyTransactionBody(
    typeUrl:
        '/com.hedera.hapi.services.auxiliary.tss.TssEncryptionKeyTransactionBody',
  ),
  comHederaHapiServicesAuxiliaryHistoryHistoryProofSignatureTransactionBody(
    typeUrl:
        '/com.hedera.hapi.services.auxiliary.history.HistoryProofSignatureTransactionBody',
  ),
  comHederaHapiServicesAuxiliaryHistoryHistoryProofKeyPublicationTransactionBody(
    typeUrl:
        '/com.hedera.hapi.services.auxiliary.history.HistoryProofKeyPublicationTransactionBody',
  ),
  comHederaHapiServicesAuxiliaryHistoryHistoryProofVoteTransactionBody(
    typeUrl:
        '/com.hedera.hapi.services.auxiliary.history.HistoryProofVoteTransactionBody',
  ),
  comHederaHapiServicesAuxiliaryHintsHintsPartialSignatureTransactionBody(
    typeUrl:
        '/com.hedera.hapi.services.auxiliary.hints.HintsPartialSignatureTransactionBody',
  ),
  comHederaHapiServicesAuxiliaryHintsHintsKeyPublicationTransactionBody(
    typeUrl:
        '/com.hedera.hapi.services.auxiliary.hints.HintsKeyPublicationTransactionBody',
  ),
  comHederaHapiServicesAuxiliaryHintsHintsPreprocessingVoteTransactionBody(
    typeUrl:
        '/com.hedera.hapi.services.auxiliary.hints.HintsPreprocessingVoteTransactionBody',
  ),
  comHederaHapiServicesAuxiliaryHintsCrsPublicationTransactionBody(
    typeUrl:
        '/com.hedera.hapi.services.auxiliary.hints.CrsPublicationTransactionBody',
  ),
  comHederaHapiServicesAuxiliaryBlockrecordsMigrationRootHashVoteTransactionBody(
    typeUrl:
        '/com.hedera.hapi.services.auxiliary.blockrecords.MigrationRootHashVoteTransactionBody',
  ),
  comHederaHapiNodeStateHooksEvmHookState(
    typeUrl: '/com.hedera.hapi.node.state.hooks.EvmHookState',
  ),
  comHederaHapiNodeStateHooksEvmHookSlotKey(
    typeUrl: '/com.hedera.hapi.node.state.hooks.EvmHookSlotKey',
  ),
  comHederaHapiNodeStateAddressbookNode(
    typeUrl: '/com.hedera.hapi.node.state.addressbook.Node',
  ),
  comHederaHapiNodeStateAddressbookRegisteredNode(
    typeUrl: '/com.hedera.hapi.node.state.addressbook.RegisteredNode',
  ),
  comHederaHapiNodeStateRosterRoster(
    typeUrl: '/com.hedera.hapi.node.state.roster.Roster',
  ),
  comHederaHapiNodeStateRosterRosterEntry(
    typeUrl: '/com.hedera.hapi.node.state.roster.RosterEntry',
  ),
  comHederaHapiNodeStateRosterRosterState(
    typeUrl: '/com.hedera.hapi.node.state.roster.RosterState',
  ),
  comHederaHapiNodeStateRosterRoundRosterPair(
    typeUrl: '/com.hedera.hapi.node.state.roster.RoundRosterPair',
  ),
  comHederaHapiNodeStateRosterLedgerId(
    typeUrl: '/com.hedera.hapi.node.state.roster.LedgerId',
  ),
  comHederaHapiNodeStateRosterRosterSignatures(
    typeUrl: '/com.hedera.hapi.node.state.roster.RosterSignatures',
  ),
  comHederaHapiNodeStateRosterNodeSignature(
    typeUrl: '/com.hedera.hapi.node.state.roster.NodeSignature',
  ),
  comHederaHapiNodeStateTssTssVoteMapKey(
    typeUrl: '/com.hedera.hapi.node.state.tss.TssVoteMapKey',
  ),
  comHederaHapiNodeStateTssTssMessageMapKey(
    typeUrl: '/com.hedera.hapi.node.state.tss.TssMessageMapKey',
  ),
  comHederaHapiNodeStateTssTssEncryptionKeys(
    typeUrl: '/com.hedera.hapi.node.state.tss.TssEncryptionKeys',
  ),
  comHederaHapiNodeStateHistoryProofKeySet(
    typeUrl: '/com.hedera.hapi.node.state.history.ProofKeySet',
  ),
  comHederaHapiNodeStateHistoryProofKey(
    typeUrl: '/com.hedera.hapi.node.state.history.ProofKey',
  ),
  comHederaHapiNodeStateHistoryHistory(
    typeUrl: '/com.hedera.hapi.node.state.history.History',
  ),
  comHederaHapiNodeStateHistoryHistoryProof(
    typeUrl: '/com.hedera.hapi.node.state.history.HistoryProof',
  ),
  comHederaHapiNodeStateHistoryHistoryProofConstruction(
    typeUrl: '/com.hedera.hapi.node.state.history.HistoryProofConstruction',
  ),
  comHederaHapiNodeStateHistoryWrapsSigningState(
    typeUrl: '/com.hedera.hapi.node.state.history.WrapsSigningState',
  ),
  comHederaHapiNodeStateHistoryConstructionNodeId(
    typeUrl: '/com.hedera.hapi.node.state.history.ConstructionNodeId',
  ),
  comHederaHapiNodeStateHistoryHistoryProofVote(
    typeUrl: '/com.hedera.hapi.node.state.history.HistoryProofVote',
  ),
  comHederaHapiNodeStateHistoryHistorySignature(
    typeUrl: '/com.hedera.hapi.node.state.history.HistorySignature',
  ),
  comHederaHapiNodeStateHistoryRecordedHistorySignature(
    typeUrl: '/com.hedera.hapi.node.state.history.RecordedHistorySignature',
  ),
  comHederaHapiNodeStateHistoryWrapsMessageDetails(
    typeUrl: '/com.hedera.hapi.node.state.history.WrapsMessageDetails',
  ),
  comHederaHapiNodeStateHistoryWrapsMessageHistory(
    typeUrl: '/com.hedera.hapi.node.state.history.WrapsMessageHistory',
  ),
  comHederaHapiNodeStateHistoryChainOfTrustProof(
    typeUrl: '/com.hedera.hapi.node.state.history.ChainOfTrustProof',
  ),
  comHederaHapiNodeStateHistoryAggregatedNodeSignatures(
    typeUrl: '/com.hedera.hapi.node.state.history.AggregatedNodeSignatures',
  ),
  comHederaHapiNodeStateEntityEntityCounts(
    typeUrl: '/com.hedera.hapi.node.state.entity.EntityCounts',
  ),
  comHederaHapiNodeStateHintsHintsPartyId(
    typeUrl: '/com.hedera.hapi.node.state.hints.HintsPartyId',
  ),
  comHederaHapiNodeStateHintsHintsKeySet(
    typeUrl: '/com.hedera.hapi.node.state.hints.HintsKeySet',
  ),
  comHederaHapiNodeStateHintsPreprocessedKeys(
    typeUrl: '/com.hedera.hapi.node.state.hints.PreprocessedKeys',
  ),
  comHederaHapiNodeStateHintsPreprocessingVoteId(
    typeUrl: '/com.hedera.hapi.node.state.hints.PreprocessingVoteId',
  ),
  comHederaHapiNodeStateHintsPreprocessingVote(
    typeUrl: '/com.hedera.hapi.node.state.hints.PreprocessingVote',
  ),
  comHederaHapiNodeStateHintsNodePartyId(
    typeUrl: '/com.hedera.hapi.node.state.hints.NodePartyId',
  ),
  comHederaHapiNodeStateHintsHintsScheme(
    typeUrl: '/com.hedera.hapi.node.state.hints.HintsScheme',
  ),
  comHederaHapiNodeStateHintsHintsConstruction(
    typeUrl: '/com.hedera.hapi.node.state.hints.HintsConstruction',
  ),
  comHederaHapiNodeStateHintsCRSState(
    typeUrl: '/com.hedera.hapi.node.state.hints.CRSState',
  ),
  comHederaHapiNodeStateBlockrecordsMigrationWrappedHashes(
    typeUrl: '/com.hedera.hapi.node.state.blockrecords.MigrationWrappedHashes',
  ),
  comHederaHapiNodeStateTokenNodePayments(
    typeUrl: '/com.hedera.hapi.node.state.token.NodePayments',
  ),
  comHederaHapiNodeStateTokenNodePayment(
    typeUrl: '/com.hedera.hapi.node.state.token.NodePayment',
  ),
  comHederaHapiNodeStateBlockstreamBlockStreamInfo(
    typeUrl: '/com.hedera.hapi.node.state.blockstream.BlockStreamInfo',
  ),
  googleProtobufDoubleValue(typeUrl: '/google.protobuf.DoubleValue'),
  googleProtobufFloatValue(typeUrl: '/google.protobuf.FloatValue'),
  googleProtobufInt64Value(typeUrl: '/google.protobuf.Int64Value'),
  googleProtobufUInt64Value(typeUrl: '/google.protobuf.UInt64Value'),
  googleProtobufInt32Value(typeUrl: '/google.protobuf.Int32Value'),
  googleProtobufUInt32Value(typeUrl: '/google.protobuf.UInt32Value'),
  googleProtobufBoolValue(typeUrl: '/google.protobuf.BoolValue'),
  googleProtobufStringValue(typeUrl: '/google.protobuf.StringValue'),
  googleProtobufBytesValue(typeUrl: '/google.protobuf.BytesValue'),
  comHederaMirrorApiProtoAddressBookQuery(
    typeUrl: '/com.hedera.mirror.api.proto.AddressBookQuery',
  ),
  comHederaMirrorApiProtoServiceNetworkServiceGetNodes(
    typeUrl: '/com.hedera.mirror.api.proto.ServiceNetworkServiceGetNodes',
    serviceUrl: "/com.hedera.mirror.api.proto.NetworkService/getNodes",
  ),
  comHederaMirrorApiProtoConsensusTopicQuery(
    typeUrl: '/com.hedera.mirror.api.proto.ConsensusTopicQuery',
  ),
  comHederaMirrorApiProtoConsensusTopicResponse(
    typeUrl: '/com.hedera.mirror.api.proto.ConsensusTopicResponse',
  ),
  comHederaMirrorApiProtoServiceConsensusServiceSubscribeTopic(
    typeUrl:
        '/com.hedera.mirror.api.proto.ServiceConsensusServiceSubscribeTopic',
    serviceUrl: "/com.hedera.mirror.api.proto.ConsensusService/subscribeTopic",
  );

  @override
  final String typeUrl;
  @override
  final String? serviceUrl;
  const DefaultHederaProtoTypeUrl({required this.typeUrl, this.serviceUrl});
  static DefaultHederaProtoTypeUrl? fromUrl(String? value) {
    return DefaultHederaProtoTypeUrl.values.firstWhereNullable(
      (e) => e.typeUrl == value || e.serviceUrl == value,
    );
  }

  @override
  String getServiceUrl() {
    final serviceUrl = this.serviceUrl;
    if (serviceUrl == null) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'Missing proto service url.',
        details: {'type_url': typeUrl},
      );
    }
    return serviceUrl;
  }
}
