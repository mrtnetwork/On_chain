import 'package:on_chain/solidity/address/core.dart';
import 'package:on_chain/solidity/contract/fragments.dart';
import 'function_encoder.dart';

/// Typed input for `transfer(address,uint256)` / `approve(address,uint256)`.
typedef ERC20AmountInput = ({SolidityAddress to, BigInt value});
typedef ERC20SpenderInput = ({SolidityAddress spender, BigInt value});

/// Typed input for `allowance(address,address)`.
typedef ERC20AllowanceInput = ({
  SolidityAddress owner,
  SolidityAddress spender
});

/// `decimals() -> uint8` (decoded as [BigInt]; call `.toInt()` at the edge).
class ERC20DecimalsEncoder extends SolidityFunctionEncoder<Null, BigInt> {
  const ERC20DecimalsEncoder();
  static final AbiFunctionFragment fragmentDef =
      AbiFunctionFragment.fromJson(const {
    "inputs": [],
    "name": "decimals",
    "outputs": [
      {"internalType": "uint8", "name": "", "type": "uint8"}
    ],
    "stateMutability": "view",
    "type": "function"
  });

  @override
  AbiFunctionFragment get fragment => fragmentDef;
  @override
  List<dynamic> toAbiInput(Null input) => [];
  @override
  Null fromAbiInput(List<dynamic> values) => null;
  @override
  List<dynamic> toAbiOutput(BigInt output) => [output];
  @override
  BigInt fromAbiOutput(List<dynamic> values) =>
      SolidityCodec.asBigInt(values[0]);
}

/// `balanceOf(address) -> uint256`.
class ERC20BalanceOfEncoder
    extends SolidityFunctionEncoder<SolidityAddress, BigInt> {
  const ERC20BalanceOfEncoder();
  static final AbiFunctionFragment fragmentDef =
      AbiFunctionFragment.fromJson(const {
    "inputs": [
      {"internalType": "address", "name": "account", "type": "address"}
    ],
    "name": "balanceOf",
    "outputs": [
      {"internalType": "uint256", "name": "", "type": "uint256"}
    ],
    "stateMutability": "view",
    "type": "function"
  });

  @override
  AbiFunctionFragment get fragment => fragmentDef;
  @override
  List<dynamic> toAbiInput(SolidityAddress input) => [input];
  @override
  SolidityAddress fromAbiInput(List<dynamic> values) =>
      SolidityCodec.asAddress(values[0]);
  @override
  List<dynamic> toAbiOutput(BigInt output) => [output];
  @override
  BigInt fromAbiOutput(List<dynamic> values) =>
      SolidityCodec.asBigInt(values[0]);
}

/// `name() -> string`.
class ERC20NameEncoder extends SolidityFunctionEncoder<Null, String> {
  const ERC20NameEncoder();
  static final AbiFunctionFragment fragmentDef =
      AbiFunctionFragment.fromJson(const {
    "inputs": [],
    "name": "name",
    "outputs": [
      {"internalType": "string", "name": "", "type": "string"}
    ],
    "stateMutability": "view",
    "type": "function"
  });

  @override
  AbiFunctionFragment get fragment => fragmentDef;
  @override
  List<dynamic> toAbiInput(Null input) => [];
  @override
  Null fromAbiInput(List<dynamic> values) => null;
  @override
  List<dynamic> toAbiOutput(String output) => [output];
  @override
  String fromAbiOutput(List<dynamic> values) =>
      SolidityCodec.asString(values[0]);
}

/// `symbol() -> string`.
class ERC20SymbolEncoder extends SolidityFunctionEncoder<Null, String> {
  const ERC20SymbolEncoder();
  static final AbiFunctionFragment fragmentDef =
      AbiFunctionFragment.fromJson(const {
    "inputs": [],
    "name": "symbol",
    "outputs": [
      {"internalType": "string", "name": "", "type": "string"}
    ],
    "stateMutability": "view",
    "type": "function"
  });

  @override
  AbiFunctionFragment get fragment => fragmentDef;
  @override
  List<dynamic> toAbiInput(Null input) => [];
  @override
  Null fromAbiInput(List<dynamic> values) => null;
  @override
  List<dynamic> toAbiOutput(String output) => [output];
  @override
  String fromAbiOutput(List<dynamic> values) =>
      SolidityCodec.asString(values[0]);
}

/// `transfer(address,uint256) -> bool`.
class ERC20TransferEncoder
    extends SolidityFunctionEncoder<ERC20AmountInput, bool> {
  const ERC20TransferEncoder();
  static final AbiFunctionFragment fragmentDef =
      AbiFunctionFragment.fromJson(const {
    "inputs": [
      {"internalType": "address", "name": "to", "type": "address"},
      {"internalType": "uint256", "name": "value", "type": "uint256"}
    ],
    "name": "transfer",
    "outputs": [
      {"internalType": "bool", "name": "", "type": "bool"}
    ],
    "stateMutability": "nonpayable",
    "type": "function"
  });

  @override
  AbiFunctionFragment get fragment => fragmentDef;
  @override
  List<dynamic> toAbiInput(ERC20AmountInput input) =>
      [input.to, input.value];
  @override
  ERC20AmountInput fromAbiInput(List<dynamic> values) => (
        to: SolidityCodec.asAddress(values[0]),
        value: SolidityCodec.asBigInt(values[1])
      );
  @override
  List<dynamic> toAbiOutput(bool output) => [output];
  @override
  bool fromAbiOutput(List<dynamic> values) => SolidityCodec.asBool(values[0]);
}

/// `approve(address,uint256) -> bool`.
class ERC20ApproveEncoder
    extends SolidityFunctionEncoder<ERC20SpenderInput, bool> {
  const ERC20ApproveEncoder();
  static final AbiFunctionFragment fragmentDef =
      AbiFunctionFragment.fromJson(const {
    "inputs": [
      {"internalType": "address", "name": "spender", "type": "address"},
      {"internalType": "uint256", "name": "value", "type": "uint256"}
    ],
    "name": "approve",
    "outputs": [
      {"internalType": "bool", "name": "", "type": "bool"}
    ],
    "stateMutability": "nonpayable",
    "type": "function"
  });

  @override
  AbiFunctionFragment get fragment => fragmentDef;
  @override
  List<dynamic> toAbiInput(ERC20SpenderInput input) =>
      [input.spender, input.value];
  @override
  ERC20SpenderInput fromAbiInput(List<dynamic> values) => (
        spender: SolidityCodec.asAddress(values[0]),
        value: SolidityCodec.asBigInt(values[1])
      );
  @override
  List<dynamic> toAbiOutput(bool output) => [output];
  @override
  bool fromAbiOutput(List<dynamic> values) => SolidityCodec.asBool(values[0]);
}

/// `allowance(address,address) -> uint256`.
class ERC20AllowanceEncoder
    extends SolidityFunctionEncoder<ERC20AllowanceInput, BigInt> {
  const ERC20AllowanceEncoder();
  static final AbiFunctionFragment fragmentDef =
      AbiFunctionFragment.fromJson(const {
    "inputs": [
      {"internalType": "address", "name": "owner", "type": "address"},
      {"internalType": "address", "name": "spender", "type": "address"}
    ],
    "name": "allowance",
    "outputs": [
      {"internalType": "uint256", "name": "", "type": "uint256"}
    ],
    "stateMutability": "view",
    "type": "function"
  });

  @override
  AbiFunctionFragment get fragment => fragmentDef;
  @override
  List<dynamic> toAbiInput(ERC20AllowanceInput input) =>
      [input.owner, input.spender];
  @override
  ERC20AllowanceInput fromAbiInput(List<dynamic> values) => (
        owner: SolidityCodec.asAddress(values[0]),
        spender: SolidityCodec.asAddress(values[1])
      );
  @override
  List<dynamic> toAbiOutput(BigInt output) => [output];
  @override
  BigInt fromAbiOutput(List<dynamic> values) =>
      SolidityCodec.asBigInt(values[0]);
}
