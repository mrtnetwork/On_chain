import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/crypto/types/types.dart';
import 'package:on_chain/icp/src/rpc/types/params.dart';
import 'package:on_chain/icp/src/service/http/types/icp_http_content.dart';
import 'package:on_chain/icp/src/service/http/types/icp_http_envelope.dart';

class ICPUtils {
  static const Duration defaultIngressExpiry = Duration(minutes: 5);
  // in ICPUtils
  static List<List<List<int>>> requestStatusPaths(List<int> requestId) => [
    [
      StringUtils.encode('request_status'),
      requestId,
      StringUtils.encode('status'),
    ],
    [
      StringUtils.encode('request_status'),
      requestId,
      StringUtils.encode('reply'),
    ],
    [
      StringUtils.encode('request_status'),
      requestId,
      StringUtils.encode('reject_code'),
    ],
    [
      StringUtils.encode('request_status'),
      requestId,
      StringUtils.encode('reject_message'),
    ],
    [
      StringUtils.encode('request_status'),
      requestId,
      StringUtils.encode('error_code'),
    ],
    [StringUtils.encode('time')],
  ];
  static String generateCanisterPath({
    required IcpPrincipalAddress canisterId,
    required ICPHttpRequestType type,
    ICPApiVersion version = ICPApiVersion.v3,
  }) {
    final v = version.value;
    final id = canisterId.address;
    return switch (type) {
      ICPHttpRequestType.call => 'api/$v/canister/$id/call',
      ICPHttpRequestType.query => 'api/$v/canister/$id/query',
      ICPHttpRequestType.readState => 'api/$v/canister/$id/read_state',
    };
  }

  static String generateSubnetPath({
    required IcpPrincipalAddress subnetId,
    required ICPHttpRequestType type,
    ICPApiVersion version = ICPApiVersion.v3,
  }) {
    final v = version.value;
    final id = subnetId.address;
    return switch (type) {
      ICPHttpRequestType.call => 'api/$v/subnet/$id/call',
      ICPHttpRequestType.query => 'api/$v/subnet/$id/query',
      ICPHttpRequestType.readState => 'api/$v/subnet/$id/read_state',
    };
  }

  static String statusPath({ICPApiVersion version = ICPApiVersion.v3}) {
    final v = version.value;
    return 'api/$v/status';
  }

  static BigInt generateIngressExpiry({Duration? expiry}) {
    final expiryMs =
        DateTime.now()
            .add(expiry ?? defaultIngressExpiry)
            .millisecondsSinceEpoch;
    return BigInt.from(expiryMs) * BigInt.from(1000000);
  }

  static Future<ICPHttpEnvelope> generateContentEnvelope(
    ICPHttpContent content, {
    IcpPrincipalAddress? sender,
    ICPSigner? signer,
  }) async {
    sender ??= switch (content) {
      ICPHttpCallContent(:var sender) => sender,
      ICPHttpQueryContent(:var sender) => sender,
      _ => null,
    };
    if (content.type == ICPHttpRequestType.query ||
        content.type == ICPHttpRequestType.readState) {
      if (sender == null ||
          sender == IcpPrincipalAddress.anonymous ||
          signer == null) {
        return ICPHttpEnvelope(content: content);
      }
    }
    if (signer == null) {
      throw OnChainErrors.icpPlugin(
        "generateEnvelope",
        reason:
            "Missing signer. Update state requires a signer to sign the envelope.",
      );
    }
    return await signer.signContent(content);
  }
}
