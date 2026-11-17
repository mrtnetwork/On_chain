import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/did/icrc1/icrc1.dart';
import 'package:on_chain/icp/src/did/icrc2/icrc2.dart';
import 'package:on_chain/icp/src/did/icrc3/icrc3.dart';
import 'package:on_chain/icp/src/did/icrc7/icrc7.dart';
import 'package:on_chain/icp/src/did/ledger/ledger.dart';
import 'package:on_chain/icp/src/rpc/types/params.dart';
import 'package:on_chain/icp/src/service/client/types/types.dart';
import 'package:on_chain/icp/src/service/core/service.dart';

mixin ICPQuickQueryApi {
  Future<RESULT> query<RESULT>({
    required IICPQueryMessage<RESULT> message,
    required IcpPrincipalAddress canisterId,
    ICPRequestQueryParams? params,
  });
  ICPNetworkConfig get networkConfig;

  Future<BigInt> getLedgerAccountBalance(
    BaseIcpAddress account, {
    IcpPrincipalAddress? canisterId,
    ICPRequestQueryParams? params,
  }) async {
    final result = await query(
      message: LEDGERQueryAccountBalance(
        LEDGERAccountBalanceArgs(
          account: account.toAccountIdentifier().toBytes(),
        ),
      ),
      canisterId: canisterId ?? networkConfig.ledgerCanisterId,
      params: params,
    );
    return result.e8s;
  }

  Future<String> getIcrc1Name({
    IcpPrincipalAddress? canisterId,
    ICPRequestQueryParams? params,
  }) async {
    return query(
      message: ICRC1QueryIcrc1Name(),
      canisterId: canisterId ?? networkConfig.ledgerCanisterId,
      params: params,
    );
  }

  Future<String> getIcrc1Symbol({
    IcpPrincipalAddress? canisterId,
    ICPRequestQueryParams? params,
  }) async {
    return query(
      message: ICRC1QueryIcrc1Symbol(),
      canisterId: canisterId ?? networkConfig.ledgerCanisterId,
      params: params,
    );
  }

  Future<int> getIcrc1Decimals({
    IcpPrincipalAddress? canisterId,
    ICPRequestQueryParams? params,
  }) async {
    return query(
      message: ICRC1QueryIcrc1Decimals(),
      canisterId: canisterId ?? networkConfig.ledgerCanisterId,
      params: params,
    );
  }

  Future<List<ICRC1Icrc1MetadataResponse>> getIcrc1Metadata({
    IcpPrincipalAddress? canisterId,
    ICPRequestQueryParams? params,
  }) async {
    return query(
      message: ICRC1QueryIcrc1Metadata(),
      canisterId: canisterId ?? networkConfig.ledgerCanisterId,
      params: params,
    );
  }

  Future<BigInt> getIcrc1TotalSupply({
    IcpPrincipalAddress? canisterId,
    ICPRequestQueryParams? params,
  }) async {
    return query(
      message: ICRC1QueryIcrc1TotalSupply(),
      canisterId: canisterId ?? networkConfig.ledgerCanisterId,
      params: params,
    );
  }

  Future<BigInt> getLedgerTransferFee({
    IcpPrincipalAddress? canisterId,
    ICPRequestQueryParams? params,
  }) async {
    final result = await query(
      message: LEDGERQueryTransferFee(const LEDGERTransferFeeArg()),
      canisterId: canisterId ?? networkConfig.ledgerCanisterId,
      params: params,
    );
    return result.transferFee.e8s;
  }

  Future<BigInt> getIcrc1LedgerIcrc1Fee({
    IcpPrincipalAddress? canisterId,
    ICPRequestQueryParams? params,
  }) async {
    return query(
      message: ICRC1QueryIcrc1Fee(),
      canisterId: canisterId ?? networkConfig.ledgerCanisterId,
      params: params,
    );
  }

  Future<ICRC2Icrc2AllowanceResponse> getIcrc2Allowance(
    IcpPrincipalAddressWithSubId account,
    IcpPrincipalAddressWithSubId spender, {
    IcpPrincipalAddress? canisterId,
    ICPRequestQueryParams? params,
  }) async {
    return query(
      message: ICRC2QueryIcrc2Allowance(
        ICRC2AllowanceArgs(
          account: ICRC2Account(
            owner: account.address,
            subaccount: account.subaccountId,
          ),
          spender: ICRC2Account(
            owner: spender.address,
            subaccount: spender.subaccountId,
          ),
        ),
      ),
      canisterId: canisterId ?? networkConfig.ledgerCanisterId,
      params: params,
    );
  }

  Future<BigInt> getIcrc1LedgerIcrc1BalanceOf(
    IcpPrincipalAddressWithSubId address, {
    IcpPrincipalAddress? canisterId,
    ICPRequestQueryParams? params,
  }) async {
    return query(
      message: ICRC1QueryIcrc1BalanceOf(
        ICRC1Account(owner: address.address, subaccount: address.subaccountId),
      ),
      canisterId: canisterId ?? networkConfig.ledgerCanisterId,
      params: params,
    );
  }

  Future<List<ICRC2Icrc1SupportedStandardsResponse>> getIcrc1SupportedStandards(
    IcpPrincipalAddressWithSubId account,
    IcpPrincipalAddressWithSubId spender, {
    IcpPrincipalAddress? canisterId,
    ICPRequestQueryParams? params,
  }) async {
    return query(
      message: ICRC2QueryIcrc1SupportedStandards(),
      canisterId: canisterId ?? networkConfig.ledgerCanisterId,
      params: params,
    );
  }

  Future<ICRC3GetBlocksResult> getIcrc3GetBlocks(
    ICRC3GetBlocksArgs args, {
    IcpPrincipalAddress? canisterId,
    ICPRequestQueryParams? params,
  }) async {
    return query(
      message: ICRC3QueryIcrc3GetBlocks(args),
      canisterId: canisterId ?? networkConfig.ledgerCanisterId,
      params: params,
    );
  }

  Future<List<ICRC7ValueMap>> getIcrc7CollectionMetadata(
    IcpPrincipalAddress canisterId, {
    ICPRequestQueryParams? params,
  }) async {
    return query(
      message: ICRC7QueryIcrc7CollectionMetadata(),
      canisterId: canisterId,
      params: params,
    );
  }

  Future<String> getIcrc7Symbol(
    IcpPrincipalAddress canisterId, {
    ICPRequestQueryParams? params,
  }) async {
    return query(
      message: ICRC7QueryIcrc7Symbol(),
      canisterId: canisterId,
      params: params,
    );
  }

  Future<String> getIcrc7Name(
    IcpPrincipalAddress canisterId, {
    ICPRequestQueryParams? params,
  }) async {
    return query(
      message: ICRC7QueryIcrc7Name(),
      canisterId: canisterId,
      params: params,
    );
  }

  Future<String?> getIcrc7Description(
    IcpPrincipalAddress canisterId, {
    ICPRequestQueryParams? params,
  }) async {
    return query(
      message: ICRC7QueryIcrc7Description(),
      canisterId: canisterId,
      params: params,
    );
  }

  Future<String?> getIcrc7Logo(
    IcpPrincipalAddress canisterId, {
    ICPRequestQueryParams? params,
  }) async {
    return query(
      message: ICRC7QueryIcrc7Logo(),
      canisterId: canisterId,
      params: params,
    );
  }

  Future<BigInt> getIcrc7TotalSupply(
    IcpPrincipalAddress canisterId, {
    ICPRequestQueryParams? params,
  }) async {
    return query(
      message: ICRC7QueryIcrc7TotalSupply(),
      canisterId: canisterId,
      params: params,
    );
  }

  Future<List<ICRC7Account?>> getIcrc7OwnerOf({
    required IcpPrincipalAddress canisterId,
    required List<BigInt> ids,
    ICPRequestQueryParams? params,
  }) async {
    return query(
      message: ICRC7QueryIcrc7OwnerOf(ids),
      canisterId: canisterId,
      params: params,
    );
  }

  Future<List<BigInt>> getIcrc7BalanceOf({
    required IcpPrincipalAddress canisterId,
    required List<IcpPrincipalAddressWithSubId> accounts,
    ICPRequestQueryParams? params,
  }) async {
    return query(
      message: ICRC7QueryIcrc7BalanceOf(
        accounts
            .map(
              (e) => ICRC7Account(owner: e.address, subaccount: e.subaccountId),
            )
            .toList(),
      ),
      canisterId: canisterId,
      params: params,
    );
  }
}
