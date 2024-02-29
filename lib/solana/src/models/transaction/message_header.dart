import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/models/models.dart';

/// The message header, identifying signed and read-only account.
class MessageHeader {
  /// The number of signatures required for this message to be considered valid. The
  /// signatures must match the first [numRequiredSignatures] of [accountKeys].
  final int numRequiredSignatures;

  /// The last [numReadonlySignedAccounts] of the signed keys are read-only accounts
  final int numReadonlySignedAccounts;

  /// The last [numReadonlySignedAccounts] of the unsigned keys are read-only accounts.
  final int numReadonlyUnsignedAccounts;

  /// Constructor to create a MessageHeader instance.
  const MessageHeader({
    required this.numRequiredSignatures,
    required this.numReadonlySignedAccounts,
    required this.numReadonlyUnsignedAccounts,
  });

  /// Factory method to create a MessageHeader instance from JSON.
  factory MessageHeader.fromJson(Map<String, dynamic> json) {
    return MessageHeader(
      numRequiredSignatures: json['numRequiredSignatures'],
      numReadonlySignedAccounts: json['numReadonlySignedAccounts'],
      numReadonlyUnsignedAccounts: json['numReadonlyUnsignedAccounts'],
    );
  }

  /// Convert the MessageHeader instance to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'numRequiredSignatures': numRequiredSignatures,
      'numReadonlySignedAccounts': numReadonlySignedAccounts,
      'numReadonlyUnsignedAccounts': numReadonlyUnsignedAccounts,
    };
  }

  bool isAccountSigner(int index) {
    return index < numRequiredSignatures;
  }

  bool isAccountWritable(
      {required int index,
      required int numStaticAccountKeys,
      List<AddressTableLookup> addressTableLookups = const []}) {
    if (index >= numStaticAccountKeys) {
      if (addressTableLookups.isEmpty) {
        throw MessageException(
            "Invalid index. The index must be lower than numStaticAccountKeys.");
      }
      final lookupAccountKeysIndex = index - numStaticAccountKeys;
      final numWritableLookupAccountKeys = addressTableLookups.fold<int>(
          0, (count, lookup) => count + lookup.writableIndexes.length);
      return lookupAccountKeysIndex < numWritableLookupAccountKeys;
    } else if (index >= numRequiredSignatures) {
      final unsignedAccountIndex = index - numRequiredSignatures;
      final numUnsignedAccounts = numStaticAccountKeys - numRequiredSignatures;
      final numWritableUnsignedAccounts =
          numUnsignedAccounts - numReadonlyUnsignedAccounts;
      return unsignedAccountIndex < numWritableUnsignedAccounts;
    } else {
      final numWritableSignedAccounts =
          numRequiredSignatures - numReadonlySignedAccounts;
      return index < numWritableSignedAccounts;
    }
  }

  /// Override the toString method to provide a string representation of the object.
  @override
  String toString() {
    return "MessageHeader${toJson()}";
  }
}
