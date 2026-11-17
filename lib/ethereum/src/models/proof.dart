import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/models/transaction.dart';
import 'package:on_chain/utils/utils/number_utils.dart';

/// A single storage entry of an EIP-1186 account proof (`eth_getProof`).
/// [eips.ethereum.org](https://eips.ethereum.org/EIPS/eip-1186)
class EthereumStorageProof {
  /// Storage key.
  final String key;

  /// Storage value.
  final String value;

  /// Merkle proof nodes for the storage value.
  final List<String> proof;

  const EthereumStorageProof({
    required this.key,
    required this.value,
    required this.proof,
  });

  factory EthereumStorageProof.fromJson(Map<String, dynamic> json) {
    return EthereumStorageProof(
      key: json.valueAs("key"),
      value: json.valueAs("value"),
      proof:
          (json['proof'] as List?)?.map((e) => e as String).toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {"key": key, "value": value, "proof": proof};
  }
}

/// EIP-1186 account proof object returned by `eth_getProof`.
/// [eips.ethereum.org](https://eips.ethereum.org/EIPS/eip-1186)
class EthereumProof {
  /// Account address.
  final String address;

  /// Merkle proof nodes for the account.
  final List<String> accountProof;

  /// Account balance.
  final BigInt balance;

  /// Account code hash.
  final String codeHash;

  /// Account nonce.
  final BigInt nonce;

  /// Account storage root hash.
  final String storageHash;

  /// Storage proofs for the requested keys.
  final List<EthereumStorageProof> storageProof;

  const EthereumProof({
    required this.address,
    required this.accountProof,
    required this.balance,
    required this.codeHash,
    required this.nonce,
    required this.storageHash,
    required this.storageProof,
  });

  factory EthereumProof.fromJson(Map<String, dynamic> json) {
    return EthereumProof(
      address: json.valueAs("address"),
      accountProof:
          (json['accountProof'] as List?)?.map((e) => e as String).toList() ??
          const [],
      balance: PluginBigintUtils.tryHexToBigint(json['balance']) ?? BigInt.zero,
      codeHash: json.valueAs("codeHash"),
      nonce: PluginBigintUtils.tryHexToBigint(json['nonce']) ?? BigInt.zero,
      storageHash: json.valueAs("storageHash"),
      storageProof:
          (json['storageProof'] as List?)
              ?.map((e) => EthereumStorageProof.fromJson(e))
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "address": address,
      "accountProof": accountProof,
      "balance": balance.toHexaDecimal,
      "codeHash": codeHash,
      "nonce": nonce.toHexaDecimal,
      "storageHash": storageHash,
      "storageProof": storageProof.map((e) => e.toJson()).toList(),
    };
  }
}

/// Response of `eth_signTransaction`: the RLP-encoded signed transaction
/// plus the decoded transaction object.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_signtransaction)
class EthereumSignTransactionResponse {
  /// RLP-encoded signed transaction.
  final String raw;

  /// Decoded transaction object.
  final TransactionInfo tx;

  const EthereumSignTransactionResponse({required this.raw, required this.tx});

  factory EthereumSignTransactionResponse.fromJson(Map<String, dynamic> json) {
    return EthereumSignTransactionResponse(
      raw: json.valueAs("raw"),
      tx: TransactionInfo.fromJson((json['tx'] as Map).cast<String, dynamic>()),
    );
  }

  Map<String, dynamic> toJson() {
    return {"raw": raw, "tx": tx.toJson()};
  }
}
