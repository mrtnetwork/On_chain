import 'dart:typed_data';

import 'package:on_chain/contract/fragments.dart';
import 'package:on_chain/ethereum/address/evm_address.dart';
import 'package:on_chain/tron/address/tron_address.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test("test1", () {
    const String encoded =
        "67d29d8200000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000160000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000e86d2a1bf8e3000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000600000000000000000000000000000000000000000000000000000000000000003ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff9c00000000000000000000000000000000000000000000000000000000000003e800000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000000000000a00000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000271000000000000000000000000000000000000000000000000000000000000007d0";
    final fragment = AbiFunctionFragment.fromJson({
      "inputs": [
        {
          "components": [
            {"internalType": "uint256", "name": "feeAmount", "type": "uint256"},
            {"internalType": "bytes32", "name": "r", "type": "bytes32"},
            {"internalType": "bytes32", "name": "r", "type": "int256[]"},
          ],
          "internalType":
              "struct IMetaTransactionsFeature.MetaTransactionData[]",
          "name": "mtxs",
          "type": "tuple[]"
        },
        {
          "components": [
            {"internalType": "bytes32", "name": "s", "type": "bytes"},
            {"internalType": "uint8", "name": "v", "type": "uint8[]"},
            {"internalType": "bytes32", "name": "r", "type": "int256[]"},
          ],
          "internalType": "struct LibSignature.Signature[]",
          "name": "signatures",
          "type": "tuple[]"
        }
      ],
      "name": "batchExecuteMetaTransactions",
      "outputs": [
        {
          "components": [
            {"internalType": "uint256", "name": "feeAmount", "type": "uint256"},
            {"internalType": "bytes32", "name": "r", "type": "bytes32"},
            {"internalType": "bytes32", "name": "r", "type": "int256[]"},
          ],
          "internalType":
              "struct IMetaTransactionsFeature.MetaTransactionData[]",
          "name": "mtxs",
          "type": "tuple[]"
        },
        {
          "components": [
            {"internalType": "bytes32", "name": "s", "type": "bytes"},
            {"internalType": "uint8", "name": "v", "type": "uint8[]"},
            {"internalType": "bytes32", "name": "r", "type": "int256[]"},
          ],
          "internalType": "struct LibSignature.Signature[]",
          "name": "signatures",
          "type": "tuple[]"
        }
      ],
      "stateMutability": "payable",
      "type": "function"
    }, false);
    final params = [
      [
        [
          BigInt.from(255555555555555),
          Uint8List(32),
          [BigInt.from(-1), BigInt.from(-100), BigInt.from(1000)]
        ]
      ],
      [
        [
          Uint8List(32),
          [BigInt.one, BigInt.two],
          [BigInt.from(10000), BigInt.from(2000)]
        ]
      ]
    ];
    final encode = fragment.encodeHex(params);
    expect(encoded, encode);
    final decode = fragment.decodeInput(BytesUtils.fromHexString(encode));
    expect(decode.toString(), params.toString());
  });

  test("test2", () {
    const String encoded = "8fd3ab80";
    final fragment = AbiFunctionFragment.fromJson({
      "inputs": [],
      "name": "migrate",
      "outputs": [
        {"internalType": "bytes4", "name": "success", "type": "bytes4"}
      ],
      "stateMutability": "nonpayable",
      "type": "function"
    }, false);
    final params = [];
    final encodeHex = fragment.encodeHex(params);
    expect(encodeHex, encoded);
  });
  test("test3", () {
    const String encoded =
        "3d61ed3e00000000000000000000000000000000000000000000000000000000000000a0000000000000000000000000000000000000000000000000000000000000000f000000000000000000000000000000000000000000000000000000000000000f46464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646000000000000000000000000305aedb55cd62106e075f0fe6cbdf0da52fedbdb000000000000000000000000a14317b6a657582d9cf34ac0c236e3eaf66a172e00000000000000000000000000000000000000000000000000000000000009c40000000000000000000000000000000000000000000000000000000000000dac0000000000000000000000000000000000000000000000000000000000001194000000000000000000000000000000000000000000000000000000000000157c00000000000000000000000000000000000000000000000000000000000001400000000000000000000000000000000000000000000000000000000000000001000000000000000000000000a14317b6a657582d9cf34ac0c236e3eaf66a172e0000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000003f09090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090900";
    final fragment = AbiFunctionFragment.fromJson({
      "inputs": [
        {
          "components": [
            {
              "internalType": "address payable",
              "name": "signer",
              "type": "address"
            },
            {"internalType": "address", "name": "sender", "type": "address"},
            {
              "internalType": "uint256",
              "name": "minGasPrice",
              "type": "uint256"
            },
            {
              "internalType": "uint256",
              "name": "maxGasPrice",
              "type": "uint256"
            },
            {
              "internalType": "uint256",
              "name": "expirationTimeSeconds",
              "type": "uint256"
            },
            {"internalType": "uint256", "name": "salt", "type": "uint256"},
            {"internalType": "bytes", "name": "callData", "type": "bytes"},
            {"internalType": "uint256", "name": "value", "type": "uint256"},
            {
              "internalType": "contract IERC20TokenV06",
              "name": "feeToken",
              "type": "address"
            },
            {"internalType": "uint256", "name": "feeAmount", "type": "uint256"}
          ],
          "internalType": "struct IMetaTransactionsFeature.MetaTransactionData",
          "name": "mtx",
          "type": "tuple"
        },
        {
          "components": [
            {
              "internalType": "enum LibSignature.SignatureType",
              "name": "signatureType",
              "type": "uint8"
            },
            {"internalType": "uint8", "name": "v", "type": "uint8"},
            {"internalType": "bytes32", "name": "r", "type": "bytes32"},
            {"internalType": "bytes32", "name": "s", "type": "bytes32"}
          ],
          "internalType": "struct LibSignature.Signature",
          "name": "signature",
          "type": "tuple"
        }
      ],
      "name": "executeMetaTransaction",
      "outputs": [
        {"internalType": "bytes", "name": "returnResult", "type": "bytes"}
      ],
      "stateMutability": "payable",
      "type": "function"
    }, false);
    final params = [
      [
        ETHAddress("0x305AEdB55Cd62106e075f0fE6cbDF0DA52FeDbDB"),
        ETHAddress("0xa14317b6a657582d9cF34AC0C236e3eAF66a172e"),
        BigInt.from(2500),
        BigInt.from(3500),
        BigInt.from(4500),
        BigInt.from(5500),
        Uint8List.fromList(List<int>.filled(63, 9)),
        BigInt.one,
        ETHAddress("0xa14317b6a657582d9cF34AC0C236e3eAF66a172e"),
        BigInt.one,
      ],
      [
        BigInt.from(15),
        BigInt.from(15),
        Uint8List.fromList(List<int>.filled(32, 70)),
        Uint8List.fromList(List<int>.filled(32, 70))
      ]
    ];
    final encodeHex = fragment.encodeHex(params);
    expect(encodeHex, encoded);
  });
  test("test4", () {
    const String encoded =
        "5b43bc99000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000644d45544e4554574f524b4d45544e4554574f524b4d45544e4554574f524b4d45544e4554574f524b4d45544e4554574f524b4d45544e4554574f524b4d45544e4554574f524b4d45544e4554574f524b4d45544e4554574f524b4d45544e4554574f524b00000000000000000000000000000000000000000000000000000000";
    final fragment = AbiFunctionFragment.fromJson({
      "constant": true,
      "inputs": [
        {"name": "", "type": "string"}
      ],
      "name": "name",
      "outputs": [
        {"name": "", "type": "string"}
      ],
      "payable": false,
      "stateMutability": "view",
      "type": "function"
    }, false);
    final params = [
      "METNETWORKMETNETWORKMETNETWORKMETNETWORKMETNETWORKMETNETWORKMETNETWORKMETNETWORKMETNETWORKMETNETWORK"
    ];
    final encodeHex = fragment.encodeHex(params);
    expect(encodeHex, encoded);
    final decode = fragment.decodeInput(BytesUtils.fromHexString(encodeHex));
    expect(params.first, decode.first);
  });
  test("test5", () {
    const String encoded =
        "3d61ed3e00000000000000000000000000000000000000000000000000000000000000a0000000000000000000000000000000000000000000000000000000000000000f000000000000000000000000000000000000000000000000000000000000000f46464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646464646000000000000000000000000305aedb55cd62106e075f0fe6cbdf0da52fedbdb000000000000000000000000a14317b6a657582d9cf34ac0c236e3eaf66a172e00000000000000000000000000000000000000000000000000000000000009c40000000000000000000000000000000000000000000000000000000000000dac0000000000000000000000000000000000000000000000000000000000001194000000000000000000000000000000000000000000000000000000000000157c00000000000000000000000000000000000000000000000000000000000001400000000000000000000000000000000000000000000000000000000000000001000000000000000000000000a14317b6a657582d9cf34ac0c236e3eaf66a172e0000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000003f09090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090909090900";
    final fragment = AbiFunctionFragment.fromJson({
      "inputs": [
        {
          "components": [
            {
              "internalType": "address payable",
              "name": "signer",
              "type": "address"
            },
            {"internalType": "address", "name": "sender", "type": "address"},
            {
              "internalType": "uint256",
              "name": "minGasPrice",
              "type": "uint256"
            },
            {
              "internalType": "uint256",
              "name": "maxGasPrice",
              "type": "uint256"
            },
            {
              "internalType": "uint256",
              "name": "expirationTimeSeconds",
              "type": "uint256"
            },
            {"internalType": "uint256", "name": "salt", "type": "uint256"},
            {"internalType": "bytes", "name": "callData", "type": "bytes"},
            {"internalType": "uint256", "name": "value", "type": "uint256"},
            {
              "internalType": "contract IERC20TokenV06",
              "name": "feeToken",
              "type": "address"
            },
            {"internalType": "uint256", "name": "feeAmount", "type": "uint256"}
          ],
          "internalType": "struct IMetaTransactionsFeature.MetaTransactionData",
          "name": "mtx",
          "type": "tuple"
        },
        {
          "components": [
            {
              "internalType": "enum LibSignature.SignatureType",
              "name": "signatureType",
              "type": "uint8"
            },
            {"internalType": "uint8", "name": "v", "type": "uint8"},
            {"internalType": "bytes32", "name": "r", "type": "bytes32"},
            {"internalType": "bytes32", "name": "s", "type": "bytes32"}
          ],
          "internalType": "struct LibSignature.Signature",
          "name": "signature",
          "type": "tuple"
        }
      ],
      "name": "executeMetaTransaction",
      "outputs": [
        {"internalType": "bytes", "name": "returnResult", "type": "bytes"}
      ],
      "stateMutability": "payable",
      "type": "function"
    }, true);
    final params = [
      [
        TronAddress.fromEthAddress(BytesUtils.fromHexString(
            "0x305AEdB55Cd62106e075f0fE6cbDF0DA52FeDbDB")),
        TronAddress.fromEthAddress(BytesUtils.fromHexString(
            "0xa14317b6a657582d9cF34AC0C236e3eAF66a172e")),
        BigInt.from(2500),
        BigInt.from(3500),
        BigInt.from(4500),
        BigInt.from(5500),
        Uint8List.fromList(List<int>.filled(63, 9)),
        BigInt.one,
        TronAddress.fromEthAddress(BytesUtils.fromHexString(
            "0xa14317b6a657582d9cF34AC0C236e3eAF66a172e")),
        BigInt.one,
      ],
      [
        BigInt.from(15),
        BigInt.from(15),
        Uint8List.fromList(List<int>.filled(32, 70)),
        Uint8List.fromList(List<int>.filled(32, 70))
      ]
    ];
    final encodeHex = fragment.encodeHex(params);
    expect(encodeHex, encoded);
  });
}
