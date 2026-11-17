import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/rpc/api/api/utils/utils.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/models.dart';
import 'package:on_chain/hedera/src/rpc/core/core.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

class HederaGrpcRequestQuery<
  RESPONSE extends IHederaQueryRespone,
  QUERY extends IHederaQuery<RESPONSE>
>
    extends HederaGrpcRequest<RESPONSE> {
  final QUERY query;
  @override
  final String method;
  HederaGrpcRequestQuery(this.query)
    : method = HederaClientUtils.getQueryServiceTypeUrl(query).getServiceUrl();
  @override
  RESPONSE onResponse(List<int> result) {
    final response = HederaResponse.deserialize(result);
    final cResponse = query.getResponse(response);
    final status =
        cResponse.header?.nodeTransactionPrecheckCode ??
        HederaResponseCodeEnum.ok;
    if (status != HederaResponseCodeEnum.ok) {
      throw RPCError(
        message: "Hedera query failed: ${status.protoName}",
        errorCode: status.value,
        request: query.toJson(),
        relatedNetwork: BlockchainNetwork.hedera,
      );
    }
    return cResponse;
  }

  @override
  BuBytes toBuffer() {
    return query.toQueryRequest().toBuffer().asImmutableBytes;
  }
}

class HederaGrpcRequestGetBySolidityID
    extends
        HederaGrpcRequestQuery<
          HederaGetBySolidityIDResponse,
          HederaGetBySolidityIDQuery
        > {
  HederaGrpcRequestGetBySolidityID(super.query);
}

class HederaGrpcRequestContractCallLocal
    extends
        HederaGrpcRequestQuery<
          HederaContractCallLocalResponse,
          HederaContractCallLocalQuery
        > {
  HederaGrpcRequestContractCallLocal(super.query);
}

class HederaGrpcRequestContractGetInfo
    extends
        HederaGrpcRequestQuery<
          HederaContractGetInfoResponse,
          HederaContractGetInfoQuery
        > {
  HederaGrpcRequestContractGetInfo(super.query);
}

class HederaGrpcRequestContractGetBytecode
    extends
        HederaGrpcRequestQuery<
          HederaContractGetBytecodeResponse,
          HederaContractGetBytecodeQuery
        > {
  HederaGrpcRequestContractGetBytecode(super.query);
}

class HederaGrpcRequestContractGetRecords
    extends
        HederaGrpcRequestQuery<
          HederaContractGetRecordsResponse,
          HederaContractGetRecordsQuery
        > {
  HederaGrpcRequestContractGetRecords(super.query);
}

class HederaGrpcRequestCryptogetAccountBalance
    extends
        HederaGrpcRequestQuery<
          HederaCryptoGetAccountBalanceResponse,
          HederaCryptoGetAccountBalanceQuery
        > {
  HederaGrpcRequestCryptogetAccountBalance(super.query);
}

class HederaGrpcRequestCryptoGetAccountRecords
    extends
        HederaGrpcRequestQuery<
          HederaCryptoGetAccountRecordsResponse,
          HederaCryptoGetAccountRecordsQuery
        > {
  HederaGrpcRequestCryptoGetAccountRecords(super.query);
}

class HederaGrpcRequestCryptoGetInfo
    extends
        HederaGrpcRequestQuery<
          HederaCryptoGetInfoResponse,
          HederaCryptoGetInfoQuery
        > {
  HederaGrpcRequestCryptoGetInfo(super.query);
}

class HederaGrpcRequestCryptoGetLiveHash
    extends
        HederaGrpcRequestQuery<
          HederaCryptoGetLiveHashResponse,
          HederaCryptoGetLiveHashQuery
        > {
  HederaGrpcRequestCryptoGetLiveHash(super.query);
}

class HederaGrpcRequestFileGetContents
    extends
        HederaGrpcRequestQuery<
          HederaFileGetContentsResponse,
          HederaFileGetContentsQuery
        > {
  HederaGrpcRequestFileGetContents(super.query);
}

class HederaGrpcRequestFileGetInfo
    extends
        HederaGrpcRequestQuery<
          HederaFileGetInfoResponse,
          HederaFileGetInfoQuery
        > {
  HederaGrpcRequestFileGetInfo(super.query);
}

class HederaGrpcRequestTransactionGetReceipt
    extends
        HederaGrpcRequestQuery<
          HederaTransactionGetReceiptResponse,
          HederaTransactionGetReceiptQuery
        > {
  HederaGrpcRequestTransactionGetReceipt(super.query);
}

class HederaGrpcRequestTransactionGetRecord
    extends
        HederaGrpcRequestQuery<
          HederaTransactionGetRecordResponse,
          HederaTransactionGetRecordQuery
        > {
  HederaGrpcRequestTransactionGetRecord(super.query);
}

class HederaGrpcRequestConsensusGetTopicInfo
    extends
        HederaGrpcRequestQuery<
          HederaConsensusGetTopicInfoResponse,
          HederaConsensusGetTopicInfoQuery
        > {
  HederaGrpcRequestConsensusGetTopicInfo(super.query);
}

class HederaGrpcRequestNetworkGetVersionInfo
    extends
        HederaGrpcRequestQuery<
          HederaNetworkGetVersionInfoResponse,
          HederaNetworkGetVersionInfoQuery
        > {
  HederaGrpcRequestNetworkGetVersionInfo(super.query);
}

class HederaGrpcRequestTokenGetInfo
    extends
        HederaGrpcRequestQuery<
          HederaTokenGetInfoResponse,
          HederaTokenGetInfoQuery
        > {
  HederaGrpcRequestTokenGetInfo(super.query);
}

class HederaGrpcRequestScheduleGetInfo
    extends
        HederaGrpcRequestQuery<
          HederaScheduleGetInfoResponse,
          HederaScheduleGetInfoQuery
        > {
  HederaGrpcRequestScheduleGetInfo(super.query);
}

class HederaGrpcRequestTokenGetAccountNftInfos
    extends
        HederaGrpcRequestQuery<
          HederaTokenGetAccountNftInfosResponse,
          HederaTokenGetAccountNftInfosQuery
        > {
  HederaGrpcRequestTokenGetAccountNftInfos(super.query);
}

class HederaGrpcRequestTokenGetNftInfo
    extends
        HederaGrpcRequestQuery<
          HederaTokenGetNftInfoResponse,
          HederaTokenGetNftInfoQuery
        > {
  HederaGrpcRequestTokenGetNftInfo(super.query);
}

class HederaGrpcRequestNetworkGetExecutionTime
    extends
        HederaGrpcRequestQuery<
          HederaNetworkGetExecutionTimeResponse,
          HederaNetworkGetExecutionTimeQuery
        > {
  HederaGrpcRequestNetworkGetExecutionTime(super.query);
}

class HederaGrpcRequestAccountDetails
    extends
        HederaGrpcRequestQuery<
          HederaGetAccountDetailsResponse,
          HederaGetAccountDetailsQuery
        > {
  HederaGrpcRequestAccountDetails(super.query);
}
