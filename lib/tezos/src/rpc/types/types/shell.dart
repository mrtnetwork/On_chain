// GENERATED CODE - DO NOT MODIFY BY HAND
// Source: OpenAPI 3.0.0
// Octez RPC Octez 25.1 (04d849eb)

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/exception/onchain_error.dart';

typedef OctezShellBls12381Signature = OctezShellUnistring;

typedef OctezShellBls12381PublicKey = OctezShellUnistring;

typedef OctezShellBls12381PublicKeyHash = OctezShellUnistring;

typedef OctezShellCryptoBoxPublicKeyHash = OctezShellUnistring;

typedef OctezShellBlockHash = OctezShellUnistring;

/// Decimal representation of 64 bit integers
typedef OctezShellInt64 = String;

/// Free-form JSON object (OpenAPI schema `error` had no type).
typedef OctezShellError = Map<String, dynamic>;

typedef OctezShellProtocolHash = OctezShellUnistring;

/// A span of time, as seen by the local computer.
typedef OctezShellTimespanSystem = num;

/// A timestamp as seen by the protocol: second-level precision, epoch based.
typedef OctezShellTimestampProtocol = OctezShellUnistring;

/// A name for the distributed DB protocol
typedef OctezShellDistributedDbVersionName = OctezShellUnistring;

/// User activated upgrades: at given level, switch to given protocol.
typedef OctezShellUserActivatedUpgrades =
    List<OctezShellUserActivatedUpgradesItem>;

/// User activated protocol overrides: activate a protocol instead of another.
typedef OctezShellUserActivatedProtocolOverrides =
    List<OctezShellUserActivatedProtocolOverridesItem>;

typedef OctezShellProtocolEnvironmentVersion = int;

typedef OctezShellChainId = OctezShellUnistring;

typedef OctezShellOperationListListHash = OctezShellUnistring;

/// The fitness, or score, of a block, that allows Tezos to decide which chain is best. A fitness value is a list of byte sequences. They are compared as follows: shortest lists are smaller; lists of the same length are compared according to lexicographical order.
typedef OctezShellFitness = List<String>;

typedef OctezShellContextHash = OctezShellUnistring;

/// An address for locating peers.
typedef OctezShellP2pAddress = OctezShellUnistring;

/// A version number for the distributed DB protocol
typedef OctezShellDistributedDbVersion = int;

/// A version number for the p2p layer.
typedef OctezShellP2pVersion = int;

/// Decimal representation of a big number
typedef OctezShellBignum = String;

/// A date in RFC 3339 notation.
typedef OctezShellTimestampRfc = OctezShellUnistring;

/// Identifier for a peer point
typedef OctezShellP2pPointId = OctezShellUnistring;

/// Events happening during maintenance of and operations on a peer point pool (such as connections, disconnections, connection requests).
typedef OctezShellP2pPointPoolEvent = List<OctezShellP2pPointPoolEventItem>;

/// Backends encoding
typedef OctezShellBackendsEncoding =
    List<List<OctezShellBackendsEncodingItemItem>>;

typedef OctezShellOperationHash = OctezShellUnistring;

/// Either a plain UTF8 string, or a sequence of bytes for strings that contain invalid byte sequences.
sealed class OctezShellUnistring {
  const OctezShellUnistring();

  factory OctezShellUnistring.fromJson(dynamic json) {
    if (json is String) return OctezShellUnistringStringValue(json);
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('invalid_utf8_string')) {
        return OctezShellUnistringInvalidUtf8String.fromJson(map);
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezShellUnistring',
      reason: 'Cannot parse OctezShellUnistring from $json',
    );
  }

  dynamic toJson();
}

class OctezShellUnistringStringValue extends OctezShellUnistring {
  final String value;
  const OctezShellUnistringStringValue(this.value);

  @override
  dynamic toJson() => value;
}

class OctezShellUnistringInvalidUtf8String extends OctezShellUnistring {
  final BuBytes invalidUtf8String;

  OctezShellUnistringInvalidUtf8String({required List<int> invalidUtf8String})
    : invalidUtf8String = invalidUtf8String.asImmutableBytes;

  factory OctezShellUnistringInvalidUtf8String.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellUnistringInvalidUtf8String(
      invalidUtf8String: json.valueAsList<List<int>>('invalid_utf8_string'),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'invalid_utf8_string': invalidUtf8String,
      }.notNullValue.cast<String, dynamic>();
}

/// If 'unsynced', the node is not currently synchronized with its peers (it is probably still bootstrapping and its head is lagging behind the chain's).
/// If 'synced', the node considers itself synchronized with its peers and the current head timestamp is recent.
/// If 'stuck', the node considers itself synchronized with its peers but the chain seems to be halted from its viewpoint.
enum OctezShellChainStatus {
  stuck("stuck"),
  synced("synced"),
  unsynced("unsynced");

  final String value;
  const OctezShellChainStatus(this.value);

  static OctezShellChainStatus fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellChainStatus.",
              ),
    );
  }

  String toJson() => value;
}

sealed class OctezShellResponseConfigRpcAclItem {
  const OctezShellResponseConfigRpcAclItem();

  factory OctezShellResponseConfigRpcAclItem.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('address') && map.hasValue('whitelist')) {
        return OctezShellResponseConfigRpcAclItemWhitelist.fromJson(map);
      }
      if (map.hasValue('address') && map.hasValue('blacklist')) {
        return OctezShellResponseConfigRpcAclItemBlacklist.fromJson(map);
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezShellResponseConfigRpcAclItem',
      reason: 'Cannot parse OctezShellResponseConfigRpcAclItem from $json',
    );
  }

  dynamic toJson();
}

class OctezShellResponseConfigRpcAclItemWhitelist
    extends OctezShellResponseConfigRpcAclItem {
  final OctezShellUnistring address;
  final List<OctezShellUnistring> whitelist;

  const OctezShellResponseConfigRpcAclItemWhitelist({
    required this.address,
    required this.whitelist,
  });

  factory OctezShellResponseConfigRpcAclItemWhitelist.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseConfigRpcAclItemWhitelist(
      address: OctezShellUnistring.fromJson(json['address']),
      whitelist:
          json
              .valueEnsureAsList<dynamic>('whitelist')
              .map((e) => OctezShellUnistring.fromJson(e))
              .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'address': address.toJson(),
        'whitelist': whitelist.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseConfigRpcAclItemBlacklist
    extends OctezShellResponseConfigRpcAclItem {
  final OctezShellUnistring address;
  final List<OctezShellUnistring> blacklist;

  const OctezShellResponseConfigRpcAclItemBlacklist({
    required this.address,
    required this.blacklist,
  });

  factory OctezShellResponseConfigRpcAclItemBlacklist.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseConfigRpcAclItemBlacklist(
      address: OctezShellUnistring.fromJson(json['address']),
      blacklist:
          json
              .valueEnsureAsList<dynamic>('blacklist')
              .map((e) => OctezShellUnistring.fromJson(e))
              .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'address': address.toJson(),
        'blacklist': blacklist.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

/// The media types supported by the server.
enum OctezShellResponseConfigRpcMediaType {
  json("json"),
  any("any"),
  binary("binary");

  final String value;
  const OctezShellResponseConfigRpcMediaType(this.value);

  static OctezShellResponseConfigRpcMediaType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseConfigRpcMediaType.",
              ),
    );
  }

  String toJson() => value;
}

/// The maximum allowed number of RPC connections
sealed class OctezShellMaxActiveRpcConnections {
  const OctezShellMaxActiveRpcConnections();

  factory OctezShellMaxActiveRpcConnections.fromJson(dynamic json) {
    if (json is String) {
      return switch (json) {
        'unlimited' => const OctezShellMaxActiveRpcConnectionsUnlimited(),
        _ =>
          throw OnChainErrors.tezosPlugin(
            'OctezShellMaxActiveRpcConnections',
            reason: 'Unknown OctezShellMaxActiveRpcConnections: $json',
          ),
      };
    }
    if (json is num) {
      return OctezShellMaxActiveRpcConnectionsLimited(json.toInt());
    }
    throw OnChainErrors.tezosPlugin(
      'OctezShellMaxActiveRpcConnections',
      reason: 'Cannot parse OctezShellMaxActiveRpcConnections from $json',
    );
  }

  dynamic toJson();
}

class OctezShellMaxActiveRpcConnectionsUnlimited
    extends OctezShellMaxActiveRpcConnections {
  const OctezShellMaxActiveRpcConnectionsUnlimited();

  @override
  String toJson() => 'unlimited';
}

class OctezShellMaxActiveRpcConnectionsLimited
    extends OctezShellMaxActiveRpcConnections {
  final int value;
  const OctezShellMaxActiveRpcConnectionsLimited(this.value);

  @override
  dynamic toJson() => value;
}

sealed class OctezShellResponseConfigP2pLimitsMaxKnownPointsItem {
  const OctezShellResponseConfigP2pLimitsMaxKnownPointsItem();

  factory OctezShellResponseConfigP2pLimitsMaxKnownPointsItem.fromJson(
    dynamic json,
  ) {
    if (json is num) {
      return OctezShellResponseConfigP2pLimitsMaxKnownPointsItemInteger(
        json.toInt(),
      );
    }
    if (json is num) {
      return OctezShellResponseConfigP2pLimitsMaxKnownPointsItemInteger2(
        json.toInt(),
      );
    }
    throw OnChainErrors.tezosPlugin(
      'OctezShellResponseConfigP2pLimitsMaxKnownPointsItem',
      reason:
          'Cannot parse OctezShellResponseConfigP2pLimitsMaxKnownPointsItem from $json',
    );
  }

  dynamic toJson();
}

class OctezShellResponseConfigP2pLimitsMaxKnownPointsItemInteger
    extends OctezShellResponseConfigP2pLimitsMaxKnownPointsItem {
  final int value;
  const OctezShellResponseConfigP2pLimitsMaxKnownPointsItemInteger(this.value);

  @override
  dynamic toJson() => value;
}

class OctezShellResponseConfigP2pLimitsMaxKnownPointsItemInteger2
    extends OctezShellResponseConfigP2pLimitsMaxKnownPointsItem {
  final int value;
  const OctezShellResponseConfigP2pLimitsMaxKnownPointsItemInteger2(this.value);

  @override
  dynamic toJson() => value;
}

/// Verbosity level: one of 'fatal', 'error', 'warn','notice', 'info', 'debug'.
enum OctezShellResponseConfigLogLevel {
  info("info"),
  debug("debug"),
  error("error"),
  fatal("fatal"),
  warning("warning"),
  notice("notice");

  final String value;
  const OctezShellResponseConfigLogLevel(this.value);

  static OctezShellResponseConfigLogLevel fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseConfigLogLevel.",
              ),
    );
  }

  String toJson() => value;
}

/// Configuration of the structured logging framework
sealed class OctezShellResponseConfigInternalEvents {
  const OctezShellResponseConfigInternalEvents();

  factory OctezShellResponseConfigInternalEvents.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('active_sinks')) {
        return OctezShellResponseConfigInternalEventsActiveSinks.fromJson(map);
      }
      if (map.hasValue('activate')) {
        return OctezShellResponseConfigInternalEventsActiveSinksDeprecated.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezShellResponseConfigInternalEvents',
      reason: 'Cannot parse OctezShellResponseConfigInternalEvents from $json',
    );
  }

  dynamic toJson();
}

class OctezShellResponseConfigInternalEventsActiveSinks
    extends OctezShellResponseConfigInternalEvents {
  /// List of URIs to activate/configure sinks.
  final List<OctezShellUnistring>? activeSinks;

  const OctezShellResponseConfigInternalEventsActiveSinks({this.activeSinks});

  factory OctezShellResponseConfigInternalEventsActiveSinks.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseConfigInternalEventsActiveSinks(
      activeSinks:
          json.hasValue('active_sinks')
              ? json
                  .valueEnsureAsList<dynamic>('active_sinks')
                  .map((e) => OctezShellUnistring.fromJson(e))
                  .toList()
              : null,
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'active_sinks': activeSinks?.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseConfigInternalEventsActiveSinksDeprecated
    extends OctezShellResponseConfigInternalEvents {
  /// List of URIs to activate/configure sinks.
  final List<OctezShellUnistring>? activate;

  const OctezShellResponseConfigInternalEventsActiveSinksDeprecated({
    this.activate,
  });

  factory OctezShellResponseConfigInternalEventsActiveSinksDeprecated.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseConfigInternalEventsActiveSinksDeprecated(
      activate:
          json.hasValue('activate')
              ? json
                  .valueEnsureAsList<dynamic>('activate')
                  .map((e) => OctezShellUnistring.fromJson(e))
                  .toList()
              : null,
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'activate': activate?.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

/// The operation metadata size limit
sealed class OctezShellOperationMetadataSizeLimit {
  const OctezShellOperationMetadataSizeLimit();

  factory OctezShellOperationMetadataSizeLimit.fromJson(dynamic json) {
    if (json is String) {
      return switch (json) {
        'unlimited' => const OctezShellOperationMetadataSizeLimitUnlimited(),
        _ =>
          throw OnChainErrors.tezosPlugin(
            'OctezShellOperationMetadataSizeLimit',
            reason: 'Unknown OctezShellOperationMetadataSizeLimit: $json',
          ),
      };
    }
    if (json is num) {
      return OctezShellOperationMetadataSizeLimitLimited(json.toInt());
    }
    throw OnChainErrors.tezosPlugin(
      'OctezShellOperationMetadataSizeLimit',
      reason: 'Cannot parse OctezShellOperationMetadataSizeLimit from $json',
    );
  }

  dynamic toJson();
}

class OctezShellOperationMetadataSizeLimitUnlimited
    extends OctezShellOperationMetadataSizeLimit {
  const OctezShellOperationMetadataSizeLimitUnlimited();

  @override
  String toJson() => 'unlimited';
}

class OctezShellOperationMetadataSizeLimitLimited
    extends OctezShellOperationMetadataSizeLimit {
  final int value;
  const OctezShellOperationMetadataSizeLimitLimited(this.value);

  @override
  dynamic toJson() => value;
}

sealed class OctezShellResponseConfigShellChainValidator {
  const OctezShellResponseConfigShellChainValidator();

  factory OctezShellResponseConfigShellChainValidator.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('latency') &&
          map.hasValue('synchronisation_threshold')) {
        return OctezShellResponseConfigShellChainValidatorSynchronisationHeuristicEncoding.fromJson(
          map,
        );
      }
      if (map.hasValue('bootstrap_threshold')) {
        return OctezShellResponseConfigShellChainValidatorLegacyBootstrapThresholdEncoding.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezShellResponseConfigShellChainValidator',
      reason:
          'Cannot parse OctezShellResponseConfigShellChainValidator from $json',
    );
  }

  dynamic toJson();
}

class OctezShellResponseConfigShellChainValidatorSynchronisationHeuristicEncoding
    extends OctezShellResponseConfigShellChainValidator {
  /// [latency] is the time interval (in seconds) used to determine if a peer is synchronized with a chain. For instance, a peer whose known head has a timestamp T is considered synchronized if T >= now - latency. This parameter depends on the baking rate and the latency of the network.
  final int? latency;

  /// The minimal number of peers this peer should be synchronized with in order to be bootstrapped.
  final int? synchronisationThreshold;

  const OctezShellResponseConfigShellChainValidatorSynchronisationHeuristicEncoding({
    this.latency,
    this.synchronisationThreshold,
  });

  factory OctezShellResponseConfigShellChainValidatorSynchronisationHeuristicEncoding.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseConfigShellChainValidatorSynchronisationHeuristicEncoding(
      latency: json.valueAsInt('latency'),
      synchronisationThreshold: json.valueAsInt('synchronisation_threshold'),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'latency': latency,
        'synchronisation_threshold': synchronisationThreshold,
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseConfigShellChainValidatorLegacyBootstrapThresholdEncoding
    extends OctezShellResponseConfigShellChainValidator {
  /// [DEPRECATED] Set the number of peers with whom a chain synchronisation must be completed to bootstrap the node.
  final int? bootstrapThreshold;

  const OctezShellResponseConfigShellChainValidatorLegacyBootstrapThresholdEncoding({
    this.bootstrapThreshold,
  });

  factory OctezShellResponseConfigShellChainValidatorLegacyBootstrapThresholdEncoding.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseConfigShellChainValidatorLegacyBootstrapThresholdEncoding(
      bootstrapThreshold: json.valueAsInt('bootstrap_threshold'),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'bootstrap_threshold': bootstrapThreshold,
      }.notNullValue.cast<String, dynamic>();
}

/// Storage mode for the Tezos shell.
sealed class OctezShellHistoryMode {
  const OctezShellHistoryMode();

  factory OctezShellHistoryMode.fromJson(dynamic json) {
    if (json is String) {
      return switch (json) {
        'archive' => const OctezShellHistoryModeArchive(),
        'full' => const OctezShellHistoryModeFull2(),
        'rolling' => const OctezShellHistoryModeRolling2(),
        _ =>
          throw OnChainErrors.tezosPlugin(
            'OctezShellHistoryMode',
            reason: 'Unknown OctezShellHistoryMode: $json',
          ),
      };
    }
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('full')) {
        return OctezShellHistoryModeFull.fromJson(map);
      }
      if (map.hasValue('rolling')) {
        return OctezShellHistoryModeRolling.fromJson(map);
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezShellHistoryMode',
      reason: 'Cannot parse OctezShellHistoryMode from $json',
    );
  }

  dynamic toJson();
}

class OctezShellHistoryModeArchive extends OctezShellHistoryMode {
  const OctezShellHistoryModeArchive();

  @override
  String toJson() => 'archive';
}

class OctezShellHistoryModeFull extends OctezShellHistoryMode {
  final OctezShellHistoryModeFullFull full;

  const OctezShellHistoryModeFull({required this.full});

  factory OctezShellHistoryModeFull.fromJson(Map<String, dynamic> json) {
    return OctezShellHistoryModeFull(
      full: json.valueTo<OctezShellHistoryModeFullFull, Map<String, dynamic>>(
        key: 'full',
        parse: (v) => OctezShellHistoryModeFullFull.fromJson(v),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'full': full.toJson()}.notNullValue.cast<String, dynamic>();
}

class OctezShellHistoryModeRolling extends OctezShellHistoryMode {
  final OctezShellHistoryModeFullFull rolling;

  const OctezShellHistoryModeRolling({required this.rolling});

  factory OctezShellHistoryModeRolling.fromJson(Map<String, dynamic> json) {
    return OctezShellHistoryModeRolling(
      rolling: json
          .valueTo<OctezShellHistoryModeFullFull, Map<String, dynamic>>(
            key: 'rolling',
            parse: (v) => OctezShellHistoryModeFullFull.fromJson(v),
          ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'rolling': rolling.toJson()}.notNullValue.cast<String, dynamic>();
}

class OctezShellHistoryModeFull2 extends OctezShellHistoryMode {
  const OctezShellHistoryModeFull2();

  @override
  String toJson() => 'full';
}

class OctezShellHistoryModeRolling2 extends OctezShellHistoryMode {
  const OctezShellHistoryModeRolling2();

  @override
  String toJson() => 'rolling';
}

/// Delay prior to the storage maintenance trigger
sealed class OctezShellStorageMaintenanceDelay {
  const OctezShellStorageMaintenanceDelay();

  factory OctezShellStorageMaintenanceDelay.fromJson(dynamic json) {
    if (json is String) {
      return switch (json) {
        'disabled' => const OctezShellStorageMaintenanceDelayDisabled(),
        'auto' => const OctezShellStorageMaintenanceDelayAuto(),
        _ =>
          throw OnChainErrors.tezosPlugin(
            'OctezShellStorageMaintenanceDelay',
            reason: 'Unknown OctezShellStorageMaintenanceDelay: $json',
          ),
      };
    }
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('custom')) {
        return OctezShellStorageMaintenanceDelayCustom.fromJson(map);
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezShellStorageMaintenanceDelay',
      reason: 'Cannot parse OctezShellStorageMaintenanceDelay from $json',
    );
  }

  dynamic toJson();
}

class OctezShellStorageMaintenanceDelayDisabled
    extends OctezShellStorageMaintenanceDelay {
  const OctezShellStorageMaintenanceDelayDisabled();

  @override
  String toJson() => 'disabled';
}

class OctezShellStorageMaintenanceDelayCustom
    extends OctezShellStorageMaintenanceDelay {
  final int custom;

  const OctezShellStorageMaintenanceDelayCustom({required this.custom});

  factory OctezShellStorageMaintenanceDelayCustom.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellStorageMaintenanceDelayCustom(
      custom: json.valueAsInt('custom'),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'custom': custom}.notNullValue.cast<String, dynamic>();
}

class OctezShellStorageMaintenanceDelayAuto
    extends OctezShellStorageMaintenanceDelay {
  const OctezShellStorageMaintenanceDelayAuto();

  @override
  String toJson() => 'auto';
}

/// Configuration of which network/blockchain to connect to
sealed class OctezShellResponseConfigNetwork {
  const OctezShellResponseConfigNetwork();

  factory OctezShellResponseConfigNetwork.fromJson(dynamic json) {
    if (json is String) {
      return switch (json) {
        'sandbox' => const OctezShellResponseConfigNetworkSandbox(),
        'mainnet' => const OctezShellResponseConfigNetworkMainnet(),
        'ghostnet' => const OctezShellResponseConfigNetworkGhostnet(),
        'shadownet' => const OctezShellResponseConfigNetworkShadownet(),
        _ =>
          throw OnChainErrors.tezosPlugin(
            'OctezShellResponseConfigNetwork',
            reason: 'Unknown OctezShellResponseConfigNetwork: $json',
          ),
      };
    }
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('genesis') &&
          map.hasValue('chain_name') &&
          map.hasValue('sandboxed_chain_name')) {
        return OctezShellResponseConfigNetworkCustom.fromJson(map);
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezShellResponseConfigNetwork',
      reason: 'Cannot parse OctezShellResponseConfigNetwork from $json',
    );
  }

  dynamic toJson();
}

class OctezShellResponseConfigNetworkSandbox
    extends OctezShellResponseConfigNetwork {
  const OctezShellResponseConfigNetworkSandbox();

  @override
  String toJson() => 'sandbox';
}

class OctezShellResponseConfigNetworkMainnet
    extends OctezShellResponseConfigNetwork {
  const OctezShellResponseConfigNetworkMainnet();

  @override
  String toJson() => 'mainnet';
}

class OctezShellResponseConfigNetworkGhostnet
    extends OctezShellResponseConfigNetwork {
  const OctezShellResponseConfigNetworkGhostnet();

  @override
  String toJson() => 'ghostnet';
}

class OctezShellResponseConfigNetworkShadownet
    extends OctezShellResponseConfigNetwork {
  const OctezShellResponseConfigNetworkShadownet();

  @override
  String toJson() => 'shadownet';
}

class OctezShellResponseConfigNetworkCustom
    extends OctezShellResponseConfigNetwork {
  final OctezShellResponseConfigNetworkCustomGenesis genesis;
  final OctezShellResponseConfigNetworkCustomGenesisParameters?
  genesisParameters;
  final OctezShellDistributedDbVersionName chainName;
  final OctezShellDistributedDbVersionName? oldChainName;
  final OctezShellDistributedDbVersionName? incompatibleChainName;
  final OctezShellDistributedDbVersionName sandboxedChainName;
  final OctezShellUserActivatedUpgrades? userActivatedUpgrades;
  final OctezShellUserActivatedProtocolOverrides?
  userActivatedProtocolOverrides;

  /// List of hosts to use if p2p.bootstrap_peers is unspecified.
  final List<OctezShellUnistring>? defaultBootstrapPeers;

  /// For testing purposes only. Configuration for the data-availability layer
  final OctezShellResponseConfigNetworkCustomDalConfig? dalConfig;

  const OctezShellResponseConfigNetworkCustom({
    required this.genesis,
    this.genesisParameters,
    required this.chainName,
    this.oldChainName,
    this.incompatibleChainName,
    required this.sandboxedChainName,
    this.userActivatedUpgrades,
    this.userActivatedProtocolOverrides,
    this.defaultBootstrapPeers,
    this.dalConfig,
  });

  factory OctezShellResponseConfigNetworkCustom.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseConfigNetworkCustom(
      genesis: json.valueTo<
        OctezShellResponseConfigNetworkCustomGenesis,
        Map<String, dynamic>
      >(
        key: 'genesis',
        parse: (v) => OctezShellResponseConfigNetworkCustomGenesis.fromJson(v),
      ),
      genesisParameters: json.valueTo<
        OctezShellResponseConfigNetworkCustomGenesisParameters?,
        Map<String, dynamic>
      >(
        key: 'genesis_parameters',
        parse:
            (v) =>
                OctezShellResponseConfigNetworkCustomGenesisParameters.fromJson(
                  v,
                ),
      ),
      chainName: OctezShellUnistring.fromJson(json['chain_name']),
      oldChainName:
          json.hasValue('old_chain_name')
              ? OctezShellUnistring.fromJson(json['old_chain_name'])
              : null,
      incompatibleChainName:
          json.hasValue('incompatible_chain_name')
              ? OctezShellUnistring.fromJson(json['incompatible_chain_name'])
              : null,
      sandboxedChainName: OctezShellUnistring.fromJson(
        json['sandboxed_chain_name'],
      ),
      userActivatedUpgrades:
          json.hasValue('user_activated_upgrades')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>(
                    'user_activated_upgrades',
                  )
                  .map((e) => OctezShellUserActivatedUpgradesItem.fromJson(e))
                  .toList()
              : null,
      userActivatedProtocolOverrides:
          json.hasValue('user_activated_protocol_overrides')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>(
                    'user_activated_protocol_overrides',
                  )
                  .map(
                    (e) =>
                        OctezShellUserActivatedProtocolOverridesItem.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      defaultBootstrapPeers:
          json.hasValue('default_bootstrap_peers')
              ? json
                  .valueEnsureAsList<dynamic>('default_bootstrap_peers')
                  .map((e) => OctezShellUnistring.fromJson(e))
                  .toList()
              : null,
      dalConfig: json.valueTo<
        OctezShellResponseConfigNetworkCustomDalConfig?,
        Map<String, dynamic>
      >(
        key: 'dal_config',
        parse:
            (v) => OctezShellResponseConfigNetworkCustomDalConfig.fromJson(v),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'genesis': genesis.toJson(),
        'genesis_parameters': genesisParameters?.toJson(),
        'chain_name': chainName.toJson(),
        'old_chain_name': oldChainName?.toJson(),
        'incompatible_chain_name': incompatibleChainName?.toJson(),
        'sandboxed_chain_name': sandboxedChainName.toJson(),
        'user_activated_upgrades':
            userActivatedUpgrades?.map((e) => e.toJson()).toList(),
        'user_activated_protocol_overrides':
            userActivatedProtocolOverrides?.map((e) => e.toJson()).toList(),
        'default_bootstrap_peers':
            defaultBootstrapPeers?.map((e) => e.toJson()).toList(),
        'dal_config': dalConfig?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

sealed class OctezShellResponseMonitorActiveChainsItem {
  const OctezShellResponseMonitorActiveChainsItem();

  factory OctezShellResponseMonitorActiveChainsItem.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('chain_id') &&
          map.hasValue('test_protocol') &&
          map.hasValue('expiration_date')) {
        return OctezShellResponseMonitorActiveChainsItemTest.fromJson(map);
      }
      if (map.hasValue('stopping')) {
        return OctezShellResponseMonitorActiveChainsItemStopping.fromJson(map);
      }
      if (map.hasValue('chain_id')) {
        return OctezShellResponseMonitorActiveChainsItemMain.fromJson(map);
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezShellResponseMonitorActiveChainsItem',
      reason:
          'Cannot parse OctezShellResponseMonitorActiveChainsItem from $json',
    );
  }

  dynamic toJson();
}

class OctezShellResponseMonitorActiveChainsItemMain
    extends OctezShellResponseMonitorActiveChainsItem {
  final OctezShellChainId chainId;

  const OctezShellResponseMonitorActiveChainsItemMain({required this.chainId});

  factory OctezShellResponseMonitorActiveChainsItemMain.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseMonitorActiveChainsItemMain(
      chainId: OctezShellUnistring.fromJson(json['chain_id']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'chain_id': chainId.toJson()}.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseMonitorActiveChainsItemTest
    extends OctezShellResponseMonitorActiveChainsItem {
  final OctezShellChainId chainId;
  final OctezShellProtocolHash testProtocol;
  final OctezShellTimestampProtocol expirationDate;

  const OctezShellResponseMonitorActiveChainsItemTest({
    required this.chainId,
    required this.testProtocol,
    required this.expirationDate,
  });

  factory OctezShellResponseMonitorActiveChainsItemTest.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseMonitorActiveChainsItemTest(
      chainId: OctezShellUnistring.fromJson(json['chain_id']),
      testProtocol: OctezShellUnistring.fromJson(json['test_protocol']),
      expirationDate: OctezShellUnistring.fromJson(json['expiration_date']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'chain_id': chainId.toJson(),
        'test_protocol': testProtocol.toJson(),
        'expiration_date': expirationDate.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseMonitorActiveChainsItemStopping
    extends OctezShellResponseMonitorActiveChainsItem {
  final OctezShellChainId stopping;

  const OctezShellResponseMonitorActiveChainsItemStopping({
    required this.stopping,
  });

  factory OctezShellResponseMonitorActiveChainsItemStopping.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseMonitorActiveChainsItemStopping(
      stopping: OctezShellUnistring.fromJson(json['stopping']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'stopping': stopping.toJson()}.notNullValue.cast<String, dynamic>();
}

sealed class OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponsesSent {
  const OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponsesSent();

  factory OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponsesSent.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('branch') &&
          map.hasValue('head') &&
          map.hasValue('block_header') &&
          map.hasValue('operations') &&
          map.hasValue('protocols') &&
          map.hasValue('operation_hashes_for_block') &&
          map.hasValue('operations_for_block') &&
          map.hasValue('checkpoint') &&
          map.hasValue('protocol_branch') &&
          map.hasValue('predecessor_header') &&
          map.hasValue('other')) {
        return OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponsesSentPeerMetadataV1.fromJson(
          map,
        );
      }
      if (map.hasValue('branch') &&
          map.hasValue('head') &&
          map.hasValue('block_header') &&
          map.hasValue('operations') &&
          map.hasValue('protocols') &&
          map.hasValue('operation_hashes_for_block') &&
          map.hasValue('operations_for_block') &&
          map.hasValue('other')) {
        return OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponsesSentPeerMetadataLegacyV0.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponsesSent',
      reason:
          'Cannot parse OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponsesSent from $json',
    );
  }

  dynamic toJson();
}

class OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponsesSentPeerMetadataV1
    extends
        OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponsesSent {
  final OctezShellBignum branch;
  final OctezShellBignum head;
  final OctezShellBignum blockHeader;
  final OctezShellBignum operations;
  final OctezShellBignum protocols;
  final OctezShellBignum operationHashesForBlock;
  final OctezShellBignum operationsForBlock;
  final OctezShellBignum checkpoint;
  final OctezShellBignum protocolBranch;
  final OctezShellBignum predecessorHeader;
  final OctezShellBignum other;

  const OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponsesSentPeerMetadataV1({
    required this.branch,
    required this.head,
    required this.blockHeader,
    required this.operations,
    required this.protocols,
    required this.operationHashesForBlock,
    required this.operationsForBlock,
    required this.checkpoint,
    required this.protocolBranch,
    required this.predecessorHeader,
    required this.other,
  });

  factory OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponsesSentPeerMetadataV1.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponsesSentPeerMetadataV1(
      branch:
          (json['branch'] is num
              ? json['branch'].toString()
              : json.valueAsString('branch')),
      head:
          (json['head'] is num
              ? json['head'].toString()
              : json.valueAsString('head')),
      blockHeader:
          (json['block_header'] is num
              ? json['block_header'].toString()
              : json.valueAsString('block_header')),
      operations:
          (json['operations'] is num
              ? json['operations'].toString()
              : json.valueAsString('operations')),
      protocols:
          (json['protocols'] is num
              ? json['protocols'].toString()
              : json.valueAsString('protocols')),
      operationHashesForBlock:
          (json['operation_hashes_for_block'] is num
              ? json['operation_hashes_for_block'].toString()
              : json.valueAsString('operation_hashes_for_block')),
      operationsForBlock:
          (json['operations_for_block'] is num
              ? json['operations_for_block'].toString()
              : json.valueAsString('operations_for_block')),
      checkpoint:
          (json['checkpoint'] is num
              ? json['checkpoint'].toString()
              : json.valueAsString('checkpoint')),
      protocolBranch:
          (json['protocol_branch'] is num
              ? json['protocol_branch'].toString()
              : json.valueAsString('protocol_branch')),
      predecessorHeader:
          (json['predecessor_header'] is num
              ? json['predecessor_header'].toString()
              : json.valueAsString('predecessor_header')),
      other:
          (json['other'] is num
              ? json['other'].toString()
              : json.valueAsString('other')),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'branch': branch,
        'head': head,
        'block_header': blockHeader,
        'operations': operations,
        'protocols': protocols,
        'operation_hashes_for_block': operationHashesForBlock,
        'operations_for_block': operationsForBlock,
        'checkpoint': checkpoint,
        'protocol_branch': protocolBranch,
        'predecessor_header': predecessorHeader,
        'other': other,
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponsesSentPeerMetadataLegacyV0
    extends
        OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponsesSent {
  final OctezShellBignum branch;
  final OctezShellBignum head;
  final OctezShellBignum blockHeader;
  final OctezShellBignum operations;
  final OctezShellBignum protocols;
  final OctezShellBignum operationHashesForBlock;
  final OctezShellBignum operationsForBlock;
  final OctezShellBignum other;

  const OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponsesSentPeerMetadataLegacyV0({
    required this.branch,
    required this.head,
    required this.blockHeader,
    required this.operations,
    required this.protocols,
    required this.operationHashesForBlock,
    required this.operationsForBlock,
    required this.other,
  });

  factory OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponsesSentPeerMetadataLegacyV0.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponsesSentPeerMetadataLegacyV0(
      branch:
          (json['branch'] is num
              ? json['branch'].toString()
              : json.valueAsString('branch')),
      head:
          (json['head'] is num
              ? json['head'].toString()
              : json.valueAsString('head')),
      blockHeader:
          (json['block_header'] is num
              ? json['block_header'].toString()
              : json.valueAsString('block_header')),
      operations:
          (json['operations'] is num
              ? json['operations'].toString()
              : json.valueAsString('operations')),
      protocols:
          (json['protocols'] is num
              ? json['protocols'].toString()
              : json.valueAsString('protocols')),
      operationHashesForBlock:
          (json['operation_hashes_for_block'] is num
              ? json['operation_hashes_for_block'].toString()
              : json.valueAsString('operation_hashes_for_block')),
      operationsForBlock:
          (json['operations_for_block'] is num
              ? json['operations_for_block'].toString()
              : json.valueAsString('operations_for_block')),
      other:
          (json['other'] is num
              ? json['other'].toString()
              : json.valueAsString('other')),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'branch': branch,
        'head': head,
        'block_header': blockHeader,
        'operations': operations,
        'protocols': protocols,
        'operation_hashes_for_block': operationHashesForBlock,
        'operations_for_block': operationsForBlock,
        'other': other,
      }.notNullValue.cast<String, dynamic>();
}

/// The state a peer connection can be in: accepted (when the connection is being established), running (when the connection is already established), disconnected (otherwise).
enum OctezShellP2pPeerState {
  running("running"),
  accepted("accepted"),
  disconnected("disconnected");

  final String value;
  const OctezShellP2pPeerState(this.value);

  static OctezShellP2pPeerState fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellP2pPeerState.",
              ),
    );
  }

  String toJson() => value;
}

sealed class OctezShellTimestampSystemRFCEncodingValue {
  const OctezShellTimestampSystemRFCEncodingValue();

  factory OctezShellTimestampSystemRFCEncodingValue.fromJson(dynamic json) {
    throw OnChainErrors.tezosPlugin(
      'OctezShellTimestampSystemRFCEncodingValue',
      reason:
          'Cannot parse OctezShellTimestampSystemRFCEncodingValue from $json',
    );
  }

  dynamic toJson();
}

class OctezShellTimestampSystemRFCEncodingValueTimestampRfc
    extends OctezShellTimestampSystemRFCEncodingValue {
  final OctezShellTimestampRfc value;
  const OctezShellTimestampSystemRFCEncodingValueTimestampRfc(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class OctezShellTimestampSystemSecondSinceEpochValue {
  const OctezShellTimestampSystemSecondSinceEpochValue();

  factory OctezShellTimestampSystemSecondSinceEpochValue.fromJson(
    dynamic json,
  ) {
    if (json is String) {
      return OctezShellTimestampSystemSecondSinceEpochValueInt64(json);
    }
    throw OnChainErrors.tezosPlugin(
      'OctezShellTimestampSystemSecondSinceEpochValue',
      reason:
          'Cannot parse OctezShellTimestampSystemSecondSinceEpochValue from $json',
    );
  }

  dynamic toJson();
}

class OctezShellTimestampSystemSecondSinceEpochValueInt64
    extends OctezShellTimestampSystemSecondSinceEpochValue {
  final OctezShellInt64 value;
  const OctezShellTimestampSystemSecondSinceEpochValueInt64(this.value);

  @override
  dynamic toJson() => value;
}

/// A timestamp as seen by the underlying, local computer: subsecond-level precision, epoch or rfc3339 based.
sealed class OctezShellTimestampSystem {
  const OctezShellTimestampSystem();

  factory OctezShellTimestampSystem.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      try {
        return OctezShellTimestampSystemRFCEncoding(
          OctezShellTimestampSystemRFCEncodingValue.fromJson(map),
        );
      } catch (_) {}
      try {
        return OctezShellTimestampSystemSecondSinceEpoch(
          OctezShellTimestampSystemSecondSinceEpochValue.fromJson(map),
        );
      } catch (_) {}
    }
    try {
      return OctezShellTimestampSystemRFCEncoding(
        OctezShellTimestampSystemRFCEncodingValue.fromJson(json),
      );
    } catch (_) {}
    try {
      return OctezShellTimestampSystemSecondSinceEpoch(
        OctezShellTimestampSystemSecondSinceEpochValue.fromJson(json),
      );
    } catch (_) {}
    throw OnChainErrors.tezosPlugin(
      'OctezShellTimestampSystem',
      reason: 'Cannot parse OctezShellTimestampSystem from $json',
    );
  }

  dynamic toJson();
}

class OctezShellTimestampSystemRFCEncoding extends OctezShellTimestampSystem {
  final OctezShellTimestampSystemRFCEncodingValue value;
  const OctezShellTimestampSystemRFCEncoding(this.value);

  @override
  dynamic toJson() => value.toJson();
}

class OctezShellTimestampSystemSecondSinceEpoch
    extends OctezShellTimestampSystem {
  final OctezShellTimestampSystemSecondSinceEpochValue value;
  const OctezShellTimestampSystemSecondSinceEpoch(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItem {
  const OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItem();

  factory OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItem.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      try {
        return OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItemTimestampSystem(
          OctezShellTimestampSystem.fromJson(map),
        );
      } catch (_) {}
      try {
        return OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItemP2pConnectionId(
          OctezShellP2pConnectionId.fromJson(map),
        );
      } catch (_) {}
    }
    try {
      return OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItemTimestampSystem(
        OctezShellTimestampSystem.fromJson(json),
      );
    } catch (_) {}
    throw OnChainErrors.tezosPlugin(
      'OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItem',
      reason:
          'Cannot parse OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItem from $json',
    );
  }

  dynamic toJson();
}

class OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItemP2pConnectionId
    extends
        OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItem {
  final OctezShellP2pConnectionId value;
  const OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItemP2pConnectionId(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItemTimestampSystem
    extends
        OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItem {
  final OctezShellTimestampSystem value;
  const OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItemTimestampSystem(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

sealed class OctezShellResponseNetworkFullStatPeersItemItem {
  const OctezShellResponseNetworkFullStatPeersItemItem();

  factory OctezShellResponseNetworkFullStatPeersItemItem.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('score') &&
          map.hasValue('trusted') &&
          map.hasValue('peer_metadata') &&
          map.hasValue('state') &&
          map.hasValue('stat')) {
        return OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStat.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezShellResponseNetworkFullStatPeersItemItem',
      reason:
          'Cannot parse OctezShellResponseNetworkFullStatPeersItemItem from $json',
    );
  }

  dynamic toJson();
}

class OctezShellResponseNetworkFullStatPeersItemItemCryptoBoxPublicKeyHash
    extends OctezShellResponseNetworkFullStatPeersItemItem {
  final OctezShellCryptoBoxPublicKeyHash value;
  const OctezShellResponseNetworkFullStatPeersItemItemCryptoBoxPublicKeyHash(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStat
    extends OctezShellResponseNetworkFullStatPeersItemItem {
  final num score;
  final bool trusted;
  final OctezShellResponseNetworkConnectionsItemLocalMetadata? connMetadata;
  final OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadata
  peerMetadata;
  final OctezShellP2pPeerState state;
  final OctezShellP2pConnectionId? reachableAt;
  final OctezShellP2pStat stat;
  final List<
    OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItem
  >?
  lastFailedConnection;
  final List<
    OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItem
  >?
  lastRejectedConnection;
  final List<
    OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItem
  >?
  lastEstablishedConnection;
  final List<
    OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItem
  >?
  lastDisconnection;
  final List<
    OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItem
  >?
  lastSeen;
  final List<
    OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItem
  >?
  lastMiss;

  const OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStat({
    required this.score,
    required this.trusted,
    this.connMetadata,
    required this.peerMetadata,
    required this.state,
    this.reachableAt,
    required this.stat,
    this.lastFailedConnection,
    this.lastRejectedConnection,
    this.lastEstablishedConnection,
    this.lastDisconnection,
    this.lastSeen,
    this.lastMiss,
  });

  factory OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStat.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStat(
      score: json.valueAsNum('score'),
      trusted: json.valueAsBool('trusted'),
      connMetadata: json.valueTo<
        OctezShellResponseNetworkConnectionsItemLocalMetadata?,
        Map<String, dynamic>
      >(
        key: 'conn_metadata',
        parse:
            (v) =>
                OctezShellResponseNetworkConnectionsItemLocalMetadata.fromJson(
                  v,
                ),
      ),
      peerMetadata: json.valueTo<
        OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadata,
        Map<String, dynamic>
      >(
        key: 'peer_metadata',
        parse:
            (v) =>
                OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadata.fromJson(
                  v,
                ),
      ),
      state: OctezShellP2pPeerState.fromJson(json['state']),
      reachableAt: json
          .valueTo<OctezShellP2pConnectionId?, Map<String, dynamic>>(
            key: 'reachable_at',
            parse: (v) => OctezShellP2pConnectionId.fromJson(v),
          ),
      stat: json.valueTo<OctezShellP2pStat, Map<String, dynamic>>(
        key: 'stat',
        parse: (v) => OctezShellP2pStat.fromJson(v),
      ),
      lastFailedConnection:
          json.hasValue('last_failed_connection')
              ? json
                  .valueEnsureAsList<dynamic>('last_failed_connection')
                  .map(
                    (e) =>
                        OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItem.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      lastRejectedConnection:
          json.hasValue('last_rejected_connection')
              ? json
                  .valueEnsureAsList<dynamic>('last_rejected_connection')
                  .map(
                    (e) =>
                        OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItem.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      lastEstablishedConnection:
          json.hasValue('last_established_connection')
              ? json
                  .valueEnsureAsList<dynamic>('last_established_connection')
                  .map(
                    (e) =>
                        OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItem.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      lastDisconnection:
          json.hasValue('last_disconnection')
              ? json
                  .valueEnsureAsList<dynamic>('last_disconnection')
                  .map(
                    (e) =>
                        OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItem.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      lastSeen:
          json.hasValue('last_seen')
              ? json
                  .valueEnsureAsList<dynamic>('last_seen')
                  .map(
                    (e) =>
                        OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItem.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      lastMiss:
          json.hasValue('last_miss')
              ? json
                  .valueEnsureAsList<dynamic>('last_miss')
                  .map(
                    (e) =>
                        OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItem.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'score': score,
        'trusted': trusted,
        'conn_metadata': connMetadata?.toJson(),
        'peer_metadata': peerMetadata.toJson(),
        'state': state.toJson(),
        'reachable_at': reachableAt?.toJson(),
        'stat': stat.toJson(),
        'last_failed_connection':
            lastFailedConnection?.map((e) => e.toJson()).toList(),
        'last_rejected_connection':
            lastRejectedConnection?.map((e) => e.toJson()).toList(),
        'last_established_connection':
            lastEstablishedConnection?.map((e) => e.toJson()).toList(),
        'last_disconnection':
            lastDisconnection?.map((e) => e.toJson()).toList(),
        'last_seen': lastSeen?.map((e) => e.toJson()).toList(),
        'last_miss': lastMiss?.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

enum OctezShellP2pPointStateRequestedEventKind {
  requested("requested");

  final String value;
  const OctezShellP2pPointStateRequestedEventKind(this.value);

  static OctezShellP2pPointStateRequestedEventKind fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellP2pPointStateRequestedEventKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellP2pPointStateAcceptedEventKind {
  accepted("accepted");

  final String value;
  const OctezShellP2pPointStateAcceptedEventKind(this.value);

  static OctezShellP2pPointStateAcceptedEventKind fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellP2pPointStateAcceptedEventKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellP2pPointStateRunningEventKind {
  running("running");

  final String value;
  const OctezShellP2pPointStateRunningEventKind(this.value);

  static OctezShellP2pPointStateRunningEventKind fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellP2pPointStateRunningEventKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellP2pPointStateDisconnectedEventKind {
  disconnected("disconnected");

  final String value;
  const OctezShellP2pPointStateDisconnectedEventKind(this.value);

  static OctezShellP2pPointStateDisconnectedEventKind fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellP2pPointStateDisconnectedEventKind.",
              ),
    );
  }

  String toJson() => value;
}

/// The state a connection to a peer point can be in: requested (connection open from here), accepted (handshake), running (connection already established), disconnected (no connection).
sealed class OctezShellP2pPointState {
  const OctezShellP2pPointState();

  factory OctezShellP2pPointState.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['event_kind'] == "accepted" && map.hasValue('p2p_peer_id')) {
        return OctezShellP2pPointStateAccepted.fromJson(map);
      }
      if (map['event_kind'] == "running" && map.hasValue('p2p_peer_id')) {
        return OctezShellP2pPointStateRunning.fromJson(map);
      }
      if (map['event_kind'] == "requested") {
        return OctezShellP2pPointStateRequested.fromJson(map);
      }
      if (map['event_kind'] == "disconnected") {
        return OctezShellP2pPointStateDisconnected.fromJson(map);
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezShellP2pPointState',
      reason: 'Cannot parse OctezShellP2pPointState from $json',
    );
  }

  dynamic toJson();
}

class OctezShellP2pPointStateRequested extends OctezShellP2pPointState {
  final OctezShellP2pPointStateRequestedEventKind eventKind;

  const OctezShellP2pPointStateRequested({required this.eventKind});

  factory OctezShellP2pPointStateRequested.fromJson(Map<String, dynamic> json) {
    return OctezShellP2pPointStateRequested(
      eventKind: OctezShellP2pPointStateRequestedEventKind.fromJson(
        json['event_kind'],
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'event_kind': eventKind.toJson()}.notNullValue.cast<String, dynamic>();
}

class OctezShellP2pPointStateAccepted extends OctezShellP2pPointState {
  final OctezShellP2pPointStateAcceptedEventKind eventKind;
  final OctezShellCryptoBoxPublicKeyHash p2pPeerId;

  const OctezShellP2pPointStateAccepted({
    required this.eventKind,
    required this.p2pPeerId,
  });

  factory OctezShellP2pPointStateAccepted.fromJson(Map<String, dynamic> json) {
    return OctezShellP2pPointStateAccepted(
      eventKind: OctezShellP2pPointStateAcceptedEventKind.fromJson(
        json['event_kind'],
      ),
      p2pPeerId: OctezShellUnistring.fromJson(json['p2p_peer_id']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'event_kind': eventKind.toJson(),
        'p2p_peer_id': p2pPeerId.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellP2pPointStateRunning extends OctezShellP2pPointState {
  final OctezShellP2pPointStateRunningEventKind eventKind;
  final OctezShellCryptoBoxPublicKeyHash p2pPeerId;

  const OctezShellP2pPointStateRunning({
    required this.eventKind,
    required this.p2pPeerId,
  });

  factory OctezShellP2pPointStateRunning.fromJson(Map<String, dynamic> json) {
    return OctezShellP2pPointStateRunning(
      eventKind: OctezShellP2pPointStateRunningEventKind.fromJson(
        json['event_kind'],
      ),
      p2pPeerId: OctezShellUnistring.fromJson(json['p2p_peer_id']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'event_kind': eventKind.toJson(),
        'p2p_peer_id': p2pPeerId.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellP2pPointStateDisconnected extends OctezShellP2pPointState {
  final OctezShellP2pPointStateDisconnectedEventKind eventKind;

  const OctezShellP2pPointStateDisconnected({required this.eventKind});

  factory OctezShellP2pPointStateDisconnected.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellP2pPointStateDisconnected(
      eventKind: OctezShellP2pPointStateDisconnectedEventKind.fromJson(
        json['event_kind'],
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'event_kind': eventKind.toJson()}.notNullValue.cast<String, dynamic>();
}

sealed class OctezShellP2pPointInfoLastRejectedConnectionItem {
  const OctezShellP2pPointInfoLastRejectedConnectionItem();

  factory OctezShellP2pPointInfoLastRejectedConnectionItem.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      try {
        return OctezShellP2pPointInfoLastRejectedConnectionItemTimestampSystem(
          OctezShellTimestampSystem.fromJson(map),
        );
      } catch (_) {}
    }
    try {
      return OctezShellP2pPointInfoLastRejectedConnectionItemTimestampSystem(
        OctezShellTimestampSystem.fromJson(json),
      );
    } catch (_) {}
    throw OnChainErrors.tezosPlugin(
      'OctezShellP2pPointInfoLastRejectedConnectionItem',
      reason:
          'Cannot parse OctezShellP2pPointInfoLastRejectedConnectionItem from $json',
    );
  }

  dynamic toJson();
}

class OctezShellP2pPointInfoLastRejectedConnectionItemCryptoBoxPublicKeyHash
    extends OctezShellP2pPointInfoLastRejectedConnectionItem {
  final OctezShellCryptoBoxPublicKeyHash value;
  const OctezShellP2pPointInfoLastRejectedConnectionItemCryptoBoxPublicKeyHash(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class OctezShellP2pPointInfoLastRejectedConnectionItemTimestampSystem
    extends OctezShellP2pPointInfoLastRejectedConnectionItem {
  final OctezShellTimestampSystem value;
  const OctezShellP2pPointInfoLastRejectedConnectionItemTimestampSystem(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

sealed class OctezShellResponseNetworkFullStatPointsItemItem {
  const OctezShellResponseNetworkFullStatPointsItemItem();

  factory OctezShellResponseNetworkFullStatPointsItemItem.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      try {
        return OctezShellResponseNetworkFullStatPointsItemItemP2pPointInfo(
          OctezShellP2pPointInfo.fromJson(map),
        );
      } catch (_) {}
    }
    throw OnChainErrors.tezosPlugin(
      'OctezShellResponseNetworkFullStatPointsItemItem',
      reason:
          'Cannot parse OctezShellResponseNetworkFullStatPointsItemItem from $json',
    );
  }

  dynamic toJson();
}

class OctezShellResponseNetworkFullStatPointsItemItemP2pPointId
    extends OctezShellResponseNetworkFullStatPointsItemItem {
  final OctezShellP2pPointId value;
  const OctezShellResponseNetworkFullStatPointsItemItemP2pPointId(this.value);

  @override
  dynamic toJson() => value.toJson();
}

class OctezShellResponseNetworkFullStatPointsItemItemP2pPointInfo
    extends OctezShellResponseNetworkFullStatPointsItemItem {
  final OctezShellP2pPointInfo value;
  const OctezShellResponseNetworkFullStatPointsItemItemP2pPointInfo(this.value);

  @override
  dynamic toJson() => value.toJson();
}

enum OctezShellResponseNetworkLogTooFewConnectionsEvent {
  tooFewConnections("too_few_connections");

  final String value;
  const OctezShellResponseNetworkLogTooFewConnectionsEvent(this.value);

  static OctezShellResponseNetworkLogTooFewConnectionsEvent fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseNetworkLogTooFewConnectionsEvent.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellResponseNetworkLogTooManyConnectionsEvent {
  tooManyConnections("too_many_connections");

  final String value;
  const OctezShellResponseNetworkLogTooManyConnectionsEvent(this.value);

  static OctezShellResponseNetworkLogTooManyConnectionsEvent fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseNetworkLogTooManyConnectionsEvent.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellResponseNetworkLogNewPointEvent {
  newPoint("new_point");

  final String value;
  const OctezShellResponseNetworkLogNewPointEvent(this.value);

  static OctezShellResponseNetworkLogNewPointEvent fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseNetworkLogNewPointEvent.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellResponseNetworkLogNewPeerEvent {
  newPeer("new_peer");

  final String value;
  const OctezShellResponseNetworkLogNewPeerEvent(this.value);

  static OctezShellResponseNetworkLogNewPeerEvent fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseNetworkLogNewPeerEvent.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellResponseNetworkLogIncomingConnectionEvent {
  incomingConnection("incoming_connection");

  final String value;
  const OctezShellResponseNetworkLogIncomingConnectionEvent(this.value);

  static OctezShellResponseNetworkLogIncomingConnectionEvent fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseNetworkLogIncomingConnectionEvent.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellResponseNetworkLogOutgoingConnectionEvent {
  outgoingConnection("outgoing_connection");

  final String value;
  const OctezShellResponseNetworkLogOutgoingConnectionEvent(this.value);

  static OctezShellResponseNetworkLogOutgoingConnectionEvent fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseNetworkLogOutgoingConnectionEvent.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellResponseNetworkLogAuthenticationFailedEvent {
  authenticationFailed("authentication_failed");

  final String value;
  const OctezShellResponseNetworkLogAuthenticationFailedEvent(this.value);

  static OctezShellResponseNetworkLogAuthenticationFailedEvent fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseNetworkLogAuthenticationFailedEvent.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellResponseNetworkLogAcceptingRequestEvent {
  acceptingRequest("accepting_request");

  final String value;
  const OctezShellResponseNetworkLogAcceptingRequestEvent(this.value);

  static OctezShellResponseNetworkLogAcceptingRequestEvent fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseNetworkLogAcceptingRequestEvent.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellResponseNetworkLogRejectingRequestEvent {
  rejectingRequest("rejecting_request");

  final String value;
  const OctezShellResponseNetworkLogRejectingRequestEvent(this.value);

  static OctezShellResponseNetworkLogRejectingRequestEvent fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseNetworkLogRejectingRequestEvent.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellResponseNetworkLogRequestRejectedEvent {
  requestRejected("request_rejected");

  final String value;
  const OctezShellResponseNetworkLogRequestRejectedEvent(this.value);

  static OctezShellResponseNetworkLogRequestRejectedEvent fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseNetworkLogRequestRejectedEvent.",
              ),
    );
  }

  String toJson() => value;
}

sealed class OctezShellResponseNetworkLogRequestRejectedIdentityItem {
  const OctezShellResponseNetworkLogRequestRejectedIdentityItem();

  factory OctezShellResponseNetworkLogRequestRejectedIdentityItem.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      try {
        return OctezShellResponseNetworkLogRequestRejectedIdentityItemP2pConnectionId(
          OctezShellP2pConnectionId.fromJson(map),
        );
      } catch (_) {}
    }
    throw OnChainErrors.tezosPlugin(
      'OctezShellResponseNetworkLogRequestRejectedIdentityItem',
      reason:
          'Cannot parse OctezShellResponseNetworkLogRequestRejectedIdentityItem from $json',
    );
  }

  dynamic toJson();
}

class OctezShellResponseNetworkLogRequestRejectedIdentityItemP2pConnectionId
    extends OctezShellResponseNetworkLogRequestRejectedIdentityItem {
  final OctezShellP2pConnectionId value;
  const OctezShellResponseNetworkLogRequestRejectedIdentityItemP2pConnectionId(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

class OctezShellResponseNetworkLogRequestRejectedIdentityItemCryptoBoxPublicKeyHash
    extends OctezShellResponseNetworkLogRequestRejectedIdentityItem {
  final OctezShellCryptoBoxPublicKeyHash value;
  const OctezShellResponseNetworkLogRequestRejectedIdentityItemCryptoBoxPublicKeyHash(
    this.value,
  );

  @override
  dynamic toJson() => value.toJson();
}

enum OctezShellResponseNetworkLogConnectionEstablishedEvent {
  connectionEstablished("connection_established");

  final String value;
  const OctezShellResponseNetworkLogConnectionEstablishedEvent(this.value);

  static OctezShellResponseNetworkLogConnectionEstablishedEvent fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseNetworkLogConnectionEstablishedEvent.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellResponseNetworkLogDisconnectionEvent {
  disconnection("disconnection");

  final String value;
  const OctezShellResponseNetworkLogDisconnectionEvent(this.value);

  static OctezShellResponseNetworkLogDisconnectionEvent fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseNetworkLogDisconnectionEvent.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellResponseNetworkLogExternalDisconnectionEvent {
  externalDisconnection("external_disconnection");

  final String value;
  const OctezShellResponseNetworkLogExternalDisconnectionEvent(this.value);

  static OctezShellResponseNetworkLogExternalDisconnectionEvent fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseNetworkLogExternalDisconnectionEvent.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellResponseNetworkLogGcPointsEvent {
  gcPoints("gc_points");

  final String value;
  const OctezShellResponseNetworkLogGcPointsEvent(this.value);

  static OctezShellResponseNetworkLogGcPointsEvent fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseNetworkLogGcPointsEvent.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellResponseNetworkLogGcPeerIdsEvent {
  gcPeerIds("gc_peer_ids");

  final String value;
  const OctezShellResponseNetworkLogGcPeerIdsEvent(this.value);

  static OctezShellResponseNetworkLogGcPeerIdsEvent fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseNetworkLogGcPeerIdsEvent.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellResponseNetworkLogSwapRequestReceivedEvent {
  swapRequestReceived("swap_request_received");

  final String value;
  const OctezShellResponseNetworkLogSwapRequestReceivedEvent(this.value);

  static OctezShellResponseNetworkLogSwapRequestReceivedEvent fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseNetworkLogSwapRequestReceivedEvent.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellResponseNetworkLogSwapAckReceivedEvent {
  swapAckReceived("swap_ack_received");

  final String value;
  const OctezShellResponseNetworkLogSwapAckReceivedEvent(this.value);

  static OctezShellResponseNetworkLogSwapAckReceivedEvent fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseNetworkLogSwapAckReceivedEvent.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellResponseNetworkLogSwapRequestSentEvent {
  swapRequestSent("swap_request_sent");

  final String value;
  const OctezShellResponseNetworkLogSwapRequestSentEvent(this.value);

  static OctezShellResponseNetworkLogSwapRequestSentEvent fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseNetworkLogSwapRequestSentEvent.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellResponseNetworkLogSwapAckSentEvent {
  swapAckSent("swap_ack_sent");

  final String value;
  const OctezShellResponseNetworkLogSwapAckSentEvent(this.value);

  static OctezShellResponseNetworkLogSwapAckSentEvent fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseNetworkLogSwapAckSentEvent.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellResponseNetworkLogSwapRequestIgnoredEvent {
  swapRequestIgnored("swap_request_ignored");

  final String value;
  const OctezShellResponseNetworkLogSwapRequestIgnoredEvent(this.value);

  static OctezShellResponseNetworkLogSwapRequestIgnoredEvent fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseNetworkLogSwapRequestIgnoredEvent.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellResponseNetworkLogSwapSuccessEvent {
  swapSuccess("swap_success");

  final String value;
  const OctezShellResponseNetworkLogSwapSuccessEvent(this.value);

  static OctezShellResponseNetworkLogSwapSuccessEvent fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseNetworkLogSwapSuccessEvent.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellResponseNetworkLogSwapFailureEvent {
  swapFailure("swap_failure");

  final String value;
  const OctezShellResponseNetworkLogSwapFailureEvent(this.value);

  static OctezShellResponseNetworkLogSwapFailureEvent fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseNetworkLogSwapFailureEvent.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellResponseNetworkLogBootstrapSentEvent {
  bootstrapSent("bootstrap_sent");

  final String value;
  const OctezShellResponseNetworkLogBootstrapSentEvent(this.value);

  static OctezShellResponseNetworkLogBootstrapSentEvent fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseNetworkLogBootstrapSentEvent.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellResponseNetworkLogBootstrapReceivedEvent {
  bootstrapReceived("bootstrap_received");

  final String value;
  const OctezShellResponseNetworkLogBootstrapReceivedEvent(this.value);

  static OctezShellResponseNetworkLogBootstrapReceivedEvent fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseNetworkLogBootstrapReceivedEvent.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellResponseNetworkLogAdvertiseSentEvent {
  advertiseSent("advertise_sent");

  final String value;
  const OctezShellResponseNetworkLogAdvertiseSentEvent(this.value);

  static OctezShellResponseNetworkLogAdvertiseSentEvent fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseNetworkLogAdvertiseSentEvent.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellResponseNetworkLogAdvertiseReceivedEvent {
  advertiseReceived("advertise_received");

  final String value;
  const OctezShellResponseNetworkLogAdvertiseReceivedEvent(this.value);

  static OctezShellResponseNetworkLogAdvertiseReceivedEvent fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseNetworkLogAdvertiseReceivedEvent.",
              ),
    );
  }

  String toJson() => value;
}

/// An event that may happen during maintenance of and other operations on the p2p connection pool. Typically, it includes connection errors, peer swaps, etc.
sealed class OctezShellResponseNetworkLog {
  const OctezShellResponseNetworkLog();

  factory OctezShellResponseNetworkLog.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['event'] == "accepting_request" &&
          map.hasValue('point') &&
          map.hasValue('id_point') &&
          map.hasValue('peer_id')) {
        return OctezShellResponseNetworkLogAcceptingRequest.fromJson(map);
      }
      if (map['event'] == "rejecting_request" &&
          map.hasValue('point') &&
          map.hasValue('id_point') &&
          map.hasValue('peer_id')) {
        return OctezShellResponseNetworkLogRejectingRequest.fromJson(map);
      }
      if (map['event'] == "connection_established" &&
          map.hasValue('id_point') &&
          map.hasValue('peer_id')) {
        return OctezShellResponseNetworkLogConnectionEstablished.fromJson(map);
      }
      if (map['event'] == "request_rejected" && map.hasValue('point')) {
        return OctezShellResponseNetworkLogRequestRejected.fromJson(map);
      }
      if (map['event'] == "new_point" && map.hasValue('point')) {
        return OctezShellResponseNetworkLogNewPoint.fromJson(map);
      }
      if (map['event'] == "new_peer" && map.hasValue('peer_id')) {
        return OctezShellResponseNetworkLogNewPeer.fromJson(map);
      }
      if (map['event'] == "incoming_connection" && map.hasValue('point')) {
        return OctezShellResponseNetworkLogIncomingConnection.fromJson(map);
      }
      if (map['event'] == "outgoing_connection" && map.hasValue('point')) {
        return OctezShellResponseNetworkLogOutgoingConnection.fromJson(map);
      }
      if (map['event'] == "authentication_failed" && map.hasValue('point')) {
        return OctezShellResponseNetworkLogAuthenticationFailed.fromJson(map);
      }
      if (map['event'] == "disconnection" && map.hasValue('peer_id')) {
        return OctezShellResponseNetworkLogDisconnection.fromJson(map);
      }
      if (map['event'] == "external_disconnection" && map.hasValue('peer_id')) {
        return OctezShellResponseNetworkLogExternalDisconnection.fromJson(map);
      }
      if (map['event'] == "swap_request_received" && map.hasValue('source')) {
        return OctezShellResponseNetworkLogSwapRequestReceived.fromJson(map);
      }
      if (map['event'] == "swap_ack_received" && map.hasValue('source')) {
        return OctezShellResponseNetworkLogSwapAckReceived.fromJson(map);
      }
      if (map['event'] == "swap_request_sent" && map.hasValue('source')) {
        return OctezShellResponseNetworkLogSwapRequestSent.fromJson(map);
      }
      if (map['event'] == "swap_ack_sent" && map.hasValue('source')) {
        return OctezShellResponseNetworkLogSwapAckSent.fromJson(map);
      }
      if (map['event'] == "swap_request_ignored" && map.hasValue('source')) {
        return OctezShellResponseNetworkLogSwapRequestIgnored.fromJson(map);
      }
      if (map['event'] == "swap_success" && map.hasValue('source')) {
        return OctezShellResponseNetworkLogSwapSuccess.fromJson(map);
      }
      if (map['event'] == "swap_failure" && map.hasValue('source')) {
        return OctezShellResponseNetworkLogSwapFailure.fromJson(map);
      }
      if (map['event'] == "bootstrap_sent" && map.hasValue('source')) {
        return OctezShellResponseNetworkLogBootstrapSent.fromJson(map);
      }
      if (map['event'] == "bootstrap_received" && map.hasValue('source')) {
        return OctezShellResponseNetworkLogBootstrapReceived.fromJson(map);
      }
      if (map['event'] == "advertise_sent" && map.hasValue('source')) {
        return OctezShellResponseNetworkLogAdvertiseSent.fromJson(map);
      }
      if (map['event'] == "advertise_received" && map.hasValue('source')) {
        return OctezShellResponseNetworkLogAdvertiseReceived.fromJson(map);
      }
      if (map['event'] == "too_few_connections") {
        return OctezShellResponseNetworkLogTooFewConnections.fromJson(map);
      }
      if (map['event'] == "too_many_connections") {
        return OctezShellResponseNetworkLogTooManyConnections.fromJson(map);
      }
      if (map['event'] == "gc_points") {
        return OctezShellResponseNetworkLogGcPoints.fromJson(map);
      }
      if (map['event'] == "gc_peer_ids") {
        return OctezShellResponseNetworkLogGcPeerIds.fromJson(map);
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezShellResponseNetworkLog',
      reason: 'Cannot parse OctezShellResponseNetworkLog from $json',
    );
  }

  dynamic toJson();
}

class OctezShellResponseNetworkLogTooFewConnections
    extends OctezShellResponseNetworkLog {
  final OctezShellResponseNetworkLogTooFewConnectionsEvent event;

  const OctezShellResponseNetworkLogTooFewConnections({required this.event});

  factory OctezShellResponseNetworkLogTooFewConnections.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkLogTooFewConnections(
      event: OctezShellResponseNetworkLogTooFewConnectionsEvent.fromJson(
        json['event'],
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'event': event.toJson()}.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkLogTooManyConnections
    extends OctezShellResponseNetworkLog {
  final OctezShellResponseNetworkLogTooManyConnectionsEvent event;

  const OctezShellResponseNetworkLogTooManyConnections({required this.event});

  factory OctezShellResponseNetworkLogTooManyConnections.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkLogTooManyConnections(
      event: OctezShellResponseNetworkLogTooManyConnectionsEvent.fromJson(
        json['event'],
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'event': event.toJson()}.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkLogNewPoint
    extends OctezShellResponseNetworkLog {
  final OctezShellResponseNetworkLogNewPointEvent event;
  final OctezShellP2pPointId point;

  const OctezShellResponseNetworkLogNewPoint({
    required this.event,
    required this.point,
  });

  factory OctezShellResponseNetworkLogNewPoint.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkLogNewPoint(
      event: OctezShellResponseNetworkLogNewPointEvent.fromJson(json['event']),
      point: OctezShellUnistring.fromJson(json['point']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'event': event.toJson(),
        'point': point.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkLogNewPeer extends OctezShellResponseNetworkLog {
  final OctezShellResponseNetworkLogNewPeerEvent event;
  final OctezShellCryptoBoxPublicKeyHash peerId;

  const OctezShellResponseNetworkLogNewPeer({
    required this.event,
    required this.peerId,
  });

  factory OctezShellResponseNetworkLogNewPeer.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkLogNewPeer(
      event: OctezShellResponseNetworkLogNewPeerEvent.fromJson(json['event']),
      peerId: OctezShellUnistring.fromJson(json['peer_id']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'event': event.toJson(),
        'peer_id': peerId.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkLogIncomingConnection
    extends OctezShellResponseNetworkLog {
  final OctezShellResponseNetworkLogIncomingConnectionEvent event;
  final OctezShellP2pPointId point;

  const OctezShellResponseNetworkLogIncomingConnection({
    required this.event,
    required this.point,
  });

  factory OctezShellResponseNetworkLogIncomingConnection.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkLogIncomingConnection(
      event: OctezShellResponseNetworkLogIncomingConnectionEvent.fromJson(
        json['event'],
      ),
      point: OctezShellUnistring.fromJson(json['point']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'event': event.toJson(),
        'point': point.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkLogOutgoingConnection
    extends OctezShellResponseNetworkLog {
  final OctezShellResponseNetworkLogOutgoingConnectionEvent event;
  final OctezShellP2pPointId point;

  const OctezShellResponseNetworkLogOutgoingConnection({
    required this.event,
    required this.point,
  });

  factory OctezShellResponseNetworkLogOutgoingConnection.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkLogOutgoingConnection(
      event: OctezShellResponseNetworkLogOutgoingConnectionEvent.fromJson(
        json['event'],
      ),
      point: OctezShellUnistring.fromJson(json['point']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'event': event.toJson(),
        'point': point.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkLogAuthenticationFailed
    extends OctezShellResponseNetworkLog {
  final OctezShellResponseNetworkLogAuthenticationFailedEvent event;
  final OctezShellP2pPointId point;

  const OctezShellResponseNetworkLogAuthenticationFailed({
    required this.event,
    required this.point,
  });

  factory OctezShellResponseNetworkLogAuthenticationFailed.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkLogAuthenticationFailed(
      event: OctezShellResponseNetworkLogAuthenticationFailedEvent.fromJson(
        json['event'],
      ),
      point: OctezShellUnistring.fromJson(json['point']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'event': event.toJson(),
        'point': point.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkLogAcceptingRequest
    extends OctezShellResponseNetworkLog {
  final OctezShellResponseNetworkLogAcceptingRequestEvent event;
  final OctezShellP2pPointId point;
  final OctezShellP2pConnectionId idPoint;
  final OctezShellCryptoBoxPublicKeyHash peerId;

  const OctezShellResponseNetworkLogAcceptingRequest({
    required this.event,
    required this.point,
    required this.idPoint,
    required this.peerId,
  });

  factory OctezShellResponseNetworkLogAcceptingRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkLogAcceptingRequest(
      event: OctezShellResponseNetworkLogAcceptingRequestEvent.fromJson(
        json['event'],
      ),
      point: OctezShellUnistring.fromJson(json['point']),
      idPoint: json.valueTo<OctezShellP2pConnectionId, Map<String, dynamic>>(
        key: 'id_point',
        parse: (v) => OctezShellP2pConnectionId.fromJson(v),
      ),
      peerId: OctezShellUnistring.fromJson(json['peer_id']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'event': event.toJson(),
        'point': point.toJson(),
        'id_point': idPoint.toJson(),
        'peer_id': peerId.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkLogRejectingRequest
    extends OctezShellResponseNetworkLog {
  final OctezShellResponseNetworkLogRejectingRequestEvent event;
  final OctezShellP2pPointId point;
  final OctezShellP2pConnectionId idPoint;
  final OctezShellCryptoBoxPublicKeyHash peerId;

  const OctezShellResponseNetworkLogRejectingRequest({
    required this.event,
    required this.point,
    required this.idPoint,
    required this.peerId,
  });

  factory OctezShellResponseNetworkLogRejectingRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkLogRejectingRequest(
      event: OctezShellResponseNetworkLogRejectingRequestEvent.fromJson(
        json['event'],
      ),
      point: OctezShellUnistring.fromJson(json['point']),
      idPoint: json.valueTo<OctezShellP2pConnectionId, Map<String, dynamic>>(
        key: 'id_point',
        parse: (v) => OctezShellP2pConnectionId.fromJson(v),
      ),
      peerId: OctezShellUnistring.fromJson(json['peer_id']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'event': event.toJson(),
        'point': point.toJson(),
        'id_point': idPoint.toJson(),
        'peer_id': peerId.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkLogRequestRejected
    extends OctezShellResponseNetworkLog {
  final OctezShellResponseNetworkLogRequestRejectedEvent event;
  final OctezShellP2pPointId point;
  final List<OctezShellResponseNetworkLogRequestRejectedIdentityItem>? identity;

  const OctezShellResponseNetworkLogRequestRejected({
    required this.event,
    required this.point,
    this.identity,
  });

  factory OctezShellResponseNetworkLogRequestRejected.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkLogRequestRejected(
      event: OctezShellResponseNetworkLogRequestRejectedEvent.fromJson(
        json['event'],
      ),
      point: OctezShellUnistring.fromJson(json['point']),
      identity:
          json.hasValue('identity')
              ? json
                  .valueEnsureAsList<dynamic>('identity')
                  .map(
                    (e) =>
                        OctezShellResponseNetworkLogRequestRejectedIdentityItem.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'event': event.toJson(),
        'point': point.toJson(),
        'identity': identity?.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkLogConnectionEstablished
    extends OctezShellResponseNetworkLog {
  final OctezShellResponseNetworkLogConnectionEstablishedEvent event;
  final OctezShellP2pConnectionId idPoint;
  final OctezShellCryptoBoxPublicKeyHash peerId;

  const OctezShellResponseNetworkLogConnectionEstablished({
    required this.event,
    required this.idPoint,
    required this.peerId,
  });

  factory OctezShellResponseNetworkLogConnectionEstablished.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkLogConnectionEstablished(
      event: OctezShellResponseNetworkLogConnectionEstablishedEvent.fromJson(
        json['event'],
      ),
      idPoint: json.valueTo<OctezShellP2pConnectionId, Map<String, dynamic>>(
        key: 'id_point',
        parse: (v) => OctezShellP2pConnectionId.fromJson(v),
      ),
      peerId: OctezShellUnistring.fromJson(json['peer_id']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'event': event.toJson(),
        'id_point': idPoint.toJson(),
        'peer_id': peerId.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkLogDisconnection
    extends OctezShellResponseNetworkLog {
  final OctezShellResponseNetworkLogDisconnectionEvent event;
  final OctezShellCryptoBoxPublicKeyHash peerId;

  const OctezShellResponseNetworkLogDisconnection({
    required this.event,
    required this.peerId,
  });

  factory OctezShellResponseNetworkLogDisconnection.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkLogDisconnection(
      event: OctezShellResponseNetworkLogDisconnectionEvent.fromJson(
        json['event'],
      ),
      peerId: OctezShellUnistring.fromJson(json['peer_id']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'event': event.toJson(),
        'peer_id': peerId.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkLogExternalDisconnection
    extends OctezShellResponseNetworkLog {
  final OctezShellResponseNetworkLogExternalDisconnectionEvent event;
  final OctezShellCryptoBoxPublicKeyHash peerId;

  const OctezShellResponseNetworkLogExternalDisconnection({
    required this.event,
    required this.peerId,
  });

  factory OctezShellResponseNetworkLogExternalDisconnection.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkLogExternalDisconnection(
      event: OctezShellResponseNetworkLogExternalDisconnectionEvent.fromJson(
        json['event'],
      ),
      peerId: OctezShellUnistring.fromJson(json['peer_id']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'event': event.toJson(),
        'peer_id': peerId.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkLogGcPoints
    extends OctezShellResponseNetworkLog {
  final OctezShellResponseNetworkLogGcPointsEvent event;

  const OctezShellResponseNetworkLogGcPoints({required this.event});

  factory OctezShellResponseNetworkLogGcPoints.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkLogGcPoints(
      event: OctezShellResponseNetworkLogGcPointsEvent.fromJson(json['event']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'event': event.toJson()}.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkLogGcPeerIds
    extends OctezShellResponseNetworkLog {
  final OctezShellResponseNetworkLogGcPeerIdsEvent event;

  const OctezShellResponseNetworkLogGcPeerIds({required this.event});

  factory OctezShellResponseNetworkLogGcPeerIds.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkLogGcPeerIds(
      event: OctezShellResponseNetworkLogGcPeerIdsEvent.fromJson(json['event']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'event': event.toJson()}.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkLogSwapRequestReceived
    extends OctezShellResponseNetworkLog {
  final OctezShellResponseNetworkLogSwapRequestReceivedEvent event;
  final OctezShellCryptoBoxPublicKeyHash source;

  const OctezShellResponseNetworkLogSwapRequestReceived({
    required this.event,
    required this.source,
  });

  factory OctezShellResponseNetworkLogSwapRequestReceived.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkLogSwapRequestReceived(
      event: OctezShellResponseNetworkLogSwapRequestReceivedEvent.fromJson(
        json['event'],
      ),
      source: OctezShellUnistring.fromJson(json['source']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'event': event.toJson(),
        'source': source.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkLogSwapAckReceived
    extends OctezShellResponseNetworkLog {
  final OctezShellResponseNetworkLogSwapAckReceivedEvent event;
  final OctezShellCryptoBoxPublicKeyHash source;

  const OctezShellResponseNetworkLogSwapAckReceived({
    required this.event,
    required this.source,
  });

  factory OctezShellResponseNetworkLogSwapAckReceived.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkLogSwapAckReceived(
      event: OctezShellResponseNetworkLogSwapAckReceivedEvent.fromJson(
        json['event'],
      ),
      source: OctezShellUnistring.fromJson(json['source']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'event': event.toJson(),
        'source': source.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkLogSwapRequestSent
    extends OctezShellResponseNetworkLog {
  final OctezShellResponseNetworkLogSwapRequestSentEvent event;
  final OctezShellCryptoBoxPublicKeyHash source;

  const OctezShellResponseNetworkLogSwapRequestSent({
    required this.event,
    required this.source,
  });

  factory OctezShellResponseNetworkLogSwapRequestSent.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkLogSwapRequestSent(
      event: OctezShellResponseNetworkLogSwapRequestSentEvent.fromJson(
        json['event'],
      ),
      source: OctezShellUnistring.fromJson(json['source']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'event': event.toJson(),
        'source': source.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkLogSwapAckSent
    extends OctezShellResponseNetworkLog {
  final OctezShellResponseNetworkLogSwapAckSentEvent event;
  final OctezShellCryptoBoxPublicKeyHash source;

  const OctezShellResponseNetworkLogSwapAckSent({
    required this.event,
    required this.source,
  });

  factory OctezShellResponseNetworkLogSwapAckSent.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkLogSwapAckSent(
      event: OctezShellResponseNetworkLogSwapAckSentEvent.fromJson(
        json['event'],
      ),
      source: OctezShellUnistring.fromJson(json['source']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'event': event.toJson(),
        'source': source.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkLogSwapRequestIgnored
    extends OctezShellResponseNetworkLog {
  final OctezShellResponseNetworkLogSwapRequestIgnoredEvent event;
  final OctezShellCryptoBoxPublicKeyHash source;

  const OctezShellResponseNetworkLogSwapRequestIgnored({
    required this.event,
    required this.source,
  });

  factory OctezShellResponseNetworkLogSwapRequestIgnored.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkLogSwapRequestIgnored(
      event: OctezShellResponseNetworkLogSwapRequestIgnoredEvent.fromJson(
        json['event'],
      ),
      source: OctezShellUnistring.fromJson(json['source']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'event': event.toJson(),
        'source': source.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkLogSwapSuccess
    extends OctezShellResponseNetworkLog {
  final OctezShellResponseNetworkLogSwapSuccessEvent event;
  final OctezShellCryptoBoxPublicKeyHash source;

  const OctezShellResponseNetworkLogSwapSuccess({
    required this.event,
    required this.source,
  });

  factory OctezShellResponseNetworkLogSwapSuccess.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkLogSwapSuccess(
      event: OctezShellResponseNetworkLogSwapSuccessEvent.fromJson(
        json['event'],
      ),
      source: OctezShellUnistring.fromJson(json['source']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'event': event.toJson(),
        'source': source.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkLogSwapFailure
    extends OctezShellResponseNetworkLog {
  final OctezShellResponseNetworkLogSwapFailureEvent event;
  final OctezShellCryptoBoxPublicKeyHash source;

  const OctezShellResponseNetworkLogSwapFailure({
    required this.event,
    required this.source,
  });

  factory OctezShellResponseNetworkLogSwapFailure.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkLogSwapFailure(
      event: OctezShellResponseNetworkLogSwapFailureEvent.fromJson(
        json['event'],
      ),
      source: OctezShellUnistring.fromJson(json['source']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'event': event.toJson(),
        'source': source.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkLogBootstrapSent
    extends OctezShellResponseNetworkLog {
  final OctezShellResponseNetworkLogBootstrapSentEvent event;
  final OctezShellCryptoBoxPublicKeyHash source;

  const OctezShellResponseNetworkLogBootstrapSent({
    required this.event,
    required this.source,
  });

  factory OctezShellResponseNetworkLogBootstrapSent.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkLogBootstrapSent(
      event: OctezShellResponseNetworkLogBootstrapSentEvent.fromJson(
        json['event'],
      ),
      source: OctezShellUnistring.fromJson(json['source']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'event': event.toJson(),
        'source': source.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkLogBootstrapReceived
    extends OctezShellResponseNetworkLog {
  final OctezShellResponseNetworkLogBootstrapReceivedEvent event;
  final OctezShellCryptoBoxPublicKeyHash source;

  const OctezShellResponseNetworkLogBootstrapReceived({
    required this.event,
    required this.source,
  });

  factory OctezShellResponseNetworkLogBootstrapReceived.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkLogBootstrapReceived(
      event: OctezShellResponseNetworkLogBootstrapReceivedEvent.fromJson(
        json['event'],
      ),
      source: OctezShellUnistring.fromJson(json['source']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'event': event.toJson(),
        'source': source.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkLogAdvertiseSent
    extends OctezShellResponseNetworkLog {
  final OctezShellResponseNetworkLogAdvertiseSentEvent event;
  final OctezShellCryptoBoxPublicKeyHash source;

  const OctezShellResponseNetworkLogAdvertiseSent({
    required this.event,
    required this.source,
  });

  factory OctezShellResponseNetworkLogAdvertiseSent.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkLogAdvertiseSent(
      event: OctezShellResponseNetworkLogAdvertiseSentEvent.fromJson(
        json['event'],
      ),
      source: OctezShellUnistring.fromJson(json['source']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'event': event.toJson(),
        'source': source.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkLogAdvertiseReceived
    extends OctezShellResponseNetworkLog {
  final OctezShellResponseNetworkLogAdvertiseReceivedEvent event;
  final OctezShellCryptoBoxPublicKeyHash source;

  const OctezShellResponseNetworkLogAdvertiseReceived({
    required this.event,
    required this.source,
  });

  factory OctezShellResponseNetworkLogAdvertiseReceived.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkLogAdvertiseReceived(
      event: OctezShellResponseNetworkLogAdvertiseReceivedEvent.fromJson(
        json['event'],
      ),
      source: OctezShellUnistring.fromJson(json['source']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'event': event.toJson(),
        'source': source.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

enum OctezShellNetworkPeersPeerIdBodyAcl {
  open("open"),
  trust("trust"),
  ban("ban");

  final String value;
  const OctezShellNetworkPeersPeerIdBodyAcl(this.value);

  static OctezShellNetworkPeersPeerIdBodyAcl fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellNetworkPeersPeerIdBodyAcl.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellP2pPeerPoolEventKind {
  rejectingRequest("rejecting_request"),
  incomingRequest("incoming_request"),
  disconnection("disconnection"),
  externalDisconnection("external_disconnection"),
  connectionEstablished("connection_established"),
  requestRejected("request_rejected");

  final String value;
  const OctezShellP2pPeerPoolEventKind(this.value);

  static OctezShellP2pPeerPoolEventKind fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellP2pPeerPoolEventKind.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellP2pPointPoolEventItemVariant1ValueOutgoingRequestEventKind {
  outgoingRequest("outgoing_request");

  final String value;
  const OctezShellP2pPointPoolEventItemVariant1ValueOutgoingRequestEventKind(
    this.value,
  );

  static OctezShellP2pPointPoolEventItemVariant1ValueOutgoingRequestEventKind
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellP2pPointPoolEventItemVariant1ValueOutgoingRequestEventKind.",
              ),
    );
  }

  String toJson() => value;
}

sealed class OctezShellP2pPointPoolEventItemVariant1Value {
  const OctezShellP2pPointPoolEventItemVariant1Value();

  factory OctezShellP2pPointPoolEventItemVariant1Value.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['event_kind'] == "outgoing_request") {
        return OctezShellP2pPointPoolEventItemVariant1ValueOutgoingRequest.fromJson(
          map,
        );
      }
      if (map['event_kind'] == "request_rejected") {
        return OctezShellP2pPointPoolEventItemVariant1ValueRejectingRejected.fromJson(
          map,
        );
      }
      if (map['event_kind'] == "accepting_request" &&
          map.hasValue('p2p_peer_id')) {
        return OctezShellP2pPointPoolEventItemVariant1ValueAcceptingRequest.fromJson(
          map,
        );
      }
      if (map['event_kind'] == "rejecting_request" &&
          map.hasValue('p2p_peer_id')) {
        return OctezShellP2pPointPoolEventItemVariant1ValueRejectingRequest.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezShellP2pPointPoolEventItemVariant1Value',
      reason:
          'Cannot parse OctezShellP2pPointPoolEventItemVariant1Value from $json',
    );
  }

  dynamic toJson();
}

class OctezShellP2pPointPoolEventItemVariant1ValueOutgoingRequest
    extends OctezShellP2pPointPoolEventItemVariant1Value {
  final OctezShellP2pPointPoolEventItemVariant1ValueOutgoingRequestEventKind
  eventKind;

  const OctezShellP2pPointPoolEventItemVariant1ValueOutgoingRequest({
    required this.eventKind,
  });

  factory OctezShellP2pPointPoolEventItemVariant1ValueOutgoingRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellP2pPointPoolEventItemVariant1ValueOutgoingRequest(
      eventKind:
          OctezShellP2pPointPoolEventItemVariant1ValueOutgoingRequestEventKind.fromJson(
            json['event_kind'],
          ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'event_kind': eventKind.toJson()}.notNullValue.cast<String, dynamic>();
}

class OctezShellP2pPointPoolEventItemVariant1ValueAcceptingRequest
    extends OctezShellP2pPointPoolEventItemVariant1Value {
  final OctezShellResponseNetworkLogAcceptingRequestEvent eventKind;
  final OctezShellCryptoBoxPublicKeyHash p2pPeerId;

  const OctezShellP2pPointPoolEventItemVariant1ValueAcceptingRequest({
    required this.eventKind,
    required this.p2pPeerId,
  });

  factory OctezShellP2pPointPoolEventItemVariant1ValueAcceptingRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellP2pPointPoolEventItemVariant1ValueAcceptingRequest(
      eventKind: OctezShellResponseNetworkLogAcceptingRequestEvent.fromJson(
        json['event_kind'],
      ),
      p2pPeerId: OctezShellUnistring.fromJson(json['p2p_peer_id']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'event_kind': eventKind.toJson(),
        'p2p_peer_id': p2pPeerId.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellP2pPointPoolEventItemVariant1ValueRejectingRequest
    extends OctezShellP2pPointPoolEventItemVariant1Value {
  final OctezShellResponseNetworkLogRejectingRequestEvent eventKind;
  final OctezShellCryptoBoxPublicKeyHash p2pPeerId;

  const OctezShellP2pPointPoolEventItemVariant1ValueRejectingRequest({
    required this.eventKind,
    required this.p2pPeerId,
  });

  factory OctezShellP2pPointPoolEventItemVariant1ValueRejectingRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellP2pPointPoolEventItemVariant1ValueRejectingRequest(
      eventKind: OctezShellResponseNetworkLogRejectingRequestEvent.fromJson(
        json['event_kind'],
      ),
      p2pPeerId: OctezShellUnistring.fromJson(json['p2p_peer_id']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'event_kind': eventKind.toJson(),
        'p2p_peer_id': p2pPeerId.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellP2pPointPoolEventItemVariant1ValueRejectingRejected
    extends OctezShellP2pPointPoolEventItemVariant1Value {
  final OctezShellResponseNetworkLogRequestRejectedEvent eventKind;
  final OctezShellCryptoBoxPublicKeyHash? p2pPeerId;

  const OctezShellP2pPointPoolEventItemVariant1ValueRejectingRejected({
    required this.eventKind,
    this.p2pPeerId,
  });

  factory OctezShellP2pPointPoolEventItemVariant1ValueRejectingRejected.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellP2pPointPoolEventItemVariant1ValueRejectingRejected(
      eventKind: OctezShellResponseNetworkLogRequestRejectedEvent.fromJson(
        json['event_kind'],
      ),
      p2pPeerId:
          json.hasValue('p2p_peer_id')
              ? OctezShellUnistring.fromJson(json['p2p_peer_id'])
              : null,
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'event_kind': eventKind.toJson(),
        'p2p_peer_id': p2pPeerId?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellP2pPointPoolEventItemVariant1ValueConnectionEstablished
    extends OctezShellP2pPointPoolEventItemVariant1Value {
  final OctezShellResponseNetworkLogRejectingRequestEvent eventKind;
  final OctezShellCryptoBoxPublicKeyHash p2pPeerId;

  const OctezShellP2pPointPoolEventItemVariant1ValueConnectionEstablished({
    required this.eventKind,
    required this.p2pPeerId,
  });

  factory OctezShellP2pPointPoolEventItemVariant1ValueConnectionEstablished.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellP2pPointPoolEventItemVariant1ValueConnectionEstablished(
      eventKind: OctezShellResponseNetworkLogRejectingRequestEvent.fromJson(
        json['event_kind'],
      ),
      p2pPeerId: OctezShellUnistring.fromJson(json['p2p_peer_id']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'event_kind': eventKind.toJson(),
        'p2p_peer_id': p2pPeerId.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellP2pPointPoolEventItemVariant1ValueDisconnection
    extends OctezShellP2pPointPoolEventItemVariant1Value {
  final OctezShellResponseNetworkLogRejectingRequestEvent eventKind;
  final OctezShellCryptoBoxPublicKeyHash p2pPeerId;

  const OctezShellP2pPointPoolEventItemVariant1ValueDisconnection({
    required this.eventKind,
    required this.p2pPeerId,
  });

  factory OctezShellP2pPointPoolEventItemVariant1ValueDisconnection.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellP2pPointPoolEventItemVariant1ValueDisconnection(
      eventKind: OctezShellResponseNetworkLogRejectingRequestEvent.fromJson(
        json['event_kind'],
      ),
      p2pPeerId: OctezShellUnistring.fromJson(json['p2p_peer_id']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'event_kind': eventKind.toJson(),
        'p2p_peer_id': p2pPeerId.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellP2pPointPoolEventItemVariant1ValueExternalDisconnection
    extends OctezShellP2pPointPoolEventItemVariant1Value {
  final OctezShellResponseNetworkLogRejectingRequestEvent eventKind;
  final OctezShellCryptoBoxPublicKeyHash p2pPeerId;

  const OctezShellP2pPointPoolEventItemVariant1ValueExternalDisconnection({
    required this.eventKind,
    required this.p2pPeerId,
  });

  factory OctezShellP2pPointPoolEventItemVariant1ValueExternalDisconnection.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellP2pPointPoolEventItemVariant1ValueExternalDisconnection(
      eventKind: OctezShellResponseNetworkLogRejectingRequestEvent.fromJson(
        json['event_kind'],
      ),
      p2pPeerId: OctezShellUnistring.fromJson(json['p2p_peer_id']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'event_kind': eventKind.toJson(),
        'p2p_peer_id': p2pPeerId.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

sealed class OctezShellP2pPointPoolEventItem {
  const OctezShellP2pPointPoolEventItem();

  factory OctezShellP2pPointPoolEventItem.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      try {
        return OctezShellP2pPointPoolEventItemTimestampSystem(
          OctezShellTimestampSystem.fromJson(map),
        );
      } catch (_) {}
      try {
        return OctezShellP2pPointPoolEventItemVariant1(
          OctezShellP2pPointPoolEventItemVariant1Value.fromJson(map),
        );
      } catch (_) {}
    }
    try {
      return OctezShellP2pPointPoolEventItemTimestampSystem(
        OctezShellTimestampSystem.fromJson(json),
      );
    } catch (_) {}
    try {
      return OctezShellP2pPointPoolEventItemVariant1(
        OctezShellP2pPointPoolEventItemVariant1Value.fromJson(json),
      );
    } catch (_) {}
    throw OnChainErrors.tezosPlugin(
      'OctezShellP2pPointPoolEventItem',
      reason: 'Cannot parse OctezShellP2pPointPoolEventItem from $json',
    );
  }

  dynamic toJson();
}

class OctezShellP2pPointPoolEventItemTimestampSystem
    extends OctezShellP2pPointPoolEventItem {
  final OctezShellTimestampSystem value;
  const OctezShellP2pPointPoolEventItemTimestampSystem(this.value);

  @override
  dynamic toJson() => value.toJson();
}

class OctezShellP2pPointPoolEventItemVariant1
    extends OctezShellP2pPointPoolEventItem {
  final OctezShellP2pPointPoolEventItemVariant1Value value;
  const OctezShellP2pPointPoolEventItemVariant1(this.value);

  @override
  dynamic toJson() => value.toJson();
}

enum OctezShellResponseProfilerRegisteredBackendRegisteredBackendsItem {
  opentelemetry("opentelemetry"),
  prometheus("prometheus"),
  plainText("plain_text"),
  json("json");

  final String value;
  const OctezShellResponseProfilerRegisteredBackendRegisteredBackendsItem(
    this.value,
  );

  static OctezShellResponseProfilerRegisteredBackendRegisteredBackendsItem
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseProfilerRegisteredBackendRegisteredBackendsItem.",
              ),
    );
  }

  String toJson() => value;
}

sealed class OctezShellBackendsEncodingItemItem {
  const OctezShellBackendsEncodingItemItem();

  factory OctezShellBackendsEncodingItemItem.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      try {
        return OctezShellBackendsEncodingItemItemUnistring(
          OctezShellUnistring.fromJson(map),
        );
      } catch (_) {}
      try {
        return OctezShellBackendsEncodingItemItemVariant1(
          OctezShellResponseProfilerRegisteredBackendRegisteredBackendsItem.fromJson(
            map,
          ),
        );
      } catch (_) {}
    }
    try {
      return OctezShellBackendsEncodingItemItemUnistring(
        OctezShellUnistring.fromJson(json),
      );
    } catch (_) {}
    try {
      return OctezShellBackendsEncodingItemItemVariant1(
        OctezShellResponseProfilerRegisteredBackendRegisteredBackendsItem.fromJson(
          json,
        ),
      );
    } catch (_) {}
    throw OnChainErrors.tezosPlugin(
      'OctezShellBackendsEncodingItemItem',
      reason: 'Cannot parse OctezShellBackendsEncodingItemItem from $json',
    );
  }

  dynamic toJson();
}

class OctezShellBackendsEncodingItemItemUnistring
    extends OctezShellBackendsEncodingItemItem {
  final OctezShellUnistring value;
  const OctezShellBackendsEncodingItemItemUnistring(this.value);

  @override
  dynamic toJson() => value.toJson();
}

class OctezShellBackendsEncodingItemItemVariant1
    extends OctezShellBackendsEncodingItemItem {
  final OctezShellResponseProfilerRegisteredBackendRegisteredBackendsItem value;
  const OctezShellBackendsEncodingItemItemVariant1(this.value);

  @override
  dynamic toJson() => value.toJson();
}

sealed class OctezShellResponseStatsMemory {
  const OctezShellResponseStatsMemory();

  factory OctezShellResponseStatsMemory.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('page_size') &&
          map.hasValue('size') &&
          map.hasValue('resident') &&
          map.hasValue('shared') &&
          map.hasValue('text') &&
          map.hasValue('lib') &&
          map.hasValue('data') &&
          map.hasValue('dt')) {
        return OctezShellResponseStatsMemoryLinuxProcStatm.fromJson(map);
      }
      if (map.hasValue('page_size') &&
          map.hasValue('mem') &&
          map.hasValue('resident')) {
        return OctezShellResponseStatsMemoryDarwinPs.fromJson(map);
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezShellResponseStatsMemory',
      reason: 'Cannot parse OctezShellResponseStatsMemory from $json',
    );
  }

  dynamic toJson();
}

class OctezShellResponseStatsMemoryLinuxProcStatm
    extends OctezShellResponseStatsMemory {
  final int pageSize;
  final OctezShellInt64 size;
  final OctezShellInt64 resident;
  final OctezShellInt64 shared;
  final OctezShellInt64 text;
  final OctezShellInt64 lib;
  final OctezShellInt64 data;
  final OctezShellInt64 dt;

  const OctezShellResponseStatsMemoryLinuxProcStatm({
    required this.pageSize,
    required this.size,
    required this.resident,
    required this.shared,
    required this.text,
    required this.lib,
    required this.data,
    required this.dt,
  });

  factory OctezShellResponseStatsMemoryLinuxProcStatm.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseStatsMemoryLinuxProcStatm(
      pageSize: json.valueAsInt('page_size'),
      size:
          (json['size'] is num
              ? json['size'].toString()
              : json.valueAsString('size')),
      resident:
          (json['resident'] is num
              ? json['resident'].toString()
              : json.valueAsString('resident')),
      shared:
          (json['shared'] is num
              ? json['shared'].toString()
              : json.valueAsString('shared')),
      text:
          (json['text'] is num
              ? json['text'].toString()
              : json.valueAsString('text')),
      lib:
          (json['lib'] is num
              ? json['lib'].toString()
              : json.valueAsString('lib')),
      data:
          (json['data'] is num
              ? json['data'].toString()
              : json.valueAsString('data')),
      dt:
          (json['dt'] is num
              ? json['dt'].toString()
              : json.valueAsString('dt')),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'page_size': pageSize,
        'size': size,
        'resident': resident,
        'shared': shared,
        'text': text,
        'lib': lib,
        'data': data,
        'dt': dt,
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseStatsMemoryDarwinPs
    extends OctezShellResponseStatsMemory {
  final int pageSize;
  final num mem;
  final OctezShellInt64 resident;

  const OctezShellResponseStatsMemoryDarwinPs({
    required this.pageSize,
    required this.mem,
    required this.resident,
  });

  factory OctezShellResponseStatsMemoryDarwinPs.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseStatsMemoryDarwinPs(
      pageSize: json.valueAsInt('page_size'),
      mem: json.valueAsNum('mem'),
      resident:
          (json['resident'] is num
              ? json['resident'].toString()
              : json.valueAsString('resident')),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'page_size': pageSize,
        'mem': mem,
        'resident': resident,
      }.notNullValue.cast<String, dynamic>();
}

sealed class OctezShellResponseVersionVersionAdditionalInfo {
  const OctezShellResponseVersionVersionAdditionalInfo();

  factory OctezShellResponseVersionVersionAdditionalInfo.fromJson(
    dynamic json,
  ) {
    if (json is String) {
      return switch (json) {
        'dev' => const OctezShellResponseVersionVersionAdditionalInfoDev(),
        'release' =>
          const OctezShellResponseVersionVersionAdditionalInfoRelease(),
        _ =>
          throw OnChainErrors.tezosPlugin(
            'OctezShellResponseVersionVersionAdditionalInfo',
            reason:
                'Unknown OctezShellResponseVersionVersionAdditionalInfo: $json',
          ),
      };
    }
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('rc')) {
        return OctezShellResponseVersionVersionAdditionalInfoRc.fromJson(map);
      }
      if (map.hasValue('rc_dev')) {
        return OctezShellResponseVersionVersionAdditionalInfoRCDev.fromJson(
          map,
        );
      }
      if (map.hasValue('beta')) {
        return OctezShellResponseVersionVersionAdditionalInfoBeta.fromJson(map);
      }
      if (map.hasValue('beta_dev')) {
        return OctezShellResponseVersionVersionAdditionalInfoBetaDev.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezShellResponseVersionVersionAdditionalInfo',
      reason:
          'Cannot parse OctezShellResponseVersionVersionAdditionalInfo from $json',
    );
  }

  dynamic toJson();
}

class OctezShellResponseVersionVersionAdditionalInfoDev
    extends OctezShellResponseVersionVersionAdditionalInfo {
  const OctezShellResponseVersionVersionAdditionalInfoDev();

  @override
  String toJson() => 'dev';
}

class OctezShellResponseVersionVersionAdditionalInfoRc
    extends OctezShellResponseVersionVersionAdditionalInfo {
  final int rc;

  const OctezShellResponseVersionVersionAdditionalInfoRc({required this.rc});

  factory OctezShellResponseVersionVersionAdditionalInfoRc.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseVersionVersionAdditionalInfoRc(
      rc: json.valueAsInt('rc'),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'rc': rc}.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseVersionVersionAdditionalInfoRelease
    extends OctezShellResponseVersionVersionAdditionalInfo {
  const OctezShellResponseVersionVersionAdditionalInfoRelease();

  @override
  String toJson() => 'release';
}

class OctezShellResponseVersionVersionAdditionalInfoRCDev
    extends OctezShellResponseVersionVersionAdditionalInfo {
  final int rcDev;

  const OctezShellResponseVersionVersionAdditionalInfoRCDev({
    required this.rcDev,
  });

  factory OctezShellResponseVersionVersionAdditionalInfoRCDev.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseVersionVersionAdditionalInfoRCDev(
      rcDev: json.valueAsInt('rc_dev'),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'rc_dev': rcDev}.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseVersionVersionAdditionalInfoBeta
    extends OctezShellResponseVersionVersionAdditionalInfo {
  final int beta;

  const OctezShellResponseVersionVersionAdditionalInfoBeta({
    required this.beta,
  });

  factory OctezShellResponseVersionVersionAdditionalInfoBeta.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseVersionVersionAdditionalInfoBeta(
      beta: json.valueAsInt('beta'),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'beta': beta}.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseVersionVersionAdditionalInfoBetaDev
    extends OctezShellResponseVersionVersionAdditionalInfo {
  final int betaDev;

  const OctezShellResponseVersionVersionAdditionalInfoBetaDev({
    required this.betaDev,
  });

  factory OctezShellResponseVersionVersionAdditionalInfoBetaDev.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseVersionVersionAdditionalInfoBetaDev(
      betaDev: json.valueAsInt('beta_dev'),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'beta_dev': betaDev}.notNullValue.cast<String, dynamic>();
}

enum OctezShellResponseWorkersBlockValidatorStatusLaunchingPhase {
  launching("launching");

  final String value;
  const OctezShellResponseWorkersBlockValidatorStatusLaunchingPhase(this.value);

  static OctezShellResponseWorkersBlockValidatorStatusLaunchingPhase fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseWorkersBlockValidatorStatusLaunchingPhase.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellResponseWorkersBlockValidatorStatusClosingPhase {
  closing("closing");

  final String value;
  const OctezShellResponseWorkersBlockValidatorStatusClosingPhase(this.value);

  static OctezShellResponseWorkersBlockValidatorStatusClosingPhase fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseWorkersBlockValidatorStatusClosingPhase.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellResponseWorkersBlockValidatorStatusClosedPhase {
  closed("closed");

  final String value;
  const OctezShellResponseWorkersBlockValidatorStatusClosedPhase(this.value);

  static OctezShellResponseWorkersBlockValidatorStatusClosedPhase fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseWorkersBlockValidatorStatusClosedPhase.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellResponseWorkersBlockValidatorStatusCrashedPhase {
  crashed("crashed");

  final String value;
  const OctezShellResponseWorkersBlockValidatorStatusCrashedPhase(this.value);

  static OctezShellResponseWorkersBlockValidatorStatusCrashedPhase fromJson(
    dynamic json,
  ) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseWorkersBlockValidatorStatusCrashedPhase.",
              ),
    );
  }

  String toJson() => value;
}

sealed class OctezShellResponseWorkersBlockValidatorStatus {
  const OctezShellResponseWorkersBlockValidatorStatus();

  factory OctezShellResponseWorkersBlockValidatorStatus.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['phase'] == "crashed" &&
          map.hasValue('birth') &&
          map.hasValue('since') &&
          map.hasValue('errors')) {
        return OctezShellResponseWorkersBlockValidatorStatusCrashed.fromJson(
          map,
        );
      }
      if (map['phase'] == "closing" &&
          map.hasValue('birth') &&
          map.hasValue('since')) {
        return OctezShellResponseWorkersBlockValidatorStatusClosing.fromJson(
          map,
        );
      }
      if (map['phase'] == "closed" &&
          map.hasValue('birth') &&
          map.hasValue('since')) {
        return OctezShellResponseWorkersBlockValidatorStatusClosed.fromJson(
          map,
        );
      }
      if (map['phase'] == "launching" && map.hasValue('since')) {
        return OctezShellResponseWorkersBlockValidatorStatusLaunching.fromJson(
          map,
        );
      }
      if (map['phase'] == "running" && map.hasValue('since')) {
        return OctezShellResponseWorkersBlockValidatorStatusRunning.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezShellResponseWorkersBlockValidatorStatus',
      reason:
          'Cannot parse OctezShellResponseWorkersBlockValidatorStatus from $json',
    );
  }

  dynamic toJson();
}

class OctezShellResponseWorkersBlockValidatorStatusLaunching
    extends OctezShellResponseWorkersBlockValidatorStatus {
  final OctezShellResponseWorkersBlockValidatorStatusLaunchingPhase phase;
  final OctezShellTimestampSystem since;

  const OctezShellResponseWorkersBlockValidatorStatusLaunching({
    required this.phase,
    required this.since,
  });

  factory OctezShellResponseWorkersBlockValidatorStatusLaunching.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersBlockValidatorStatusLaunching(
      phase:
          OctezShellResponseWorkersBlockValidatorStatusLaunchingPhase.fromJson(
            json['phase'],
          ),
      since: OctezShellTimestampSystem.fromJson(json['since']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'phase': phase.toJson(),
        'since': since.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseWorkersBlockValidatorStatusRunning
    extends OctezShellResponseWorkersBlockValidatorStatus {
  final OctezShellP2pPointStateRunningEventKind phase;
  final OctezShellTimestampSystem since;

  const OctezShellResponseWorkersBlockValidatorStatusRunning({
    required this.phase,
    required this.since,
  });

  factory OctezShellResponseWorkersBlockValidatorStatusRunning.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersBlockValidatorStatusRunning(
      phase: OctezShellP2pPointStateRunningEventKind.fromJson(json['phase']),
      since: OctezShellTimestampSystem.fromJson(json['since']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'phase': phase.toJson(),
        'since': since.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseWorkersBlockValidatorStatusClosing
    extends OctezShellResponseWorkersBlockValidatorStatus {
  final OctezShellResponseWorkersBlockValidatorStatusClosingPhase phase;
  final OctezShellTimestampSystem birth;
  final OctezShellTimestampSystem since;

  const OctezShellResponseWorkersBlockValidatorStatusClosing({
    required this.phase,
    required this.birth,
    required this.since,
  });

  factory OctezShellResponseWorkersBlockValidatorStatusClosing.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersBlockValidatorStatusClosing(
      phase: OctezShellResponseWorkersBlockValidatorStatusClosingPhase.fromJson(
        json['phase'],
      ),
      birth: OctezShellTimestampSystem.fromJson(json['birth']),
      since: OctezShellTimestampSystem.fromJson(json['since']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'phase': phase.toJson(),
        'birth': birth.toJson(),
        'since': since.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseWorkersBlockValidatorStatusClosed
    extends OctezShellResponseWorkersBlockValidatorStatus {
  final OctezShellResponseWorkersBlockValidatorStatusClosedPhase phase;
  final OctezShellTimestampSystem birth;
  final OctezShellTimestampSystem since;

  const OctezShellResponseWorkersBlockValidatorStatusClosed({
    required this.phase,
    required this.birth,
    required this.since,
  });

  factory OctezShellResponseWorkersBlockValidatorStatusClosed.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersBlockValidatorStatusClosed(
      phase: OctezShellResponseWorkersBlockValidatorStatusClosedPhase.fromJson(
        json['phase'],
      ),
      birth: OctezShellTimestampSystem.fromJson(json['birth']),
      since: OctezShellTimestampSystem.fromJson(json['since']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'phase': phase.toJson(),
        'birth': birth.toJson(),
        'since': since.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseWorkersBlockValidatorStatusCrashed
    extends OctezShellResponseWorkersBlockValidatorStatus {
  final OctezShellResponseWorkersBlockValidatorStatusCrashedPhase phase;
  final OctezShellTimestampSystem birth;
  final OctezShellTimestampSystem since;
  final OctezShellError errors;

  const OctezShellResponseWorkersBlockValidatorStatusCrashed({
    required this.phase,
    required this.birth,
    required this.since,
    required this.errors,
  });

  factory OctezShellResponseWorkersBlockValidatorStatusCrashed.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersBlockValidatorStatusCrashed(
      phase: OctezShellResponseWorkersBlockValidatorStatusCrashedPhase.fromJson(
        json['phase'],
      ),
      birth: OctezShellTimestampSystem.fromJson(json['birth']),
      since: OctezShellTimestampSystem.fromJson(json['since']),
      errors: Map<String, dynamic>.from(json['errors'] as Map),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'phase': phase.toJson(),
        'birth': birth.toJson(),
        'since': since.toJson(),
        'errors': errors,
      }.notNullValue.cast<String, dynamic>();
}

sealed class OctezShellResponseWorkersBlockValidatorPendingRequestsItemRequest {
  const OctezShellResponseWorkersBlockValidatorPendingRequestsItemRequest();

  factory OctezShellResponseWorkersBlockValidatorPendingRequestsItemRequest.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('block') && map.hasValue('chain_id')) {
        return OctezShellResponseWorkersBlockValidatorPendingRequestsItemRequestValidation.fromJson(
          map,
        );
      }
      if (map.hasValue('chain_id') && map.hasValue('level')) {
        return OctezShellResponseWorkersBlockValidatorPendingRequestsItemRequestPreapplication.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezShellResponseWorkersBlockValidatorPendingRequestsItemRequest',
      reason:
          'Cannot parse OctezShellResponseWorkersBlockValidatorPendingRequestsItemRequest from $json',
    );
  }

  dynamic toJson();
}

class OctezShellResponseWorkersBlockValidatorPendingRequestsItemRequestValidation
    extends OctezShellResponseWorkersBlockValidatorPendingRequestsItemRequest {
  final OctezShellBlockHash block;
  final OctezShellChainId chainId;
  final OctezShellCryptoBoxPublicKeyHash? peer;

  const OctezShellResponseWorkersBlockValidatorPendingRequestsItemRequestValidation({
    required this.block,
    required this.chainId,
    this.peer,
  });

  factory OctezShellResponseWorkersBlockValidatorPendingRequestsItemRequestValidation.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersBlockValidatorPendingRequestsItemRequestValidation(
      block: OctezShellUnistring.fromJson(json['block']),
      chainId: OctezShellUnistring.fromJson(json['chain_id']),
      peer:
          json.hasValue('peer')
              ? OctezShellUnistring.fromJson(json['peer'])
              : null,
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'block': block.toJson(),
        'chain_id': chainId.toJson(),
        'peer': peer?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseWorkersBlockValidatorPendingRequestsItemRequestPreapplication
    extends OctezShellResponseWorkersBlockValidatorPendingRequestsItemRequest {
  final OctezShellChainId chainId;
  final int level;

  const OctezShellResponseWorkersBlockValidatorPendingRequestsItemRequestPreapplication({
    required this.chainId,
    required this.level,
  });

  factory OctezShellResponseWorkersBlockValidatorPendingRequestsItemRequestPreapplication.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersBlockValidatorPendingRequestsItemRequestPreapplication(
      chainId: OctezShellUnistring.fromJson(json['chain_id']),
      level: json.valueAsInt('level'),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'chain_id': chainId.toJson(),
        'level': level,
      }.notNullValue.cast<String, dynamic>();
}

sealed class OctezShellResponseWorkersChainValidatorsChainIdPendingRequestsItemRequest {
  const OctezShellResponseWorkersChainValidatorsChainIdPendingRequestsItemRequest();

  factory OctezShellResponseWorkersChainValidatorsChainIdPendingRequestsItemRequest.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('hash')) {
        return OctezShellResponseWorkersChainValidatorsChainIdPendingRequestsItemRequestHash.fromJson(
          map,
        );
      }
      if (map.hasValue('peer_id')) {
        return OctezShellResponseWorkersChainValidatorsChainIdPendingRequestsItemRequestPeerId.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezShellResponseWorkersChainValidatorsChainIdPendingRequestsItemRequest',
      reason:
          'Cannot parse OctezShellResponseWorkersChainValidatorsChainIdPendingRequestsItemRequest from $json',
    );
  }

  dynamic toJson();
}

class OctezShellResponseWorkersChainValidatorsChainIdPendingRequestsItemRequestHash
    extends
        OctezShellResponseWorkersChainValidatorsChainIdPendingRequestsItemRequest {
  final OctezShellBlockHash hash;

  const OctezShellResponseWorkersChainValidatorsChainIdPendingRequestsItemRequestHash({
    required this.hash,
  });

  factory OctezShellResponseWorkersChainValidatorsChainIdPendingRequestsItemRequestHash.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersChainValidatorsChainIdPendingRequestsItemRequestHash(
      hash: OctezShellUnistring.fromJson(json['hash']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'hash': hash.toJson()}.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseWorkersChainValidatorsChainIdPendingRequestsItemRequestPeerId
    extends
        OctezShellResponseWorkersChainValidatorsChainIdPendingRequestsItemRequest {
  final OctezShellCryptoBoxPublicKeyHash peerId;

  const OctezShellResponseWorkersChainValidatorsChainIdPendingRequestsItemRequestPeerId({
    required this.peerId,
  });

  factory OctezShellResponseWorkersChainValidatorsChainIdPendingRequestsItemRequestPeerId.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersChainValidatorsChainIdPendingRequestsItemRequestPeerId(
      peerId: OctezShellUnistring.fromJson(json['peer_id']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'peer_id': peerId.toJson()}.notNullValue.cast<String, dynamic>();
}

enum OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItemRequestNewHeadRequest {
  newHead("new_head");

  final String value;
  const OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItemRequestNewHeadRequest(
    this.value,
  );

  static OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItemRequestNewHeadRequest
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItemRequestNewHeadRequest.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItemRequestNewBranchRequest {
  newBranch("new_branch");

  final String value;
  const OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItemRequestNewBranchRequest(
    this.value,
  );

  static OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItemRequestNewBranchRequest
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItemRequestNewBranchRequest.",
              ),
    );
  }

  String toJson() => value;
}

sealed class OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItemRequest {
  const OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItemRequest();

  factory OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItemRequest.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['request'] == "new_branch" &&
          map.hasValue('block') &&
          map.hasValue('locators')) {
        return OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItemRequestNewBranch.fromJson(
          map,
        );
      }
      if (map['request'] == "new_head" && map.hasValue('block')) {
        return OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItemRequestNewHead.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItemRequest',
      reason:
          'Cannot parse OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItemRequest from $json',
    );
  }

  dynamic toJson();
}

class OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItemRequestNewHead
    extends
        OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItemRequest {
  final OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItemRequestNewHeadRequest
  request;
  final OctezShellBlockHash block;

  const OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItemRequestNewHead({
    required this.request,
    required this.block,
  });

  factory OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItemRequestNewHead.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItemRequestNewHead(
      request:
          OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItemRequestNewHeadRequest.fromJson(
            json['request'],
          ),
      block: OctezShellUnistring.fromJson(json['block']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'request': request.toJson(),
        'block': block.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItemRequestNewBranch
    extends
        OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItemRequest {
  final OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItemRequestNewBranchRequest
  request;
  final OctezShellBlockHash block;
  final int locators;

  const OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItemRequestNewBranch({
    required this.request,
    required this.block,
    required this.locators,
  });

  factory OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItemRequestNewBranch.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItemRequestNewBranch(
      request:
          OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItemRequestNewBranchRequest.fromJson(
            json['request'],
          ),
      block: OctezShellUnistring.fromJson(json['block']),
      locators: json.valueAsInt('locators'),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'request': request.toJson(),
        'block': block.toJson(),
        'locators': locators,
      }.notNullValue.cast<String, dynamic>();
}

enum OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestFlushRequest {
  flush("flush");

  final String value;
  const OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestFlushRequest(
    this.value,
  );

  static OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestFlushRequest
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestFlushRequest.",
              ),
    );
  }

  String toJson() => value;
}

/// If 'ignored', the new validated block is ignored since the current head fitness is better. If 'branch', we have set our head to a new validated block which is not the direct successor of the previous head. If 'increment', the new validated head is the direct successor of the previous head.
enum OctezShellChainUpdate {
  branch("branch"),
  ignored("ignored"),
  increment("increment");

  final String value;
  const OctezShellChainUpdate(this.value);

  static OctezShellChainUpdate fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellChainUpdate.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestNotifyRequest {
  notify("notify");

  final String value;
  const OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestNotifyRequest(
    this.value,
  );

  static OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestNotifyRequest
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestNotifyRequest.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestInjectRequest {
  inject("inject");

  final String value;
  const OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestInjectRequest(
    this.value,
  );

  static OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestInjectRequest
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestInjectRequest.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestArrivedRequest {
  arrived("arrived");

  final String value;
  const OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestArrivedRequest(
    this.value,
  );

  static OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestArrivedRequest
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestArrivedRequest.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestAdvertiseRequest {
  advertise("advertise");

  final String value;
  const OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestAdvertiseRequest(
    this.value,
  );

  static OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestAdvertiseRequest
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestAdvertiseRequest.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestLeftoverRequest {
  leftover("leftover");

  final String value;
  const OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestLeftoverRequest(
    this.value,
  );

  static OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestLeftoverRequest
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestLeftoverRequest.",
              ),
    );
  }

  String toJson() => value;
}

enum OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestBanRequest {
  ban("ban");

  final String value;
  const OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestBanRequest(
    this.value,
  );

  static OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestBanRequest
  fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                "Invalid OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestBanRequest.",
              ),
    );
  }

  String toJson() => value;
}

sealed class OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequest {
  const OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequest();

  factory OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequest.fromJson(
    dynamic json,
  ) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['request'] == "flush" &&
          map.hasValue('block') &&
          map.hasValue('event')) {
        return OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestFlush.fromJson(
          map,
        );
      }
      if (map['request'] == "notify" &&
          map.hasValue('peer') &&
          map.hasValue('mempool')) {
        return OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestNotify.fromJson(
          map,
        );
      }
      if (map['request'] == "inject" &&
          map.hasValue('operation') &&
          map.hasValue('force')) {
        return OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestInject.fromJson(
          map,
        );
      }
      if (map['request'] == "arrived" &&
          map.hasValue('operation_hash') &&
          map.hasValue('operation')) {
        return OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestArrived.fromJson(
          map,
        );
      }
      if (map['request'] == "ban" && map.hasValue('operation_hash')) {
        return OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestBan.fromJson(
          map,
        );
      }
      if (map['request'] == "advertise") {
        return OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestAdvertise.fromJson(
          map,
        );
      }
      if (map['request'] == "leftover") {
        return OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestLeftover.fromJson(
          map,
        );
      }
    }
    throw OnChainErrors.tezosPlugin(
      'OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequest',
      reason:
          'Cannot parse OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequest from $json',
    );
  }

  dynamic toJson();
}

class OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestFlush
    extends
        OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequest {
  final OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestFlushRequest
  request;
  final OctezShellBlockHash block;
  final OctezShellChainUpdate event;

  const OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestFlush({
    required this.request,
    required this.block,
    required this.event,
  });

  factory OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestFlush.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestFlush(
      request:
          OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestFlushRequest.fromJson(
            json['request'],
          ),
      block: OctezShellUnistring.fromJson(json['block']),
      event: OctezShellChainUpdate.fromJson(json['event']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'request': request.toJson(),
        'block': block.toJson(),
        'event': event.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestNotify
    extends
        OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequest {
  final OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestNotifyRequest
  request;
  final OctezShellCryptoBoxPublicKeyHash peer;
  final OctezShellMempool mempool;

  const OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestNotify({
    required this.request,
    required this.peer,
    required this.mempool,
  });

  factory OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestNotify.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestNotify(
      request:
          OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestNotifyRequest.fromJson(
            json['request'],
          ),
      peer: OctezShellUnistring.fromJson(json['peer']),
      mempool: json.valueTo<OctezShellMempool, Map<String, dynamic>>(
        key: 'mempool',
        parse: (v) => OctezShellMempool.fromJson(v),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'request': request.toJson(),
        'peer': peer.toJson(),
        'mempool': mempool.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestInject
    extends
        OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequest {
  final OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestInjectRequest
  request;
  final OctezShellOperation operation;
  final bool force;

  const OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestInject({
    required this.request,
    required this.operation,
    required this.force,
  });

  factory OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestInject.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestInject(
      request:
          OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestInjectRequest.fromJson(
            json['request'],
          ),
      operation: json.valueTo<OctezShellOperation, Map<String, dynamic>>(
        key: 'operation',
        parse: (v) => OctezShellOperation.fromJson(v),
      ),
      force: json.valueAsBool('force'),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'request': request.toJson(),
        'operation': operation.toJson(),
        'force': force,
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestArrived
    extends
        OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequest {
  final OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestArrivedRequest
  request;
  final OctezShellOperationHash operationHash;
  final OctezShellOperation operation;

  const OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestArrived({
    required this.request,
    required this.operationHash,
    required this.operation,
  });

  factory OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestArrived.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestArrived(
      request:
          OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestArrivedRequest.fromJson(
            json['request'],
          ),
      operationHash: OctezShellUnistring.fromJson(json['operation_hash']),
      operation: json.valueTo<OctezShellOperation, Map<String, dynamic>>(
        key: 'operation',
        parse: (v) => OctezShellOperation.fromJson(v),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'request': request.toJson(),
        'operation_hash': operationHash.toJson(),
        'operation': operation.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestAdvertise
    extends
        OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequest {
  final OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestAdvertiseRequest
  request;

  const OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestAdvertise({
    required this.request,
  });

  factory OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestAdvertise.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestAdvertise(
      request:
          OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestAdvertiseRequest.fromJson(
            json['request'],
          ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'request': request.toJson()}.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestLeftover
    extends
        OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequest {
  final OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestLeftoverRequest
  request;

  const OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestLeftover({
    required this.request,
  });

  factory OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestLeftover.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestLeftover(
      request:
          OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestLeftoverRequest.fromJson(
            json['request'],
          ),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {'request': request.toJson()}.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestBan
    extends
        OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequest {
  final OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestBanRequest
  request;
  final OctezShellOperationHash operationHash;

  const OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestBan({
    required this.request,
    required this.operationHash,
  });

  factory OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestBan.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestBan(
      request:
          OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequestBanRequest.fromJson(
            json['request'],
          ),
      operationHash: OctezShellUnistring.fromJson(json['operation_hash']),
    );
  }

  @override
  Map<String, dynamic> toJson() =>
      {
        'request': request.toJson(),
        'operation_hash': operationHash.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellBlsAggregateProofsBody {
  final OctezShellBls12381PublicKey publicKey;
  final List<OctezShellBls12381Signature> proofs;

  const OctezShellBlsAggregateProofsBody({
    required this.publicKey,
    required this.proofs,
  });

  factory OctezShellBlsAggregateProofsBody.fromJson(Map<String, dynamic> json) {
    return OctezShellBlsAggregateProofsBody(
      publicKey: OctezShellUnistring.fromJson(json['public_key']),
      proofs:
          json
              .valueEnsureAsList<dynamic>('proofs')
              .map((e) => OctezShellUnistring.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'public_key': publicKey.toJson(),
        'proofs': proofs.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseBlsAggregatePublicKeys {
  final OctezShellBls12381PublicKey publicKey;
  final OctezShellBls12381PublicKeyHash publicKeyHash;

  const OctezShellResponseBlsAggregatePublicKeys({
    required this.publicKey,
    required this.publicKeyHash,
  });

  factory OctezShellResponseBlsAggregatePublicKeys.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseBlsAggregatePublicKeys(
      publicKey: OctezShellUnistring.fromJson(json['public_key']),
      publicKeyHash: OctezShellUnistring.fromJson(json['public_key_hash']),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'public_key': publicKey.toJson(),
        'public_key_hash': publicKeyHash.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellBlsAggregatePublicKeysBodyItem {
  final OctezShellBls12381PublicKey publicKey;
  final OctezShellBls12381Signature proof;

  const OctezShellBlsAggregatePublicKeysBodyItem({
    required this.publicKey,
    required this.proof,
  });

  factory OctezShellBlsAggregatePublicKeysBodyItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellBlsAggregatePublicKeysBodyItem(
      publicKey: OctezShellUnistring.fromJson(json['public_key']),
      proof: OctezShellUnistring.fromJson(json['proof']),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'public_key': publicKey.toJson(),
        'proof': proof.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellBlsAggregateSignaturesBody {
  final OctezShellBls12381PublicKey publicKey;
  final String message;
  final List<OctezShellBls12381Signature> signatureShares;

  const OctezShellBlsAggregateSignaturesBody({
    required this.publicKey,
    required this.message,
    required this.signatureShares,
  });

  factory OctezShellBlsAggregateSignaturesBody.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellBlsAggregateSignaturesBody(
      publicKey: OctezShellUnistring.fromJson(json['public_key']),
      message:
          (json['message'] is num
              ? json['message'].toString()
              : json.valueAsString('message')),
      signatureShares:
          json
              .valueEnsureAsList<dynamic>('signature_shares')
              .map((e) => OctezShellUnistring.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'public_key': publicKey.toJson(),
        'message': message,
        'signature_shares': signatureShares.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellBlsThresholdSignaturesBodySignatureSharesItem {
  final int id;
  final OctezShellBls12381Signature signature;

  const OctezShellBlsThresholdSignaturesBodySignatureSharesItem({
    required this.id,
    required this.signature,
  });

  factory OctezShellBlsThresholdSignaturesBodySignatureSharesItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellBlsThresholdSignaturesBodySignatureSharesItem(
      id: json.valueAsInt('id'),
      signature: OctezShellUnistring.fromJson(json['signature']),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'signature': signature.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellBlsThresholdSignaturesBody {
  final OctezShellBls12381PublicKey publicKey;
  final String message;
  final List<OctezShellBlsThresholdSignaturesBodySignatureSharesItem>
  signatureShares;

  const OctezShellBlsThresholdSignaturesBody({
    required this.publicKey,
    required this.message,
    required this.signatureShares,
  });

  factory OctezShellBlsThresholdSignaturesBody.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellBlsThresholdSignaturesBody(
      publicKey: OctezShellUnistring.fromJson(json['public_key']),
      message:
          (json['message'] is num
              ? json['message'].toString()
              : json.valueAsString('message')),
      signatureShares:
          json
              .valueEnsureAsList<Map<String, dynamic>>('signature_shares')
              .map(
                (e) =>
                    OctezShellBlsThresholdSignaturesBodySignatureSharesItem.fromJson(
                      e,
                    ),
              )
              .toList(),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'public_key': publicKey.toJson(),
        'message': message,
        'signature_shares': signatureShares.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellChainsChainIdBody {
  final bool bootstrapped;

  const OctezShellChainsChainIdBody({required this.bootstrapped});

  factory OctezShellChainsChainIdBody.fromJson(Map<String, dynamic> json) {
    return OctezShellChainsChainIdBody(
      bootstrapped: json.valueAsBool('bootstrapped'),
    );
  }

  Map<String, dynamic> toJson() =>
      {'bootstrapped': bootstrapped}.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseChainsChainIdActivePeersHeadsActivePeersHeadsItem {
  final OctezShellCryptoBoxPublicKeyHash peerId;
  final OctezShellBlockHash blockHash;
  final int blockLevel;

  const OctezShellResponseChainsChainIdActivePeersHeadsActivePeersHeadsItem({
    required this.peerId,
    required this.blockHash,
    required this.blockLevel,
  });

  factory OctezShellResponseChainsChainIdActivePeersHeadsActivePeersHeadsItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseChainsChainIdActivePeersHeadsActivePeersHeadsItem(
      peerId: OctezShellUnistring.fromJson(json['peer_id']),
      blockHash: OctezShellUnistring.fromJson(json['block_hash']),
      blockLevel: json.valueAsInt('block_level'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'peer_id': peerId.toJson(),
        'block_hash': blockHash.toJson(),
        'block_level': blockLevel,
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseChainsChainIdActivePeersHeads {
  final List<
    OctezShellResponseChainsChainIdActivePeersHeadsActivePeersHeadsItem
  >
  activePeersHeads;

  const OctezShellResponseChainsChainIdActivePeersHeads({
    required this.activePeersHeads,
  });

  factory OctezShellResponseChainsChainIdActivePeersHeads.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseChainsChainIdActivePeersHeads(
      activePeersHeads:
          json
              .valueEnsureAsList<Map<String, dynamic>>('active_peers_heads')
              .map(
                (e) =>
                    OctezShellResponseChainsChainIdActivePeersHeadsActivePeersHeadsItem.fromJson(
                      e,
                    ),
              )
              .toList(),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'active_peers_heads': activePeersHeads.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseChainsChainIdDelegatorsContributionInt32PkhExternalDelegatorsItem {
  final OctezShellUnistring delegatorContractHash;
  final OctezShellInt64 contribution;

  const OctezShellResponseChainsChainIdDelegatorsContributionInt32PkhExternalDelegatorsItem({
    required this.delegatorContractHash,
    required this.contribution,
  });

  factory OctezShellResponseChainsChainIdDelegatorsContributionInt32PkhExternalDelegatorsItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseChainsChainIdDelegatorsContributionInt32PkhExternalDelegatorsItem(
      delegatorContractHash: OctezShellUnistring.fromJson(
        json['delegator_contract_hash'],
      ),
      contribution:
          (json['contribution'] is num
              ? json['contribution'].toString()
              : json.valueAsString('contribution')),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'delegator_contract_hash': delegatorContractHash.toJson(),
        'contribution': contribution,
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseChainsChainIdDelegatorsContributionInt32Pkh {
  final OctezShellInt64 ownDelegated;
  final List<
    OctezShellResponseChainsChainIdDelegatorsContributionInt32PkhExternalDelegatorsItem
  >
  externalDelegators;
  final OctezShellInt64 formerDelegatorsUnstakeRequests;
  final OctezShellInt64 overstaked;
  final OctezShellInt64 totalDelegatedIncludingOverdelegated;
  final OctezShellInt64 totalDelegatedAfterLimits;
  final OctezShellInt64 overdelegated;

  const OctezShellResponseChainsChainIdDelegatorsContributionInt32Pkh({
    required this.ownDelegated,
    required this.externalDelegators,
    required this.formerDelegatorsUnstakeRequests,
    required this.overstaked,
    required this.totalDelegatedIncludingOverdelegated,
    required this.totalDelegatedAfterLimits,
    required this.overdelegated,
  });

  factory OctezShellResponseChainsChainIdDelegatorsContributionInt32Pkh.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseChainsChainIdDelegatorsContributionInt32Pkh(
      ownDelegated:
          (json['own_delegated'] is num
              ? json['own_delegated'].toString()
              : json.valueAsString('own_delegated')),
      externalDelegators:
          json
              .valueEnsureAsList<Map<String, dynamic>>('external_delegators')
              .map(
                (e) =>
                    OctezShellResponseChainsChainIdDelegatorsContributionInt32PkhExternalDelegatorsItem.fromJson(
                      e,
                    ),
              )
              .toList(),
      formerDelegatorsUnstakeRequests:
          (json['former_delegators_unstake_requests'] is num
              ? json['former_delegators_unstake_requests'].toString()
              : json.valueAsString('former_delegators_unstake_requests')),
      overstaked:
          (json['overstaked'] is num
              ? json['overstaked'].toString()
              : json.valueAsString('overstaked')),
      totalDelegatedIncludingOverdelegated:
          (json['total_delegated_including_overdelegated'] is num
              ? json['total_delegated_including_overdelegated'].toString()
              : json.valueAsString('total_delegated_including_overdelegated')),
      totalDelegatedAfterLimits:
          (json['total_delegated_after_limits'] is num
              ? json['total_delegated_after_limits'].toString()
              : json.valueAsString('total_delegated_after_limits')),
      overdelegated:
          (json['overdelegated'] is num
              ? json['overdelegated'].toString()
              : json.valueAsString('overdelegated')),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'own_delegated': ownDelegated,
        'external_delegators':
            externalDelegators.map((e) => e.toJson()).toList(),
        'former_delegators_unstake_requests': formerDelegatorsUnstakeRequests,
        'overstaked': overstaked,
        'total_delegated_including_overdelegated':
            totalDelegatedIncludingOverdelegated,
        'total_delegated_after_limits': totalDelegatedAfterLimits,
        'overdelegated': overdelegated,
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseChainsChainIdInvalidBlocksItem {
  final OctezShellBlockHash block;
  final int level;
  final OctezShellError errors;

  const OctezShellResponseChainsChainIdInvalidBlocksItem({
    required this.block,
    required this.level,
    required this.errors,
  });

  factory OctezShellResponseChainsChainIdInvalidBlocksItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseChainsChainIdInvalidBlocksItem(
      block: OctezShellUnistring.fromJson(json['block']),
      level: json.valueAsInt('level'),
      errors: Map<String, dynamic>.from(json['errors'] as Map),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'block': block.toJson(),
        'level': level,
        'errors': errors,
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseChainsChainIdInvalidBlocksBlockHash {
  const OctezShellResponseChainsChainIdInvalidBlocksBlockHash();

  factory OctezShellResponseChainsChainIdInvalidBlocksBlockHash.fromJson(
    Map<String, dynamic> json,
  ) {
    return const OctezShellResponseChainsChainIdInvalidBlocksBlockHash();
  }

  Map<String, dynamic> toJson() => {}.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseChainsChainIdIsBootstrapped {
  final bool bootstrapped;
  final OctezShellChainStatus syncState;

  const OctezShellResponseChainsChainIdIsBootstrapped({
    required this.bootstrapped,
    required this.syncState,
  });

  factory OctezShellResponseChainsChainIdIsBootstrapped.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseChainsChainIdIsBootstrapped(
      bootstrapped: json.valueAsBool('bootstrapped'),
      syncState: OctezShellChainStatus.fromJson(json['sync_state']),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'bootstrapped': bootstrapped,
        'sync_state': syncState.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseChainsChainIdLevelsCaboose {
  final OctezShellBlockHash blockHash;
  final int level;

  const OctezShellResponseChainsChainIdLevelsCaboose({
    required this.blockHash,
    required this.level,
  });

  factory OctezShellResponseChainsChainIdLevelsCaboose.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseChainsChainIdLevelsCaboose(
      blockHash: OctezShellUnistring.fromJson(json['block_hash']),
      level: json.valueAsInt('level'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'block_hash': blockHash.toJson(),
        'level': level,
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseChainsChainIdProtocolsItem {
  final OctezShellProtocolHash protocol;

  /// Level of protocol in the sequence of protocol activations.
  final int protoLevel;

  /// The activation block for a protocol is the migration block, i.e. the last level of the previous protocol.
  final OctezShellResponseChainsChainIdLevelsCaboose activationBlock;

  const OctezShellResponseChainsChainIdProtocolsItem({
    required this.protocol,
    required this.protoLevel,
    required this.activationBlock,
  });

  factory OctezShellResponseChainsChainIdProtocolsItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseChainsChainIdProtocolsItem(
      protocol: OctezShellUnistring.fromJson(json['protocol']),
      protoLevel: json.valueAsInt('proto_level'),
      activationBlock: json.valueTo<
        OctezShellResponseChainsChainIdLevelsCaboose,
        Map<String, dynamic>
      >(
        key: 'activation_block',
        parse: (v) => OctezShellResponseChainsChainIdLevelsCaboose.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'protocol': protocol.toJson(),
        'proto_level': protoLevel,
        'activation_block': activationBlock.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

/// Configuration of rpc parameters
class OctezShellResponseConfigRpc {
  /// Hosts to listen to. If the port is not specified, the default port 8732 will be assumed.
  final List<OctezShellUnistring>? listenAddrs;

  /// Hosts to listen to. If the port is not specified, the default port 8732 will be assumed.
  final List<OctezShellUnistring>? externalListenAddrs;

  /// Legacy value: Host to listen to
  final OctezShellUnistring? listenAddr;

  /// Cross Origin Resource Sharing parameters, see https://en.wikipedia.org/wiki/Cross-origin_resource_sharing.
  final List<OctezShellUnistring>? corsOrigin;

  /// Cross Origin Resource Sharing parameters, see https://en.wikipedia.org/wiki/Cross-origin_resource_sharing.
  final List<OctezShellUnistring>? corsHeaders;

  /// Certificate file (necessary when TLS is used).
  final OctezShellUnistring? crt;

  /// Key file (necessary when TLS is used).
  final OctezShellUnistring? key;

  /// A list of RPC ACLs for specific listening addresses.
  final List<OctezShellResponseConfigRpcAclItem>? acl;

  /// The media types supported by the server.
  final OctezShellResponseConfigRpcMediaType? mediaType;

  /// The maximum number of active connections per RPC endpoint.
  final OctezShellMaxActiveRpcConnections? maxActiveRpcConnections;

  /// Enables HTTP cache headers in the RPC response. When enabled, 'Cache-control' will be present with 'max-age' in the response header of relative queries (eg. head, head-n, head~n). The 'max-age' value indicates the duration of which the returned response is cacheable. It is an estimate of the remaining duration of the current round based on when the block was forged. Enabling this feature adds a performance overhead to all queries hence you should only do so if you are running the RPC server behind a caching server. The feature is implemented based on RFC9111 hence useful for reverse proxies with auto-caching mechanism.
  final bool? enableHttpCacheHeaders;

  const OctezShellResponseConfigRpc({
    this.listenAddrs,
    this.externalListenAddrs,
    this.listenAddr,
    this.corsOrigin,
    this.corsHeaders,
    this.crt,
    this.key,
    this.acl,
    this.mediaType,
    this.maxActiveRpcConnections,
    this.enableHttpCacheHeaders,
  });

  factory OctezShellResponseConfigRpc.fromJson(Map<String, dynamic> json) {
    return OctezShellResponseConfigRpc(
      listenAddrs:
          json.hasValue('listen-addrs')
              ? json
                  .valueEnsureAsList<dynamic>('listen-addrs')
                  .map((e) => OctezShellUnistring.fromJson(e))
                  .toList()
              : null,
      externalListenAddrs:
          json.hasValue('external-listen-addrs')
              ? json
                  .valueEnsureAsList<dynamic>('external-listen-addrs')
                  .map((e) => OctezShellUnistring.fromJson(e))
                  .toList()
              : null,
      listenAddr:
          json.hasValue('listen-addr')
              ? OctezShellUnistring.fromJson(json['listen-addr'])
              : null,
      corsOrigin:
          json.hasValue('cors-origin')
              ? json
                  .valueEnsureAsList<dynamic>('cors-origin')
                  .map((e) => OctezShellUnistring.fromJson(e))
                  .toList()
              : null,
      corsHeaders:
          json.hasValue('cors-headers')
              ? json
                  .valueEnsureAsList<dynamic>('cors-headers')
                  .map((e) => OctezShellUnistring.fromJson(e))
                  .toList()
              : null,
      crt:
          json.hasValue('crt')
              ? OctezShellUnistring.fromJson(json['crt'])
              : null,
      key:
          json.hasValue('key')
              ? OctezShellUnistring.fromJson(json['key'])
              : null,
      acl:
          json.hasValue('acl')
              ? json
                  .valueEnsureAsList<dynamic>('acl')
                  .map((e) => OctezShellResponseConfigRpcAclItem.fromJson(e))
                  .toList()
              : null,
      mediaType:
          json.hasValue('media-type')
              ? OctezShellResponseConfigRpcMediaType.fromJson(
                json['media-type'],
              )
              : null,
      maxActiveRpcConnections:
          json.hasValue('max_active_rpc_connections')
              ? OctezShellMaxActiveRpcConnections.fromJson(
                json['max_active_rpc_connections'],
              )
              : null,
      enableHttpCacheHeaders: json.valueAsBool('enable-http-cache-headers'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'listen-addrs': listenAddrs?.map((e) => e.toJson()).toList(),
        'external-listen-addrs':
            externalListenAddrs?.map((e) => e.toJson()).toList(),
        'listen-addr': listenAddr?.toJson(),
        'cors-origin': corsOrigin?.map((e) => e.toJson()).toList(),
        'cors-headers': corsHeaders?.map((e) => e.toJson()).toList(),
        'crt': crt?.toJson(),
        'key': key?.toJson(),
        'acl': acl?.map((e) => e.toJson()).toList(),
        'media-type': mediaType?.toJson(),
        'max_active_rpc_connections': maxActiveRpcConnections?.toJson(),
        'enable-http-cache-headers': enableHttpCacheHeaders,
      }.notNullValue.cast<String, dynamic>();
}

/// Network limits
class OctezShellResponseConfigP2pLimits {
  /// Delay acceptable when initiating a connection to a new peer, in seconds.
  final OctezShellTimespanSystem? connectionTimeout;

  /// Delay granted to a peer to perform authentication, in seconds.
  final OctezShellTimespanSystem? authenticationTimeout;

  /// Strict minimum number of connections (triggers an urgent maintenance).
  final int? minConnections;

  /// Targeted number of connections to reach when bootstrapping / maintaining.
  final int? expectedConnections;

  /// Maximum number of connections (exceeding peers are disconnected).
  final int? maxConnections;

  /// Number above which pending incoming connections are immediately rejected.
  final int? backlog;

  /// Number above which pending incoming connections are immediately rejected.
  final int? maxIncomingConnections;

  /// Max download speeds in KiB/s.
  final int? maxDownloadSpeed;

  /// Max upload speeds in KiB/s.
  final int? maxUploadSpeed;
  final OctezShellTimespanSystem? swapLinger;
  final int? binaryChunksSize;

  /// Size of the buffer passed to read(2).
  final int? readBufferSize;
  final int? readQueueSize;
  final int? writeQueueSize;
  final int? incomingAppMessageQueueSize;
  final int? incomingMessageQueueSize;
  final int? outgoingMessageQueueSize;

  /// The max and target size for the known address table.
  final List<OctezShellResponseConfigP2pLimitsMaxKnownPointsItem>?
  maxKnownPoints;

  /// The max and target size for the known peers table.
  final List<OctezShellResponseConfigP2pLimitsMaxKnownPointsItem>?
  maxKnownPeerIds;

  /// The number of peer_ids kept in the peer_id greylist.
  final int? peerGreylistSize;

  /// The size of the IP address greylist (in kilobytes).
  final int? ipGreylistSizeInKilobytes;

  /// The time an IP address is kept in the greylist.
  final OctezShellTimespanSystem? ipGreylistCleanupDelay;

  /// GC delay for the greylists tables, in seconds.
  final OctezShellTimespanSystem? greylistTimeout;

  /// How long to wait at most, in seconds, before running a maintenance loop. If null -- decoding to None -- is provided then the maintenance is disabled.
  final OctezShellTimespanSystem? maintenanceIdleTime;

  const OctezShellResponseConfigP2pLimits({
    this.connectionTimeout,
    this.authenticationTimeout,
    this.minConnections,
    this.expectedConnections,
    this.maxConnections,
    this.backlog,
    this.maxIncomingConnections,
    this.maxDownloadSpeed,
    this.maxUploadSpeed,
    this.swapLinger,
    this.binaryChunksSize,
    this.readBufferSize,
    this.readQueueSize,
    this.writeQueueSize,
    this.incomingAppMessageQueueSize,
    this.incomingMessageQueueSize,
    this.outgoingMessageQueueSize,
    this.maxKnownPoints,
    this.maxKnownPeerIds,
    this.peerGreylistSize,
    this.ipGreylistSizeInKilobytes,
    this.ipGreylistCleanupDelay,
    this.greylistTimeout,
    this.maintenanceIdleTime,
  });

  factory OctezShellResponseConfigP2pLimits.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseConfigP2pLimits(
      connectionTimeout: json.valueAsNum('connection-timeout'),
      authenticationTimeout: json.valueAsNum('authentication-timeout'),
      minConnections: json.valueAsInt('min-connections'),
      expectedConnections: json.valueAsInt('expected-connections'),
      maxConnections: json.valueAsInt('max-connections'),
      backlog: json.valueAsInt('backlog'),
      maxIncomingConnections: json.valueAsInt('max-incoming-connections'),
      maxDownloadSpeed: json.valueAsInt('max-download-speed'),
      maxUploadSpeed: json.valueAsInt('max-upload-speed'),
      swapLinger: json.valueAsNum('swap-linger'),
      binaryChunksSize: json.valueAsInt('binary-chunks-size'),
      readBufferSize: json.valueAsInt('read-buffer-size'),
      readQueueSize: json.valueAsInt('read-queue-size'),
      writeQueueSize: json.valueAsInt('write-queue-size'),
      incomingAppMessageQueueSize: json.valueAsInt(
        'incoming-app-message-queue-size',
      ),
      incomingMessageQueueSize: json.valueAsInt('incoming-message-queue-size'),
      outgoingMessageQueueSize: json.valueAsInt('outgoing-message-queue-size'),
      maxKnownPoints:
          json.hasValue('max_known_points')
              ? json
                  .valueEnsureAsList<dynamic>('max_known_points')
                  .map(
                    (e) =>
                        OctezShellResponseConfigP2pLimitsMaxKnownPointsItem.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      maxKnownPeerIds:
          json.hasValue('max_known_peer_ids')
              ? json
                  .valueEnsureAsList<dynamic>('max_known_peer_ids')
                  .map(
                    (e) =>
                        OctezShellResponseConfigP2pLimitsMaxKnownPointsItem.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      peerGreylistSize: json.valueAsInt('peer_greylist_size'),
      ipGreylistSizeInKilobytes: json.valueAsInt(
        'ip_greylist_size_in_kilobytes',
      ),
      ipGreylistCleanupDelay: json.valueAsNum('ip_greylist_cleanup_delay'),
      greylistTimeout: json.valueAsNum('greylist-timeout'),
      maintenanceIdleTime: json.valueAsNum('maintenance-idle-time'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'connection-timeout': connectionTimeout,
        'authentication-timeout': authenticationTimeout,
        'min-connections': minConnections,
        'expected-connections': expectedConnections,
        'max-connections': maxConnections,
        'backlog': backlog,
        'max-incoming-connections': maxIncomingConnections,
        'max-download-speed': maxDownloadSpeed,
        'max-upload-speed': maxUploadSpeed,
        'swap-linger': swapLinger,
        'binary-chunks-size': binaryChunksSize,
        'read-buffer-size': readBufferSize,
        'read-queue-size': readQueueSize,
        'write-queue-size': writeQueueSize,
        'incoming-app-message-queue-size': incomingAppMessageQueueSize,
        'incoming-message-queue-size': incomingMessageQueueSize,
        'outgoing-message-queue-size': outgoingMessageQueueSize,
        'max_known_points': maxKnownPoints?.map((e) => e.toJson()).toList(),
        'max_known_peer_ids': maxKnownPeerIds?.map((e) => e.toJson()).toList(),
        'peer_greylist_size': peerGreylistSize,
        'ip_greylist_size_in_kilobytes': ipGreylistSizeInKilobytes,
        'ip_greylist_cleanup_delay': ipGreylistCleanupDelay,
        'greylist-timeout': greylistTimeout,
        'maintenance-idle-time': maintenanceIdleTime,
      }.notNullValue.cast<String, dynamic>();
}

/// The reconnection policy regulates the frequency with which the node tries to reconnect to an old known peer.
class OctezShellResponseConfigP2pGreylistingConfig {
  /// The factor by which the reconnection delay is increased when a peer that was previously disconnected is disconnected again. This value should be set to 1 for a linear back-off and to >1 for an exponential back-off.
  final num? factor;

  /// The span of time a peer is disconnected for when it is first disconnected.
  final OctezShellTimespanSystem? initialDelay;

  /// The span of time a peer is disconnected for when it is disconnected as the result of an error.
  final OctezShellTimespanSystem? disconnectionDelay;

  /// The maximum amount by which the reconnection is extended. This limits the rate of the exponential back-off, which eventually becomes linear when it reaches this limit. This limit is set to avoid reaching the End-of-Time when repeatedly reconnection a peer.
  final OctezShellTimespanSystem? increaseCap;

  const OctezShellResponseConfigP2pGreylistingConfig({
    this.factor,
    this.initialDelay,
    this.disconnectionDelay,
    this.increaseCap,
  });

  factory OctezShellResponseConfigP2pGreylistingConfig.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseConfigP2pGreylistingConfig(
      factor: json.valueAsNum('factor'),
      initialDelay: json.valueAsNum('initial-delay'),
      disconnectionDelay: json.valueAsNum('disconnection-delay'),
      increaseCap: json.valueAsNum('increase-cap'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'factor': factor,
        'initial-delay': initialDelay,
        'disconnection-delay': disconnectionDelay,
        'increase-cap': increaseCap,
      }.notNullValue.cast<String, dynamic>();
}

/// Configuration of network parameters
class OctezShellResponseConfigP2p {
  /// Floating point number between 0 and 256 that represents a difficulty, 24 signifies for example that at least 24 leading zeroes are expected in the hash.
  final num? expectedProofOfWork;

  /// List of hosts. Tezos can connect to both IPv6 and IPv4 hosts. If the port is not specified, default port 9732 will be assumed.
  final List<OctezShellUnistring>? bootstrapPeers;

  /// Host to listen to. If the port is not specified, the default port 9732 will be assumed.
  final OctezShellUnistring? listenAddr;

  /// Alternative port advertised to other peers to connect to. If the port is not specified, the port from listen-addr will be assumed.
  final int? advertisedNetPort;

  /// Host for local peer discovery. If the port is not specified, the default port 10732 will be assumed.
  final OctezShellUnistring? discoveryAddr;

  /// Specify if the node is in private mode or not. A node in private mode rejects incoming connections from untrusted peers and only opens outgoing connections to peers listed in 'bootstrap-peers' or provided with '--peer' option. Moreover, these peers will keep the identity and the address of the private node secret.
  final bool? privateMode;

  /// Network limits
  final OctezShellResponseConfigP2pLimits? limits;

  /// If set to [true], the node will not participate in the propagation of pending operations (mempool). Default value is [false]. It can be used to decrease the memory and computation footprints of the node.
  final bool? disableMempool;

  /// DEPRECATED. If set to [true], the node will spawn a testchain during the protocol's testing voting period. Default value is [false]. It is disabled to decrease the node storage usage and computation by dropping the validation of the test network blocks.
  final bool? enableTestchain;

  /// The reconnection policy regulates the frequency with which the node tries to reconnect to an old known peer.
  final OctezShellResponseConfigP2pGreylistingConfig? greylistingConfig;

  /// This field should be used for testing purpose only. If set to [true], the node will not participate to the peer discovery mechanism. The node will not be able to find new peers to connect with.
  final bool? disablePeerDiscovery;

  const OctezShellResponseConfigP2p({
    this.expectedProofOfWork,
    this.bootstrapPeers,
    this.listenAddr,
    this.advertisedNetPort,
    this.discoveryAddr,
    this.privateMode,
    this.limits,
    this.disableMempool,
    this.enableTestchain,
    this.greylistingConfig,
    this.disablePeerDiscovery,
  });

  factory OctezShellResponseConfigP2p.fromJson(Map<String, dynamic> json) {
    return OctezShellResponseConfigP2p(
      expectedProofOfWork: json.valueAsNum('expected-proof-of-work'),
      bootstrapPeers:
          json.hasValue('bootstrap-peers')
              ? json
                  .valueEnsureAsList<dynamic>('bootstrap-peers')
                  .map((e) => OctezShellUnistring.fromJson(e))
                  .toList()
              : null,
      listenAddr:
          json.hasValue('listen-addr')
              ? OctezShellUnistring.fromJson(json['listen-addr'])
              : null,
      advertisedNetPort: json.valueAsInt('advertised-net-port'),
      discoveryAddr:
          json.hasValue('discovery-addr')
              ? OctezShellUnistring.fromJson(json['discovery-addr'])
              : null,
      privateMode: json.valueAsBool('private-mode'),
      limits: json
          .valueTo<OctezShellResponseConfigP2pLimits?, Map<String, dynamic>>(
            key: 'limits',
            parse: (v) => OctezShellResponseConfigP2pLimits.fromJson(v),
          ),
      disableMempool: json.valueAsBool('disable_mempool'),
      enableTestchain: json.valueAsBool('enable_testchain'),
      greylistingConfig: json.valueTo<
        OctezShellResponseConfigP2pGreylistingConfig?,
        Map<String, dynamic>
      >(
        key: 'greylisting_config',
        parse: (v) => OctezShellResponseConfigP2pGreylistingConfig.fromJson(v),
      ),
      disablePeerDiscovery: json.valueAsBool('disable_peer_discovery'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'expected-proof-of-work': expectedProofOfWork,
        'bootstrap-peers': bootstrapPeers?.map((e) => e.toJson()).toList(),
        'listen-addr': listenAddr?.toJson(),
        'advertised-net-port': advertisedNetPort,
        'discovery-addr': discoveryAddr?.toJson(),
        'private-mode': privateMode,
        'limits': limits?.toJson(),
        'disable_mempool': disableMempool,
        'enable_testchain': enableTestchain,
        'greylisting_config': greylistingConfig?.toJson(),
        'disable_peer_discovery': disablePeerDiscovery,
      }.notNullValue.cast<String, dynamic>();
}

/// Configuration of the Lwt-log sink (part of the logging framework)
class OctezShellResponseConfigLog {
  /// Output for the logging function. Either 'stdout', 'stderr' or the name of a log file .
  final OctezShellUnistring? output;

  /// Verbosity level: one of 'fatal', 'error', 'warn','notice', 'info', 'debug'.
  final OctezShellResponseConfigLogLevel? level;

  /// Enables light coloring in logs.
  final bool? colors;

  /// Fine-grained logging instructions. Same format as described in `octez-node run --help`, DEBUG section. In the example below, sections 'p2p' and all sections starting by 'client' will have their messages logged up to the debug level, whereas the rest of log sections will be logged up to the notice level.
  final OctezShellUnistring? rules;

  /// When `true`, advertises the level of an event in addition to its contents.
  final bool? advertisesLevel;

  const OctezShellResponseConfigLog({
    this.output,
    this.level,
    this.colors,
    this.rules,
    this.advertisesLevel,
  });

  factory OctezShellResponseConfigLog.fromJson(Map<String, dynamic> json) {
    return OctezShellResponseConfigLog(
      output:
          json.hasValue('output')
              ? OctezShellUnistring.fromJson(json['output'])
              : null,
      level:
          json.hasValue('level')
              ? OctezShellResponseConfigLogLevel.fromJson(json['level'])
              : null,
      colors: json.valueAsBool('colors'),
      rules:
          json.hasValue('rules')
              ? OctezShellUnistring.fromJson(json['rules'])
              : null,
      advertisesLevel: json.valueAsBool('advertises_level'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'output': output?.toJson(),
        'level': level?.toJson(),
        'colors': colors,
        'rules': rules?.toJson(),
        'advertises_level': advertisesLevel,
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseConfigShellPeerValidator {
  final OctezShellTimespanSystem? blockHeaderRequestTimeout;
  final OctezShellTimespanSystem? blockOperationsRequestTimeout;
  final OctezShellTimespanSystem? protocolRequestTimeout;
  final OctezShellTimespanSystem? newHeadRequestTimeout;

  const OctezShellResponseConfigShellPeerValidator({
    this.blockHeaderRequestTimeout,
    this.blockOperationsRequestTimeout,
    this.protocolRequestTimeout,
    this.newHeadRequestTimeout,
  });

  factory OctezShellResponseConfigShellPeerValidator.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseConfigShellPeerValidator(
      blockHeaderRequestTimeout: json.valueAsNum(
        'block_header_request_timeout',
      ),
      blockOperationsRequestTimeout: json.valueAsNum(
        'block_operations_request_timeout',
      ),
      protocolRequestTimeout: json.valueAsNum('protocol_request_timeout'),
      newHeadRequestTimeout: json.valueAsNum('new_head_request_timeout'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'block_header_request_timeout': blockHeaderRequestTimeout,
        'block_operations_request_timeout': blockOperationsRequestTimeout,
        'protocol_request_timeout': protocolRequestTimeout,
        'new_head_request_timeout': newHeadRequestTimeout,
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseConfigShellBlockValidator {
  final OctezShellTimespanSystem? protocolRequestTimeout;
  final OctezShellOperationMetadataSizeLimit? operationMetadataSizeLimit;

  const OctezShellResponseConfigShellBlockValidator({
    this.protocolRequestTimeout,
    this.operationMetadataSizeLimit,
  });

  factory OctezShellResponseConfigShellBlockValidator.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseConfigShellBlockValidator(
      protocolRequestTimeout: json.valueAsNum('protocol_request_timeout'),
      operationMetadataSizeLimit:
          json.hasValue('operation_metadata_size_limit')
              ? OctezShellOperationMetadataSizeLimit.fromJson(
                json['operation_metadata_size_limit'],
              )
              : null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'protocol_request_timeout': protocolRequestTimeout,
        'operation_metadata_size_limit': operationMetadataSizeLimit?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseConfigShellPrevalidator {
  final OctezShellTimespanSystem? operationsRequestTimeout;
  final int? maxRefusedOperations;
  final int? operationsBatchSize;

  const OctezShellResponseConfigShellPrevalidator({
    this.operationsRequestTimeout,
    this.maxRefusedOperations,
    this.operationsBatchSize,
  });

  factory OctezShellResponseConfigShellPrevalidator.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseConfigShellPrevalidator(
      operationsRequestTimeout: json.valueAsNum('operations_request_timeout'),
      maxRefusedOperations: json.valueAsInt('max_refused_operations'),
      operationsBatchSize: json.valueAsInt('operations_batch_size'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'operations_request_timeout': operationsRequestTimeout,
        'max_refused_operations': maxRefusedOperations,
        'operations_batch_size': operationsBatchSize,
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellHistoryModeFullFull {
  /// Number of additional cycles preserved below the savepoint. By default: 1 additional cycles will be stored.
  final int additionalCycles;

  const OctezShellHistoryModeFullFull({required this.additionalCycles});

  factory OctezShellHistoryModeFullFull.fromJson(Map<String, dynamic> json) {
    return OctezShellHistoryModeFullFull(
      additionalCycles: json.valueAsInt('additional_cycles'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'additional_cycles': additionalCycles,
      }.notNullValue.cast<String, dynamic>();
}

/// Configuration of network parameters
class OctezShellResponseConfigShell {
  final OctezShellResponseConfigShellPeerValidator? peerValidator;
  final OctezShellResponseConfigShellBlockValidator? blockValidator;
  final OctezShellResponseConfigShellPrevalidator? prevalidator;
  final OctezShellResponseConfigShellChainValidator? chainValidator;
  final OctezShellHistoryMode? historyMode;
  final bool? disableContextPruning;
  final OctezShellStorageMaintenanceDelay? storageMaintenanceDelay;

  const OctezShellResponseConfigShell({
    this.peerValidator,
    this.blockValidator,
    this.prevalidator,
    this.chainValidator,
    this.historyMode,
    this.disableContextPruning,
    this.storageMaintenanceDelay,
  });

  factory OctezShellResponseConfigShell.fromJson(Map<String, dynamic> json) {
    return OctezShellResponseConfigShell(
      peerValidator: json.valueTo<
        OctezShellResponseConfigShellPeerValidator?,
        Map<String, dynamic>
      >(
        key: 'peer_validator',
        parse: (v) => OctezShellResponseConfigShellPeerValidator.fromJson(v),
      ),
      blockValidator: json.valueTo<
        OctezShellResponseConfigShellBlockValidator?,
        Map<String, dynamic>
      >(
        key: 'block_validator',
        parse: (v) => OctezShellResponseConfigShellBlockValidator.fromJson(v),
      ),
      prevalidator: json.valueTo<
        OctezShellResponseConfigShellPrevalidator?,
        Map<String, dynamic>
      >(
        key: 'prevalidator',
        parse: (v) => OctezShellResponseConfigShellPrevalidator.fromJson(v),
      ),
      chainValidator:
          json.hasValue('chain_validator')
              ? OctezShellResponseConfigShellChainValidator.fromJson(
                json['chain_validator'],
              )
              : null,
      historyMode:
          json.hasValue('history_mode')
              ? OctezShellHistoryMode.fromJson(json['history_mode'])
              : null,
      disableContextPruning: json.valueAsBool('disable_context_pruning'),
      storageMaintenanceDelay:
          json.hasValue('storage_maintenance_delay')
              ? OctezShellStorageMaintenanceDelay.fromJson(
                json['storage_maintenance_delay'],
              )
              : null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'peer_validator': peerValidator?.toJson(),
        'block_validator': blockValidator?.toJson(),
        'prevalidator': prevalidator?.toJson(),
        'chain_validator': chainValidator?.toJson(),
        'history_mode': historyMode?.toJson(),
        'disable_context_pruning': disableContextPruning,
        'storage_maintenance_delay': storageMaintenanceDelay?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseConfigNetworkCustomGenesis {
  final OctezShellTimestampProtocol timestamp;
  final OctezShellBlockHash block;
  final OctezShellProtocolHash protocol;

  const OctezShellResponseConfigNetworkCustomGenesis({
    required this.timestamp,
    required this.block,
    required this.protocol,
  });

  factory OctezShellResponseConfigNetworkCustomGenesis.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseConfigNetworkCustomGenesis(
      timestamp: OctezShellUnistring.fromJson(json['timestamp']),
      block: OctezShellUnistring.fromJson(json['block']),
      protocol: OctezShellUnistring.fromJson(json['protocol']),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'timestamp': timestamp.toJson(),
        'block': block.toJson(),
        'protocol': protocol.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseConfigNetworkCustomGenesisParameters {
  final OctezShellUnistring? contextKey;

  final dynamic values;

  const OctezShellResponseConfigNetworkCustomGenesisParameters({
    this.contextKey,
    required this.values,
  });

  factory OctezShellResponseConfigNetworkCustomGenesisParameters.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseConfigNetworkCustomGenesisParameters(
      contextKey:
          json.hasValue('context_key')
              ? OctezShellUnistring.fromJson(json['context_key'])
              : null,
      values: json['values'],
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'context_key': contextKey?.toJson(),
        'values': values,
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellUserActivatedUpgradesItem {
  final int level;
  final OctezShellProtocolHash replacementProtocol;

  const OctezShellUserActivatedUpgradesItem({
    required this.level,
    required this.replacementProtocol,
  });

  factory OctezShellUserActivatedUpgradesItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellUserActivatedUpgradesItem(
      level: json.valueAsInt('level'),
      replacementProtocol: OctezShellUnistring.fromJson(
        json['replacement_protocol'],
      ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'level': level,
        'replacement_protocol': replacementProtocol.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellUserActivatedProtocolOverridesItem {
  final OctezShellProtocolHash replacedProtocol;
  final OctezShellProtocolHash replacementProtocol;

  const OctezShellUserActivatedProtocolOverridesItem({
    required this.replacedProtocol,
    required this.replacementProtocol,
  });

  factory OctezShellUserActivatedProtocolOverridesItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellUserActivatedProtocolOverridesItem(
      replacedProtocol: OctezShellUnistring.fromJson(json['replaced_protocol']),
      replacementProtocol: OctezShellUnistring.fromJson(
        json['replacement_protocol'],
      ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'replaced_protocol': replacedProtocol.toJson(),
        'replacement_protocol': replacementProtocol.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

/// For testing purposes only. Configuration for the data-availability layer
class OctezShellResponseConfigNetworkCustomDalConfig {
  final bool? activated;
  final List<OctezShellUnistring> bootstrapPeers;

  const OctezShellResponseConfigNetworkCustomDalConfig({
    this.activated,
    required this.bootstrapPeers,
  });

  factory OctezShellResponseConfigNetworkCustomDalConfig.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseConfigNetworkCustomDalConfig(
      activated: json.valueAsBool('activated'),
      bootstrapPeers:
          json
              .valueEnsureAsList<dynamic>('bootstrap_peers')
              .map((e) => OctezShellUnistring.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'activated': activated,
        'bootstrap_peers': bootstrapPeers.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

/// Configuration of profiling output
class OctezShellResponseConfigProfiling {
  /// Number of days of profiling results to keep. Older profiling files are automatically deleted during daily rotation.
  final int? daysKept;

  /// Per-profiler verbosity rules. Same format as the PROFILING environment variable, e.g. "chain_validator->debug;rpc_server->notice". When set, overrides the PROFILING environment variable.
  final OctezShellUnistring? verbosity;

  /// List of profiling backends to enable, e.g. ["txt", "json"]. When set, overrides the PROFILING_BACKENDS environment variable.
  final List<OctezShellUnistring>? backends;

  /// Override the profiling output directory. When set, overrides the PROFILING_OUTPUT_DIR environment variable.
  final OctezShellUnistring? outputDir;

  const OctezShellResponseConfigProfiling({
    this.daysKept,
    this.verbosity,
    this.backends,
    this.outputDir,
  });

  factory OctezShellResponseConfigProfiling.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseConfigProfiling(
      daysKept: json.valueAsInt('days-kept'),
      verbosity:
          json.hasValue('verbosity')
              ? OctezShellUnistring.fromJson(json['verbosity'])
              : null,
      backends:
          json.hasValue('backends')
              ? json
                  .valueEnsureAsList<dynamic>('backends')
                  .map((e) => OctezShellUnistring.fromJson(e))
                  .toList()
              : null,
      outputDir:
          json.hasValue('output-dir')
              ? OctezShellUnistring.fromJson(json['output-dir'])
              : null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'days-kept': daysKept,
        'verbosity': verbosity?.toJson(),
        'backends': backends?.map((e) => e.toJson()).toList(),
        'output-dir': outputDir?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseConfig {
  /// Location of the data dir on disk.
  final OctezShellUnistring? dataDir;

  /// Disable the node configuration validation.
  final bool? disableConfigValidation;

  /// Configuration of rpc parameters
  final OctezShellResponseConfigRpc? rpc;

  /// Configuration of network parameters
  final OctezShellResponseConfigP2p? p2p;

  /// Configuration of the Lwt-log sink (part of the logging framework)
  final OctezShellResponseConfigLog? log;

  /// Configuration of the structured logging framework
  final OctezShellResponseConfigInternalEvents? internalEvents;

  /// Configuration of network parameters
  final OctezShellResponseConfigShell? shell;

  /// Configuration of which network/blockchain to connect to
  final OctezShellResponseConfigNetwork? network;

  /// Configuration of the Prometheus metrics endpoint
  final List<OctezShellUnistring>? metricsAddr;

  /// Configuration of profiling output
  final OctezShellResponseConfigProfiling? profiling;

  const OctezShellResponseConfig({
    this.dataDir,
    this.disableConfigValidation,
    this.rpc,
    this.p2p,
    this.log,
    this.internalEvents,
    this.shell,
    this.network,
    this.metricsAddr,
    this.profiling,
  });

  factory OctezShellResponseConfig.fromJson(Map<String, dynamic> json) {
    return OctezShellResponseConfig(
      dataDir:
          json.hasValue('data-dir')
              ? OctezShellUnistring.fromJson(json['data-dir'])
              : null,
      disableConfigValidation: json.valueAsBool('disable-config-validation'),
      rpc: json.valueTo<OctezShellResponseConfigRpc?, Map<String, dynamic>>(
        key: 'rpc',
        parse: (v) => OctezShellResponseConfigRpc.fromJson(v),
      ),
      p2p: json.valueTo<OctezShellResponseConfigP2p?, Map<String, dynamic>>(
        key: 'p2p',
        parse: (v) => OctezShellResponseConfigP2p.fromJson(v),
      ),
      log: json.valueTo<OctezShellResponseConfigLog?, Map<String, dynamic>>(
        key: 'log',
        parse: (v) => OctezShellResponseConfigLog.fromJson(v),
      ),
      internalEvents:
          json.hasValue('internal-events')
              ? OctezShellResponseConfigInternalEvents.fromJson(
                json['internal-events'],
              )
              : null,
      shell: json.valueTo<OctezShellResponseConfigShell?, Map<String, dynamic>>(
        key: 'shell',
        parse: (v) => OctezShellResponseConfigShell.fromJson(v),
      ),
      network:
          json.hasValue('network')
              ? OctezShellResponseConfigNetwork.fromJson(json['network'])
              : null,
      metricsAddr:
          json.hasValue('metrics_addr')
              ? json
                  .valueEnsureAsList<dynamic>('metrics_addr')
                  .map((e) => OctezShellUnistring.fromJson(e))
                  .toList()
              : null,
      profiling: json
          .valueTo<OctezShellResponseConfigProfiling?, Map<String, dynamic>>(
            key: 'profiling',
            parse: (v) => OctezShellResponseConfigProfiling.fromJson(v),
          ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'data-dir': dataDir?.toJson(),
        'disable-config-validation': disableConfigValidation,
        'rpc': rpc?.toJson(),
        'p2p': p2p?.toJson(),
        'log': log?.toJson(),
        'internal-events': internalEvents?.toJson(),
        'shell': shell?.toJson(),
        'network': network?.toJson(),
        'metrics_addr': metricsAddr?.map((e) => e.toJson()).toList(),
        'profiling': profiling?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseConfigHistoryMode {
  final OctezShellHistoryMode historyMode;
  final int? blocksPreservationCycles;

  const OctezShellResponseConfigHistoryMode({
    required this.historyMode,
    this.blocksPreservationCycles,
  });

  factory OctezShellResponseConfigHistoryMode.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseConfigHistoryMode(
      historyMode: OctezShellHistoryMode.fromJson(json['history_mode']),
      blocksPreservationCycles: json.valueAsInt('blocks_preservation_cycles'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'history_mode': historyMode.toJson(),
        'blocks_preservation_cycles': blocksPreservationCycles,
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseHealthReady {
  final bool ready;

  const OctezShellResponseHealthReady({required this.ready});

  factory OctezShellResponseHealthReady.fromJson(Map<String, dynamic> json) {
    return OctezShellResponseHealthReady(ready: json.valueAsBool('ready'));
  }

  Map<String, dynamic> toJson() =>
      {'ready': ready}.notNullValue.cast<String, dynamic>();
}

/// An operation. The shell_header part indicates a block an operation is meant to apply on top of. The proto part is protocol-specific and appears as a binary blob.
class OctezShellOperation {
  final OctezShellBlockHash branch;
  final String data;

  const OctezShellOperation({required this.branch, required this.data});

  factory OctezShellOperation.fromJson(Map<String, dynamic> json) {
    return OctezShellOperation(
      branch: OctezShellUnistring.fromJson(json['branch']),
      data:
          (json['data'] is num
              ? json['data'].toString()
              : json.valueAsString('data')),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'branch': branch.toJson(),
        'data': data,
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellInjectionBlockBody {
  final String data;
  final List<List<OctezShellOperation>> operations;

  const OctezShellInjectionBlockBody({
    required this.data,
    required this.operations,
  });

  factory OctezShellInjectionBlockBody.fromJson(Map<String, dynamic> json) {
    return OctezShellInjectionBlockBody(
      data:
          (json['data'] is num
              ? json['data'].toString()
              : json.valueAsString('data')),
      operations:
          json
              .valueEnsureAsList<dynamic>('operations')
              .map(
                (e) =>
                    (e as List)
                        .map(
                          (e) => OctezShellOperation.fromJson(
                            e as Map<String, dynamic>,
                          ),
                        )
                        .toList(),
              )
              .toList(),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'data': data,
        'operations':
            operations.map((e) => e.map((x) => x.toJson()).toList()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellInjectionProtocolBodyComponentsItem {
  final OctezShellUnistring name;
  final OctezShellUnistring? interface_;
  final OctezShellUnistring implementation;

  const OctezShellInjectionProtocolBodyComponentsItem({
    required this.name,
    this.interface_,
    required this.implementation,
  });

  factory OctezShellInjectionProtocolBodyComponentsItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellInjectionProtocolBodyComponentsItem(
      name: OctezShellUnistring.fromJson(json['name']),
      interface_:
          json.hasValue('interface')
              ? OctezShellUnistring.fromJson(json['interface'])
              : null,
      implementation: OctezShellUnistring.fromJson(json['implementation']),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'name': name.toJson(),
        'interface': interface_?.toJson(),
        'implementation': implementation.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

/// The environment a protocol relies on and the components a protocol is made of.
class OctezShellInjectionProtocolBody {
  final OctezShellProtocolEnvironmentVersion expectedEnvVersion;
  final List<OctezShellInjectionProtocolBodyComponentsItem> components;

  const OctezShellInjectionProtocolBody({
    required this.expectedEnvVersion,
    required this.components,
  });

  factory OctezShellInjectionProtocolBody.fromJson(Map<String, dynamic> json) {
    return OctezShellInjectionProtocolBody(
      expectedEnvVersion: json.valueAsInt('expected_env_version'),
      components:
          json
              .valueEnsureAsList<Map<String, dynamic>>('components')
              .map(
                (e) =>
                    OctezShellInjectionProtocolBodyComponentsItem.fromJson(e),
              )
              .toList(),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'expected_env_version': expectedEnvVersion,
        'components': components.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

/// Block header. It contains both shell and protocol specific data.
class OctezShellBlockHeader {
  final int level;
  final int proto;
  final OctezShellBlockHash predecessor;
  final OctezShellTimestampProtocol timestamp;
  final int validationPass;
  final OctezShellOperationListListHash operationsHash;
  final OctezShellFitness fitness;
  final OctezShellContextHash context;
  final String protocolData;

  const OctezShellBlockHeader({
    required this.level,
    required this.proto,
    required this.predecessor,
    required this.timestamp,
    required this.validationPass,
    required this.operationsHash,
    required this.fitness,
    required this.context,
    required this.protocolData,
  });

  factory OctezShellBlockHeader.fromJson(Map<String, dynamic> json) {
    return OctezShellBlockHeader(
      level: json.valueAsInt('level'),
      proto: json.valueAsInt('proto'),
      predecessor: OctezShellUnistring.fromJson(json['predecessor']),
      timestamp: OctezShellUnistring.fromJson(json['timestamp']),
      validationPass: json.valueAsInt('validation_pass'),
      operationsHash: OctezShellUnistring.fromJson(json['operations_hash']),
      fitness: json.valueAsList<List<String>>('fitness'),
      context: OctezShellUnistring.fromJson(json['context']),
      protocolData:
          (json['protocol_data'] is num
              ? json['protocol_data'].toString()
              : json.valueAsString('protocol_data')),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'level': level,
        'proto': proto,
        'predecessor': predecessor.toJson(),
        'timestamp': timestamp.toJson(),
        'validation_pass': validationPass,
        'operations_hash': operationsHash.toJson(),
        'fitness': fitness,
        'context': context.toJson(),
        'protocol_data': protocolData,
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseMonitorAppliedBlocks {
  final OctezShellChainId chainId;
  final OctezShellBlockHash hash;
  final OctezShellBlockHeader header;
  final List<List<OctezShellOperation>> operations;

  const OctezShellResponseMonitorAppliedBlocks({
    required this.chainId,
    required this.hash,
    required this.header,
    required this.operations,
  });

  factory OctezShellResponseMonitorAppliedBlocks.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseMonitorAppliedBlocks(
      chainId: OctezShellUnistring.fromJson(json['chain_id']),
      hash: OctezShellUnistring.fromJson(json['hash']),
      header: json.valueTo<OctezShellBlockHeader, Map<String, dynamic>>(
        key: 'header',
        parse: (v) => OctezShellBlockHeader.fromJson(v),
      ),
      operations:
          json
              .valueEnsureAsList<dynamic>('operations')
              .map(
                (e) =>
                    (e as List)
                        .map(
                          (e) => OctezShellOperation.fromJson(
                            e as Map<String, dynamic>,
                          ),
                        )
                        .toList(),
              )
              .toList(),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'chain_id': chainId.toJson(),
        'hash': hash.toJson(),
        'header': header.toJson(),
        'operations':
            operations.map((e) => e.map((x) => x.toJson()).toList()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseMonitorBootstrapped {
  final OctezShellBlockHash block;
  final OctezShellTimestampProtocol timestamp;

  const OctezShellResponseMonitorBootstrapped({
    required this.block,
    required this.timestamp,
  });

  factory OctezShellResponseMonitorBootstrapped.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseMonitorBootstrapped(
      block: OctezShellUnistring.fromJson(json['block']),
      timestamp: OctezShellUnistring.fromJson(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'block': block.toJson(),
        'timestamp': timestamp.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

/// Block header. It contains both shell and protocol specific data.
class OctezShellResponseMonitorHeadsChainId {
  final OctezShellBlockHash hash;
  final int level;
  final int proto;
  final OctezShellBlockHash predecessor;
  final OctezShellTimestampProtocol timestamp;
  final int validationPass;
  final OctezShellOperationListListHash operationsHash;
  final OctezShellFitness fitness;
  final OctezShellContextHash context;
  final String protocolData;

  const OctezShellResponseMonitorHeadsChainId({
    required this.hash,
    required this.level,
    required this.proto,
    required this.predecessor,
    required this.timestamp,
    required this.validationPass,
    required this.operationsHash,
    required this.fitness,
    required this.context,
    required this.protocolData,
  });

  factory OctezShellResponseMonitorHeadsChainId.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseMonitorHeadsChainId(
      hash: OctezShellUnistring.fromJson(json['hash']),
      level: json.valueAsInt('level'),
      proto: json.valueAsInt('proto'),
      predecessor: OctezShellUnistring.fromJson(json['predecessor']),
      timestamp: OctezShellUnistring.fromJson(json['timestamp']),
      validationPass: json.valueAsInt('validation_pass'),
      operationsHash: OctezShellUnistring.fromJson(json['operations_hash']),
      fitness: json.valueAsList<List<String>>('fitness'),
      context: OctezShellUnistring.fromJson(json['context']),
      protocolData:
          (json['protocol_data'] is num
              ? json['protocol_data'].toString()
              : json.valueAsString('protocol_data')),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'hash': hash.toJson(),
        'level': level,
        'proto': proto,
        'predecessor': predecessor.toJson(),
        'timestamp': timestamp.toJson(),
        'validation_pass': validationPass,
        'operations_hash': operationsHash.toJson(),
        'fitness': fitness,
        'context': context.toJson(),
        'protocol_data': protocolData,
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseMonitorReceivedBlocksChainId {
  final OctezShellBlockHash hash;

  const OctezShellResponseMonitorReceivedBlocksChainId({required this.hash});

  factory OctezShellResponseMonitorReceivedBlocksChainId.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseMonitorReceivedBlocksChainId(
      hash: OctezShellUnistring.fromJson(json['hash']),
    );
  }

  Map<String, dynamic> toJson() =>
      {'hash': hash.toJson()}.notNullValue.cast<String, dynamic>();
}

/// The identifier for a p2p connection. It includes an address and a port number.
class OctezShellP2pConnectionId {
  final OctezShellP2pAddress addr;
  final int? port;

  const OctezShellP2pConnectionId({required this.addr, this.port});

  factory OctezShellP2pConnectionId.fromJson(Map<String, dynamic> json) {
    return OctezShellP2pConnectionId(
      addr: OctezShellUnistring.fromJson(json['addr']),
      port: json.valueAsInt('port'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'addr': addr.toJson(),
        'port': port,
      }.notNullValue.cast<String, dynamic>();
}

/// A version number for the network protocol (includes distributed DB version and p2p version)
class OctezShellNetworkVersion {
  final OctezShellDistributedDbVersionName chainName;
  final OctezShellDistributedDbVersion distributedDbVersion;
  final OctezShellP2pVersion p2pVersion;

  const OctezShellNetworkVersion({
    required this.chainName,
    required this.distributedDbVersion,
    required this.p2pVersion,
  });

  factory OctezShellNetworkVersion.fromJson(Map<String, dynamic> json) {
    return OctezShellNetworkVersion(
      chainName: OctezShellUnistring.fromJson(json['chain_name']),
      distributedDbVersion: json.valueAsInt('distributed_db_version'),
      p2pVersion: json.valueAsInt('p2p_version'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'chain_name': chainName.toJson(),
        'distributed_db_version': distributedDbVersion,
        'p2p_version': p2pVersion,
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkConnectionsItemLocalMetadata {
  final bool disableMempool;
  final bool privateNode;

  const OctezShellResponseNetworkConnectionsItemLocalMetadata({
    required this.disableMempool,
    required this.privateNode,
  });

  factory OctezShellResponseNetworkConnectionsItemLocalMetadata.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkConnectionsItemLocalMetadata(
      disableMempool: json.valueAsBool('disable_mempool'),
      privateNode: json.valueAsBool('private_node'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'disable_mempool': disableMempool,
        'private_node': privateNode,
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkConnectionsItem {
  final bool incoming;
  final OctezShellCryptoBoxPublicKeyHash peerId;
  final OctezShellP2pConnectionId idPoint;
  final int remoteSocketPort;
  final OctezShellNetworkVersion announcedVersion;
  final bool private;
  final OctezShellResponseNetworkConnectionsItemLocalMetadata localMetadata;
  final OctezShellResponseNetworkConnectionsItemLocalMetadata remoteMetadata;

  const OctezShellResponseNetworkConnectionsItem({
    required this.incoming,
    required this.peerId,
    required this.idPoint,
    required this.remoteSocketPort,
    required this.announcedVersion,
    required this.private,
    required this.localMetadata,
    required this.remoteMetadata,
  });

  factory OctezShellResponseNetworkConnectionsItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkConnectionsItem(
      incoming: json.valueAsBool('incoming'),
      peerId: OctezShellUnistring.fromJson(json['peer_id']),
      idPoint: json.valueTo<OctezShellP2pConnectionId, Map<String, dynamic>>(
        key: 'id_point',
        parse: (v) => OctezShellP2pConnectionId.fromJson(v),
      ),
      remoteSocketPort: json.valueAsInt('remote_socket_port'),
      announcedVersion: json
          .valueTo<OctezShellNetworkVersion, Map<String, dynamic>>(
            key: 'announced_version',
            parse: (v) => OctezShellNetworkVersion.fromJson(v),
          ),
      private: json.valueAsBool('private'),
      localMetadata: json.valueTo<
        OctezShellResponseNetworkConnectionsItemLocalMetadata,
        Map<String, dynamic>
      >(
        key: 'local_metadata',
        parse:
            (v) =>
                OctezShellResponseNetworkConnectionsItemLocalMetadata.fromJson(
                  v,
                ),
      ),
      remoteMetadata: json.valueTo<
        OctezShellResponseNetworkConnectionsItemLocalMetadata,
        Map<String, dynamic>
      >(
        key: 'remote_metadata',
        parse:
            (v) =>
                OctezShellResponseNetworkConnectionsItemLocalMetadata.fromJson(
                  v,
                ),
      ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'incoming': incoming,
        'peer_id': peerId.toJson(),
        'id_point': idPoint.toJson(),
        'remote_socket_port': remoteSocketPort,
        'announced_version': announcedVersion.toJson(),
        'private': private,
        'local_metadata': localMetadata.toJson(),
        'remote_metadata': remoteMetadata.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

/// Statistics about the p2p network.
class OctezShellP2pStat {
  final OctezShellInt64 totalSent;
  final OctezShellInt64 totalRecv;
  final int currentInflow;
  final int currentOutflow;

  const OctezShellP2pStat({
    required this.totalSent,
    required this.totalRecv,
    required this.currentInflow,
    required this.currentOutflow,
  });

  factory OctezShellP2pStat.fromJson(Map<String, dynamic> json) {
    return OctezShellP2pStat(
      totalSent:
          (json['total_sent'] is num
              ? json['total_sent'].toString()
              : json.valueAsString('total_sent')),
      totalRecv:
          (json['total_recv'] is num
              ? json['total_recv'].toString()
              : json.valueAsString('total_recv')),
      currentInflow: json.valueAsInt('current_inflow'),
      currentOutflow: json.valueAsInt('current_outflow'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'total_sent': totalSent,
        'total_recv': totalRecv,
        'current_inflow': currentInflow,
        'current_outflow': currentOutflow,
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponses {
  final OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponsesSent
  sent;
  final OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponsesSent
  failed;
  final OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponsesSent
  received;
  final OctezShellBignum unexpected;
  final OctezShellBignum outdated;

  const OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponses({
    required this.sent,
    required this.failed,
    required this.received,
    required this.unexpected,
    required this.outdated,
  });

  factory OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponses.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponses(
      sent:
          OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponsesSent.fromJson(
            json['sent'],
          ),
      failed:
          OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponsesSent.fromJson(
            json['failed'],
          ),
      received:
          OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponsesSent.fromJson(
            json['received'],
          ),
      unexpected:
          (json['unexpected'] is num
              ? json['unexpected'].toString()
              : json.valueAsString('unexpected')),
      outdated:
          (json['outdated'] is num
              ? json['outdated'].toString()
              : json.valueAsString('outdated')),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'sent': sent.toJson(),
        'failed': failed.toJson(),
        'received': received.toJson(),
        'unexpected': unexpected,
        'outdated': outdated,
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataRequests {
  final OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponsesSent
  sent;
  final OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponsesSent
  received;
  final OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponsesSent
  failed;
  final OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponsesSent
  scheduled;

  const OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataRequests({
    required this.sent,
    required this.received,
    required this.failed,
    required this.scheduled,
  });

  factory OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataRequests.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataRequests(
      sent:
          OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponsesSent.fromJson(
            json['sent'],
          ),
      received:
          OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponsesSent.fromJson(
            json['received'],
          ),
      failed:
          OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponsesSent.fromJson(
            json['failed'],
          ),
      scheduled:
          OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponsesSent.fromJson(
            json['scheduled'],
          ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'sent': sent.toJson(),
        'received': received.toJson(),
        'failed': failed.toJson(),
        'scheduled': scheduled.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataPrevalidatorResults {
  final OctezShellBignum cannotDownload;
  final OctezShellBignum cannotParse;
  final OctezShellBignum refusedByPrefilter;
  final OctezShellBignum refusedByPostfilter;
  final OctezShellBignum applied;
  final OctezShellBignum branchDelayed;
  final OctezShellBignum branchRefused;
  final OctezShellBignum refused;
  final OctezShellBignum duplicate;
  final OctezShellBignum outdated;

  const OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataPrevalidatorResults({
    required this.cannotDownload,
    required this.cannotParse,
    required this.refusedByPrefilter,
    required this.refusedByPostfilter,
    required this.applied,
    required this.branchDelayed,
    required this.branchRefused,
    required this.refused,
    required this.duplicate,
    required this.outdated,
  });

  factory OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataPrevalidatorResults.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataPrevalidatorResults(
      cannotDownload:
          (json['cannot_download'] is num
              ? json['cannot_download'].toString()
              : json.valueAsString('cannot_download')),
      cannotParse:
          (json['cannot_parse'] is num
              ? json['cannot_parse'].toString()
              : json.valueAsString('cannot_parse')),
      refusedByPrefilter:
          (json['refused_by_prefilter'] is num
              ? json['refused_by_prefilter'].toString()
              : json.valueAsString('refused_by_prefilter')),
      refusedByPostfilter:
          (json['refused_by_postfilter'] is num
              ? json['refused_by_postfilter'].toString()
              : json.valueAsString('refused_by_postfilter')),
      applied:
          (json['applied'] is num
              ? json['applied'].toString()
              : json.valueAsString('applied')),
      branchDelayed:
          (json['branch_delayed'] is num
              ? json['branch_delayed'].toString()
              : json.valueAsString('branch_delayed')),
      branchRefused:
          (json['branch_refused'] is num
              ? json['branch_refused'].toString()
              : json.valueAsString('branch_refused')),
      refused:
          (json['refused'] is num
              ? json['refused'].toString()
              : json.valueAsString('refused')),
      duplicate:
          (json['duplicate'] is num
              ? json['duplicate'].toString()
              : json.valueAsString('duplicate')),
      outdated:
          (json['outdated'] is num
              ? json['outdated'].toString()
              : json.valueAsString('outdated')),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'cannot_download': cannotDownload,
        'cannot_parse': cannotParse,
        'refused_by_prefilter': refusedByPrefilter,
        'refused_by_postfilter': refusedByPostfilter,
        'applied': applied,
        'branch_delayed': branchDelayed,
        'branch_refused': branchRefused,
        'refused': refused,
        'duplicate': duplicate,
        'outdated': outdated,
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataUnadvertised {
  final OctezShellBignum block;
  final OctezShellBignum operations;
  final OctezShellBignum protocol;

  const OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataUnadvertised({
    required this.block,
    required this.operations,
    required this.protocol,
  });

  factory OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataUnadvertised.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataUnadvertised(
      block:
          (json['block'] is num
              ? json['block'].toString()
              : json.valueAsString('block')),
      operations:
          (json['operations'] is num
              ? json['operations'].toString()
              : json.valueAsString('operations')),
      protocol:
          (json['protocol'] is num
              ? json['protocol'].toString()
              : json.valueAsString('protocol')),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'block': block,
        'operations': operations,
        'protocol': protocol,
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataAdvertisementsSent {
  final OctezShellBignum head;
  final OctezShellBignum branch;

  const OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataAdvertisementsSent({
    required this.head,
    required this.branch,
  });

  factory OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataAdvertisementsSent.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataAdvertisementsSent(
      head:
          (json['head'] is num
              ? json['head'].toString()
              : json.valueAsString('head')),
      branch:
          (json['branch'] is num
              ? json['branch'].toString()
              : json.valueAsString('branch')),
    );
  }

  Map<String, dynamic> toJson() =>
      {'head': head, 'branch': branch}.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataAdvertisements {
  final OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataAdvertisementsSent
  sent;
  final OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataAdvertisementsSent
  received;

  const OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataAdvertisements({
    required this.sent,
    required this.received,
  });

  factory OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataAdvertisements.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataAdvertisements(
      sent: json.valueTo<
        OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataAdvertisementsSent,
        Map<String, dynamic>
      >(
        key: 'sent',
        parse:
            (v) =>
                OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataAdvertisementsSent.fromJson(
                  v,
                ),
      ),
      received: json.valueTo<
        OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataAdvertisementsSent,
        Map<String, dynamic>
      >(
        key: 'received',
        parse:
            (v) =>
                OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataAdvertisementsSent.fromJson(
                  v,
                ),
      ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'sent': sent.toJson(),
        'received': received.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadata {
  final OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponses
  responses;
  final OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataRequests
  requests;
  final OctezShellBignum validBlocks;
  final OctezShellBignum oldHeads;
  final OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataPrevalidatorResults
  prevalidatorResults;
  final OctezShellBignum unactivatedChains;
  final OctezShellBignum inactiveChains;
  final OctezShellBignum futureBlocksAdvertised;
  final OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataUnadvertised
  unadvertised;
  final OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataAdvertisements
  advertisements;

  const OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadata({
    required this.responses,
    required this.requests,
    required this.validBlocks,
    required this.oldHeads,
    required this.prevalidatorResults,
    required this.unactivatedChains,
    required this.inactiveChains,
    required this.futureBlocksAdvertised,
    required this.unadvertised,
    required this.advertisements,
  });

  factory OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadata.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadata(
      responses: json.valueTo<
        OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponses,
        Map<String, dynamic>
      >(
        key: 'responses',
        parse:
            (v) =>
                OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataResponses.fromJson(
                  v,
                ),
      ),
      requests: json.valueTo<
        OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataRequests,
        Map<String, dynamic>
      >(
        key: 'requests',
        parse:
            (v) =>
                OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataRequests.fromJson(
                  v,
                ),
      ),
      validBlocks:
          (json['valid_blocks'] is num
              ? json['valid_blocks'].toString()
              : json.valueAsString('valid_blocks')),
      oldHeads:
          (json['old_heads'] is num
              ? json['old_heads'].toString()
              : json.valueAsString('old_heads')),
      prevalidatorResults: json.valueTo<
        OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataPrevalidatorResults,
        Map<String, dynamic>
      >(
        key: 'prevalidator_results',
        parse:
            (v) =>
                OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataPrevalidatorResults.fromJson(
                  v,
                ),
      ),
      unactivatedChains:
          (json['unactivated_chains'] is num
              ? json['unactivated_chains'].toString()
              : json.valueAsString('unactivated_chains')),
      inactiveChains:
          (json['inactive_chains'] is num
              ? json['inactive_chains'].toString()
              : json.valueAsString('inactive_chains')),
      futureBlocksAdvertised:
          (json['future_blocks_advertised'] is num
              ? json['future_blocks_advertised'].toString()
              : json.valueAsString('future_blocks_advertised')),
      unadvertised: json.valueTo<
        OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataUnadvertised,
        Map<String, dynamic>
      >(
        key: 'unadvertised',
        parse:
            (v) =>
                OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataUnadvertised.fromJson(
                  v,
                ),
      ),
      advertisements: json.valueTo<
        OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataAdvertisements,
        Map<String, dynamic>
      >(
        key: 'advertisements',
        parse:
            (v) =>
                OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadataAdvertisements.fromJson(
                  v,
                ),
      ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'responses': responses.toJson(),
        'requests': requests.toJson(),
        'valid_blocks': validBlocks,
        'old_heads': oldHeads,
        'prevalidator_results': prevalidatorResults.toJson(),
        'unactivated_chains': unactivatedChains,
        'inactive_chains': inactiveChains,
        'future_blocks_advertised': futureBlocksAdvertised,
        'unadvertised': unadvertised.toJson(),
        'advertisements': advertisements.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

/// Information about a peer point. Includes flags, state, and records about past events.
class OctezShellP2pPointInfo {
  final bool trusted;
  final OctezShellTimestampSystem? greylistedUntil;
  final OctezShellP2pPointState state;
  final OctezShellCryptoBoxPublicKeyHash? p2pPeerId;
  final OctezShellTimestampSystem? lastFailedConnection;
  final List<OctezShellP2pPointInfoLastRejectedConnectionItem>?
  lastRejectedConnection;
  final List<OctezShellP2pPointInfoLastRejectedConnectionItem>?
  lastEstablishedConnection;
  final List<OctezShellP2pPointInfoLastRejectedConnectionItem>?
  lastDisconnection;
  final List<OctezShellP2pPointInfoLastRejectedConnectionItem>? lastSeen;
  final OctezShellTimestampSystem? lastMiss;
  final OctezShellCryptoBoxPublicKeyHash? expectedPeerId;

  const OctezShellP2pPointInfo({
    required this.trusted,
    this.greylistedUntil,
    required this.state,
    this.p2pPeerId,
    this.lastFailedConnection,
    this.lastRejectedConnection,
    this.lastEstablishedConnection,
    this.lastDisconnection,
    this.lastSeen,
    this.lastMiss,
    this.expectedPeerId,
  });

  factory OctezShellP2pPointInfo.fromJson(Map<String, dynamic> json) {
    return OctezShellP2pPointInfo(
      trusted: json.valueAsBool('trusted'),
      greylistedUntil:
          json.hasValue('greylisted_until')
              ? OctezShellTimestampSystem.fromJson(json['greylisted_until'])
              : null,
      state: OctezShellP2pPointState.fromJson(json['state']),
      p2pPeerId:
          json.hasValue('p2p_peer_id')
              ? OctezShellUnistring.fromJson(json['p2p_peer_id'])
              : null,
      lastFailedConnection:
          json.hasValue('last_failed_connection')
              ? OctezShellTimestampSystem.fromJson(
                json['last_failed_connection'],
              )
              : null,
      lastRejectedConnection:
          json.hasValue('last_rejected_connection')
              ? json
                  .valueEnsureAsList<dynamic>('last_rejected_connection')
                  .map(
                    (e) =>
                        OctezShellP2pPointInfoLastRejectedConnectionItem.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      lastEstablishedConnection:
          json.hasValue('last_established_connection')
              ? json
                  .valueEnsureAsList<dynamic>('last_established_connection')
                  .map(
                    (e) =>
                        OctezShellP2pPointInfoLastRejectedConnectionItem.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      lastDisconnection:
          json.hasValue('last_disconnection')
              ? json
                  .valueEnsureAsList<dynamic>('last_disconnection')
                  .map(
                    (e) =>
                        OctezShellP2pPointInfoLastRejectedConnectionItem.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      lastSeen:
          json.hasValue('last_seen')
              ? json
                  .valueEnsureAsList<dynamic>('last_seen')
                  .map(
                    (e) =>
                        OctezShellP2pPointInfoLastRejectedConnectionItem.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      lastMiss:
          json.hasValue('last_miss')
              ? OctezShellTimestampSystem.fromJson(json['last_miss'])
              : null,
      expectedPeerId:
          json.hasValue('expected_peer_id')
              ? OctezShellUnistring.fromJson(json['expected_peer_id'])
              : null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'trusted': trusted,
        'greylisted_until': greylistedUntil?.toJson(),
        'state': state.toJson(),
        'p2p_peer_id': p2pPeerId?.toJson(),
        'last_failed_connection': lastFailedConnection?.toJson(),
        'last_rejected_connection':
            lastRejectedConnection?.map((e) => e.toJson()).toList(),
        'last_established_connection':
            lastEstablishedConnection?.map((e) => e.toJson()).toList(),
        'last_disconnection':
            lastDisconnection?.map((e) => e.toJson()).toList(),
        'last_seen': lastSeen?.map((e) => e.toJson()).toList(),
        'last_miss': lastMiss?.toJson(),
        'expected_peer_id': expectedPeerId?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

/// Stored statistics about the p2p network.
class OctezShellResponseNetworkFullStat {
  final OctezShellP2pStat stat;
  final List<OctezShellResponseNetworkConnectionsItem> incomingConnections;
  final List<OctezShellResponseNetworkConnectionsItem> outgoingConnections;
  final List<List<OctezShellResponseNetworkFullStatPeersItemItem>> peers;
  final List<List<OctezShellResponseNetworkFullStatPointsItemItem>> points;

  const OctezShellResponseNetworkFullStat({
    required this.stat,
    required this.incomingConnections,
    required this.outgoingConnections,
    required this.peers,
    required this.points,
  });

  factory OctezShellResponseNetworkFullStat.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkFullStat(
      stat: json.valueTo<OctezShellP2pStat, Map<String, dynamic>>(
        key: 'stat',
        parse: (v) => OctezShellP2pStat.fromJson(v),
      ),
      incomingConnections:
          json
              .valueEnsureAsList<Map<String, dynamic>>('incoming_connections')
              .map((e) => OctezShellResponseNetworkConnectionsItem.fromJson(e))
              .toList(),
      outgoingConnections:
          json
              .valueEnsureAsList<Map<String, dynamic>>('outgoing_connections')
              .map((e) => OctezShellResponseNetworkConnectionsItem.fromJson(e))
              .toList(),
      peers:
          json
              .valueEnsureAsList<dynamic>('peers')
              .map(
                (e) =>
                    (e as List)
                        .map(
                          (e) =>
                              OctezShellResponseNetworkFullStatPeersItemItem.fromJson(
                                e,
                              ),
                        )
                        .toList(),
              )
              .toList(),
      points:
          json
              .valueEnsureAsList<dynamic>('points')
              .map(
                (e) =>
                    (e as List)
                        .map(
                          (e) =>
                              OctezShellResponseNetworkFullStatPointsItemItem.fromJson(
                                e,
                              ),
                        )
                        .toList(),
              )
              .toList(),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'stat': stat.toJson(),
        'incoming_connections':
            incomingConnections.map((e) => e.toJson()).toList(),
        'outgoing_connections':
            outgoingConnections.map((e) => e.toJson()).toList(),
        'peers': peers.map((e) => e.map((x) => x.toJson()).toList()).toList(),
        'points': points.map((e) => e.map((x) => x.toJson()).toList()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkGreylistIps {
  final List<OctezShellP2pAddress> ips;
  final OctezShellTimestampSystem? notReliableSince;

  const OctezShellResponseNetworkGreylistIps({
    required this.ips,
    this.notReliableSince,
  });

  factory OctezShellResponseNetworkGreylistIps.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkGreylistIps(
      ips:
          json
              .valueEnsureAsList<dynamic>('ips')
              .map((e) => OctezShellUnistring.fromJson(e))
              .toList(),
      notReliableSince:
          json.hasValue('not_reliable_since')
              ? OctezShellTimestampSystem.fromJson(json['not_reliable_since'])
              : null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'ips': ips.map((e) => e.toJson()).toList(),
        'not_reliable_since': notReliableSince?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseNetworkPeersPeerId {
  final num score;
  final bool trusted;
  final OctezShellResponseNetworkConnectionsItemLocalMetadata? connMetadata;
  final OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadata
  peerMetadata;
  final OctezShellP2pPeerState state;
  final OctezShellP2pConnectionId? reachableAt;
  final OctezShellP2pStat stat;
  final List<
    OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItem
  >?
  lastFailedConnection;
  final List<
    OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItem
  >?
  lastRejectedConnection;
  final List<
    OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItem
  >?
  lastEstablishedConnection;
  final List<
    OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItem
  >?
  lastDisconnection;
  final List<
    OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItem
  >?
  lastSeen;
  final List<
    OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItem
  >?
  lastMiss;

  const OctezShellResponseNetworkPeersPeerId({
    required this.score,
    required this.trusted,
    this.connMetadata,
    required this.peerMetadata,
    required this.state,
    this.reachableAt,
    required this.stat,
    this.lastFailedConnection,
    this.lastRejectedConnection,
    this.lastEstablishedConnection,
    this.lastDisconnection,
    this.lastSeen,
    this.lastMiss,
  });

  factory OctezShellResponseNetworkPeersPeerId.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkPeersPeerId(
      score: json.valueAsNum('score'),
      trusted: json.valueAsBool('trusted'),
      connMetadata: json.valueTo<
        OctezShellResponseNetworkConnectionsItemLocalMetadata?,
        Map<String, dynamic>
      >(
        key: 'conn_metadata',
        parse:
            (v) =>
                OctezShellResponseNetworkConnectionsItemLocalMetadata.fromJson(
                  v,
                ),
      ),
      peerMetadata: json.valueTo<
        OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadata,
        Map<String, dynamic>
      >(
        key: 'peer_metadata',
        parse:
            (v) =>
                OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatPeerMetadata.fromJson(
                  v,
                ),
      ),
      state: OctezShellP2pPeerState.fromJson(json['state']),
      reachableAt: json
          .valueTo<OctezShellP2pConnectionId?, Map<String, dynamic>>(
            key: 'reachable_at',
            parse: (v) => OctezShellP2pConnectionId.fromJson(v),
          ),
      stat: json.valueTo<OctezShellP2pStat, Map<String, dynamic>>(
        key: 'stat',
        parse: (v) => OctezShellP2pStat.fromJson(v),
      ),
      lastFailedConnection:
          json.hasValue('last_failed_connection')
              ? json
                  .valueEnsureAsList<dynamic>('last_failed_connection')
                  .map(
                    (e) =>
                        OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItem.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      lastRejectedConnection:
          json.hasValue('last_rejected_connection')
              ? json
                  .valueEnsureAsList<dynamic>('last_rejected_connection')
                  .map(
                    (e) =>
                        OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItem.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      lastEstablishedConnection:
          json.hasValue('last_established_connection')
              ? json
                  .valueEnsureAsList<dynamic>('last_established_connection')
                  .map(
                    (e) =>
                        OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItem.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      lastDisconnection:
          json.hasValue('last_disconnection')
              ? json
                  .valueEnsureAsList<dynamic>('last_disconnection')
                  .map(
                    (e) =>
                        OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItem.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      lastSeen:
          json.hasValue('last_seen')
              ? json
                  .valueEnsureAsList<dynamic>('last_seen')
                  .map(
                    (e) =>
                        OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItem.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      lastMiss:
          json.hasValue('last_miss')
              ? json
                  .valueEnsureAsList<dynamic>('last_miss')
                  .map(
                    (e) =>
                        OctezShellResponseNetworkFullStatPeersItemItemScoreTrustedPeerMetadataStateStatLastFailedConnectionItem.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'score': score,
        'trusted': trusted,
        'conn_metadata': connMetadata?.toJson(),
        'peer_metadata': peerMetadata.toJson(),
        'state': state.toJson(),
        'reachable_at': reachableAt?.toJson(),
        'stat': stat.toJson(),
        'last_failed_connection':
            lastFailedConnection?.map((e) => e.toJson()).toList(),
        'last_rejected_connection':
            lastRejectedConnection?.map((e) => e.toJson()).toList(),
        'last_established_connection':
            lastEstablishedConnection?.map((e) => e.toJson()).toList(),
        'last_disconnection':
            lastDisconnection?.map((e) => e.toJson()).toList(),
        'last_seen': lastSeen?.map((e) => e.toJson()).toList(),
        'last_miss': lastMiss?.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellNetworkPeersPeerIdBody {
  final OctezShellNetworkPeersPeerIdBodyAcl? acl;

  const OctezShellNetworkPeersPeerIdBody({this.acl});

  factory OctezShellNetworkPeersPeerIdBody.fromJson(Map<String, dynamic> json) {
    return OctezShellNetworkPeersPeerIdBody(
      acl:
          json.hasValue('acl')
              ? OctezShellNetworkPeersPeerIdBodyAcl.fromJson(json['acl'])
              : null,
    );
  }

  Map<String, dynamic> toJson() =>
      {'acl': acl?.toJson()}.notNullValue.cast<String, dynamic>();
}

/// An event that may happen during maintenance of and other operations on the connection to a specific peer.
class OctezShellP2pPeerPoolEvent {
  final OctezShellP2pPeerPoolEventKind kind;
  final OctezShellTimestampSystem timestamp;
  final OctezShellP2pAddress addr;
  final int? port;

  const OctezShellP2pPeerPoolEvent({
    required this.kind,
    required this.timestamp,
    required this.addr,
    this.port,
  });

  factory OctezShellP2pPeerPoolEvent.fromJson(Map<String, dynamic> json) {
    return OctezShellP2pPeerPoolEvent(
      kind: OctezShellP2pPeerPoolEventKind.fromJson(json['kind']),
      timestamp: OctezShellTimestampSystem.fromJson(json['timestamp']),
      addr: OctezShellUnistring.fromJson(json['addr']),
      port: json.valueAsInt('port'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'kind': kind.toJson(),
        'timestamp': timestamp.toJson(),
        'addr': addr.toJson(),
        'port': port,
      }.notNullValue.cast<String, dynamic>();
}

/// Information about a peer point. Includes flags, state, and records about past events.
class OctezShellResponseNetworkPointsPoint {
  final bool trusted;
  final OctezShellTimestampSystem? greylistedUntil;
  final OctezShellP2pPointState state;
  final OctezShellCryptoBoxPublicKeyHash? p2pPeerId;
  final OctezShellTimestampSystem? lastFailedConnection;
  final List<OctezShellP2pPointInfoLastRejectedConnectionItem>?
  lastRejectedConnection;
  final List<OctezShellP2pPointInfoLastRejectedConnectionItem>?
  lastEstablishedConnection;
  final List<OctezShellP2pPointInfoLastRejectedConnectionItem>?
  lastDisconnection;
  final List<OctezShellP2pPointInfoLastRejectedConnectionItem>? lastSeen;
  final OctezShellTimestampSystem? lastMiss;
  final OctezShellCryptoBoxPublicKeyHash? expectedPeerId;

  const OctezShellResponseNetworkPointsPoint({
    required this.trusted,
    this.greylistedUntil,
    required this.state,
    this.p2pPeerId,
    this.lastFailedConnection,
    this.lastRejectedConnection,
    this.lastEstablishedConnection,
    this.lastDisconnection,
    this.lastSeen,
    this.lastMiss,
    this.expectedPeerId,
  });

  factory OctezShellResponseNetworkPointsPoint.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseNetworkPointsPoint(
      trusted: json.valueAsBool('trusted'),
      greylistedUntil:
          json.hasValue('greylisted_until')
              ? OctezShellTimestampSystem.fromJson(json['greylisted_until'])
              : null,
      state: OctezShellP2pPointState.fromJson(json['state']),
      p2pPeerId:
          json.hasValue('p2p_peer_id')
              ? OctezShellUnistring.fromJson(json['p2p_peer_id'])
              : null,
      lastFailedConnection:
          json.hasValue('last_failed_connection')
              ? OctezShellTimestampSystem.fromJson(
                json['last_failed_connection'],
              )
              : null,
      lastRejectedConnection:
          json.hasValue('last_rejected_connection')
              ? json
                  .valueEnsureAsList<dynamic>('last_rejected_connection')
                  .map(
                    (e) =>
                        OctezShellP2pPointInfoLastRejectedConnectionItem.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      lastEstablishedConnection:
          json.hasValue('last_established_connection')
              ? json
                  .valueEnsureAsList<dynamic>('last_established_connection')
                  .map(
                    (e) =>
                        OctezShellP2pPointInfoLastRejectedConnectionItem.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      lastDisconnection:
          json.hasValue('last_disconnection')
              ? json
                  .valueEnsureAsList<dynamic>('last_disconnection')
                  .map(
                    (e) =>
                        OctezShellP2pPointInfoLastRejectedConnectionItem.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      lastSeen:
          json.hasValue('last_seen')
              ? json
                  .valueEnsureAsList<dynamic>('last_seen')
                  .map(
                    (e) =>
                        OctezShellP2pPointInfoLastRejectedConnectionItem.fromJson(
                          e,
                        ),
                  )
                  .toList()
              : null,
      lastMiss:
          json.hasValue('last_miss')
              ? OctezShellTimestampSystem.fromJson(json['last_miss'])
              : null,
      expectedPeerId:
          json.hasValue('expected_peer_id')
              ? OctezShellUnistring.fromJson(json['expected_peer_id'])
              : null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'trusted': trusted,
        'greylisted_until': greylistedUntil?.toJson(),
        'state': state.toJson(),
        'p2p_peer_id': p2pPeerId?.toJson(),
        'last_failed_connection': lastFailedConnection?.toJson(),
        'last_rejected_connection':
            lastRejectedConnection?.map((e) => e.toJson()).toList(),
        'last_established_connection':
            lastEstablishedConnection?.map((e) => e.toJson()).toList(),
        'last_disconnection':
            lastDisconnection?.map((e) => e.toJson()).toList(),
        'last_seen': lastSeen?.map((e) => e.toJson()).toList(),
        'last_miss': lastMiss?.toJson(),
        'expected_peer_id': expectedPeerId?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellNetworkPointsPointBody {
  final OctezShellNetworkPeersPeerIdBodyAcl? acl;
  final OctezShellCryptoBoxPublicKeyHash? peerId;

  const OctezShellNetworkPointsPointBody({this.acl, this.peerId});

  factory OctezShellNetworkPointsPointBody.fromJson(Map<String, dynamic> json) {
    return OctezShellNetworkPointsPointBody(
      acl:
          json.hasValue('acl')
              ? OctezShellNetworkPeersPeerIdBodyAcl.fromJson(json['acl'])
              : null,
      peerId:
          json.hasValue('peer_id')
              ? OctezShellUnistring.fromJson(json['peer_id'])
              : null,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'acl': acl?.toJson(),
        'peer_id': peerId?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

/// Statistics about the p2p network.
class OctezShellResponseNetworkStat {
  final OctezShellInt64 totalSent;
  final OctezShellInt64 totalRecv;
  final int currentInflow;
  final int currentOutflow;

  const OctezShellResponseNetworkStat({
    required this.totalSent,
    required this.totalRecv,
    required this.currentInflow,
    required this.currentOutflow,
  });

  factory OctezShellResponseNetworkStat.fromJson(Map<String, dynamic> json) {
    return OctezShellResponseNetworkStat(
      totalSent:
          (json['total_sent'] is num
              ? json['total_sent'].toString()
              : json.valueAsString('total_sent')),
      totalRecv:
          (json['total_recv'] is num
              ? json['total_recv'].toString()
              : json.valueAsString('total_recv')),
      currentInflow: json.valueAsInt('current_inflow'),
      currentOutflow: json.valueAsInt('current_outflow'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'total_sent': totalSent,
        'total_recv': totalRecv,
        'current_inflow': currentInflow,
        'current_outflow': currentOutflow,
      }.notNullValue.cast<String, dynamic>();
}

/// Registered backends.
class OctezShellResponseProfilerRegisteredBackend {
  final List<OctezShellResponseProfilerRegisteredBackendRegisteredBackendsItem>
  registeredBackends;
  final OctezShellBackendsEncoding backends;

  const OctezShellResponseProfilerRegisteredBackend({
    required this.registeredBackends,
    required this.backends,
  });

  factory OctezShellResponseProfilerRegisteredBackend.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseProfilerRegisteredBackend(
      registeredBackends:
          json
              .valueEnsureAsList<dynamic>('registered_backends')
              .map(
                (e) =>
                    OctezShellResponseProfilerRegisteredBackendRegisteredBackendsItem.fromJson(
                      e,
                    ),
              )
              .toList(),
      backends:
          json
              .valueEnsureAsList<dynamic>('backends')
              .map(
                (e) =>
                    (e as List)
                        .map(
                          (e) => OctezShellBackendsEncodingItemItem.fromJson(e),
                        )
                        .toList(),
              )
              .toList(),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'registered_backends':
            registeredBackends.map((e) => e.toJson()).toList(),
        'backends':
            backends.map((e) => e.map((x) => x.toJson()).toList()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseStatsGc {
  final num minorWords;
  final num promotedWords;
  final num majorWords;
  final int minorCollections;
  final int majorCollections;
  final int forcedMajorCollections;
  final int heapWords;
  final int heapChunks;
  final int liveWords;
  final int liveBlocks;
  final int freeWords;
  final int freeBlocks;
  final int largestFree;
  final int fragments;
  final int compactions;
  final int topHeapWords;
  final int stackSize;

  const OctezShellResponseStatsGc({
    required this.minorWords,
    required this.promotedWords,
    required this.majorWords,
    required this.minorCollections,
    required this.majorCollections,
    required this.forcedMajorCollections,
    required this.heapWords,
    required this.heapChunks,
    required this.liveWords,
    required this.liveBlocks,
    required this.freeWords,
    required this.freeBlocks,
    required this.largestFree,
    required this.fragments,
    required this.compactions,
    required this.topHeapWords,
    required this.stackSize,
  });

  factory OctezShellResponseStatsGc.fromJson(Map<String, dynamic> json) {
    return OctezShellResponseStatsGc(
      minorWords: json.valueAsNum('minor_words'),
      promotedWords: json.valueAsNum('promoted_words'),
      majorWords: json.valueAsNum('major_words'),
      minorCollections: json.valueAsInt('minor_collections'),
      majorCollections: json.valueAsInt('major_collections'),
      forcedMajorCollections: json.valueAsInt('forced_major_collections'),
      heapWords: json.valueAsInt('heap_words'),
      heapChunks: json.valueAsInt('heap_chunks'),
      liveWords: json.valueAsInt('live_words'),
      liveBlocks: json.valueAsInt('live_blocks'),
      freeWords: json.valueAsInt('free_words'),
      freeBlocks: json.valueAsInt('free_blocks'),
      largestFree: json.valueAsInt('largest_free'),
      fragments: json.valueAsInt('fragments'),
      compactions: json.valueAsInt('compactions'),
      topHeapWords: json.valueAsInt('top_heap_words'),
      stackSize: json.valueAsInt('stack_size'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'minor_words': minorWords,
        'promoted_words': promotedWords,
        'major_words': majorWords,
        'minor_collections': minorCollections,
        'major_collections': majorCollections,
        'forced_major_collections': forcedMajorCollections,
        'heap_words': heapWords,
        'heap_chunks': heapChunks,
        'live_words': liveWords,
        'live_blocks': liveBlocks,
        'free_words': freeWords,
        'free_blocks': freeBlocks,
        'largest_free': largestFree,
        'fragments': fragments,
        'compactions': compactions,
        'top_heap_words': topHeapWords,
        'stack_size': stackSize,
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseVersionVersion {
  final int major;
  final int minor;
  final int build;
  final OctezShellResponseVersionVersionAdditionalInfo additionalInfo;

  const OctezShellResponseVersionVersion({
    required this.major,
    required this.minor,
    required this.build,
    required this.additionalInfo,
  });

  factory OctezShellResponseVersionVersion.fromJson(Map<String, dynamic> json) {
    return OctezShellResponseVersionVersion(
      major: json.valueAsInt('major'),
      minor: json.valueAsInt('minor'),
      build: json.valueAsInt('build'),
      additionalInfo: OctezShellResponseVersionVersionAdditionalInfo.fromJson(
        json['additional_info'],
      ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'major': major,
        'minor': minor,
        'build': build,
        'additional_info': additionalInfo.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseVersionCommitInfo {
  final OctezShellUnistring commitHash;
  final OctezShellUnistring commitDate;

  const OctezShellResponseVersionCommitInfo({
    required this.commitHash,
    required this.commitDate,
  });

  factory OctezShellResponseVersionCommitInfo.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseVersionCommitInfo(
      commitHash: OctezShellUnistring.fromJson(json['commit_hash']),
      commitDate: OctezShellUnistring.fromJson(json['commit_date']),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'commit_hash': commitHash.toJson(),
        'commit_date': commitDate.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseVersion {
  final OctezShellResponseVersionVersion version;
  final OctezShellNetworkVersion networkVersion;
  final OctezShellResponseVersionCommitInfo? commitInfo;

  const OctezShellResponseVersion({
    required this.version,
    required this.networkVersion,
    this.commitInfo,
  });

  factory OctezShellResponseVersion.fromJson(Map<String, dynamic> json) {
    return OctezShellResponseVersion(
      version: json
          .valueTo<OctezShellResponseVersionVersion, Map<String, dynamic>>(
            key: 'version',
            parse: (v) => OctezShellResponseVersionVersion.fromJson(v),
          ),
      networkVersion: json
          .valueTo<OctezShellNetworkVersion, Map<String, dynamic>>(
            key: 'network_version',
            parse: (v) => OctezShellNetworkVersion.fromJson(v),
          ),
      commitInfo: json
          .valueTo<OctezShellResponseVersionCommitInfo?, Map<String, dynamic>>(
            key: 'commit_info',
            parse: (v) => OctezShellResponseVersionCommitInfo.fromJson(v),
          ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'version': version.toJson(),
        'network_version': networkVersion.toJson(),
        'commit_info': commitInfo?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseWorkersBlockValidatorPendingRequestsItem {
  final OctezShellTimestampSystem pushed;
  final OctezShellResponseWorkersBlockValidatorPendingRequestsItemRequest
  request;

  const OctezShellResponseWorkersBlockValidatorPendingRequestsItem({
    required this.pushed,
    required this.request,
  });

  factory OctezShellResponseWorkersBlockValidatorPendingRequestsItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersBlockValidatorPendingRequestsItem(
      pushed: OctezShellTimestampSystem.fromJson(json['pushed']),
      request:
          OctezShellResponseWorkersBlockValidatorPendingRequestsItemRequest.fromJson(
            json['request'],
          ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'pushed': pushed.toJson(),
        'request': request.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseWorkersBlockValidatorCurrentRequest {
  final OctezShellTimestampSystem pushed;
  final OctezShellTimestampSystem treated;
  final OctezShellResponseWorkersBlockValidatorPendingRequestsItemRequest
  request;

  const OctezShellResponseWorkersBlockValidatorCurrentRequest({
    required this.pushed,
    required this.treated,
    required this.request,
  });

  factory OctezShellResponseWorkersBlockValidatorCurrentRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersBlockValidatorCurrentRequest(
      pushed: OctezShellTimestampSystem.fromJson(json['pushed']),
      treated: OctezShellTimestampSystem.fromJson(json['treated']),
      request:
          OctezShellResponseWorkersBlockValidatorPendingRequestsItemRequest.fromJson(
            json['request'],
          ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'pushed': pushed.toJson(),
        'treated': treated.toJson(),
        'request': request.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseWorkersBlockValidator {
  final OctezShellResponseWorkersBlockValidatorStatus status;
  final List<OctezShellResponseWorkersBlockValidatorPendingRequestsItem>
  pendingRequests;
  final OctezShellResponseWorkersBlockValidatorCurrentRequest? currentRequest;

  const OctezShellResponseWorkersBlockValidator({
    required this.status,
    required this.pendingRequests,
    this.currentRequest,
  });

  factory OctezShellResponseWorkersBlockValidator.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersBlockValidator(
      status: OctezShellResponseWorkersBlockValidatorStatus.fromJson(
        json['status'],
      ),
      pendingRequests:
          json
              .valueEnsureAsList<Map<String, dynamic>>('pending_requests')
              .map(
                (e) =>
                    OctezShellResponseWorkersBlockValidatorPendingRequestsItem.fromJson(
                      e,
                    ),
              )
              .toList(),
      currentRequest: json.valueTo<
        OctezShellResponseWorkersBlockValidatorCurrentRequest?,
        Map<String, dynamic>
      >(
        key: 'current_request',
        parse:
            (v) =>
                OctezShellResponseWorkersBlockValidatorCurrentRequest.fromJson(
                  v,
                ),
      ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'status': status.toJson(),
        'pending_requests': pendingRequests.map((e) => e.toJson()).toList(),
        'current_request': currentRequest?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseWorkersChainValidatorsItemInformation {
  final int instances;
  final OctezShellResponseWorkersBlockValidatorStatus status;
  final int queueLength;

  const OctezShellResponseWorkersChainValidatorsItemInformation({
    required this.instances,
    required this.status,
    required this.queueLength,
  });

  factory OctezShellResponseWorkersChainValidatorsItemInformation.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersChainValidatorsItemInformation(
      instances: json.valueAsInt('instances'),
      status: OctezShellResponseWorkersBlockValidatorStatus.fromJson(
        json['status'],
      ),
      queueLength: json.valueAsInt('queue_length'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'instances': instances,
        'status': status.toJson(),
        'queue_length': queueLength,
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseWorkersChainValidatorsItem {
  final OctezShellChainId chainId;
  final OctezShellResponseWorkersBlockValidatorStatus status;
  final OctezShellResponseWorkersChainValidatorsItemInformation information;
  final int pipelines;

  const OctezShellResponseWorkersChainValidatorsItem({
    required this.chainId,
    required this.status,
    required this.information,
    required this.pipelines,
  });

  factory OctezShellResponseWorkersChainValidatorsItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersChainValidatorsItem(
      chainId: OctezShellUnistring.fromJson(json['chain_id']),
      status: OctezShellResponseWorkersBlockValidatorStatus.fromJson(
        json['status'],
      ),
      information: json.valueTo<
        OctezShellResponseWorkersChainValidatorsItemInformation,
        Map<String, dynamic>
      >(
        key: 'information',
        parse:
            (v) =>
                OctezShellResponseWorkersChainValidatorsItemInformation.fromJson(
                  v,
                ),
      ),
      pipelines: json.valueAsInt('pipelines'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'chain_id': chainId.toJson(),
        'status': status.toJson(),
        'information': information.toJson(),
        'pipelines': pipelines,
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseWorkersChainValidatorsChainIdPendingRequestsItem {
  final OctezShellTimestampSystem pushed;
  final OctezShellResponseWorkersChainValidatorsChainIdPendingRequestsItemRequest
  request;

  const OctezShellResponseWorkersChainValidatorsChainIdPendingRequestsItem({
    required this.pushed,
    required this.request,
  });

  factory OctezShellResponseWorkersChainValidatorsChainIdPendingRequestsItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersChainValidatorsChainIdPendingRequestsItem(
      pushed: OctezShellTimestampSystem.fromJson(json['pushed']),
      request:
          OctezShellResponseWorkersChainValidatorsChainIdPendingRequestsItemRequest.fromJson(
            json['request'],
          ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'pushed': pushed.toJson(),
        'request': request.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseWorkersChainValidatorsChainIdCurrentRequest {
  final OctezShellTimestampSystem pushed;
  final OctezShellTimestampSystem treated;
  final OctezShellResponseWorkersChainValidatorsChainIdPendingRequestsItemRequest
  request;

  const OctezShellResponseWorkersChainValidatorsChainIdCurrentRequest({
    required this.pushed,
    required this.treated,
    required this.request,
  });

  factory OctezShellResponseWorkersChainValidatorsChainIdCurrentRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersChainValidatorsChainIdCurrentRequest(
      pushed: OctezShellTimestampSystem.fromJson(json['pushed']),
      treated: OctezShellTimestampSystem.fromJson(json['treated']),
      request:
          OctezShellResponseWorkersChainValidatorsChainIdPendingRequestsItemRequest.fromJson(
            json['request'],
          ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'pushed': pushed.toJson(),
        'treated': treated.toJson(),
        'request': request.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseWorkersChainValidatorsChainId {
  final OctezShellResponseWorkersBlockValidatorStatus status;
  final List<OctezShellResponseWorkersChainValidatorsChainIdPendingRequestsItem>
  pendingRequests;
  final OctezShellResponseWorkersChainValidatorsChainIdCurrentRequest?
  currentRequest;

  const OctezShellResponseWorkersChainValidatorsChainId({
    required this.status,
    required this.pendingRequests,
    this.currentRequest,
  });

  factory OctezShellResponseWorkersChainValidatorsChainId.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersChainValidatorsChainId(
      status: OctezShellResponseWorkersBlockValidatorStatus.fromJson(
        json['status'],
      ),
      pendingRequests:
          json
              .valueEnsureAsList<Map<String, dynamic>>('pending_requests')
              .map(
                (e) =>
                    OctezShellResponseWorkersChainValidatorsChainIdPendingRequestsItem.fromJson(
                      e,
                    ),
              )
              .toList(),
      currentRequest: json.valueTo<
        OctezShellResponseWorkersChainValidatorsChainIdCurrentRequest?,
        Map<String, dynamic>
      >(
        key: 'current_request',
        parse:
            (v) =>
                OctezShellResponseWorkersChainValidatorsChainIdCurrentRequest.fromJson(
                  v,
                ),
      ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'status': status.toJson(),
        'pending_requests': pendingRequests.map((e) => e.toJson()).toList(),
        'current_request': currentRequest?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseWorkersChainValidatorsChainIdDdbOperationDb {
  final int tableLength;
  final int schedulerLength;

  const OctezShellResponseWorkersChainValidatorsChainIdDdbOperationDb({
    required this.tableLength,
    required this.schedulerLength,
  });

  factory OctezShellResponseWorkersChainValidatorsChainIdDdbOperationDb.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersChainValidatorsChainIdDdbOperationDb(
      tableLength: json.valueAsInt('table_length'),
      schedulerLength: json.valueAsInt('scheduler_length'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'table_length': tableLength,
        'scheduler_length': schedulerLength,
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseWorkersChainValidatorsChainIdDdb {
  final int p2pReaders;
  final int activeChains;
  final OctezShellResponseWorkersChainValidatorsChainIdDdbOperationDb
  operationDb;
  final OctezShellResponseWorkersChainValidatorsChainIdDdbOperationDb
  operationsDb;
  final OctezShellResponseWorkersChainValidatorsChainIdDdbOperationDb
  blockHeaderDb;
  final int activeConnections;
  final int activePeers;

  const OctezShellResponseWorkersChainValidatorsChainIdDdb({
    required this.p2pReaders,
    required this.activeChains,
    required this.operationDb,
    required this.operationsDb,
    required this.blockHeaderDb,
    required this.activeConnections,
    required this.activePeers,
  });

  factory OctezShellResponseWorkersChainValidatorsChainIdDdb.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersChainValidatorsChainIdDdb(
      p2pReaders: json.valueAsInt('p2p_readers'),
      activeChains: json.valueAsInt('active_chains'),
      operationDb: json.valueTo<
        OctezShellResponseWorkersChainValidatorsChainIdDdbOperationDb,
        Map<String, dynamic>
      >(
        key: 'operation_db',
        parse:
            (v) =>
                OctezShellResponseWorkersChainValidatorsChainIdDdbOperationDb.fromJson(
                  v,
                ),
      ),
      operationsDb: json.valueTo<
        OctezShellResponseWorkersChainValidatorsChainIdDdbOperationDb,
        Map<String, dynamic>
      >(
        key: 'operations_db',
        parse:
            (v) =>
                OctezShellResponseWorkersChainValidatorsChainIdDdbOperationDb.fromJson(
                  v,
                ),
      ),
      blockHeaderDb: json.valueTo<
        OctezShellResponseWorkersChainValidatorsChainIdDdbOperationDb,
        Map<String, dynamic>
      >(
        key: 'block_header_db',
        parse:
            (v) =>
                OctezShellResponseWorkersChainValidatorsChainIdDdbOperationDb.fromJson(
                  v,
                ),
      ),
      activeConnections: json.valueAsInt('active_connections'),
      activePeers: json.valueAsInt('active_peers'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'p2p_readers': p2pReaders,
        'active_chains': activeChains,
        'operation_db': operationDb.toJson(),
        'operations_db': operationsDb.toJson(),
        'block_header_db': blockHeaderDb.toJson(),
        'active_connections': activeConnections,
        'active_peers': activePeers,
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsItemPipelines {
  final int fetchedHeaders;
  final int fetchedBlocks;

  const OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsItemPipelines({
    required this.fetchedHeaders,
    required this.fetchedBlocks,
  });

  factory OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsItemPipelines.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsItemPipelines(
      fetchedHeaders: json.valueAsInt('fetched_headers'),
      fetchedBlocks: json.valueAsInt('fetched_blocks'),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'fetched_headers': fetchedHeaders,
        'fetched_blocks': fetchedBlocks,
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsItem {
  final OctezShellCryptoBoxPublicKeyHash peerId;
  final OctezShellResponseWorkersBlockValidatorStatus status;
  final OctezShellResponseWorkersChainValidatorsItemInformation information;
  final OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsItemPipelines
  pipelines;

  const OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsItem({
    required this.peerId,
    required this.status,
    required this.information,
    required this.pipelines,
  });

  factory OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsItem(
      peerId: OctezShellUnistring.fromJson(json['peer_id']),
      status: OctezShellResponseWorkersBlockValidatorStatus.fromJson(
        json['status'],
      ),
      information: json.valueTo<
        OctezShellResponseWorkersChainValidatorsItemInformation,
        Map<String, dynamic>
      >(
        key: 'information',
        parse:
            (v) =>
                OctezShellResponseWorkersChainValidatorsItemInformation.fromJson(
                  v,
                ),
      ),
      pipelines: json.valueTo<
        OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsItemPipelines,
        Map<String, dynamic>
      >(
        key: 'pipelines',
        parse:
            (v) =>
                OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsItemPipelines.fromJson(
                  v,
                ),
      ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'peer_id': peerId.toJson(),
        'status': status.toJson(),
        'information': information.toJson(),
        'pipelines': pipelines.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItem {
  final OctezShellTimestampSystem pushed;
  final OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItemRequest
  request;

  const OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItem({
    required this.pushed,
    required this.request,
  });

  factory OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItem(
      pushed: OctezShellTimestampSystem.fromJson(json['pushed']),
      request:
          OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItemRequest.fromJson(
            json['request'],
          ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'pushed': pushed.toJson(),
        'request': request.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdCurrentRequest {
  final OctezShellTimestampSystem pushed;
  final OctezShellTimestampSystem treated;
  final OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItemRequest
  request;

  const OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdCurrentRequest({
    required this.pushed,
    required this.treated,
    required this.request,
  });

  factory OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdCurrentRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdCurrentRequest(
      pushed: OctezShellTimestampSystem.fromJson(json['pushed']),
      treated: OctezShellTimestampSystem.fromJson(json['treated']),
      request:
          OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItemRequest.fromJson(
            json['request'],
          ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'pushed': pushed.toJson(),
        'treated': treated.toJson(),
        'request': request.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerId {
  final OctezShellResponseWorkersBlockValidatorStatus status;
  final List<
    OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItem
  >
  pendingRequests;
  final OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdCurrentRequest?
  currentRequest;

  const OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerId({
    required this.status,
    required this.pendingRequests,
    this.currentRequest,
  });

  factory OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerId.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerId(
      status: OctezShellResponseWorkersBlockValidatorStatus.fromJson(
        json['status'],
      ),
      pendingRequests:
          json
              .valueEnsureAsList<Map<String, dynamic>>('pending_requests')
              .map(
                (e) =>
                    OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdPendingRequestsItem.fromJson(
                      e,
                    ),
              )
              .toList(),
      currentRequest: json.valueTo<
        OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdCurrentRequest?,
        Map<String, dynamic>
      >(
        key: 'current_request',
        parse:
            (v) =>
                OctezShellResponseWorkersChainValidatorsChainIdPeersValidatorsPeerIdCurrentRequest.fromJson(
                  v,
                ),
      ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'status': status.toJson(),
        'pending_requests': pendingRequests.map((e) => e.toJson()).toList(),
        'current_request': currentRequest?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

/// A batch of operation. This format is used to gossip operations between peers.
class OctezShellMempool {
  final List<OctezShellOperationHash> knownValid;
  final List<OctezShellOperationHash> pending;

  const OctezShellMempool({required this.knownValid, required this.pending});

  factory OctezShellMempool.fromJson(Map<String, dynamic> json) {
    return OctezShellMempool(
      knownValid:
          json
              .valueEnsureAsList<dynamic>('known_valid')
              .map((e) => OctezShellUnistring.fromJson(e))
              .toList(),
      pending:
          json
              .valueEnsureAsList<dynamic>('pending')
              .map((e) => OctezShellUnistring.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'known_valid': knownValid.map((e) => e.toJson()).toList(),
        'pending': pending.map((e) => e.toJson()).toList(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItem {
  final OctezShellTimestampSystem pushed;
  final OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequest
  request;

  const OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItem({
    required this.pushed,
    required this.request,
  });

  factory OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItem(
      pushed: OctezShellTimestampSystem.fromJson(json['pushed']),
      request:
          OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequest.fromJson(
            json['request'],
          ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'pushed': pushed.toJson(),
        'request': request.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseWorkersPrevalidatorsChainIdCurrentRequest {
  final OctezShellTimestampSystem pushed;
  final OctezShellTimestampSystem treated;
  final OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequest
  request;

  const OctezShellResponseWorkersPrevalidatorsChainIdCurrentRequest({
    required this.pushed,
    required this.treated,
    required this.request,
  });

  factory OctezShellResponseWorkersPrevalidatorsChainIdCurrentRequest.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersPrevalidatorsChainIdCurrentRequest(
      pushed: OctezShellTimestampSystem.fromJson(json['pushed']),
      treated: OctezShellTimestampSystem.fromJson(json['treated']),
      request:
          OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItemRequest.fromJson(
            json['request'],
          ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'pushed': pushed.toJson(),
        'treated': treated.toJson(),
        'request': request.toJson(),
      }.notNullValue.cast<String, dynamic>();
}

class OctezShellResponseWorkersPrevalidatorsChainId {
  final OctezShellResponseWorkersBlockValidatorStatus status;
  final List<OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItem>
  pendingRequests;
  final OctezShellResponseWorkersPrevalidatorsChainIdCurrentRequest?
  currentRequest;

  const OctezShellResponseWorkersPrevalidatorsChainId({
    required this.status,
    required this.pendingRequests,
    this.currentRequest,
  });

  factory OctezShellResponseWorkersPrevalidatorsChainId.fromJson(
    Map<String, dynamic> json,
  ) {
    return OctezShellResponseWorkersPrevalidatorsChainId(
      status: OctezShellResponseWorkersBlockValidatorStatus.fromJson(
        json['status'],
      ),
      pendingRequests:
          json
              .valueEnsureAsList<Map<String, dynamic>>('pending_requests')
              .map(
                (e) =>
                    OctezShellResponseWorkersPrevalidatorsChainIdPendingRequestsItem.fromJson(
                      e,
                    ),
              )
              .toList(),
      currentRequest: json.valueTo<
        OctezShellResponseWorkersPrevalidatorsChainIdCurrentRequest?,
        Map<String, dynamic>
      >(
        key: 'current_request',
        parse:
            (v) =>
                OctezShellResponseWorkersPrevalidatorsChainIdCurrentRequest.fromJson(
                  v,
                ),
      ),
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'status': status.toJson(),
        'pending_requests': pendingRequests.map((e) => e.toJson()).toList(),
        'current_request': currentRequest?.toJson(),
      }.notNullValue.cast<String, dynamic>();
}
