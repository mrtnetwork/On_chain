import 'package:on_chain/ethereum/src/contracts/safe/types/types.dart';
import 'package:on_chain/on_chain.dart';

import '../types/contracts.dart';
import 'contract.dart';

abstract class ISafeFactoryContract with BaseSafeContract {
  @override
  final ETHAddress contractAddress;
  @override
  final ContractABI contract;
  const ISafeFactoryContract(
      {required this.contract, required this.contractAddress});

  /// Retrieve the {SafeProxy} creation code.
  Future<List<int>> proxyCreationCode(EthereumProvider provider);

  Future<List<int>> proxyRuntimeCode(EthereumProvider provider);

  /// Returns the ID of the chain the contract is currently deployed on.
  Future<BigInt> getChainId(EthereumProvider provider);

  Future<SafeContractEncodedCall> createProxy(
      {required ETHAddress masterCopy, required List<int> data});

  /// Deploys a new chain-specific proxy with [singleton] singleton and [saltNonce] salt.
  /// Optionally executes an [initializer] call to a new proxy.
  Future<SafeContractEncodedCall> createChainSpecificProxyWithNonce(
      {required ETHAddress singleton,
      required List<int> initializer,
      required BigInt saltNonce});

  /// Deploys a new chain-specific proxy with [singleton] singleton and [saltNonce] salt.
  /// Optionally executes an [initializer] call to a new proxy.
  Future<SafeContractEncodedCall> createChainSpecificProxyWithNonceL2(
      {required ETHAddress singleton,
      required List<int> initializer,
      required BigInt saltNonce});

  /// Deploys a new proxy with [singleton] singleton and [saltNonce] salt.
  /// Optionally executes an [initializer] call to a new proxy.
  Future<SafeContractEncodedCall> createProxyWithNonce(
      {required ETHAddress singleton,
      required List<int> initializer,
      required BigInt saltNonce});

  /// Deploys a new proxy with [singleton] singleton and [saltNonce] salt.
  /// Optionally executes an [initializer] call to a new proxy.
  Future<SafeContractEncodedCall> createProxyWithNonceL2(
      {required ETHAddress singleton,
      required List<int> initializer,
      required BigInt saltNonce});
  Future<SafeContractEncodedCall> createProxyWithCallback(
      {required ETHAddress singleton,
      required List<int> initializer,
      required BigInt saltNonce,
      required ETHAddress callback});

  Future<SafeContractEncodedCall> calculateCreateProxyWithNonceAddress(
      {required ETHAddress singleton,
      required List<int> initializer,
      required BigInt saltNonce});

  Future<SafeContractEncodedCall> resolveContractCreationMethod({
    required ETHAddress singleton,
    required List<int> initializer,
    BigInt? saltNonce,
    SafeCreationMode mode = SafeCreationMode.standard,
    SafeContractLayer layer = SafeContractLayer.l1,
    bool disableNonceForCreateProxy = false,
  });
}
