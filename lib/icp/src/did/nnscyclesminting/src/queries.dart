// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: prefer_const_constructors

import 'package:on_chain/icp/src/service/service.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/serialization/serialization.dart';
import 'types.dart';

/// Query messages for service `NnsCyclesMinting`.
abstract class NnsCyclesMintingQueryMessage<RESULT>
    extends IICPQueryMessage<RESULT> {
  const NnsCyclesMintingQueryMessage();
}

class NnsCyclesMintingQueryGetIcpXdrConversionRate
    extends
        NnsCyclesMintingQueryMessage<
          NnsCyclesMintingIcpXdrConversionRateResponse
        > {
  const NnsCyclesMintingQueryGetIcpXdrConversionRate();

  @override
  String get methodName => 'get_icp_xdr_conversion_rate';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  NnsCyclesMintingIcpXdrConversionRateResponse onResponse(List<int> bytes) {
    return NnsCyclesMintingIcpXdrConversionRateResponse.fromBytes(bytes);
  }
}

class NnsCyclesMintingQueryGetSubnetTypesToSubnets
    extends
        NnsCyclesMintingQueryMessage<
          NnsCyclesMintingSubnetTypesToSubnetsResponse
        > {
  const NnsCyclesMintingQueryGetSubnetTypesToSubnets();

  @override
  String get methodName => 'get_subnet_types_to_subnets';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  NnsCyclesMintingSubnetTypesToSubnetsResponse onResponse(List<int> bytes) {
    return NnsCyclesMintingSubnetTypesToSubnetsResponse.fromBytes(bytes);
  }
}

class NnsCyclesMintingQueryGetPrincipalsAuthorizedToCreateCanistersToSubnets
    extends
        NnsCyclesMintingQueryMessage<
          NnsCyclesMintingPrincipalsAuthorizedToCreateCanistersToSubnetsResponse
        > {
  const NnsCyclesMintingQueryGetPrincipalsAuthorizedToCreateCanistersToSubnets();

  @override
  String get methodName =>
      'get_principals_authorized_to_create_canisters_to_subnets';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  NnsCyclesMintingPrincipalsAuthorizedToCreateCanistersToSubnetsResponse
  onResponse(List<int> bytes) {
    return NnsCyclesMintingPrincipalsAuthorizedToCreateCanistersToSubnetsResponse.fromBytes(
      bytes,
    );
  }
}

class NnsCyclesMintingQueryGetDefaultSubnets
    extends NnsCyclesMintingQueryMessage<List<IcpPrincipalAddress>> {
  const NnsCyclesMintingQueryGetDefaultSubnets();

  @override
  String get methodName => 'get_default_subnets';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  List<IcpPrincipalAddress> onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.vec(CType.principal))
        as List<IcpPrincipalAddress>;
  }
}

class NnsCyclesMintingQueryGetBuildMetadata
    extends NnsCyclesMintingQueryMessage<String> {
  const NnsCyclesMintingQueryGetBuildMetadata();

  @override
  String get methodName => 'get_build_metadata';

  @override
  List<int> toCandidBytes() {
    return CandidUtils.encode(const <CType>[], const <dynamic>[]);
  }

  @override
  String onResponse(List<int> bytes) {
    return CandidUtils.decodeOneTyped(bytes, CType.text) as String;
  }
}
