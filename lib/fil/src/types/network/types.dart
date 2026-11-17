import 'package:blockchain_utils/chain/address/address.dart';

import 'package:blockchain_utils/helper/extensions/extensions.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/fil/src/crypto/cid/cid.dart';

import 'constants.dart';

enum FilActorVersion implements Comparable<FilActorVersion> {
  v8,
  v9,
  v10,
  v11,
  v12,
  v13,
  v14,
  v15,
  v16,
  v17,
  v18,
  v19;

  @override
  int compareTo(FilActorVersion other) {
    return index.compareTo(other.index);
  }
}

enum FilActorNames { multisig, paymentchannel }

abstract class FilActorSupportedMethods {}

enum FilMultisigSupportedMethods implements FilActorSupportedMethods {
  construct,
  propose,
  approve,
  approveV2,
  cancel,
  cancelV2,
  addSigner,
  removeSigner,
  swapSigner,
  changeNumApprovalsThreshold,
  lockBalance,
  fallback,
}

enum FilPaychSupportedMethods implements FilActorSupportedMethods {
  construct,
  updateChannelState,
  settle,
  collect,
  fallback,
}

class FilActorCid {
  final Cid cid;
  final FilActorVersion version;
  final List<FilActorSupportedMethods> supportedMethods;

  const FilActorCid({
    required this.cid,
    required this.version,
    this.supportedMethods = const [],
  });
}

class FilNetworkActorConfig {
  final Map<FilActorNames, List<FilActorCid>> actors;
  const FilNetworkActorConfig({required this.actors});
}

/// Network-specific configuration used by the high-level API.
///
/// Holds the address network prefix ([FilNetwork]) and the set of known
/// built-in actor code CIDs for that network ([FilNetworkActorConfig]).
///
/// Use [FilNetworkConfig.calibrationnet] for the public testnet or construct
/// your own instance for mainnet / custom nets.
class FilNetworkConfig {
  /// Address network (mainnet vs testnet prefix).
  final FilNetwork network;

  /// Mapping of actor name → list of supported code CIDs (by version).
  final FilNetworkActorConfig actorConfig;

  const FilNetworkConfig({required this.network, required this.actorConfig});

  /// Pre-configured Calibration testnet.
  static const FilNetworkConfig calibrationnet = FilNetworkConfig(
    network: FilNetwork.testnet,
    actorConfig: FilNetworkConst.calibrationnet,
  );

  /// Pre-configured Filecoin mainnet.
  static const FilNetworkConfig mainnet = FilNetworkConfig(
    network: FilNetwork.mainnet,
    actorConfig: FilNetworkConst.mainnet,
  );

  /// Returns the highest-version code CID registered for [actor].
  FilActorCid getLatestActor(FilActorNames actor) {
    final List<FilActorCid> cids =
        (actorConfig.actors[actor] ?? []).clone()
          ..sort((a, b) => a.version.compareTo(b.version));
    final latest = cids.lastOrNull;
    if (latest == null) {
      throw OnChainErrors.filPlugin(
        "getLatestActor",
        reason: "Unsupported ${actor.name} actor: no code CID registered.",
      );
    }
    return latest;
  }

  /// Validates that [cid] is a known code CID for [actor] and returns it.
  FilActorCid getSupportedCid(FilActorNames actor, Cid cid) {
    final List<FilActorCid> cids = actorConfig.actors[actor] ?? [];
    return cids.firstWhere(
      (e) => e.cid == cid,
      orElse:
          () =>
              throw OnChainErrors.filPlugin(
                "getSupportedCid",
                reason: "Unsupported ${actor.name} actor CID.",
                details: {"cid": cid.cid, "actor": actor.name},
              ),
    );
  }
}
