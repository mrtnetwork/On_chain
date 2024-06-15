import 'package:blockchain_utils/utils/utils.dart';
import 'package:blockchain_utils/bip/ecc/keys/ed25519_keys.dart';
import 'package:blockchain_utils/exception/exception.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:blockchain_utils/signer/solana/solana_signer.dart';
import 'package:on_chain/solana/src/instructions/ed25519/constant.dart';
import 'package:on_chain/solana/src/keypair/private_key.dart';
import 'package:on_chain/solana/src/keypair/public_key.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// StructLayout for the Ed25519 program.
class Ed25519ProgramLayout extends ProgramLayout {
  /// Number of signatures.
  final int numSignatures;

  /// Padding.
  final int padding;

  /// Signature offset.
  final int signatureOffset;

  /// Signature instruction index.
  final int signatureInstructionIndex;

  /// Public key offset.
  final int publicKeyOffset;

  /// Public key instruction index.
  final int publicKeyInstructionIndex;

  /// Message data offset.
  final int messageDataOffset;

  /// Message data size.
  final int messageDataSize;

  /// Message instruction index.
  final int messageInstructionIndex;

  /// Public key.
  final SolanaPublicKey publicKey;

  /// Signature.
  final List<int> signature;

  /// Message.
  final List<int> message;

  /// Constructs the layout with required parameters.
  Ed25519ProgramLayout._({
    required this.numSignatures,
    required this.padding,
    required this.signatureOffset,
    required this.signatureInstructionIndex,
    required this.publicKeyOffset,
    required this.publicKeyInstructionIndex,
    required this.messageDataOffset,
    required this.messageDataSize,
    required this.messageInstructionIndex,
    required this.publicKey,
    required List<int> message,
    required List<int> signature,
  })  : signature = BytesUtils.toBytes(signature, unmodifiable: true),
        message = BytesUtils.toBytes(message, unmodifiable: true);

  /// Create an ed25519 instruction with a private key.
  factory Ed25519ProgramLayout.fromPrivateKey({
    required SolanaPrivateKey privateKey,
    required List<int> message,
    int? instructionIndex,
  }) {
    final pubkey = privateKey.publicKey();
    final signature = privateKey.sign(message);
    return Ed25519ProgramLayout.fromPublicKey(
      publicKey: pubkey,
      message: message,
      signature: signature,
      instructionIndex: instructionIndex,
    );
  }

  ///  Create an ed25519 instruction with a public key and signature. the signature
  ///  must be a buffer of 64 bytes.
  factory Ed25519ProgramLayout.fromPublicKey({
    required SolanaPublicKey publicKey,
    required List<int> message,
    required List<int> signature,
    int? instructionIndex,
  }) {
    if (signature.length != Ed25519ProgramConst.signatureLen) {
      throw MessageException("invalid signature length.", details: {
        "Excepted": Ed25519ProgramConst.signatureLen,
        "length": signature.length
      });
    }
    final int index = instructionIndex ?? mask16;
    final publicKeyOffset = _layout.span;
    final signatureOffset = publicKeyOffset + publicKey.toBytes(false).length;
    final messageDataOffset = signatureOffset + signature.length;

    return Ed25519ProgramLayout._(
      numSignatures: 1,
      padding: 0,
      signatureOffset: signatureOffset,
      signatureInstructionIndex: index,
      publicKeyOffset: publicKeyOffset,
      publicKeyInstructionIndex: index,
      messageDataOffset: messageDataOffset,
      messageDataSize: message.length,
      messageInstructionIndex: index,
      publicKey: publicKey,
      message: message,
      signature: signature,
    );
  }

  /// Constructs the layout from raw bytes.
  factory Ed25519ProgramLayout.fromBuffer(List<int> data) {
    final decode =
        ProgramLayout.decodeAndValidateStruct(layout: _layout, bytes: data);
    final int publicKeyOffset = decode["publicKeyOffset"];
    final int signatureOffset = decode["signatureOffset"];
    final int messageOffset = decode["messageDataOffset"];
    final int messageSize = decode["messageDataSize"];
    final pubKey = data.sublist(
        publicKeyOffset, publicKeyOffset + Ed25519KeysConst.pubKeyByteLen);
    final signature = data.sublist(
        signatureOffset, signatureOffset + SolanaSignerConst.signatureLen);
    final message = data.sublist(messageOffset, messageOffset + messageSize);
    return Ed25519ProgramLayout._(
      numSignatures: decode["numSignatures"],
      padding: decode["padding"],
      signatureOffset: signatureOffset,
      signatureInstructionIndex: decode["signatureInstructionIndex"],
      publicKeyOffset: publicKeyOffset,
      publicKeyInstructionIndex: decode["publicKeyInstructionIndex"],
      messageDataOffset: messageOffset,
      messageDataSize: messageSize,
      messageInstructionIndex: decode["messageInstructionIndex"],
      message: message,
      publicKey: SolanaPublicKey.fromBytes(pubKey),
      signature: signature,
    );
  }

  /// StructLayout layout definition.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "numSignatures"),
    LayoutConst.u8(property: 'padding'),
    LayoutConst.u16(property: 'signatureOffset'),
    LayoutConst.u16(property: 'signatureInstructionIndex'),
    LayoutConst.u16(property: 'publicKeyOffset'),
    LayoutConst.u16(property: 'publicKeyInstructionIndex'),
    LayoutConst.u16(property: 'messageDataOffset'),
    LayoutConst.u16(property: 'messageDataSize'),
    LayoutConst.u16(property: 'messageInstructionIndex'),
  ]);
  @override
  StructLayout get layout => _layout;

  @override
  final int instruction = -1;

  int get length {
    final publicKeyOffset = _layout.span;
    final signatureOffset = publicKeyOffset + publicKey.toBytes(false).length;
    final messageDataOffset = signatureOffset + signature.length;
    return messageDataOffset + message.length;
  }

  @override
  Map<String, dynamic> serialize() {
    return {
      "numSignatures": numSignatures,
      "padding": padding,
      "signatureOffset": signatureOffset,
      "signatureInstructionIndex": signatureInstructionIndex,
      "publicKeyOffset": publicKeyOffset,
      "publicKeyInstructionIndex": publicKeyInstructionIndex,
      "messageDataOffset": messageDataOffset,
      "messageDataSize": messageDataSize,
      "messageInstructionIndex": messageInstructionIndex,
    };
  }

  @override
  List<int> toBytes() {
    final data = List<int>.filled(length, 0);
    data.setAll(0, layout.serialize(serialize()));
    data.setAll(publicKeyOffset, publicKey.toBytes(false));
    data.setAll(signatureOffset, signature);
    data.setAll(messageDataOffset, message);
    return data;
  }
}
