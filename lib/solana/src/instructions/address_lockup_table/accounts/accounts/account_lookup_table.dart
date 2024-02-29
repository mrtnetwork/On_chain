import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/address_lockup_table/constant.dart';
import 'package:on_chain/solana/src/layout/layout.dart';
import 'package:on_chain/solana/src/transaction/constant/solana_transaction_constant.dart';

/// Utility class for handling address lookup table accounts.
class _Utils {
  /// Maximum value for a 64-bit unsigned integer.
  static final BigInt u64Max = BigInt.parse('0xffffffffffffffff');

  /// Layout definition for the lookup table metadata.
  static Structure lookupTableMetaLayout = LayoutUtils.struct([
    LayoutUtils.u32("typeIndex"),
    LayoutUtils.u64("deactivationSlot"),
    LayoutUtils.u64("lastExtendedSlot"),
    LayoutUtils.u8("lastExtendedStartIndex"),
    LayoutUtils.u8(),
    LayoutUtils.seq(LayoutUtils.publicKey("publicKey"),
        LayoutUtils.offset(LayoutUtils.u8(), -1),
        property: "authority")
  ]);

  /// Create a layout for the addresses based on the number of serialized addresses.
  static Layout addressesLayout(int numSerializedAddresses) {
    return LayoutUtils.struct([
      LayoutUtils.array(
          LayoutUtils.publicKey("publicKey"), numSerializedAddresses,
          property: 'addresses')
    ]);
  }

  /// Decode the account data into a structured map.
  static Map<String, dynamic> decode(List<int> accountData) {
    final meta = lookupTableMetaLayout.decode(accountData);
    final serializedAddressesLen =
        accountData.length - AddressLookupTableProgramConst.lockupTableMetaSize;
    if (serializedAddressesLen < 0 ||
        serializedAddressesLen % SolanaTransactionConstant.publicKeyLength !=
            0) {
      throw MessageException("Lookup table is invalid");
    }
    final numSerializedAddresses =
        serializedAddressesLen ~/ SolanaTransactionConstant.publicKeyLength;
    final addressLayout = addressesLayout(numSerializedAddresses);
    final decodeAddresses = addressLayout.decode(accountData
        .sublist(AddressLookupTableProgramConst.lockupTableMetaSize));
    final List<SolAddress> authority = (meta['authority'] as List).cast();
    return {
      'deactivationSlot': meta['deactivationSlot'],
      'lastExtendedSlot': meta['lastExtendedSlot'],
      'lastExtendedSlotStartIndex': meta['lastExtendedStartIndex'],
      'authority': authority.isNotEmpty ? authority.first : null,
      'addresses':
          (decodeAddresses["addresses"] as List<dynamic>).cast<SolAddress>(),
    };
  }
}

/// Class representing an address lookup table account.
class AddressLookupTableAccount {
  final SolAddress key;

  final BigInt deactivationSlot;
  final BigInt lastExtendedSlot;
  final int lastExtendedStartIndex;
  final SolAddress? authority;
  final List<SolAddress> addresses;

  AddressLookupTableAccount({
    required this.key,
    required this.deactivationSlot,
    required this.lastExtendedSlot,
    required this.lastExtendedStartIndex,
    required this.authority,
    required List<SolAddress> addresses,
  }) : addresses = List<SolAddress>.unmodifiable(addresses);

  /// Check if the account is active based on the deactivation slot.
  bool isActive() {
    return deactivationSlot == _Utils.u64Max;
  }

  /// Factory method to create an AddressLookupTableAccount instance from buffer data.
  factory AddressLookupTableAccount.fromBuffer({
    required SolAddress accountKey,
    required List<int> accountData,
  }) {
    final decode = _Utils.decode(accountData);
    return AddressLookupTableAccount(
      key: accountKey,
      addresses: decode["addresses"],
      authority: decode["authority"],
      deactivationSlot: decode["deactivationSlot"],
      lastExtendedSlot: decode["lastExtendedSlot"],
      lastExtendedStartIndex: decode["lastExtendedSlotStartIndex"],
    );
  }
}
