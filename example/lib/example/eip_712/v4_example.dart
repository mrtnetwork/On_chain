import 'package:on_chain/ethereum/src/keys/private_key.dart';
import 'package:on_chain/solidity/solidity.dart';

void main() {
  /// Create an EIP-712 message
  final Eip712TypedData eip712 = Eip712TypedData(
      types: {
        "EIP712Domain": [
          const Eip712TypeDetails(name: "name", type: "string"),
          const Eip712TypeDetails(name: "version", type: "string"),
          const Eip712TypeDetails(name: "chainId", type: "uint256"),
          const Eip712TypeDetails(name: "verifyingContract", type: "address"),
        ],
        "Person": [
          const Eip712TypeDetails(name: "name", type: "string"),
          const Eip712TypeDetails(name: "wallet", type: "address"),
        ],
        "Mail": [
          const Eip712TypeDetails(name: "from", type: "Person"),
          const Eip712TypeDetails(name: "to", type: "Person"),
          const Eip712TypeDetails(name: "contents", type: "string")
        ],
      },
      primaryType: "Mail",
      domain: {
        "name": "Ether Mail",
        "version": "1",
        "chainId": BigInt.from(80001),
        "verifyingContract": "0xCcCCccccCCCCcCCCCCCcCcCccCcCCCcCcccccccC",
      },
      message: {
        "from": {
          "name": "Cow",
          "wallet": "0xCD2a3d9F938E13CD947Ec05AbC7FE734Df8DD826"
        },
        "to": {
          "name": "Bob",
          "wallet": "0xbBbBBBBbbBBBbbbBbbBbbbbBBbBbbbbBbBbbBBbB"
        },
        "contents": "Hello, Bob!",
      });

  /// Encode the types of the EIP-712 message
  final encodeTypes = eip712.encode();

  /// Define a private key for signing the EIP-712 message
  final privateKey = ETHPrivateKey(
      "db8cf18222bb47698309de20e0befa9a55ef1f0af001dcefa79d31446484dc65");

  /// Sign the encoded types with the private key, setting hashMessage to false
  final _ = privateKey.sign(encodeTypes, hashMessage: false).toHex();
}
