// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/icp/src/service/service.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import 'types.dart';
import '../../utils/utils.dart';

/// Query messages for service `NnsInternetIdentity`.
abstract class NnsInternetIdentityQueryMessage<RESULT>
    extends IICPQueryMessage<RESULT> {
  const NnsInternetIdentityQueryMessage();
}

class NnsInternetIdentityQueryLookup
    extends
        NnsInternetIdentityQueryMessage<List<NnsInternetIdentityDeviceData>> {
  final NnsInternetIdentityUserNumber args;
  const NnsInternetIdentityQueryLookup(this.args);

  @override
  String get methodName => 'lookup';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(CType.nat64, args);
  }

  @override
  List<NnsInternetIdentityDeviceData> onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      CType.vec(NnsInternetIdentityDeviceData.ctype),
    );
    return JsonParser.valueEnsureAsList<Map<String, dynamic>>(
      decode,
    ).map((e) => NnsInternetIdentityDeviceData.fromCandid(e)).toList();
  }
}

class NnsInternetIdentityQueryGetAnchorCredentials
    extends
        NnsInternetIdentityQueryMessage<NnsInternetIdentityAnchorCredentials> {
  final NnsInternetIdentityUserNumber args;
  const NnsInternetIdentityQueryGetAnchorCredentials(this.args);

  @override
  String get methodName => 'get_anchor_credentials';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(CType.nat64, args);
  }

  @override
  NnsInternetIdentityAnchorCredentials onResponse(List<int> bytes) {
    return NnsInternetIdentityAnchorCredentials.fromBytes(bytes);
  }
}

class NnsInternetIdentityQueryGetPrincipal
    extends NnsInternetIdentityQueryMessage<IcpPrincipalAddress> {
  final NnsInternetIdentityUserNumber arg0;
  final NnsInternetIdentityFrontendHostname arg1;
  const NnsInternetIdentityQueryGetPrincipal({
    required this.arg0,
    required this.arg1,
  });

  @override
  String get methodName => 'get_principal';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode([CType.nat64, CType.text], [arg0, arg1]);
  }

  @override
  IcpPrincipalAddress onResponse(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, CType.principal);
    return GeneratorParserUtils.principalFromCandid(raw);
  }
}

class NnsInternetIdentityQueryIdentityAuthnInfo
    extends
        NnsInternetIdentityQueryMessage<
          NnsInternetIdentityIdentityAuthnInfoResponse
        > {
  final NnsInternetIdentityIdentityNumber args;
  const NnsInternetIdentityQueryIdentityAuthnInfo(this.args);

  @override
  String get methodName => 'identity_authn_info';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(CType.nat64, args);
  }

  @override
  NnsInternetIdentityIdentityAuthnInfoResponse onResponse(List<int> bytes) {
    return NnsInternetIdentityIdentityAuthnInfoResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityQueryAuthnMethodSessionInfo
    extends
        NnsInternetIdentityQueryMessage<
          NnsInternetIdentityAuthnMethodSessionInfo?
        > {
  final NnsInternetIdentityIdentityNumber args;
  const NnsInternetIdentityQueryAuthnMethodSessionInfo(this.args);

  @override
  String get methodName => 'authn_method_session_info';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(CType.nat64, args);
  }

  @override
  NnsInternetIdentityAuthnMethodSessionInfo? onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      CType.opt(NnsInternetIdentityAuthnMethodSessionInfo.ctype),
    );
    if (decode == null) return null;
    return NnsInternetIdentityAuthnMethodSessionInfo.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(decode),
    );
  }
}

class NnsInternetIdentityQueryLookupByRegistrationModeId
    extends
        NnsInternetIdentityQueryMessage<NnsInternetIdentityIdentityNumber?> {
  final NnsInternetIdentityRegistrationId args;
  const NnsInternetIdentityQueryLookupByRegistrationModeId(this.args);

  @override
  String get methodName => 'lookup_by_registration_mode_id';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(CType.text, args);
  }

  @override
  NnsInternetIdentityIdentityNumber? onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.opt(CType.nat64))
        as NnsInternetIdentityIdentityNumber?;
  }
}

class NnsInternetIdentityQueryGetDelegation
    extends
        NnsInternetIdentityQueryMessage<
          NnsInternetIdentityGetDelegationResponse
        > {
  final NnsInternetIdentityUserNumber arg0;
  final NnsInternetIdentityFrontendHostname arg1;
  final NnsInternetIdentitySessionKey arg2;
  final NnsInternetIdentityTimestamp arg3;
  const NnsInternetIdentityQueryGetDelegation({
    required this.arg0,
    required this.arg1,
    required this.arg2,
    required this.arg3,
  });

  @override
  String get methodName => 'get_delegation';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [CType.nat64, CType.text, CType.vec(CType.nat8), CType.nat64],
      [arg0, arg1, arg2, arg3],
    );
  }

  @override
  NnsInternetIdentityGetDelegationResponse onResponse(List<int> bytes) {
    return NnsInternetIdentityGetDelegationResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityQueryGetAttributes
    extends
        NnsInternetIdentityQueryMessage<
          NnsInternetIdentityGetAttributesResponse
        > {
  final NnsInternetIdentityGetAttributesRequest args;
  const NnsInternetIdentityQueryGetAttributes(this.args);

  @override
  String get methodName => 'get_attributes';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsInternetIdentityGetAttributesResponse onResponse(List<int> bytes) {
    return NnsInternetIdentityGetAttributesResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityQueryGetIcrc3Attributes
    extends
        NnsInternetIdentityQueryMessage<
          NnsInternetIdentityGetIcrc3AttributesResponse
        > {
  final NnsInternetIdentityGetIcrc3AttributeRequest args;
  const NnsInternetIdentityQueryGetIcrc3Attributes(this.args);

  @override
  String get methodName => 'get_icrc3_attributes';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsInternetIdentityGetIcrc3AttributesResponse onResponse(List<int> bytes) {
    return NnsInternetIdentityGetIcrc3AttributesResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityQueryListAvailableAttributes
    extends
        NnsInternetIdentityQueryMessage<
          NnsInternetIdentityListAvailableAttributesResponse2
        > {
  final NnsInternetIdentityListAvailableAttributesRequest args;
  const NnsInternetIdentityQueryListAvailableAttributes(this.args);

  @override
  String get methodName => 'list_available_attributes';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsInternetIdentityListAvailableAttributesResponse2 onResponse(
    List<int> bytes,
  ) {
    return NnsInternetIdentityListAvailableAttributesResponse2.fromBytes(bytes);
  }
}

class NnsInternetIdentityQueryGetIdAlias
    extends
        NnsInternetIdentityQueryMessage<NnsInternetIdentityGetIdAliasResponse> {
  final NnsInternetIdentityGetIdAliasRequest args;
  const NnsInternetIdentityQueryGetIdAlias(this.args);

  @override
  String get methodName => 'get_id_alias';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsInternetIdentityGetIdAliasResponse onResponse(List<int> bytes) {
    return NnsInternetIdentityGetIdAliasResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityQueryOpenidGetDelegation
    extends
        NnsInternetIdentityQueryMessage<
          NnsInternetIdentityOpenidGetDelegationResponse
        > {
  final NnsInternetIdentityJWT arg0;
  final NnsInternetIdentitySalt arg1;
  final NnsInternetIdentitySessionKey arg2;
  final NnsInternetIdentityTimestamp arg3;
  final String? arg4;
  const NnsInternetIdentityQueryOpenidGetDelegation({
    required this.arg0,
    required this.arg1,
    required this.arg2,
    required this.arg3,
    required this.arg4,
  });

  @override
  String get methodName => 'openid_get_delegation';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [
        CType.text,
        CType.vec(CType.nat8),
        CType.vec(CType.nat8),
        CType.nat64,
        CType.opt(CType.text),
      ],
      [arg0, arg1, arg2, arg3, arg4],
    );
  }

  @override
  NnsInternetIdentityOpenidGetDelegationResponse onResponse(List<int> bytes) {
    return NnsInternetIdentityOpenidGetDelegationResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityQueryGetSsoDiscoveryStatus
    extends
        NnsInternetIdentityQueryMessage<NnsInternetIdentitySsoDiscoveryStatus> {
  final NnsInternetIdentityGetSsoDiscoveryStatusRequest args;
  const NnsInternetIdentityQueryGetSsoDiscoveryStatus(this.args);

  @override
  String get methodName => 'get_sso_discovery_status';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsInternetIdentitySsoDiscoveryStatus onResponse(List<int> bytes) {
    return NnsInternetIdentitySsoDiscoveryStatus.fromBytes(bytes);
  }
}

class NnsInternetIdentityQuerySsoGetDelegation
    extends
        NnsInternetIdentityQueryMessage<
          NnsInternetIdentitySsoGetDelegationResponse2
        > {
  final NnsInternetIdentitySsoGetDelegationRequest args;
  const NnsInternetIdentityQuerySsoGetDelegation(this.args);

  @override
  String get methodName => 'sso_get_delegation';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsInternetIdentitySsoGetDelegationResponse2 onResponse(List<int> bytes) {
    return NnsInternetIdentitySsoGetDelegationResponse2.fromBytes(bytes);
  }
}

class NnsInternetIdentityQuerySmtpRequestValidate
    extends NnsInternetIdentityQueryMessage<NnsInternetIdentitySmtpResponse> {
  final NnsInternetIdentitySmtpRequest args;
  const NnsInternetIdentityQuerySmtpRequestValidate(this.args);

  @override
  String get methodName => 'smtp_request_validate';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsInternetIdentitySmtpResponse onResponse(List<int> bytes) {
    return NnsInternetIdentitySmtpResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityQueryEmailChallengeStatus
    extends
        NnsInternetIdentityQueryMessage<
          NnsInternetIdentityEmailChallengeStatus
        > {
  final String args;
  const NnsInternetIdentityQueryEmailChallengeStatus(this.args);

  @override
  String get methodName => 'email_challenge_status';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(CType.text, args);
  }

  @override
  NnsInternetIdentityEmailChallengeStatus onResponse(List<int> bytes) {
    return NnsInternetIdentityEmailChallengeStatus.fromBytes(bytes);
  }
}

class NnsInternetIdentityQueryEmailChallengeDiagnostics
    extends
        NnsInternetIdentityQueryMessage<
          NnsInternetIdentityEmailChallengeDiagnostics?
        > {
  final String args;
  const NnsInternetIdentityQueryEmailChallengeDiagnostics(this.args);

  @override
  String get methodName => 'email_challenge_diagnostics';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(CType.text, args);
  }

  @override
  NnsInternetIdentityEmailChallengeDiagnostics? onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      CType.opt(NnsInternetIdentityEmailChallengeDiagnostics.ctype),
    );
    if (decode == null) return null;
    return NnsInternetIdentityEmailChallengeDiagnostics.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(decode),
    );
  }
}

class NnsInternetIdentityQueryEmailRecoveryGetDelegation
    extends
        NnsInternetIdentityQueryMessage<
          NnsInternetIdentityEmailRecoveryGetDelegationResponse
        > {
  final NnsInternetIdentityEmailRecoveryGetDelegationArgs args;
  const NnsInternetIdentityQueryEmailRecoveryGetDelegation(this.args);

  @override
  String get methodName => 'email_recovery_get_delegation';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsInternetIdentityEmailRecoveryGetDelegationResponse onResponse(
    List<int> bytes,
  ) {
    return NnsInternetIdentityEmailRecoveryGetDelegationResponse.fromBytes(
      bytes,
    );
  }
}

class NnsInternetIdentityQueryEmailRecoveryStatus
    extends
        NnsInternetIdentityQueryMessage<
          NnsInternetIdentityEmailChallengeStatus
        > {
  final String args;
  const NnsInternetIdentityQueryEmailRecoveryStatus(this.args);

  @override
  String get methodName => 'email_recovery_status';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(CType.text, args);
  }

  @override
  NnsInternetIdentityEmailChallengeStatus onResponse(List<int> bytes) {
    return NnsInternetIdentityEmailChallengeStatus.fromBytes(bytes);
  }
}

class NnsInternetIdentityQueryEmailRecoveryDiagnostics
    extends
        NnsInternetIdentityQueryMessage<
          NnsInternetIdentityEmailChallengeDiagnostics?
        > {
  final String args;
  const NnsInternetIdentityQueryEmailRecoveryDiagnostics(this.args);

  @override
  String get methodName => 'email_recovery_diagnostics';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(CType.text, args);
  }

  @override
  NnsInternetIdentityEmailChallengeDiagnostics? onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      CType.opt(NnsInternetIdentityEmailChallengeDiagnostics.ctype),
    );
    if (decode == null) return null;
    return NnsInternetIdentityEmailChallengeDiagnostics.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(decode),
    );
  }
}

class NnsInternetIdentityQueryHttpRequest
    extends NnsInternetIdentityQueryMessage<NnsInternetIdentityHttpResponse> {
  final NnsInternetIdentityHttpRequest args;
  const NnsInternetIdentityQueryHttpRequest(this.args);

  @override
  String get methodName => 'http_request';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsInternetIdentityHttpResponse onResponse(List<int> bytes) {
    return NnsInternetIdentityHttpResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityQueryStats
    extends
        NnsInternetIdentityQueryMessage<
          NnsInternetIdentityInternetIdentityStats
        > {
  const NnsInternetIdentityQueryStats();

  @override
  String get methodName => 'stats';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  NnsInternetIdentityInternetIdentityStats onResponse(List<int> bytes) {
    return NnsInternetIdentityInternetIdentityStats.fromBytes(bytes);
  }
}

class NnsInternetIdentityQueryConfig
    extends
        NnsInternetIdentityQueryMessage<
          NnsInternetIdentityInternetIdentityInit
        > {
  const NnsInternetIdentityQueryConfig();

  @override
  String get methodName => 'config';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  NnsInternetIdentityInternetIdentityInit onResponse(List<int> bytes) {
    return NnsInternetIdentityInternetIdentityInit.fromBytes(bytes);
  }
}

class NnsInternetIdentityQueryWhoami
    extends NnsInternetIdentityQueryMessage<IcpPrincipalAddress> {
  const NnsInternetIdentityQueryWhoami();

  @override
  String get methodName => 'whoami';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  IcpPrincipalAddress onResponse(List<int> bytes) {
    final raw = CandidUtils.decodeOneTyped(bytes, CType.principal);
    return GeneratorParserUtils.principalFromCandid(raw);
  }
}

class NnsInternetIdentityQueryLookupDeviceKey
    extends
        NnsInternetIdentityQueryMessage<
          NnsInternetIdentityDeviceKeyWithAnchor?
        > {
  final List<int> args;
  const NnsInternetIdentityQueryLookupDeviceKey(this.args);

  @override
  String get methodName => 'lookup_device_key';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(CType.vec(CType.nat8), args);
  }

  @override
  NnsInternetIdentityDeviceKeyWithAnchor? onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      CType.opt(NnsInternetIdentityDeviceKeyWithAnchor.ctype),
    );
    if (decode == null) return null;
    return NnsInternetIdentityDeviceKeyWithAnchor.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(decode),
    );
  }
}

class NnsInternetIdentityQueryGetAccounts
    extends
        NnsInternetIdentityQueryMessage<
          NnsInternetIdentityGetAccountsResponse
        > {
  final NnsInternetIdentityUserNumber arg0;
  final NnsInternetIdentityFrontendHostname arg1;
  const NnsInternetIdentityQueryGetAccounts({
    required this.arg0,
    required this.arg1,
  });

  @override
  String get methodName => 'get_accounts';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode([CType.nat64, CType.text], [arg0, arg1]);
  }

  @override
  NnsInternetIdentityGetAccountsResponse onResponse(List<int> bytes) {
    return NnsInternetIdentityGetAccountsResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityQueryGetAccountDelegation
    extends
        NnsInternetIdentityQueryMessage<
          NnsInternetIdentityGetAccountDelegationResponse
        > {
  final NnsInternetIdentityUserNumber arg0;
  final NnsInternetIdentityFrontendHostname arg1;
  final NnsInternetIdentityAccountNumber? arg2;
  final NnsInternetIdentitySessionKey arg3;
  final NnsInternetIdentityTimestamp arg4;
  final NnsInternetIdentityPermissions? arg5;
  const NnsInternetIdentityQueryGetAccountDelegation({
    required this.arg0,
    required this.arg1,
    required this.arg2,
    required this.arg3,
    required this.arg4,
    required this.arg5,
  });

  @override
  String get methodName => 'get_account_delegation';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [
        CType.nat64,
        CType.text,
        CType.opt(CType.nat64),
        CType.vec(CType.nat8),
        CType.nat64,
        CType.opt(NnsInternetIdentityPermissions.ctype),
      ],
      [arg0, arg1, arg2, arg3, arg4, arg5],
    );
  }

  @override
  NnsInternetIdentityGetAccountDelegationResponse onResponse(List<int> bytes) {
    return NnsInternetIdentityGetAccountDelegationResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityQueryMcpGetConfig
    extends NnsInternetIdentityQueryMessage<NnsInternetIdentityMcpConfig?> {
  final NnsInternetIdentityUserNumber args;
  const NnsInternetIdentityQueryMcpGetConfig(this.args);

  @override
  String get methodName => 'mcp_get_config';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(CType.nat64, args);
  }

  @override
  NnsInternetIdentityMcpConfig? onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      CType.opt(NnsInternetIdentityMcpConfig.ctype),
    );
    if (decode == null) return null;
    return NnsInternetIdentityMcpConfig.fromCandid(
      JsonParser.valueEnsureAsMap<String, dynamic>(decode),
    );
  }
}

class NnsInternetIdentityQueryMcpGetDelegation
    extends
        NnsInternetIdentityQueryMessage<
          NnsInternetIdentityGetAccountDelegationResponse
        > {
  final NnsInternetIdentityFrontendHostname arg0;
  final NnsInternetIdentityAccountNumber? arg1;
  final NnsInternetIdentitySessionKey arg2;
  final NnsInternetIdentityTimestamp arg3;
  const NnsInternetIdentityQueryMcpGetDelegation({
    required this.arg0,
    required this.arg1,
    required this.arg2,
    required this.arg3,
  });

  @override
  String get methodName => 'mcp_get_delegation';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [CType.text, CType.opt(CType.nat64), CType.vec(CType.nat8), CType.nat64],
      [arg0, arg1, arg2, arg3],
    );
  }

  @override
  NnsInternetIdentityGetAccountDelegationResponse onResponse(List<int> bytes) {
    return NnsInternetIdentityGetAccountDelegationResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityQueryMcpGetAccounts
    extends
        NnsInternetIdentityQueryMessage<
          NnsInternetIdentityMcpGetAccountsResponse
        > {
  final NnsInternetIdentityFrontendHostname args;
  const NnsInternetIdentityQueryMcpGetAccounts(this.args);

  @override
  String get methodName => 'mcp_get_accounts';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(CType.text, args);
  }

  @override
  NnsInternetIdentityMcpGetAccountsResponse onResponse(List<int> bytes) {
    return NnsInternetIdentityMcpGetAccountsResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityQueryGetSessionDelegation
    extends
        NnsInternetIdentityQueryMessage<
          NnsInternetIdentityGetSessionDelegationResponse
        > {
  final NnsInternetIdentityUserNumber arg0;
  final NnsInternetIdentitySessionKey arg1;
  final NnsInternetIdentityTimestamp arg2;
  const NnsInternetIdentityQueryGetSessionDelegation({
    required this.arg0,
    required this.arg1,
    required this.arg2,
  });

  @override
  String get methodName => 'get_session_delegation';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [CType.nat64, CType.vec(CType.nat8), CType.nat64],
      [arg0, arg1, arg2],
    );
  }

  @override
  NnsInternetIdentityGetSessionDelegationResponse onResponse(List<int> bytes) {
    return NnsInternetIdentityGetSessionDelegationResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityQueryGetMcpRegistrationDelegation
    extends
        NnsInternetIdentityQueryMessage<
          NnsInternetIdentityGetMcpRegistrationDelegationResponse
        > {
  final NnsInternetIdentityUserNumber arg0;
  final NnsInternetIdentitySessionKey arg1;
  final NnsInternetIdentityPublicKey arg2;
  final NnsInternetIdentityTimestamp arg3;
  const NnsInternetIdentityQueryGetMcpRegistrationDelegation({
    required this.arg0,
    required this.arg1,
    required this.arg2,
    required this.arg3,
  });

  @override
  String get methodName => 'get_mcp_registration_delegation';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [CType.nat64, CType.vec(CType.nat8), CType.vec(CType.nat8), CType.nat64],
      [arg0, arg1, arg2, arg3],
    );
  }

  @override
  NnsInternetIdentityGetMcpRegistrationDelegationResponse onResponse(
    List<int> bytes,
  ) {
    return NnsInternetIdentityGetMcpRegistrationDelegationResponse.fromBytes(
      bytes,
    );
  }
}

class NnsInternetIdentityQueryGetDefaultAccount
    extends
        NnsInternetIdentityQueryMessage<
          NnsInternetIdentityGetDefaultAccountResponse
        > {
  final NnsInternetIdentityUserNumber arg0;
  final NnsInternetIdentityFrontendHostname arg1;
  const NnsInternetIdentityQueryGetDefaultAccount({
    required this.arg0,
    required this.arg1,
  });

  @override
  String get methodName => 'get_default_account';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode([CType.nat64, CType.text], [arg0, arg1]);
  }

  @override
  NnsInternetIdentityGetDefaultAccountResponse onResponse(List<int> bytes) {
    return NnsInternetIdentityGetDefaultAccountResponse.fromBytes(bytes);
  }
}
