// Auto-generated Lotus FullNode JSON-RPC request classes.
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/models/block.dart';
import 'package:on_chain/ethereum/src/models/block_tag.dart';
import 'package:on_chain/ethereum/src/models/fee_history.dart';
import 'package:on_chain/ethereum/src/models/transaction.dart';
import 'package:on_chain/ethereum/src/models/transaction_receipt.dart';
import 'package:on_chain/fil/src/crypto/cid/cid.dart';
import 'package:on_chain/fil/src/rpc/core/core.dart';
import 'package:on_chain/fil/src/rpc/types/types/full_node.dart';
import 'package:on_chain/fil/src/types/types.dart';

/// JSON-RPC `Filecoin.Discover`
class LotusFullNodeRequestDiscover
    extends LotusFullNodeRequest<Map<String, dynamic>, Map<String, dynamic>> {
  const LotusFullNodeRequestDiscover();

  @override
  String get jsonRpcMethod => 'Filecoin.Discover';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return const <dynamic>[];
  }
}

/// JSON-RPC `Filecoin.Version`
class LotusFullNodeRequestVersion
    extends
        LotusFullNodeRequest<LotusResponseAPIVersion, Map<String, dynamic>> {
  const LotusFullNodeRequestVersion();

  @override
  String get jsonRpcMethod => 'Filecoin.Version';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return const <dynamic>[];
  }

  @override
  LotusResponseAPIVersion onResponse(Map<String, dynamic> result) {
    return LotusResponseAPIVersion.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.ChainGetBlock`
/// ChainGetBlock returns the block specified by the given CID.
///
/// Permission: read
class LotusFullNodeRequestChainGetBlock
    extends
        LotusFullNodeRequest<LotusResponseBlockHeader?, Map<String, dynamic>?> {
  final Cid cid;
  const LotusFullNodeRequestChainGetBlock({required this.cid});

  @override
  String get jsonRpcMethod => 'Filecoin.ChainGetBlock';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [cid.toJson()];
  }

  @override
  LotusResponseBlockHeader? onResponse(Map<String, dynamic>? result) {
    return result == null ? null : LotusResponseBlockHeader.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.ChainGetBlockMessages`
/// ChainGetBlockMessages returns messages stored in the specified block.
///
/// Note: If there are multiple blocks in a tipset, it's likely that some
/// messages will be duplicated. It's also possible for blocks in a tipset to have
/// different messages from the same sender at the same nonce. When that happens,
/// only the first message (in a block with lowest ticket) will be considered
/// for execution
///
/// NOTE: THIS METHOD SHOULD ONLY BE USED FOR GETTING MESSAGES IN A SPECIFIC BLOCK
///
/// DO NOT USE THIS METHOD TO GET MESSAGES INCLUDED IN A TIPSET
/// Use ChainGetParentMessages, which will perform correct message deduplication
///
/// Permission: read
class LotusFullNodeRequestChainGetBlockMessages
    extends
        LotusFullNodeRequest<
          LotusResponseBlockMessages?,
          Map<String, dynamic>?
        > {
  final Cid blockCid;
  const LotusFullNodeRequestChainGetBlockMessages({required this.blockCid});

  @override
  String get jsonRpcMethod => 'Filecoin.ChainGetBlockMessages';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [blockCid.toJson()];
  }

  @override
  LotusResponseBlockMessages? onResponse(Map<String, dynamic>? result) {
    return result == null ? null : LotusResponseBlockMessages.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.ChainGetEvents`
/// ChainGetEvents returns the events under an event AMT root CID.
///
/// Permission: read
class LotusFullNodeRequestChainGetEvents
    extends
        LotusFullNodeRequest<
          List<LotusResponseEvent>,
          List<Map<String, dynamic>>?
        > {
  final Cid cid;
  const LotusFullNodeRequestChainGetEvents({required this.cid});

  @override
  String get jsonRpcMethod => 'Filecoin.ChainGetEvents';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [cid.toJson()];
  }

  @override
  List<LotusResponseEvent> onResponse(List<Map<String, dynamic>>? result) {
    return result?.map((e) => LotusResponseEvent.fromJson(e)).toList() ?? [];
  }
}

/// JSON-RPC `Filecoin.ChainGetFinalizedTipSet`
/// ChainGetFinalizedTipSet returns the latest finalized tipset. It uses the
/// current F3 instance to determine the finalized tipset.
/// This is the tipset at the end of the last finalized round and can be used
/// for follow-up querying of the chain state with the assurance that the
/// state will not change.
/// If F3 is operational and finalizing in this node. If not, it will fall back
/// to the Expected Consensus (EC) finality definition of head - 900 epochs.
///
/// Permission: read
class LotusFullNodeRequestChainGetFinalizedTipSet
    extends LotusFullNodeRequest<LotusResponseTipSet?, Map<String, dynamic>?> {
  const LotusFullNodeRequestChainGetFinalizedTipSet();

  @override
  String get jsonRpcMethod => 'Filecoin.ChainGetFinalizedTipSet';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return const <dynamic>[];
  }

  @override
  LotusResponseTipSet? onResponse(Map<String, dynamic>? result) {
    return result == null ? null : LotusResponseTipSet.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.ChainGetGenesis`
/// ChainGetGenesis returns the genesis tipset.
///
/// Permission: read
class LotusFullNodeRequestChainGetGenesis
    extends LotusFullNodeRequest<LotusResponseTipSet?, Map<String, dynamic>?> {
  const LotusFullNodeRequestChainGetGenesis();

  @override
  String get jsonRpcMethod => 'Filecoin.ChainGetGenesis';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return const <dynamic>[];
  }

  @override
  LotusResponseTipSet? onResponse(Map<String, dynamic>? result) {
    return result == null ? null : LotusResponseTipSet.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.ChainGetMessage`
/// ChainGetMessage reads a message referenced by the specified CID from the
/// chain blockstore.
///
/// Permission: read
class LotusFullNodeRequestChainGetMessage
    extends LotusFullNodeRequest<FilMessage?, Map<String, dynamic>?> {
  final Cid cid;
  const LotusFullNodeRequestChainGetMessage({required this.cid});

  @override
  String get jsonRpcMethod => 'Filecoin.ChainGetMessage';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [cid.toJson()];
  }

  @override
  FilMessage? onResponse(Map<String, dynamic>? result) {
    return result == null ? null : FilMessage.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.ChainGetMessagesInTipset`
/// ChainGetMessagesInTipset returns message stores in current tipset
///
/// Permission: read
class LotusFullNodeRequestChainGetMessagesInTipset
    extends
        LotusFullNodeRequest<
          List<LotusResponseMessageWithCid>,
          List<Map<String, dynamic>>?
        > {
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestChainGetMessagesInTipset({this.tsk});

  @override
  String get jsonRpcMethod => 'Filecoin.ChainGetMessagesInTipset';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [tsk?.toJson()];
  }

  @override
  List<LotusResponseMessageWithCid> onResponse(
    List<Map<String, dynamic>>? result,
  ) {
    return result
            ?.map((e) => LotusResponseMessageWithCid.fromJson(e))
            .toList() ??
        [];
  }
}

/// JSON-RPC `Filecoin.ChainGetParentMessages`
/// ChainGetParentMessages returns messages stored in parent tipset of the
/// specified block.
///
/// Permission: read
class LotusFullNodeRequestChainGetParentMessages
    extends
        LotusFullNodeRequest<
          List<LotusResponseMessageWithCid>,
          List<Map<String, dynamic>>?
        > {
  final Cid blockCid;
  const LotusFullNodeRequestChainGetParentMessages({required this.blockCid});

  @override
  String get jsonRpcMethod => 'Filecoin.ChainGetParentMessages';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [blockCid.toJson()];
  }

  @override
  List<LotusResponseMessageWithCid> onResponse(
    List<Map<String, dynamic>>? result,
  ) {
    return result
            ?.map((e) => LotusResponseMessageWithCid.fromJson(e))
            .toList() ??
        [];
  }
}

/// JSON-RPC `Filecoin.ChainGetParentReceipts`
/// ChainGetParentReceipts returns receipts for messages in parent tipset of
/// the specified block. The receipts in the list returned is one-to-one with the
/// messages returned by a call to ChainGetParentMessages with the same blockCid.
///
/// Permission: read
class LotusFullNodeRequestChainGetParentReceipts
    extends
        LotusFullNodeRequest<
          List<LotusResponseMessageReceipt>,
          List<Map<String, dynamic>>?
        > {
  final Cid blockCid;
  const LotusFullNodeRequestChainGetParentReceipts({required this.blockCid});

  @override
  String get jsonRpcMethod => 'Filecoin.ChainGetParentReceipts';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [blockCid.toJson()];
  }

  @override
  List<LotusResponseMessageReceipt> onResponse(List<dynamic>? result) {
    return result
            ?.map((e) => LotusResponseMessageReceipt.fromJson(e))
            .toList() ??
        [];
  }
}

/// JSON-RPC `Filecoin.ChainGetPath`
/// ChainGetPath returns a set of revert/apply operations needed to get from
/// one tipset to another, for example:
/// ```
/// to
/// ^
/// from   tAA
/// ^     ^
/// tBA    tAB
/// ^---*--^
/// ^
/// tRR
/// ```
/// Would return `[revert(tBA), apply(tAB), apply(tAA)]`
///
/// Permission: read
class LotusFullNodeRequestChainGetPath
    extends
        LotusFullNodeRequest<
          List<LotusResponseHeadChange>,
          List<Map<String, dynamic>>?
        > {
  final LotusTipSetKey? from;
  final LotusTipSetKey? to;
  const LotusFullNodeRequestChainGetPath({this.from, this.to});

  @override
  String get jsonRpcMethod => 'Filecoin.ChainGetPath';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [from?.toJson(), to?.toJson()];
  }

  @override
  List<LotusResponseHeadChange> onResponse(List<Map<String, dynamic>>? result) {
    return result?.map((e) => LotusResponseHeadChange.fromJson(e)).toList() ??
        [];
  }
}

/// JSON-RPC `Filecoin.ChainGetTipSet`
/// ChainGetTipSet returns the tipset specified by the given LotusTipSetKey.
///
/// Permission: read
class LotusFullNodeRequestChainGetTipSet
    extends LotusFullNodeRequest<LotusResponseTipSet?, Map<String, dynamic>?> {
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestChainGetTipSet({this.tsk});

  @override
  String get jsonRpcMethod => 'Filecoin.ChainGetTipSet';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [tsk?.toJson()];
  }

  @override
  LotusResponseTipSet? onResponse(Map<String, dynamic>? result) {
    return result == null ? null : LotusResponseTipSet.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.ChainGetTipSetAfterHeight`
/// ChainGetTipSetAfterHeight looks back for a tipset at the specified epoch.
/// If there are no blocks at the specified epoch, the first non-nil tipset at a later epoch
/// will be returned.
///
/// Permission: read
class LotusFullNodeRequestChainGetTipSetAfterHeight
    extends LotusFullNodeRequest<LotusResponseTipSet?, Map<String, dynamic>?> {
  final BigInt epoch;
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestChainGetTipSetAfterHeight({
    required this.epoch,
    this.tsk,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.ChainGetTipSetAfterHeight';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [epoch, tsk?.toJson()];
  }

  @override
  LotusResponseTipSet? onResponse(Map<String, dynamic>? result) {
    return result == null ? null : LotusResponseTipSet.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.ChainGetTipSetByHeight`
/// ChainGetTipSetByHeight looks back for a tipset at the specified epoch.
/// If there are no blocks at the specified epoch, a tipset at an earlier epoch
/// will be returned.
///
/// Permission: read
class LotusFullNodeRequestChainGetTipSetByHeight
    extends LotusFullNodeRequest<LotusResponseTipSet?, Map<String, dynamic>?> {
  final BigInt epoch;
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestChainGetTipSetByHeight({
    required this.epoch,
    this.tsk,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.ChainGetTipSetByHeight';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [epoch, tsk?.toJson()];
  }

  @override
  LotusResponseTipSet? onResponse(Map<String, dynamic>? result) {
    return result == null ? null : LotusResponseTipSet.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.ChainHasObj`
/// ChainHasObj checks if a given CID exists in the chain blockstore.
///
/// Permission: read
class LotusFullNodeRequestChainHasObj extends LotusFullNodeRequest<bool, bool> {
  final Cid cid;
  const LotusFullNodeRequestChainHasObj({required this.cid});

  @override
  String get jsonRpcMethod => 'Filecoin.ChainHasObj';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [cid.toJson()];
  }

  @override
  bool onResponse(bool result) {
    return result == true;
  }
}

/// JSON-RPC `Filecoin.ChainHead`
/// ChainHead returns the current head of the chain.
///
/// Permission: read
class LotusFullNodeRequestChainHead
    extends LotusFullNodeRequest<LotusResponseTipSet, Map<String, dynamic>> {
  const LotusFullNodeRequestChainHead();

  @override
  String get jsonRpcMethod => 'Filecoin.ChainHead';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return const <dynamic>[];
  }

  @override
  LotusResponseTipSet onResponse(Map<String, dynamic> result) {
    return LotusResponseTipSet.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.ChainReadObj`
/// ChainReadObj reads ipld nodes referenced by the specified CID from chain
/// blockstore and returns raw bytes.
///
/// Permission: read
class LotusFullNodeRequestChainReadObj
    extends LotusFullNodeRequest<List<int>, String> {
  final Cid cid;
  const LotusFullNodeRequestChainReadObj({required this.cid});

  @override
  String get jsonRpcMethod => 'Filecoin.ChainReadObj';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [cid.toJson()];
  }

  @override
  List<int> onResponse(String result) {
    return StringUtils.encode(result, encoding: StringEncoding.base64);
  }
}

/// JSON-RPC `Filecoin.EthAccounts`
/// EthAccounts will always return [] since we don't expect Lotus to manage private keys
///
/// Permission: read
class LotusFullNodeRequestEthAccounts
    extends LotusFullNodeRequest<List<String>, List<String>?> {
  const LotusFullNodeRequestEthAccounts();

  @override
  String get jsonRpcMethod => 'Filecoin.EthAccounts';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return const <dynamic>[];
  }

  @override
  List<String> onResponse(List<String>? result) {
    return result ?? [];
  }
}

/// JSON-RPC `Filecoin.EthAddressToFilecoinAddress`
/// EthAddressToFilecoinAddress converts an EthAddress into an f410 Filecoin Address
///
/// Permission: read
class LotusFullNodeRequestEthAddressToFilecoinAddress
    extends LotusFullNodeRequest<String, String> {
  final String ethAddress;
  const LotusFullNodeRequestEthAddressToFilecoinAddress({
    required this.ethAddress,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.EthAddressToFilecoinAddress';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [ethAddress];
  }

  @override
  String onResponse(String result) {
    return result;
  }
}

/// JSON-RPC `Filecoin.EthBlockNumber`
/// EthBlockNumber returns the height of the latest (heaviest) TipSet
///
/// Permission: read
class LotusFullNodeRequestEthBlockNumber
    extends LotusFullNodeRequest<BigInt, String> {
  const LotusFullNodeRequestEthBlockNumber();

  @override
  String get jsonRpcMethod => 'Filecoin.EthBlockNumber';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return const <dynamic>[];
  }

  @override
  BigInt onResponse(String result) {
    return JsonParser.valueAsBigInt(result);
  }
}

/// JSON-RPC `Filecoin.EthCall`
class LotusFullNodeRequestEthCall
    extends LotusFullNodeRequest<List<int>, String> {
  final LotusParamsEthCall tx;
  final BlockTagOrNumber blkParam;
  const LotusFullNodeRequestEthCall({required this.tx, required this.blkParam});

  @override
  String get jsonRpcMethod => 'Filecoin.EthCall';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [tx.toJson(), blkParam.toJson()];
  }

  @override
  List<int> onResponse(String result) {
    return JsonParser.valueAsBytes(result);
  }
}

/// JSON-RPC `Filecoin.EthChainId`
class LotusFullNodeRequestEthChainId
    extends LotusFullNodeRequest<BigInt, String> {
  const LotusFullNodeRequestEthChainId();

  @override
  String get jsonRpcMethod => 'Filecoin.EthChainId';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return const <dynamic>[];
  }

  @override
  BigInt onResponse(String result) {
    return JsonParser.valueAsBigInt(result);
  }
}

/// JSON-RPC `Filecoin.EthEstimateGas`
class LotusFullNodeRequestEthEstimateGas
    extends LotusFullNodeRequest<BigInt, String> {
  final Map<String, dynamic> params;
  const LotusFullNodeRequestEthEstimateGas({required this.params});

  @override
  String get jsonRpcMethod => 'Filecoin.EthEstimateGas';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [params];
  }

  @override
  BigInt onResponse(String result) {
    return JsonParser.valueAs(result);
  }
}

/// JSON-RPC `Filecoin.EthFeeHistory`
class LotusFullNodeRequestEthFeeHistory
    extends LotusFullNodeRequest<FeeHistory, Map<String, dynamic>> {
  final List<dynamic> params;
  const LotusFullNodeRequestEthFeeHistory({required this.params});

  @override
  String get jsonRpcMethod => 'Filecoin.EthFeeHistory';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return params;
  }

  @override
  FeeHistory onResponse(Map<String, dynamic> result) {
    return FeeHistory.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.EthGasPrice`
class LotusFullNodeRequestEthGasPrice
    extends LotusFullNodeRequest<BigInt, String> {
  const LotusFullNodeRequestEthGasPrice();

  @override
  String get jsonRpcMethod => 'Filecoin.EthGasPrice';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return const <dynamic>[];
  }

  @override
  BigInt onResponse(String result) {
    return JsonParser.valueAsBigInt(result);
  }
}

/// JSON-RPC `Filecoin.EthGetBalance`
class LotusFullNodeRequestEthGetBalance
    extends LotusFullNodeRequest<BigInt, String> {
  final String ethAddress;
  final BlockTagOrNumber? blkParam;
  const LotusFullNodeRequestEthGetBalance({
    required this.ethAddress,
    this.blkParam,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.EthGetBalance';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [ethAddress, (blkParam ?? BlockTagOrNumber.latest).toJson()];
  }

  @override
  BigInt onResponse(String result) {
    return JsonParser.valueAsBigInt(result);
  }
}

/// JSON-RPC `Filecoin.EthGetBlockByHash`
class LotusFullNodeRequestEthGetBlockByHash
    extends LotusFullNodeRequest<BlockDetails, Map<String, dynamic>> {
  final String blkHash;
  final bool fullTxInfo;
  const LotusFullNodeRequestEthGetBlockByHash({
    required this.blkHash,
    required this.fullTxInfo,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.EthGetBlockByHash';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [blkHash, fullTxInfo];
  }

  @override
  BlockDetails onResponse(Map<String, dynamic> result) {
    return BlockDetails.fromJson(result, hydrated: fullTxInfo);
  }
}

/// JSON-RPC `Filecoin.EthGetBlockByNumber`
class LotusFullNodeRequestEthGetBlockByNumber
    extends LotusFullNodeRequest<BlockDetails, Map<String, dynamic>> {
  final String blkNum;
  final bool fullTxInfo;
  const LotusFullNodeRequestEthGetBlockByNumber({
    required this.blkNum,
    required this.fullTxInfo,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.EthGetBlockByNumber';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [blkNum, fullTxInfo];
  }

  @override
  BlockDetails onResponse(Map<String, dynamic> result) {
    return BlockDetails.fromJson(result, hydrated: fullTxInfo);
  }
}

/// JSON-RPC `Filecoin.EthGetBlockReceipts`
class LotusFullNodeRequestEthGetBlockReceipts
    extends
        LotusFullNodeRequest<
          List<TransactionReceipt>,
          List<Map<String, dynamic>>?
        > {
  final BlockTagOrNumber blkParam;
  const LotusFullNodeRequestEthGetBlockReceipts({required this.blkParam});

  @override
  String get jsonRpcMethod => 'Filecoin.EthGetBlockReceipts';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [blkParam.toJson()];
  }

  @override
  List<TransactionReceipt> onResponse(List<Map<String, dynamic>>? result) {
    return result?.map((e) => TransactionReceipt.fromJson(e)).toList() ?? [];
  }
}

/// JSON-RPC `Filecoin.EthGetBlockTransactionCountByHash`
/// EthGetBlockTransactionCountByHash returns the number of messages in the TipSet
///
/// Permission: read
class LotusFullNodeRequestEthGetBlockTransactionCountByHash
    extends LotusFullNodeRequest<int, String> {
  final String blkHash;
  const LotusFullNodeRequestEthGetBlockTransactionCountByHash({
    required this.blkHash,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.EthGetBlockTransactionCountByHash';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [blkHash];
  }

  @override
  int onResponse(String result) {
    return JsonParser.valueAsInt(result);
  }
}

/// JSON-RPC `Filecoin.EthGetBlockTransactionCountByNumber`
/// EthGetBlockTransactionCountByNumber returns the number of messages in the TipSet
///
/// Permission: read
class LotusFullNodeRequestEthGetBlockTransactionCountByNumber
    extends LotusFullNodeRequest<int, String> {
  final String blkNum;
  const LotusFullNodeRequestEthGetBlockTransactionCountByNumber({
    required this.blkNum,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.EthGetBlockTransactionCountByNumber';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [blkNum];
  }

  @override
  int onResponse(String result) {
    return JsonParser.valueAsInt(result);
  }
}

/// JSON-RPC `Filecoin.EthGetCode`
class LotusFullNodeRequestEthGetCode
    extends LotusFullNodeRequest<List<int>, String> {
  final String ethAddress;
  final BlockTagOrNumber blkParam;
  const LotusFullNodeRequestEthGetCode({
    required this.ethAddress,
    required this.blkParam,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.EthGetCode';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [ethAddress, blkParam.toJson()];
  }

  @override
  List<int> onResponse(String result) {
    return JsonParser.valueAsBytes(result);
  }
}

/// JSON-RPC `Filecoin.EthGetFilterChanges`
/// Polling method for a filter, returns event logs which occurred since last poll.
/// (requires write perm since timestamp of last filter execution will be written)
///
/// Permission: read
class LotusFullNodeRequestEthGetFilterChanges
    extends LotusFullNodeRequest<List<dynamic>, List<dynamic>?> {
  final String ethFilterID;
  const LotusFullNodeRequestEthGetFilterChanges({required this.ethFilterID});

  @override
  String get jsonRpcMethod => 'Filecoin.EthGetFilterChanges';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [ethFilterID];
  }

  @override
  List<dynamic> onResponse(List<dynamic>? result) {
    return result ?? [];
  }
}

/// JSON-RPC `Filecoin.EthGetFilterLogs`
/// Returns event logs matching filter with given id.
/// (requires write perm since timestamp of last filter execution will be written)
///
/// Permission: read
class LotusFullNodeRequestEthGetFilterLogs
    extends LotusFullNodeRequest<List<dynamic>, List<dynamic>?> {
  final String ethFilterID;
  const LotusFullNodeRequestEthGetFilterLogs({required this.ethFilterID});

  @override
  String get jsonRpcMethod => 'Filecoin.EthGetFilterLogs';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [ethFilterID];
  }

  @override
  List<dynamic> onResponse(List<dynamic>? result) {
    return result ?? [];
  }
}

/// JSON-RPC `Filecoin.EthGetLogs`
/// Returns event logs matching given filter spec.
///
/// Permission: read
class LotusFullNodeRequestEthGetLogs
    extends LotusFullNodeRequest<List<dynamic>, List<dynamic>?> {
  final LotusParamsEthFilterSpec ethFilterSpec;
  const LotusFullNodeRequestEthGetLogs({required this.ethFilterSpec});

  @override
  String get jsonRpcMethod => 'Filecoin.EthGetLogs';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [ethFilterSpec.toJson()];
  }

  @override
  List<dynamic> onResponse(List<dynamic>? result) {
    return result ?? [];
  }
}

/// JSON-RPC `Filecoin.EthGetMessageCidByTransactionHash`
class LotusFullNodeRequestEthGetMessageCidByTransactionHash
    extends LotusFullNodeRequest<Cid?, Map<String, dynamic>?> {
  final String ethHash;
  const LotusFullNodeRequestEthGetMessageCidByTransactionHash({
    required this.ethHash,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.EthGetMessageCidByTransactionHash';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [ethHash];
  }

  @override
  Cid? onResponse(Map<String, dynamic>? result) {
    if (result == null) return null;
    return Cid.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.EthGetStorageAt`
class LotusFullNodeRequestEthGetStorageAt
    extends LotusFullNodeRequest<List<int>, String> {
  final String ethAddress;
  final List<int> ethBytes;
  final BlockTagOrNumber blkParam;
  const LotusFullNodeRequestEthGetStorageAt({
    required this.ethAddress,
    required this.ethBytes,
    required this.blkParam,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.EthGetStorageAt';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [
      ethAddress,
      BytesUtils.toHexString(ethBytes, prefix: "0x"),
      blkParam.toJson(),
    ];
  }

  @override
  List<int> onResponse(String result) {
    return JsonParser.valueAsBytes(result);
  }
}

/// JSON-RPC `Filecoin.EthGetTransactionByBlockHashAndIndex`
class LotusFullNodeRequestEthGetTransactionByBlockHashAndIndex
    extends LotusFullNodeRequest<TransactionInfo, Map<String, dynamic>> {
  final String blkHash;
  final int txIndex;
  const LotusFullNodeRequestEthGetTransactionByBlockHashAndIndex({
    required this.blkHash,
    required this.txIndex,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.EthGetTransactionByBlockHashAndIndex';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [blkHash, txIndex];
  }

  @override
  TransactionInfo onResponse(Map<String, dynamic> result) {
    return TransactionInfo.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.EthGetTransactionByBlockNumberAndIndex`
class LotusFullNodeRequestEthGetTransactionByBlockNumberAndIndex
    extends LotusFullNodeRequest<TransactionInfo, Map<String, dynamic>> {
  final String blkNum;
  final int txIndex;
  const LotusFullNodeRequestEthGetTransactionByBlockNumberAndIndex({
    required this.blkNum,
    required this.txIndex,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.EthGetTransactionByBlockNumberAndIndex';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [blkNum, txIndex];
  }

  @override
  TransactionInfo onResponse(Map<String, dynamic> result) {
    return TransactionInfo.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.EthGetTransactionByHash`
class LotusFullNodeRequestEthGetTransactionByHash
    extends LotusFullNodeRequest<TransactionInfo?, Map<String, dynamic>?> {
  final String ethHash;
  const LotusFullNodeRequestEthGetTransactionByHash({required this.ethHash});

  @override
  String get jsonRpcMethod => 'Filecoin.EthGetTransactionByHash';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [ethHash];
  }

  @override
  TransactionInfo? onResponse(Map<String, dynamic>? result) {
    if (result == null) return null;
    return TransactionInfo.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.EthGetTransactionCount`
class LotusFullNodeRequestEthGetTransactionCount
    extends LotusFullNodeRequest<int, String> {
  final String ethAddress;
  final BlockTagOrNumber blkParam;
  const LotusFullNodeRequestEthGetTransactionCount({
    required this.ethAddress,
    required this.blkParam,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.EthGetTransactionCount';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [ethAddress, blkParam.toJson()];
  }

  @override
  int onResponse(String result) {
    return JsonParser.valueAsInt(result);
  }
}

/// JSON-RPC `Filecoin.EthGetTransactionHashByCid`
class LotusFullNodeRequestEthGetTransactionHashByCid
    extends LotusFullNodeRequest<String?, String?> {
  final Cid cid;
  const LotusFullNodeRequestEthGetTransactionHashByCid({required this.cid});

  @override
  String get jsonRpcMethod => 'Filecoin.EthGetTransactionHashByCid';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [cid.toJson()];
  }
}

/// JSON-RPC `Filecoin.EthGetTransactionReceipt`
class LotusFullNodeRequestEthGetTransactionReceipt
    extends LotusFullNodeRequest<TransactionReceipt?, Map<String, dynamic>?> {
  final String ethHash;
  const LotusFullNodeRequestEthGetTransactionReceipt({required this.ethHash});

  @override
  String get jsonRpcMethod => 'Filecoin.EthGetTransactionReceipt';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [ethHash];
  }

  @override
  TransactionReceipt? onResponse(Map<String, dynamic>? result) {
    return result == null ? null : TransactionReceipt.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.EthMaxPriorityFeePerGas`
class LotusFullNodeRequestEthMaxPriorityFeePerGas
    extends LotusFullNodeRequest<BigInt, String> {
  const LotusFullNodeRequestEthMaxPriorityFeePerGas();

  @override
  String get jsonRpcMethod => 'Filecoin.EthMaxPriorityFeePerGas';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return const <dynamic>[];
  }

  @override
  BigInt onResponse(String result) {
    return JsonParser.valueAsBigInt(result);
  }
}

/// JSON-RPC `Filecoin.EthNewBlockFilter`
/// Installs a persistent filter to notify when a new block arrives.
///
/// Permission: read
class LotusFullNodeRequestEthNewBlockFilter
    extends LotusFullNodeRequest<String, String> {
  const LotusFullNodeRequestEthNewBlockFilter();

  @override
  String get jsonRpcMethod => 'Filecoin.EthNewBlockFilter';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return const <dynamic>[];
  }
}

/// JSON-RPC `Filecoin.EthNewFilter`
/// Installs a persistent filter based on given filter spec.
///
/// Permission: read
class LotusFullNodeRequestEthNewFilter
    extends LotusFullNodeRequest<String, String> {
  final LotusParamsEthFilterSpec ethFilterSpec;
  const LotusFullNodeRequestEthNewFilter({required this.ethFilterSpec});

  @override
  String get jsonRpcMethod => 'Filecoin.EthNewFilter';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [ethFilterSpec.toJson()];
  }
}

/// JSON-RPC `Filecoin.EthNewPendingTransactionFilter`
/// Installs a persistent filter to notify when new messages arrive in the message pool.
///
/// Permission: read
class LotusFullNodeRequestEthNewPendingTransactionFilter
    extends LotusFullNodeRequest<String, String> {
  const LotusFullNodeRequestEthNewPendingTransactionFilter();

  @override
  String get jsonRpcMethod => 'Filecoin.EthNewPendingTransactionFilter';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return const <dynamic>[];
  }
}

/// JSON-RPC `Filecoin.EthProtocolVersion`
class LotusFullNodeRequestEthProtocolVersion
    extends LotusFullNodeRequest<BigInt, String> {
  const LotusFullNodeRequestEthProtocolVersion();

  @override
  String get jsonRpcMethod => 'Filecoin.EthProtocolVersion';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return const <dynamic>[];
  }

  @override
  BigInt onResponse(String result) {
    return JsonParser.valueAsBigInt(result);
  }
}

/// JSON-RPC `Filecoin.EthSendRawTransaction`
class LotusFullNodeRequestEthSendRawTransaction
    extends LotusFullNodeRequest<String, String> {
  final String ethBytes;
  const LotusFullNodeRequestEthSendRawTransaction({required this.ethBytes});

  @override
  String get jsonRpcMethod => 'Filecoin.EthSendRawTransaction';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [ethBytes];
  }
}

/// JSON-RPC `Filecoin.EthSubscribe`
/// Subscribe to different event types using websockets
/// eventTypes is one or more of:
/// - newHeads: notify when new blocks arrive.
/// - pendingTransactions: notify when new messages arrive in the message pool.
/// - logs: notify new event logs that match a criteria
/// params contains additional parameters used with the log event type
/// The client will receive a stream of EthSubscriptionResponse values until EthUnsubscribe is called.
///
/// Permission: read
class LotusFullNodeRequestEthSubscribe
    extends LotusFullNodeRequest<String, String> {
  final List<dynamic> params;
  const LotusFullNodeRequestEthSubscribe({required this.params});

  @override
  String get jsonRpcMethod => 'Filecoin.EthSubscribe';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return params;
  }
}

/// JSON-RPC `Filecoin.EthSyncing`
class LotusFullNodeRequestEthSyncing
    extends LotusFullNodeRequest<LotusResponseEthSyncingResult?, dynamic> {
  const LotusFullNodeRequestEthSyncing();

  @override
  String get jsonRpcMethod => 'Filecoin.EthSyncing';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return const <dynamic>[];
  }

  @override
  LotusResponseEthSyncingResult? onResponse(dynamic result) {
    if (result == false) return null;
    return LotusResponseEthSyncingResult.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.EthTraceBlock`
/// Returns an OpenEthereum-compatible trace of the given block (implementing `trace_block`),
/// translating Filecoin semantics into Ethereum semantics and tracing both EVM and FVM calls.
///
/// Features:
///
/// - FVM actor create events, calls, etc. show up as if they were EVM smart contract events.
/// - Native FVM call inputs are ABI-encoded (Solidity ABI) as if they were calls to a
/// `handle_filecoin_method(uint64 method, uint64 codec, bytes params)` function
/// (where `codec` is the IPLD codec of `params`).
/// - Native FVM call outputs (return values) are ABI-encoded as `(uint32 exit_code, uint64
/// codec, bytes output)` where `codec` is the IPLD codec of `output`.
///
/// Limitations (for now):
///
/// 1. Block rewards are not included in the trace.
/// 2. SELFDESTRUCT operations are not included in the trace.
/// 3. EVM smart contract "create" events always specify `0xfe` as the "code" for newly created EVM smart contracts.
///
/// Permission: read
class LotusFullNodeRequestEthTraceBlock
    extends
        LotusFullNodeRequest<
          List<LotusResponseEthTraceBlock>,
          List<Map<String, dynamic>>?
        > {
  final String height;
  const LotusFullNodeRequestEthTraceBlock({required this.height});

  @override
  String get jsonRpcMethod => 'Filecoin.EthTraceBlock';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [height];
  }

  @override
  List<LotusResponseEthTraceBlock> onResponse(
    List<Map<String, dynamic>>? result,
  ) {
    return result
            ?.map((e) => LotusResponseEthTraceBlock.fromJson(e))
            .toList() ??
        [];
  }
}

/// JSON-RPC `Filecoin.EthTraceFilter`
/// Implements OpenEthereum-compatible API method trace_filter
///
/// Permission: read
class LotusFullNodeRequestEthTraceFilter
    extends
        LotusFullNodeRequest<
          List<LotusResponseEthTraceFilterResult?>,
          List<Map<String, dynamic>>?
        > {
  final LotusParamsEthTraceFilterCriteria ethTraceFilterCriteria;
  const LotusFullNodeRequestEthTraceFilter({
    required this.ethTraceFilterCriteria,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.EthTraceFilter';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [ethTraceFilterCriteria.toJson()];
  }

  @override
  List<LotusResponseEthTraceFilterResult> onResponse(
    List<Map<String, dynamic>>? result,
  ) {
    return result
            ?.map((e) => LotusResponseEthTraceFilterResult.fromJson(e))
            .toList() ??
        [];
  }
}

/// JSON-RPC `Filecoin.EthTraceReplayBlockTransactions`
/// Replays all transactions in a block returning the requested traces for each transaction
///
/// Permission: read
class LotusFullNodeRequestEthTraceReplayBlockTransactions
    extends
        LotusFullNodeRequest<
          List<LotusResponseEthTraceReplayBlockTransaction>,
          List<Map<String, dynamic>>?
        > {
  final String value;
  final List<String> arg;
  const LotusFullNodeRequestEthTraceReplayBlockTransactions({
    required this.value,
    required this.arg,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.EthTraceReplayBlockTransactions';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [value, arg];
  }

  @override
  List<LotusResponseEthTraceReplayBlockTransaction> onResponse(
    List<Map<String, dynamic>>? result,
  ) {
    return result
            ?.map(
              (e) => LotusResponseEthTraceReplayBlockTransaction.fromJson(e),
            )
            .toList() ??
        [];
  }
}

/// JSON-RPC `Filecoin.EthTraceTransaction`
/// Implements OpenEthereum-compatible API method trace_transaction
///
/// Permission: read
class LotusFullNodeRequestEthTraceTransaction
    extends
        LotusFullNodeRequest<
          List<LotusResponseEthTraceTransaction>,
          List<Map<String, dynamic>>?
        > {
  final String value;
  const LotusFullNodeRequestEthTraceTransaction({required this.value});

  @override
  String get jsonRpcMethod => 'Filecoin.EthTraceTransaction';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [value];
  }

  @override
  List<LotusResponseEthTraceTransaction> onResponse(
    List<Map<String, dynamic>>? result,
  ) {
    return result
            ?.map((e) => LotusResponseEthTraceTransaction.fromJson(e))
            .toList() ??
        [];
  }
}

/// JSON-RPC `Filecoin.EthUninstallFilter`
/// Uninstalls a filter with given id.
///
/// Permission: read
class LotusFullNodeRequestEthUninstallFilter
    extends LotusFullNodeRequest<bool, bool> {
  final String ethFilterID;
  const LotusFullNodeRequestEthUninstallFilter({required this.ethFilterID});

  @override
  String get jsonRpcMethod => 'Filecoin.EthUninstallFilter';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [ethFilterID];
  }

  @override
  bool onResponse(bool result) {
    return result == true;
  }
}

/// JSON-RPC `Filecoin.EthUnsubscribe`
/// Unsubscribe from a websocket subscription
///
/// Permission: read
class LotusFullNodeRequestEthUnsubscribe
    extends LotusFullNodeRequest<bool, bool> {
  final String ethSubscriptionID;
  const LotusFullNodeRequestEthUnsubscribe({required this.ethSubscriptionID});

  @override
  String get jsonRpcMethod => 'Filecoin.EthUnsubscribe';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [ethSubscriptionID];
  }

  @override
  bool onResponse(bool result) {
    return result == true;
  }
}

/// JSON-RPC `Filecoin.F3GetCertificate`
/// F3GetCertificate returns a finality certificate at given instance.
///
/// Permission: read
class LotusFullNodeRequestF3GetCertificate
    extends
        LotusFullNodeRequest<
          LotusResponseFinalityCertificate?,
          Map<String, dynamic>?
        > {
  final BigInt arg;
  const LotusFullNodeRequestF3GetCertificate({required this.arg});

  @override
  String get jsonRpcMethod => 'Filecoin.F3GetCertificate';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [arg];
  }

  @override
  LotusResponseFinalityCertificate? onResponse(Map<String, dynamic>? result) {
    return result == null
        ? null
        : LotusResponseFinalityCertificate.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.F3GetLatestCertificate`
/// F3GetLatestCertificate returns the latest finality certificate.
///
/// Permission: read
class LotusFullNodeRequestF3GetLatestCertificate
    extends
        LotusFullNodeRequest<
          LotusResponseFinalityCertificate?,
          Map<String, dynamic>?
        > {
  const LotusFullNodeRequestF3GetLatestCertificate();

  @override
  String get jsonRpcMethod => 'Filecoin.F3GetLatestCertificate';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return const <dynamic>[];
  }

  @override
  LotusResponseFinalityCertificate? onResponse(Map<String, dynamic>? result) {
    return result == null
        ? null
        : LotusResponseFinalityCertificate.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.F3GetPowerTableByInstance`
/// F3GetPowerTableByInstance returns the power table (committee) used to validate the specified instance.
///
/// Permission: read
class LotusFullNodeRequestF3GetPowerTableByInstance
    extends
        LotusFullNodeRequest<
          List<LotusResponsePowerEntry>,
          List<Map<String, dynamic>>?
        > {
  final BigInt arg;
  const LotusFullNodeRequestF3GetPowerTableByInstance({required this.arg});

  @override
  String get jsonRpcMethod => 'Filecoin.F3GetPowerTableByInstance';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [arg];
  }

  @override
  List<LotusResponsePowerEntry> onResponse(List<Map<String, dynamic>>? result) {
    return result?.map((e) => LotusResponsePowerEntry.fromJson(e)).toList() ??
        [];
  }
}

/// JSON-RPC `Filecoin.FilecoinAddressToEthAddress`
/// `FilecoinAddressToEthAddress` converts any Filecoin address to an EthAddress.
///
/// This method supports all Filecoin address types:
/// - "f0" and "f4" addresses: Converted directly.
/// - "f1", "f2", and "f3" addresses: First converted to their corresponding "f0" ID address, then to an EthAddress.
///
/// Requirements:
/// - For "f1", "f2", and "f3" addresses, they must be instantiated on-chain, as "f0" ID addresses are only assigned to actors when they are created on-chain.
/// The simplest way to instantiate an address on chain is to send a transaction to the address.
///
/// Note on chain reorganizations:
/// "f0" ID addresses are not permanent and can be affected by chain reorganizations. To account for this,
/// the API includes a `blkNum` parameter, which specifies the block number that is used to determine the tipset state to use for converting an
/// "f1"/"f2"/"f3" address to an "f0" address. This parameter functions similarly to the `blkNum` parameter in the existing `EthGetBlockByNumber` API.
/// See https://docs.alchemy.com/reference/eth-getblockbynumber for more details.
///
/// Parameters:
/// - ctx: The context for the API call.
/// - filecoinAddress: The Filecoin address to convert.
/// - blkNum: The block number or state for the conversion. Defaults to "finalized" for maximum safety.
/// Possible values: "pending", "latest", "finalized", "safe", or a specific block number represented as hex.
///
/// Returns:
/// - The corresponding EthAddress.
/// - An error if the conversion fails.
///
/// Permission: read
class LotusFullNodeRequestFilecoinAddressToEthAddress
    extends LotusFullNodeRequest<String, String> {
  final List<dynamic> params;
  const LotusFullNodeRequestFilecoinAddressToEthAddress({required this.params});

  @override
  String get jsonRpcMethod => 'Filecoin.FilecoinAddressToEthAddress';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return params;
  }

  @override
  String onResponse(String result) {
    return result;
  }
}

/// JSON-RPC `Filecoin.GasEstimateGasPremium`
/// GasEstimateGasPremium estimates what gas price should be used for a
/// message to have high likelihood of inclusion in `nblocksincl` epochs.
///
/// Permission: read
class LotusFullNodeRequestGasEstimateGasPremium
    extends LotusFullNodeRequest<BigInt, String> {
  final BigInt nblocksincl;
  final String sender;
  final BigInt gaslimit;
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestGasEstimateGasPremium({
    required this.nblocksincl,
    required this.sender,
    required this.gaslimit,
    this.tsk,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.GasEstimateGasPremium';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [nblocksincl, sender, gaslimit, tsk?.toJson()];
  }

  @override
  BigInt onResponse(String result) {
    return JsonParser.valueAsBigInt(result);
  }
}

/// JSON-RPC `Filecoin.GasEstimateMessageGas`
/// GasEstimateMessageGas estimates gas values for unset message gas fields
///
/// Permission: read
class LotusFullNodeRequestGasEstimateMessageGas
    extends LotusFullNodeRequest<FilMessage, Map<String, dynamic>> {
  final FilMessage message;
  final LotusParamsMessageSendSpec? messageSendSpec;
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestGasEstimateMessageGas({
    required this.message,
    this.messageSendSpec,
    this.tsk,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.GasEstimateMessageGas';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [message.toJson(), messageSendSpec?.toJson(), tsk?.toJson()];
  }

  @override
  FilMessage onResponse(Map<String, dynamic> result) {
    return FilMessage.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.GetActorEventsRaw`
/// GetActorEventsRaw returns all user-programmed and built-in actor events that match the given
/// filter.
/// This is a request/response API.
/// Results available from this API may be limited by the MaxFilterResults and MaxFilterHeightRange
/// configuration options and also the amount of historical data available in the node.
///
/// This is an EXPERIMENTAL API and may be subject to change.
///
/// Permission: read
class LotusFullNodeRequestGetActorEventsRaw
    extends
        LotusFullNodeRequest<
          List<LotusResponseActorEvent>,
          List<Map<String, dynamic>>?
        > {
  final LotusParamsActorEventFilter actorEventFilter;
  const LotusFullNodeRequestGetActorEventsRaw({required this.actorEventFilter});

  @override
  String get jsonRpcMethod => 'Filecoin.GetActorEventsRaw';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [actorEventFilter.toJson()];
  }

  @override
  List<LotusResponseActorEvent> onResponse(List<Map<String, dynamic>>? result) {
    return result?.map((e) => LotusResponseActorEvent.fromJson(e)).toList() ??
        [];
  }
}

/// JSON-RPC `Filecoin.MinerGetBaseInfo`
class LotusFullNodeRequestMinerGetBaseInfo
    extends
        LotusFullNodeRequest<
          LotusResponseMiningBaseInfo?,
          Map<String, dynamic>?
        > {
  final String maddr;
  final BigInt epoch;
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestMinerGetBaseInfo({
    required this.maddr,
    required this.epoch,
    this.tsk,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.MinerGetBaseInfo';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [maddr, epoch, tsk?.toJson()];
  }

  @override
  LotusResponseMiningBaseInfo? onResponse(Map<String, dynamic>? result) {
    return result == null ? null : LotusResponseMiningBaseInfo.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.MpoolGetNonce`
/// MpoolGetNonce gets next nonce for the specified sender.
/// Note that this method may not be atomic. Use MpoolPushMessage instead.
///
/// Permission: read
class LotusFullNodeRequestMpoolGetNonce extends LotusFullNodeRequest<int, int> {
  final String address;
  const LotusFullNodeRequestMpoolGetNonce({required this.address});

  @override
  String get jsonRpcMethod => 'Filecoin.MpoolGetNonce';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [address];
  }
}

/// JSON-RPC `Filecoin.MpoolPending`
/// MpoolPending returns pending mempool messages.
///
/// Permission: read
class LotusFullNodeRequestMpoolPending
    extends
        LotusFullNodeRequest<
          List<FilSignedMessage>,
          List<Map<String, dynamic>>?
        > {
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestMpoolPending({this.tsk});

  @override
  String get jsonRpcMethod => 'Filecoin.MpoolPending';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [tsk?.toJson()];
  }

  @override
  List<FilSignedMessage> onResponse(List<Map<String, dynamic>>? result) {
    return result?.map((e) => FilSignedMessage.fromJson(e)).toList() ?? [];
  }
}

/// JSON-RPC `Filecoin.MpoolPush`
/// MpoolPush pushes a signed message to mempool.
///
/// Permission: write
class LotusFullNodeRequestMpoolPush extends LotusFullNodeRequest<Cid, dynamic> {
  final FilSignedMessage message;
  const LotusFullNodeRequestMpoolPush({required this.message});

  @override
  String get jsonRpcMethod => 'Filecoin.MpoolPush';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [message.toJson()];
  }

  @override
  Cid onResponse(dynamic result) {
    return Cid.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.MsigGetAvailableBalance`
/// MsigGetAvailableBalance returns the portion of a multisig's balance that can be withdrawn or spent
///
/// Permission: read
class LotusFullNodeRequestMsigGetAvailableBalance
    extends LotusFullNodeRequest<BigInt?, String?> {
  final String address;
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestMsigGetAvailableBalance({
    required this.address,
    this.tsk,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.MsigGetAvailableBalance';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [address, tsk?.toJson()];
  }

  @override
  BigInt? onResponse(String? result) {
    if (result == null) return null;
    return JsonParser.valueAsBigInt(result);
  }
}

/// JSON-RPC `Filecoin.MsigGetPending`
/// MsigGetPending returns pending transactions for the given multisig
/// wallet. Once pending transactions are fully approved, they will no longer
/// appear here.
///
/// Permission: read
class LotusFullNodeRequestMsigGetPending
    extends
        LotusFullNodeRequest<
          List<LotusResponseMsigTransaction>,
          List<Map<String, dynamic>>?
        > {
  final String address;
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestMsigGetPending({required this.address, this.tsk});

  @override
  String get jsonRpcMethod => 'Filecoin.MsigGetPending';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [address, tsk?.toJson()];
  }

  @override
  List<LotusResponseMsigTransaction> onResponse(
    List<Map<String, dynamic>>? result,
  ) {
    return result
            ?.map((e) => LotusResponseMsigTransaction?.fromJson(e))
            .toList() ??
        [];
  }
}

/// JSON-RPC `Filecoin.MsigGetVested`
/// MsigGetVested returns the amount of FIL that vested in a multisig in a certain period.
/// It takes the following params: multisig address, start epoch, end epoch
///
/// Permission: read
class LotusFullNodeRequestMsigGetVested
    extends LotusFullNodeRequest<BigInt, String> {
  final String address;
  final LotusTipSetKey? tsk;
  final LotusTipSetKey? to;
  const LotusFullNodeRequestMsigGetVested({
    required this.address,
    this.tsk,
    this.to,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.MsigGetVested';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [address, tsk?.toJson(), to?.toJson()];
  }

  @override
  BigInt onResponse(String result) {
    return JsonParser.valueAsBigInt(result);
  }
}

/// JSON-RPC `Filecoin.MsigGetVestingSchedule`
/// MsigGetVestingSchedule returns the vesting details of a given multisig.
///
/// Permission: read
class LotusFullNodeRequestMsigGetVestingSchedule
    extends
        LotusFullNodeRequest<LotusResponseMsigVesting, Map<String, dynamic>> {
  final String address;
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestMsigGetVestingSchedule({
    required this.address,
    this.tsk,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.MsigGetVestingSchedule';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [address, tsk?.toJson()];
  }

  @override
  LotusResponseMsigVesting onResponse(Map<String, dynamic> result) {
    return LotusResponseMsigVesting.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.NetListening`
class LotusFullNodeRequestNetListening
    extends LotusFullNodeRequest<bool, bool> {
  const LotusFullNodeRequestNetListening();

  @override
  String get jsonRpcMethod => 'Filecoin.NetListening';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return const <dynamic>[];
  }
}

/// JSON-RPC `Filecoin.NetVersion`
class LotusFullNodeRequestNetVersion
    extends LotusFullNodeRequest<String, String> {
  const LotusFullNodeRequestNetVersion();

  @override
  String get jsonRpcMethod => 'Filecoin.NetVersion';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return const <dynamic>[];
  }
}

/// JSON-RPC `Filecoin.StateAccountKey`
/// StateAccountKey returns the public key address of the given ID address for secp and bls accounts
///
/// Permission: read
class LotusFullNodeRequestStateAccountKey
    extends LotusFullNodeRequest<String, String> {
  final String address;
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestStateAccountKey({required this.address, this.tsk});

  @override
  String get jsonRpcMethod => 'Filecoin.StateAccountKey';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [address, tsk?.toJson()];
  }
}

/// JSON-RPC `Filecoin.StateCall`
/// StateCall runs the given message and returns its result without any persisted changes.
///
/// StateCall applies the message to the tipset's parent state. The
/// message is not applied on-top-of the messages in the passed-in
/// tipset.
///
/// Permission: read
class LotusFullNodeRequestStateCall
    extends
        LotusFullNodeRequest<LotusResponseInvocResult?, Map<String, dynamic>?> {
  final FilMessage message;
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestStateCall({required this.message, this.tsk});

  @override
  String get jsonRpcMethod => 'Filecoin.StateCall';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [message.toJson(), tsk?.toJson()];
  }

  @override
  LotusResponseInvocResult? onResponse(Map<String, dynamic>? result) {
    return result == null ? null : LotusResponseInvocResult.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.StateChangedActors`
/// StateChangedActors returns all the actors whose states change between the two given state CIDs
/// Permission: read
class LotusFullNodeRequestStateChangedActors
    extends
        LotusFullNodeRequest<
          Map<String, LotusResponseActor>,
          Map<String, dynamic>
        > {
  final Cid oldRoot;
  final Cid newRoot;
  const LotusFullNodeRequestStateChangedActors({
    required this.oldRoot,
    required this.newRoot,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.StateChangedActors';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [oldRoot.toJson(), newRoot.toJson()];
  }

  @override
  Map<String, LotusResponseActor> onResponse(Map<String, dynamic> result) {
    return result.map((k, v) => MapEntry(k, LotusResponseActor.fromJson(v)));
  }
}

/// JSON-RPC `Filecoin.StateDealProviderCollateralBounds`
/// StateDealProviderCollateralBounds returns the min and max collateral a storage provider
/// can issue. It takes the deal size and verified status as parameters.
/// Note: The min value returned is overestimated by 10% (multiplied by 110/100).
/// See: node/impl/full/state.go StateDealProviderCollateralBounds implementation.
///
/// Permission: read
class LotusFullNodeRequestStateDealProviderCollateralBounds
    extends
        LotusFullNodeRequest<
          LotusResponseDealCollateralBounds,
          Map<String, dynamic>
        > {
  final BigInt paddedPieceSize;
  final bool flag;
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestStateDealProviderCollateralBounds({
    required this.paddedPieceSize,
    required this.flag,
    this.tsk,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.StateDealProviderCollateralBounds';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [paddedPieceSize, flag, tsk?.toJson()];
  }

  @override
  LotusResponseDealCollateralBounds onResponse(Map<String, dynamic> result) {
    return LotusResponseDealCollateralBounds.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.StateDecodeParams`
/// StateDecodeParams attempts to decode the provided params, based on the recipient actor address and method number.
///
/// Permission: read
class LotusFullNodeRequestStateDecodeParams
    extends LotusFullNodeRequest<dynamic, dynamic> {
  final String address;
  final BigInt methodNum;
  final List<int> data;
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestStateDecodeParams({
    required this.address,
    required this.methodNum,
    required this.data,
    this.tsk,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.StateDecodeParams';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [address, methodNum, data, tsk?.toJson()];
  }
}

/// JSON-RPC `Filecoin.StateGetActor`
/// StateGetActor returns the indicated actor's nonce and balance.
///
/// Permission: read
class LotusFullNodeRequestStateGetActor
    extends LotusFullNodeRequest<LotusResponseActor?, Map<String, dynamic>?> {
  final String actor;
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestStateGetActor({required this.actor, this.tsk});

  @override
  String get jsonRpcMethod => 'Filecoin.StateGetActor';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [actor, tsk?.toJson()];
  }

  @override
  LotusResponseActor? onResponse(Map<String, dynamic>? result) {
    return result == null ? null : LotusResponseActor.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.StateGetAllocation`
/// StateGetAllocation returns the allocation for a given address and allocation ID.
///
/// Permission: read
class LotusFullNodeRequestStateGetAllocation
    extends
        LotusFullNodeRequest<
          LotusResponseStateGetAllocation?,
          Map<String, dynamic>?
        > {
  final String address;
  final BigInt allocationId;
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestStateGetAllocation({
    required this.address,
    required this.allocationId,
    this.tsk,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.StateGetAllocation';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [address, allocationId, tsk?.toJson()];
  }

  @override
  LotusResponseStateGetAllocation? onResponse(Map<String, dynamic>? result) {
    return result == null
        ? null
        : LotusResponseStateGetAllocation.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.StateGetAllocationForPendingDeal`
/// StateGetAllocationForPendingDeal returns the allocation for a given deal ID of a pending deal. Returns nil if
/// pending allocation is not found.
///
/// Permission: read
class LotusFullNodeRequestStateGetAllocationForPendingDeal
    extends
        LotusFullNodeRequest<
          LotusResponseStateGetAllocation?,
          Map<String, dynamic>?
        > {
  final BigInt dealID;
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestStateGetAllocationForPendingDeal({
    required this.dealID,
    this.tsk,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.StateGetAllocationForPendingDeal';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [dealID, tsk?.toJson()];
  }

  @override
  LotusResponseStateGetAllocation? onResponse(Map<String, dynamic>? result) {
    return result == null
        ? null
        : LotusResponseStateGetAllocation.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.StateGetAllocations`
/// StateGetAllocations returns the all the allocations for a given client.
///
/// Permission: read
class LotusFullNodeRequestStateGetAllocations
    extends
        LotusFullNodeRequest<
          LotusResponseStateGetAllocation?,
          Map<String, dynamic>?
        > {
  final String address;
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestStateGetAllocations({
    required this.address,
    this.tsk,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.StateGetAllocations';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [address, tsk?.toJson()];
  }

  @override
  LotusResponseStateGetAllocation? onResponse(Map<String, dynamic>? result) {
    if (result == null) return null;
    return LotusResponseStateGetAllocation.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.StateGetClaim`
/// StateGetClaim returns the claim for a given address and claim ID.
///
/// Permission: read
class LotusFullNodeRequestStateGetClaim
    extends LotusFullNodeRequest<LotusResponseClaim?, Map<String, dynamic>?> {
  final String address;
  final BigInt claimId;
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestStateGetClaim({
    required this.address,
    required this.claimId,
    this.tsk,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.StateGetClaim';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [address, claimId, tsk?.toJson()];
  }

  @override
  LotusResponseClaim? onResponse(Map<String, dynamic>? result) {
    return result == null ? null : LotusResponseClaim.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.StateGetClaims`
/// StateGetClaims returns the all the claims for a given provider.
///
/// Permission: read
class LotusFullNodeRequestStateGetClaims
    extends
        LotusFullNodeRequest<
          Map<BigInt, LotusResponseClaim>,
          Map<dynamic, dynamic>
        > {
  final String address;
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestStateGetClaims({required this.address, this.tsk});

  @override
  String get jsonRpcMethod => 'Filecoin.StateGetClaims';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [address, tsk?.toJson()];
  }

  @override
  Map<BigInt, LotusResponseClaim> onResponse(Map<dynamic, dynamic> result) {
    return result.map(
      (k, v) =>
          MapEntry(JsonParser.valueAsBigInt(k), LotusResponseClaim.fromJson(v)),
    );
  }
}

/// JSON-RPC `Filecoin.StateGetNetworkParams`
/// StateGetNetworkParams return current network params
///
/// Permission: read
class LotusFullNodeRequestStateGetNetworkParams
    extends
        LotusFullNodeRequest<LotusResponseNetworkParams, Map<String, dynamic>> {
  const LotusFullNodeRequestStateGetNetworkParams();

  @override
  String get jsonRpcMethod => 'Filecoin.StateGetNetworkParams';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return const <dynamic>[];
  }

  @override
  LotusResponseNetworkParams onResponse(Map<String, dynamic> result) {
    return LotusResponseNetworkParams.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.StateGetRandomnessDigestFromBeacon`
/// StateGetRandomnessDigestFromBeacon is used to sample the beacon for randomness.
///
/// Permission: read
class LotusFullNodeRequestStateGetRandomnessDigestFromBeacon
    extends LotusFullNodeRequest<List<int>, String> {
  final BigInt epoch;
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestStateGetRandomnessDigestFromBeacon({
    required this.epoch,
    this.tsk,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.StateGetRandomnessDigestFromBeacon';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [epoch, tsk?.toJson()];
  }

  @override
  List<int> onResponse(String result) {
    return JsonParser.valueAsBytes(result, encoding: StringEncoding.base64);
  }
}

/// JSON-RPC `Filecoin.StateListMiners`
/// StateListMiners returns the addresses of every miner that has claimed power in the Power Actor
///
/// Permission: read
class LotusFullNodeRequestStateListMiners
    extends LotusFullNodeRequest<List<String>, List<String>?> {
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestStateListMiners({this.tsk});

  @override
  String get jsonRpcMethod => 'Filecoin.StateListMiners';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [tsk?.toJson()];
  }

  @override
  List<String> onResponse(List<String>? result) {
    return result ?? [];
  }
}

/// JSON-RPC `Filecoin.StateLookupID`
/// StateLookupID retrieves the ID address of the given address
///
/// Permission: read
class LotusFullNodeRequestStateLookupID
    extends LotusFullNodeRequest<String?, String?> {
  final String address;
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestStateLookupID({required this.address, this.tsk});

  @override
  String get jsonRpcMethod => 'Filecoin.StateLookupID';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [address, tsk?.toJson()];
  }
}

/// JSON-RPC `Filecoin.StateLookupRobustAddress`
/// StateLookupRobustAddress returns the public key address of the given ID address for non-account addresses (multisig, miners etc)
///
/// Permission: read
class LotusFullNodeRequestStateLookupRobustAddress
    extends LotusFullNodeRequest<String, String> {
  final String address;
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestStateLookupRobustAddress({
    required this.address,
    this.tsk,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.StateLookupRobustAddress';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [address, tsk?.toJson()];
  }
}

/// JSON-RPC `Filecoin.StateMarketBalance`
/// StateMarketBalance looks up the Escrow and Locked balances of the given address in the Storage Market
///
/// Permission: read
class LotusFullNodeRequestStateMarketBalance
    extends
        LotusFullNodeRequest<LotusResponseMarketBalance, Map<String, dynamic>> {
  final String address;
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestStateMarketBalance({
    required this.address,
    this.tsk,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.StateMarketBalance';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [address, tsk?.toJson()];
  }

  @override
  LotusResponseMarketBalance onResponse(Map<String, dynamic> result) {
    return LotusResponseMarketBalance.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.StateMarketStorageDeal`
/// StateMarketStorageDeal returns information about the indicated deal
///
/// Permission: read
class LotusFullNodeRequestStateMarketStorageDeal
    extends
        LotusFullNodeRequest<LotusResponseMarketDeal?, Map<String, dynamic>?> {
  final BigInt dealID;
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestStateMarketStorageDeal({
    required this.dealID,
    this.tsk,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.StateMarketStorageDeal';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [dealID, tsk?.toJson()];
  }

  @override
  LotusResponseMarketDeal? onResponse(Map<String, dynamic>? result) {
    return result == null ? null : LotusResponseMarketDeal.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.StateMinerAvailableBalance`
/// StateMinerAvailableBalance returns the portion of a miner's balance that can be withdrawn or
/// spent. It is calculated by subtracting the following from the miner actor's balance:
/// * Locked vesting funds (accounting for vesting funds that should already be unlocked)
/// * PreCommit deposits
/// * Initial pledge collateral
///
/// Permission: read
class LotusFullNodeRequestStateMinerAvailableBalance
    extends LotusFullNodeRequest<BigInt, String> {
  final String address;
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestStateMinerAvailableBalance({
    required this.address,
    this.tsk,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.StateMinerAvailableBalance';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [address, tsk?.toJson()];
  }

  @override
  BigInt onResponse(String result) {
    return JsonParser.valueAsBigInt(result);
  }
}

/// JSON-RPC `Filecoin.StateMinerDeadlines`
/// StateMinerDeadlines returns all the proving deadlines for the given miner
///
/// Permission: read
class LotusFullNodeRequestStateMinerDeadlines
    extends
        LotusFullNodeRequest<
          List<LotusResponseDeadline>,
          List<Map<String, dynamic>>?
        > {
  final String address;
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestStateMinerDeadlines({
    required this.address,
    this.tsk,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.StateMinerDeadlines';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [address, tsk?.toJson()];
  }

  @override
  List<LotusResponseDeadline> onResponse(List<Map<String, dynamic>>? result) {
    return result?.map((e) => LotusResponseDeadline.fromJson(e)).toList() ?? [];
  }
}

/// JSON-RPC `Filecoin.StateMinerInfo`
/// StateMinerInfo returns info about the indicated miner
///
/// Permission: read
class LotusFullNodeRequestStateMinerInfo
    extends LotusFullNodeRequest<LotusResponseMinerInfo, Map<String, dynamic>> {
  final String address;
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestStateMinerInfo({required this.address, this.tsk});

  @override
  String get jsonRpcMethod => 'Filecoin.StateMinerInfo';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [address, tsk?.toJson()];
  }

  @override
  LotusResponseMinerInfo onResponse(Map<String, dynamic> result) {
    return LotusResponseMinerInfo.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.StateMinerPower`
/// StateMinerPower returns the power of the indicated miner
///
/// Permission: read
class LotusFullNodeRequestStateMinerPower
    extends
        LotusFullNodeRequest<LotusResponseMinerPower?, Map<String, dynamic>> {
  final String address;
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestStateMinerPower({required this.address, this.tsk});

  @override
  String get jsonRpcMethod => 'Filecoin.StateMinerPower';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [address, tsk?.toJson()];
  }

  @override
  LotusResponseMinerPower onResponse(Map<String, dynamic> result) {
    return LotusResponseMinerPower.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.StateMinerProvingDeadline`
/// StateMinerProvingDeadline calculates the deadline at some epoch for a proving period
/// and returns the deadline-related calculations.
///
/// Permission: read
class LotusFullNodeRequestStateMinerProvingDeadline
    extends
        LotusFullNodeRequest<LotusResponseDeadlineInfo, Map<String, dynamic>> {
  final String address;
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestStateMinerProvingDeadline({
    required this.address,
    this.tsk,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.StateMinerProvingDeadline';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [address, tsk?.toJson()];
  }

  @override
  LotusResponseDeadlineInfo onResponse(Map<String, dynamic> result) {
    return LotusResponseDeadlineInfo.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.StateMinerSectorCount`
/// StateMinerSectorCount returns the number of sectors in a miner's sector set and proving set
///
/// Permission: read
class LotusFullNodeRequestStateMinerSectorCount
    extends
        LotusFullNodeRequest<LotusResponseMinerSectors, Map<String, dynamic>> {
  final String address;
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestStateMinerSectorCount({
    required this.address,
    this.tsk,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.StateMinerSectorCount';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [address, tsk?.toJson()];
  }

  @override
  LotusResponseMinerSectors onResponse(Map<String, dynamic> result) {
    return LotusResponseMinerSectors.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.StateNetworkName`
/// StateNetworkName returns the name of the network the node is synced to
///
/// Permission: read
class LotusFullNodeRequestStateNetworkName
    extends LotusFullNodeRequest<String, String> {
  const LotusFullNodeRequestStateNetworkName();

  @override
  String get jsonRpcMethod => 'Filecoin.StateNetworkName';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return const <dynamic>[];
  }
}

/// JSON-RPC `Filecoin.StateNetworkVersion`
/// StateNetworkVersion returns the network version at the given tipset
///
/// Permission: read
class LotusFullNodeRequestStateNetworkVersion
    extends LotusFullNodeRequest<int, int> {
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestStateNetworkVersion({this.tsk});

  @override
  String get jsonRpcMethod => 'Filecoin.StateNetworkVersion';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [tsk?.toJson()];
  }
}

class LotusFullNodeRequestStateActorCodeCIDs
    extends LotusFullNodeRequest<dynamic, dynamic> {
  final int version;
  const LotusFullNodeRequestStateActorCodeCIDs(this.version);

  @override
  String get jsonRpcMethod => 'Filecoin.StateActorCodeCIDs';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [version];
  }
}

/// JSON-RPC `Filecoin.StateReadState`
/// StateReadState returns the indicated actor's state.
///
/// Permission: read
class LotusFullNodeRequestStateReadState
    extends
        LotusFullNodeRequest<LotusResponseActorState?, Map<String, dynamic>?> {
  final String actor;
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestStateReadState({required this.actor, this.tsk});

  @override
  String get jsonRpcMethod => 'Filecoin.StateReadState';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [actor, tsk?.toJson()];
  }

  @override
  LotusResponseActorState? onResponse(Map<String, dynamic>? result) {
    return result == null ? null : LotusResponseActorState.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.StateReplay`
/// StateReplay replays a given message, assuming it was included in a block in the specified tipset.
///
/// If a tipset key is provided, and a replacing message is not found on chain,
/// the method will return an error saying that the message wasn't found
///
/// If no tipset key is provided, the appropriate tipset is looked up, and if
/// the message was gas-repriced, the on-chain message will be replayed - in
/// that case the returned InvocResult.MsgCid will not match the Cid param
///
/// If the caller wants to ensure that exactly the requested message was executed,
/// they MUST check that InvocResult.MsgCid is equal to the provided Cid.
/// Without this check both the requested and original message may appear as
/// successfully executed on-chain, which may look like a double-spend.
///
/// A replacing message is a message with a different CID, any of Gas values, and
/// different signature, but with all other parameters matching (source/destination,
/// nonce, params, etc.)
///
/// Permission: read
class LotusFullNodeRequestStateReplay
    extends
        LotusFullNodeRequest<LotusResponseInvocResult?, Map<String, dynamic>?> {
  final LotusTipSetKey? tsk;
  final Cid cid;
  const LotusFullNodeRequestStateReplay({this.tsk, required this.cid});

  @override
  String get jsonRpcMethod => 'Filecoin.StateReplay';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [tsk?.toJson(), cid.toJson()];
  }

  @override
  LotusResponseInvocResult? onResponse(Map<String, dynamic>? result) {
    return result == null ? null : LotusResponseInvocResult.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.StateSearchMsg`
/// StateSearchMsg looks back up to limit epochs in the chain for a message, and returns its receipt and the tipset where it was executed
///
/// NOTE: If a replacing message is found on chain, this method will return
/// a MsgLookup for the replacing message - the MsgLookup.Message will be a different
/// CID than the one provided in the 'cid' param, MsgLookup.Receipt will contain the
/// result of the execution of the replacing message.
///
/// If the caller wants to ensure that exactly the requested message was executed,
/// they must check that MsgLookup.Message is equal to the provided 'cid', or set the
/// `allowReplaced` parameter to false. Without this check, and with `allowReplaced`
/// set to true, both the requested and original message may appear as
/// successfully executed on-chain, which may look like a double-spend.
///
/// A replacing message is a message with a different CID, any of Gas values, and
/// different signature, but with all other parameters matching (source/destination,
/// nonce, params, etc.)
///
/// Permission: read
class LotusFullNodeRequestStateSearchMsg
    extends
        LotusFullNodeRequest<LotusResponseMsgLookup?, Map<String, dynamic>?> {
  final LotusTipSetKey? from;
  final Cid msg;
  final BigInt limit;
  final bool allowReplaced;
  const LotusFullNodeRequestStateSearchMsg({
    this.from,
    required this.msg,
    required this.limit,
    required this.allowReplaced,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.StateSearchMsg';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [from?.toJson(), msg.toJson(), limit, allowReplaced];
  }

  @override
  LotusResponseMsgLookup? onResponse(Map<String, dynamic>? result) {
    return result == null ? null : LotusResponseMsgLookup.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.StateSectorGetInfo`
/// StateSectorGetInfo returns the on-chain info for the specified miner's sector. Returns null in case the sector info isn't found
/// NOTE: returned info.Expiration may not be accurate in some cases, use StateSectorExpiration to get accurate
/// expiration limit
///
/// Permission: read
class LotusFullNodeRequestStateSectorGetInfo
    extends
        LotusFullNodeRequest<
          LotusResponseSectorOnChainInfo?,
          Map<String, dynamic>?
        > {
  final String address;
  final BigInt sectorNumber;
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestStateSectorGetInfo({
    required this.address,
    required this.sectorNumber,
    this.tsk,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.StateSectorGetInfo';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [address, sectorNumber, tsk?.toJson()];
  }

  @override
  LotusResponseSectorOnChainInfo? onResponse(Map<String, dynamic>? result) {
    return result == null
        ? null
        : LotusResponseSectorOnChainInfo.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.StateSectorPartition`
/// StateSectorPartition finds deadline/partition with the specified sector
///
/// Permission: read
class LotusFullNodeRequestStateSectorPartition
    extends
        LotusFullNodeRequest<
          LotusResponseSectorLocation?,
          Map<String, dynamic>?
        > {
  final String address;
  final BigInt sectorNumber;
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestStateSectorPartition({
    required this.address,
    required this.sectorNumber,
    this.tsk,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.StateSectorPartition';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [address, sectorNumber, tsk?.toJson()];
  }

  @override
  LotusResponseSectorLocation? onResponse(Map<String, dynamic>? result) {
    return result == null ? null : LotusResponseSectorLocation.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.StateVerifiedClientStatus`
/// StateVerifiedClientStatus returns the data cap for the given address.
/// Returns nil if there is no entry in the data cap table for the
/// address.
///
/// Permission: read
class LotusFullNodeRequestStateVerifiedClientStatus
    extends LotusFullNodeRequest<BigInt?, String?> {
  final String address;
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestStateVerifiedClientStatus({
    required this.address,
    this.tsk,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.StateVerifiedClientStatus';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [address, tsk?.toJson()];
  }

  @override
  BigInt? onResponse(String? result) {
    return result == null ? null : JsonParser.valueAsBigInt(result);
  }
}

/// JSON-RPC `Filecoin.StateVerifiedRegistryRootKey`
/// StateVerifiedRegistryRootKey returns the address of the Verified Registry's root key
///
/// Permission: read
class LotusFullNodeRequestStateVerifiedRegistryRootKey
    extends LotusFullNodeRequest<String, dynamic> {
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestStateVerifiedRegistryRootKey({this.tsk});

  @override
  String get jsonRpcMethod => 'Filecoin.StateVerifiedRegistryRootKey';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [tsk?.toJson()];
  }

  @override
  String onResponse(dynamic result) {
    return result;
  }
}

/// JSON-RPC `Filecoin.StateVerifierStatus`
/// StateVerifierStatus returns the data cap for the given address.
/// Returns nil if there is no entry in the data cap table for the
/// address.
///
/// Permission: read
class LotusFullNodeRequestStateVerifierStatus
    extends LotusFullNodeRequest<BigInt?, String?> {
  final String address;
  final LotusTipSetKey? tsk;
  const LotusFullNodeRequestStateVerifierStatus({
    required this.address,
    this.tsk,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.StateVerifierStatus';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [address, tsk?.toJson()];
  }

  @override
  BigInt? onResponse(String? result) {
    return result == null ? null : JsonParser.valueAsBigInt(result);
  }
}

/// JSON-RPC `Filecoin.StateWaitMsg`
/// StateWaitMsg looks back up to limit epochs in the chain for a message.
/// If not found, it blocks until the message arrives on chain, and gets to the
/// indicated confidence depth.
///
/// NOTE: If a replacing message is found on chain, this method will return
/// a MsgLookup for the replacing message - the MsgLookup.Message will be a different
/// CID than the one provided in the 'cid' param, MsgLookup.Receipt will contain the
/// result of the execution of the replacing message.
///
/// If the caller wants to ensure that exactly the requested message was executed,
/// they must check that MsgLookup.Message is equal to the provided 'cid', or set the
/// `allowReplaced` parameter to false. Without this check, and with `allowReplaced`
/// set to true, both the requested and original message may appear as
/// successfully executed on-chain, which may look like a double-spend.
///
/// A replacing message is a message with a different CID, any of Gas values, and
/// different signature, but with all other parameters matching (source/destination,
/// nonce, params, etc.)
///
/// Permission: read
class LotusFullNodeRequestStateWaitMsg
    extends
        LotusFullNodeRequest<LotusResponseMsgLookup?, Map<String, dynamic>?> {
  final Cid cid;
  final BigInt confidence;
  final BigInt limit;
  final bool allowReplaced;
  const LotusFullNodeRequestStateWaitMsg({
    required this.cid,
    required this.confidence,
    required this.limit,
    required this.allowReplaced,
  });

  @override
  String get jsonRpcMethod => 'Filecoin.StateWaitMsg';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [cid.toJson(), confidence, limit, allowReplaced];
  }

  @override
  LotusResponseMsgLookup? onResponse(Map<String, dynamic>? result) {
    return result == null ? null : LotusResponseMsgLookup.fromJson(result);
  }
}

/// JSON-RPC `Filecoin.WalletBalance`
/// WalletBalance returns the balance of the given address at the current head of the chain.
///
/// Permission: read
class LotusFullNodeRequestWalletBalance
    extends LotusFullNodeRequest<BigInt, String?> {
  final String address;
  const LotusFullNodeRequestWalletBalance({required this.address});

  @override
  String get jsonRpcMethod => 'Filecoin.WalletBalance';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return [address];
  }

  @override
  BigInt onResponse(String? result) {
    return JsonParser.valueAsBigInt(result ?? BigInt.zero);
  }
}

/// JSON-RPC `Filecoin.Web3ClientVersion`
/// Returns the client version
///
/// Permission: read
class LotusFullNodeRequestWeb3ClientVersion
    extends LotusFullNodeRequest<String, String> {
  const LotusFullNodeRequestWeb3ClientVersion();

  @override
  String get jsonRpcMethod => 'Filecoin.Web3ClientVersion';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  List<dynamic> toJson() {
    return const <dynamic>[];
  }
}
