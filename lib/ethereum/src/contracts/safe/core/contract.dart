import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:on_chain/ethereum/src/contracts/safe/types/contracts.dart';
import 'package:on_chain/ethereum/src/contracts/safe/types/events.dart';
import 'package:on_chain/ethereum/src/exception/exception.dart';
import 'package:on_chain/ethereum/src/models/log_entry.dart';
import 'package:on_chain/ethereum/src/rpc/provider/provider.dart';
import 'package:on_chain/ethereum/src/rpc/rpc.dart'
    show EthereumRequestFunctionCall;
import 'package:on_chain/solidity/solidity.dart';

typedef ONPARSECALLREQUEST<T> = T Function(List<dynamic> result);
typedef ONVALIDATEFUNCTION = AbiFunctionFragment Function(AbiFunctionFragment);

abstract mixin class BaseSafeContract {
  abstract final ETHAddress contractAddress;
  abstract final ContractABI contract;
  abstract final SafeContractVersion version;

  AbiFunctionFragment _findFunction({
    required SafeContractFunction functionName,
    List<int>? selector,
  }) {
    final function = contract.functions
        .where((element) => element.name == functionName.functionName);
    if (function.isEmpty) {
      throw ETHPluginException(
          "No matching function found in ABI for ${functionName.functionName}");
    } else if (function.length == 1) {
      return function.first;
    }
    if (selector == null) {
      throw ETHPluginException(
          "Multiple '${functionName.functionName}' functions found in ABI. Provide a selector to disambiguate.");
    }
    selector = selector.sublist(0, ABIConst.selectorLength);
    return function.singleWhere(
        (element) => BytesUtils.bytesEqual(selector, element.selector),
        orElse: () => throw ETHPluginException(
            "No function in the ABI matches '${functionName.functionName}' with selector ${BytesUtils.toHexString(selector!, prefix: "0x")}."));
  }

  AbiFunctionFragment _function(
      {required SafeContractFunction functionName,
      required ONVALIDATEFUNCTION onValidateFunction,
      List<int>? selector}) {
    final function =
        _findFunction(functionName: functionName, selector: selector);
    return onValidateFunction(function);
  }

  SafeContractEncodedCall encodeTransactionCall(
      {required SafeContractFunction functionName,
      List<int>? selector,
      List<Object> params = const [],
      ONVALIDATEFUNCTION? onValidateFunction}) {
    onValidateFunction ??= (f) {
      final stateMutability = f.stateMutability;
      if (stateMutability == null || stateMutability.isExcutable) return f;
      throw ETHPluginException(
          "this function is not executable due to its state mutability");
    };
    final func = _function(
        functionName: functionName,
        selector: selector,
        onValidateFunction: onValidateFunction);
    return SafeContractEncodedCall(func: func, encode: func.encode(params));
  }

  Future<T> queryContract<T extends Object>(
      {ONPARSECALLREQUEST<T>? onResponse,
      required SafeContractFunction functionName,
      required EthereumProvider provider,
      List<int>? selector,
      List<Object> params = const []}) async {
    final func = _function(
      functionName: functionName,
      selector: selector,
      onValidateFunction: (f) {
        final stateMutability = f.stateMutability;
        if (stateMutability == null || !stateMutability.isExcutable) return f;
        throw ETHPluginException(
            "this contract function is executable and cannot be used with queryContract");
      },
    );
    final result = await provider.request(EthereumRequestFunctionCall(
        contractAddress: contractAddress.address,
        function: func,
        params: params));
    onResponse ??= (result) {
      return JsonParser.valueAs<T>(result[0]);
    };
    return onResponse(result);
  }

  List<SafeContractFunction> getMethods() {
    return contract.functions
        .map((e) => SafeContractFunction.fromFunctionNameOrNull(e.name))
        .whereType<SafeContractFunction>()
        .toList();
  }

  List<SafeContractEventType> getEvents() {
    return contract.events
        .map((e) => SafeContractEventType.fromEventNameOrNull(e.name))
        .whereType<SafeContractEventType>()
        .toList();
  }

  List<SafeContractEvent> decodeContractEvents(List<LogEntry> logs) {
    final contractEvents = getEvents();
    List<SafeContractEvent> events = [];
    for (final i in logs) {
      if (i.topics.isEmpty) continue;
      final event = contract.tryEventFromSignature(i.topics.elementAt(0));
      if (event == null) continue;
      final type = SafeContractEventType.fromEventNameOrNull(event.name);
      assert(type != null && contractEvents.contains(type));
      if (type == null) continue;
      events.add(SafeContractEvent.deserialize(
          type: type,
          result: event.decode(BytesUtils.fromHexString(i.data),
              i.topics.map((e) => BytesUtils.fromHexString(e)).toList())));
    }
    return events;
  }
}
