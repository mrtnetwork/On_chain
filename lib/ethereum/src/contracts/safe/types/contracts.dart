import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:on_chain/ethereum/src/exception/exception.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'package:on_chain/solidity/solidity.dart';

enum SafeContractLayer { l1, l2 }

enum SafeContractExecutionOpration {
  call(0),
  delegateCall(1);

  final int value;
  const SafeContractExecutionOpration(this.value);
  static SafeContractExecutionOpration fromValue(int? value) {
    return values.firstWhere((e) => e.value == value,
        orElse: () => throw ItemNotFoundException(value: value));
  }
}

class SafeContractEncodedCall {
  final AbiFunctionFragment func;
  final List<Object> params;
  final List<int> encode;
  SafeContractEncodedCall(
      {required this.func,
      List<Object> params = const [],
      required List<int> encode})
      : params = params.immutable,
        encode = encode.asImmutableBytes;
}

enum SafeContractFunction {
  addOwnerWithThreshold("addOwnerWithThreshold"),
  domainSeparatorTypeHash("DOMAIN_SEPARATOR_TYPEHASH"),
  isOwner("isOwner"),
  execTransactionFromModule("execTransactionFromModule"),
  signedMessages("signedMessages"),
  enableModule("enableModule"),
  changeThreshold("changeThreshold"),
  approvedHashes("approvedHashes"),
  changeMasterCopy("changeMasterCopy"),
  sentinelModules("SENTINEL_MODULES"),
  sentinelOwners("SENTINEL_OWNERS"),
  getOwners("getOwners"),
  name("NAME"),
  nonce("nonce"),
  getModules("getModules"),
  safeMsgTypeHash("SAFE_MSG_TYPEHASH"),
  safeTxTypeHash("SAFE_TX_TYPEHASH"),
  disableModule("disableModule"),
  swapOwner("swapOwner"),
  getThreshold("getThreshold"),
  domainSeparator("domainSeparator"),
  removeOwner("removeOwner"),
  version("VERSION"),
  setup("setup"),
  execTransaction("execTransaction"),
  requiredTxGas("requiredTxGas"),
  approveHash("approveHash"),
  signMessage("signMessage"),
  isValidSignature("isValidSignature"),
  getMessageHash("getMessageHash"),
  encodeTransactionData("encodeTransactionData"),
  getTransactionHash("getTransactionHash"),
  execTransactionFromModuleReturnData("execTransactionFromModuleReturnData"),
  getModulesPaginated("getModulesPaginated"),
  setFallbackHandler("setFallbackHandler"),
  isModuleEnabled("isModuleEnabled"),
  checkNSignatures("checkNSignatures"),
  checkSignatures("checkSignatures"),
  getChainId("getChainId"),
  getStorageAt("getStorageAt"),
  setGuard("setGuard"),
  simulateAndRevert("simulateAndRevert"),
  createProxyWithNonce("createProxyWithNonce"),
  proxyCreationCode("proxyCreationCode"),
  createProxy("createProxy"),
  proxyRuntimeCode("proxyRuntimeCode"),
  createProxyWithCallback("createProxyWithCallback"),
  calculateCreateProxyWithNonceAddress("calculateCreateProxyWithNonceAddress"),
  setModuleGuard("setModuleGuard"),
  createChainSpecificProxyWithNonce("createChainSpecificProxyWithNonce"),
  createChainSpecificProxyWithNonceL2("createChainSpecificProxyWithNonceL2"),
  createProxyWithNonceL2("createProxyWithNonceL2");

  final String functionName;
  const SafeContractFunction(this.functionName);
  static SafeContractFunction fromFunctionName(String? name) {
    return values.firstWhere((e) => e.functionName == name,
        orElse: () => throw ItemNotFoundException(value: name));
  }

  static SafeContractFunction? fromFunctionNameOrNull(String? name) {
    return values.firstWhereNullable((e) => e.functionName == name);
  }
}

enum SafeContractFlavor {
  canonical(0),
  zksync(1),
  eip155(2);

  final int value;
  const SafeContractFlavor(this.value);
  static SafeContractFlavor fromName(String? name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw ItemNotFoundException(value: name));
  }

  static SafeContractFlavor fromValue(int? value) {
    return values.firstWhere((e) => e.value == value,
        orElse: () => throw ItemNotFoundException(value: value));
  }
}

enum SafeContractName {
  gnosisSafe(contractName: "GnosisSafe", layer: SafeContractLayer.l1, value: 0),
  gnosisSafeL2(
      contractName: "GnosisSafeL2", layer: SafeContractLayer.l2, value: 1),
  gnosisSafeProxyFactory(contractName: "GnosisSafeProxyFactory", value: 2),
  proxyFactory(contractName: "ProxyFactory", value: 3),
  safeL2(contractName: "SafeL2", layer: SafeContractLayer.l2, value: 4),
  safe(contractName: "Safe", layer: SafeContractLayer.l1, value: 5),
  safeProxyFactory(contractName: "SafeProxyFactory", value: 6),
  compatibilityFallbackHandler(
      contractName: "CompatibilityFallbackHandler", value: 7),
  defaultCallbackHandler(contractName: "DefaultCallbackHandler", value: 8);

  final String contractName;
  final SafeContractLayer? layer;
  final int value;
  const SafeContractName(
      {required this.contractName, this.layer, required this.value});
  static SafeContractName fromContractName(String? contractName) {
    return values.firstWhere((e) => e.contractName == contractName,
        orElse: () => throw ItemNotFoundException(value: contractName));
  }

  static SafeContractName fromValue(int? value) {
    return values.firstWhere((e) => e.value == value,
        orElse: () => throw ItemNotFoundException(value: value));
  }
}

enum SafeContractVersion implements Comparable<SafeContractVersion> {
  v1_0_0("1.0.0", 0),
  v1_1_1("1.1.1", 1),
  v1_2_0("1.2.0", 2),
  v1_3_0("1.3.0", 3),
  v1_4_1("1.4.1", 4),
  v1_5_0("1.5.0", 5);

  final String version;
  final int value;

  const SafeContractVersion(this.version, this.value);

  static SafeContractVersion fromVersion(String? version) {
    return values.firstWhere((e) => e.version == version,
        orElse: () => throw ItemNotFoundException(value: version));
  }

  static SafeContractVersion fromValue(int? value) {
    return values.firstWhere((e) => e.value == value,
        orElse: () => throw ItemNotFoundException(value: value));
  }

  // Compare to operator (<=>) for general comparison
  @override
  int compareTo(SafeContractVersion other) {
    return value.compareTo(other.value);
  }

  bool operator >=(SafeContractVersion other) {
    return value >= other.value;
  }

  bool operator <=(SafeContractVersion other) {
    return value <= other.value;
  }

  bool operator <(SafeContractVersion other) {
    return value < other.value;
  }

  bool operator >(SafeContractVersion other) {
    return value > other.value;
  }
}

class SafeContractDeployment with InternalCborSerialization {
  final ETHAddress address;
  final List<int> codeHash;
  SafeContractDeployment({required this.address, required List<int> codeHash})
      : codeHash = codeHash.asImmutableBytes;
  factory SafeContractDeployment.fromJson(Map<String, dynamic> json) {
    return SafeContractDeployment(
        address: ETHAddress(json.valueAs("address")),
        codeHash: json.valueAsBytes("codeHash"));
  }

  factory SafeContractDeployment.deserialize(
      {List<int>? cborBytes, CborObject? cbor}) {
    final values = QuickCborObject.cborTagValue(
        cborBytes: cborBytes,
        object: cbor,
        tags: InternalCborSerializationConst.defaultTag);
    return SafeContractDeployment(
        address: ETHAddress.fromBytes(values.elementAtBytes(0)),
        codeHash: values.elementAtBytes(1));
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "address": address.address,
      "codeHash": BytesUtils.toHexString(codeHash, prefix: "0x")
    };
  }

  @override
  CborObject<CborListValue> toCbor() {
    return CborTagValue(
        CborListValue.definite([
          CborBytesValue(address.toBytes()),
          CborBytesValue(codeHash),
        ].cast()),
        InternalCborSerializationConst.defaultTag);
  }
}

class SafeContractManifest with InternalCborSerialization {
  final bool released;
  final SafeContractName contractName;
  final SafeContractVersion version;
  final Map<SafeContractFlavor, SafeContractDeployment> deployments;
  final Map<BigInt, List<SafeContractFlavor>> networkAddresses;
  final ContractABI abi;
  List<BigInt> getSupportChainIds({SafeContractFlavor? flavor}) {
    if (flavor == null) return networkAddresses.keys.toList();
    return networkAddresses.entries
        .where((e) => e.value.contains(flavor))
        .map((e) => e.key)
        .toList();
  }

  SafeContractManifest(
      {required this.released,
      required this.contractName,
      required this.version,
      required Map<SafeContractFlavor, SafeContractDeployment> deployments,
      required Map<BigInt, List<SafeContractFlavor>> networkAddresses,
      required this.abi})
      : deployments = deployments.immutable,
        networkAddresses = networkAddresses
            .map((k, v) =>
                MapEntry<BigInt, List<SafeContractFlavor>>(k, v.toImutableList))
            .immutable;
  factory SafeContractManifest.fromJson(Map<String, dynamic> json) {
    return SafeContractManifest(
        released: json.valueAs("released"),
        contractName:
            SafeContractName.fromContractName(json.valueAs("contractName")),
        version: SafeContractVersion.fromVersion(json.valueAs("version")),
        deployments: json.valueEnsureAsMap<String, dynamic>("deployments").map(
            (k, v) => MapEntry(SafeContractFlavor.fromName(k),
                SafeContractDeployment.fromJson(v))),
        networkAddresses: json
            .valueEnsureAsMap<String, dynamic>("networkAddresses")
            .map((k, v) {
          List<SafeContractFlavor> types = [];
          if (v is String) {
            types.add(SafeContractFlavor.fromName(v));
          } else {
            types.addAll(JsonParser.valueEnsureAsList<String>(v)
                .map(SafeContractFlavor.fromName));
          }
          return MapEntry(
              JsonParser.valueAsBigInt<BigInt>(k), types.toImutableList);
        }),
        abi: ContractABI.fromJson(json.valueAs("abi")));
  }
  factory SafeContractManifest.deserialize(
      {List<int>? cborBytes, CborObject? cbor}) {
    final values = QuickCborObject.cborTagValue(
        cborBytes: cborBytes,
        object: cbor,
        tags: InternalCborSerializationConst.defaultTag);
    return SafeContractManifest(
        released: values.elementAt<CborBoleanValue>(0).value,
        contractName:
            SafeContractName.fromValue(values.elementAt<CborIntValue>(1).value),
        version: SafeContractVersion.fromValue(
            values.elementAt<CborIntValue>(2).value),
        deployments: values
            .elementAt<CborMapValue>(3)
            .valueAsMap<CborIntValue, CborTagValue>()
            .map((k, v) => MapEntry(SafeContractFlavor.fromValue(k.value),
                SafeContractDeployment.deserialize(cbor: v))),
        networkAddresses: values
            .elementAt<CborMapValue>(4)
            .valueAsMap<CborBigIntValue, CborListValue>()
            .map((k, v) => MapEntry(
                k.value,
                v
                    .valueAsListOf<CborIntValue>()
                    .map((e) => SafeContractFlavor.fromValue(e.value))
                    .toList())),
        abi: ContractABI.deserialize(cbor: values.elementAt<CborTagValue>(5)));
  }

  @override
  CborTagValue<CborListValue> toCbor() {
    return CborTagValue(
        CborListValue.definite([
          CborBoleanValue(released),
          CborIntValue(contractName.value),
          CborIntValue(version.value),
          CborMapValue.definite(deployments
              .map((k, v) => MapEntry(CborIntValue(k.value), v.toCbor()))),
          CborMapValue.definite(networkAddresses.map((k, v) => MapEntry(
              CborBigIntValue(k),
              CborListValue.definite(
                  v.map((e) => CborIntValue(e.value)).toList())))),
          abi.toCbor(),
        ].cast()),
        InternalCborSerializationConst.defaultTag);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "released": released,
      "contractName": contractName.contractName,
      "version": version.version,
      "deployments": deployments.map((k, v) => MapEntry(k.name, v.toJson())),
      "networkAddresses": networkAddresses.map((k, v) => MapEntry(k.toString(),
          v.length == 1 ? v.first.name : v.map((e) => e.name).toList())),
      "abi": abi.toJson()
    };
  }
}

class SafeContractAssets with InternalCborSerialization {
  final Map<SafeContractVersion, SafeContractVersionedManifest> manifests;
  SafeContractAssets(
      {required Map<SafeContractVersion, SafeContractVersionedManifest>
          manifests})
      : manifests = manifests.immutable;
  factory SafeContractAssets.fromJson(Map<String, dynamic> json) {
    return SafeContractAssets(
        manifests: json.valueEnsureAsMap<String, dynamic>("manifests").map(
            (k, v) => MapEntry(SafeContractVersion.fromVersion(k),
                SafeContractVersionedManifest.fromJson(v))));
  }
  factory SafeContractAssets.deserialize(
      {List<int>? cborBytes, CborObject? cbor}) {
    final values = QuickCborObject.cborTagValue(
        cborBytes: cborBytes,
        object: cbor,
        tags: InternalCborSerializationConst.defaultTag);
    return SafeContractAssets(
      manifests: values
          .elementAt<CborMapValue>(0)
          .valueAsMap<CborIntValue, CborTagValue>()
          .map((k, v) => MapEntry(SafeContractVersion.fromValue(k.value),
              SafeContractVersionedManifest.deserialize(cbor: v))),
    );
  }
  @override
  CborTagValue<CborListValue> toCbor() {
    return CborTagValue(
        CborListValue.definite([
          CborMapValue.definite(manifests
              .map((k, v) => MapEntry(CborIntValue(k.value), v.toCbor())))
        ].cast()),
        InternalCborSerializationConst.defaultTag);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "manifests": manifests.map((k, v) => MapEntry(k.version, v.toJson()))
    };
  }

  SafeContractVersionedManifest getLatestDeployment({BigInt? chainId}) {
    if (this.manifests.isEmpty) {
      throw ETHPluginException('No deployment found.',
          details: {"chainId": chainId.toString});
    }
    final manifests = this.manifests.values.toList()
      ..sort((a, b) => b.version.compareTo(a.version));
    if (chainId == null) return manifests.first;
    return manifests.firstWhere(
        (e) => e.proxy.networkAddresses.containsKey(chainId),
        orElse: () => throw ETHPluginException(
            'No deployment found for the specified chain ID.',
            details: {"chainId": chainId.toString}));
  }

  SafeContractVersionedManifest atVersion(SafeContractVersion version) {
    final manifest = manifests[version];
    if (manifest == null) {
      throw ETHPluginException('No deployment found.');
    }
    return manifest;
  }

  SafeContractVersionedManifest fromSingletonAddress(ETHAddress address) {
    for (final i in manifests.values) {
      try {
        i.getSafeSingletonManifestFromAddress(address);
        return i;
      } on ETHPluginException catch (_) {}
    }
    // If none matched, throw meaningful exception
    throw ETHPluginException(
      "No versioned manifest found from address $address.",
      details: {"address": address.address},
    );
  }

  List<BigInt> getSupportedChainIds(
      {SafeContractFlavor? flavor, SafeContractVersion? version}) {
    if (version != null) {
      return manifests[version]?.singleton.getSupportChainIds(flavor: flavor) ??
          [];
    }
    return manifests.entries
        .map((e) => e.value.singleton.getSupportChainIds(flavor: flavor))
        .expand((e) => e)
        .toSet()
        .toList();
  }
}

class SafeContractVersionedManifest with InternalCborSerialization {
  final SafeContractManifest singleton;
  final SafeContractManifest proxy;
  final SafeContractManifest? singltonL2;
  final SafeContractManifest? fallbackHandler;
  SafeContractVersion get version => singleton.version;
  const SafeContractVersionedManifest._(
      {required this.singleton,
      required this.proxy,
      this.singltonL2,
      this.fallbackHandler});
  factory SafeContractVersionedManifest({
    required SafeContractManifest singleton,
    required SafeContractManifest proxy,
    SafeContractManifest? fallBackHandler,
    SafeContractManifest? singltonL2,
  }) {
    // v1.0.0 logic
    if (singleton.version == SafeContractVersion.v1_0_0) {
      if (proxy.version != SafeContractVersion.v1_0_0) {
        throw const ETHPluginException(
            'ProxyFactory version must match singleton version v1.0.0.');
      }
      if (fallBackHandler != null || singltonL2 != null) {
        throw const ETHPluginException(
            'Fallback handler and Singleton L2 are not supported for v1.0.0 contracts.');
      }
      return SafeContractVersionedManifest._(
          singleton: singleton, proxy: proxy);
    }

    // v1.1.1 and v1.2.0 logic
    switch (singleton.version) {
      case SafeContractVersion.v1_1_1:
      case SafeContractVersion.v1_2_0:
        if (singltonL2 != null) {
          throw ETHPluginException(
              'Singleton L2 is not supported for version ${singleton.version}.');
        }
        if (proxy.version != SafeContractVersion.v1_1_1) {
          throw ETHPluginException(
              'ProxyFactory must have version v1.1.1 for this singleton version ${singleton.version.version}.');
        }
        if (fallBackHandler == null ||
            fallBackHandler.version != SafeContractVersion.v1_1_1) {
          throw const ETHPluginException(
              'Fallback handler is required and must have version v1.1.1 for this singleton version.');
        }
        return SafeContractVersionedManifest._(
            singleton: singleton,
            proxy: proxy,
            fallbackHandler: fallBackHandler,
            singltonL2: singltonL2);

      default:
        if (fallBackHandler == null ||
            singltonL2 == null ||
            {
                  singleton.version,
                  proxy.version,
                  fallBackHandler.version,
                  singltonL2.version
                }.length !=
                1) {
          throw const ETHPluginException(
            'All contracts must have the same version and fallback/L2 proxies must be provided.',
          );
        }
        return SafeContractVersionedManifest._(
            singleton: singleton,
            proxy: proxy,
            fallbackHandler: fallBackHandler,
            singltonL2: singltonL2);
    }
  }

  factory SafeContractVersionedManifest.deserialize(
      {List<int>? cborBytes, CborObject? cbor}) {
    final values = QuickCborObject.cborTagValue(
        cborBytes: cborBytes,
        object: cbor,
        tags: InternalCborSerializationConst.defaultTag);
    return SafeContractVersionedManifest(
        singleton: SafeContractManifest.deserialize(
            cbor: values.elementAt<CborTagValue>(0)),
        proxy: SafeContractManifest.deserialize(
            cbor: values.elementAt<CborTagValue>(1)),
        singltonL2: values.elementMaybeAt<SafeContractManifest, CborTagValue>(
            2, (e) => SafeContractManifest.deserialize(cbor: e)),
        fallBackHandler:
            values.elementMaybeAt<SafeContractManifest, CborTagValue>(
                3, (e) => SafeContractManifest.deserialize(cbor: e)));
  }
  factory SafeContractVersionedManifest.fromJson(Map<String, dynamic> json) {
    return SafeContractVersionedManifest(
        singleton: SafeContractManifest.fromJson(
            json.valueEnsureAsMap<String, dynamic>("singleton")),
        proxy: SafeContractManifest.fromJson(
            json.valueEnsureAsMap<String, dynamic>("proxy")),
        singltonL2: json.valueTo<SafeContractManifest?, Map<String, dynamic>>(
            key: "singletonL2", parse: (v) => SafeContractManifest.fromJson(v)),
        fallBackHandler:
            json.valueTo<SafeContractManifest?, Map<String, dynamic>>(
                key: "handler",
                parse: (v) => SafeContractManifest.fromJson(v)));
  }

  SafeContractDeployment getSafeSingletonDeployment(
      {required BigInt chainId,
      SafeContractFlavor flavor = SafeContractFlavor.canonical,
      SafeContractLayer layer = SafeContractLayer.l1}) {
    final singleton = switch (layer) {
      SafeContractLayer.l1 => this.singleton,
      SafeContractLayer.l2 => singltonL2
    };
    if (singleton == null) {
      throw ETHPluginException(
          'L2 proxy is not configured for this Safe version.',
          details: {'version': version.version});
    }

    final networkAddress = singleton.networkAddresses[chainId];

    if (networkAddress == null) {
      throw const ETHPluginException(
          'No deployment found for the specified chain ID.');
    }

    if (!networkAddress.contains(flavor)) {
      throw ETHPluginException(
        'The specified flavor is not available for the current chain ID.',
        details: {'flavor': flavor.name, 'chainId': chainId.toString()},
      );
    }

    final deployment = singleton.deployments[flavor];
    if (deployment == null) {
      throw ETHPluginException(
        'Factory deployment not found for the specified flavor and chain ID.',
        details: {'flavor': flavor.name, 'chainId': chainId.toString()},
      );
    }

    return deployment;
  }

  SafeContractManifest getSafeSingletonManifestFromAddress(ETHAddress address) {
    if (singleton.deployments.values.any((e) => e.address == address)) {
      return singleton;
    }
    if (singltonL2?.deployments.values.any((e) => e.address == address) ??
        false) {
      return singltonL2!;
    }
    throw ETHPluginException(
      "The provided address $address does not match any known Safe singleton deployment.",
      details: {
        "address": address.address,
        "availableSingletons": [
          ...singleton.deployments.values.map((e) => e.address.address),
          if (singltonL2 != null)
            ...singltonL2!.deployments.values.map((e) => e.address.address)
        ]
      },
    );
  }

  SafeContractDeployment getSafeFactoryDeployment(
      {required BigInt chainId,
      SafeContractFlavor flavor = SafeContractFlavor.canonical}) {
    final networkAddress = proxy.networkAddresses[chainId];

    if (networkAddress == null) {
      throw const ETHPluginException(
          'No deployment found for the specified chain ID.');
    }

    if (!networkAddress.contains(flavor)) {
      throw ETHPluginException(
        'The specified flavor is not available for the current chain ID.',
        details: {'flavor': flavor.name, 'chainId': chainId.toString()},
      );
    }

    final deployment = proxy.deployments[flavor];
    if (deployment == null) {
      throw ETHPluginException(
        'Factory deployment not found for the specified flavor and chain ID.',
        details: {'flavor': flavor.name, 'chainId': chainId.toString()},
      );
    }

    return deployment;
  }

  SafeContractDeployment? tryGetSafeFallBackHandlerDeployment(
      {required BigInt chainId,
      SafeContractFlavor flavor = SafeContractFlavor.canonical}) {
    if (fallbackHandler == null) return null;
    return getSafeFallBackHandlerDeployment(chainId: chainId, flavor: flavor);
  }

  SafeContractDeployment getSafeFallBackHandlerDeployment(
      {required BigInt chainId,
      SafeContractFlavor flavor = SafeContractFlavor.canonical}) {
    final fallBackHandler = fallbackHandler;
    if (fallBackHandler == null) {
      throw const ETHPluginException(
          'Fallback handler is not configured for this Safe version.');
    }

    final networkAddress = fallBackHandler.networkAddresses[chainId];
    if (networkAddress == null) {
      throw const ETHPluginException(
          'No fallback handler deployment found for the specified chain ID.');
    }

    if (!networkAddress.contains(flavor)) {
      throw ETHPluginException(
        'The specified flavor is not available for the current fallback handler deployment.',
        details: {'flavor': flavor.name, 'chainId': chainId.toString()},
      );
    }

    final deployment = fallBackHandler.deployments[flavor];
    if (deployment == null) {
      throw ETHPluginException(
        'Deployment not found for the specified fallback handler flavor and chain ID.',
        details: {'flavor': flavor.name, 'chainId': chainId.toString()},
      );
    }

    return deployment;
  }

  ContractABI getSingletonContractAbi(
      {SafeContractLayer layer = SafeContractLayer.l1}) {
    switch (layer) {
      case SafeContractLayer.l1:
        return singleton.abi;
      case SafeContractLayer.l2:
        if (singltonL2 == null) {
          throw const ETHPluginException(
              'L2 proxy is not configured for this Safe version.');
        }
        return singltonL2!.abi;
    }
  }

  @override
  CborTagValue<CborListValue> toCbor() {
    return CborTagValue(
        CborListValue.definite([
          singleton.toCbor(),
          proxy.toCbor(),
          singltonL2?.toCbor() ?? const CborNullValue(),
          fallbackHandler?.toCbor() ?? const CborNullValue()
        ].cast()),
        InternalCborSerializationConst.defaultTag);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "singleton": singleton.toJson(),
      "proxy": proxy.toJson(),
      "singletonL2": singltonL2?.toJson(),
      "handler": fallbackHandler?.toJson(),
    }.notNullValue;
  }
}
