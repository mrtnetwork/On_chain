import 'package:on_chain/solidity/address/core.dart';
import 'package:on_chain/solidity/contract/fragments.dart';
import 'function_encoder.dart';

/// Typed inputs for ERC-721 functions.
typedef ERC721TransferFromInput = ({
  SolidityAddress from,
  SolidityAddress to,
  BigInt tokenId
});
typedef ERC721ApproveInput = ({SolidityAddress to, BigInt tokenId});
typedef ERC721TokenOfOwnerByIndexInput = ({
  SolidityAddress owner,
  BigInt index
});

/// Typed input for `isApprovedForAll(address,address)`.
typedef ERC721IsApprovedForAllInput = ({
  SolidityAddress owner,
  SolidityAddress operator
});

/// `ownerOf(uint256) -> address`.
class ERC721OwnerOfEncoder
    extends SolidityFunctionEncoder<BigInt, SolidityAddress> {
  const ERC721OwnerOfEncoder();
  static final AbiFunctionFragment fragmentDef =
      AbiFunctionFragment.fromJson(const {
    "inputs": [
      {"internalType": "uint256", "name": "tokenId", "type": "uint256"}
    ],
    "name": "ownerOf",
    "outputs": [
      {"internalType": "address", "name": "", "type": "address"}
    ],
    "stateMutability": "view",
    "type": "function"
  });

  @override
  AbiFunctionFragment get fragment => fragmentDef;
  @override
  List<dynamic> toAbiInput(BigInt input) => [input];
  @override
  BigInt fromAbiInput(List<dynamic> values) =>
      SolidityCodec.asBigInt(values[0]);
  @override
  List<dynamic> toAbiOutput(SolidityAddress output) => [output];
  @override
  SolidityAddress fromAbiOutput(List<dynamic> values) =>
      SolidityCodec.asAddress(values[0]);
}

/// `transferFrom(address,address,uint256) -> bool`.
class ERC721TransferFromEncoder
    extends SolidityFunctionEncoder<ERC721TransferFromInput, bool> {
  const ERC721TransferFromEncoder();
  static final AbiFunctionFragment fragmentDef =
      AbiFunctionFragment.fromJson(const {
    "inputs": [
      {"internalType": "address", "name": "from", "type": "address"},
      {"internalType": "address", "name": "to", "type": "address"},
      {"internalType": "uint256", "name": "tokenId", "type": "uint256"}
    ],
    "name": "transferFrom",
    "outputs": [
      {"internalType": "bool", "name": "", "type": "bool"}
    ],
    "stateMutability": "nonpayable",
    "type": "function"
  });

  @override
  AbiFunctionFragment get fragment => fragmentDef;
  @override
  List<dynamic> toAbiInput(ERC721TransferFromInput input) =>
      [input.from, input.to, input.tokenId];
  @override
  ERC721TransferFromInput fromAbiInput(List<dynamic> values) => (
        from: SolidityCodec.asAddress(values[0]),
        to: SolidityCodec.asAddress(values[1]),
        tokenId: SolidityCodec.asBigInt(values[2])
      );
  @override
  List<dynamic> toAbiOutput(bool output) => [output];
  @override
  bool fromAbiOutput(List<dynamic> values) => SolidityCodec.asBool(values[0]);
}

/// `approve(address,uint256)` (no outputs).
class ERC721ApproveEncoder
    extends SolidityFunctionEncoder<ERC721ApproveInput, Null> {
  const ERC721ApproveEncoder();
  static final AbiFunctionFragment fragmentDef =
      AbiFunctionFragment.fromJson(const {
    "inputs": [
      {"internalType": "address", "name": "to", "type": "address"},
      {"internalType": "uint256", "name": "tokenId", "type": "uint256"}
    ],
    "name": "approve",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  });

  @override
  AbiFunctionFragment get fragment => fragmentDef;
  @override
  List<dynamic> toAbiInput(ERC721ApproveInput input) =>
      [input.to, input.tokenId];
  @override
  ERC721ApproveInput fromAbiInput(List<dynamic> values) => (
        to: SolidityCodec.asAddress(values[0]),
        tokenId: SolidityCodec.asBigInt(values[1])
      );
  @override
  List<dynamic> toAbiOutput(Null output) => [];
  @override
  Null fromAbiOutput(List<dynamic> values) => null;
}

/// `totalSupply() -> uint256`.
class ERC721TotalSupplyEncoder extends SolidityFunctionEncoder<Null, BigInt> {
  const ERC721TotalSupplyEncoder();
  static final AbiFunctionFragment fragmentDef =
      AbiFunctionFragment.fromJson(const {
    "inputs": [],
    "name": "totalSupply",
    "outputs": [
      {"internalType": "uint256", "name": "", "type": "uint256"}
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

/// `tokenOfOwnerByIndex(address,uint256) -> uint256`.
class ERC721TokenOfOwnerByIndexEncoder extends SolidityFunctionEncoder<
    ERC721TokenOfOwnerByIndexInput, BigInt> {
  const ERC721TokenOfOwnerByIndexEncoder();
  static final AbiFunctionFragment fragmentDef =
      AbiFunctionFragment.fromJson(const {
    "inputs": [
      {"internalType": "address", "name": "owner", "type": "address"},
      {"internalType": "uint256", "name": "index", "type": "uint256"}
    ],
    "name": "tokenOfOwnerByIndex",
    "outputs": [
      {"internalType": "uint256", "name": "", "type": "uint256"}
    ],
    "stateMutability": "view",
    "type": "function"
  });

  @override
  AbiFunctionFragment get fragment => fragmentDef;
  @override
  List<dynamic> toAbiInput(ERC721TokenOfOwnerByIndexInput input) =>
      [input.owner, input.index];
  @override
  ERC721TokenOfOwnerByIndexInput fromAbiInput(List<dynamic> values) => (
        owner: SolidityCodec.asAddress(values[0]),
        index: SolidityCodec.asBigInt(values[1])
      );
  @override
  List<dynamic> toAbiOutput(BigInt output) => [output];
  @override
  BigInt fromAbiOutput(List<dynamic> values) =>
      SolidityCodec.asBigInt(values[0]);
}

/// `tokenURI(uint256) -> string`.
class ERC721TokenUriEncoder extends SolidityFunctionEncoder<BigInt, String> {
  const ERC721TokenUriEncoder();
  static final AbiFunctionFragment fragmentDef =
      AbiFunctionFragment.fromJson(const {
    "inputs": [
      {"internalType": "uint256", "name": "tokenId", "type": "uint256"}
    ],
    "name": "tokenURI",
    "outputs": [
      {"internalType": "string", "name": "", "type": "string"}
    ],
    "stateMutability": "view",
    "type": "function"
  });

  @override
  AbiFunctionFragment get fragment => fragmentDef;
  @override
  List<dynamic> toAbiInput(BigInt input) => [input];
  @override
  BigInt fromAbiInput(List<dynamic> values) =>
      SolidityCodec.asBigInt(values[0]);
  @override
  List<dynamic> toAbiOutput(String output) => [output];
  @override
  String fromAbiOutput(List<dynamic> values) =>
      SolidityCodec.asString(values[0]);
}

/// `isApprovedForAll(address,address) -> bool`.
class ERC721IsApprovedForAllEncoder extends SolidityFunctionEncoder<
    ERC721IsApprovedForAllInput, bool> {
  const ERC721IsApprovedForAllEncoder();
  static final AbiFunctionFragment fragmentDef =
      AbiFunctionFragment.fromJson(const {
    "inputs": [
      {"internalType": "address", "name": "owner", "type": "address"},
      {"internalType": "address", "name": "operator", "type": "address"}
    ],
    "name": "isApprovedForAll",
    "outputs": [
      {"internalType": "bool", "name": "", "type": "bool"}
    ],
    "stateMutability": "view",
    "type": "function"
  });

  @override
  AbiFunctionFragment get fragment => fragmentDef;
  @override
  List<dynamic> toAbiInput(ERC721IsApprovedForAllInput input) =>
      [input.owner, input.operator];
  @override
  ERC721IsApprovedForAllInput fromAbiInput(List<dynamic> values) => (
        owner: SolidityCodec.asAddress(values[0]),
        operator: SolidityCodec.asAddress(values[1])
      );
  @override
  List<dynamic> toAbiOutput(bool output) => [output];
  @override
  bool fromAbiOutput(List<dynamic> values) => SolidityCodec.asBool(values[0]);
}
