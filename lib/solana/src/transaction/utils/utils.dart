import 'dart:typed_data';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/address_lockup_table/accounts/accounts/account_lookup_table.dart';
import 'package:on_chain/solana/src/models/models.dart';
import 'package:on_chain/solana/src/transaction/constant/solana_transaction_constant.dart';
import 'package:on_chain/solana/src/transaction/core/core.dart';
import 'package:on_chain/solana/src/transaction/message/legacy.dart';
import 'package:on_chain/solana/src/transaction/message/message_v1.dart';
import 'package:on_chain/solana/src/transaction/message/message_v0.dart';
import 'package:on_chain/solana/src/transaction/message/transaction_v1_config.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class SolanaTransactionUtils {
  /// encode int to bytes
  static List<int> _encodeLength(int len) {
    final List<int> bytes = [];
    var remLen = len;
    for (;;) {
      var elem = remLen & 0x7f;
      remLen >>= 7;
      if (remLen == 0) {
        bytes.add(elem);
        break;
      } else {
        elem |= 0x80;
        bytes.add(elem);
      }
    }
    return bytes;
  }

  /// decode bytes to int
  static int _decodeLength(List<int> bytes) {
    int len = 0;
    int size = 0;
    for (;;) {
      final int elem = bytes.removeAt(0);
      len |= (elem & 0x7f) << size * 7;
      size += 1;
      if ((elem & 0x80) == 0) {
        break;
      }
    }
    return len;
  }

  /// compile V0 Message
  static MessageV0 compileV0({
    required List<TransactionInstruction> transactionInstructions,
    required SolAddress payer,
    required SolAddress recentBlockhash,
    List<AddressLookupTableAccount> lookupTableAccounts = const [],
  }) {
    final compiledKeys = CompiledKeys.compile(transactionInstructions, payer);
    final addressTableLookups = <AddressTableLookup>[];
    final List<SolAddress> writable = List.empty(growable: true);
    final List<SolAddress> readonly = List.empty(growable: true);
    for (final lookupTable in lookupTableAccounts) {
      final extractResult = compiledKeys.extractTableLookup(lookupTable);
      if (extractResult != null) {
        final addressTableLookup = extractResult.lookup;
        addressTableLookups.add(addressTableLookup);
        writable.addAll(extractResult.writable);
        readonly.addAll(extractResult.readable);
      }
    }
    final componets = compiledKeys.getMessageComponents();
    final header = componets.$1;
    final staticAccountKeys = componets.$2;
    final accountKeys = MessageAccountKeys(
      staticAccountKeys,
      AccountLookupKeys(readonly: readonly, writable: writable),
    );
    final compiledInstructions = accountKeys.compileInstructions(
      transactionInstructions,
    );
    return MessageV0(
      header: header,
      accountKeys: staticAccountKeys,
      recentBlockhash: recentBlockhash,
      compiledInstructions: compiledInstructions,
      addressTableLookups: addressTableLookups,
    );
  }

  /// compile V1 message (SIMD-0385: no lookup tables, inline unique accounts).
  static MessageV1 compileV1({
    required List<TransactionInstruction> transactionInstructions,
    required SolAddress payer,
    required SolAddress recentBlockhash,
    TransactionV1Config config = const TransactionV1Config.empty(),
  }) {
    config.validate();
    if (transactionInstructions.length >
        SolanaTransactionConstant.maximumInstructions) {
      throw const BuError(
        DefaultErrorType.invalidLength,
        'Max instructions per v1 transaction exceeded.',
      );
    }
    final compiledKeys = CompiledKeys.compile(transactionInstructions, payer);
    final componets = compiledKeys.getMessageComponents();
    final header = componets.$1;
    final staticAccountKeys = componets.$2;
    if (staticAccountKeys.length >
        SolanaTransactionConstant.maximumAccountKeys) {
      throw const BuError(
        DefaultErrorType.invalidLength,
        'Max static account keys length exceeded.',
      );
    }
    final seen = <String>{};
    for (final key in staticAccountKeys) {
      if (!seen.add(key.address)) {
        throw const BuError(
          DefaultErrorType.invalidAddress,
          'V1 transaction addresses must not contain duplicates.',
        );
      }
    }
    final accountKeys = MessageAccountKeys(staticAccountKeys, null);
    final compiledInstructions = accountKeys.compileInstructions(
      transactionInstructions,
    );
    for (final ix in compiledInstructions) {
      if (ix.programIdIndex >= staticAccountKeys.length) {
        throw const BuError(
          DefaultErrorType.invalidLength,
          'V1 program index out of range.',
        );
      }
      if (ix.accounts.length > 255) {
        throw const BuError(
          DefaultErrorType.invalidLength,
          'Max accounts per v1 instruction exceeded.',
        );
      }
      for (final a in ix.accounts) {
        if (a >= staticAccountKeys.length) {
          throw const BuError(
            DefaultErrorType.invalidLength,
            'V1 account index out of range.',
          );
        }
      }
      if (ix.data.length > 0xFFFF) {
        throw const BuError(
          DefaultErrorType.invalidLength,
          'Max instruction data per v1 instruction exceeded.',
        );
      }
    }
    if (header.numRequiredSignatures < 1) {
      throw const BuError(
        DefaultErrorType.invalidArgument,
        'Expected at least one required signature.',
      );
    }
    return MessageV1(
      header: header,
      accountKeys: staticAccountKeys,
      recentBlockhash: recentBlockhash,
      compiledInstructions: compiledInstructions,
      config: config,
    );
  }

  static void _writeU16LE(List<int> out, int value) {
    out.addAll(IntUtils.toBytes(value, length: 2, byteOrder: Endian.little));
  }

  static void _writeU32LE(List<int> out, int value) {
    out.addAll(IntUtils.toBytes(value, length: 4, byteOrder: Endian.little));
  }

  static int _readU16LE(List<int> bytes, int offset) {
    if (offset + 2 > bytes.length) {
      throw const BuError(
        DefaultErrorType.invalidLength,
        'Truncated v1 message.',
      );
    }
    return IntUtils.fromBytes16(
      bytes,
      offset: offset,
      byteOrder: Endian.little,
    );
  }

  static int _readU32LE(List<int> bytes, int offset) {
    if (offset + 4 > bytes.length) {
      throw const BuError(
        DefaultErrorType.invalidLength,
        'Truncated v1 message.',
      );
    }
    return IntUtils.fromBytes32(
      bytes,
      offset: offset,
      byteOrder: Endian.little,
    );
  }

  /// serialize message V1 to bytes (SIMD-0385).
  static List<int> serializeV1(MessageV1 message) {
    message.config.validate();
    if (message.accountKeys.length >
        SolanaTransactionConstant.maximumAccountKeys) {
      throw const BuError(
        DefaultErrorType.invalidLength,
        'Max static account keys length exceeded.',
      );
    }
    if (message.compiledInstructions.length >
        SolanaTransactionConstant.maximumInstructions) {
      throw const BuError(
        DefaultErrorType.invalidLength,
        'Max instructions per v1 transaction exceeded.',
      );
    }
    final seen = <String>{};
    for (final key in message.accountKeys) {
      if (!seen.add(key.address)) {
        throw const BuError(
          DefaultErrorType.invalidAddress,
          'V1 transaction addresses must not contain duplicates.',
        );
      }
    }
    final out = <int>[];
    out.add(SolanaTransactionConstant.versionPrefixV1);
    out.addAll([
      message.header.numRequiredSignatures,
      message.header.numReadonlySignedAccounts,
      message.header.numReadonlyUnsignedAccounts,
    ]);
    _writeU32LE(out, message.config.mask);
    out.addAll(message.recentBlockhash.toBytes());
    if (message.compiledInstructions.length > 255 ||
        message.accountKeys.length > 255) {
      throw const BuError(
        DefaultErrorType.invalidLength,
        'V1 count exceeds u8 range.',
      );
    }
    out.add(message.compiledInstructions.length);
    out.add(message.accountKeys.length);
    for (final key in message.accountKeys) {
      out.addAll(key.toBytes());
    }
    out.addAll(message.config.encodeValues());
    for (final ix in message.compiledInstructions) {
      out.add(ix.programIdIndex);
      out.add(ix.accounts.length);
      _writeU16LE(out, ix.data.length);
    }
    for (final ix in message.compiledInstructions) {
      out.addAll(ix.accounts);
      out.addAll(ix.data);
    }
    if (out.length > SolanaTransactionConstant.packetDataSizeV1) {
      throw const BuError(
        DefaultErrorType.invalidLength,
        'Max v1 message size exceeded.',
      );
    }
    return out;
  }

  /// Length of the v1 message prefix up to (excluding) signatures.
  /// Used to split tail signatures from the wire transaction.
  static int v1MessageLength(List<int> bytes) {
    var offset = 0;
    int need(int n) {
      if (offset + n > bytes.length) {
        throw const BuError(
          DefaultErrorType.invalidLength,
          'Truncated v1 transaction.',
        );
      }
      return n;
    }

    need(1 + 3 + 4 + SolanaTransactionConstant.publicKeyLength + 1 + 1);
    if (bytes[offset] != SolanaTransactionConstant.versionPrefixV1) {
      throw const BuError(
        DefaultErrorType.invalidArgument,
        'Expected v1 version byte 0x81.',
      );
    }
    offset += 1 + 3;
    final mask = _readU32LE(bytes, offset);
    offset += 4;
    if ((mask & ~TransactionV1Config.knownBitsMask) != 0) {
      throw BuError(
        DefaultErrorType.unsupported,
        'Unsupported v1 config bits.',
        details: {'mask': mask.toString()},
      );
    }
    offset += SolanaTransactionConstant.publicKeyLength;
    final numInstructions = bytes[offset++];
    final numAddresses = bytes[offset++];
    if (numInstructions > SolanaTransactionConstant.maximumInstructions) {
      throw const BuError(
        DefaultErrorType.invalidLength,
        'Max instructions per v1 transaction exceeded.',
      );
    }
    if (numAddresses > SolanaTransactionConstant.maximumAccountKeys) {
      throw const BuError(
        DefaultErrorType.invalidLength,
        'Max static account keys length exceeded.',
      );
    }
    need(numAddresses * SolanaTransactionConstant.publicKeyLength);
    offset += numAddresses * SolanaTransactionConstant.publicKeyLength;
    need(TransactionV1Config.wordsForMask(mask) * 4);
    offset += TransactionV1Config.wordsForMask(mask) * 4;
    need(numInstructions * 4);
    var payloadLength = 0;
    for (var i = 0; i < numInstructions; i++) {
      final dataLen = _readU16LE(bytes, offset + 2);
      payloadLength += bytes[offset + 1] + dataLen;
    }
    offset += numInstructions * 4;
    need(payloadLength);
    offset += payloadLength;
    return offset;
  }

  /// convert bytes to Message V1.
  static MessageV1 deserializeV1(List<int> serializedMessage) {
    final bytes = List<int>.from(serializedMessage, growable: false);
    if (bytes.isEmpty ||
        bytes[0] != SolanaTransactionConstant.versionPrefixV1) {
      throw const BuError(
        DefaultErrorType.invalidArgument,
        'Expected v1 version byte 0x81.',
      );
    }
    var offset = 1;
    int need(int n) {
      if (offset + n > bytes.length) {
        throw const BuError(
          DefaultErrorType.invalidLength,
          'Truncated v1 message.',
        );
      }
      return n;
    }

    need(3);
    final header = MessageHeader(
      numRequiredSignatures: bytes[offset++],
      numReadonlySignedAccounts: bytes[offset++],
      numReadonlyUnsignedAccounts: bytes[offset++],
    );
    if (header.numRequiredSignatures < 1 ||
        header.numReadonlySignedAccounts >= header.numRequiredSignatures) {
      throw const BuError(
        DefaultErrorType.invalidArgument,
        'Invalid v1 message header.',
      );
    }
    need(4);
    final mask = _readU32LE(bytes, offset);
    offset += 4;
    need(SolanaTransactionConstant.publicKeyLength);
    final lifetime = SolAddress.uncheckBytes(
      bytes.sublist(offset, offset + SolanaTransactionConstant.publicKeyLength),
    );
    offset += SolanaTransactionConstant.publicKeyLength;
    need(2);
    final numInstructions = bytes[offset++];
    final numAddresses = bytes[offset++];
    if (numInstructions > SolanaTransactionConstant.maximumInstructions) {
      throw const BuError(
        DefaultErrorType.invalidLength,
        'Max instructions per v1 transaction exceeded.',
      );
    }
    if (numAddresses > SolanaTransactionConstant.maximumAccountKeys) {
      throw const BuError(
        DefaultErrorType.invalidLength,
        'Max static account keys length exceeded.',
      );
    }
    if (numAddresses < 1 ||
        numAddresses <
            header.numRequiredSignatures + header.numReadonlyUnsignedAccounts) {
      throw const BuError(
        DefaultErrorType.invalidAddress,
        'Invalid v1 address count.',
      );
    }
    need(numAddresses * SolanaTransactionConstant.publicKeyLength);
    final accountKeys = <SolAddress>[];
    final seen = <String>{};
    for (var i = 0; i < numAddresses; i++) {
      final key = SolAddress.uncheckBytes(
        bytes.sublist(
          offset,
          offset + SolanaTransactionConstant.publicKeyLength,
        ),
      );
      offset += SolanaTransactionConstant.publicKeyLength;
      if (!seen.add(key.address)) {
        throw const BuError(
          DefaultErrorType.invalidAddress,
          'V1 transaction addresses must not contain duplicates.',
        );
      }
      accountKeys.add(key);
    }
    final words = TransactionV1Config.wordsForMask(mask);
    need(words * 4);
    final config = TransactionV1Config.fromMaskAndValues(
      mask,
      bytes.sublist(offset, offset + words * 4),
    );
    offset += words * 4;
    need(numInstructions * 4);
    final headers = <(int, int, int)>[];
    for (var i = 0; i < numInstructions; i++) {
      final programIndex = bytes[offset++];
      final numAccounts = bytes[offset++];
      final dataLen = _readU16LE(bytes, offset);
      offset += 2;
      if (programIndex >= numAddresses) {
        throw const BuError(
          DefaultErrorType.invalidLength,
          'V1 program index out of range.',
        );
      }
      headers.add((programIndex, numAccounts, dataLen));
    }
    final compiled = <CompiledInstruction>[];
    for (final h in headers) {
      need(h.$2 + h.$3);
      final accounts = bytes.sublist(offset, offset + h.$2);
      offset += h.$2;
      for (final a in accounts) {
        if (a >= numAddresses) {
          throw const BuError(
            DefaultErrorType.invalidLength,
            'V1 account index out of range.',
          );
        }
      }
      final data = bytes.sublist(offset, offset + h.$3);
      offset += h.$3;
      compiled.add(
        CompiledInstruction(
          programIdIndex: h.$1,
          accounts: accounts,
          data: data,
        ),
      );
    }
    if (offset != bytes.length) {
      throw const BuError(
        OnChainErrorType.solanaPlugin,
        'Trailing bytes after v1 message.',
      );
    }
    return MessageV1(
      header: header,
      accountKeys: accountKeys,
      recentBlockhash: lifetime,
      compiledInstructions: compiled,
      config: config,
    );
  }

  /// serialize Message V0 instructions
  static List<int> serializeInstructionsV0(
    List<CompiledInstruction> compiledInstructions,
  ) {
    var serializedLength = 0;
    final serializedInstructions = List<int>.filled(
      SolanaTransactionConstant.packetDataSize,
      0,
    );
    for (final instruction in compiledInstructions) {
      final encodedAccountKeyIndexesLength =
          SolanaTransactionUtils._encodeLength(instruction.accounts.length);
      final encodedDataLength = SolanaTransactionUtils._encodeLength(
        instruction.data.length,
      );
      final instructionLayout = LayoutConst.struct([
        LayoutConst.u8(property: 'programIdIndex'),
        LayoutConst.blob(
          encodedAccountKeyIndexesLength.length,
          property: 'encodedAccountKeyIndexesLength',
        ),
        LayoutConst.array(
          LayoutConst.u8(),
          instruction.accounts.length,
          property: 'accountKeyIndexes',
        ),
        LayoutConst.blob(
          encodedDataLength.length,
          property: 'encodedDataLength',
        ),
        LayoutConst.blob(instruction.data.length, property: 'data'),
      ]);
      final encode = instructionLayout.serialize({
        'programIdIndex': instruction.programIdIndex,
        'encodedAccountKeyIndexesLength': encodedAccountKeyIndexesLength,
        'accountKeyIndexes': instruction.accounts,
        'encodedDataLength': encodedDataLength,
        'data': instruction.data,
      });
      serializedInstructions.setAll(serializedLength, encode);
      serializedLength += encode.length;
    }
    return serializedInstructions.sublist(0, serializedLength);
  }

  /// serialize message V0 to bytes
  static List<int> serializeV0(MessageV0 message) {
    final encodedStaticAccountKeysLength = SolanaTransactionUtils._encodeLength(
      message.accountKeys.length,
    );
    final serializedInstructions = serializeInstructionsV0(
      message.compiledInstructions,
    );
    final encodedInstructionsLength = SolanaTransactionUtils._encodeLength(
      message.compiledInstructions.length,
    );
    final serializedAddressTableLookups = serializeAddressTableLookups(
      message.addressTableLookups,
    );
    final encodedAddressTableLookupsLength =
        SolanaTransactionUtils._encodeLength(
          message.addressTableLookups.length,
        );
    final messageLayout = LayoutConst.struct([
      LayoutConst.u8(property: 'prefix'),
      LayoutConst.struct([
        LayoutConst.u8(property: 'numRequiredSignatures'),
        LayoutConst.u8(property: 'numReadonlySignedAccounts'),
        LayoutConst.u8(property: 'numReadonlyUnsignedAccounts'),
      ], property: 'header'),
      LayoutConst.blob(
        encodedStaticAccountKeysLength.length,
        property: 'staticAccountKeysLength',
      ),
      LayoutConst.array(
        SolanaLayoutUtils.publicKey(),
        message.accountKeys.length,
        property: 'staticAccountKeys',
      ),
      SolanaLayoutUtils.publicKey('recentBlockhash'),
      LayoutConst.blob(
        encodedInstructionsLength.length,
        property: 'instructionsLength',
      ),
      LayoutConst.blob(
        serializedInstructions.length,
        property: 'serializedInstructions',
      ),
      LayoutConst.blob(
        encodedAddressTableLookupsLength.length,
        property: 'addressTableLookupsLength',
      ),
      LayoutConst.blob(
        serializedAddressTableLookups.length,
        property: 'serializedAddressTableLookups',
      ),
    ]);
    const messageVersion0Prefix = 1 << 7;
    return messageLayout.serialize({
      'prefix': messageVersion0Prefix,
      'header': message.header.toJson(),
      'staticAccountKeysLength': encodedStaticAccountKeysLength,
      'staticAccountKeys': message.accountKeys.map((key) => key).toList(),
      'recentBlockhash': message.recentBlockhash,
      'instructionsLength': encodedInstructionsLength,
      'serializedInstructions': serializedInstructions,
      'addressTableLookupsLength': encodedAddressTableLookupsLength,
      'serializedAddressTableLookups': serializedAddressTableLookups,
    });
  }

  /// serialize address table
  static List<int> serializeAddressTableLookups(
    List<AddressTableLookup> addressTableLookups,
  ) {
    int serializedLength = 0;
    final serializedAddressTableLookups = List<int>.filled(
      SolanaTransactionConstant.packetDataSize,
      0,
    );
    for (final lookup in addressTableLookups) {
      final encodedWritableIndexesLength = SolanaTransactionUtils._encodeLength(
        lookup.writableIndexes.length,
      );
      final encodedReadonlyIndexesLength = SolanaTransactionUtils._encodeLength(
        lookup.readonlyIndexes.length,
      );

      final addressTableLookupLayout = LayoutConst.struct([
        SolanaLayoutUtils.publicKey('accountKey'),
        LayoutConst.blob(
          encodedWritableIndexesLength.length,
          property: 'encodedWritableIndexesLength',
        ),
        LayoutConst.array(
          LayoutConst.u8(),
          lookup.writableIndexes.length,
          property: 'writableIndexes',
        ),
        LayoutConst.blob(
          encodedReadonlyIndexesLength.length,
          property: 'encodedReadonlyIndexesLength',
        ),
        LayoutConst.array(
          LayoutConst.u8(),
          lookup.readonlyIndexes.length,
          property: 'readonlyIndexes',
        ),
      ]);
      final encode = addressTableLookupLayout.serialize({
        'accountKey': lookup.accountKey,
        'encodedWritableIndexesLength': encodedWritableIndexesLength,
        'writableIndexes': lookup.writableIndexes,
        'encodedReadonlyIndexesLength': encodedReadonlyIndexesLength,
        'readonlyIndexes': lookup.readonlyIndexes,
      });
      serializedAddressTableLookups.setAll(serializedLength, encode);
      serializedLength += encode.length;
    }
    return serializedAddressTableLookups.sublist(0, serializedLength);
  }

  /// convert bytes to Message V0
  static MessageV0 deserializeV0(List<int> serializedMessage) {
    final List<int> byteArray = List<int>.from(
      serializedMessage,
      growable: true,
    );
    final prefix = byteArray.removeAt(0);
    final maskedPrefix = prefix & SolanaTransactionConstant.versionPrefixMask;
    if (prefix == maskedPrefix) {
      throw const BuError(
        DefaultErrorType.invalidArgument,
        'Expected versioned message but received legacy message.',
      );
    }
    final version = maskedPrefix;
    if (version != 0) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'Expected versioned message with version 0 but found version $version.',
      );
    }
    final MessageHeader header = MessageHeader(
      numRequiredSignatures: byteArray.removeAt(0),
      numReadonlySignedAccounts: byteArray.removeAt(0),
      numReadonlyUnsignedAccounts: byteArray.removeAt(0),
    );

    final staticAccountKeys = <SolAddress>[];
    final staticAccountKeysLength = SolanaTransactionUtils._decodeLength(
      byteArray,
    );
    for (var i = 0; i < staticAccountKeysLength; i++) {
      staticAccountKeys.add(
        SolAddress.uncheckBytes(
          byteArray.sublist(0, SolanaTransactionConstant.publicKeyLength),
        ),
      );
      byteArray.removeRange(0, SolanaTransactionConstant.publicKeyLength);
    }
    final recentBlockhash = SolAddress.uncheckBytes(
      byteArray.sublist(0, SolanaTransactionConstant.publicKeyLength),
    );
    byteArray.removeRange(0, SolanaTransactionConstant.publicKeyLength);
    final instructionCount = SolanaTransactionUtils._decodeLength(byteArray);
    final compiledInstructions = <CompiledInstruction>[];
    for (var i = 0; i < instructionCount; i++) {
      final programIdIndex = byteArray.removeAt(0);
      final accountKeyIndexesLength = SolanaTransactionUtils._decodeLength(
        byteArray,
      );
      final accountKeyIndexes = byteArray.sublist(0, accountKeyIndexesLength);
      byteArray.removeRange(0, accountKeyIndexesLength);
      final dataLength = SolanaTransactionUtils._decodeLength(byteArray);
      final data = byteArray.sublist(0, dataLength);
      byteArray.removeRange(0, dataLength);
      compiledInstructions.add(
        CompiledInstruction(
          programIdIndex: programIdIndex,
          accounts: accountKeyIndexes,
          data: data,
        ),
      );
    }
    final addressTableLookupsCount = SolanaTransactionUtils._decodeLength(
      byteArray,
    );
    final addressTableLookups = <AddressTableLookup>[];
    for (int i = 0; i < addressTableLookupsCount; i++) {
      final accountKey = SolAddress.uncheckBytes(
        byteArray.sublist(0, SolanaTransactionConstant.publicKeyLength),
      );
      byteArray.removeRange(0, SolanaTransactionConstant.publicKeyLength);
      final writableIndexesLength = SolanaTransactionUtils._decodeLength(
        byteArray,
      );
      final writableIndexes = byteArray.sublist(0, writableIndexesLength);
      byteArray.removeRange(0, writableIndexesLength);
      final readonlyIndexesLength = SolanaTransactionUtils._decodeLength(
        byteArray,
      );
      final readonlyIndexes = byteArray.sublist(0, readonlyIndexesLength);
      byteArray.removeRange(0, readonlyIndexesLength);
      addressTableLookups.add(
        AddressTableLookup(
          accountKey: accountKey,
          writableIndexes: writableIndexes,
          readonlyIndexes: readonlyIndexes,
        ),
      );
    }
    return MessageV0(
      header: header,
      accountKeys: staticAccountKeys,
      recentBlockhash: recentBlockhash,
      compiledInstructions: compiledInstructions,
      addressTableLookups: addressTableLookups,
    );
  }

  /// convert bytes to Message
  static (VersionedMessage, List<List<int>>) deserializeTransaction(
    List<int> serializedTransaction,
  ) {
    if (serializedTransaction.isNotEmpty &&
        serializedTransaction[0] == SolanaTransactionConstant.versionPrefixV1) {
      final messageLength = v1MessageLength(serializedTransaction);
      final message = MessageV1.fromBuffer(
        serializedTransaction.sublist(0, messageLength),
      );
      final sigBytes = serializedTransaction.sublist(messageLength);
      if (sigBytes.length !=
          message.header.numRequiredSignatures *
              SolanaTransactionConstant.signatureLengthInBytes) {
        throw const BuError(
          DefaultErrorType.invalidLength,
          'Invalid v1 signatures length.',
        );
      }
      final v1Signatures = <List<int>>[];
      for (var i = 0; i < message.header.numRequiredSignatures; i++) {
        v1Signatures.add(
          sigBytes.sublist(
            i * SolanaTransactionConstant.signatureLengthInBytes,
            (i + 1) * SolanaTransactionConstant.signatureLengthInBytes,
          ),
        );
      }
      return (message, v1Signatures);
    }
    final List<int> byteArray = [...serializedTransaction];
    final List<List<int>> signatures = [];
    final int signaturesLength = _decodeLength(byteArray);
    for (int i = 0; i < signaturesLength; i++) {
      final int offset = i * SolanaTransactionConstant.signatureLengthInBytes;
      signatures.add(
        byteArray.sublist(
          offset,
          offset + SolanaTransactionConstant.signatureLengthInBytes,
        ),
      );
    }
    final message = VersionedMessage.fromBuffer(
      byteArray.sublist(
        signatures.length * SolanaTransactionConstant.signatureLengthInBytes,
      ),
    );
    return (message, signatures);
  }

  /// serialize legacy Message to bytes
  static List<int> serializeLegacy(Message message) {
    final numKeys = message.accountKeys.length;
    final keyCount = SolanaTransactionUtils._encodeLength(numKeys);
    final List<Map<String, dynamic>> instructions =
        message.compiledInstructions.map((instruction) {
          final accounts = instruction.accounts;
          final programIdIndex = instruction.programIdIndex;
          final data = List<int>.from(instruction.data);
          final keyIndicesCount = SolanaTransactionUtils._encodeLength(
            accounts.length,
          );
          final dataCount = SolanaTransactionUtils._encodeLength(data.length);

          return {
            'programIdIndex': programIdIndex,
            'keyIndicesCount': keyIndicesCount,
            'keyIndices': accounts,
            'dataLength': dataCount,
            'data': data,
          };
        }).toList();

    final instructionCount = SolanaTransactionUtils._encodeLength(
      instructions.length,
    );
    List<int> instructionBuffer = List<int>.filled(
      SolanaTransactionConstant.packetDataSize,
      0,
    );
    instructionBuffer.setAll(0, instructionCount);
    int instructionBufferLength = instructionCount.length;
    for (final instruction in instructions) {
      final instructionLayout = LayoutConst.struct([
        LayoutConst.u8(property: 'programIdIndex'),
        LayoutConst.blob(
          (instruction['keyIndicesCount'] as List).length,
          property: 'keyIndicesCount',
        ),
        LayoutConst.array(
          LayoutConst.u8(property: 'keyIndex'),
          (instruction['keyIndices'] as List).length,
          property: 'keyIndices',
        ),
        LayoutConst.blob(
          (instruction['dataLength'] as List).length,
          property: 'dataLength',
        ),
        LayoutConst.array(
          LayoutConst.u8(property: 'userdatum'),
          (instruction['data'] as List).length,
          property: 'data',
        ),
      ]);

      final encode = instructionLayout.serialize(instruction);
      instructionBuffer.setAll(instructionBufferLength, encode);
      instructionBufferLength += encode.length;
    }
    instructionBuffer = instructionBuffer.sublist(0, instructionBufferLength);
    final signDataLayout = LayoutConst.struct([
      LayoutConst.blob(1, property: 'numRequiredSignatures'),
      LayoutConst.blob(1, property: 'numReadonlySignedAccounts'),
      LayoutConst.blob(1, property: 'numReadonlyUnsignedAccounts'),
      LayoutConst.blob(keyCount.length, property: 'keyCount'),
      LayoutConst.array(
        LayoutConst.blob(32, property: 'key'),
        numKeys,
        property: 'keys',
      ),
      LayoutConst.blob(32, property: 'recentBlockhash'),
    ]);
    final transaction = {
      'numRequiredSignatures': <int>[message.header.numRequiredSignatures],
      'numReadonlySignedAccounts': <int>[
        message.header.numReadonlySignedAccounts,
      ],
      'numReadonlyUnsignedAccounts': <int>[
        message.header.numReadonlyUnsignedAccounts,
      ],
      'keyCount': keyCount,
      'keys': message.accountKeys.map((key) => key.toBytes()).toList(),
      'recentBlockhash': message.recentBlockhash.toBytes(),
    };
    final List<int> signedData = List<int>.filled(2048, 0);
    // final signData = LayoutByteWriter.filled(2048);
    final encode = signDataLayout.serialize(transaction);
    signedData.setAll(0, encode);
    signedData.setAll(encode.length, instructionBuffer);
    // signData.setAll(length, instructionBuffer.toBytes());

    return signedData.sublist(0, encode.length + instructionBufferLength);
  }

  /// convert Bytes to legacy message
  static Message deserializeMessageLegacy(List<int> bytes) {
    List<int> byteArray = List<int>.from(bytes);
    final int numRequiredSignatures = byteArray.removeAt(0);
    if (numRequiredSignatures !=
        (numRequiredSignatures & SolanaTransactionConstant.versionPrefixMask)) {
      throw const BuError(
        DefaultErrorType.invalidArgument,
        'Invalid versioned Message.',
      );
    }
    final int numReadonlySignedAccounts = byteArray.removeAt(0);
    final int numReadonlyUnsignedAccounts = byteArray.removeAt(0);
    final int accountCount = SolanaTransactionUtils._decodeLength(byteArray);
    final List<SolAddress> accountKeys = [];
    for (int i = 0; i < accountCount; i++) {
      final List<int> account = byteArray.sublist(
        0,
        SolanaTransactionConstant.publicKeyLength,
      );
      byteArray = byteArray.sublist(SolanaTransactionConstant.publicKeyLength);
      accountKeys.add(SolAddress.uncheckBytes(account));
    }
    final List<int> recentBlockhash = byteArray.sublist(
      0,
      SolanaTransactionConstant.publicKeyLength,
    );
    byteArray = byteArray.sublist(SolanaTransactionConstant.publicKeyLength);
    final int instructionCount = SolanaTransactionUtils._decodeLength(
      byteArray,
    );
    final List<CompiledInstruction> instructions = [];
    for (int i = 0; i < instructionCount; i++) {
      final int programIdIndex = byteArray.removeAt(0);
      final int accountCount = SolanaTransactionUtils._decodeLength(byteArray);
      final List<int> accounts = byteArray.sublist(0, accountCount);
      byteArray = byteArray.sublist(accountCount);
      final int dataLength = SolanaTransactionUtils._decodeLength(byteArray);
      final List<int> data = byteArray.sublist(0, dataLength);
      byteArray = byteArray.sublist(dataLength);
      instructions.add(
        CompiledInstruction(
          programIdIndex: programIdIndex,
          accounts: accounts,
          data: data,
        ),
      );
    }
    return Message(
      accountKeys: accountKeys,
      compiledInstructions: instructions,
      recentBlockhash: SolAddress.uncheckBytes(recentBlockhash),
      header: MessageHeader(
        numRequiredSignatures: numRequiredSignatures,
        numReadonlySignedAccounts: numReadonlySignedAccounts,
        numReadonlyUnsignedAccounts: numReadonlyUnsignedAccounts,
      ),
    );
  }

  /// compile instructions to legacy message
  static Message compileLegacy({
    required List<TransactionInstruction> transactionInstructions,
    required SolAddress payer,
    required SolAddress recentBlockhash,
  }) {
    final compiledKeys = CompiledKeys.compile(transactionInstructions, payer);
    final componets = compiledKeys.getMessageComponents();
    final header = componets.$1;
    final staticAccountKeys = componets.$2;
    final accountKeys = MessageAccountKeys(staticAccountKeys, null);
    final instructions =
        accountKeys.compileInstructions(transactionInstructions).map((ix) {
          return CompiledInstruction(
            programIdIndex: ix.programIdIndex,
            accounts: ix.accounts,
            data: ix.data,
          );
        }).toList();
    return Message(
      header: header,
      accountKeys: staticAccountKeys,
      recentBlockhash: recentBlockhash,
      compiledInstructions: instructions,
    );
  }

  /// serialize transaction to bytes. v1 puts signatures at the tail with no
  /// length prefix; legacy/v0 put a compact-u16 count + signatures at head.
  static List<int> serializeTransaction(
    VersionedMessage message,
    List<List<int>> signatures,
  ) {
    if (message is MessageV1) {
      if (signatures.length != message.header.numRequiredSignatures) {
        throw const BuError(
          DefaultErrorType.invalidArgument,
          'Signature count must match v1 required signatures.',
        );
      }
      final serializedMessage = message.serialize();
      final out = List<int>.from(serializedMessage);
      for (final sig in signatures) {
        if (sig.length != SolanaTransactionConstant.signatureLengthInBytes) {
          throw const BuError(
            DefaultErrorType.invalidLength,
            'Signature must be 64 bytes long.',
          );
        }
        out.addAll(sig);
      }
      if (out.length > SolanaTransactionConstant.packetDataSizeV1) {
        throw const BuError(
          DefaultErrorType.invalidLength,
          'Max v1 transaction size exceeded.',
        );
      }
      return out;
    }
    final serializedMessage = message.serialize();
    final encodedSignaturesLength = SolanaTransactionUtils._encodeLength(
      signatures.length,
    );

    final transactionLayout = LayoutConst.struct([
      LayoutConst.blob(
        encodedSignaturesLength.length,
        property: 'encodedSignaturesLength',
      ),
      LayoutConst.array(
        LayoutConst.blob(64, property: 'signature'),
        signatures.length,
        property: 'signatures',
      ),
      LayoutConst.blob(serializedMessage.length, property: 'serializedMessage'),
    ]);
    return transactionLayout.serialize({
      'encodedSignaturesLength': encodedSignaturesLength,
      'signatures': signatures,
      'serializedMessage': serializedMessage,
    });
  }
}
