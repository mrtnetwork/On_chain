import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:on_chain/solidity/address/core.dart';

import 'contracts.dart';

class SafeContractEventConst {
  static const List<SafeContractEventType> proxyCreationEventTypes = [
    SafeContractEventType.proxyCreation,
    SafeContractEventType.proxyCreationL2,
    SafeContractEventType.chainSpecificProxyCreationL2
  ];
}

enum SafeContractEventType {
  executionFailed("ExecutionFailed"),
  addedOwner("AddedOwner"),
  removedOwner("RemovedOwner"),
  changedThreshold("ChangedThreshold"),
  enabledModule("EnabledModule"),
  disabledModule("DisabledModule"),
  contractCreation("ContractCreation"),
  approveHash("ApproveHash"),
  changedMasterCopy("ChangedMasterCopy"),
  executionFailure("ExecutionFailure"),
  executionFromModuleFailure("ExecutionFromModuleFailure"),
  executionFromModuleSuccess("ExecutionFromModuleSuccess"),
  executionSuccess("ExecutionSuccess"),
  signMsg("SignMsg"),
  changedFallbackHandler("ChangedFallbackHandler"),
  changedGuard("ChangedGuard"),
  safeReceived("SafeReceived"),
  safeSetup("SafeSetup"),
  safeModuleTransaction("SafeModuleTransaction"),
  safeMultiSigTransaction("SafeMultiSigTransaction"),
  proxyCreation("ProxyCreation"),
  changedModuleGuard("ChangedModuleGuard"),
  chainSpecificProxyCreationL2("ChainSpecificProxyCreationL2"),
  proxyCreationL2("ProxyCreationL2");

  final String eventName;
  const SafeContractEventType(this.eventName);
  static SafeContractEventType fromEventName(String? name) {
    return values.firstWhere((e) => e.eventName == name,
        orElse: () => throw ItemNotFoundException(value: name));
  }

  static SafeContractEventType? fromEventNameOrNull(String? name) {
    return values.firstWhereNullable((e) => e.eventName == name);
  }
}

abstract class SafeContractEvent {
  final SafeContractEventType type;
  const SafeContractEvent(this.type);
  factory SafeContractEvent.deserialize(
      {required SafeContractEventType type, required List<dynamic> result}) {
    switch (type) {
      case SafeContractEventType.executionFailed:
        return SafeContractEventExecutionFailed.fromEvent(result);
      case SafeContractEventType.addedOwner:
        return SafeContractEventAddedOwner.fromEvent(result);
      case SafeContractEventType.removedOwner:
        return SafeContractEventRemovedOwner.fromEvent(result);
      case SafeContractEventType.changedThreshold:
        return SafeContractEventChangedThreshold.fromEvent(result);
      case SafeContractEventType.enabledModule:
        return SafeContractEventEnabledModule.fromEvent(result);
      case SafeContractEventType.disabledModule:
        return SafeContractEventDisabledModule.fromEvent(result);
      case SafeContractEventType.contractCreation:
        return SafeContractEventContractCreation.fromEvent(result);
      case SafeContractEventType.approveHash:
        return SafeContractEventApproveHash.fromEvent(result);
      case SafeContractEventType.changedMasterCopy:
        return SafeContractEventChangedMasterCopy.fromEvent(result);
      case SafeContractEventType.executionFailure:
        return SafeContractEventExecutionFailure.fromEvent(result);
      case SafeContractEventType.executionFromModuleFailure:
        return SafeContractEventExecutionFromModuleFailure.fromEvent(result);
      case SafeContractEventType.executionFromModuleSuccess:
        return SafeContractEventExecutionFromModuleSuccess.fromEvent(result);
      case SafeContractEventType.executionSuccess:
        return SafeContractEventExecutionSuccess.fromEvent(result);
      case SafeContractEventType.signMsg:
        return SafeContractEventSignMsg.fromEvent(result);
      case SafeContractEventType.changedFallbackHandler:
        return SafeContractEventChangedFallbackHandler.fromEvent(result);
      case SafeContractEventType.changedGuard:
        return SafeContractEventChangedGuard.fromEvent(result);
      case SafeContractEventType.safeReceived:
        return SafeContractEventSafeReceived.fromEvent(result);
      case SafeContractEventType.safeSetup:
        return SafeContractEventSafeSetup.fromEvent(result);
      case SafeContractEventType.safeModuleTransaction:
        return SafeContractEventSafeModuleTransaction.fromEvent(result);
      case SafeContractEventType.safeMultiSigTransaction:
        return SafeContractEventSafeMultiSigTransaction.fromEvent(result);
      case SafeContractEventType.proxyCreation:
        return SafeContractEventProxyCreation.fromEvent(result);
      case SafeContractEventType.changedModuleGuard:
        return SafeContractEventChangedModuleGuard.fromEvent(result);
      case SafeContractEventType.chainSpecificProxyCreationL2:
        return SafeContractEventChainSpecificProxyCreationL2.fromEvent(result);
      case SafeContractEventType.proxyCreationL2:
        return SafeContractEventProxyCreationL2.fromEvent(result);
    }
  }

  T cast<T extends SafeContractEvent>() {
    if (this is! T) throw CastFailedException<T>(value: this);
    return this as T;
  }
}

abstract class BaseSafeContractEventProxyCreation extends SafeContractEvent {
  final ETHAddress proxy;
  final ETHAddress? singleton;
  BaseSafeContractEventProxyCreation(
      {required this.proxy,
      required this.singleton,
      required SafeContractEventType type})
      : super(type);
}

class SafeContractEventProxyCreation
    extends BaseSafeContractEventProxyCreation {
  SafeContractEventProxyCreation({required super.proxy, super.singleton})
      : super(type: SafeContractEventType.proxyCreation);

  factory SafeContractEventProxyCreation.fromEvent(List<dynamic> result) {
    return SafeContractEventProxyCreation(
        proxy: JsonParser.valueAs<SolidityAddress>(result.elementAtOrNull(0))
            .toEthereumAddress(),
        singleton: JsonParser.valueTo<ETHAddress?, SolidityAddress>(
            value: result.elementAtOrNull(1),
            parse: (v) => v.toEthereumAddress()));
  }
}

class SafeContractEventApproveHash extends SafeContractEvent {
  final List<int> approvedHash;
  final ETHAddress owner;

  SafeContractEventApproveHash({
    required List<int> approvedHash,
    required this.owner,
  })  : approvedHash = approvedHash.asImmutableBytes,
        super(SafeContractEventType.approveHash);

  factory SafeContractEventApproveHash.fromEvent(List<dynamic> result) {
    return SafeContractEventApproveHash(
        approvedHash: JsonParser.valueAsBytes(result.elementAtOrNull(0)),
        owner: JsonParser.valueAs<SolidityAddress>(result.elementAtOrNull(1))
            .toEthereumAddress());
  }
}

class SafeContractEventAddedOwner extends SafeContractEvent {
  final ETHAddress owner;

  SafeContractEventAddedOwner({required this.owner})
      : super(SafeContractEventType.addedOwner);

  factory SafeContractEventAddedOwner.fromEvent(List<dynamic> result) {
    return SafeContractEventAddedOwner(
        owner: JsonParser.valueAs<SolidityAddress>(
      result.elementAtOrNull(0),
    ).toEthereumAddress());
  }
}

class SafeContractEventChangedMasterCopy extends SafeContractEvent {
  final ETHAddress masterCopy;

  SafeContractEventChangedMasterCopy({required this.masterCopy})
      : super(SafeContractEventType.changedMasterCopy);

  factory SafeContractEventChangedMasterCopy.fromEvent(List<dynamic> result) {
    return SafeContractEventChangedMasterCopy(
        masterCopy: JsonParser.valueAs<SolidityAddress>(
      result.elementAtOrNull(0),
    ).toEthereumAddress());
  }
}

class SafeContractEventDisabledModule extends SafeContractEvent {
  final ETHAddress module;

  SafeContractEventDisabledModule({required this.module})
      : super(SafeContractEventType.disabledModule);

  factory SafeContractEventDisabledModule.fromEvent(List<dynamic> result) {
    return SafeContractEventDisabledModule(
        module: JsonParser.valueAs<SolidityAddress>(result.elementAtOrNull(0))
            .toEthereumAddress());
  }
}

class SafeContractEventEnabledModule extends SafeContractEvent {
  final ETHAddress module;

  SafeContractEventEnabledModule({required this.module})
      : super(SafeContractEventType.enabledModule);

  factory SafeContractEventEnabledModule.fromEvent(List<dynamic> result) {
    return SafeContractEventEnabledModule(
        module: JsonParser.valueAs<SolidityAddress>(result.elementAtOrNull(0))
            .toEthereumAddress());
  }
}

class SafeContractEventExecutionFromModuleFailure extends SafeContractEvent {
  final ETHAddress module;

  SafeContractEventExecutionFromModuleFailure({required this.module})
      : super(SafeContractEventType.executionFromModuleFailure);

  factory SafeContractEventExecutionFromModuleFailure.fromEvent(
      List<dynamic> result) {
    return SafeContractEventExecutionFromModuleFailure(
        module: JsonParser.valueAs<SolidityAddress>(result.elementAtOrNull(0))
            .toEthereumAddress());
  }
}

class SafeContractEventExecutionFromModuleSuccess extends SafeContractEvent {
  final ETHAddress module;

  SafeContractEventExecutionFromModuleSuccess({required this.module})
      : super(SafeContractEventType.executionFromModuleSuccess);

  factory SafeContractEventExecutionFromModuleSuccess.fromEvent(
      List<dynamic> result) {
    return SafeContractEventExecutionFromModuleSuccess(
        module: JsonParser.valueAs<SolidityAddress>(result.elementAtOrNull(0))
            .toEthereumAddress());
  }
}

class SafeContractEventRemovedOwner extends SafeContractEvent {
  final ETHAddress owner;

  SafeContractEventRemovedOwner({required this.owner})
      : super(SafeContractEventType.removedOwner);

  factory SafeContractEventRemovedOwner.fromEvent(List<dynamic> result) {
    return SafeContractEventRemovedOwner(
        owner: JsonParser.valueAs<SolidityAddress>(result.elementAtOrNull(0))
            .toEthereumAddress());
  }
}

class SafeContractEventChangedFallbackHandler extends SafeContractEvent {
  final ETHAddress handler;

  SafeContractEventChangedFallbackHandler({required this.handler})
      : super(SafeContractEventType.changedFallbackHandler);

  factory SafeContractEventChangedFallbackHandler.fromEvent(
      List<dynamic> result) {
    return SafeContractEventChangedFallbackHandler(
        handler: JsonParser.valueAs<SolidityAddress>(result.elementAtOrNull(0))
            .toEthereumAddress());
  }
}

class SafeContractEventChangedGuard extends SafeContractEvent {
  final ETHAddress guard;

  SafeContractEventChangedGuard({required this.guard})
      : super(SafeContractEventType.changedGuard);

  factory SafeContractEventChangedGuard.fromEvent(List<dynamic> result) {
    return SafeContractEventChangedGuard(
        guard: JsonParser.valueAs<SolidityAddress>(result.elementAtOrNull(0))
            .toEthereumAddress());
  }
}

class SafeContractEventChangedModuleGuard extends SafeContractEvent {
  final ETHAddress moduleGuard;

  SafeContractEventChangedModuleGuard({required this.moduleGuard})
      : super(SafeContractEventType.changedModuleGuard);

  factory SafeContractEventChangedModuleGuard.fromEvent(List<dynamic> result) {
    return SafeContractEventChangedModuleGuard(
        moduleGuard:
            JsonParser.valueAs<SolidityAddress>(result.elementAtOrNull(0))
                .toEthereumAddress());
  }
}

class SafeContractEventContractCreation extends SafeContractEvent {
  final ETHAddress moduleGuard;

  SafeContractEventContractCreation({required this.moduleGuard})
      : super(SafeContractEventType.contractCreation);

  factory SafeContractEventContractCreation.fromEvent(List<dynamic> result) {
    return SafeContractEventContractCreation(
        moduleGuard:
            JsonParser.valueAs<SolidityAddress>(result.elementAtOrNull(0))
                .toEthereumAddress());
  }
}

class SafeContractEventChangedThreshold extends SafeContractEvent {
  final BigInt threshold;

  SafeContractEventChangedThreshold({required this.threshold})
      : super(SafeContractEventType.changedThreshold);

  factory SafeContractEventChangedThreshold.fromEvent(List<dynamic> result) {
    return SafeContractEventChangedThreshold(
        threshold: JsonParser.valueAsBigInt(result.elementAtOrNull(0)));
  }
}

class SafeContractEventExecutionFailure extends SafeContractEvent {
  final List<int> txHash;
  final BigInt payment;

  SafeContractEventExecutionFailure({
    required this.payment,
    required List<int> txHash,
  })  : txHash = txHash.asImmutableBytes,
        super(SafeContractEventType.executionFailure);

  factory SafeContractEventExecutionFailure.fromEvent(List<dynamic> result) {
    return SafeContractEventExecutionFailure(
        txHash: JsonParser.valueAsBytes(result.elementAtOrNull(0)),
        payment: JsonParser.valueAsBigInt(result.elementAtOrNull(1)));
  }
}

class SafeContractEventExecutionSuccess extends SafeContractEvent {
  final List<int> txHash;
  final BigInt payment;

  SafeContractEventExecutionSuccess({
    required this.payment,
    required List<int> txHash,
  })  : txHash = txHash.asImmutableBytes,
        super(SafeContractEventType.executionSuccess);

  factory SafeContractEventExecutionSuccess.fromEvent(List<dynamic> result) {
    return SafeContractEventExecutionSuccess(
        txHash: JsonParser.valueAsBytes(result.elementAtOrNull(0)),
        payment: JsonParser.valueAsBigInt(result.elementAtOrNull(1)));
  }
}

class SafeContractEventSignMsg extends SafeContractEvent {
  final List<int> msgHash;

  SafeContractEventSignMsg({
    required List<int> msgHash,
  })  : msgHash = msgHash.asImmutableBytes,
        super(SafeContractEventType.signMsg);

  factory SafeContractEventSignMsg.fromEvent(List<dynamic> result) {
    return SafeContractEventSignMsg(
        msgHash: JsonParser.valueAsBytes(result.elementAtOrNull(0)));
  }
}

class SafeContractEventSafeReceived extends SafeContractEvent {
  final ETHAddress sender;
  final BigInt value;

  SafeContractEventSafeReceived({
    required this.sender,
    required this.value,
  }) : super(SafeContractEventType.safeReceived);

  factory SafeContractEventSafeReceived.fromEvent(List<dynamic> result) {
    return SafeContractEventSafeReceived(
        sender: JsonParser.valueAs<SolidityAddress>(result.elementAtOrNull(0))
            .toEthereumAddress(),
        value: JsonParser.valueAsBigInt(result.elementAtOrNull(1)));
  }
}

class SafeContractEventExecutionFailed extends SafeContractEvent {
  final List<int> txHash;

  SafeContractEventExecutionFailed({
    required List<int> txHash,
  })  : txHash = txHash.asImmutableBytes,
        super(SafeContractEventType.executionFailed);

  factory SafeContractEventExecutionFailed.fromEvent(List<dynamic> result) {
    return SafeContractEventExecutionFailed(
        txHash: JsonParser.valueAsBytes(result.elementAtOrNull(0)));
  }
}

class SafeContractEventSafeModuleTransaction extends SafeContractEvent {
  final ETHAddress module;
  final ETHAddress to;
  final BigInt value;
  final List<int> data;
  final SafeContractExecutionOpration operation;

  SafeContractEventSafeModuleTransaction({
    required this.module,
    required this.to,
    required this.value,
    required List<int> data,
    required this.operation,
  })  : data = data.asImmutableBytes,
        super(SafeContractEventType.safeModuleTransaction);

  factory SafeContractEventSafeModuleTransaction.fromEvent(
      List<dynamic> result) {
    return SafeContractEventSafeModuleTransaction(
      module: JsonParser.valueAs<SolidityAddress>(result.elementAtOrNull(0))
          .toEthereumAddress(),
      to: JsonParser.valueAs<SolidityAddress>(result.elementAtOrNull(1))
          .toEthereumAddress(),
      value: JsonParser.valueAsBigInt(result.elementAtOrNull(2)),
      data: JsonParser.valueAsBytes(result.elementAtOrNull(3)),
      operation: JsonParser.valueTo<SafeContractExecutionOpration, int>(
          value: result.elementAtOrNull(4),
          parse: (e) => SafeContractExecutionOpration.fromValue(e)),
    );
  }
}

class SafeContractEventSafeMultiSigTransaction extends SafeContractEvent {
  final ETHAddress to;
  final BigInt value;
  final List<int> data;
  final SafeContractExecutionOpration operation;
  final BigInt safeTxGas;
  final BigInt baseGas;
  final BigInt gasPrice;
  final ETHAddress gasToken;
  final ETHAddress refundReceiver;
  final List<int> signatures;
  final List<int> additionalInfo;

  SafeContractEventSafeMultiSigTransaction({
    required this.to,
    required this.value,
    required List<int> data,
    required this.operation,
    required this.safeTxGas,
    required this.baseGas,
    required this.gasPrice,
    required this.gasToken,
    required this.refundReceiver,
    required List<int> signatures,
    required List<int> additionalInfo,
  })  : data = data.asImmutableBytes,
        signatures = signatures.asImmutableBytes,
        additionalInfo = additionalInfo.asImmutableBytes,
        super(SafeContractEventType.safeMultiSigTransaction);

  factory SafeContractEventSafeMultiSigTransaction.fromEvent(
      List<dynamic> result) {
    return SafeContractEventSafeMultiSigTransaction(
      to: JsonParser.valueAs<SolidityAddress>(result.elementAtOrNull(0))
          .toEthereumAddress(),
      value: JsonParser.valueAsBigInt(result.elementAtOrNull(1)),
      data: JsonParser.valueAsBytes(result.elementAtOrNull(2)),
      operation: JsonParser.valueTo<SafeContractExecutionOpration, int>(
          value: result.elementAtOrNull(3),
          parse: (e) => SafeContractExecutionOpration.fromValue(e)),
      safeTxGas: JsonParser.valueAsBigInt(result.elementAtOrNull(4)),
      baseGas: JsonParser.valueAsBigInt(result.elementAtOrNull(5)),
      gasPrice: JsonParser.valueAsBigInt(result.elementAtOrNull(6)),
      gasToken: JsonParser.valueAs<SolidityAddress>(result.elementAtOrNull(7))
          .toEthereumAddress(),
      refundReceiver:
          JsonParser.valueAs<SolidityAddress>(result.elementAtOrNull(8))
              .toEthereumAddress(),
      signatures: JsonParser.valueAsBytes(result.elementAtOrNull(9)),
      additionalInfo: JsonParser.valueAsBytes(result.elementAtOrNull(10)),
    );
  }
}

class SafeContractEventSafeSetup extends SafeContractEvent {
  final ETHAddress initiator;
  final List<ETHAddress> owners;
  final BigInt threshold;
  final ETHAddress initializer;
  final ETHAddress fallbackHandler;

  SafeContractEventSafeSetup({
    required this.initiator,
    required List<ETHAddress> owners,
    required this.threshold,
    required this.initializer,
    required this.fallbackHandler,
  })  : owners = owners.immutable,
        super(SafeContractEventType.safeSetup);

  factory SafeContractEventSafeSetup.fromEvent(List<dynamic> result) {
    return SafeContractEventSafeSetup(
      initiator: JsonParser.valueAs<SolidityAddress>(result.elementAtOrNull(0))
          .toEthereumAddress(),
      owners: JsonParser.valueEnsureAsList<SolidityAddress>(1)
          .map((e) => e.toEthereumAddress())
          .toList(),
      threshold: JsonParser.valueAsBigInt(result.elementAtOrNull(2)),
      initializer:
          JsonParser.valueAs<SolidityAddress>(result.elementAtOrNull(3))
              .toEthereumAddress(),
      fallbackHandler:
          JsonParser.valueAs<SolidityAddress>(result.elementAtOrNull(4))
              .toEthereumAddress(),
    );
  }
}

class SafeContractEventChainSpecificProxyCreationL2
    extends BaseSafeContractEventProxyCreation {
  final List<int> initializer;
  final BigInt saltNonce;
  final BigInt chainId;

  SafeContractEventChainSpecificProxyCreationL2({
    required super.proxy,
    required super.singleton,
    required List<int> initializer,
    required this.saltNonce,
    required this.chainId,
  })  : initializer = initializer.asImmutableBytes,
        super(type: SafeContractEventType.chainSpecificProxyCreationL2);

  factory SafeContractEventChainSpecificProxyCreationL2.fromEvent(
      List<dynamic> result) {
    return SafeContractEventChainSpecificProxyCreationL2(
      proxy: JsonParser.valueAs<SolidityAddress>(result.elementAtOrNull(0))
          .toEthereumAddress(),
      singleton: JsonParser.valueAs<SolidityAddress>(
        result.elementAtOrNull(1),
      ).toEthereumAddress(),
      initializer: JsonParser.valueAsBytes(result.elementAtOrNull(2)),
      saltNonce: JsonParser.valueAsBigInt(result.elementAtOrNull(3)),
      chainId: JsonParser.valueAsBigInt(result.elementAtOrNull(4)),
    );
  }
}

class SafeContractEventProxyCreationL2
    extends BaseSafeContractEventProxyCreation {
  final List<int> initializer;
  final BigInt saltNonce;

  SafeContractEventProxyCreationL2({
    required super.proxy,
    required super.singleton,
    required List<int> initializer,
    required this.saltNonce,
  })  : initializer = initializer.asImmutableBytes,
        super(type: SafeContractEventType.proxyCreationL2);

  factory SafeContractEventProxyCreationL2.fromEvent(List<dynamic> result) {
    return SafeContractEventProxyCreationL2(
        proxy: JsonParser.valueAs<SolidityAddress>(result.elementAtOrNull(0))
            .toEthereumAddress(),
        singleton: JsonParser.valueAs<SolidityAddress>(
          result.elementAtOrNull(1),
        ).toEthereumAddress(),
        initializer: JsonParser.valueAsBytes(result.elementAtOrNull(2)),
        saltNonce: JsonParser.valueAsBigInt(result.elementAtOrNull(3)));
  }
}
