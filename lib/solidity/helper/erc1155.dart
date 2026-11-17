import 'package:on_chain/solidity/address/core.dart';
import 'package:on_chain/solidity/contract/fragments.dart';
import 'function_encoder.dart';

/// Typed inputs for ERC-1155 functions.
typedef ERC1155SafeTransferFromInput =
    ({
      SolidityAddress from,
      SolidityAddress to,
      BigInt id,
      BigInt value,
      List<int> data,
    });
typedef ERC1155SetApprovalForAllInput =
    ({SolidityAddress operator, bool approved});
typedef ERC1155BalanceOfInput = ({SolidityAddress account, BigInt id});

/// `safeTransferFrom(address,address,uint256,uint256,bytes)` (no outputs).
class ERC1155SafeTransferFromEncoder
    extends SolidityFunctionEncoder<ERC1155SafeTransferFromInput, Null> {
  const ERC1155SafeTransferFromEncoder();
  static final AbiFunctionFragment fragmentDef = AbiFunctionFragment.fromJson(
    const {
      "inputs": [
        {"internalType": "address", "name": "from", "type": "address"},
        {"internalType": "address", "name": "to", "type": "address"},
        {"internalType": "uint256", "name": "id", "type": "uint256"},
        {"internalType": "uint256", "name": "value", "type": "uint256"},
        {"internalType": "bytes", "name": "data", "type": "bytes"},
      ],
      "name": "safeTransferFrom",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function",
    },
  );

  @override
  AbiFunctionFragment get fragment => fragmentDef;
  @override
  List<dynamic> toAbiInput(ERC1155SafeTransferFromInput input) => [
    input.from,
    input.to,
    input.id,
    input.value,
    input.data,
  ];
  @override
  ERC1155SafeTransferFromInput fromAbiInput(List<dynamic> values) => (
    from: SolidityCodec.asAddress(values[0]),
    to: SolidityCodec.asAddress(values[1]),
    id: SolidityCodec.asBigInt(values[2]),
    value: SolidityCodec.asBigInt(values[3]),
    data: SolidityCodec.asBytes(values[4]),
  );
  @override
  List<dynamic> toAbiOutput(Null output) => [];
  @override
  Null fromAbiOutput(List<dynamic> values) => null;
}

/// `setApprovalForAll(address,bool)` (no outputs).
class ERC1155SetApprovalForAllEncoder
    extends SolidityFunctionEncoder<ERC1155SetApprovalForAllInput, Null> {
  const ERC1155SetApprovalForAllEncoder();
  static final AbiFunctionFragment fragmentDef = AbiFunctionFragment.fromJson(
    const {
      "inputs": [
        {"internalType": "address", "name": "operator", "type": "address"},
        {"internalType": "bool", "name": "approved", "type": "bool"},
      ],
      "name": "setApprovalForAll",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function",
    },
  );

  @override
  AbiFunctionFragment get fragment => fragmentDef;
  @override
  List<dynamic> toAbiInput(ERC1155SetApprovalForAllInput input) => [
    input.operator,
    input.approved,
  ];
  @override
  ERC1155SetApprovalForAllInput fromAbiInput(List<dynamic> values) => (
    operator: SolidityCodec.asAddress(values[0]),
    approved: SolidityCodec.asBool(values[1]),
  );
  @override
  List<dynamic> toAbiOutput(Null output) => [];
  @override
  Null fromAbiOutput(List<dynamic> values) => null;
}

/// `balanceOf(address,uint256) -> uint256`.
class ERC1155BalanceOfEncoder
    extends SolidityFunctionEncoder<ERC1155BalanceOfInput, BigInt> {
  const ERC1155BalanceOfEncoder();
  static final AbiFunctionFragment fragmentDef = AbiFunctionFragment.fromJson(
    const {
      "inputs": [
        {"internalType": "address", "name": "account", "type": "address"},
        {"internalType": "uint256", "name": "id", "type": "uint256"},
      ],
      "name": "balanceOf",
      "outputs": [
        {"internalType": "uint256", "name": "", "type": "uint256"},
      ],
      "stateMutability": "view",
      "type": "function",
    },
  );

  @override
  AbiFunctionFragment get fragment => fragmentDef;
  @override
  List<dynamic> toAbiInput(ERC1155BalanceOfInput input) => [
    input.account,
    input.id,
  ];
  @override
  ERC1155BalanceOfInput fromAbiInput(List<dynamic> values) => (
    account: SolidityCodec.asAddress(values[0]),
    id: SolidityCodec.asBigInt(values[1]),
  );
  @override
  List<dynamic> toAbiOutput(BigInt output) => [output];
  @override
  BigInt fromAbiOutput(List<dynamic> values) =>
      SolidityCodec.asBigInt(values[0]);
}

/// `uri(uint256) -> string`.
class ERC1155UriEncoder extends SolidityFunctionEncoder<BigInt, String> {
  const ERC1155UriEncoder();
  static final AbiFunctionFragment fragmentDef = AbiFunctionFragment.fromJson(
    const {
      "inputs": [
        {"internalType": "uint256", "name": "id", "type": "uint256"},
      ],
      "name": "uri",
      "outputs": [
        {"internalType": "string", "name": "", "type": "string"},
      ],
      "stateMutability": "view",
      "type": "function",
    },
  );

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

/// Decoded `TransferSingle(address,address,address,uint256,uint256)`.
class ERC1155TransferSingleEvent {
  final SolidityAddress operator;
  final SolidityAddress from;
  final SolidityAddress to;
  final BigInt id;
  final BigInt value;
  const ERC1155TransferSingleEvent({
    required this.operator,
    required this.from,
    required this.to,
    required this.id,
    required this.value,
  });
}

/// Decoder for `TransferSingle`.
class ERC1155TransferSingleDecoder
    extends SolidityEventDecoder<ERC1155TransferSingleEvent> {
  const ERC1155TransferSingleDecoder();
  static final AbiEventFragment fragmentDef = AbiEventFragment.fromJson(const {
    "name": "TransferSingle",
    "inputs": [
      {
        "internalType": "address",
        "name": "operator",
        "type": "address",
        "indexed": true,
      },
      {
        "internalType": "address",
        "name": "from",
        "type": "address",
        "indexed": true,
      },
      {
        "internalType": "address",
        "name": "to",
        "type": "address",
        "indexed": true,
      },
      {
        "internalType": "uint256",
        "name": "id",
        "type": "uint256",
        "indexed": false,
      },
      {
        "internalType": "uint256",
        "name": "value",
        "type": "uint256",
        "indexed": false,
      },
    ],
    "type": "event",
  });

  @override
  AbiEventFragment get fragment => fragmentDef;
  @override
  ERC1155TransferSingleEvent fromDecodedValues(List<dynamic> values) {
    return ERC1155TransferSingleEvent(
      operator: SolidityCodec.asAddress(values[0]),
      from: SolidityCodec.asAddress(values[1]),
      to: SolidityCodec.asAddress(values[2]),
      id: SolidityCodec.asBigInt(values[3]),
      value: SolidityCodec.asBigInt(values[4]),
    );
  }
}

/// Decoded `TransferBatch(address,address,address,uint256[],uint256[])`.
class ERC1155TransferBatchEvent {
  final SolidityAddress operator;
  final SolidityAddress from;
  final SolidityAddress to;
  final List<BigInt> ids;
  final List<BigInt> values;
  const ERC1155TransferBatchEvent({
    required this.operator,
    required this.from,
    required this.to,
    required this.ids,
    required this.values,
  });
}

/// Decoder for `TransferBatch`.
class ERC1155TransferBatchDecoder
    extends SolidityEventDecoder<ERC1155TransferBatchEvent> {
  const ERC1155TransferBatchDecoder();
  static final AbiEventFragment fragmentDef = AbiEventFragment.fromJson(const {
    "name": "TransferBatch",
    "inputs": [
      {
        "internalType": "address",
        "name": "operator",
        "type": "address",
        "indexed": true,
      },
      {
        "internalType": "address",
        "name": "from",
        "type": "address",
        "indexed": true,
      },
      {
        "internalType": "address",
        "name": "to",
        "type": "address",
        "indexed": true,
      },
      {
        "internalType": "uint256[]",
        "name": "ids",
        "type": "uint256[]",
        "indexed": false,
      },
      {
        "internalType": "uint256[]",
        "name": "values",
        "type": "uint256[]",
        "indexed": false,
      },
    ],
    "type": "event",
  });

  @override
  AbiEventFragment get fragment => fragmentDef;
  @override
  ERC1155TransferBatchEvent fromDecodedValues(List<dynamic> values) {
    return ERC1155TransferBatchEvent(
      operator: SolidityCodec.asAddress(values[0]),
      from: SolidityCodec.asAddress(values[1]),
      to: SolidityCodec.asAddress(values[2]),
      ids: SolidityCodec.asBigIntList(values[3]),
      values: SolidityCodec.asBigIntList(values[4]),
    );
  }
}
