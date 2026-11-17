import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';

enum DefaultSuiProtoTypeUrl implements SuiProtoTypeUrl {
  suiRpcV2ProtocolConfig(typeUrl: '/sui.rpc.v2.ProtocolConfig'),
  suiRpcV2LookupNameRequest(
    typeUrl: '/sui.rpc.v2.LookupNameRequest',
    serviceUrl: "/sui.rpc.v2.NameService/LookupName",
  ),
  suiRpcV2LookupNameResponse(typeUrl: '/sui.rpc.v2.LookupNameResponse'),
  suiRpcV2ReverseLookupNameRequest(
    typeUrl: '/sui.rpc.v2.ReverseLookupNameRequest',
    serviceUrl: "/sui.rpc.v2.NameService/ReverseLookupName",
  ),
  suiRpcV2ReverseLookupNameResponse(
    typeUrl: '/sui.rpc.v2.ReverseLookupNameResponse',
  ),
  suiRpcV2NameRecord(typeUrl: '/sui.rpc.v2.NameRecord'),
  suiRpcV2Owner(typeUrl: '/sui.rpc.v2.Owner'),
  suiRpcV2CheckpointContents(typeUrl: '/sui.rpc.v2.CheckpointContents'),
  suiRpcV2CheckpointedTransactionInfo(
    typeUrl: '/sui.rpc.v2.CheckpointedTransactionInfo',
  ),
  suiRpcV2AddressAliasesVersion(typeUrl: '/sui.rpc.v2.AddressAliasesVersion'),
  suiRpcV2GasCostSummary(typeUrl: '/sui.rpc.v2.GasCostSummary'),
  suiRpcV2TransactionEvents(typeUrl: '/sui.rpc.v2.TransactionEvents'),
  suiRpcV2Event(typeUrl: '/sui.rpc.v2.Event'),
  suiRpcV2Argument(typeUrl: '/sui.rpc.v2.Argument'),
  suiRpcV2GetPackageRequest(
    typeUrl: '/sui.rpc.v2.GetPackageRequest',
    serviceUrl: "/sui.rpc.v2.MovePackageService/GetPackage",
  ),
  suiRpcV2GetPackageResponse(typeUrl: '/sui.rpc.v2.GetPackageResponse'),
  suiRpcV2GetDatatypeRequest(
    typeUrl: '/sui.rpc.v2.GetDatatypeRequest',
    serviceUrl: "/sui.rpc.v2.MovePackageService/GetDatatype",
  ),
  suiRpcV2GetDatatypeResponse(typeUrl: '/sui.rpc.v2.GetDatatypeResponse'),
  suiRpcV2GetFunctionRequest(
    typeUrl: '/sui.rpc.v2.GetFunctionRequest',
    serviceUrl: "/sui.rpc.v2.MovePackageService/GetFunction",
  ),
  suiRpcV2GetFunctionResponse(typeUrl: '/sui.rpc.v2.GetFunctionResponse'),
  suiRpcV2ListPackageVersionsRequest(
    typeUrl: '/sui.rpc.v2.ListPackageVersionsRequest',
    serviceUrl: "/sui.rpc.v2.MovePackageService/ListPackageVersions",
  ),
  suiRpcV2ListPackageVersionsResponse(
    typeUrl: '/sui.rpc.v2.ListPackageVersionsResponse',
  ),
  suiRpcV2PackageVersion(typeUrl: '/sui.rpc.v2.PackageVersion'),
  suiRpcV2BalanceChange(typeUrl: '/sui.rpc.v2.BalanceChange'),
  suiRpcV2ExecutedTransaction(typeUrl: '/sui.rpc.v2.ExecutedTransaction'),
  suiRpcV2ExecuteTransactionRequest(
    typeUrl: '/sui.rpc.v2.ExecuteTransactionRequest',
    serviceUrl: "/sui.rpc.v2.TransactionExecutionService/ExecuteTransaction",
  ),
  suiRpcV2ExecuteTransactionResponse(
    typeUrl: '/sui.rpc.v2.ExecuteTransactionResponse',
  ),
  suiRpcV2SimulateTransactionRequest(
    typeUrl: '/sui.rpc.v2.SimulateTransactionRequest',
    serviceUrl: "/sui.rpc.v2.TransactionExecutionService/SimulateTransaction",
  ),
  suiRpcV2SimulateTransactionResponse(
    typeUrl: '/sui.rpc.v2.SimulateTransactionResponse',
  ),
  suiRpcV2CommandResult(typeUrl: '/sui.rpc.v2.CommandResult'),
  suiRpcV2CommandOutput(typeUrl: '/sui.rpc.v2.CommandOutput'),
  suiRpcV2ObjectReference(typeUrl: '/sui.rpc.v2.ObjectReference'),
  suiRpcV2GetCoinInfoRequest(
    typeUrl: '/sui.rpc.v2.GetCoinInfoRequest',
    serviceUrl: "/sui.rpc.v2.StateService/GetCoinInfo",
  ),
  suiRpcV2GetCoinInfoResponse(typeUrl: '/sui.rpc.v2.GetCoinInfoResponse'),
  suiRpcV2CoinMetadata(typeUrl: '/sui.rpc.v2.CoinMetadata'),
  suiRpcV2CoinTreasury(typeUrl: '/sui.rpc.v2.CoinTreasury'),
  suiRpcV2RegulatedCoinMetadata(typeUrl: '/sui.rpc.v2.RegulatedCoinMetadata'),
  suiRpcV2GetBalanceRequest(
    typeUrl: '/sui.rpc.v2.GetBalanceRequest',
    serviceUrl: "/sui.rpc.v2.StateService/GetBalance",
  ),
  suiRpcV2GetBalanceResponse(typeUrl: '/sui.rpc.v2.GetBalanceResponse'),
  suiRpcV2ListBalancesRequest(
    typeUrl: '/sui.rpc.v2.ListBalancesRequest',
    serviceUrl: "/sui.rpc.v2.StateService/ListBalances",
  ),
  suiRpcV2ListBalancesResponse(typeUrl: '/sui.rpc.v2.ListBalancesResponse'),
  suiRpcV2Balance(typeUrl: '/sui.rpc.v2.Balance'),
  suiRpcV2ListDynamicFieldsRequest(
    typeUrl: '/sui.rpc.v2.ListDynamicFieldsRequest',
    serviceUrl: "/sui.rpc.v2.StateService/ListDynamicFields",
  ),
  suiRpcV2ListDynamicFieldsResponse(
    typeUrl: '/sui.rpc.v2.ListDynamicFieldsResponse',
  ),
  suiRpcV2DynamicField(typeUrl: '/sui.rpc.v2.DynamicField'),
  suiRpcV2ListOwnedObjectsRequest(
    typeUrl: '/sui.rpc.v2.ListOwnedObjectsRequest',
    serviceUrl: "/sui.rpc.v2.StateService/ListOwnedObjects",
  ),
  suiRpcV2ListOwnedObjectsResponse(
    typeUrl: '/sui.rpc.v2.ListOwnedObjectsResponse',
  ),
  suiRpcV2Bcs(typeUrl: '/sui.rpc.v2.Bcs'),
  suiRpcV2CheckpointSummary(typeUrl: '/sui.rpc.v2.CheckpointSummary'),
  suiRpcV2EndOfEpochData(typeUrl: '/sui.rpc.v2.EndOfEpochData'),
  suiRpcV2CheckpointCommitment(typeUrl: '/sui.rpc.v2.CheckpointCommitment'),
  suiRpcV2Checkpoint(typeUrl: '/sui.rpc.v2.Checkpoint'),
  suiRpcV2SubscribeCheckpointsRequest(
    typeUrl: '/sui.rpc.v2.SubscribeCheckpointsRequest',
    serviceUrl: "/sui.rpc.v2.SubscriptionService/SubscribeCheckpoints",
  ),
  suiRpcV2SubscribeCheckpointsResponse(
    typeUrl: '/sui.rpc.v2.SubscribeCheckpointsResponse',
  ),
  suiRpcV2SubscribeTransactionsRequest(
    typeUrl: '/sui.rpc.v2.SubscribeTransactionsRequest',
    serviceUrl: "/sui.rpc.v2.SubscriptionService/SubscribeTransactions",
  ),
  suiRpcV2SubscribeTransactionsResponse(
    typeUrl: '/sui.rpc.v2.SubscribeTransactionsResponse',
  ),
  suiRpcV2SubscribeEventsRequest(
    typeUrl: '/sui.rpc.v2.SubscribeEventsRequest',
    serviceUrl: "/sui.rpc.v2.SubscriptionService/SubscribeEvents",
  ),
  suiRpcV2SubscribeEventsResponse(
    typeUrl: '/sui.rpc.v2.SubscribeEventsResponse',
  ),
  suiRpcV2Input(typeUrl: '/sui.rpc.v2.Input'),
  suiRpcV2FundsWithdrawal(typeUrl: '/sui.rpc.v2.FundsWithdrawal'),
  suiRpcV2QueryOptions(typeUrl: '/sui.rpc.v2.QueryOptions'),
  suiRpcV2Watermark(typeUrl: '/sui.rpc.v2.Watermark'),
  suiRpcV2QueryEnd(typeUrl: '/sui.rpc.v2.QueryEnd'),
  suiRpcV2SystemState(typeUrl: '/sui.rpc.v2.SystemState'),
  suiRpcV2ValidatorReportRecord(typeUrl: '/sui.rpc.v2.ValidatorReportRecord'),
  suiRpcV2SystemParameters(typeUrl: '/sui.rpc.v2.SystemParameters'),
  suiRpcV2MoveTable(typeUrl: '/sui.rpc.v2.MoveTable'),
  suiRpcV2StakeSubsidy(typeUrl: '/sui.rpc.v2.StakeSubsidy'),
  suiRpcV2StorageFund(typeUrl: '/sui.rpc.v2.StorageFund'),
  suiRpcV2ValidatorSet(typeUrl: '/sui.rpc.v2.ValidatorSet'),
  suiRpcV2Validator(typeUrl: '/sui.rpc.v2.Validator'),
  suiRpcV2StakingPool(typeUrl: '/sui.rpc.v2.StakingPool'),
  suiRpcV2TransactionEffects(typeUrl: '/sui.rpc.v2.TransactionEffects'),
  suiRpcV2ChangedObject(typeUrl: '/sui.rpc.v2.ChangedObject'),
  suiRpcV2EventDigestEntry(typeUrl: '/sui.rpc.v2.EventDigestEntry'),
  suiRpcV2AccumulatorWrite(typeUrl: '/sui.rpc.v2.AccumulatorWrite'),
  suiRpcV2UnchangedConsensusObject(
    typeUrl: '/sui.rpc.v2.UnchangedConsensusObject',
  ),
  suiRpcV2UserSignature(typeUrl: '/sui.rpc.v2.UserSignature'),
  suiRpcV2SimpleSignature(typeUrl: '/sui.rpc.v2.SimpleSignature'),
  suiRpcV2ZkLoginPublicIdentifier(
    typeUrl: '/sui.rpc.v2.ZkLoginPublicIdentifier',
  ),
  suiRpcV2MultisigMemberPublicKey(
    typeUrl: '/sui.rpc.v2.MultisigMemberPublicKey',
  ),
  suiRpcV2MultisigMember(typeUrl: '/sui.rpc.v2.MultisigMember'),
  suiRpcV2MultisigCommittee(typeUrl: '/sui.rpc.v2.MultisigCommittee'),
  suiRpcV2MultisigAggregatedSignature(
    typeUrl: '/sui.rpc.v2.MultisigAggregatedSignature',
  ),
  suiRpcV2MultisigMemberSignature(
    typeUrl: '/sui.rpc.v2.MultisigMemberSignature',
  ),
  suiRpcV2ZkLoginAuthenticator(typeUrl: '/sui.rpc.v2.ZkLoginAuthenticator'),
  suiRpcV2ZkLoginInputs(typeUrl: '/sui.rpc.v2.ZkLoginInputs'),
  suiRpcV2ZkLoginProof(typeUrl: '/sui.rpc.v2.ZkLoginProof'),
  suiRpcV2ZkLoginClaim(typeUrl: '/sui.rpc.v2.ZkLoginClaim'),
  suiRpcV2CircomG1(typeUrl: '/sui.rpc.v2.CircomG1'),
  suiRpcV2CircomG2(typeUrl: '/sui.rpc.v2.CircomG2'),
  suiRpcV2PasskeyAuthenticator(typeUrl: '/sui.rpc.v2.PasskeyAuthenticator'),
  suiRpcV2ValidatorCommittee(typeUrl: '/sui.rpc.v2.ValidatorCommittee'),
  suiRpcV2ValidatorCommitteeMember(
    typeUrl: '/sui.rpc.v2.ValidatorCommitteeMember',
  ),
  suiRpcV2ValidatorAggregatedSignature(
    typeUrl: '/sui.rpc.v2.ValidatorAggregatedSignature',
  ),
  suiRpcV2ExecutionStatus(typeUrl: '/sui.rpc.v2.ExecutionStatus'),
  suiRpcV2ExecutionError(typeUrl: '/sui.rpc.v2.ExecutionError'),
  suiRpcV2MoveAbort(typeUrl: '/sui.rpc.v2.MoveAbort'),
  suiRpcV2MoveLocation(typeUrl: '/sui.rpc.v2.MoveLocation'),
  suiRpcV2CleverError(typeUrl: '/sui.rpc.v2.CleverError'),
  suiRpcV2SizeError(typeUrl: '/sui.rpc.v2.SizeError'),
  suiRpcV2IndexError(typeUrl: '/sui.rpc.v2.IndexError'),
  suiRpcV2CoinDenyListError(typeUrl: '/sui.rpc.v2.CoinDenyListError'),
  suiRpcV2CongestedObjects(typeUrl: '/sui.rpc.v2.CongestedObjects'),
  suiRpcV2CommandArgumentError(typeUrl: '/sui.rpc.v2.CommandArgumentError'),
  suiRpcV2PackageUpgradeError(typeUrl: '/sui.rpc.v2.PackageUpgradeError'),
  suiRpcV2TypeArgumentError(typeUrl: '/sui.rpc.v2.TypeArgumentError'),
  suiRpcV2Object(typeUrl: '/sui.rpc.v2.Object'),
  suiRpcV2ObjectSet(typeUrl: '/sui.rpc.v2.ObjectSet'),
  suiRpcV2Display(typeUrl: '/sui.rpc.v2.Display'),
  suiRpcV2VerifySignatureRequest(
    typeUrl: '/sui.rpc.v2.VerifySignatureRequest',
    serviceUrl: "/sui.rpc.v2.SignatureVerificationService/VerifySignature",
  ),
  suiRpcV2VerifySignatureResponse(
    typeUrl: '/sui.rpc.v2.VerifySignatureResponse',
  ),
  suiRpcV2Epoch(typeUrl: '/sui.rpc.v2.Epoch'),
  suiRpcV2Package(typeUrl: '/sui.rpc.v2.Package'),
  suiRpcV2Module(typeUrl: '/sui.rpc.v2.Module'),
  suiRpcV2DatatypeDescriptor(typeUrl: '/sui.rpc.v2.DatatypeDescriptor'),
  suiRpcV2TypeParameter(typeUrl: '/sui.rpc.v2.TypeParameter'),
  suiRpcV2FieldDescriptor(typeUrl: '/sui.rpc.v2.FieldDescriptor'),
  suiRpcV2VariantDescriptor(typeUrl: '/sui.rpc.v2.VariantDescriptor'),
  suiRpcV2OpenSignatureBody(typeUrl: '/sui.rpc.v2.OpenSignatureBody'),
  suiRpcV2FunctionDescriptor(typeUrl: '/sui.rpc.v2.FunctionDescriptor'),
  suiRpcV2OpenSignature(typeUrl: '/sui.rpc.v2.OpenSignature'),
  suiRpcV2TypeOrigin(typeUrl: '/sui.rpc.v2.TypeOrigin'),
  suiRpcV2Linkage(typeUrl: '/sui.rpc.v2.Linkage'),
  suiRpcV2GetServiceInfoRequest(
    typeUrl: '/sui.rpc.v2.GetServiceInfoRequest',
    serviceUrl: "/sui.rpc.v2.LedgerService/GetServiceInfo",
  ),
  suiRpcV2GetServiceInfoResponse(typeUrl: '/sui.rpc.v2.GetServiceInfoResponse'),
  suiRpcV2GetObjectRequest(
    typeUrl: '/sui.rpc.v2.GetObjectRequest',
    serviceUrl: "/sui.rpc.v2.LedgerService/GetObject",
  ),
  suiRpcV2GetObjectResponse(typeUrl: '/sui.rpc.v2.GetObjectResponse'),
  suiRpcV2BatchGetObjectsRequest(
    typeUrl: '/sui.rpc.v2.BatchGetObjectsRequest',
    serviceUrl: "/sui.rpc.v2.LedgerService/BatchGetObjects",
  ),
  suiRpcV2BatchGetObjectsResponse(
    typeUrl: '/sui.rpc.v2.BatchGetObjectsResponse',
  ),
  suiRpcV2GetObjectResult(typeUrl: '/sui.rpc.v2.GetObjectResult'),
  suiRpcV2GetTransactionRequest(
    typeUrl: '/sui.rpc.v2.GetTransactionRequest',
    serviceUrl: "/sui.rpc.v2.LedgerService/GetTransaction",
  ),
  suiRpcV2GetTransactionResponse(typeUrl: '/sui.rpc.v2.GetTransactionResponse'),
  suiRpcV2BatchGetTransactionsRequest(
    typeUrl: '/sui.rpc.v2.BatchGetTransactionsRequest',
    serviceUrl: "/sui.rpc.v2.LedgerService/BatchGetTransactions",
  ),
  suiRpcV2BatchGetTransactionsResponse(
    typeUrl: '/sui.rpc.v2.BatchGetTransactionsResponse',
  ),
  suiRpcV2GetTransactionResult(typeUrl: '/sui.rpc.v2.GetTransactionResult'),
  suiRpcV2GetCheckpointRequest(
    typeUrl: '/sui.rpc.v2.GetCheckpointRequest',
    serviceUrl: "/sui.rpc.v2.LedgerService/GetCheckpoint",
  ),
  suiRpcV2GetCheckpointResponse(typeUrl: '/sui.rpc.v2.GetCheckpointResponse'),
  suiRpcV2GetEpochRequest(
    typeUrl: '/sui.rpc.v2.GetEpochRequest',
    serviceUrl: "/sui.rpc.v2.LedgerService/GetEpoch",
  ),
  suiRpcV2GetEpochResponse(typeUrl: '/sui.rpc.v2.GetEpochResponse'),
  suiRpcV2ListCheckpointsRequest(
    typeUrl: '/sui.rpc.v2.ListCheckpointsRequest',
    serviceUrl: "/sui.rpc.v2.LedgerService/ListCheckpoints",
  ),
  suiRpcV2ListCheckpointsResponse(
    typeUrl: '/sui.rpc.v2.ListCheckpointsResponse',
  ),
  suiRpcV2ListTransactionsRequest(
    typeUrl: '/sui.rpc.v2.ListTransactionsRequest',
    serviceUrl: "/sui.rpc.v2.LedgerService/ListTransactions",
  ),
  suiRpcV2ListTransactionsResponse(
    typeUrl: '/sui.rpc.v2.ListTransactionsResponse',
  ),
  suiRpcV2ListEventsRequest(
    typeUrl: '/sui.rpc.v2.ListEventsRequest',
    serviceUrl: "/sui.rpc.v2.LedgerService/ListEvents",
  ),
  suiRpcV2ListEventsResponse(typeUrl: '/sui.rpc.v2.ListEventsResponse'),
  suiRpcV2TransactionFilter(typeUrl: '/sui.rpc.v2.TransactionFilter'),
  suiRpcV2TransactionTerm(typeUrl: '/sui.rpc.v2.TransactionTerm'),
  suiRpcV2TransactionLiteral(typeUrl: '/sui.rpc.v2.TransactionLiteral'),
  suiRpcV2EventFilter(typeUrl: '/sui.rpc.v2.EventFilter'),
  suiRpcV2EventTerm(typeUrl: '/sui.rpc.v2.EventTerm'),
  suiRpcV2EventLiteral(typeUrl: '/sui.rpc.v2.EventLiteral'),
  suiRpcV2SenderFilter(typeUrl: '/sui.rpc.v2.SenderFilter'),
  suiRpcV2AffectedAddressFilter(typeUrl: '/sui.rpc.v2.AffectedAddressFilter'),
  suiRpcV2AffectedObjectFilter(typeUrl: '/sui.rpc.v2.AffectedObjectFilter'),
  suiRpcV2MoveCallFilter(typeUrl: '/sui.rpc.v2.MoveCallFilter'),
  suiRpcV2EmitModuleFilter(typeUrl: '/sui.rpc.v2.EmitModuleFilter'),
  suiRpcV2EventTypeFilter(typeUrl: '/sui.rpc.v2.EventTypeFilter'),
  suiRpcV2EventStreamHeadFilter(typeUrl: '/sui.rpc.v2.EventStreamHeadFilter'),
  suiRpcV2PackageWriteFilter(typeUrl: '/sui.rpc.v2.PackageWriteFilter'),
  suiRpcV2Transaction(typeUrl: '/sui.rpc.v2.Transaction'),
  suiRpcV2GasPayment(typeUrl: '/sui.rpc.v2.GasPayment'),
  suiRpcV2TransactionExpiration(typeUrl: '/sui.rpc.v2.TransactionExpiration'),
  suiRpcV2AllowedProposers(typeUrl: '/sui.rpc.v2.AllowedProposers'),
  suiRpcV2TransactionKind(typeUrl: '/sui.rpc.v2.TransactionKind'),
  suiRpcV2ProgrammableTransaction(
    typeUrl: '/sui.rpc.v2.ProgrammableTransaction',
  ),
  suiRpcV2Command(typeUrl: '/sui.rpc.v2.Command'),
  suiRpcV2MoveCall(typeUrl: '/sui.rpc.v2.MoveCall'),
  suiRpcV2TransferObjects(typeUrl: '/sui.rpc.v2.TransferObjects'),
  suiRpcV2SplitCoins(typeUrl: '/sui.rpc.v2.SplitCoins'),
  suiRpcV2MergeCoins(typeUrl: '/sui.rpc.v2.MergeCoins'),
  suiRpcV2Publish(typeUrl: '/sui.rpc.v2.Publish'),
  suiRpcV2MakeMoveVector(typeUrl: '/sui.rpc.v2.MakeMoveVector'),
  suiRpcV2Upgrade(typeUrl: '/sui.rpc.v2.Upgrade'),
  suiRpcV2RandomnessStateUpdate(typeUrl: '/sui.rpc.v2.RandomnessStateUpdate'),
  suiRpcV2ChangeEpoch(typeUrl: '/sui.rpc.v2.ChangeEpoch'),
  suiRpcV2SystemPackage(typeUrl: '/sui.rpc.v2.SystemPackage'),
  suiRpcV2GenesisTransaction(typeUrl: '/sui.rpc.v2.GenesisTransaction'),
  suiRpcV2ConsensusCommitPrologue(
    typeUrl: '/sui.rpc.v2.ConsensusCommitPrologue',
  ),
  suiRpcV2VersionAssignment(typeUrl: '/sui.rpc.v2.VersionAssignment'),
  suiRpcV2CanceledTransaction(typeUrl: '/sui.rpc.v2.CanceledTransaction'),
  suiRpcV2ConsensusDeterminedVersionAssignments(
    typeUrl: '/sui.rpc.v2.ConsensusDeterminedVersionAssignments',
  ),
  suiRpcV2AuthenticatorStateUpdate(
    typeUrl: '/sui.rpc.v2.AuthenticatorStateUpdate',
  ),
  suiRpcV2ActiveJwk(typeUrl: '/sui.rpc.v2.ActiveJwk'),
  suiRpcV2EndOfEpochTransaction(typeUrl: '/sui.rpc.v2.EndOfEpochTransaction'),
  suiRpcV2EndOfEpochTransactionKind(
    typeUrl: '/sui.rpc.v2.EndOfEpochTransactionKind',
  ),
  suiRpcV2AuthenticatorStateExpire(
    typeUrl: '/sui.rpc.v2.AuthenticatorStateExpire',
  ),
  suiRpcV2ExecutionTimeObservations(
    typeUrl: '/sui.rpc.v2.ExecutionTimeObservations',
  ),
  suiRpcV2ExecutionTimeObservation(
    typeUrl: '/sui.rpc.v2.ExecutionTimeObservation',
  ),
  suiRpcV2ValidatorExecutionTimeObservation(
    typeUrl: '/sui.rpc.v2.ValidatorExecutionTimeObservation',
  ),
  suiRpcV2JwkId(typeUrl: '/sui.rpc.v2.JwkId'),
  suiRpcV2Jwk(typeUrl: '/sui.rpc.v2.Jwk'),
  googleProtobufFieldMask(typeUrl: '/google.protobuf.FieldMask'),
  googleProtobufTimestamp(typeUrl: '/google.protobuf.Timestamp'),
  googleProtobufAny(typeUrl: '/google.protobuf.Any'),
  googleProtobufDuration(typeUrl: '/google.protobuf.Duration'),
  googleProtobufStruct(typeUrl: '/google.protobuf.Struct'),
  googleProtobufValue(typeUrl: '/google.protobuf.Value'),
  googleProtobufListValue(typeUrl: '/google.protobuf.ListValue'),
  googleProtobufEmpty(typeUrl: '/google.protobuf.Empty'),
  googleRpcStatus(typeUrl: '/google.rpc.Status'),
  googleRpcErrorInfo(typeUrl: '/google.rpc.ErrorInfo'),
  googleRpcRetryInfo(typeUrl: '/google.rpc.RetryInfo'),
  googleRpcDebugInfo(typeUrl: '/google.rpc.DebugInfo'),
  googleRpcQuotaFailure(typeUrl: '/google.rpc.QuotaFailure'),
  googleRpcQuotaFailureViolation(typeUrl: '/google.rpc.QuotaFailure.Violation'),
  googleRpcPreconditionFailure(typeUrl: '/google.rpc.PreconditionFailure'),
  googleRpcPreconditionFailureViolation(
    typeUrl: '/google.rpc.PreconditionFailure.Violation',
  ),
  googleRpcBadRequest(typeUrl: '/google.rpc.BadRequest'),
  googleRpcBadRequestFieldViolation(
    typeUrl: '/google.rpc.BadRequest.FieldViolation',
  ),
  googleRpcRequestInfo(typeUrl: '/google.rpc.RequestInfo'),
  googleRpcResourceInfo(typeUrl: '/google.rpc.ResourceInfo'),
  googleRpcHelp(typeUrl: '/google.rpc.Help'),
  googleRpcHelpLink(typeUrl: '/google.rpc.Help.Link'),
  googleRpcLocalizedMessage(typeUrl: '/google.rpc.LocalizedMessage');

  @override
  final String typeUrl;
  @override
  final String? serviceUrl;
  const DefaultSuiProtoTypeUrl({required this.typeUrl, this.serviceUrl});
  static DefaultSuiProtoTypeUrl? fromUrl(String? value) {
    return DefaultSuiProtoTypeUrl.values.firstWhereNullable(
      (e) => e.typeUrl == value || e.serviceUrl == value,
    );
  }

  @override
  String getServiceUrl() {
    final serviceUrl = this.serviceUrl;
    if (serviceUrl == null) {
      throw BuError(
        DefaultErrorType.notFound,
        "No matching item found for the given value. null",
      );
    }
    return serviceUrl;
  }
}
