import 'package:on_chain/on_chain.dart';
import 'api_methods.dart';

void main() async {
  final module = await aptosProvider.request(AptosRequestGetAccountModule(
      address: AptosAddress("0x1"), moduleName: "aptos_governance"));
  final function = module.abi.findViewFunction("get_remaining_voting_power");
  final arguments = AptosFunctionEntryArgumentUtils.parseArguments(
      function: function,
      values: [
        "0xba08cec00a8cfa1deff6c9212dda8d198c8fa6ee1992f3ada76d645f99e3402b",
        0
      ]);
  await aptosProvider.request(AptosRequestExecuteViewFunctionOfaModule.bcs(
      entry: AptosTransactionEntryFunction(
          moduleId: AptosModuleId(
              address: AptosAddress("0x1"),
              name: "aptos_governance"), // Governance module
          functionName: "get_remaining_voting_power", // Function to execute
          args: arguments)));
}
