import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/secp256r1/constant.dart';
import 'package:on_chain/solana/src/instructions/secp256r1/instruction/instructions.dart';

/// Single-signature layout for the Secp256r1 precompile.
/// Wire format (SIMD-0075): u8 num_signatures, u8 padding, then one 14-byte
/// offsets struct of u16s (signature_offset, signature_instruction_index,
/// public_key_offset, public_key_instruction_index, message_offset,
/// message_size, message_instruction_index), then 64-byte compact signature
/// (r || s, low-S enforced on-chain), 33-byte compressed public key and the
/// raw message bytes.
class Secp256r1Layout extends ProgramLayout {
  static int get size => _layout.span;

  /// Number of signatures.
  final int numSignatures;

  /// Offset of the signature.
  final int signatureOffset;

  /// Instruction index for the signature.
  final int signatureInstructionIndex;

  /// Offset of the compressed public key.
  final int publicKeyOffset;

  /// Instruction index for the public key.
  final int publicKeyInstructionIndex;

  /// Offset of the message data.
  final int messageDataOffset;

  /// Size of the message data.
  final int messageDataSize;

  /// Instruction index for the message.
  final int messageInstructionIndex;

  /// compact signature bytes (r || s).
  final List<int> signature;

  /// compressed public key bytes.
  final List<int> publicKey;

  /// message bytes.
  final List<int> message;

  /// Constructs a Secp256r1Layout instance.
  Secp256r1Layout({
    required this.numSignatures,
    required this.signatureOffset,
    required this.signatureInstructionIndex,
    required this.publicKeyOffset,
    required this.publicKeyInstructionIndex,
    required this.messageDataOffset,
    required this.messageDataSize,
    required this.messageInstructionIndex,
    required List<int> signature,
    required List<int> publicKey,
    required List<int> message,
  }) : signature = signature.asImmutableBytes,
       publicKey = publicKey.asImmutableBytes,
       message = message.asImmutableBytes;

  /// Create a secp256r1 layout from raw parts. The signature
  /// must be 64-byte compact (r || s) with low-S; the public key 33-byte
  /// compressed. Offsets point into this same instruction by default.
  factory Secp256r1Layout.fromParts({
    required List<int> publicKey,
    required List<int> message,
    required List<int> signature,
    int instructionIndex = 0,
  }) {
    if (signature.length != Secp256r1ProgramConst.signatureLength) {
      throw BuError.length(
        what: 'Secp256r1 signature',
        expected: Secp256r1ProgramConst.signatureLength,
        actual: signature.length,
      );
    }
    if (publicKey.length != Secp256r1ProgramConst.compressedPubkeyLength) {
      throw BuError.length(
        what: 'Secp256r1 public key',
        expected: Secp256r1ProgramConst.compressedPubkeyLength,
        actual: publicKey.length,
      );
    }
    const int signatureOffset = 14;
    final int publicKeyOffset =
        signatureOffset + Secp256r1ProgramConst.signatureLength;
    return Secp256r1Layout(
      numSignatures: 1,
      signatureOffset: signatureOffset,
      signatureInstructionIndex: instructionIndex,
      publicKeyOffset: publicKeyOffset,
      publicKeyInstructionIndex: instructionIndex,
      messageDataOffset:
          publicKeyOffset + Secp256r1ProgramConst.compressedPubkeyLength,
      messageDataSize: message.length,
      messageInstructionIndex: instructionIndex,
      message: message,
      signature: signature,
      publicKey: publicKey,
    );
  }

  /// Constructs a Secp256r1Layout instance from a buffer.
  factory Secp256r1Layout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: data,
    );
    final int messageDataOffset = decode['messageDataOffset'];
    final int messageDataSize = decode['messageDataSize'];
    final int publicKeyOffset = decode['publicKeyOffset'];
    final List<int> signature = List<int>.unmodifiable(
      (decode['signature'] as List).cast<int>(),
    );
    final List<int> publicKey = List<int>.unmodifiable(
      data.sublist(
        publicKeyOffset,
        publicKeyOffset + Secp256r1ProgramConst.compressedPubkeyLength,
      ),
    );
    final List<int> message = data.sublist(
      messageDataOffset,
      messageDataOffset + messageDataSize,
    );
    return Secp256r1Layout(
      numSignatures: decode['numSignatures'],
      signatureOffset: decode['signatureOffset'],
      signatureInstructionIndex: decode['signatureInstructionIndex'],
      publicKeyOffset: publicKeyOffset,
      publicKeyInstructionIndex: decode['publicKeyInstructionIndex'],
      messageDataOffset: messageDataOffset,
      messageDataSize: messageDataSize,
      messageInstructionIndex: decode['messageInstructionIndex'],
      signature: signature,
      publicKey: publicKey,
      message: message,
    );
  }

  /// StructLayout structure for Secp256r1Layout.
  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.u8(property: 'numSignatures'),
    LayoutConst.u8(property: 'padding'),
    LayoutConst.u16(property: 'signatureOffset'),
    LayoutConst.u16(property: 'signatureInstructionIndex'),
    LayoutConst.u16(property: 'publicKeyOffset'),
    LayoutConst.u16(property: 'publicKeyInstructionIndex'),
    LayoutConst.u16(property: 'messageDataOffset'),
    LayoutConst.u16(property: 'messageDataSize'),
    LayoutConst.u16(property: 'messageInstructionIndex'),
    LayoutConst.blob(
      Secp256r1ProgramConst.signatureLength,
      property: 'signature',
    ),
    LayoutConst.blob(
      Secp256r1ProgramConst.compressedPubkeyLength,
      property: 'publicKey',
    ),
  ]);

  /// Gets the layout structure.
  @override
  StructLayout get layout => _layout;

  /// Instruction associated with the layout.
  @override
  final Secp256r1ProgramInstruction instruction =
      Secp256r1ProgramInstruction.secp256r1;

  int get length => _layout.span + message.length;

  /// Serializes the layout.
  @override
  Map<String, dynamic> serialize() {
    return {
      'numSignatures': numSignatures,
      'padding': 0,
      'signatureOffset': signatureOffset,
      'signatureInstructionIndex': signatureInstructionIndex,
      'publicKeyOffset': publicKeyOffset,
      'publicKeyInstructionIndex': publicKeyInstructionIndex,
      'messageDataOffset': messageDataOffset,
      'messageDataSize': messageDataSize,
      'messageInstructionIndex': messageInstructionIndex,
      'signature': signature,
      'publicKey': publicKey,
    };
  }

  /// Converts the layout into bytes.
  @override
  BuBytes toBytes() {
    final data = BuBytes.fill(_layout.span + message.length, 0);
    data.setAll(0, layout.serialize(serialize()));
    data.setAll(publicKeyOffset, publicKey);
    data.setAll(messageDataOffset, message);
    return data;
  }
}
