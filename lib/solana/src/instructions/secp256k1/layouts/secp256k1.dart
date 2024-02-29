// Manages the layout structure for a Solana program involving Ethereum's secp256k1 signatures.
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:on_chain/ethereum/src/keys/private_key.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class Secp256k1Layout extends ProgramLayout {
  /// Ethereum address used in the layout.
  final ETHAddress ethAddress;

  /// Number of signatures.
  final int numSignatures;

  /// Offset of the signature.
  final int signatureOffset;

  /// Instruction index for the signature.
  final int signatureInstructionIndex;

  /// Offset of the Ethereum address.
  final int ethAddressOffset;

  /// Instruction index for the Ethereum address.
  final int ethAddressInstructionIndex;

  /// Offset of the message data.
  final int messageDataOffset;

  /// Size of the message data.
  final int messageDataSize;

  /// Instruction index for the message.
  final int messageInstructionIndex;

  /// signature bytes.
  final List<int> signature;

  /// Recovery ID.
  final int recoveryId;

  /// message bytes.
  final List<int> message;

  /// Constructs a Secp256k1Layout instance.
  Secp256k1Layout({
    required this.ethAddress,
    required this.numSignatures,
    required this.signatureOffset,
    required this.signatureInstructionIndex,
    required this.ethAddressOffset,
    required this.ethAddressInstructionIndex,
    required this.messageDataOffset,
    required this.messageDataSize,
    required this.messageInstructionIndex,
    required List<int> signature,
    required List<int> message,
    required this.recoveryId,
  })  : signature = BytesUtils.toBytes(signature, unmodifiable: true),
        message = BytesUtils.toBytes(message, unmodifiable: true);

  /// Create an secp256k1 layout with an Ethereum address.
  factory Secp256k1Layout.fromEthAddress(
      {required ETHAddress address,
      required List<int> message,
      required List<int> signature,
      required int recoveryId,
      int instructionIndex = 0}) {
    final int ethAddressOffset = 12;
    final int signatureOffset = ethAddressOffset + ETHAddress.lengthInBytes;
    return Secp256k1Layout(
        ethAddress: address,
        numSignatures: 1,
        signatureOffset: signatureOffset,
        signatureInstructionIndex: instructionIndex,
        ethAddressOffset: ethAddressOffset,
        ethAddressInstructionIndex: instructionIndex,
        messageDataOffset: signatureOffset + signature.length + 1,
        messageDataSize: message.length,
        messageInstructionIndex: instructionIndex,
        message: message,
        signature: signature,
        recoveryId: recoveryId);
  }

  /// Create an secp256k1 layout with a private key.
  factory Secp256k1Layout.fromPrivateKey(
      {required ETHPrivateKey privateKey,
      required List<int> message,
      required int instructionIndex}) {
    final address = privateKey.publicKey().toAddress();
    final signature = privateKey.sign(message, hashMessage: true);
    final sigBytes = signature.toBytes(false);
    return Secp256k1Layout.fromEthAddress(
        address: address,
        message: message,
        signature: sigBytes.sublist(0, ETHSignerConst.ethSignatureLength),
        recoveryId: sigBytes[ETHSignerConst.ethSignatureLength],
        instructionIndex: instructionIndex);
  }

  /// Constructs a Secp256k1Layout instance from a buffer.
  factory Secp256k1Layout.fromBuffer(List<int> data) {
    final decode =
        ProgramLayout.decodeAndValidateStruct(layout: _layout, bytes: data);
    final int messageDataOffset = decode["messageDataOffset"];
    final int messageDataSize = decode["messageDataSize"];
    final List<int> message =
        data.sublist(messageDataOffset, messageDataOffset + messageDataSize);
    return Secp256k1Layout(
        ethAddress: ETHAddress.fromBytes(decode["ethAddress"]),
        numSignatures: decode["numSignatures"],
        signatureOffset: decode["signatureOffset"],
        signatureInstructionIndex: decode["signatureInstructionIndex"],
        ethAddressOffset: decode["ethAddressOffset"],
        ethAddressInstructionIndex: decode["ethAddressInstructionIndex"],
        messageDataOffset: messageDataOffset,
        messageDataSize: messageDataSize,
        messageInstructionIndex: decode["messageInstructionIndex"],
        signature: decode["signature"],
        message: message,
        recoveryId: decode["recoveryId"]);
  }

  /// Structure structure for Secp256k1Layout.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("numSignatures"),
    LayoutUtils.u16("signatureOffset"),
    LayoutUtils.u8("signatureInstructionIndex"),
    LayoutUtils.u16("ethAddressOffset"),
    LayoutUtils.u8("ethAddressInstructionIndex"),
    LayoutUtils.u16("messageDataOffset"),
    LayoutUtils.u16("messageDataSize"),
    LayoutUtils.u8("messageInstructionIndex"),
    LayoutUtils.blob(ETHAddress.lengthInBytes, property: "ethAddress"),
    LayoutUtils.blob(ETHSignerConst.ethSignatureLength, property: "signature"),
    LayoutUtils.u8("recoveryId")
  ]);

  /// Gets the layout structure.
  @override
  Structure get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final int instruction = -1;

  int get length => _layout.span + message.length;

  /// Serializes the layout.
  @override
  Map<String, dynamic> serialize() {
    return {
      "numSignatures": numSignatures,
      "signatureOffset": signatureOffset,
      "signatureInstructionIndex": signatureInstructionIndex,
      "ethAddressOffset": ethAddressOffset,
      "ethAddressInstructionIndex": ethAddressInstructionIndex,
      "messageDataOffset": messageDataOffset,
      "messageDataSize": messageDataSize,
      "messageInstructionIndex": messageInstructionIndex,
      "ethAddress": ethAddress.toBytes(),
      "signature": signature,
      "recoveryId": recoveryId
    };
  }

  /// Converts the layout into bytes.
  @override
  List<int> toBytes() {
    final LayoutByteWriter data =
        LayoutByteWriter(_layout.span + message.length);
    layout.encode(serialize(), data);
    data.setAll(messageDataOffset, message);
    return data.toBytes();
  }
}
