import 'package:on_chain/solidity/contract/fragments.dart';
import 'function_encoder.dart';

/// `supportsInterface(bytes4) -> bool` (ERC-165).
class SupportsInterfaceEncoder
    extends SolidityFunctionEncoder<List<int>, bool> {
  const SupportsInterfaceEncoder();
  static final AbiFunctionFragment fragmentDef =
      AbiFunctionFragment.fromJson(const {
    "inputs": [
      {"internalType": "bytes4", "name": "interfaceId", "type": "bytes4"}
    ],
    "name": "supportsInterface",
    "outputs": [
      {"internalType": "bool", "name": "", "type": "bool"}
    ],
    "stateMutability": "view",
    "type": "function"
  });

  @override
  AbiFunctionFragment get fragment => fragmentDef;
  @override
  List<dynamic> toAbiInput(List<int> input) => [input];
  @override
  List<int> fromAbiInput(List<dynamic> values) =>
      SolidityCodec.asBytes(values[0]);
  @override
  List<dynamic> toAbiOutput(bool output) => [output];
  @override
  bool fromAbiOutput(List<dynamic> values) => SolidityCodec.asBool(values[0]);
}
