import 'package:blockchain_utils/crypto/quick_crypto.dart';
import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:on_chain/ethereum/src/contracts/safe/types/contracts.dart';
import 'package:on_chain/ethereum/src/contracts/safe/types/types.dart';
import 'package:on_chain/solidity/solidity.dart';

class SafeContractUtils {
  static List<int> calculateSafeTransactionHash({
    required BigInt chainId,
    required ETHAddress safeAddress,
    required SafeTransaction safeTransaction,
    required SafeContractVersion version,
  }) {
    final encode = switch (version) {
      SafeContractVersion.v1_0_0 ||
      SafeContractVersion.v1_1_1 ||
      SafeContractVersion.v1_2_0 =>
        encodeTransactionData(
            chainId: chainId,
            safeAddress: safeAddress,
            safeTransaction: safeTransaction),
      _ => preimageSafeTransactionHash(
          chainId: chainId,
          safeAddress: safeAddress,
          safeTransaction: safeTransaction)
    };
    return QuickCrypto.keccack256Hash(encode);
  }

  static List<int> encodeTransactionData(
      {required BigInt chainId,
      required ETHAddress safeAddress,
      required SafeTransaction safeTransaction}) {
    final encode = ABIUtils.encodeKeccack256(types: [
      "bytes32",
      "address",
      "uint256",
      "bytes32",
      "uint256",
      "uint256",
      "uint256",
      "uint256",
      "address",
      "address",
      "uint256"
    ], params: [
      "0xbb8310d486368db6bd6f849402fdd73ad53d316b5a4b2644ad6efe0f941286d8",
      safeTransaction.to,
      safeTransaction.value,
      QuickCrypto.keccack256Hash(safeTransaction.data),
      safeTransaction.operation.value,
      safeTransaction.gasParams.safeTxGas,
      safeTransaction.gasParams.baseGas,
      safeTransaction.gasParams.gasPrice,
      safeTransaction.gasParams.gasToken,
      safeTransaction.gasParams.refundReceiver,
      safeTransaction.nonce
    ]);
    return ABIUtils.encodePacked(types: [
      "bytes1",
      "bytes1",
      "bytes32",
      "bytes32"
    ], params: [
      [0x19],
      [0x01],
      ABIUtils.encodeKeccack256(types: [
        "bytes32",
        "address"
      ], params: [
        "0x035aff83d86937d35b32e04f0ddc6ff469290eef2f1b692d8a815c89404d4749",
        safeAddress
      ]),
      encode
    ]);
  }

  /// 190174c815f23df60424711688befc29af78eaac7d00e1eead469deab26214c634085b20455a2747d3e0b265987c5de49e1a391edd11d0cd43b4c1fbce50b0af3a25
  /// 1901e7389e76c4d884774faff34a0fbe58802f4315e7f7c980c8fd5cc8ff3d9b3e77ef1d6c74dc97b92e5e2f29c56d34f9369951c8f459a20eeeb32e37f6b84720ef
  static List<int> calculateSafeDomainSeparator(
      {required BigInt chainId,
      required ETHAddress safeAddress,
      required SafeTransaction safeTransaction}) {
    final typeData = Eip712TypedData(
        types: {
          "EIP712Domain": [
            Eip712TypeDetails(name: "chainId", type: "uint256"),
            Eip712TypeDetails(name: "verifyingContract", type: "address"),
          ],
        },
        primaryType: "SafeTx",
        domain: {
          "verifyingContract": safeAddress.address,
          "chainId": chainId.toString()
        },
        message: {});

    return typeData.hashDomain();
  }

  static List<int> preimageSafeTransactionHash(
      {required BigInt chainId,
      required ETHAddress safeAddress,
      required SafeTransaction safeTransaction}) {
    final typeData = safeTransactionTypedData(
        chainId: chainId,
        safeAddress: safeAddress,
        safeTransaction: safeTransaction);

    return typeData.encode(hash: false);
  }

  static Eip712TypedData safeTransactionTypedData(
      {required BigInt chainId,
      required ETHAddress safeAddress,
      required SafeTransaction safeTransaction}) {
    return Eip712TypedData(
        types: {
          "EIP712Domain": [
            Eip712TypeDetails(name: "chainId", type: "uint256"),
            Eip712TypeDetails(name: "verifyingContract", type: "address"),
          ],
          "SafeTx": [
            Eip712TypeDetails(name: "to", type: "address"),
            Eip712TypeDetails(name: "value", type: "uint256"),
            Eip712TypeDetails(name: "data", type: "bytes"),
            Eip712TypeDetails(name: "operation", type: "uint8"),
            Eip712TypeDetails(name: "safeTxGas", type: "uint256"),
            Eip712TypeDetails(name: "baseGas", type: "uint256"),
            Eip712TypeDetails(name: "gasPrice", type: "uint256"),
            Eip712TypeDetails(name: "gasToken", type: "address"),
            Eip712TypeDetails(name: "refundReceiver", type: "address"),
            Eip712TypeDetails(name: "nonce", type: "uint256"),
          ]
        },
        primaryType: "SafeTx",
        domain: {
          "verifyingContract": safeAddress.address,
          "chainId": chainId.toString()
        },
        message: safeTransaction.toJson());
  }

  static List<int> preimageSafeMessageHash(
      {required BigInt chainId,
      required ETHAddress safeAddress,
      required String message}) {
    final typeData = Eip712TypedData(
        types: {
          "EIP712Domain": [
            Eip712TypeDetails(name: "chainId", type: "uint256"),
            Eip712TypeDetails(name: "verifyingContract", type: "address"),
          ],
          "SafeMessage": [
            Eip712TypeDetails(name: "message", type: "bytes"),
          ]
        },
        primaryType: "SafeMessage",
        domain: {
          "verifyingContract": safeAddress.address,
          "chainId": chainId.toString()
        },
        message: {"message": message});

    return typeData.encode(hash: false);
  }

  static List<int> calculateSafeMessageHash(
      {required BigInt chainId,
      required ETHAddress safeAddress,
      required String message}) {
    return QuickCrypto.keccack256Hash(preimageSafeMessageHash(
        chainId: chainId, safeAddress: safeAddress, message: message));
  }
}
