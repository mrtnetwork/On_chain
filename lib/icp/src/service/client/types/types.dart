import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/icp/src/address/address.dart';
import 'package:on_chain/icp/src/crypto/types/types.dart';

class ICPNetworkConfig {
  /// ICP Ledger canister
  final IcpPrincipalAddress ledgerCanisterId;

  /// Cycles Ledger canister
  final IcpPrincipalAddress cyclesLedgerCanisterId;

  /// Cycles Minting Canister (CMC)
  final IcpPrincipalAddress cyclesMintingCanisterId;

  /// Internet Identity canister
  final IcpPrincipalAddress internetIdentityCanisterId;

  /// NNS Root canister
  final IcpPrincipalAddress nnsRootCanisterId;

  /// SNS-Wasm canister
  final IcpPrincipalAddress snsWasmCanisterId;

  /// Management canister (aaaaa-aa)
  /// This is special and not a normal installed canister.
  final IcpPrincipalAddress managementCanisterId;

  const ICPNetworkConfig({
    required this.ledgerCanisterId,
    required this.cyclesLedgerCanisterId,
    required this.cyclesMintingCanisterId,
    required this.internetIdentityCanisterId,
    required this.nnsRootCanisterId,
    required this.snsWasmCanisterId,
    required this.managementCanisterId,
  });

  /// NNS Governance canister (rrkah-fqaaa-aaaaa-aaaaq-cai).
  /// Neuron staking accounts live under this canister with staking subaccounts.
  static const IcpPrincipalAddress governanceCanisterId =
      IcpPrincipalAddress.unsafe("rrkah-fqaaa-aaaaa-aaaaq-cai");

  static const ICPNetworkConfig defaultConfig = ICPNetworkConfig(
    ledgerCanisterId: IcpPrincipalAddress.unsafe("ryjl3-tyaaa-aaaaa-aaaba-cai"),

    cyclesLedgerCanisterId: IcpPrincipalAddress.unsafe(
      "um5iw-rqaaa-aaaaq-qaaba-cai",
    ),

    cyclesMintingCanisterId: IcpPrincipalAddress.unsafe(
      "rkp4c-7iaaa-aaaaa-aaaca-cai",
    ),

    internetIdentityCanisterId: IcpPrincipalAddress.unsafe(
      "rdmx6-jaaaa-aaaaa-aaadq-cai",
    ),

    nnsRootCanisterId: IcpPrincipalAddress.unsafe(
      "rrkah-fqaaa-aaaaa-aaaaq-cai",
    ),

    snsWasmCanisterId: IcpPrincipalAddress.unsafe(
      "qaa6y-5yaaa-aaaaa-aaafa-cai",
    ),

    managementCanisterId: IcpPrincipalAddress.unsafe("aaaaa-aa"),
  );
}

/// Configuration for building request parameters (nonce, ingress expiry, etc.).
class ICPCreateParamsConfig {
  /// Optional custom nonce generator.
  ///
  /// If null, the client uses its default RNG when a nonce is required
  /// (e.g. for signed requests).
  final Rng? nonceGenerator;

  /// How long a request remains valid after creation.
  ///
  /// Maps to the IC `ingress_expiry` field (nanoseconds since Unix epoch).
  /// If null, a library default (e.g. now + 5 minutes) is used.
  final Duration? ingressExpiry;

  const ICPCreateParamsConfig({this.nonceGenerator, this.ingressExpiry});
}

/// Strategy for how **query** calls are authenticated.
sealed class ICPQueryStrategy {}

/// Query calls are sent as the anonymous principal (`2vxsx-fae`).
///
/// No signature is attached. Suitable for public read-only methods.
class ICPQueryStrategyAnonymous implements ICPQueryStrategy {
  const ICPQueryStrategyAnonymous();
}

/// Query calls are signed with the given identity.
///
/// [signer] produces a signing callback for [address];
class ICPQueryStrategySigning implements ICPQueryStrategy {
  /// Factory that returns a signer for the given principal.
  final CbICPSigner signer;

  /// Principal used as `sender` in the query content map.
  final IcpPrincipalAddress address;

  const ICPQueryStrategySigning({required this.signer, required this.address});
}

/// Strategy for how **update / call** requests are authenticated.
sealed class ICPCallStrategy {}

/// Update calls are disabled.
///
/// Any attempt to create call params throws (useful for read-only clients).
class ICPCallStrategyDisable implements ICPCallStrategy {
  const ICPCallStrategyDisable();
}

/// Update calls are signed with the given identity.
///
/// Same pattern as [ICPQueryStrategySigning], but applied to `/call`.
class ICPCallStrategySigning implements ICPCallStrategy {
  final CbICPSigner signer;
  final IcpPrincipalAddress address;

  const ICPCallStrategySigning({required this.signer, required this.address});
}

/// Strategy for verifying query / certificate responses from the IC.
sealed class ICPResponseVerificationStrategy {}

/// Never verify responses (skip certificate and node signatures).
///
/// Fast but unsafe on mainnet; mainly for local replica / tests.
class ICPResponseVerificationStrategyNever
    implements ICPResponseVerificationStrategy {
  const ICPResponseVerificationStrategyNever();
}

/// Always verify every response (certificate + optional node signatures).
///
/// Uses the network root key (from `/api/v2/status`) and optional
/// custom BLS / Ed25519 verification hooks.
class ICPResponseVerificationStrategyAlways
    implements ICPResponseVerificationStrategy {
  /// Optional custom BLS verification key resolver.
  ///
  /// If null, the default BLS verifier and root key from status are used.
  final CbBlsVerificationKey? verificationKey;

  /// Optional Ed25519 verification callback (e.g. for node signatures).
  final CbED25519Verification? ed25519verificationCallback;

  const ICPResponseVerificationStrategyAlways({
    this.verificationKey,
    this.ed25519verificationCallback,
  });
}

/// Verify the first successful response per canister, then trust later ones.
///
/// Caches a successful verification in the client so subsequent queries
/// to the same canister skip full cert checks (trade-off: speed vs strictness).
class ICPResponseVerificationStrategyOncePerCanister
    extends ICPResponseVerificationStrategyAlways {
  const ICPResponseVerificationStrategyOncePerCanister({
    super.verificationKey,
    super.ed25519verificationCallback,
  });
}

/// Top-level client configuration: network, auth strategies, verification.
class ICPClientConfig {
  /// Nonce / ingress-expiry defaults for built requests.
  final ICPCreateParamsConfig config;

  /// Target network config.
  final ICPNetworkConfig network;

  /// How query requests are authenticated (anonymous vs signed).
  final ICPQueryStrategy queryStrategy;

  /// How update (call) requests are authenticated (or disabled).
  final ICPCallStrategy callStrategy;

  /// How read_state requests are authenticated (same shape as query strategy).
  final ICPQueryStrategy readStateStrategy;

  /// Whether and how to verify IC certificates / query signatures.
  final ICPResponseVerificationStrategy verificationStrategy;

  const ICPClientConfig({
    required this.callStrategy,
    required this.network,
    this.config = const ICPCreateParamsConfig(),
    this.queryStrategy = const ICPQueryStrategyAnonymous(),
    this.readStateStrategy = const ICPQueryStrategyAnonymous(),
    this.verificationStrategy =
        const ICPResponseVerificationStrategyOncePerCanister(),
  });
}
