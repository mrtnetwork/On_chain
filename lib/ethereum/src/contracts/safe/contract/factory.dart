import 'package:blockchain_utils/crypto/quick_crypto.dart';
import 'package:blockchain_utils/utils/binary/binary_operation.dart';
import 'package:blockchain_utils/utils/numbers/utils/bigint_utils.dart';
import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:on_chain/ethereum/src/contracts/safe/core/factory.dart';
import 'package:on_chain/ethereum/src/contracts/safe/types/contracts.dart';
import 'package:on_chain/ethereum/src/contracts/safe/types/types.dart';
import 'package:on_chain/ethereum/src/exception/exception.dart';
import 'package:on_chain/ethereum/src/rpc/provider/provider.dart';

class SafeFactoryContract extends ISafeFactoryContract {
  @override
  final SafeContractVersion version;
  SafeFactoryContract(
      {required super.contract,
      required super.contractAddress,
      required this.version});

  /// Retrieve the {SafeProxy} creation code.
  @override
  Future<List<int>> proxyCreationCode(EthereumProvider provider) async {
    return queryContract<List<int>>(
        functionName: SafeContractFunction.proxyCreationCode,
        provider: provider);
  }

  @override
  Future<List<int>> proxyRuntimeCode(EthereumProvider provider) async {
    return queryContract<List<int>>(
        functionName: SafeContractFunction.proxyRuntimeCode,
        provider: provider);
  }

  /// Returns the ID of the chain the contract is currently deployed on.
  @override
  Future<BigInt> getChainId(EthereumProvider provider) async {
    return queryContract<BigInt>(
        functionName: SafeContractFunction.getChainId, provider: provider);
  }

  /// Allows creating a new proxy contract and executing a message call to the new proxy within one transaction.
  ///
  /// [ masterCopy ] Address of the master copy.
  /// [ data ] Payload for the message call sent to the new proxy contract.
  @override
  Future<SafeContractEncodedCall> createProxy(
      {required ETHAddress masterCopy, required List<int> data}) async {
    final params = [masterCopy, data];
    return encodeTransactionCall(
        functionName: SafeContractFunction.createProxy, params: params);
  }

  /// Deploys a new chain-specific proxy with [singleton] singleton and [saltNonce] salt.
  /// Optionally executes an [initializer] call to a new proxy.
  @override
  Future<SafeContractEncodedCall> createChainSpecificProxyWithNonce(
      {required ETHAddress singleton,
      required List<int> initializer,
      required BigInt saltNonce}) async {
    final params = [singleton, initializer, saltNonce];
    return encodeTransactionCall(
        functionName: SafeContractFunction.createChainSpecificProxyWithNonce,
        params: params);
  }

  /// Deploys a new chain-specific proxy with [singleton] singleton and [saltNonce] salt.
  /// Optionally executes an [initializer] call to a new proxy.
  @override
  Future<SafeContractEncodedCall> createChainSpecificProxyWithNonceL2(
      {required ETHAddress singleton,
      required List<int> initializer,
      required BigInt saltNonce}) async {
    final params = [singleton, initializer, saltNonce];
    return encodeTransactionCall(
        functionName: SafeContractFunction.createChainSpecificProxyWithNonceL2,
        params: params);
  }

  /// Deploys a new proxy with [singleton] singleton and [saltNonce] salt.
  /// Optionally executes an [initializer] call to a new proxy.
  @override
  Future<SafeContractEncodedCall> createProxyWithNonce(
      {required ETHAddress singleton,
      required List<int> initializer,
      required BigInt saltNonce}) async {
    final params = [singleton, initializer, saltNonce];
    return encodeTransactionCall(
        functionName: SafeContractFunction.createProxyWithNonce,
        params: params);
  }

  /// Deploys a new proxy with [singleton] singleton and [saltNonce] salt.
  /// Optionally executes an [initializer] call to a new proxy.
  @override
  Future<SafeContractEncodedCall> createProxyWithNonceL2(
      {required ETHAddress singleton,
      required List<int> initializer,
      required BigInt saltNonce}) async {
    final params = [singleton, initializer, saltNonce];
    return encodeTransactionCall(
        functionName: SafeContractFunction.createProxyWithNonceL2,
        params: params);
  }

  /// Allows to create a new proxy contract, execute a message call to the new proxy,
  /// and call a specified callback within one transaction.
  ///
  /// [singleton] Address of the master copy.
  /// [initializer] Payload for the message call sent to the new proxy contract.
  /// [saltNonce] Nonce that will be used to generate the salt to calculate the address
  ///        of the new proxy contract.
  /// [callback] Callback that will be invoked after the new proxy contract has been
  ///        successfully deployed and initialized.
  @override
  Future<SafeContractEncodedCall> createProxyWithCallback(
      {required ETHAddress singleton,
      required List<int> initializer,
      required BigInt saltNonce,
      required ETHAddress callback}) async {
    final params = [singleton, initializer, saltNonce, callback];
    return encodeTransactionCall(
        functionName: SafeContractFunction.createProxyWithCallback,
        params: params);
  }

  /// Allows getting the address for a new proxy contract created via `createProxyWithNonce`.
  /// This method is only meant for address calculation purposes when you use an initializer that would revert.
  /// Therefore, the response is returned with a revert. When calling this method, set `from` to the address of the proxy factory.
  ///
  /// [ singleton ] Address of the master copy.
  /// [ initializer ] Payload for the message call sent to the new proxy contract.
  /// [ saltNonce ] Nonce that will be used to generate the salt to calculate the address of the new proxy contract.
  @override
  Future<SafeContractEncodedCall> calculateCreateProxyWithNonceAddress(
      {required ETHAddress singleton,
      required List<int> initializer,
      required BigInt saltNonce}) async {
    final params = [singleton, initializer, saltNonce];
    return encodeTransactionCall(
        functionName: SafeContractFunction.calculateCreateProxyWithNonceAddress,
        params: params);
  }

  @override
  Future<SafeContractEncodedCall> resolveContractCreationMethod({
    required ETHAddress singleton,
    required List<int> initializer,
    BigInt? saltNonce,
    SafeCreationMode mode = SafeCreationMode.standard,
    SafeContractLayer layer = SafeContractLayer.l1,
    bool disableNonceForCreateProxy = false,
  }) async {
    final methods = getMethods();
    SafeContractFunction? method;
    if (version < SafeContractVersion.v1_4_1 && layer == SafeContractLayer.l2) {
      throw ETHPluginException(
          "This Safe contract version (${version.version}) does not support L2 with explicit layer selection.",
          details: {
            "layer": layer.name,
            "mode": mode.name,
            "disableNonceForCreateProxy": disableNonceForCreateProxy
          });
    }
    bool isL2 = layer == SafeContractLayer.l2;
    switch (mode) {
      case SafeCreationMode.standard:
        if (isL2 && disableNonceForCreateProxy) break;
        if (isL2 &&
            methods.contains(SafeContractFunction.createProxyWithNonceL2)) {
          method = SafeContractFunction.createProxyWithNonceL2;
        } else if (methods
                .contains(SafeContractFunction.createProxyWithNonce) &&
            !disableNonceForCreateProxy) {
          method = SafeContractFunction.createProxyWithNonce;
        } else if (methods.contains(SafeContractFunction.createProxy)) {
          method = SafeContractFunction.createProxy;
        }
      case SafeCreationMode.chainSpecific:
        if (disableNonceForCreateProxy) break;
        if (isL2 &&
            methods.contains(
                SafeContractFunction.createChainSpecificProxyWithNonceL2)) {
          method = SafeContractFunction.createChainSpecificProxyWithNonceL2;
        } else if (methods
            .contains(SafeContractFunction.createChainSpecificProxyWithNonce)) {
          method = SafeContractFunction.createChainSpecificProxyWithNonce;
        }
    }

    if (method == null) {
      throw ETHPluginException(
          "Failed to find a valid contract creation method for the provided configuration",
          details: {
            "layer": layer.name,
            "mode": mode.name,
            "disableNonceForCreateProxy": disableNonceForCreateProxy
          });
    }
    if (method != SafeContractFunction.createProxy) {
      saltNonce ??=
          BigintUtils.fromBytes(QuickCrypto.generateRandom()) & maxU256;
    } else {
      saltNonce = null;
    }
    return encodeTransactionCall(
        functionName: method,
        params: [singleton, initializer, if (saltNonce != null) saltNonce]);
  }
}
