import 'package:blockchain_utils/service/models/params.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/crypto/types/types.dart';
import 'package:on_chain/icp/src/crypto/utils/utils.dart';
import 'package:on_chain/icp/src/rpc/core/core.dart';
import 'package:on_chain/icp/src/rpc/types/params.dart';
import 'package:on_chain/icp/src/rpc/types/types.dart';
import 'package:on_chain/icp/src/service/certificate/src/icp_certificate.dart';
import 'package:on_chain/icp/src/service/client/api/icp_icrc.dart';
import 'package:on_chain/icp/src/service/client/api/icp_quick_api.dart';
import 'package:on_chain/icp/src/service/client/api/icp_token_api.dart';
import 'package:on_chain/icp/src/service/client/api/ipc_update.dart';
import 'package:on_chain/icp/src/service/client/types/types.dart';

/// Default high-level ICP client: queries, updates, read_state, verification.
///
/// Composes [ICPQuickApi] with query/update mixins and applies the strategies
/// from [ICPClientConfig] when building and verifying requests.
class ICPClientDefault extends ICPQuickApi
    with ICPQuickQueryApi, ICPUpdateQuickApi, ICPTokenQuickApi {
  /// Low-level HTTP/CBOR provider that sends [ICPRequestDetails].
  @override
  final IProvider<IServiceProvider, ICPRequestDetails> provider;

  /// Auth, network, and verification strategy for this client instance.
  final ICPClientConfig config;

  /// Cached root key from `GET /api/v2/status` (DER-encoded BLS public key).
  List<int>? _rootKey;

  /// Cached subnet certificates per canister (from read_state `/subnet`).
  final Map<IcpPrincipalAddress, ICPCertificate> _certificates = {};

  /// Canisters that already passed verification under
  /// [ICPResponseVerificationStrategyOncePerCanister].
  final Set<IcpPrincipalAddress> _verified = {};

  @override
  ICPNetworkConfig get networkConfig => config.network;

  ICPClientDefault({required this.provider, required this.config});

  /// Returns the IC root key, fetching status once and caching the result.
  ///
  /// Returns null only if status has no root key (unusual on a real replica).
  @override
  Future<List<int>?> rootKey() async {
    final rootKey = _rootKey;
    if (rootKey != null) return rootKey;
    final status = await this.status();
    return _rootKey = status.rootKey;
  }

  /// Internal certificate / query signature verification.
  ///
  /// 1. Loads root key (skip verify if missing).
  /// 2. Reuses or fetches a subnet certificate for [canisterId].
  /// 3. Delegates to [ICPCryptoUtils.verify] (BLS cert + optional node sigs).
  Future<bool> _verifyInternal({
    required IcpPrincipalAddress canisterId,
    ICPCertificate? certificate,
    CbBlsVerificationKey? verificationKey,
    ICPFullDecodedQueryResponse? query,
    CbED25519Verification? ed25519Verification,
  }) async {
    final rootKey = await this.rootKey();
    // No root key → cannot verify; treat as success (e.g. misconfigured status).
    if (rootKey == null) return true;

    if (certificate == null) {
      if (query == null) return false;

      // Prefer a cached cert that already contains the response node keys.
      final cert = _certificates[canisterId];
      if (cert != null &&
          query.response.signatures.every(
            (e) =>
                cert.tryGetNodePublicKey(
                  nodeId: e.identity,
                  rootKey: rootKey,
                ) !=
                null,
          )) {
        certificate = cert;
      } else {
        // Fetch subnet cert via read_state and cache it.
        certificate = await getCanisterSubnet(canisterId);
        _certificates[canisterId] = certificate;
      }
    }

    return await ICPCryptoUtils.verify(
      rootKey: rootKey,
      certificate: certificate,
      queries: [if (query != null) query],
      verificationKey: verificationKey,
      ed25519Verification: ed25519Verification,
    );
  }

  /// Public verification entry point; behavior depends on [config.verificationStrategy].
  ///
  /// - Never: always true
  /// - OncePerCanister: full verify once, then cache success per canister
  /// - Always: full verify on every call
  @override
  Future<bool> verify({
    required IcpPrincipalAddress canisterId,
    ICPCertificate? certificate,
    CbBlsVerificationKey? verificationKey,
    ICPFullDecodedQueryResponse<dynamic>? query,
  }) async {
    switch (config.verificationStrategy) {
      case ICPResponseVerificationStrategyNever():
        return true;

      case ICPResponseVerificationStrategyOncePerCanister(
        verificationKey: final vf,
        :final ed25519verificationCallback,
      ):
        if (_verified.contains(canisterId)) return true;
        final result = await _verifyInternal(
          canisterId: canisterId,
          certificate: certificate,
          query: query,
          verificationKey: verificationKey ?? vf,
          ed25519Verification: ed25519verificationCallback,
        );
        if (result) {
          _verified.add(canisterId);
        }
        return result;

      case ICPResponseVerificationStrategyAlways(
        :final verificationKey,
        :final ed25519verificationCallback,
      ):
        return await _verifyInternal(
          canisterId: canisterId,
          certificate: certificate,
          query: query,
          verificationKey: verificationKey,
          ed25519Verification: ed25519verificationCallback,
        );
    }
  }

  /// Builds query request params according to [config.queryStrategy].
  @override
  Future<ICPRequestQueryParams> createQueryParams(
    IcpPrincipalAddress canisterId,
  ) async {
    switch (config.queryStrategy) {
      case ICPQueryStrategyAnonymous():
        return ICPRequestQueryParams.anonymous(canisterId);

      case ICPQueryStrategySigning(:final signer, :final address):
        final s = await signer(address);
        return ICPRequestQueryParams.sign(
          canisterId: canisterId,
          sender: address,
          signer: s,
          ingressExpiry: config.config.ingressExpiry,
          nonce: config.config.nonceGenerator,
        );
    }
  }

  /// Builds read_state request params according to [config.readStateStrategy].
  @override
  Future<ICPRequestReadStateParams> createReadStateParams(
    IcpPrincipalAddress canisterId,
  ) async {
    switch (config.readStateStrategy) {
      case ICPQueryStrategyAnonymous():
        return ICPRequestReadStateParams.anonymous(canisterId);

      case ICPQueryStrategySigning(:final signer, :final address):
        final s = await signer(address);
        return ICPRequestReadStateParams.sign(
          canisterId: canisterId,
          sender: address,
          signer: s,
          ingressExpiry: config.config.ingressExpiry,
          nonce: config.config.nonceGenerator,
        );
    }
  }

  /// Builds update/call request params according to [config.callStrategy].
  ///
  /// [canisterId] is the management or target canister in the message body.
  /// [effectiveCanisterId] is used in the URL path when calling management
  /// methods that require it (e.g. `install_code`).
  /// Throws if calls are disabled via [ICPCallStrategyDisable].
  @override
  Future<ICPRequestCallParams> createCallParams({
    required IcpPrincipalAddress canisterId,
    required IcpPrincipalAddress sender,
    IcpPrincipalAddress? effectiveCanisterId,
  }) async {
    switch (config.callStrategy) {
      case ICPCallStrategyDisable():
        throw OnChainErrors.icpClient(
          "createCallParams",
          reason: "Call request disabled by client strategy.",
          details: const {"strategy": "ICPCallStrategyDisable"},
        );

      case ICPCallStrategySigning(:final signer):
        final s = await signer(sender);
        return ICPRequestCallParams.sign(
          canisterId: canisterId,
          sender: sender,
          effectiveCanisterId: effectiveCanisterId,
          signer: s,
          ingressExpiry: config.config.ingressExpiry,
          nonce: config.config.nonceGenerator,
        );
    }
  }
}
