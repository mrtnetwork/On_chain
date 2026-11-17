import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/serialization/protobuf/proto.dart';

enum DefaultTronProtoTypeUrl implements TronProtoTypeUrl {
  protocolEndpoint(typeUrl: '/protocol.Endpoint'),
  protocolPingMessage(typeUrl: '/protocol.PingMessage'),
  protocolPongMessage(typeUrl: '/protocol.PongMessage'),
  protocolFindNeighbours(typeUrl: '/protocol.FindNeighbours'),
  protocolNeighbours(typeUrl: '/protocol.Neighbours'),
  protocolBackupMessage(typeUrl: '/protocol.BackupMessage'),
  protocolWitnessCreateContract(typeUrl: '/protocol.WitnessCreateContract'),
  protocolWitnessUpdateContract(typeUrl: '/protocol.WitnessUpdateContract'),
  protocolVoteWitnessContract(typeUrl: '/protocol.VoteWitnessContract'),
  protocolVoteWitnessContractVote(
    typeUrl: '/protocol.VoteWitnessContract.Vote',
  ),
  protocolWalletVoteWitnessAccount(
    typeUrl: '/protocol.WalletVoteWitnessAccount',
    serviceUrl: "/protocol.Wallet/VoteWitnessAccount",
  ),
  protocolWalletVoteWitnessAccount2(
    typeUrl: '/protocol.WalletVoteWitnessAccount2',
    serviceUrl: "/protocol.Wallet/VoteWitnessAccount2",
  ),
  protocolWalletUpdateWitness(
    typeUrl: '/protocol.WalletUpdateWitness',
    serviceUrl: "/protocol.Wallet/UpdateWitness",
  ),
  protocolWalletUpdateWitness2(
    typeUrl: '/protocol.WalletUpdateWitness2',
    serviceUrl: "/protocol.Wallet/UpdateWitness2",
  ),
  protocolWalletCreateWitness(
    typeUrl: '/protocol.WalletCreateWitness',
    serviceUrl: "/protocol.Wallet/CreateWitness",
  ),
  protocolWalletCreateWitness2(
    typeUrl: '/protocol.WalletCreateWitness2',
    serviceUrl: "/protocol.Wallet/CreateWitness2",
  ),
  protocolAssetIssueContract(typeUrl: '/protocol.AssetIssueContract'),
  protocolAssetIssueContractFrozenSupply(
    typeUrl: '/protocol.AssetIssueContract.FrozenSupply',
  ),
  protocolTransferAssetContract(typeUrl: '/protocol.TransferAssetContract'),
  protocolUnfreezeAssetContract(typeUrl: '/protocol.UnfreezeAssetContract'),
  protocolUpdateAssetContract(typeUrl: '/protocol.UpdateAssetContract'),
  protocolParticipateAssetIssueContract(
    typeUrl: '/protocol.ParticipateAssetIssueContract',
  ),
  protocolWalletCreateAssetIssue(
    typeUrl: '/protocol.WalletCreateAssetIssue',
    serviceUrl: "/protocol.Wallet/CreateAssetIssue",
  ),
  protocolWalletCreateAssetIssue2(
    typeUrl: '/protocol.WalletCreateAssetIssue2',
    serviceUrl: "/protocol.Wallet/CreateAssetIssue2",
  ),
  protocolWalletTransferAsset(
    typeUrl: '/protocol.WalletTransferAsset',
    serviceUrl: "/protocol.Wallet/TransferAsset",
  ),
  protocolWalletTransferAsset2(
    typeUrl: '/protocol.WalletTransferAsset2',
    serviceUrl: "/protocol.Wallet/TransferAsset2",
  ),
  protocolWalletParticipateAssetIssue(
    typeUrl: '/protocol.WalletParticipateAssetIssue',
    serviceUrl: "/protocol.Wallet/ParticipateAssetIssue",
  ),
  protocolWalletParticipateAssetIssue2(
    typeUrl: '/protocol.WalletParticipateAssetIssue2',
    serviceUrl: "/protocol.Wallet/ParticipateAssetIssue2",
  ),
  protocolWalletUnfreezeAsset(
    typeUrl: '/protocol.WalletUnfreezeAsset',
    serviceUrl: "/protocol.Wallet/UnfreezeAsset",
  ),
  protocolWalletUnfreezeAsset2(
    typeUrl: '/protocol.WalletUnfreezeAsset2',
    serviceUrl: "/protocol.Wallet/UnfreezeAsset2",
  ),
  protocolWalletUpdateAsset(
    typeUrl: '/protocol.WalletUpdateAsset',
    serviceUrl: "/protocol.Wallet/UpdateAsset",
  ),
  protocolWalletUpdateAsset2(
    typeUrl: '/protocol.WalletUpdateAsset2',
    serviceUrl: "/protocol.Wallet/UpdateAsset2",
  ),
  protocolVoteAssetContract(typeUrl: '/protocol.VoteAssetContract'),
  protocolAuthenticationPath(typeUrl: '/protocol.AuthenticationPath'),
  protocolMerklePath(typeUrl: '/protocol.MerklePath'),
  protocolOutputPoint(typeUrl: '/protocol.OutputPoint'),
  protocolOutputPointInfo(typeUrl: '/protocol.OutputPointInfo'),
  protocolPedersenHash(typeUrl: '/protocol.PedersenHash'),
  protocolIncrementalMerkleTree(typeUrl: '/protocol.IncrementalMerkleTree'),
  protocolIncrementalMerkleVoucher(
    typeUrl: '/protocol.IncrementalMerkleVoucher',
  ),
  protocolIncrementalMerkleVoucherInfo(
    typeUrl: '/protocol.IncrementalMerkleVoucherInfo',
  ),
  protocolSpendDescription(typeUrl: '/protocol.SpendDescription'),
  protocolReceiveDescription(typeUrl: '/protocol.ReceiveDescription'),
  protocolShieldedTransferContract(
    typeUrl: '/protocol.ShieldedTransferContract',
  ),
  protocolWalletGetMerkleTreeVoucherInfo(
    typeUrl: '/protocol.WalletGetMerkleTreeVoucherInfo',
    serviceUrl: "/protocol.Wallet/GetMerkleTreeVoucherInfo",
  ),
  protocolWalletSolidityGetMerkleTreeVoucherInfo(
    typeUrl: '/protocol.WalletSolidityGetMerkleTreeVoucherInfo',
    serviceUrl: "/protocol.WalletSolidity/GetMerkleTreeVoucherInfo",
  ),
  protocolFreezeBalanceContract(typeUrl: '/protocol.FreezeBalanceContract'),
  protocolUnfreezeBalanceContract(typeUrl: '/protocol.UnfreezeBalanceContract'),
  protocolWithdrawBalanceContract(typeUrl: '/protocol.WithdrawBalanceContract'),
  protocolTransferContract(typeUrl: '/protocol.TransferContract'),
  protocolTransactionBalanceTrace(typeUrl: '/protocol.TransactionBalanceTrace'),
  protocolTransactionBalanceTraceOperation(
    typeUrl: '/protocol.TransactionBalanceTrace.Operation',
  ),
  protocolBlockBalanceTrace(typeUrl: '/protocol.BlockBalanceTrace'),
  protocolBlockBalanceTraceBlockIdentifier(
    typeUrl: '/protocol.BlockBalanceTrace.BlockIdentifier',
  ),
  protocolAccountTrace(typeUrl: '/protocol.AccountTrace'),
  protocolAccountIdentifier(typeUrl: '/protocol.AccountIdentifier'),
  protocolAccountBalanceRequest(typeUrl: '/protocol.AccountBalanceRequest'),
  protocolAccountBalanceResponse(typeUrl: '/protocol.AccountBalanceResponse'),
  protocolFreezeBalanceV2Contract(typeUrl: '/protocol.FreezeBalanceV2Contract'),
  protocolUnfreezeBalanceV2Contract(
    typeUrl: '/protocol.UnfreezeBalanceV2Contract',
  ),
  protocolWithdrawExpireUnfreezeContract(
    typeUrl: '/protocol.WithdrawExpireUnfreezeContract',
  ),
  protocolDelegateResourceContract(
    typeUrl: '/protocol.DelegateResourceContract',
  ),
  protocolUnDelegateResourceContract(
    typeUrl: '/protocol.UnDelegateResourceContract',
  ),
  protocolCancelAllUnfreezeV2Contract(
    typeUrl: '/protocol.CancelAllUnfreezeV2Contract',
  ),
  protocolWalletGetAccountBalance(
    typeUrl: '/protocol.WalletGetAccountBalance',
    serviceUrl: "/protocol.Wallet/GetAccountBalance",
  ),
  protocolWalletGetBlockBalanceTrace(
    typeUrl: '/protocol.WalletGetBlockBalanceTrace',
    serviceUrl: "/protocol.Wallet/GetBlockBalanceTrace",
  ),
  protocolWalletCreateTransaction(
    typeUrl: '/protocol.WalletCreateTransaction',
    serviceUrl: "/protocol.Wallet/CreateTransaction",
  ),
  protocolWalletCreateTransaction2(
    typeUrl: '/protocol.WalletCreateTransaction2',
    serviceUrl: "/protocol.Wallet/CreateTransaction2",
  ),
  protocolWalletFreezeBalance(
    typeUrl: '/protocol.WalletFreezeBalance',
    serviceUrl: "/protocol.Wallet/FreezeBalance",
  ),
  protocolWalletFreezeBalance2(
    typeUrl: '/protocol.WalletFreezeBalance2',
    serviceUrl: "/protocol.Wallet/FreezeBalance2",
  ),
  protocolWalletFreezeBalanceV2(
    typeUrl: '/protocol.WalletFreezeBalanceV2',
    serviceUrl: "/protocol.Wallet/FreezeBalanceV2",
  ),
  protocolWalletUnfreezeBalance(
    typeUrl: '/protocol.WalletUnfreezeBalance',
    serviceUrl: "/protocol.Wallet/UnfreezeBalance",
  ),
  protocolWalletUnfreezeBalance2(
    typeUrl: '/protocol.WalletUnfreezeBalance2',
    serviceUrl: "/protocol.Wallet/UnfreezeBalance2",
  ),
  protocolWalletUnfreezeBalanceV2(
    typeUrl: '/protocol.WalletUnfreezeBalanceV2',
    serviceUrl: "/protocol.Wallet/UnfreezeBalanceV2",
  ),
  protocolWalletWithdrawBalance(
    typeUrl: '/protocol.WalletWithdrawBalance',
    serviceUrl: "/protocol.Wallet/WithdrawBalance",
  ),
  protocolWalletWithdrawBalance2(
    typeUrl: '/protocol.WalletWithdrawBalance2',
    serviceUrl: "/protocol.Wallet/WithdrawBalance2",
  ),
  protocolWalletWithdrawExpireUnfreeze(
    typeUrl: '/protocol.WalletWithdrawExpireUnfreeze',
    serviceUrl: "/protocol.Wallet/WithdrawExpireUnfreeze",
  ),
  protocolWalletDelegateResource(
    typeUrl: '/protocol.WalletDelegateResource',
    serviceUrl: "/protocol.Wallet/DelegateResource",
  ),
  protocolWalletUnDelegateResource(
    typeUrl: '/protocol.WalletUnDelegateResource',
    serviceUrl: "/protocol.Wallet/UnDelegateResource",
  ),
  protocolWalletCancelAllUnfreezeV2(
    typeUrl: '/protocol.WalletCancelAllUnfreezeV2',
    serviceUrl: "/protocol.Wallet/CancelAllUnfreezeV2",
  ),
  protocolAccountCreateContract(typeUrl: '/protocol.AccountCreateContract'),
  protocolAccountUpdateContract(typeUrl: '/protocol.AccountUpdateContract'),
  protocolSetAccountIdContract(typeUrl: '/protocol.SetAccountIdContract'),
  protocolAccountPermissionUpdateContract(
    typeUrl: '/protocol.AccountPermissionUpdateContract',
  ),
  protocolWalletUpdateAccount(
    typeUrl: '/protocol.WalletUpdateAccount',
    serviceUrl: "/protocol.Wallet/UpdateAccount",
  ),
  protocolWalletSetAccountId(
    typeUrl: '/protocol.WalletSetAccountId',
    serviceUrl: "/protocol.Wallet/SetAccountId",
  ),
  protocolWalletUpdateAccount2(
    typeUrl: '/protocol.WalletUpdateAccount2',
    serviceUrl: "/protocol.Wallet/UpdateAccount2",
  ),
  protocolWalletCreateAccount(
    typeUrl: '/protocol.WalletCreateAccount',
    serviceUrl: "/protocol.Wallet/CreateAccount",
  ),
  protocolWalletCreateAccount2(
    typeUrl: '/protocol.WalletCreateAccount2',
    serviceUrl: "/protocol.Wallet/CreateAccount2",
  ),
  protocolWalletAccountPermissionUpdate(
    typeUrl: '/protocol.WalletAccountPermissionUpdate',
    serviceUrl: "/protocol.Wallet/AccountPermissionUpdate",
  ),
  protocolExchangeCreateContract(typeUrl: '/protocol.ExchangeCreateContract'),
  protocolExchangeInjectContract(typeUrl: '/protocol.ExchangeInjectContract'),
  protocolExchangeWithdrawContract(
    typeUrl: '/protocol.ExchangeWithdrawContract',
  ),
  protocolExchangeTransactionContract(
    typeUrl: '/protocol.ExchangeTransactionContract',
  ),
  protocolWalletExchangeCreate(
    typeUrl: '/protocol.WalletExchangeCreate',
    serviceUrl: "/protocol.Wallet/ExchangeCreate",
  ),
  protocolWalletExchangeInject(
    typeUrl: '/protocol.WalletExchangeInject',
    serviceUrl: "/protocol.Wallet/ExchangeInject",
  ),
  protocolWalletExchangeWithdraw(
    typeUrl: '/protocol.WalletExchangeWithdraw',
    serviceUrl: "/protocol.Wallet/ExchangeWithdraw",
  ),
  protocolWalletExchangeTransaction(
    typeUrl: '/protocol.WalletExchangeTransaction',
    serviceUrl: "/protocol.Wallet/ExchangeTransaction",
  ),
  protocolMarketSellAssetContract(typeUrl: '/protocol.MarketSellAssetContract'),
  protocolMarketCancelOrderContract(
    typeUrl: '/protocol.MarketCancelOrderContract',
  ),
  protocolWalletMarketSellAsset(
    typeUrl: '/protocol.WalletMarketSellAsset',
    serviceUrl: "/protocol.Wallet/MarketSellAsset",
  ),
  protocolWalletMarketCancelOrder(
    typeUrl: '/protocol.WalletMarketCancelOrder',
    serviceUrl: "/protocol.Wallet/MarketCancelOrder",
  ),
  protocolBuyStorageBytesContract(typeUrl: '/protocol.BuyStorageBytesContract'),
  protocolBuyStorageContract(typeUrl: '/protocol.BuyStorageContract'),
  protocolSellStorageContract(typeUrl: '/protocol.SellStorageContract'),
  protocolUpdateBrokerageContract(typeUrl: '/protocol.UpdateBrokerageContract'),
  protocolWalletBuyStorage(
    typeUrl: '/protocol.WalletBuyStorage',
    serviceUrl: "/protocol.Wallet/BuyStorage",
  ),
  protocolWalletBuyStorageBytes(
    typeUrl: '/protocol.WalletBuyStorageBytes',
    serviceUrl: "/protocol.Wallet/BuyStorageBytes",
  ),
  protocolWalletSellStorage(
    typeUrl: '/protocol.WalletSellStorage',
    serviceUrl: "/protocol.Wallet/SellStorage",
  ),
  protocolWalletUpdateBrokerage(
    typeUrl: '/protocol.WalletUpdateBrokerage',
    serviceUrl: "/protocol.Wallet/UpdateBrokerage",
  ),
  protocolSmartContract(typeUrl: '/protocol.SmartContract'),
  protocolSmartContractAbi(typeUrl: '/protocol.SmartContract.ABI'),
  protocolSmartContractAbiEntry(typeUrl: '/protocol.SmartContract.ABI.Entry'),
  protocolSmartContractAbiEntryParam(
    typeUrl: '/protocol.SmartContract.ABI.Entry.Param',
  ),
  protocolContractState(typeUrl: '/protocol.ContractState'),
  protocolCreateSmartContract(typeUrl: '/protocol.CreateSmartContract'),
  protocolTriggerSmartContract(typeUrl: '/protocol.TriggerSmartContract'),
  protocolClearABIContract(typeUrl: '/protocol.ClearABIContract'),
  protocolUpdateSettingContract(typeUrl: '/protocol.UpdateSettingContract'),
  protocolUpdateEnergyLimitContract(
    typeUrl: '/protocol.UpdateEnergyLimitContract',
  ),
  protocolSmartContractDataWrapper(
    typeUrl: '/protocol.SmartContractDataWrapper',
  ),
  protocolWalletUpdateSetting(
    typeUrl: '/protocol.WalletUpdateSetting',
    serviceUrl: "/protocol.Wallet/UpdateSetting",
  ),
  protocolWalletUpdateEnergyLimit(
    typeUrl: '/protocol.WalletUpdateEnergyLimit',
    serviceUrl: "/protocol.Wallet/UpdateEnergyLimit",
  ),
  protocolWalletDeployContract(
    typeUrl: '/protocol.WalletDeployContract',
    serviceUrl: "/protocol.Wallet/DeployContract",
  ),
  protocolWalletTriggerContract(
    typeUrl: '/protocol.WalletTriggerContract',
    serviceUrl: "/protocol.Wallet/TriggerContract",
  ),
  protocolWalletTriggerConstantContract(
    typeUrl: '/protocol.WalletTriggerConstantContract',
    serviceUrl: "/protocol.Wallet/TriggerConstantContract",
  ),
  protocolWalletEstimateEnergy(
    typeUrl: '/protocol.WalletEstimateEnergy',
    serviceUrl: "/protocol.Wallet/EstimateEnergy",
  ),
  protocolWalletClearContractABI(
    typeUrl: '/protocol.WalletClearContractABI',
    serviceUrl: "/protocol.Wallet/ClearContractABI",
  ),
  protocolWalletSolidityTriggerConstantContract(
    typeUrl: '/protocol.WalletSolidityTriggerConstantContract',
    serviceUrl: "/protocol.WalletSolidity/TriggerConstantContract",
  ),
  protocolWalletSolidityEstimateEnergy(
    typeUrl: '/protocol.WalletSolidityEstimateEnergy',
    serviceUrl: "/protocol.WalletSolidity/EstimateEnergy",
  ),
  protocolProposalApproveContract(typeUrl: '/protocol.ProposalApproveContract'),
  protocolProposalCreateContract(typeUrl: '/protocol.ProposalCreateContract'),
  protocolProposalDeleteContract(typeUrl: '/protocol.ProposalDeleteContract'),
  protocolWalletProposalCreate(
    typeUrl: '/protocol.WalletProposalCreate',
    serviceUrl: "/protocol.Wallet/ProposalCreate",
  ),
  protocolWalletProposalApprove(
    typeUrl: '/protocol.WalletProposalApprove',
    serviceUrl: "/protocol.Wallet/ProposalApprove",
  ),
  protocolWalletProposalDelete(
    typeUrl: '/protocol.WalletProposalDelete',
    serviceUrl: "/protocol.Wallet/ProposalDelete",
  ),
  protocolAccountId(typeUrl: '/protocol.AccountId'),
  protocolVote(typeUrl: '/protocol.Vote'),
  protocolProposal(typeUrl: '/protocol.Proposal'),
  protocolExchange(typeUrl: '/protocol.Exchange'),
  protocolMarketOrder(typeUrl: '/protocol.MarketOrder'),
  protocolMarketOrderList(typeUrl: '/protocol.MarketOrderList'),
  protocolMarketOrderPairList(typeUrl: '/protocol.MarketOrderPairList'),
  protocolMarketOrderPair(typeUrl: '/protocol.MarketOrderPair'),
  protocolMarketAccountOrder(typeUrl: '/protocol.MarketAccountOrder'),
  protocolMarketPrice(typeUrl: '/protocol.MarketPrice'),
  protocolMarketPriceList(typeUrl: '/protocol.MarketPriceList'),
  protocolMarketOrderIdList(typeUrl: '/protocol.MarketOrderIdList'),
  protocolChainParameters(typeUrl: '/protocol.ChainParameters'),
  protocolChainParametersChainParameter(
    typeUrl: '/protocol.ChainParameters.ChainParameter',
  ),
  protocolAccount(typeUrl: '/protocol.Account'),
  protocolAccountFrozen(typeUrl: '/protocol.Account.Frozen'),
  protocolAccountAccountResource(typeUrl: '/protocol.Account.AccountResource'),
  protocolAccountFreezeV2(typeUrl: '/protocol.Account.FreezeV2'),
  protocolAccountUnFreezeV2(typeUrl: '/protocol.Account.UnFreezeV2'),
  protocolKey(typeUrl: '/protocol.Key'),
  protocolDelegatedResource(typeUrl: '/protocol.DelegatedResource'),
  protocolAuthority(typeUrl: '/protocol.authority'),
  protocolPermission(typeUrl: '/protocol.Permission'),
  protocolWitness(typeUrl: '/protocol.Witness'),
  protocolVotes(typeUrl: '/protocol.Votes'),
  protocolTXOutput(typeUrl: '/protocol.TXOutput'),
  protocolTXInput(typeUrl: '/protocol.TXInput'),
  protocolTXInputRaw(typeUrl: '/protocol.TXInput.raw'),
  protocolTXOutputs(typeUrl: '/protocol.TXOutputs'),
  protocolResourceReceipt(typeUrl: '/protocol.ResourceReceipt'),
  protocolMarketOrderDetail(typeUrl: '/protocol.MarketOrderDetail'),
  protocolTransaction(typeUrl: '/protocol.Transaction'),
  protocolTransactionContract(typeUrl: '/protocol.Transaction.Contract'),
  protocolTransactionResult(typeUrl: '/protocol.Transaction.Result'),
  protocolTransactionRaw(typeUrl: '/protocol.Transaction.raw'),
  protocolTransactionInfo(typeUrl: '/protocol.TransactionInfo'),
  protocolTransactionInfoLog(typeUrl: '/protocol.TransactionInfo.Log'),
  protocolTransactionRet(typeUrl: '/protocol.TransactionRet'),
  protocolTransactions(typeUrl: '/protocol.Transactions'),
  protocolBlockHeader(typeUrl: '/protocol.BlockHeader'),
  protocolBlockHeaderRaw(typeUrl: '/protocol.BlockHeader.raw'),
  protocolBlock(typeUrl: '/protocol.Block'),
  protocolChainInventory(typeUrl: '/protocol.ChainInventory'),
  protocolChainInventoryBlockId(typeUrl: '/protocol.ChainInventory.BlockId'),
  protocolBlockInventory(typeUrl: '/protocol.BlockInventory'),
  protocolBlockInventoryBlockId(typeUrl: '/protocol.BlockInventory.BlockId'),
  protocolInventory(typeUrl: '/protocol.Inventory'),
  protocolItems(typeUrl: '/protocol.Items'),
  protocolDynamicProperties(typeUrl: '/protocol.DynamicProperties'),
  protocolDisconnectMessage(typeUrl: '/protocol.DisconnectMessage'),
  protocolHelloMessage(typeUrl: '/protocol.HelloMessage'),
  protocolHelloMessageBlockId(typeUrl: '/protocol.HelloMessage.BlockId'),
  protocolInternalTransaction(typeUrl: '/protocol.InternalTransaction'),
  protocolInternalTransactionCallValueInfo(
    typeUrl: '/protocol.InternalTransaction.CallValueInfo',
  ),
  protocolDelegatedResourceAccountIndex(
    typeUrl: '/protocol.DelegatedResourceAccountIndex',
  ),
  protocolNodeInfo(typeUrl: '/protocol.NodeInfo'),
  protocolNodeInfoPeerInfo(typeUrl: '/protocol.NodeInfo.PeerInfo'),
  protocolNodeInfoConfigNodeInfo(typeUrl: '/protocol.NodeInfo.ConfigNodeInfo'),
  protocolNodeInfoMachineInfo(typeUrl: '/protocol.NodeInfo.MachineInfo'),
  protocolNodeInfoMachineInfoMemoryDescInfo(
    typeUrl: '/protocol.NodeInfo.MachineInfo.MemoryDescInfo',
  ),
  protocolNodeInfoMachineInfoDeadLockThreadInfo(
    typeUrl: '/protocol.NodeInfo.MachineInfo.DeadLockThreadInfo',
  ),
  protocolMetricsInfo(typeUrl: '/protocol.MetricsInfo'),
  protocolMetricsInfoNodeInfo(typeUrl: '/protocol.MetricsInfo.NodeInfo'),
  protocolMetricsInfoBlockChainInfo(
    typeUrl: '/protocol.MetricsInfo.BlockChainInfo',
  ),
  protocolMetricsInfoBlockChainInfoWitness(
    typeUrl: '/protocol.MetricsInfo.BlockChainInfo.Witness',
  ),
  protocolMetricsInfoBlockChainInfoDupWitness(
    typeUrl: '/protocol.MetricsInfo.BlockChainInfo.DupWitness',
  ),
  protocolMetricsInfoRateInfo(typeUrl: '/protocol.MetricsInfo.RateInfo'),
  protocolMetricsInfoNetInfo(typeUrl: '/protocol.MetricsInfo.NetInfo'),
  protocolMetricsInfoNetInfoApiInfo(
    typeUrl: '/protocol.MetricsInfo.NetInfo.ApiInfo',
  ),
  protocolMetricsInfoNetInfoApiInfoApiDetailInfo(
    typeUrl: '/protocol.MetricsInfo.NetInfo.ApiInfo.ApiDetailInfo',
  ),
  protocolMetricsInfoNetInfoDisconnectionDetailInfo(
    typeUrl: '/protocol.MetricsInfo.NetInfo.DisconnectionDetailInfo',
  ),
  protocolMetricsInfoNetInfoLatencyInfo(
    typeUrl: '/protocol.MetricsInfo.NetInfo.LatencyInfo',
  ),
  protocolMetricsInfoNetInfoLatencyInfoLatencyDetailInfo(
    typeUrl: '/protocol.MetricsInfo.NetInfo.LatencyInfo.LatencyDetailInfo',
  ),
  protocolPBFTMessage(typeUrl: '/protocol.PBFTMessage'),
  protocolPBFTMessageRaw(typeUrl: '/protocol.PBFTMessage.Raw'),
  protocolPBFTCommitResult(typeUrl: '/protocol.PBFTCommitResult'),
  protocolSrl(typeUrl: '/protocol.SRL'),
  protocolWalletGetAccount(
    typeUrl: '/protocol.WalletGetAccount',
    serviceUrl: "/protocol.Wallet/GetAccount",
  ),
  protocolWalletGetAccountById(
    typeUrl: '/protocol.WalletGetAccountById',
    serviceUrl: "/protocol.Wallet/GetAccountById",
  ),
  protocolWalletBroadcastTransaction(
    typeUrl: '/protocol.WalletBroadcastTransaction',
    serviceUrl: "/protocol.Wallet/BroadcastTransaction",
  ),
  protocolWalletGetMarketPriceByPair(
    typeUrl: '/protocol.WalletGetMarketPriceByPair',
    serviceUrl: "/protocol.Wallet/GetMarketPriceByPair",
  ),
  protocolWalletGetMarketOrderListByPair(
    typeUrl: '/protocol.WalletGetMarketOrderListByPair',
    serviceUrl: "/protocol.Wallet/GetMarketOrderListByPair",
  ),
  protocolWalletGetAssetIssueByAccount(
    typeUrl: '/protocol.WalletGetAssetIssueByAccount',
    serviceUrl: "/protocol.Wallet/GetAssetIssueByAccount",
  ),
  protocolWalletGetAccountNet(
    typeUrl: '/protocol.WalletGetAccountNet',
    serviceUrl: "/protocol.Wallet/GetAccountNet",
  ),
  protocolWalletGetAccountResource(
    typeUrl: '/protocol.WalletGetAccountResource',
    serviceUrl: "/protocol.Wallet/GetAccountResource",
  ),
  protocolWalletGetTransactionSignWeight(
    typeUrl: '/protocol.WalletGetTransactionSignWeight',
    serviceUrl: "/protocol.Wallet/GetTransactionSignWeight",
  ),
  protocolWalletGetTransactionApprovedList(
    typeUrl: '/protocol.WalletGetTransactionApprovedList',
    serviceUrl: "/protocol.Wallet/GetTransactionApprovedList",
  ),
  protocolWalletGetShieldTransactionHash(
    typeUrl: '/protocol.WalletGetShieldTransactionHash',
    serviceUrl: "/protocol.Wallet/GetShieldTransactionHash",
  ),
  protocolWalletCreateCommonTransaction(
    typeUrl: '/protocol.WalletCreateCommonTransaction',
    serviceUrl: "/protocol.Wallet/CreateCommonTransaction",
  ),
  protocolWalletSolidityGetAccount(
    typeUrl: '/protocol.WalletSolidityGetAccount',
    serviceUrl: "/protocol.WalletSolidity/GetAccount",
  ),
  protocolWalletSolidityGetAccountById(
    typeUrl: '/protocol.WalletSolidityGetAccountById',
    serviceUrl: "/protocol.WalletSolidity/GetAccountById",
  ),
  protocolWalletSolidityGetMarketPriceByPair(
    typeUrl: '/protocol.WalletSolidityGetMarketPriceByPair',
    serviceUrl: "/protocol.WalletSolidity/GetMarketPriceByPair",
  ),
  protocolWalletSolidityGetMarketOrderListByPair(
    typeUrl: '/protocol.WalletSolidityGetMarketOrderListByPair',
    serviceUrl: "/protocol.WalletSolidity/GetMarketOrderListByPair",
  ),
  protocolInventoryItems(typeUrl: '/protocol.InventoryItems'),
  protocolReturn(typeUrl: '/protocol.Return'),
  protocolBlockReference(typeUrl: '/protocol.BlockReference'),
  protocolWitnessList(typeUrl: '/protocol.WitnessList'),
  protocolProposalList(typeUrl: '/protocol.ProposalList'),
  protocolExchangeList(typeUrl: '/protocol.ExchangeList'),
  protocolAssetIssueList(typeUrl: '/protocol.AssetIssueList'),
  protocolBlockList(typeUrl: '/protocol.BlockList'),
  protocolTransactionList(typeUrl: '/protocol.TransactionList'),
  protocolTransactionIdList(typeUrl: '/protocol.TransactionIdList'),
  protocolDelegatedResourceMessage(
    typeUrl: '/protocol.DelegatedResourceMessage',
  ),
  protocolDelegatedResourceList(typeUrl: '/protocol.DelegatedResourceList'),
  protocolGetAvailableUnfreezeCountRequestMessage(
    typeUrl: '/protocol.GetAvailableUnfreezeCountRequestMessage',
  ),
  protocolGetAvailableUnfreezeCountResponseMessage(
    typeUrl: '/protocol.GetAvailableUnfreezeCountResponseMessage',
  ),
  protocolCanDelegatedMaxSizeRequestMessage(
    typeUrl: '/protocol.CanDelegatedMaxSizeRequestMessage',
  ),
  protocolCanDelegatedMaxSizeResponseMessage(
    typeUrl: '/protocol.CanDelegatedMaxSizeResponseMessage',
  ),
  protocolCanWithdrawUnfreezeAmountRequestMessage(
    typeUrl: '/protocol.CanWithdrawUnfreezeAmountRequestMessage',
  ),
  protocolCanWithdrawUnfreezeAmountResponseMessage(
    typeUrl: '/protocol.CanWithdrawUnfreezeAmountResponseMessage',
  ),
  protocolPricesResponseMessage(typeUrl: '/protocol.PricesResponseMessage'),
  protocolNodeList(typeUrl: '/protocol.NodeList'),
  protocolNode(typeUrl: '/protocol.Node'),
  protocolAddress(typeUrl: '/protocol.Address'),
  protocolEmptyMessage(typeUrl: '/protocol.EmptyMessage'),
  protocolNumberMessage(typeUrl: '/protocol.NumberMessage'),
  protocolBytesMessage(typeUrl: '/protocol.BytesMessage'),
  protocolTimeMessage(typeUrl: '/protocol.TimeMessage'),
  protocolBlockReq(typeUrl: '/protocol.BlockReq'),
  protocolBlockLimit(typeUrl: '/protocol.BlockLimit'),
  protocolTransactionLimit(typeUrl: '/protocol.TransactionLimit'),
  protocolAccountPaginated(typeUrl: '/protocol.AccountPaginated'),
  protocolTimePaginatedMessage(typeUrl: '/protocol.TimePaginatedMessage'),
  protocolAccountNetMessage(typeUrl: '/protocol.AccountNetMessage'),
  protocolAccountResourceMessage(typeUrl: '/protocol.AccountResourceMessage'),
  protocolPaginatedMessage(typeUrl: '/protocol.PaginatedMessage'),
  protocolTransactionExtention(typeUrl: '/protocol.TransactionExtention'),
  protocolEstimateEnergyMessage(typeUrl: '/protocol.EstimateEnergyMessage'),
  protocolBlockExtention(typeUrl: '/protocol.BlockExtention'),
  protocolBlockListExtention(typeUrl: '/protocol.BlockListExtention'),
  protocolTransactionListExtention(
    typeUrl: '/protocol.TransactionListExtention',
  ),
  protocolBlockIncrementalMerkleTree(
    typeUrl: '/protocol.BlockIncrementalMerkleTree',
  ),
  protocolTransactionSignWeight(typeUrl: '/protocol.TransactionSignWeight'),
  protocolTransactionSignWeightResult(
    typeUrl: '/protocol.TransactionSignWeight.Result',
  ),
  protocolTransactionApprovedList(typeUrl: '/protocol.TransactionApprovedList'),
  protocolTransactionApprovedListResult(
    typeUrl: '/protocol.TransactionApprovedList.Result',
  ),
  protocolIvkDecryptParameters(typeUrl: '/protocol.IvkDecryptParameters'),
  protocolIvkDecryptAndMarkParameters(
    typeUrl: '/protocol.IvkDecryptAndMarkParameters',
  ),
  protocolOvkDecryptParameters(typeUrl: '/protocol.OvkDecryptParameters'),
  protocolDecryptNotes(typeUrl: '/protocol.DecryptNotes'),
  protocolDecryptNotesNoteTx(typeUrl: '/protocol.DecryptNotes.NoteTx'),
  protocolDecryptNotesMarked(typeUrl: '/protocol.DecryptNotesMarked'),
  protocolDecryptNotesMarkedNoteTx(
    typeUrl: '/protocol.DecryptNotesMarked.NoteTx',
  ),
  protocolNote(typeUrl: '/protocol.Note'),
  protocolSpendNote(typeUrl: '/protocol.SpendNote'),
  protocolReceiveNote(typeUrl: '/protocol.ReceiveNote'),
  protocolPrivateParameters(typeUrl: '/protocol.PrivateParameters'),
  protocolPrivateParametersWithoutAsk(
    typeUrl: '/protocol.PrivateParametersWithoutAsk',
  ),
  protocolSpendAuthSigParameters(typeUrl: '/protocol.SpendAuthSigParameters'),
  protocolNfParameters(typeUrl: '/protocol.NfParameters'),
  protocolExpandedSpendingKeyMessage(
    typeUrl: '/protocol.ExpandedSpendingKeyMessage',
  ),
  protocolViewingKeyMessage(typeUrl: '/protocol.ViewingKeyMessage'),
  protocolIncomingViewingKeyMessage(
    typeUrl: '/protocol.IncomingViewingKeyMessage',
  ),
  protocolDiversifierMessage(typeUrl: '/protocol.DiversifierMessage'),
  protocolIncomingViewingKeyDiversifierMessage(
    typeUrl: '/protocol.IncomingViewingKeyDiversifierMessage',
  ),
  protocolPaymentAddressMessage(typeUrl: '/protocol.PaymentAddressMessage'),
  protocolShieldedAddressInfo(typeUrl: '/protocol.ShieldedAddressInfo'),
  protocolNoteParameters(typeUrl: '/protocol.NoteParameters'),
  protocolSpendResult(typeUrl: '/protocol.SpendResult'),
  protocolTransactionInfoList(typeUrl: '/protocol.TransactionInfoList'),
  protocolSpendNoteTRC20(typeUrl: '/protocol.SpendNoteTRC20'),
  protocolPrivateShieldedTRC20Parameters(
    typeUrl: '/protocol.PrivateShieldedTRC20Parameters',
  ),
  protocolPrivateShieldedTRC20ParametersWithoutAsk(
    typeUrl: '/protocol.PrivateShieldedTRC20ParametersWithoutAsk',
  ),
  protocolShieldedTRC20Parameters(typeUrl: '/protocol.ShieldedTRC20Parameters'),
  protocolIvkDecryptTRC20Parameters(
    typeUrl: '/protocol.IvkDecryptTRC20Parameters',
  ),
  protocolOvkDecryptTRC20Parameters(
    typeUrl: '/protocol.OvkDecryptTRC20Parameters',
  ),
  protocolDecryptNotesTRC20(typeUrl: '/protocol.DecryptNotesTRC20'),
  protocolDecryptNotesTRC20NoteTx(
    typeUrl: '/protocol.DecryptNotesTRC20.NoteTx',
  ),
  protocolNfTRC20Parameters(typeUrl: '/protocol.NfTRC20Parameters'),
  protocolNullifierResult(typeUrl: '/protocol.NullifierResult'),
  protocolShieldedTRC20TriggerContractParameters(
    typeUrl: '/protocol.ShieldedTRC20TriggerContractParameters',
  ),
  protocolWalletGetMarketOrderById(
    typeUrl: '/protocol.WalletGetMarketOrderById',
    serviceUrl: "/protocol.Wallet/GetMarketOrderById",
  ),
  protocolWalletGetMarketOrderByAccount(
    typeUrl: '/protocol.WalletGetMarketOrderByAccount',
    serviceUrl: "/protocol.Wallet/GetMarketOrderByAccount",
  ),
  protocolWalletGetMarketPairList(
    typeUrl: '/protocol.WalletGetMarketPairList',
    serviceUrl: "/protocol.Wallet/GetMarketPairList",
  ),
  protocolWalletListNodes(
    typeUrl: '/protocol.WalletListNodes',
    serviceUrl: "/protocol.Wallet/ListNodes",
  ),
  protocolWalletGetAssetIssueByName(
    typeUrl: '/protocol.WalletGetAssetIssueByName',
    serviceUrl: "/protocol.Wallet/GetAssetIssueByName",
  ),
  protocolWalletGetAssetIssueListByName(
    typeUrl: '/protocol.WalletGetAssetIssueListByName',
    serviceUrl: "/protocol.Wallet/GetAssetIssueListByName",
  ),
  protocolWalletGetAssetIssueById(
    typeUrl: '/protocol.WalletGetAssetIssueById',
    serviceUrl: "/protocol.Wallet/GetAssetIssueById",
  ),
  protocolWalletGetNowBlock(
    typeUrl: '/protocol.WalletGetNowBlock',
    serviceUrl: "/protocol.Wallet/GetNowBlock",
  ),
  protocolWalletGetNowBlock2(
    typeUrl: '/protocol.WalletGetNowBlock2',
    serviceUrl: "/protocol.Wallet/GetNowBlock2",
  ),
  protocolWalletGetBlockByNum(
    typeUrl: '/protocol.WalletGetBlockByNum',
    serviceUrl: "/protocol.Wallet/GetBlockByNum",
  ),
  protocolWalletGetBlockByNum2(
    typeUrl: '/protocol.WalletGetBlockByNum2',
    serviceUrl: "/protocol.Wallet/GetBlockByNum2",
  ),
  protocolWalletGetTransactionCountByBlockNum(
    typeUrl: '/protocol.WalletGetTransactionCountByBlockNum',
    serviceUrl: "/protocol.Wallet/GetTransactionCountByBlockNum",
  ),
  protocolWalletGetBlockById(
    typeUrl: '/protocol.WalletGetBlockById',
    serviceUrl: "/protocol.Wallet/GetBlockById",
  ),
  protocolWalletGetBlockByLimitNext(
    typeUrl: '/protocol.WalletGetBlockByLimitNext',
    serviceUrl: "/protocol.Wallet/GetBlockByLimitNext",
  ),
  protocolWalletGetBlockByLimitNext2(
    typeUrl: '/protocol.WalletGetBlockByLimitNext2',
    serviceUrl: "/protocol.Wallet/GetBlockByLimitNext2",
  ),
  protocolWalletGetBlockByLatestNum(
    typeUrl: '/protocol.WalletGetBlockByLatestNum',
    serviceUrl: "/protocol.Wallet/GetBlockByLatestNum",
  ),
  protocolWalletGetBlockByLatestNum2(
    typeUrl: '/protocol.WalletGetBlockByLatestNum2',
    serviceUrl: "/protocol.Wallet/GetBlockByLatestNum2",
  ),
  protocolWalletGetTransactionById(
    typeUrl: '/protocol.WalletGetTransactionById',
    serviceUrl: "/protocol.Wallet/GetTransactionById",
  ),
  protocolWalletGetContract(
    typeUrl: '/protocol.WalletGetContract',
    serviceUrl: "/protocol.Wallet/GetContract",
  ),
  protocolWalletGetContractInfo(
    typeUrl: '/protocol.WalletGetContractInfo',
    serviceUrl: "/protocol.Wallet/GetContractInfo",
  ),
  protocolWalletListWitnesses(
    typeUrl: '/protocol.WalletListWitnesses',
    serviceUrl: "/protocol.Wallet/ListWitnesses",
  ),
  protocolWalletGetPaginatedNowWitnessList(
    typeUrl: '/protocol.WalletGetPaginatedNowWitnessList',
    serviceUrl: "/protocol.Wallet/GetPaginatedNowWitnessList",
  ),
  protocolWalletGetDelegatedResource(
    typeUrl: '/protocol.WalletGetDelegatedResource',
    serviceUrl: "/protocol.Wallet/GetDelegatedResource",
  ),
  protocolWalletGetDelegatedResourceV2(
    typeUrl: '/protocol.WalletGetDelegatedResourceV2',
    serviceUrl: "/protocol.Wallet/GetDelegatedResourceV2",
  ),
  protocolWalletGetDelegatedResourceAccountIndex(
    typeUrl: '/protocol.WalletGetDelegatedResourceAccountIndex',
    serviceUrl: "/protocol.Wallet/GetDelegatedResourceAccountIndex",
  ),
  protocolWalletGetDelegatedResourceAccountIndexV2(
    typeUrl: '/protocol.WalletGetDelegatedResourceAccountIndexV2',
    serviceUrl: "/protocol.Wallet/GetDelegatedResourceAccountIndexV2",
  ),
  protocolWalletGetCanDelegatedMaxSize(
    typeUrl: '/protocol.WalletGetCanDelegatedMaxSize',
    serviceUrl: "/protocol.Wallet/GetCanDelegatedMaxSize",
  ),
  protocolWalletGetAvailableUnfreezeCount(
    typeUrl: '/protocol.WalletGetAvailableUnfreezeCount',
    serviceUrl: "/protocol.Wallet/GetAvailableUnfreezeCount",
  ),
  protocolWalletGetCanWithdrawUnfreezeAmount(
    typeUrl: '/protocol.WalletGetCanWithdrawUnfreezeAmount',
    serviceUrl: "/protocol.Wallet/GetCanWithdrawUnfreezeAmount",
  ),
  protocolWalletListProposals(
    typeUrl: '/protocol.WalletListProposals',
    serviceUrl: "/protocol.Wallet/ListProposals",
  ),
  protocolWalletGetPaginatedProposalList(
    typeUrl: '/protocol.WalletGetPaginatedProposalList',
    serviceUrl: "/protocol.Wallet/GetPaginatedProposalList",
  ),
  protocolWalletGetProposalById(
    typeUrl: '/protocol.WalletGetProposalById',
    serviceUrl: "/protocol.Wallet/GetProposalById",
  ),
  protocolWalletListExchanges(
    typeUrl: '/protocol.WalletListExchanges',
    serviceUrl: "/protocol.Wallet/ListExchanges",
  ),
  protocolWalletGetPaginatedExchangeList(
    typeUrl: '/protocol.WalletGetPaginatedExchangeList',
    serviceUrl: "/protocol.Wallet/GetPaginatedExchangeList",
  ),
  protocolWalletGetExchangeById(
    typeUrl: '/protocol.WalletGetExchangeById',
    serviceUrl: "/protocol.Wallet/GetExchangeById",
  ),
  protocolWalletGetChainParameters(
    typeUrl: '/protocol.WalletGetChainParameters',
    serviceUrl: "/protocol.Wallet/GetChainParameters",
  ),
  protocolWalletGetAssetIssueList(
    typeUrl: '/protocol.WalletGetAssetIssueList',
    serviceUrl: "/protocol.Wallet/GetAssetIssueList",
  ),
  protocolWalletGetPaginatedAssetIssueList(
    typeUrl: '/protocol.WalletGetPaginatedAssetIssueList',
    serviceUrl: "/protocol.Wallet/GetPaginatedAssetIssueList",
  ),
  protocolWalletTotalTransaction(
    typeUrl: '/protocol.WalletTotalTransaction',
    serviceUrl: "/protocol.Wallet/TotalTransaction",
  ),
  protocolWalletGetNextMaintenanceTime(
    typeUrl: '/protocol.WalletGetNextMaintenanceTime',
    serviceUrl: "/protocol.Wallet/GetNextMaintenanceTime",
  ),
  protocolWalletGetTransactionInfoById(
    typeUrl: '/protocol.WalletGetTransactionInfoById',
    serviceUrl: "/protocol.Wallet/GetTransactionInfoById",
  ),
  protocolWalletGetNodeInfo(
    typeUrl: '/protocol.WalletGetNodeInfo',
    serviceUrl: "/protocol.Wallet/GetNodeInfo",
  ),
  protocolWalletGetRewardInfo(
    typeUrl: '/protocol.WalletGetRewardInfo',
    serviceUrl: "/protocol.Wallet/GetRewardInfo",
  ),
  protocolWalletGetBrokerageInfo(
    typeUrl: '/protocol.WalletGetBrokerageInfo',
    serviceUrl: "/protocol.Wallet/GetBrokerageInfo",
  ),
  protocolWalletCreateShieldedTransaction(
    typeUrl: '/protocol.WalletCreateShieldedTransaction',
    serviceUrl: "/protocol.Wallet/CreateShieldedTransaction",
  ),
  protocolWalletScanNoteByIvk(
    typeUrl: '/protocol.WalletScanNoteByIvk',
    serviceUrl: "/protocol.Wallet/ScanNoteByIvk",
  ),
  protocolWalletScanAndMarkNoteByIvk(
    typeUrl: '/protocol.WalletScanAndMarkNoteByIvk',
    serviceUrl: "/protocol.Wallet/ScanAndMarkNoteByIvk",
  ),
  protocolWalletScanNoteByOvk(
    typeUrl: '/protocol.WalletScanNoteByOvk',
    serviceUrl: "/protocol.Wallet/ScanNoteByOvk",
  ),
  protocolWalletGetSpendingKey(
    typeUrl: '/protocol.WalletGetSpendingKey',
    serviceUrl: "/protocol.Wallet/GetSpendingKey",
  ),
  protocolWalletGetExpandedSpendingKey(
    typeUrl: '/protocol.WalletGetExpandedSpendingKey',
    serviceUrl: "/protocol.Wallet/GetExpandedSpendingKey",
  ),
  protocolWalletGetAkFromAsk(
    typeUrl: '/protocol.WalletGetAkFromAsk',
    serviceUrl: "/protocol.Wallet/GetAkFromAsk",
  ),
  protocolWalletGetNkFromNsk(
    typeUrl: '/protocol.WalletGetNkFromNsk',
    serviceUrl: "/protocol.Wallet/GetNkFromNsk",
  ),
  protocolWalletGetIncomingViewingKey(
    typeUrl: '/protocol.WalletGetIncomingViewingKey',
    serviceUrl: "/protocol.Wallet/GetIncomingViewingKey",
  ),
  protocolWalletGetDiversifier(
    typeUrl: '/protocol.WalletGetDiversifier',
    serviceUrl: "/protocol.Wallet/GetDiversifier",
  ),
  protocolWalletGetNewShieldedAddress(
    typeUrl: '/protocol.WalletGetNewShieldedAddress',
    serviceUrl: "/protocol.Wallet/GetNewShieldedAddress",
  ),
  protocolWalletGetZenPaymentAddress(
    typeUrl: '/protocol.WalletGetZenPaymentAddress',
    serviceUrl: "/protocol.Wallet/GetZenPaymentAddress",
  ),
  protocolWalletGetRcm(
    typeUrl: '/protocol.WalletGetRcm',
    serviceUrl: "/protocol.Wallet/GetRcm",
  ),
  protocolWalletIsSpend(
    typeUrl: '/protocol.WalletIsSpend',
    serviceUrl: "/protocol.Wallet/IsSpend",
  ),
  protocolWalletCreateShieldedTransactionWithoutSpendAuthSig(
    typeUrl: '/protocol.WalletCreateShieldedTransactionWithoutSpendAuthSig',
    serviceUrl: "/protocol.Wallet/CreateShieldedTransactionWithoutSpendAuthSig",
  ),
  protocolWalletCreateSpendAuthSig(
    typeUrl: '/protocol.WalletCreateSpendAuthSig',
    serviceUrl: "/protocol.Wallet/CreateSpendAuthSig",
  ),
  protocolWalletCreateShieldNullifier(
    typeUrl: '/protocol.WalletCreateShieldNullifier',
    serviceUrl: "/protocol.Wallet/CreateShieldNullifier",
  ),
  protocolWalletCreateShieldedContractParameters(
    typeUrl: '/protocol.WalletCreateShieldedContractParameters',
    serviceUrl: "/protocol.Wallet/CreateShieldedContractParameters",
  ),
  protocolWalletCreateShieldedContractParametersWithoutAsk(
    typeUrl: '/protocol.WalletCreateShieldedContractParametersWithoutAsk',
    serviceUrl: "/protocol.Wallet/CreateShieldedContractParametersWithoutAsk",
  ),
  protocolWalletScanShieldedTRC20NotesByIvk(
    typeUrl: '/protocol.WalletScanShieldedTRC20NotesByIvk',
    serviceUrl: "/protocol.Wallet/ScanShieldedTRC20NotesByIvk",
  ),
  protocolWalletScanShieldedTRC20NotesByOvk(
    typeUrl: '/protocol.WalletScanShieldedTRC20NotesByOvk',
    serviceUrl: "/protocol.Wallet/ScanShieldedTRC20NotesByOvk",
  ),
  protocolWalletIsShieldedTRC20ContractNoteSpent(
    typeUrl: '/protocol.WalletIsShieldedTRC20ContractNoteSpent',
    serviceUrl: "/protocol.Wallet/IsShieldedTRC20ContractNoteSpent",
  ),
  protocolWalletGetTriggerInputForShieldedTRC20Contract(
    typeUrl: '/protocol.WalletGetTriggerInputForShieldedTRC20Contract',
    serviceUrl: "/protocol.Wallet/GetTriggerInputForShieldedTRC20Contract",
  ),
  protocolWalletGetTransactionInfoByBlockNum(
    typeUrl: '/protocol.WalletGetTransactionInfoByBlockNum',
    serviceUrl: "/protocol.Wallet/GetTransactionInfoByBlockNum",
  ),
  protocolWalletGetBurnTrx(
    typeUrl: '/protocol.WalletGetBurnTrx',
    serviceUrl: "/protocol.Wallet/GetBurnTrx",
  ),
  protocolWalletGetTransactionFromPending(
    typeUrl: '/protocol.WalletGetTransactionFromPending',
    serviceUrl: "/protocol.Wallet/GetTransactionFromPending",
  ),
  protocolWalletGetTransactionListFromPending(
    typeUrl: '/protocol.WalletGetTransactionListFromPending',
    serviceUrl: "/protocol.Wallet/GetTransactionListFromPending",
  ),
  protocolWalletGetPendingSize(
    typeUrl: '/protocol.WalletGetPendingSize',
    serviceUrl: "/protocol.Wallet/GetPendingSize",
  ),
  protocolWalletGetBlock(
    typeUrl: '/protocol.WalletGetBlock',
    serviceUrl: "/protocol.Wallet/GetBlock",
  ),
  protocolWalletGetBandwidthPrices(
    typeUrl: '/protocol.WalletGetBandwidthPrices',
    serviceUrl: "/protocol.Wallet/GetBandwidthPrices",
  ),
  protocolWalletGetEnergyPrices(
    typeUrl: '/protocol.WalletGetEnergyPrices',
    serviceUrl: "/protocol.Wallet/GetEnergyPrices",
  ),
  protocolWalletGetMemoFee(
    typeUrl: '/protocol.WalletGetMemoFee',
    serviceUrl: "/protocol.Wallet/GetMemoFee",
  ),
  protocolWalletSolidityListWitnesses(
    typeUrl: '/protocol.WalletSolidityListWitnesses',
    serviceUrl: "/protocol.WalletSolidity/ListWitnesses",
  ),
  protocolWalletSolidityGetPaginatedNowWitnessList(
    typeUrl: '/protocol.WalletSolidityGetPaginatedNowWitnessList',
    serviceUrl: "/protocol.WalletSolidity/GetPaginatedNowWitnessList",
  ),
  protocolWalletSolidityGetAssetIssueList(
    typeUrl: '/protocol.WalletSolidityGetAssetIssueList',
    serviceUrl: "/protocol.WalletSolidity/GetAssetIssueList",
  ),
  protocolWalletSolidityGetPaginatedAssetIssueList(
    typeUrl: '/protocol.WalletSolidityGetPaginatedAssetIssueList',
    serviceUrl: "/protocol.WalletSolidity/GetPaginatedAssetIssueList",
  ),
  protocolWalletSolidityGetAssetIssueByName(
    typeUrl: '/protocol.WalletSolidityGetAssetIssueByName',
    serviceUrl: "/protocol.WalletSolidity/GetAssetIssueByName",
  ),
  protocolWalletSolidityGetAssetIssueListByName(
    typeUrl: '/protocol.WalletSolidityGetAssetIssueListByName',
    serviceUrl: "/protocol.WalletSolidity/GetAssetIssueListByName",
  ),
  protocolWalletSolidityGetAssetIssueById(
    typeUrl: '/protocol.WalletSolidityGetAssetIssueById',
    serviceUrl: "/protocol.WalletSolidity/GetAssetIssueById",
  ),
  protocolWalletSolidityGetNowBlock(
    typeUrl: '/protocol.WalletSolidityGetNowBlock',
    serviceUrl: "/protocol.WalletSolidity/GetNowBlock",
  ),
  protocolWalletSolidityGetNowBlock2(
    typeUrl: '/protocol.WalletSolidityGetNowBlock2',
    serviceUrl: "/protocol.WalletSolidity/GetNowBlock2",
  ),
  protocolWalletSolidityGetBlockByNum(
    typeUrl: '/protocol.WalletSolidityGetBlockByNum',
    serviceUrl: "/protocol.WalletSolidity/GetBlockByNum",
  ),
  protocolWalletSolidityGetBlockByNum2(
    typeUrl: '/protocol.WalletSolidityGetBlockByNum2',
    serviceUrl: "/protocol.WalletSolidity/GetBlockByNum2",
  ),
  protocolWalletSolidityGetTransactionCountByBlockNum(
    typeUrl: '/protocol.WalletSolidityGetTransactionCountByBlockNum',
    serviceUrl: "/protocol.WalletSolidity/GetTransactionCountByBlockNum",
  ),
  protocolWalletSolidityGetDelegatedResource(
    typeUrl: '/protocol.WalletSolidityGetDelegatedResource',
    serviceUrl: "/protocol.WalletSolidity/GetDelegatedResource",
  ),
  protocolWalletSolidityGetDelegatedResourceV2(
    typeUrl: '/protocol.WalletSolidityGetDelegatedResourceV2',
    serviceUrl: "/protocol.WalletSolidity/GetDelegatedResourceV2",
  ),
  protocolWalletSolidityGetDelegatedResourceAccountIndex(
    typeUrl: '/protocol.WalletSolidityGetDelegatedResourceAccountIndex',
    serviceUrl: "/protocol.WalletSolidity/GetDelegatedResourceAccountIndex",
  ),
  protocolWalletSolidityGetDelegatedResourceAccountIndexV2(
    typeUrl: '/protocol.WalletSolidityGetDelegatedResourceAccountIndexV2',
    serviceUrl: "/protocol.WalletSolidity/GetDelegatedResourceAccountIndexV2",
  ),
  protocolWalletSolidityGetCanDelegatedMaxSize(
    typeUrl: '/protocol.WalletSolidityGetCanDelegatedMaxSize',
    serviceUrl: "/protocol.WalletSolidity/GetCanDelegatedMaxSize",
  ),
  protocolWalletSolidityGetAvailableUnfreezeCount(
    typeUrl: '/protocol.WalletSolidityGetAvailableUnfreezeCount',
    serviceUrl: "/protocol.WalletSolidity/GetAvailableUnfreezeCount",
  ),
  protocolWalletSolidityGetCanWithdrawUnfreezeAmount(
    typeUrl: '/protocol.WalletSolidityGetCanWithdrawUnfreezeAmount',
    serviceUrl: "/protocol.WalletSolidity/GetCanWithdrawUnfreezeAmount",
  ),
  protocolWalletSolidityGetExchangeById(
    typeUrl: '/protocol.WalletSolidityGetExchangeById',
    serviceUrl: "/protocol.WalletSolidity/GetExchangeById",
  ),
  protocolWalletSolidityListExchanges(
    typeUrl: '/protocol.WalletSolidityListExchanges',
    serviceUrl: "/protocol.WalletSolidity/ListExchanges",
  ),
  protocolWalletSolidityGetTransactionById(
    typeUrl: '/protocol.WalletSolidityGetTransactionById',
    serviceUrl: "/protocol.WalletSolidity/GetTransactionById",
  ),
  protocolWalletSolidityGetTransactionInfoById(
    typeUrl: '/protocol.WalletSolidityGetTransactionInfoById',
    serviceUrl: "/protocol.WalletSolidity/GetTransactionInfoById",
  ),
  protocolWalletSolidityScanNoteByIvk(
    typeUrl: '/protocol.WalletSolidityScanNoteByIvk',
    serviceUrl: "/protocol.WalletSolidity/ScanNoteByIvk",
  ),
  protocolWalletSolidityScanAndMarkNoteByIvk(
    typeUrl: '/protocol.WalletSolidityScanAndMarkNoteByIvk',
    serviceUrl: "/protocol.WalletSolidity/ScanAndMarkNoteByIvk",
  ),
  protocolWalletSolidityScanNoteByOvk(
    typeUrl: '/protocol.WalletSolidityScanNoteByOvk',
    serviceUrl: "/protocol.WalletSolidity/ScanNoteByOvk",
  ),
  protocolWalletSolidityIsSpend(
    typeUrl: '/protocol.WalletSolidityIsSpend',
    serviceUrl: "/protocol.WalletSolidity/IsSpend",
  ),
  protocolWalletSolidityScanShieldedTRC20NotesByIvk(
    typeUrl: '/protocol.WalletSolidityScanShieldedTRC20NotesByIvk',
    serviceUrl: "/protocol.WalletSolidity/ScanShieldedTRC20NotesByIvk",
  ),
  protocolWalletSolidityScanShieldedTRC20NotesByOvk(
    typeUrl: '/protocol.WalletSolidityScanShieldedTRC20NotesByOvk',
    serviceUrl: "/protocol.WalletSolidity/ScanShieldedTRC20NotesByOvk",
  ),
  protocolWalletSolidityIsShieldedTRC20ContractNoteSpent(
    typeUrl: '/protocol.WalletSolidityIsShieldedTRC20ContractNoteSpent',
    serviceUrl: "/protocol.WalletSolidity/IsShieldedTRC20ContractNoteSpent",
  ),
  protocolWalletSolidityGetRewardInfo(
    typeUrl: '/protocol.WalletSolidityGetRewardInfo',
    serviceUrl: "/protocol.WalletSolidity/GetRewardInfo",
  ),
  protocolWalletSolidityGetBrokerageInfo(
    typeUrl: '/protocol.WalletSolidityGetBrokerageInfo',
    serviceUrl: "/protocol.WalletSolidity/GetBrokerageInfo",
  ),
  protocolWalletSolidityGetTransactionInfoByBlockNum(
    typeUrl: '/protocol.WalletSolidityGetTransactionInfoByBlockNum',
    serviceUrl: "/protocol.WalletSolidity/GetTransactionInfoByBlockNum",
  ),
  protocolWalletSolidityGetMarketOrderById(
    typeUrl: '/protocol.WalletSolidityGetMarketOrderById',
    serviceUrl: "/protocol.WalletSolidity/GetMarketOrderById",
  ),
  protocolWalletSolidityGetMarketOrderByAccount(
    typeUrl: '/protocol.WalletSolidityGetMarketOrderByAccount',
    serviceUrl: "/protocol.WalletSolidity/GetMarketOrderByAccount",
  ),
  protocolWalletSolidityGetMarketPairList(
    typeUrl: '/protocol.WalletSolidityGetMarketPairList',
    serviceUrl: "/protocol.WalletSolidity/GetMarketPairList",
  ),
  protocolWalletSolidityGetBurnTrx(
    typeUrl: '/protocol.WalletSolidityGetBurnTrx',
    serviceUrl: "/protocol.WalletSolidity/GetBurnTrx",
  ),
  protocolWalletSolidityGetBlock(
    typeUrl: '/protocol.WalletSolidityGetBlock',
    serviceUrl: "/protocol.WalletSolidity/GetBlock",
  ),
  protocolWalletSolidityGetBandwidthPrices(
    typeUrl: '/protocol.WalletSolidityGetBandwidthPrices',
    serviceUrl: "/protocol.WalletSolidity/GetBandwidthPrices",
  ),
  protocolWalletSolidityGetEnergyPrices(
    typeUrl: '/protocol.WalletSolidityGetEnergyPrices',
    serviceUrl: "/protocol.WalletSolidity/GetEnergyPrices",
  ),
  protocolWalletExtensionGetTransactionsFromThis(
    typeUrl: '/protocol.WalletExtensionGetTransactionsFromThis',
    serviceUrl: "/protocol.WalletExtension/GetTransactionsFromThis",
  ),
  protocolWalletExtensionGetTransactionsFromThis2(
    typeUrl: '/protocol.WalletExtensionGetTransactionsFromThis2',
    serviceUrl: "/protocol.WalletExtension/GetTransactionsFromThis2",
  ),
  protocolWalletExtensionGetTransactionsToThis(
    typeUrl: '/protocol.WalletExtensionGetTransactionsToThis',
    serviceUrl: "/protocol.WalletExtension/GetTransactionsToThis",
  ),
  protocolWalletExtensionGetTransactionsToThis2(
    typeUrl: '/protocol.WalletExtensionGetTransactionsToThis2',
    serviceUrl: "/protocol.WalletExtension/GetTransactionsToThis2",
  ),
  protocolZksnarkRequest(typeUrl: '/protocol.ZksnarkRequest'),
  protocolZksnarkResponse(typeUrl: '/protocol.ZksnarkResponse'),
  googleProtobufAny(typeUrl: '/google.protobuf.Any');

  @override
  final String typeUrl;
  @override
  final String? serviceUrl;
  const DefaultTronProtoTypeUrl({required this.typeUrl, this.serviceUrl});
  static DefaultTronProtoTypeUrl? fromUrl(String? value) {
    return DefaultTronProtoTypeUrl.values.firstWhereNullable(
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
