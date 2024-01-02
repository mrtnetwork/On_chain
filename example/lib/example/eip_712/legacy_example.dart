import 'package:on_chain/on_chain.dart';

void main() {
  /// Create an EIP-712 message using legacy format
  final eip712 = EIP712Legacy.fromJson([
    {"type": "string", "name": "Message", "value": "Hi, Alice!"},
    {"type": "uint32", "name": "A number", "value": "1337"},
    {"type": "int32", "name": "A number", "value": "-1"},
    {
      "type": "string[]",
      "name": "BBBB",
      "value": ["one", "two", "three"]
    },
  ]);

  /// Encode the types of the EIP-712 message
  final encodeTypes = eip712.encode();

  /// Define a private key for signing the EIP-712 message
  final privateKey = ETHPrivateKey(
      "db8cf18222bb47698309de20e0befa9a55ef1f0af001dcefa79d31446484dc65");

  /// Sign the encoded types with the private key, setting hashMessage to false
  final _ = privateKey.sign(encodeTypes, hashMessage: false).toHex();
}
