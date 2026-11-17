import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/crypto/types/types.dart';
import 'package:on_chain/icp/src/crypto/utils/utils.dart';
import 'package:on_chain/icp/src/service/http/http.dart';
import 'package:on_chain/icp/src/utils/utils.dart';

/// HTTPS API version used in the path: `/api/{version}/canister/...`.
enum ICPApiVersion {
  /// Asynchronous call only (`/call`).
  ///
  /// Response is HTTP 202 Accepted or a pre-processing rejection body.
  /// Client must poll status via read_state.
  v2('v2'),

  /// Sync call (deprecated) + query + read_state.
  ///
  /// Prefer [v4] for new sync calls; [v3] remains common for query/read_state.
  v3('v3'),

  /// Current sync call + query + read_state.
  ///
  /// Sync `/call` may return a certificate in the HTTP response when the
  /// request finishes within the replica timeout.
  v4('v4');

  final String value;
  const ICPApiVersion(this.value);

  /// Recommended version for update/call endpoints.
  static ICPApiVersion forCall({bool synchronous = true}) =>
      synchronous ? v4 : v2;

  /// Recommended version for query endpoints.
  static ICPApiVersion forQuery() => v3;

  /// Recommended version for read_state endpoints.
  static ICPApiVersion forReadState() => v3;
}

/// Bundled request payload: content map, optional auth envelope, request id.
class ICPRequestContent {
  /// IC request content (`request_type`, `canister_id`, `method_name`, …).
  final ICPHttpContent content;

  /// Optional signed envelope (`sender_pubkey`, `sender_sig`, delegations).
  ///
  /// Null for anonymous requests.
  final ICPHttpEnvelope? envelope;

  /// Representation-independent hash of [content] (32-byte request id).
  ///
  /// Used for signing (`ic-request` domain) and for polling
  /// `/request_status/<id>`.
  final List<int>? id;

  ICPRequestContent({required this.content, this.envelope, List<int>? id})
    : id =
          id
              ?.exc(
                length: QuickCrypto.sha256DigestSize,
                operation: "Invalid id bytes length",
              )
              .asImmutableBytes;

  /// Builds content and ensures [id] is set (computes hash if omitted).
  factory ICPRequestContent.withId(ICPHttpContent content, {List<int>? id}) {
    return ICPRequestContent(
      content: content,
      id: id ?? ICPCryptoUtils.hashContent(content),
    );
  }
}

/// Shared options for building IC HTTP requests (auth, nonce, expiry, API version).
sealed class ICPRequestParams {
  /// Signer used to produce `sender_sig` (null → anonymous / no envelope).
  final ICPSigner? signer;

  /// Optional RNG for the `nonce` field in content.
  final Rng? nonce;

  /// Optional override for `ingress_expiry` (request lifetime).
  final Duration? ingressExpiry;

  /// API path version; null → method-specific default ([ICPApiVersion.forQuery], etc.).
  final ICPApiVersion? version;

  const ICPRequestParams({
    this.signer,
    this.nonce,
    this.ingressExpiry,
    this.version,
  });

  /// Next 32-byte nonce, or null if no [nonce] generator is configured.
  List<int>? getNonce() => nonce?.nextBytes(QuickCrypto.sha256DigestSize);
}

/// Parameters for a **query** request (`/api/{v}/canister/{id}/query`).
class ICPRequestQueryParams extends ICPRequestParams {
  /// Target canister (also used as effective canister id in the URL).
  final IcpPrincipalAddress canisterId;

  /// `sender` principal in the content map (anonymous or authenticated).
  final IcpPrincipalAddress sender;

  const ICPRequestQueryParams({
    required this.canisterId,
    required this.sender,
    super.signer,
    super.nonce,
    super.ingressExpiry,
    super.version,
  });

  /// Signed query: [signer] must match [sender].
  factory ICPRequestQueryParams.sign({
    required IcpPrincipalAddress canisterId,
    required IcpPrincipalAddress sender,
    required ICPSigner signer,
    Rng? nonce,
    Duration? ingressExpiry,
    ICPApiVersion? version,
  }) {
    return ICPRequestQueryParams(
      canisterId: canisterId,
      sender: sender,
      signer: signer,
      nonce: nonce ?? nonce,
      ingressExpiry: ingressExpiry,
      version: version,
    );
  }

  /// Anonymous query (`sender` = anonymous principal, no envelope).
  factory ICPRequestQueryParams.anonymous(
    IcpPrincipalAddress canisterId, {
    ICPApiVersion? version,
    Rng? nonce,
    Duration? ingressExpiry,
  }) {
    return ICPRequestQueryParams(
      canisterId: canisterId,
      sender: IcpPrincipalAddress.anonymous,
      version: version,
      nonce: nonce,
      ingressExpiry: ingressExpiry,
    );
  }

  /// Path segment: `/api/{version}/canister/{canisterId}/query`.
  String path() => ICPUtils.generateCanisterPath(
    canisterId: canisterId,
    type: ICPHttpRequestType.query,
    version: version ?? ICPApiVersion.forQuery(),
  );
}

/// Parameters for an **update/call** request (`/api/{v}/canister/{id}/call`).
class ICPRequestCallParams extends ICPRequestParams {
  /// Canister id placed in the content map (`canister_id` field).
  ///
  /// For management methods this is often `aaaaa-aa`.
  final IcpPrincipalAddress canisterId;

  /// Effective canister id in the URL path when it differs from [canisterId]
  /// (e.g. target canister for `install_code` on the management canister).
  final IcpPrincipalAddress? effectiveCanisterId;

  /// `sender` principal (must be a controller for most management methods).
  final IcpPrincipalAddress sender;

  const ICPRequestCallParams({
    required this.canisterId,
    required this.sender,
    this.effectiveCanisterId,
    super.signer,
    super.nonce,
    super.ingressExpiry,
    super.version,
  });

  /// Signed call; [effectiveCanisterId] overrides the path canister when set.
  factory ICPRequestCallParams.sign({
    required IcpPrincipalAddress canisterId,
    required IcpPrincipalAddress sender,
    required ICPSigner signer,
    IcpPrincipalAddress? effectiveCanisterId,
    Rng? nonce,
    Duration? ingressExpiry,
    ICPApiVersion? version,
  }) {
    return ICPRequestCallParams(
      canisterId: canisterId,
      sender: sender,
      signer: signer,
      nonce: nonce ?? nonce,
      ingressExpiry: ingressExpiry,
      version: version,
      effectiveCanisterId: effectiveCanisterId,
    );
  }

  /// Path: `/api/{version}/canister/{effectiveOrCanisterId}/call`.
  ///
  /// [synchronous] true → prefer v4; false → v2 (async, poll with read_state).
  String path({bool synchronous = true}) => ICPUtils.generateCanisterPath(
    canisterId: effectiveCanisterId ?? canisterId,
    type: ICPHttpRequestType.call,
    version: version ?? ICPApiVersion.forCall(synchronous: synchronous),
  );
}

/// Parameters for a **read_state** request (`/api/{v}/canister/{id}/read_state`).
///
/// Used to read the state tree (e.g. `/request_status/<id>`, `/time`, subnet info).
class ICPRequestReadStateParams extends ICPRequestParams {
  /// Effective canister id in the URL (must be consistent with requested paths).
  final IcpPrincipalAddress canisterId;

  /// `sender` of the read_state request (often same as the original call sender).
  final IcpPrincipalAddress sender;

  const ICPRequestReadStateParams({
    required this.canisterId,
    required this.sender,
    super.signer,
    super.nonce,
    super.ingressExpiry,
    super.version,
  });

  /// Signed read_state.
  factory ICPRequestReadStateParams.sign({
    required IcpPrincipalAddress canisterId,
    required IcpPrincipalAddress sender,
    required ICPSigner signer,
    Rng? nonce,
    Duration? ingressExpiry,
    ICPApiVersion? version,
  }) {
    return ICPRequestReadStateParams(
      canisterId: canisterId,
      sender: sender,
      signer: signer,
      nonce: nonce ?? nonce,
      ingressExpiry: ingressExpiry,
      version: version,
    );
  }

  /// Anonymous read_state.
  factory ICPRequestReadStateParams.anonymous(
    IcpPrincipalAddress canisterId, {
    ICPApiVersion? version,
    Rng? nonce,
    Duration? ingressExpiry,
  }) {
    return ICPRequestReadStateParams(
      canisterId: canisterId,
      sender: IcpPrincipalAddress.anonymous,
      version: version,
      nonce: nonce,
      ingressExpiry: ingressExpiry,
    );
  }

  /// Path: `/api/{version}/canister/{canisterId}/read_state`.
  String path() => ICPUtils.generateCanisterPath(
    canisterId: canisterId,
    type: ICPHttpRequestType.readState,
    version: version ?? ICPApiVersion.forReadState(),
  );
}
