// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/icp/src/address/address.dart';

/// Shared helpers for generated Candid types (principal parse, etc.).
abstract final class GeneratorParserUtils {
  /// Convert a decoded Candid principal value to [IcpPrincipalAddress].
  static IcpPrincipalAddress principalFromCandid(dynamic e) {
    try {
      if (e is IcpPrincipalAddress) return e;
      if (e is String) return IcpPrincipalAddress(e);
      if (e is List<int>) return IcpPrincipalAddress.fromBytes(e);
    } catch (_) {}
    throw OnChainErrors.icpCandid(
      'GeneratorParserUtils.principalFromCandid',
      reason: 'Expected principal, got ${e.runtimeType}',
    );
  }
}
