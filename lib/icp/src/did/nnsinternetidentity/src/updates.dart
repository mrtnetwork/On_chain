// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/icp/src/service/service.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import 'types.dart';

/// Update messages for service `NnsInternetIdentity`.
abstract class NnsInternetIdentityUpdateMessage<RESULT>
    extends IICPUpdateMessage<RESULT> {
  const NnsInternetIdentityUpdateMessage();
}

class NnsInternetIdentityUpdateCreateChallenge
    extends NnsInternetIdentityUpdateMessage<NnsInternetIdentityChallenge> {
  const NnsInternetIdentityUpdateCreateChallenge();

  @override
  String get methodName => 'create_challenge';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  NnsInternetIdentityChallenge onResponse(List<int> bytes) {
    return NnsInternetIdentityChallenge.fromBytes(bytes);
  }
}

class NnsInternetIdentityUpdateRegister
    extends
        NnsInternetIdentityUpdateMessage<NnsInternetIdentityRegisterResponse> {
  final NnsInternetIdentityDeviceData arg0;
  final NnsInternetIdentityChallengeResult arg1;
  final IcpPrincipalAddress? arg2;
  const NnsInternetIdentityUpdateRegister({
    required this.arg0,
    required this.arg1,
    required this.arg2,
  });

  @override
  String get methodName => 'register';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [
        NnsInternetIdentityDeviceData.ctype,
        NnsInternetIdentityChallengeResult.ctype,
        CType.opt(CType.principal),
      ],
      [arg0.candidValue, arg1.candidValue, arg2],
    );
  }

  @override
  NnsInternetIdentityRegisterResponse onResponse(List<int> bytes) {
    return NnsInternetIdentityRegisterResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityUpdateAdd
    extends NnsInternetIdentityUpdateMessage<Null> {
  final NnsInternetIdentityUserNumber arg0;
  final NnsInternetIdentityDeviceData arg1;
  const NnsInternetIdentityUpdateAdd({required this.arg0, required this.arg1});

  @override
  String get methodName => 'add';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [CType.nat64, NnsInternetIdentityDeviceData.ctype],
      [arg0, arg1.candidValue],
    );
  }

  @override
  Null onResponse(List<int> bytes) {
    // unit ()
    return null;
  }
}

class NnsInternetIdentityUpdateUpdate
    extends NnsInternetIdentityUpdateMessage<Null> {
  final NnsInternetIdentityUserNumber arg0;
  final NnsInternetIdentityDeviceKey arg1;
  final NnsInternetIdentityDeviceData arg2;
  const NnsInternetIdentityUpdateUpdate({
    required this.arg0,
    required this.arg1,
    required this.arg2,
  });

  @override
  String get methodName => 'update';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [CType.nat64, CType.vec(CType.nat8), NnsInternetIdentityDeviceData.ctype],
      [arg0, arg1, arg2.candidValue],
    );
  }

  @override
  Null onResponse(List<int> bytes) {
    // unit ()
    return null;
  }
}

class NnsInternetIdentityUpdateReplace
    extends NnsInternetIdentityUpdateMessage<Null> {
  final NnsInternetIdentityUserNumber arg0;
  final NnsInternetIdentityDeviceKey arg1;
  final NnsInternetIdentityDeviceData arg2;
  const NnsInternetIdentityUpdateReplace({
    required this.arg0,
    required this.arg1,
    required this.arg2,
  });

  @override
  String get methodName => 'replace';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [CType.nat64, CType.vec(CType.nat8), NnsInternetIdentityDeviceData.ctype],
      [arg0, arg1, arg2.candidValue],
    );
  }

  @override
  Null onResponse(List<int> bytes) {
    // unit ()
    return null;
  }
}

class NnsInternetIdentityUpdateRemove
    extends NnsInternetIdentityUpdateMessage<Null> {
  final NnsInternetIdentityUserNumber arg0;
  final NnsInternetIdentityDeviceKey arg1;
  const NnsInternetIdentityUpdateRemove({
    required this.arg0,
    required this.arg1,
  });

  @override
  String get methodName => 'remove';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [CType.nat64, CType.vec(CType.nat8)],
      [arg0, arg1],
    );
  }

  @override
  Null onResponse(List<int> bytes) {
    // unit ()
    return null;
  }
}

class NnsInternetIdentityUpdateGetAnchorInfo
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityIdentityAnchorInfo
        > {
  final NnsInternetIdentityUserNumber args;
  const NnsInternetIdentityUpdateGetAnchorInfo(this.args);

  @override
  String get methodName => 'get_anchor_info';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(CType.nat64, args);
  }

  @override
  NnsInternetIdentityIdentityAnchorInfo onResponse(List<int> bytes) {
    return NnsInternetIdentityIdentityAnchorInfo.fromBytes(bytes);
  }
}

class NnsInternetIdentityUpdateEnterDeviceRegistrationMode
    extends NnsInternetIdentityUpdateMessage<NnsInternetIdentityTimestamp> {
  final NnsInternetIdentityUserNumber args;
  const NnsInternetIdentityUpdateEnterDeviceRegistrationMode(this.args);

  @override
  String get methodName => 'enter_device_registration_mode';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(CType.nat64, args);
  }

  @override
  NnsInternetIdentityTimestamp onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.nat64)
        as NnsInternetIdentityTimestamp;
  }
}

class NnsInternetIdentityUpdateExitDeviceRegistrationMode
    extends NnsInternetIdentityUpdateMessage<Null> {
  final NnsInternetIdentityUserNumber args;
  const NnsInternetIdentityUpdateExitDeviceRegistrationMode(this.args);

  @override
  String get methodName => 'exit_device_registration_mode';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(CType.nat64, args);
  }

  @override
  Null onResponse(List<int> bytes) {
    // unit ()
    return null;
  }
}

class NnsInternetIdentityUpdateAddTentativeDevice
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityAddTentativeDeviceResponse
        > {
  final NnsInternetIdentityUserNumber arg0;
  final NnsInternetIdentityDeviceData arg1;
  const NnsInternetIdentityUpdateAddTentativeDevice({
    required this.arg0,
    required this.arg1,
  });

  @override
  String get methodName => 'add_tentative_device';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [CType.nat64, NnsInternetIdentityDeviceData.ctype],
      [arg0, arg1.candidValue],
    );
  }

  @override
  NnsInternetIdentityAddTentativeDeviceResponse onResponse(List<int> bytes) {
    return NnsInternetIdentityAddTentativeDeviceResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityUpdateVerifyTentativeDevice
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityVerifyTentativeDeviceResponse
        > {
  final NnsInternetIdentityUserNumber arg0;
  final String arg1;
  const NnsInternetIdentityUpdateVerifyTentativeDevice({
    required this.arg0,
    required this.arg1,
  });

  @override
  String get methodName => 'verify_tentative_device';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode([CType.nat64, CType.text], [arg0, arg1]);
  }

  @override
  NnsInternetIdentityVerifyTentativeDeviceResponse onResponse(List<int> bytes) {
    return NnsInternetIdentityVerifyTentativeDeviceResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityUpdateIdentityRegistrationStart
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityIdentityRegistrationStartResponse
        > {
  const NnsInternetIdentityUpdateIdentityRegistrationStart();

  @override
  String get methodName => 'identity_registration_start';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  NnsInternetIdentityIdentityRegistrationStartResponse onResponse(
    List<int> bytes,
  ) {
    return NnsInternetIdentityIdentityRegistrationStartResponse.fromBytes(
      bytes,
    );
  }
}

class NnsInternetIdentityUpdateCheckCaptcha
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityCheckCaptchaResponse
        > {
  final NnsInternetIdentityCheckCaptchaArg args;
  const NnsInternetIdentityUpdateCheckCaptcha(this.args);

  @override
  String get methodName => 'check_captcha';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsInternetIdentityCheckCaptchaResponse onResponse(List<int> bytes) {
    return NnsInternetIdentityCheckCaptchaResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityUpdateIdentityRegistrationFinish
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityIdentityRegistrationFinishResponse
        > {
  final NnsInternetIdentityIdRegFinishArg args;
  const NnsInternetIdentityUpdateIdentityRegistrationFinish(this.args);

  @override
  String get methodName => 'identity_registration_finish';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsInternetIdentityIdentityRegistrationFinishResponse onResponse(
    List<int> bytes,
  ) {
    return NnsInternetIdentityIdentityRegistrationFinishResponse.fromBytes(
      bytes,
    );
  }
}

class NnsInternetIdentityUpdateIdentityInfo
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityIdentityInfoResponse
        > {
  final NnsInternetIdentityIdentityNumber args;
  const NnsInternetIdentityUpdateIdentityInfo(this.args);

  @override
  String get methodName => 'identity_info';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(CType.nat64, args);
  }

  @override
  NnsInternetIdentityIdentityInfoResponse onResponse(List<int> bytes) {
    return NnsInternetIdentityIdentityInfoResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityUpdateIdentityMetadataReplace
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityIdentityMetadataReplaceResponse
        > {
  final NnsInternetIdentityIdentityNumber arg0;
  final NnsInternetIdentityMetadataMapV2 arg1;
  const NnsInternetIdentityUpdateIdentityMetadataReplace({
    required this.arg0,
    required this.arg1,
  });

  @override
  String get methodName => 'identity_metadata_replace';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [CType.nat64, NnsInternetIdentityMetadataMapV2Candid.ctype],
      [arg0, arg1],
    );
  }

  @override
  NnsInternetIdentityIdentityMetadataReplaceResponse onResponse(
    List<int> bytes,
  ) {
    return NnsInternetIdentityIdentityMetadataReplaceResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityUpdateIdentityPropertiesReplace
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityIdentityPropertiesReplaceResponse
        > {
  final NnsInternetIdentityIdentityNumber arg0;
  final NnsInternetIdentityIdentityPropertiesReplace arg1;
  const NnsInternetIdentityUpdateIdentityPropertiesReplace({
    required this.arg0,
    required this.arg1,
  });

  @override
  String get methodName => 'identity_properties_replace';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [CType.nat64, NnsInternetIdentityIdentityPropertiesReplace.ctype],
      [arg0, arg1.candidValue],
    );
  }

  @override
  NnsInternetIdentityIdentityPropertiesReplaceResponse onResponse(
    List<int> bytes,
  ) {
    return NnsInternetIdentityIdentityPropertiesReplaceResponse.fromBytes(
      bytes,
    );
  }
}

class NnsInternetIdentityUpdateAuthnMethodAdd
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityAuthnMethodAddResponse
        > {
  final NnsInternetIdentityIdentityNumber arg0;
  final NnsInternetIdentityAuthnMethodData arg1;
  const NnsInternetIdentityUpdateAuthnMethodAdd({
    required this.arg0,
    required this.arg1,
  });

  @override
  String get methodName => 'authn_method_add';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [CType.nat64, NnsInternetIdentityAuthnMethodData.ctype],
      [arg0, arg1.candidValue],
    );
  }

  @override
  NnsInternetIdentityAuthnMethodAddResponse onResponse(List<int> bytes) {
    return NnsInternetIdentityAuthnMethodAddResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityUpdateAuthnMethodReplace
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityAuthnMethodReplaceResponse
        > {
  final NnsInternetIdentityIdentityNumber arg0;
  final NnsInternetIdentityPublicKey arg1;
  final NnsInternetIdentityAuthnMethodData arg2;
  const NnsInternetIdentityUpdateAuthnMethodReplace({
    required this.arg0,
    required this.arg1,
    required this.arg2,
  });

  @override
  String get methodName => 'authn_method_replace';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [
        CType.nat64,
        CType.vec(CType.nat8),
        NnsInternetIdentityAuthnMethodData.ctype,
      ],
      [arg0, arg1, arg2.candidValue],
    );
  }

  @override
  NnsInternetIdentityAuthnMethodReplaceResponse onResponse(List<int> bytes) {
    return NnsInternetIdentityAuthnMethodReplaceResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityUpdateAuthnMethodMetadataReplace
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityAuthnMethodMetadataReplaceResponse
        > {
  final NnsInternetIdentityIdentityNumber arg0;
  final NnsInternetIdentityPublicKey arg1;
  final NnsInternetIdentityMetadataMapV2 arg2;
  const NnsInternetIdentityUpdateAuthnMethodMetadataReplace({
    required this.arg0,
    required this.arg1,
    required this.arg2,
  });

  @override
  String get methodName => 'authn_method_metadata_replace';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [
        CType.nat64,
        CType.vec(CType.nat8),
        NnsInternetIdentityMetadataMapV2Candid.ctype,
      ],
      [arg0, arg1, arg2],
    );
  }

  @override
  NnsInternetIdentityAuthnMethodMetadataReplaceResponse onResponse(
    List<int> bytes,
  ) {
    return NnsInternetIdentityAuthnMethodMetadataReplaceResponse.fromBytes(
      bytes,
    );
  }
}

class NnsInternetIdentityUpdateAuthnMethodSecuritySettingsReplace
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityAuthnMethodSecuritySettingsReplaceResponse
        > {
  final NnsInternetIdentityIdentityNumber arg0;
  final NnsInternetIdentityPublicKey arg1;
  final NnsInternetIdentityAuthnMethodSecuritySettings arg2;
  const NnsInternetIdentityUpdateAuthnMethodSecuritySettingsReplace({
    required this.arg0,
    required this.arg1,
    required this.arg2,
  });

  @override
  String get methodName => 'authn_method_security_settings_replace';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [
        CType.nat64,
        CType.vec(CType.nat8),
        NnsInternetIdentityAuthnMethodSecuritySettings.ctype,
      ],
      [arg0, arg1, arg2.candidValue],
    );
  }

  @override
  NnsInternetIdentityAuthnMethodSecuritySettingsReplaceResponse onResponse(
    List<int> bytes,
  ) {
    return NnsInternetIdentityAuthnMethodSecuritySettingsReplaceResponse.fromBytes(
      bytes,
    );
  }
}

class NnsInternetIdentityUpdateAuthnMethodRemove
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityAuthnMethodRemoveResponse
        > {
  final NnsInternetIdentityIdentityNumber arg0;
  final NnsInternetIdentityPublicKey arg1;
  const NnsInternetIdentityUpdateAuthnMethodRemove({
    required this.arg0,
    required this.arg1,
  });

  @override
  String get methodName => 'authn_method_remove';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [CType.nat64, CType.vec(CType.nat8)],
      [arg0, arg1],
    );
  }

  @override
  NnsInternetIdentityAuthnMethodRemoveResponse onResponse(List<int> bytes) {
    return NnsInternetIdentityAuthnMethodRemoveResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityUpdateAuthnMethodRegistrationModeEnter
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityAuthnMethodRegistrationModeEnterResponse
        > {
  final NnsInternetIdentityIdentityNumber arg0;
  final NnsInternetIdentityRegistrationId? arg1;
  const NnsInternetIdentityUpdateAuthnMethodRegistrationModeEnter({
    required this.arg0,
    required this.arg1,
  });

  @override
  String get methodName => 'authn_method_registration_mode_enter';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [CType.nat64, CType.opt(CType.text)],
      [arg0, arg1],
    );
  }

  @override
  NnsInternetIdentityAuthnMethodRegistrationModeEnterResponse onResponse(
    List<int> bytes,
  ) {
    return NnsInternetIdentityAuthnMethodRegistrationModeEnterResponse.fromBytes(
      bytes,
    );
  }
}

class NnsInternetIdentityUpdateAuthnMethodRegistrationModeExit
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityAuthnMethodRegistrationModeExitResponse
        > {
  final NnsInternetIdentityIdentityNumber arg0;
  final NnsInternetIdentityAuthnMethodData? arg1;
  const NnsInternetIdentityUpdateAuthnMethodRegistrationModeExit({
    required this.arg0,
    required this.arg1,
  });

  @override
  String get methodName => 'authn_method_registration_mode_exit';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [CType.nat64, CType.opt(NnsInternetIdentityAuthnMethodData.ctype)],
      [arg0, arg1],
    );
  }

  @override
  NnsInternetIdentityAuthnMethodRegistrationModeExitResponse onResponse(
    List<int> bytes,
  ) {
    return NnsInternetIdentityAuthnMethodRegistrationModeExitResponse.fromBytes(
      bytes,
    );
  }
}

class NnsInternetIdentityUpdateAuthnMethodRegister
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityAuthnMethodRegisterResponse
        > {
  final NnsInternetIdentityIdentityNumber arg0;
  final NnsInternetIdentityAuthnMethodData arg1;
  const NnsInternetIdentityUpdateAuthnMethodRegister({
    required this.arg0,
    required this.arg1,
  });

  @override
  String get methodName => 'authn_method_register';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [CType.nat64, NnsInternetIdentityAuthnMethodData.ctype],
      [arg0, arg1.candidValue],
    );
  }

  @override
  NnsInternetIdentityAuthnMethodRegisterResponse onResponse(List<int> bytes) {
    return NnsInternetIdentityAuthnMethodRegisterResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityUpdateAuthnMethodSessionRegister
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityAuthnMethodRegisterResponse
        > {
  final NnsInternetIdentityIdentityNumber args;
  const NnsInternetIdentityUpdateAuthnMethodSessionRegister(this.args);

  @override
  String get methodName => 'authn_method_session_register';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(CType.nat64, args);
  }

  @override
  NnsInternetIdentityAuthnMethodRegisterResponse onResponse(List<int> bytes) {
    return NnsInternetIdentityAuthnMethodRegisterResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityUpdateAuthnMethodConfirm
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityAuthnMethodConfirmResponse
        > {
  final NnsInternetIdentityIdentityNumber arg0;
  final String arg1;
  const NnsInternetIdentityUpdateAuthnMethodConfirm({
    required this.arg0,
    required this.arg1,
  });

  @override
  String get methodName => 'authn_method_confirm';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode([CType.nat64, CType.text], [arg0, arg1]);
  }

  @override
  NnsInternetIdentityAuthnMethodConfirmResponse onResponse(List<int> bytes) {
    return NnsInternetIdentityAuthnMethodConfirmResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityUpdatePrepareDelegation
    extends NnsInternetIdentityUpdateMessage<List<dynamic>> {
  final NnsInternetIdentityUserNumber arg0;
  final NnsInternetIdentityFrontendHostname arg1;
  final NnsInternetIdentitySessionKey arg2;
  final BigInt? arg3;
  const NnsInternetIdentityUpdatePrepareDelegation({
    required this.arg0,
    required this.arg1,
    required this.arg2,
    required this.arg3,
  });

  @override
  String get methodName => 'prepare_delegation';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [CType.nat64, CType.text, CType.vec(CType.nat8), CType.opt(CType.nat64)],
      [arg0, arg1, arg2, arg3],
    );
  }

  @override
  List<dynamic> onResponse(List<int> bytes) {
    return CandidUtils.decode(bytes, [CType.vec(CType.nat8), CType.nat64]);
  }
}

class NnsInternetIdentityUpdatePrepareAttributes
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityPrepareAttributesResponse
        > {
  final NnsInternetIdentityPrepareAttributeRequest args;
  const NnsInternetIdentityUpdatePrepareAttributes(this.args);

  @override
  String get methodName => 'prepare_attributes';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsInternetIdentityPrepareAttributesResponse onResponse(List<int> bytes) {
    return NnsInternetIdentityPrepareAttributesResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityUpdatePrepareIcrc3Attributes
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityPrepareIcrc3AttributesResponse
        > {
  final NnsInternetIdentityPrepareIcrc3AttributeRequest args;
  const NnsInternetIdentityUpdatePrepareIcrc3Attributes(this.args);

  @override
  String get methodName => 'prepare_icrc3_attributes';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsInternetIdentityPrepareIcrc3AttributesResponse onResponse(
    List<int> bytes,
  ) {
    return NnsInternetIdentityPrepareIcrc3AttributesResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityUpdatePrepareIdAlias
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityPrepareIdAliasResponse
        > {
  final NnsInternetIdentityPrepareIdAliasRequest args;
  const NnsInternetIdentityUpdatePrepareIdAlias(this.args);

  @override
  String get methodName => 'prepare_id_alias';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsInternetIdentityPrepareIdAliasResponse onResponse(List<int> bytes) {
    return NnsInternetIdentityPrepareIdAliasResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityUpdateOpenidIdentityRegistrationFinish
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityOpenidIdentityRegistrationFinishResponse
        > {
  final NnsInternetIdentityOpenIDRegFinishArg args;
  const NnsInternetIdentityUpdateOpenidIdentityRegistrationFinish(this.args);

  @override
  String get methodName => 'openid_identity_registration_finish';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsInternetIdentityOpenidIdentityRegistrationFinishResponse onResponse(
    List<int> bytes,
  ) {
    return NnsInternetIdentityOpenidIdentityRegistrationFinishResponse.fromBytes(
      bytes,
    );
  }
}

class NnsInternetIdentityUpdateOpenidCredentialAdd
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityOpenidCredentialAddResponse
        > {
  final NnsInternetIdentityIdentityNumber arg0;
  final NnsInternetIdentityJWT arg1;
  final NnsInternetIdentitySalt arg2;
  final String? arg3;
  const NnsInternetIdentityUpdateOpenidCredentialAdd({
    required this.arg0,
    required this.arg1,
    required this.arg2,
    required this.arg3,
  });

  @override
  String get methodName => 'openid_credential_add';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [CType.nat64, CType.text, CType.vec(CType.nat8), CType.opt(CType.text)],
      [arg0, arg1, arg2, arg3],
    );
  }

  @override
  NnsInternetIdentityOpenidCredentialAddResponse onResponse(List<int> bytes) {
    return NnsInternetIdentityOpenidCredentialAddResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityUpdateOpenidCredentialRemove
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityOpenidCredentialRemoveResponse
        > {
  final NnsInternetIdentityIdentityNumber arg0;
  final NnsInternetIdentityOpenIdCredentialKey arg1;
  const NnsInternetIdentityUpdateOpenidCredentialRemove({
    required this.arg0,
    required this.arg1,
  });

  @override
  String get methodName => 'openid_credential_remove';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [CType.nat64, NnsInternetIdentityOpenIdCredentialKey.ctype],
      [arg0, arg1.candidValue],
    );
  }

  @override
  NnsInternetIdentityOpenidCredentialRemoveResponse onResponse(
    List<int> bytes,
  ) {
    return NnsInternetIdentityOpenidCredentialRemoveResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityUpdateOpenidPrepareDelegation
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityOpenidPrepareDelegationResponse
        > {
  final NnsInternetIdentityJWT arg0;
  final NnsInternetIdentitySalt arg1;
  final NnsInternetIdentitySessionKey arg2;
  final String? arg3;
  const NnsInternetIdentityUpdateOpenidPrepareDelegation({
    required this.arg0,
    required this.arg1,
    required this.arg2,
    required this.arg3,
  });

  @override
  String get methodName => 'openid_prepare_delegation';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [
        CType.text,
        CType.vec(CType.nat8),
        CType.vec(CType.nat8),
        CType.opt(CType.text),
      ],
      [arg0, arg1, arg2, arg3],
    );
  }

  @override
  NnsInternetIdentityOpenidPrepareDelegationResponse onResponse(
    List<int> bytes,
  ) {
    return NnsInternetIdentityOpenidPrepareDelegationResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityUpdateDiscoverSso
    extends NnsInternetIdentityUpdateMessage<Null> {
  final String args;
  const NnsInternetIdentityUpdateDiscoverSso(this.args);

  @override
  String get methodName => 'discover_sso';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(CType.text, args);
  }

  @override
  Null onResponse(List<int> bytes) {
    // unit ()
    return null;
  }
}

class NnsInternetIdentityUpdateSsoPrepareDelegation
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentitySsoPrepareDelegationResponse2
        > {
  final NnsInternetIdentitySsoPrepareDelegationRequest args;
  const NnsInternetIdentityUpdateSsoPrepareDelegation(this.args);

  @override
  String get methodName => 'sso_prepare_delegation';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsInternetIdentitySsoPrepareDelegationResponse2 onResponse(List<int> bytes) {
    return NnsInternetIdentitySsoPrepareDelegationResponse2.fromBytes(bytes);
  }
}

class NnsInternetIdentityUpdateSmtpRequest
    extends NnsInternetIdentityUpdateMessage<NnsInternetIdentitySmtpResponse> {
  final NnsInternetIdentitySmtpRequest args;
  const NnsInternetIdentityUpdateSmtpRequest(this.args);

  @override
  String get methodName => 'smtp_request';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsInternetIdentitySmtpResponse onResponse(List<int> bytes) {
    return NnsInternetIdentitySmtpResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityUpdateEmailChallengeSubmitDkimLeaf
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityEmailChallengeSubmitDkimLeafResponse
        > {
  final NnsInternetIdentityEmailChallengeSubmitDkimLeafArg args;
  const NnsInternetIdentityUpdateEmailChallengeSubmitDkimLeaf(this.args);

  @override
  String get methodName => 'email_challenge_submit_dkim_leaf';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsInternetIdentityEmailChallengeSubmitDkimLeafResponse onResponse(
    List<int> bytes,
  ) {
    return NnsInternetIdentityEmailChallengeSubmitDkimLeafResponse.fromBytes(
      bytes,
    );
  }
}

class NnsInternetIdentityUpdateEmailChallengeResolveViaDoh
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityEmailChallengeSubmitDkimLeafResponse
        > {
  final NnsInternetIdentityEmailChallengeResolveViaDohArg args;
  const NnsInternetIdentityUpdateEmailChallengeResolveViaDoh(this.args);

  @override
  String get methodName => 'email_challenge_resolve_via_doh';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsInternetIdentityEmailChallengeSubmitDkimLeafResponse onResponse(
    List<int> bytes,
  ) {
    return NnsInternetIdentityEmailChallengeSubmitDkimLeafResponse.fromBytes(
      bytes,
    );
  }
}

class NnsInternetIdentityUpdateEmailRecoveryCredentialPrepareAdd
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityEmailRecoveryCredentialPrepareAddResponse
        > {
  final NnsInternetIdentityIdentityNumber arg0;
  final NnsInternetIdentityEmailChallengeDnsInput arg1;
  const NnsInternetIdentityUpdateEmailRecoveryCredentialPrepareAdd({
    required this.arg0,
    required this.arg1,
  });

  @override
  String get methodName => 'email_recovery_credential_prepare_add';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [CType.nat64, NnsInternetIdentityEmailChallengeDnsInput.ctype],
      [arg0, arg1.candidValue],
    );
  }

  @override
  NnsInternetIdentityEmailRecoveryCredentialPrepareAddResponse onResponse(
    List<int> bytes,
  ) {
    return NnsInternetIdentityEmailRecoveryCredentialPrepareAddResponse.fromBytes(
      bytes,
    );
  }
}

class NnsInternetIdentityUpdateEmailRecoveryPrepareDelegation
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityEmailRecoveryCredentialPrepareAddResponse
        > {
  final NnsInternetIdentityEmailChallengeDnsInput arg0;
  final NnsInternetIdentitySessionKey arg1;
  const NnsInternetIdentityUpdateEmailRecoveryPrepareDelegation({
    required this.arg0,
    required this.arg1,
  });

  @override
  String get methodName => 'email_recovery_prepare_delegation';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [NnsInternetIdentityEmailChallengeDnsInput.ctype, CType.vec(CType.nat8)],
      [arg0.candidValue, arg1],
    );
  }

  @override
  NnsInternetIdentityEmailRecoveryCredentialPrepareAddResponse onResponse(
    List<int> bytes,
  ) {
    return NnsInternetIdentityEmailRecoveryCredentialPrepareAddResponse.fromBytes(
      bytes,
    );
  }
}

class NnsInternetIdentityUpdateEmailRecoveryCredentialRemove
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityEmailChallengeSubmitDkimLeafResponse
        > {
  final NnsInternetIdentityIdentityNumber arg0;
  final String arg1;
  const NnsInternetIdentityUpdateEmailRecoveryCredentialRemove({
    required this.arg0,
    required this.arg1,
  });

  @override
  String get methodName => 'email_recovery_credential_remove';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode([CType.nat64, CType.text], [arg0, arg1]);
  }

  @override
  NnsInternetIdentityEmailChallengeSubmitDkimLeafResponse onResponse(
    List<int> bytes,
  ) {
    return NnsInternetIdentityEmailChallengeSubmitDkimLeafResponse.fromBytes(
      bytes,
    );
  }
}

class NnsInternetIdentityUpdateVerifiedEmailPrepareAdd
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityEmailRecoveryCredentialPrepareAddResponse
        > {
  final NnsInternetIdentityIdentityNumber arg0;
  final NnsInternetIdentityEmailChallengeDnsInput arg1;
  const NnsInternetIdentityUpdateVerifiedEmailPrepareAdd({
    required this.arg0,
    required this.arg1,
  });

  @override
  String get methodName => 'verified_email_prepare_add';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [CType.nat64, NnsInternetIdentityEmailChallengeDnsInput.ctype],
      [arg0, arg1.candidValue],
    );
  }

  @override
  NnsInternetIdentityEmailRecoveryCredentialPrepareAddResponse onResponse(
    List<int> bytes,
  ) {
    return NnsInternetIdentityEmailRecoveryCredentialPrepareAddResponse.fromBytes(
      bytes,
    );
  }
}

class NnsInternetIdentityUpdateVerifiedEmailRemove
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityEmailChallengeSubmitDkimLeafResponse
        > {
  final NnsInternetIdentityIdentityNumber arg0;
  final String arg1;
  const NnsInternetIdentityUpdateVerifiedEmailRemove({
    required this.arg0,
    required this.arg1,
  });

  @override
  String get methodName => 'verified_email_remove';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode([CType.nat64, CType.text], [arg0, arg1]);
  }

  @override
  NnsInternetIdentityEmailChallengeSubmitDkimLeafResponse onResponse(
    List<int> bytes,
  ) {
    return NnsInternetIdentityEmailChallengeSubmitDkimLeafResponse.fromBytes(
      bytes,
    );
  }
}

class NnsInternetIdentityUpdateEmailRecoverySubmitDkimLeaf
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityEmailChallengeSubmitDkimLeafResponse
        > {
  final NnsInternetIdentityEmailChallengeSubmitDkimLeafArg args;
  const NnsInternetIdentityUpdateEmailRecoverySubmitDkimLeaf(this.args);

  @override
  String get methodName => 'email_recovery_submit_dkim_leaf';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsInternetIdentityEmailChallengeSubmitDkimLeafResponse onResponse(
    List<int> bytes,
  ) {
    return NnsInternetIdentityEmailChallengeSubmitDkimLeafResponse.fromBytes(
      bytes,
    );
  }
}

class NnsInternetIdentityUpdateEmailRecoveryResolveViaDoh
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityEmailChallengeSubmitDkimLeafResponse
        > {
  final NnsInternetIdentityEmailChallengeResolveViaDohArg args;
  const NnsInternetIdentityUpdateEmailRecoveryResolveViaDoh(this.args);

  @override
  String get methodName => 'email_recovery_resolve_via_doh';

  @override
  List<int> toCandidBytes() {
    return args.toCandidBytes();
  }

  @override
  NnsInternetIdentityEmailChallengeSubmitDkimLeafResponse onResponse(
    List<int> bytes,
  ) {
    return NnsInternetIdentityEmailChallengeSubmitDkimLeafResponse.fromBytes(
      bytes,
    );
  }
}

class NnsInternetIdentityUpdateInitSalt
    extends NnsInternetIdentityUpdateMessage<Null> {
  const NnsInternetIdentityUpdateInitSalt();

  @override
  String get methodName => 'init_salt';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  Null onResponse(List<int> bytes) {
    // unit ()
    return null;
  }
}

class NnsInternetIdentityUpdateDeployArchive
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityDeployArchiveResult
        > {
  final List<int> args;
  const NnsInternetIdentityUpdateDeployArchive(this.args);

  @override
  String get methodName => 'deploy_archive';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(CType.vec(CType.nat8), args);
  }

  @override
  NnsInternetIdentityDeployArchiveResult onResponse(List<int> bytes) {
    return NnsInternetIdentityDeployArchiveResult.fromBytes(bytes);
  }
}

class NnsInternetIdentityUpdateFetchEntries
    extends
        NnsInternetIdentityUpdateMessage<
          List<NnsInternetIdentityBufferedArchiveEntry>
        > {
  const NnsInternetIdentityUpdateFetchEntries();

  @override
  String get methodName => 'fetch_entries';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  List<NnsInternetIdentityBufferedArchiveEntry> onResponse(List<int> bytes) {
    final decode = CandidUtils.decodeOneTyped(
      bytes,
      CType.vec(NnsInternetIdentityBufferedArchiveEntry.ctype),
    );
    return JsonParser.valueEnsureAsList<Map<String, dynamic>>(decode)
        .map((e) => NnsInternetIdentityBufferedArchiveEntry.fromCandid(e))
        .toList();
  }
}

class NnsInternetIdentityUpdateAcknowledgeEntries
    extends NnsInternetIdentityUpdateMessage<Null> {
  final BigInt args;
  const NnsInternetIdentityUpdateAcknowledgeEntries(this.args);

  @override
  String get methodName => 'acknowledge_entries';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(CType.nat64, args);
  }

  @override
  Null onResponse(List<int> bytes) {
    // unit ()
    return null;
  }
}

class NnsInternetIdentityUpdateCreateAccount
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityCreateAccountResponse
        > {
  final NnsInternetIdentityUserNumber arg0;
  final NnsInternetIdentityFrontendHostname arg1;
  final String arg2;
  const NnsInternetIdentityUpdateCreateAccount({
    required this.arg0,
    required this.arg1,
    required this.arg2,
  });

  @override
  String get methodName => 'create_account';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [CType.nat64, CType.text, CType.text],
      [arg0, arg1, arg2],
    );
  }

  @override
  NnsInternetIdentityCreateAccountResponse onResponse(List<int> bytes) {
    return NnsInternetIdentityCreateAccountResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityUpdateUpdateAccount
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityUpdateAccountResponse
        > {
  final NnsInternetIdentityUserNumber arg0;
  final NnsInternetIdentityFrontendHostname arg1;
  final NnsInternetIdentityAccountNumber? arg2;
  final NnsInternetIdentityAccountUpdate arg3;
  const NnsInternetIdentityUpdateUpdateAccount({
    required this.arg0,
    required this.arg1,
    required this.arg2,
    required this.arg3,
  });

  @override
  String get methodName => 'update_account';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [
        CType.nat64,
        CType.text,
        CType.opt(CType.nat64),
        NnsInternetIdentityAccountUpdate.ctype,
      ],
      [arg0, arg1, arg2, arg3.candidValue],
    );
  }

  @override
  NnsInternetIdentityUpdateAccountResponse onResponse(List<int> bytes) {
    return NnsInternetIdentityUpdateAccountResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityUpdatePrepareAccountDelegation
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityPrepareAccountDelegationResponse
        > {
  final NnsInternetIdentityUserNumber arg0;
  final NnsInternetIdentityFrontendHostname arg1;
  final NnsInternetIdentityAccountNumber? arg2;
  final NnsInternetIdentitySessionKey arg3;
  final BigInt? arg4;
  final NnsInternetIdentityPermissions? arg5;
  const NnsInternetIdentityUpdatePrepareAccountDelegation({
    required this.arg0,
    required this.arg1,
    required this.arg2,
    required this.arg3,
    required this.arg4,
    required this.arg5,
  });

  @override
  String get methodName => 'prepare_account_delegation';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [
        CType.nat64,
        CType.text,
        CType.opt(CType.nat64),
        CType.vec(CType.nat8),
        CType.opt(CType.nat64),
        CType.opt(NnsInternetIdentityPermissions.ctype),
      ],
      [arg0, arg1, arg2, arg3, arg4, arg5],
    );
  }

  @override
  NnsInternetIdentityPrepareAccountDelegationResponse onResponse(
    List<int> bytes,
  ) {
    return NnsInternetIdentityPrepareAccountDelegationResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityUpdateMcpSetConfig
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityMcpSetConfigResponse
        > {
  final NnsInternetIdentityUserNumber arg0;
  final NnsInternetIdentityMcpConfig arg1;
  const NnsInternetIdentityUpdateMcpSetConfig({
    required this.arg0,
    required this.arg1,
  });

  @override
  String get methodName => 'mcp_set_config';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [CType.nat64, NnsInternetIdentityMcpConfig.ctype],
      [arg0, arg1.candidValue],
    );
  }

  @override
  NnsInternetIdentityMcpSetConfigResponse onResponse(List<int> bytes) {
    return NnsInternetIdentityMcpSetConfigResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityUpdateMcpPrepareDelegation
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityMcpPrepareDelegationResponse
        > {
  final NnsInternetIdentityFrontendHostname arg0;
  final NnsInternetIdentityAccountNumber? arg1;
  final NnsInternetIdentitySessionKey arg2;
  final BigInt? arg3;
  const NnsInternetIdentityUpdateMcpPrepareDelegation({
    required this.arg0,
    required this.arg1,
    required this.arg2,
    required this.arg3,
  });

  @override
  String get methodName => 'mcp_prepare_delegation';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [
        CType.text,
        CType.opt(CType.nat64),
        CType.vec(CType.nat8),
        CType.opt(CType.nat64),
      ],
      [arg0, arg1, arg2, arg3],
    );
  }

  @override
  NnsInternetIdentityMcpPrepareDelegationResponse onResponse(List<int> bytes) {
    return NnsInternetIdentityMcpPrepareDelegationResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityUpdatePrepareSessionDelegation
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityPrepareSessionDelegationResponse
        > {
  final NnsInternetIdentityUserNumber arg0;
  final NnsInternetIdentitySessionKey arg1;
  final BigInt? arg2;
  const NnsInternetIdentityUpdatePrepareSessionDelegation({
    required this.arg0,
    required this.arg1,
    required this.arg2,
  });

  @override
  String get methodName => 'prepare_session_delegation';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [CType.nat64, CType.vec(CType.nat8), CType.opt(CType.nat64)],
      [arg0, arg1, arg2],
    );
  }

  @override
  NnsInternetIdentityPrepareSessionDelegationResponse onResponse(
    List<int> bytes,
  ) {
    return NnsInternetIdentityPrepareSessionDelegationResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityUpdatePrepareMcpRegistrationDelegation
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityPrepareMcpRegistrationDelegationResponse
        > {
  final NnsInternetIdentityUserNumber arg0;
  final NnsInternetIdentitySessionKey arg1;
  final NnsInternetIdentityPermissions? arg2;
  final BigInt? arg3;
  const NnsInternetIdentityUpdatePrepareMcpRegistrationDelegation({
    required this.arg0,
    required this.arg1,
    required this.arg2,
    required this.arg3,
  });

  @override
  String get methodName => 'prepare_mcp_registration_delegation';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [
        CType.nat64,
        CType.vec(CType.nat8),
        CType.opt(NnsInternetIdentityPermissions.ctype),
        CType.opt(CType.nat64),
      ],
      [arg0, arg1, arg2, arg3],
    );
  }

  @override
  NnsInternetIdentityPrepareMcpRegistrationDelegationResponse onResponse(
    List<int> bytes,
  ) {
    return NnsInternetIdentityPrepareMcpRegistrationDelegationResponse.fromBytes(
      bytes,
    );
  }
}

class NnsInternetIdentityUpdateMcpRegisterV2
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentityMcpRegisterV2Response
        > {
  final NnsInternetIdentitySessionKey args;
  const NnsInternetIdentityUpdateMcpRegisterV2(this.args);

  @override
  String get methodName => 'mcp_register_v2';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encodeOneTyped(CType.vec(CType.nat8), args);
  }

  @override
  NnsInternetIdentityMcpRegisterV2Response onResponse(List<int> bytes) {
    return NnsInternetIdentityMcpRegisterV2Response.fromBytes(bytes);
  }
}

class NnsInternetIdentityUpdateSetDefaultAccount
    extends
        NnsInternetIdentityUpdateMessage<
          NnsInternetIdentitySetDefaultAccountResponse
        > {
  final NnsInternetIdentityUserNumber arg0;
  final NnsInternetIdentityFrontendHostname arg1;
  final NnsInternetIdentityAccountNumber? arg2;
  const NnsInternetIdentityUpdateSetDefaultAccount({
    required this.arg0,
    required this.arg1,
    required this.arg2,
  });

  @override
  String get methodName => 'set_default_account';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(
      [CType.nat64, CType.text, CType.opt(CType.nat64)],
      [arg0, arg1, arg2],
    );
  }

  @override
  NnsInternetIdentitySetDefaultAccountResponse onResponse(List<int> bytes) {
    return NnsInternetIdentitySetDefaultAccountResponse.fromBytes(bytes);
  }
}

class NnsInternetIdentityUpdateLookupCallerIdentityByRecoveryPhrase
    extends
        NnsInternetIdentityUpdateMessage<NnsInternetIdentityIdentityNumber?> {
  const NnsInternetIdentityUpdateLookupCallerIdentityByRecoveryPhrase();

  @override
  String get methodName => 'lookup_caller_identity_by_recovery_phrase';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  NnsInternetIdentityIdentityNumber? onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.opt(CType.nat64))
        as NnsInternetIdentityIdentityNumber?;
  }
}
