import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:on_chain/ethereum/src/contracts/safe/safe.dart';
import 'package:on_chain/ethereum/src/contracts/safe/types/types.dart';
import 'package:on_chain/ethereum/src/exception/exception.dart';
import 'package:on_chain/ethereum/src/keys/signer.dart';
import 'package:on_chain/ethereum/src/rpc/rpc.dart';

import 'package:on_chain/ethereum/src/transaction/transaction.dart';
import 'package:on_chain/solidity/abi/abi.dart';
import 'package:on_chain/solidity/address/core.dart';

class SafeContractController {
  final ONREQUESTETHPROVIDER onRequestProvider;
  final SafeSingletonContract contract;
  final BigInt chainId;
  const SafeContractController(
      {required this.contract,
      required this.onRequestProvider,
      required this.chainId});
  static Future<SafeContractDeployResult> deploy({
    required ONREQUESTETHPROVIDER onRequestProvider,
    required EthereumSigner signer,
    required SafeContractVersionedManifest manifest,
    required ETHAddress from,
    required List<ETHAddress> owners,
    required int threshold,
    SafeCreationMode mode = SafeCreationMode.standard,
    SafeContractLayer layer = SafeContractLayer.l1,
    BigInt? chainId,
    SafeContractFlavor flavor = SafeContractFlavor.canonical,
    ETHAddress? to,
    ETHAddress? factory,
    ETHAddress? singleton,
    ETHAddress? handler,
    List<int>? data,
    BigInt? saletNonce,
    ETHAddress? paymentToken,
    BigInt? payment,
    ETHAddress? paymentReceiver,
    bool disableNonceForCreateProxy = false,
  }) async {
    final provider = await onRequestProvider();
    chainId ??= await provider.request(EthereumRequestGetChainId());
    factory ??= manifest
        .getSafeFactoryDeployment(chainId: chainId!, flavor: flavor)
        .address;
    singleton ??= manifest
        .getSafeSingletonDeployment(
            chainId: chainId!, flavor: flavor, layer: layer)
        .address;
    handler ??= manifest
        .tryGetSafeFallBackHandlerDeployment(chainId: chainId!, flavor: flavor)
        ?.address;
    switch (manifest.version) {
      case SafeContractVersion.v1_0_0:
        if (handler != null) {
          throw ETHPluginException(
              "Fallback handler is not supported in version ${manifest.version.version}.");
        }
        break;
      default:
        break;
    }
    final singletonAbi = manifest.getSingletonContractAbi(layer: layer);
    final signletonContract = SafeSingletonContract(
        contract: singletonAbi,
        contractAddress: singleton,
        version: manifest.version);
    final factoryContract = SafeFactoryContract(
        contract: manifest.proxy.abi,
        contractAddress: factory,
        version: manifest.proxy.version);
    final setupData = await signletonContract.setup(
        owners: owners,
        threshold: BigInt.from(threshold),
        to: to,
        data: data,
        fallbackHandler: handler,
        paymentToken: paymentToken,
        payment: payment,
        paymentReceiver: paymentReceiver);
    final factoryCreationionData =
        await factoryContract.resolveContractCreationMethod(
            singleton: singleton,
            initializer: setupData.encode,
            disableNonceForCreateProxy: disableNonceForCreateProxy,
            layer: layer,
            mode: mode,
            saltNonce: saletNonce);
    final tx = ETHTransactionBuilder(
        from: from,
        data: factoryCreationionData.encode,
        to: factoryContract.contractAddress,
        value: BigInt.zero,
        chainId: chainId!);
    await tx.autoFill(provider);
    await tx.signAsync(signer);
    // throw Exception();
    final receipt = await tx.submitAndWatchTransactionAsync(provider);
    List<SafeContractEvent> events = [];
    for (final i in receipt.logs) {
      if (i.topics.isEmpty) continue;
      final event =
          factoryContract.contract.tryEventFromSignature(i.topics.elementAt(0));
      if (event == null) continue;
      final type = SafeContractEventType.fromEventName(event.name);
      events.add(SafeContractEvent.deserialize(
          type: type,
          result: event.decode(BytesUtils.fromHexString(i.data),
              i.topics.map((e) => BytesUtils.fromHexString(e)).toList())));
    }
    final creationEvent = events
        .firstWhere(
            (e) =>
                SafeContractEventConst.proxyCreationEventTypes.contains(e.type),
            orElse: () => throw ETHPluginException(
                'No proxy creation event found in the transaction events.'))
        .cast<BaseSafeContractEventProxyCreation>();

    // final events = receipt.from.m
    return SafeContractDeployResult(
      controller: SafeContractController(
          chainId: chainId,
          contract: SafeSingletonContract(
              version: manifest.version,
              contract: signletonContract.contract,
              contractAddress: creationEvent.proxy),
          onRequestProvider: onRequestProvider),
      events: events,
      creationEvent: creationEvent,
    );
  }

  static Future<SafeContractController> fromAddress(
      {required ONREQUESTETHPROVIDER onRequestProvider,
      required SafeContractAssets assets,
      required ETHAddress address,
      BigInt? chainId}) async {
    final provider = await onRequestProvider();
    chainId ??= await provider.request(EthereumRequestGetChainId());
    Future<SafeContractController> getController() async {
      final firstSlot = await provider.request(EthereumRequestGetStorageAt(
          address: address.address, storageSlot: "0x00"));
      final singletonProxy = ABIUtils.decodeSingle<SolidityAddress>(
              type: "address", bytes: BytesUtils.fromHexString(firstSlot))
          .toEthereumAddress();
      if (singletonProxy != ETHAddress.zero) {
        final manifest = assets.fromSingletonAddress(singletonProxy);
        return SafeContractController(
            contract: SafeSingletonContract(
                contract: manifest
                    .getSafeSingletonManifestFromAddress(singletonProxy)
                    .abi,
                contractAddress: address,
                version: manifest.version),
            onRequestProvider: onRequestProvider,
            chainId: chainId!);
      }
      final chainIds = assets.getSupportedChainIds();
      if (!chainIds.contains(chainId)) {
        throw ETHPluginException(
            "The provided chainId is not supported by Safe assets.",
            details: {"chainId": chainId.toString()});
      }
      final manifest = assets.getLatestDeployment();
      final contract = SafeSingletonContract(
          contract: manifest.getSingletonContractAbi(),
          contractAddress: address,
          version: manifest.version);
      try {
        final storage = await contract.getStorageAt(
            provider: provider, offset: 0, length: 1);
        final singletonProxy = ABIUtils.decodeSingle<SolidityAddress>(
                type: "address", bytes: storage)
            .toEthereumAddress();
        if (singletonProxy != ETHAddress.zero) {
          final manifest = assets.fromSingletonAddress(singletonProxy);
          return SafeContractController(
              contract: SafeSingletonContract(
                  contract: manifest
                      .getSafeSingletonManifestFromAddress(singletonProxy)
                      .abi,
                  contractAddress: address,
                  version: manifest.version),
              onRequestProvider: onRequestProvider,
              chainId: chainId!);
        }
      } on RPCError catch (_) {}
      throw ETHPluginException(
          "Unable to locate the ABI for the specified Safe Singleton address.",
          details: {"address": address.address});
    }

    final controller = await getController();
    final version = SafeContractVersion.fromVersion(
        await controller.contract.getVersion(provider));
    if (version == controller.contract.version) {
      return controller;
    }
    throw ETHPluginException(
        "Failed to verify the singleton contract address.");
  }

  Future<SafeSignature> signHash(
      {required ETHAddress address,
      required EthereumSigner signer,
      required List<int> hash,
      SafeTransactionSigningMode? signingMode}) async {
    signingMode ??= switch (contract.version) {
      SafeContractVersion.v1_0_0 => SafeTransactionSigningMode.ethSign,
      _ => SafeTransactionSigningMode.signMessage
    };
    switch (signingMode) {
      case SafeTransactionSigningMode.ethSign:
        final signature = await signer.signAsync(hash, hashMessage: false);
        return SafeSignature(address: address, signature: signature.toBytes());
      case SafeTransactionSigningMode.signMessage:
        final signature = await signer.signPersonalMessageAsync(hash);
        assert(signature.length ==
            CryptoSignerConst.ecdsaSignatureLength +
                CryptoSignerConst.ecdsaRecoveryIdLength);
        final signatureBytes =
            signature.sublist(0, CryptoSignerConst.ecdsaSignatureLength);
        int v = ETHSignatureUtils.getSignatureV(signature.last);
        return SafeSignature(
            address: address, signature: [...signatureBytes, v + 4]);
      case SafeTransactionSigningMode.approveHash:
        final signature = List<int>.filled(
            CryptoSignerConst.ecdsaSignatureLength +
                CryptoSignerConst.ecdsaRecoveryIdLength,
            0);
        signature.setAll(
            0, ABIUtils.encode(types: ["address"], params: [address]));
        signature.last = 1;
        return SafeSignature(address: address, signature: signature);
    }
  }

  Future<SafeSignature> safeSignMessage(
      {required ETHAddress address,
      required EthereumSigner signer,
      required SafeTransaction safeTx,
      SafeTransactionSigningMode? signingMode}) {
    return signHash(
        address: address,
        signer: signer,
        signingMode: signingMode,
        hash: safeTx.calculateSafeTransactionHash(
            chainId: chainId,
            safeAddress: contract.contractAddress,
            version: contract.version));
  }

  Map<String, dynamic> toTypeDataMessage(SafeTransaction safeTx) {
    final typedData = SafeContractUtils.safeTransactionTypedData(
        chainId: chainId,
        safeAddress: contract.contractAddress,
        safeTransaction: safeTx);
    return typedData.toJson();
  }

  Future<String> excute(
      {required SafeTransaction safeTx,
      required ETHAddress excuter,
      required EthereumSigner excuterSigner,
      required List<SafeSignature> signatures,
      ETHTransactionParams? params}) async {
    final provider = await onRequestProvider();
    final sort = signatures.clone()
      ..sort((a, b) => a.address.address
          .toLowerCase()
          .compareTo(b.address.address.toLowerCase()));
    final transaction = ETHTransactionBuilder(
        from: excuter,
        to: contract.contractAddress,
        value: BigInt.zero,
        data: (await contract.execTransaction(
                to: safeTx.to,
                baseGas: safeTx.gasParams.baseGas,
                data: safeTx.data,
                gasPrice: safeTx.gasParams.gasPrice,
                gasToken: safeTx.gasParams.gasToken,
                operation: safeTx.operation,
                refundReceiver: safeTx.gasParams.refundReceiver,
                safeTxGas: safeTx.gasParams.safeTxGas,
                value: safeTx.value,
                signatures: sort.expand((e) => e.signature).toList()))
            .encode,
        chainId: chainId);
    if (params != null) transaction.updateTxPrams(params);
    await transaction.autoFill(provider);
    await transaction.signAsync(excuterSigner);
    return transaction.submitTransaction(provider);
  }

  Future<ETHTransactionBuilder> buildSafeTransactionBuilder(
      {required SafeTransaction safeTx,
      required ETHAddress excuter,
      required EthereumSigner excuterSigner,
      required List<SafeSignature> signatures,
      ETHTransactionParams? params}) async {
    final sort = signatures.clone()
      ..sort((a, b) => a.address.address
          .toLowerCase()
          .compareTo(b.address.address.toLowerCase()));
    return ETHTransactionBuilder(
        from: excuter,
        to: contract.contractAddress,
        value: BigInt.zero,
        data: (await contract.execTransaction(
                to: safeTx.to,
                baseGas: safeTx.gasParams.baseGas,
                data: safeTx.data,
                gasPrice: safeTx.gasParams.gasPrice,
                gasToken: safeTx.gasParams.gasToken,
                operation: safeTx.operation,
                refundReceiver: safeTx.gasParams.refundReceiver,
                safeTxGas: safeTx.gasParams.safeTxGas,
                value: safeTx.value,
                signatures: sort.expand((e) => e.signature).toList()))
            .encode,
        chainId: chainId);
  }

  Future<Stream<SafeContractExecutionResult>> excuteAndWatchStream(
      {required SafeTransaction safeTx,
      required ETHAddress excuter,
      required EthereumSigner excuterSigner,
      required List<SafeSignature> signatures,
      ETHTransactionParams? params,
      Duration timeout = const Duration(minutes: 5),
      Duration blockInternal = const Duration(seconds: 10)}) async {
    final txId = await excute(
        safeTx: safeTx,
        excuter: excuter,
        excuterSigner: excuterSigner,
        signatures: signatures,
        params: params);
    final provider = await onRequestProvider();
    final receipt =
        await ETHTransactionBuilderUtils.watchTransactionReceiptStream(
            rpc: provider,
            txId: txId,
            blockInternal: blockInternal,
            timeout: timeout);
    return receipt.map((e) => SafeContractExecutionResult(
        receipt: e, events: contract.decodeContractEvents(e.logs)));
  }

  Future<SafeContractExecutionResult> excuteAndWatchAsync(
      {required SafeTransaction safeTx,
      required ETHAddress excuter,
      required EthereumSigner excuterSigner,
      required List<SafeSignature> signatures,
      ETHTransactionParams? params,
      Duration timeout = const Duration(minutes: 5),
      Duration blockInternal = const Duration(seconds: 10)}) async {
    final txId = await excute(
        safeTx: safeTx,
        excuter: excuter,
        excuterSigner: excuterSigner,
        signatures: signatures,
        params: params);
    final provider = await onRequestProvider();
    final receipt =
        await ETHTransactionBuilderUtils.watchTransactionReceiptAsync(
            rpc: provider,
            txId: txId,
            blockInternal: blockInternal,
            timeout: timeout);
    return SafeContractExecutionResult(
        receipt: receipt, events: contract.decodeContractEvents(receipt.logs));
  }

  Future<List<int>> buildSingletonContractCall(
      {required SafeContractFunction method,
      List<Object> params = const []}) async {
    return contract
        .encodeTransactionCall(functionName: method, params: params)
        .encode;
  }
}
