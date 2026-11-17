import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/algorand/src/account/account/multi_sig.dart';
import 'package:on_chain/algorand/src/address/address.dart';
import 'package:on_chain/algorand/src/crypto/keypair/public_key/ed25519.dart';
import 'package:on_chain/algorand/src/transaction/src/signatures.dart';
import 'package:on_chain/algorand/src/transaction/src/transaction.dart';
import 'package:on_chain/algorand/src/types/types.dart';
import 'package:on_chain/exception/onchain_error.dart';

class AlgoUtils {
  static const int defaultMultisigAccountVersion = 1;
  static const String multisigAddrPrefix = "MultisigAddr";

  /// Domain-separation prefix for transaction IDs: ASCII "TX".
  /// Prepended to the msgpack-encoded transaction before SHA-512/256.
  static const List<int> txidPrefix = [84, 88]; // "TX"

  /// Domain-separation prefix for signing arbitrary bytes: ASCII "MX".
  static const List<int> bytesPrefix = [77, 88]; // "MX"

  /// Domain-separation prefix for bid (auction) messages: ASCII "aB".
  static const List<int> bidPrefix = [97, 66]; // "aB"

  /// Domain-separation prefix for program data (TEAL args): ASCII "ProgData".
  static const List<int> programDataPrefix = [
    80,
    114,
    111,
    103,
    68,
    97,
    116,
    97,
  ];

  /// Domain-separation prefix for application ID address derivation: ASCII "appID".
  static const List<int> appIDPrefix = [97, 112, 112, 73, 68]; // "appID"

  /// Domain-separation prefix for state-proof messages: ASCII "spm".
  static const List<int> stateProofMessagePrefix = [115, 112, 109]; // "spm"

  /// Domain-separation prefix for light block headers: ASCII "B256".
  static const List<int> lightBlockHeaderPrefix = [66, 50, 53, 54]; // "B256"

  /// Domain-separation prefix for logic-signature program hashing: ASCII "Program".
  static const List<int> programPrefix = [80, 114, 111, 103, 114, 97, 109];

  /// Domain-separation prefix for multi-sig logic programs: ASCII "MsigProgram".
  static const List<int> msigProgramPrefix = [
    77,
    115,
    105,
    103,
    80,
    114,
    111,
    103,
    114,
    97,
    109,
  ];

  /// Domain-separation prefix for transaction group IDs: ASCII "TG".
  static const List<int> tgidPrefix = [84, 71]; // "TG"

  /// Parses [v] into an [AlgoAddress].
  /// Accepts a base32 address string or raw 32-byte public key.
  static AlgoAddress parseAddress(dynamic v) {
    try {
      if (v is String) {
        return AlgoAddress(v);
      }
      return AlgoAddress.fromBytes(v);
    } on BuError {
      rethrow;
    } catch (e) {
      throw OnChainErrors.algoPlugin(
        "parseAddress",
        reason: "Invalid Algorand address.",
        details: {"value": v.toString()},
      );
    }
  }

  /// Parses [v] into an [AlgoAddress], returning [AlgoAddress.zero] on null.
  /// Tries base32 first; on failure treats the string as base64-encoded bytes.
  static AlgoAddress parseAddressOrDefault(dynamic v) {
    if (v == null) return AlgoAddress.zero;

    try {
      if (v is String) {
        try {
          return AlgoAddress(v);
        } on BuError {
          return AlgoAddress.fromBytes(
            StringUtils.encode(v, encoding: StringEncoding.base64),
          );
        }
      }
      return AlgoAddress.fromBytes(v);
    } on BuError {
      rethrow;
    } catch (e) {
      throw OnChainErrors.algoPlugin(
        "parseAddressOrDefault",
        reason: "Invalid Algorand address.",
        details: {"value": v.toString()},
      );
    }
  }

  /// Parses a block hash from a string (optionally prefixed with "blk-") or bytes.
  static List<int> parseBlockHash(dynamic v) {
    try {
      if (v is String) {
        if (v.toLowerCase().startsWith("blk-")) {
          v = v.substring(4);
        }
        return StringUtils.encode(v, encoding: StringEncoding.base64);
      }
      return JsonParser.valueAsBytes(v);
    } catch (_) {
      throw OnChainErrors.algoPlugin(
        "parseBlockHash",
        reason: "Invalid Algorand block hash.",
        details: {"value": v.toString()},
      );
    }
  }

  /// SHA-512/256 hash used throughout Algorand for commitments and IDs.
  static List<int> hashData(List<int> data) {
    return QuickCrypto.sha512256Hash(data);
  }

  /// Derives the 32-byte application address checksum for [applicationId].
  /// Hash of: appIDPrefix || big-endian u64 application ID.
  static List<int> getApplicationChecksum(BigInt applicationId) {
    final idBytes = applicationId.toU64BeBytes();
    return hashData([...AlgoUtils.appIDPrefix, ...idBytes]);
  }

  /// Message to sign for a single-key logic signature (lsig).
  /// Hash of: programPrefix || program bytes.
  static List<int> programToSign(List<int> program) {
    return hashData([...AlgoUtils.programPrefix, ...program]);
  }

  /// Message to sign for a multi-sig logic signature (lmsig).
  /// Hash of: msigProgramPrefix || address bytes || program bytes.
  static List<int> msigProgramToSign(AlgoAddress address, List<int> program) {
    return hashData([
      ...AlgoUtils.msigProgramPrefix,
      ...address.toBytes(),
      ...program,
    ]);
  }

  /// Commitment hash of a state-proof message.
  /// Hash of: stateProofMessagePrefix || msgpack(message).
  static List<int> hashStateProofMessage(AlgoTypesMessage message) {
    final messageBytes = message.toSerializeBytes();
    return hashData([...AlgoUtils.stateProofMessagePrefix, ...messageBytes]);
  }

  /// Commitment hash of a light block header.
  /// Hash of: lightBlockHeaderPrefix || msgpack(message).
  static List<int> hashLightBlockHeader(
    AlgoAddress address,
    AlgoTypesLightBlockHeader message,
  ) {
    final messageBytes = message.toSerializeBytes();
    return hashData([...AlgoUtils.lightBlockHeaderPrefix, ...messageBytes]);
  }

  /// Verifies a logic signature against [address].
  /// Supports single-key (sig), multi-sig (msig), and multi-sig program (lmsig) forms.
  static bool verifyLogicSig(AlgoLogicSig logicSig, AlgoAddress address) {
    if (!logicSig.isValid()) return false;
    final signature = logicSig.signature;
    if (signature != null) {
      final pk = AlgoEd25519PublicKey.tryFromBytes(address.toBytes());
      if (pk == null) return false;
      final message = programToSign(logicSig.logic);
      return pk.verify(message, signature);
    }
    final multisig = logicSig.msig;
    if (multisig != null) {
      final mSigAccount = AlgoMultiEd25519AccountPublicKey.fromMultisig(
        multisig,
      );
      if (mSigAccount == null) return false;
      final message = programToSign(logicSig.logic);
      return mSigAccount.verifyMultisig(
        message: message,
        signatures: multisig.subsigs,
      );
    }
    final lMultisig = logicSig.lmsig;
    if (lMultisig != null) {
      final mSigAccount = AlgoMultiEd25519AccountPublicKey.fromMultisig(
        lMultisig,
      );
      if (mSigAccount == null) return false;
      final message = msigProgramToSign(
        mSigAccount.toAddress(),
        logicSig.logic,
      );
      return mSigAccount.verifyMultisig(
        message: message,
        signatures: lMultisig.subsigs,
      );
    }
    // Contract-account (stateless) logic sig: no external signature required.
    return true;
  }

  /// Builds a signed transaction wrapping [logicSig] with an explicit [lsigAddress].
  /// Sets [authAddr] when the transaction sender differs from the lsig address.
  static AlgoSignedTxn buildLogicSigTransactionWithAddress({
    required AlgoLogicSig logicSig,
    required AlgoAddress lsigAddress,
    required AlgoTransaction transaction,
  }) {
    if (!verifyLogicSig(logicSig, lsigAddress)) {
      throw OnChainErrors.algoPlugin(
        "buildLogicSigTransactionWithAddress",
        reason: "Logic sig signature verification failed.",
      );
    }
    AlgoAddress? authAddr;
    if (transaction.sender != lsigAddress) {
      authAddr = lsigAddress;
    }
    return AlgoSignedTxn(
      transaction: transaction,
      lsig: logicSig,
      authAddr: authAddr,
    );
  }

  /// Builds a signed transaction for [logicSig], deriving the lsig address
  /// from the signature type (single-key sender, multisig account, or program hash).
  static AlgoSignedTxn buildLogicSigTransaction({
    required AlgoLogicSig logicSig,
    required AlgoTransaction transaction,
  }) {
    AlgoAddress lsigAddress;
    if (logicSig.signature != null) {
      lsigAddress = transaction.sender;
    } else if (logicSig.msig case AlgoMultisigSig()) {
      final account = AlgoMultiEd25519AccountPublicKey.fromMultisig(
        logicSig.msig!,
      );
      if (account == null) {
        throw OnChainErrors.algoPlugin(
          "buildLogicSigTransaction",
          reason: "Invalid LogicSig multisig account.",
        );
      }
      lsigAddress = account.toAddress();
    } else {
      // Contract account address derived from the program itself.
      lsigAddress = AlgoAddress.fromProgram(logicSig.logic);
    }

    return buildLogicSigTransactionWithAddress(
      logicSig: logicSig,
      lsigAddress: lsigAddress,
      transaction: transaction,
    );
  }

  /// Computes the group ID for a list of transactions (same as go-algorand-sdk).
  /// Hash of: tgidPrefix || msgpack(TxGroup of each txn's txid).
  static List<int> computeGroupId(List<AlgoTransaction> txns) {
    final txIds = txns.map((e) => e.transactionID()).toList();
    final group = AlgoTypesTxGroup(txGroupHashes: txIds);
    return hashData([...AlgoUtils.tgidPrefix, ...group.toSerializeBytes()]);
  }
}
