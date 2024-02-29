import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';
import 'package:on_chain/solana/src/models/models.dart';
import 'package:on_chain/solana/src/transaction/constant/solana_transaction_constant.dart';
import 'package:on_chain/solana/src/transaction/core/core.dart';
import 'package:on_chain/solana/src/transaction/message/legacy.dart';
import 'package:on_chain/solana/src/transaction/message/message_v0.dart';

class SolanaTransactionUtils {
  /// encode int to bytes
  static List<int> _encodeLength(int len) {
    List<int> bytes = [];
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
      int elem = bytes.removeAt(0);
      len |= (elem & 0x7f) << size * 7;
      size += 1;
      if ((elem & 0x80) == 0) {
        break;
      }
    }
    return len;
  }

  /// compile V0 Message
  static MessageV0 compileV0(
      {required List<TransactionInstruction> transactionInstructions,
      required SolAddress payer,
      required SolAddress recentBlockhash,
      List<AddressLookupTableAccount> lookupTableAccounts = const []}) {
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
    final header = componets.item1;
    final staticAccountKeys = componets.item2;
    final accountKeys = MessageAccountKeys(staticAccountKeys,
        AccountLookupKeys(readonly: readonly, writable: writable));
    final compiledInstructions =
        accountKeys.compileInstructions(transactionInstructions);
    return MessageV0(
      header: header,
      accountKeys: staticAccountKeys,
      recentBlockhash: recentBlockhash,
      compiledInstructions: compiledInstructions,
      addressTableLookups: addressTableLookups,
    );
  }

  /// serialize Message V0 instructions
  static List<int> serializeInstructionsV0(
      List<CompiledInstruction> compiledInstructions) {
    var serializedLength = 0;
    final serializedInstructions =
        LayoutByteWriter.filled(SolanaTransactionConstant.packetDataSize, 0);
    for (var instruction in compiledInstructions) {
      final encodedAccountKeyIndexesLength =
          SolanaTransactionUtils._encodeLength(instruction.accounts.length);
      final encodedDataLength =
          SolanaTransactionUtils._encodeLength(instruction.data.length);
      final instructionLayout = LayoutUtils.struct([
        LayoutUtils.u8('programIdIndex'),
        LayoutUtils.blob(encodedAccountKeyIndexesLength.length,
            property: 'encodedAccountKeyIndexesLength'),
        LayoutUtils.array(LayoutUtils.u8(), instruction.accounts.length,
            property: 'accountKeyIndexes'),
        LayoutUtils.blob(encodedDataLength.length,
            property: 'encodedDataLength'),
        LayoutUtils.blob(instruction.data.length, property: 'data')
      ]);
      serializedLength += instructionLayout.encode({
        'programIdIndex': instruction.programIdIndex,
        'encodedAccountKeyIndexesLength': encodedAccountKeyIndexesLength,
        'accountKeyIndexes': instruction.accounts,
        'encodedDataLength': encodedDataLength,
        'data': instruction.data
      }, serializedInstructions, offset: serializedLength);
    }
    return serializedInstructions.toBytes().sublist(0, serializedLength);
  }

  /// serialize message V0 to bytes
  static List<int> serializeV0(MessageV0 message) {
    final encodedStaticAccountKeysLength =
        SolanaTransactionUtils._encodeLength(message.accountKeys.length);
    final serializedInstructions =
        serializeInstructionsV0(message.compiledInstructions);
    final encodedInstructionsLength = SolanaTransactionUtils._encodeLength(
        message.compiledInstructions.length);
    final serializedAddressTableLookups =
        serializeAddressTableLookups(message.addressTableLookups);
    final encodedAddressTableLookupsLength =
        SolanaTransactionUtils._encodeLength(
            message.addressTableLookups.length);
    final messageLayout = LayoutUtils.struct([
      LayoutUtils.u8('prefix'),
      LayoutUtils.struct([
        LayoutUtils.u8('numRequiredSignatures'),
        LayoutUtils.u8('numReadonlySignedAccounts'),
        LayoutUtils.u8('numReadonlyUnsignedAccounts')
      ], 'header'),
      LayoutUtils.blob(encodedStaticAccountKeysLength.length,
          property: 'staticAccountKeysLength'),
      LayoutUtils.array(LayoutUtils.publicKey(), message.accountKeys.length,
          property: 'staticAccountKeys'),
      LayoutUtils.publicKey('recentBlockhash'),
      LayoutUtils.blob(encodedInstructionsLength.length,
          property: 'instructionsLength'),
      LayoutUtils.blob(serializedInstructions.length,
          property: 'serializedInstructions'),
      LayoutUtils.blob(encodedAddressTableLookupsLength.length,
          property: 'addressTableLookupsLength'),
      LayoutUtils.blob(serializedAddressTableLookups.length,
          property: 'serializedAddressTableLookups')
    ]);
    final serializedMessage =
        LayoutByteWriter.filled(SolanaTransactionConstant.packetDataSize, 0);
    const messageVersion0Prefix = 1 << 7;
    final serializedMessageLength = messageLayout.encode({
      'prefix': messageVersion0Prefix,
      'header': message.header.toJson(),
      'staticAccountKeysLength': encodedStaticAccountKeysLength,
      'staticAccountKeys': message.accountKeys.map((key) => key).toList(),
      'recentBlockhash': message.recentBlockhash,
      'instructionsLength': encodedInstructionsLength,
      'serializedInstructions': serializedInstructions,
      'addressTableLookupsLength': encodedAddressTableLookupsLength,
      'serializedAddressTableLookups': serializedAddressTableLookups
    }, serializedMessage);
    return serializedMessage.toBytes().sublist(0, serializedMessageLength);
  }

  /// serialize address table
  static List<int> serializeAddressTableLookups(
      List<AddressTableLookup> addressTableLookups) {
    var serializedLength = 0;
    final serializedAddressTableLookups =
        LayoutByteWriter.filled(SolanaTransactionConstant.packetDataSize, 0);
    for (var lookup in addressTableLookups) {
      final encodedWritableIndexesLength =
          SolanaTransactionUtils._encodeLength(lookup.writableIndexes.length);
      final encodedReadonlyIndexesLength =
          SolanaTransactionUtils._encodeLength(lookup.readonlyIndexes.length);

      final addressTableLookupLayout = LayoutUtils.struct([
        LayoutUtils.publicKey('accountKey'),
        LayoutUtils.blob(encodedWritableIndexesLength.length,
            property: 'encodedWritableIndexesLength'),
        LayoutUtils.array(LayoutUtils.u8(), lookup.writableIndexes.length,
            property: 'writableIndexes'),
        LayoutUtils.blob(encodedReadonlyIndexesLength.length,
            property: 'encodedReadonlyIndexesLength'),
        LayoutUtils.array(LayoutUtils.u8(), lookup.readonlyIndexes.length,
            property: 'readonlyIndexes')
      ]);
      serializedLength += addressTableLookupLayout.encode({
        'accountKey': lookup.accountKey,
        'encodedWritableIndexesLength': encodedWritableIndexesLength,
        'writableIndexes': lookup.writableIndexes,
        'encodedReadonlyIndexesLength': encodedReadonlyIndexesLength,
        'readonlyIndexes': lookup.readonlyIndexes
      }, serializedAddressTableLookups, offset: serializedLength);
    }
    return serializedAddressTableLookups.toBytes().sublist(0, serializedLength);
  }

  /// convert bytes to Message V0
  static MessageV0 deserializeV0(List<int> serializedMessage) {
    List<int> byteArray = List<int>.from(serializedMessage, growable: true);
    final prefix = byteArray.removeAt(0);
    final maskedPrefix = prefix & SolanaTransactionConstant.versionPrefixMask;
    assert(prefix != maskedPrefix,
        'Expected versioned message but received legacy message');
    final version = maskedPrefix;
    assert(version == 0,
        'Expected versioned message with version 0 but found version $version');
    final MessageHeader header = MessageHeader(
        numRequiredSignatures: byteArray.removeAt(0),
        numReadonlySignedAccounts: byteArray.removeAt(0),
        numReadonlyUnsignedAccounts: byteArray.removeAt(0));

    final staticAccountKeys = <SolAddress>[];
    final staticAccountKeysLength =
        SolanaTransactionUtils._decodeLength(byteArray);
    for (var i = 0; i < staticAccountKeysLength; i++) {
      staticAccountKeys.add(SolAddress.uncheckBytes(
          byteArray.sublist(0, SolanaTransactionConstant.publicKeyLength)));
      byteArray.removeRange(0, SolanaTransactionConstant.publicKeyLength);
    }
    final recentBlockhash = SolAddress.uncheckBytes(
        byteArray.sublist(0, SolanaTransactionConstant.publicKeyLength));
    byteArray.removeRange(0, SolanaTransactionConstant.publicKeyLength);
    final instructionCount = SolanaTransactionUtils._decodeLength(byteArray);
    final compiledInstructions = <CompiledInstruction>[];
    for (var i = 0; i < instructionCount; i++) {
      final programIdIndex = byteArray.removeAt(0);
      final accountKeyIndexesLength =
          SolanaTransactionUtils._decodeLength(byteArray);
      final accountKeyIndexes = byteArray.sublist(0, accountKeyIndexesLength);
      byteArray.removeRange(0, accountKeyIndexesLength);
      final dataLength = SolanaTransactionUtils._decodeLength(byteArray);
      final data = byteArray.sublist(0, dataLength);
      byteArray.removeRange(0, dataLength);
      compiledInstructions.add(CompiledInstruction(
        programIdIndex: programIdIndex,
        accounts: accountKeyIndexes,
        data: data,
      ));
    }
    final addressTableLookupsCount =
        SolanaTransactionUtils._decodeLength(byteArray);
    final addressTableLookups = <AddressTableLookup>[];
    for (int i = 0; i < addressTableLookupsCount; i++) {
      final accountKey = SolAddress.uncheckBytes(
          byteArray.sublist(0, SolanaTransactionConstant.publicKeyLength));
      byteArray.removeRange(0, SolanaTransactionConstant.publicKeyLength);
      final writableIndexesLength =
          SolanaTransactionUtils._decodeLength(byteArray);
      final writableIndexes = byteArray.sublist(0, writableIndexesLength);
      byteArray.removeRange(0, writableIndexesLength);
      final readonlyIndexesLength =
          SolanaTransactionUtils._decodeLength(byteArray);
      final readonlyIndexes = byteArray.sublist(0, readonlyIndexesLength);
      byteArray.removeRange(0, readonlyIndexesLength);
      addressTableLookups.add(AddressTableLookup(
        accountKey: accountKey,
        writableIndexes: writableIndexes,
        readonlyIndexes: readonlyIndexes,
      ));
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
  static Tuple<VersionedMessage, List<List<int>>> deserializeTransaction(
      List<int> serializedTransaction) {
    List<int> byteArray = [...serializedTransaction];
    List<List<int>> signatures = [];
    int signaturesLength = _decodeLength(byteArray);
    for (int i = 0; i < signaturesLength; i++) {
      int offset = i * SolanaTransactionConstant.signatureLengthInBytes;
      signatures.add(byteArray.sublist(
          offset, offset + SolanaTransactionConstant.signatureLengthInBytes));
    }
    final message = VersionedMessage.fromBuffer(byteArray.sublist(
        signatures.length * SolanaTransactionConstant.signatureLengthInBytes));
    return Tuple(message, signatures);
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
      final keyIndicesCount =
          SolanaTransactionUtils._encodeLength(accounts.length);
      final dataCount = SolanaTransactionUtils._encodeLength(data.length);

      return {
        'programIdIndex': programIdIndex,
        'keyIndicesCount': keyIndicesCount,
        'keyIndices': accounts,
        'dataLength': dataCount,
        'data': data,
      };
    }).toList();

    final instructionCount =
        SolanaTransactionUtils._encodeLength(instructions.length);
    LayoutByteWriter instructionBuffer =
        LayoutByteWriter.filled(SolanaTransactionConstant.packetDataSize);
    instructionBuffer.setAll(0, instructionCount);
    int instructionBufferLength = instructionCount.length;
    for (var instruction in instructions) {
      final instructionLayout = LayoutUtils.struct([
        LayoutUtils.u8('programIdIndex'),
        LayoutUtils.blob((instruction['keyIndicesCount'] as List).length,
            property: 'keyIndicesCount'),
        LayoutUtils.array(LayoutUtils.u8('keyIndex'),
            (instruction['keyIndices'] as List).length,
            property: 'keyIndices'),
        LayoutUtils.blob((instruction['dataLength'] as List).length,
            property: 'dataLength'),
        LayoutUtils.array(
            LayoutUtils.u8('userdatum'), (instruction['data'] as List).length,
            property: 'data'),
      ]);

      final length = instructionLayout.encode(instruction, instructionBuffer,
          offset: instructionBufferLength);
      instructionBufferLength += length;
    }
    instructionBuffer = LayoutByteWriter.from(
        instructionBuffer.toBytes().sublist(0, instructionBufferLength));
    final signDataLayout = LayoutUtils.struct([
      LayoutUtils.blob(1, property: 'numRequiredSignatures'),
      LayoutUtils.blob(1, property: 'numReadonlySignedAccounts'),
      LayoutUtils.blob(1, property: 'numReadonlyUnsignedAccounts'),
      LayoutUtils.blob(keyCount.length, property: 'keyCount'),
      LayoutUtils.array(LayoutUtils.blob(32, property: 'key'), numKeys,
          property: 'keys'),
      LayoutUtils.blob(32, property: 'recentBlockhash'),
    ]);
    final transaction = {
      'numRequiredSignatures': <int>[message.header.numRequiredSignatures],
      'numReadonlySignedAccounts': <int>[
        message.header.numReadonlySignedAccounts
      ],
      'numReadonlyUnsignedAccounts': <int>[
        message.header.numReadonlyUnsignedAccounts
      ],
      'keyCount': keyCount,
      'keys': message.accountKeys.map((key) => key.toBytes()).toList(),
      'recentBlockhash': message.recentBlockhash.toBytes(),
    };

    final signData = LayoutByteWriter.filled(2048);
    final length = signDataLayout.encode(transaction, signData);
    signData.setAll(length, instructionBuffer.toBytes());

    return signData.toBytes().sublist(0, length + instructionBufferLength);
  }

  /// convert Bytes to legacy message
  static Message deserializeMessageLegacy(List<int> bytes) {
    List<int> byteArray = List<int>.from(bytes);
    int numRequiredSignatures = byteArray.removeAt(0);
    if (numRequiredSignatures !=
        (numRequiredSignatures & SolanaTransactionConstant.versionPrefixMask)) {
      throw MessageException('invalid versioned Message');
    }
    int numReadonlySignedAccounts = byteArray.removeAt(0);
    int numReadonlyUnsignedAccounts = byteArray.removeAt(0);
    int accountCount = SolanaTransactionUtils._decodeLength(byteArray);
    List<SolAddress> accountKeys = [];
    for (int i = 0; i < accountCount; i++) {
      List<int> account =
          byteArray.sublist(0, SolanaTransactionConstant.publicKeyLength);
      byteArray = byteArray.sublist(SolanaTransactionConstant.publicKeyLength);
      accountKeys.add(SolAddress.uncheckBytes(account));
    }
    List<int> recentBlockhash =
        byteArray.sublist(0, SolanaTransactionConstant.publicKeyLength);
    byteArray = byteArray.sublist(SolanaTransactionConstant.publicKeyLength);
    int instructionCount = SolanaTransactionUtils._decodeLength(byteArray);
    List<CompiledInstruction> instructions = [];
    for (int i = 0; i < instructionCount; i++) {
      int programIdIndex = byteArray.removeAt(0);
      int accountCount = SolanaTransactionUtils._decodeLength(byteArray);
      List<int> accounts = byteArray.sublist(0, accountCount);
      byteArray = byteArray.sublist(accountCount);
      int dataLength = SolanaTransactionUtils._decodeLength(byteArray);
      List<int> data = byteArray.sublist(0, dataLength);
      byteArray = byteArray.sublist(dataLength);
      instructions.add(CompiledInstruction(
          programIdIndex: programIdIndex, accounts: accounts, data: data));
    }
    return Message(
        accountKeys: accountKeys,
        compiledInstructions: instructions,
        recentBlockhash: SolAddress.uncheckBytes(recentBlockhash),
        header: MessageHeader(
            numRequiredSignatures: numRequiredSignatures,
            numReadonlySignedAccounts: numReadonlySignedAccounts,
            numReadonlyUnsignedAccounts: numReadonlyUnsignedAccounts));
  }

  /// compile instructions to legacy message
  static Message compileLegacy({
    required List<TransactionInstruction> transactionInstructions,
    required SolAddress payer,
    required SolAddress recentBlockhash,
  }) {
    final compiledKeys = CompiledKeys.compile(transactionInstructions, payer);
    final componets = compiledKeys.getMessageComponents();
    final header = componets.item1;
    final staticAccountKeys = componets.item2;
    final accountKeys = MessageAccountKeys(staticAccountKeys, null);
    final instructions =
        accountKeys.compileInstructions(transactionInstructions).map((ix) {
      return CompiledInstruction(
          programIdIndex: ix.programIdIndex,
          accounts: ix.accounts,
          data: ix.data);
    }).toList();
    return Message(
      header: header,
      accountKeys: staticAccountKeys,
      recentBlockhash: recentBlockhash,
      compiledInstructions: instructions,
    );
  }

  /// serialize transaction to bytes
  static List<int> serializeTransaction(
      VersionedMessage message, List<List<int>> signatures) {
    final serializedMessage = message.serialize();
    final encodedSignaturesLength =
        SolanaTransactionUtils._encodeLength(signatures.length);

    final transactionLayout = LayoutUtils.struct([
      LayoutUtils.blob(encodedSignaturesLength.length,
          property: 'encodedSignaturesLength'),
      LayoutUtils.array(
          LayoutUtils.blob(64, property: "signature"), signatures.length,
          property: 'signatures'),
      LayoutUtils.blob(serializedMessage.length, property: 'serializedMessage')
    ]);
    final serializedTransaction = LayoutByteWriter.filled(2048);
    final serializedTransactionLength = transactionLayout.encode({
      'encodedSignaturesLength': encodedSignaturesLength,
      'signatures': signatures,
      'serializedMessage': serializedMessage
    }, serializedTransaction);
    return serializedTransaction
        .toBytes()
        .sublist(0, serializedTransactionLength);
  }
}
