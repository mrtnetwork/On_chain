import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/solana/src/instructions/address_lockup_table/accounts/accounts/account_lookup_table.dart';
import 'package:on_chain/solana/src/models/models.dart';
import 'package:on_chain/solana/src/transaction/core/core.dart';
import 'package:on_chain/solana/src/transaction/message/transaction_v1_config.dart';
import 'package:on_chain/solana/src/transaction/utils/utils.dart';

/// v1 Solana message (SIMD-0385).
///
/// Wire layout (SIMD-0385):
/// `0x81 | header(3) | configMask(u32 LE) | lifetime(32) | numIx(u8) |
/// numAddresses(u8) | addresses[N*32] | configValues | ixHeaders |
/// ixPayloads`. Signatures live at the transaction tail (not counted here).
/// No address lookup tables; addresses must be unique inline (max 64).
class MessageV1 implements VersionedMessage {
  @override
  final MessageHeader header;

  /// All account addresses inline (static, max 64, no duplicates).
  @override
  final List<SolAddress> accountKeys;

  /// Lifetime specifier (recent blockhash or nonce), 32 bytes.
  @override
  final SolAddress recentBlockhash;

  @override
  final List<CompiledInstruction> compiledInstructions;

  /// Resource configuration (fee + limits). Empty means all-zero except heap.
  final TransactionV1Config config;

  const MessageV1({
    required this.header,
    required this.accountKeys,
    required this.recentBlockhash,
    required this.compiledInstructions,
    this.config = const TransactionV1Config.empty(),
  });

  @override
  MessageV1 copyWith({
    MessageHeader? header,
    List<SolAddress>? accountKeys,
    SolAddress? recentBlockhash,
    List<CompiledInstruction>? compiledInstructions,
    List<AddressTableLookup>? addressTableLookups,
    TransactionV1Config? config,
  }) {
    if (addressTableLookups != null && addressTableLookups.isNotEmpty) {
      throw const BuError(
        DefaultErrorType.unsupported,
        'V1 transactions do not support address lookup tables.',
      );
    }
    return MessageV1(
      header: header ?? this.header,
      accountKeys: accountKeys ?? this.accountKeys,
      recentBlockhash: recentBlockhash ?? this.recentBlockhash,
      compiledInstructions: compiledInstructions ?? this.compiledInstructions,
      config: config ?? this.config,
    );
  }

  /// Compiles a v1 message from uncompiled instructions.
  factory MessageV1.compile({
    required List<TransactionInstruction> transactionInstructions,
    required SolAddress payer,
    required SolAddress recentBlockhash,
    TransactionV1Config config = const TransactionV1Config.empty(),
  }) {
    return SolanaTransactionUtils.compileV1(
      transactionInstructions: transactionInstructions,
      payer: payer,
      recentBlockhash: recentBlockhash,
      config: config,
    );
  }

  /// Constructs a v1 message from a serialized message buffer.
  factory MessageV1.fromBuffer(List<int> serializedMessage) {
    return SolanaTransactionUtils.deserializeV1(serializedMessage);
  }

  @override
  TransactionType get version => TransactionType.v1;

  @override
  MessageAccountKeys getAccounts({
    List<AddressLookupTableAccount> addressLookupTableAccounts = const [],
    AccountLookupKeys? lookupKeys,
  }) {
    if (addressLookupTableAccounts.isNotEmpty) {
      throw const BuError(
        DefaultErrorType.unsupported,
        'V1 transactions do not support address lookup tables.',
      );
    }
    if (lookupKeys != null) {
      throw const BuError(
        OnChainErrorType.solanaPlugin,
        'V1 transactions do not use lookup keys.',
      );
    }
    return MessageAccountKeys(List.unmodifiable(accountKeys), null);
  }

  @override
  bool isAccountSigner(int index) => header.isAccountSigner(index);

  @override
  bool isAccountWritable(int index) => header.isAccountWritable(
    index: index,
    numStaticAccountKeys: accountKeys.length,
    addressTableLookups: const [],
  );

  @override
  List<int> serialize() {
    return SolanaTransactionUtils.serializeV1(this);
  }
}
