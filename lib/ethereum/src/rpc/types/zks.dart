import 'package:blockchain_utils/helper/helper.dart';
import 'package:blockchain_utils/utils/utils.dart';

class Getl2tol1logproof {
  final List<String> proof;
  final int id;
  final String root;
  Getl2tol1logproof(
      {required List<String> proof, required this.id, required this.root})
      : proof = proof.immutable;
  factory Getl2tol1logproof.fromJson(Map<String, dynamic> json) {
    return Getl2tol1logproof(
        proof: json.valueEnsureAsList<String>("proof"),
        id: json.valueAs("id"),
        root: json.valueAs("root"));
  }
}

class JKSGenesis {
  final List<List<String>> initialContracts;
  final List<dynamic> additionalStorage;
  final int executionVersion;
  final String genesisRoot;

  const JKSGenesis({
    required this.initialContracts,
    required this.additionalStorage,
    required this.executionVersion,
    required this.genesisRoot,
  });

  // Factory constructor to create an instance from JSON
  factory JKSGenesis.fromJson(Map<String, dynamic> json) {
    return JKSGenesis(
      initialContracts: json
          .valueEnsureAsList<List>("initial_contracts")
          .map((e) => JsonParser.valueEnsureAsList<String>(e))
          .toList(),
      additionalStorage: json.valueAs("additional_storage"),
      executionVersion: json.valueAs("execution_version"),
      genesisRoot: json.valueAs("genesis_root"),
    );
  }

  // Method to convert an instance to JSON (optional)
  Map<String, dynamic> toJson() {
    return {
      'initial_contracts':
          initialContracts.map((x) => List<String>.from(x)).toList(),
      'additional_storage': additionalStorage,
      'execution_version': executionVersion,
      'genesis_root': genesisRoot,
    };
  }
}

class ZkSyncBlockDetails {
  final int number;
  final int l1BatchNumber;
  final int timestamp;
  final int l1TxCount;
  final int l2TxCount;
  final String rootHash;
  final String status;
  final String commitTxHash;
  final String committedAt;
  final String proveTxHash;
  final String provenAt;
  final String executeTxHash;
  final String executedAt;
  final int l1GasPrice;
  final int l2FairGasPrice;
  final Map<String, dynamic> baseSystemContractsHashes;
  final String operatorAddress;
  final String protocolVersion;

  ZkSyncBlockDetails({
    required this.number,
    required this.l1BatchNumber,
    required this.timestamp,
    required this.l1TxCount,
    required this.l2TxCount,
    required this.rootHash,
    required this.status,
    required this.commitTxHash,
    required this.committedAt,
    required this.proveTxHash,
    required this.provenAt,
    required this.executeTxHash,
    required this.executedAt,
    required this.l1GasPrice,
    required this.l2FairGasPrice,
    required this.baseSystemContractsHashes,
    required this.operatorAddress,
    required this.protocolVersion,
  });

  // Factory constructor to create an instance from JSON
  factory ZkSyncBlockDetails.fromJson(Map<String, dynamic> json) {
    return ZkSyncBlockDetails(
      number: json['number'],
      l1BatchNumber: json['l1BatchNumber'],
      timestamp: json['timestamp'],
      l1TxCount: json['l1TxCount'],
      l2TxCount: json['l2TxCount'],
      rootHash: json['rootHash'],
      status: json['status'],
      commitTxHash: json['commitTxHash'],
      committedAt: json['committedAt'],
      proveTxHash: json['proveTxHash'],
      provenAt: json['provenAt'],
      executeTxHash: json['executeTxHash'],
      executedAt: json['executedAt'],
      l1GasPrice: json['l1GasPrice'],
      l2FairGasPrice: json['l2FairGasPrice'],
      baseSystemContractsHashes:
          Map<String, dynamic>.from(json['baseSystemContractsHashes']),
      operatorAddress: json['operatorAddress'],
      protocolVersion: json['protocolVersion'],
    );
  }

  // Method to convert an instance to JSON (optional)
  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'l1BatchNumber': l1BatchNumber,
      'timestamp': timestamp,
      'l1TxCount': l1TxCount,
      'l2TxCount': l2TxCount,
      'rootHash': rootHash,
      'status': status,
      'commitTxHash': commitTxHash,
      'committedAt': committedAt,
      'proveTxHash': proveTxHash,
      'provenAt': provenAt,
      'executeTxHash': executeTxHash,
      'executedAt': executedAt,
      'l1GasPrice': l1GasPrice,
      'l2FairGasPrice': l2FairGasPrice,
      'baseSystemContractsHashes': baseSystemContractsHashes,
      'operatorAddress': operatorAddress,
      'protocolVersion': protocolVersion,
    };
  }
}

class ZkSyncBridgeContracts {
  final String l1Erc20DefaultBridge;
  final String l2Erc20DefaultBridge;
  final String l1WethBridge;
  final String l2WethBridge;

  ZkSyncBridgeContracts({
    required this.l1Erc20DefaultBridge,
    required this.l2Erc20DefaultBridge,
    required this.l1WethBridge,
    required this.l2WethBridge,
  });

  // Factory constructor to create an instance from JSON
  factory ZkSyncBridgeContracts.fromJson(Map<String, dynamic> json) {
    return ZkSyncBridgeContracts(
      l1Erc20DefaultBridge: json['l1Erc20DefaultBridge'],
      l2Erc20DefaultBridge: json['l2Erc20DefaultBridge'],
      l1WethBridge: json['l1WethBridge'],
      l2WethBridge: json['l2WethBridge'],
    );
  }

  // Method to convert an instance to JSON (optional)
  Map<String, dynamic> toJson() {
    return {
      'l1Erc20DefaultBridge': l1Erc20DefaultBridge,
      'l2Erc20DefaultBridge': l2Erc20DefaultBridge,
      'l1WethBridge': l1WethBridge,
      'l2WethBridge': l2WethBridge,
    };
  }
}

class ZkSyncSendRawTransactionWithDetailedOutput {
  final String transactionHash;
  final List<ZkSyncStorageLog> storageLogs;
  final List<ZkSyncEvent> events;

  ZkSyncSendRawTransactionWithDetailedOutput({
    required this.transactionHash,
    required this.storageLogs,
    required this.events,
  });

  // Factory constructor to create an instance from JSON
  factory ZkSyncSendRawTransactionWithDetailedOutput.fromJson(
      Map<String, dynamic> json) {
    return ZkSyncSendRawTransactionWithDetailedOutput(
      transactionHash: json['transactionHash'],
      storageLogs: (json['storageLogs'] as List)
          .map((item) => ZkSyncStorageLog.fromJson(item))
          .toList(),
      events: (json['events'] as List)
          .map((item) => ZkSyncEvent.fromJson(item))
          .toList(),
    );
  }

  // Method to convert an instance to JSON (optional)
  Map<String, dynamic> toJson() {
    return {
      'transactionHash': transactionHash,
      'storageLogs': storageLogs.map((log) => log.toJson()).toList(),
      'events': events.map((event) => event.toJson()).toList(),
    };
  }
}

class ZkSyncStorageLog {
  final String address;
  final String key;
  final String writtenValue;

  ZkSyncStorageLog({
    required this.address,
    required this.key,
    required this.writtenValue,
  });

  // Factory constructor to create an instance from JSON
  factory ZkSyncStorageLog.fromJson(Map<String, dynamic> json) {
    return ZkSyncStorageLog(
      address: json['address'],
      key: json['key'],
      writtenValue: json['writtenValue'],
    );
  }

  // Method to convert an instance to JSON (optional)
  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'key': key,
      'writtenValue': writtenValue,
    };
  }
}

class ZkSyncEvent {
  final String address;
  final List<String> topics;
  final String data;
  final String? blockHash;
  final int? blockNumber;
  final String l1BatchNumber;
  final String transactionHash;
  final String transactionIndex;
  final bool removed;

  ZkSyncEvent({
    required this.address,
    required this.topics,
    required this.data,
    this.blockHash,
    this.blockNumber,
    required this.l1BatchNumber,
    required this.transactionHash,
    required this.transactionIndex,
    required this.removed,
  });

  // Factory constructor to create an instance from JSON
  factory ZkSyncEvent.fromJson(Map<String, dynamic> json) {
    return ZkSyncEvent(
      address: json['address'],
      topics: List<String>.from(json['topics']),
      data: json['data'],
      blockHash: json['blockHash'],
      blockNumber: json['blockNumber'] != null
          ? int.parse(json['blockNumber'], radix: 16)
          : null,
      l1BatchNumber: json['l1BatchNumber'],
      transactionHash: json['transactionHash'],
      transactionIndex: json['transactionIndex'],
      removed: json['removed'],
    );
  }

  // Method to convert an instance to JSON (optional)
  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'topics': topics,
      'data': data,
      'blockHash': blockHash,
      'blockNumber': blockNumber?.toRadixString(16),
      'l1BatchNumber': l1BatchNumber,
      'transactionHash': transactionHash,
      'transactionIndex': transactionIndex,
      'removed': removed,
    };
  }
}

class ZkSyncTransactionDetails {
  final bool isL1Originated;
  final String status;
  final String fee;
  final String gasPerPubdata;
  final String initiatorAddress;
  final String receivedAt;
  final String ethCommitTxHash;
  final String ethProveTxHash;
  final String ethExecuteTxHash;

  ZkSyncTransactionDetails({
    required this.isL1Originated,
    required this.status,
    required this.fee,
    required this.gasPerPubdata,
    required this.initiatorAddress,
    required this.receivedAt,
    required this.ethCommitTxHash,
    required this.ethProveTxHash,
    required this.ethExecuteTxHash,
  });

  // Factory constructor to create an instance from JSON
  factory ZkSyncTransactionDetails.fromJson(Map<String, dynamic> json) {
    return ZkSyncTransactionDetails(
      isL1Originated: json['isL1Originated'],
      status: json['status'],
      fee: json['fee'],
      gasPerPubdata: json['gasPerPubdata'],
      initiatorAddress: json['initiatorAddress'],
      receivedAt: json['receivedAt'],
      ethCommitTxHash: json['ethCommitTxHash'],
      ethProveTxHash: json['ethProveTxHash'],
      ethExecuteTxHash: json['ethExecuteTxHash'],
    );
  }

  // Optionally, you can add a `toJson` method if you want to serialize back to JSON
  Map<String, dynamic> toJson() {
    return {
      'isL1Originated': isL1Originated,
      'status': status,
      'fee': fee,
      'gasPerPubdata': gasPerPubdata,
      'initiatorAddress': initiatorAddress,
      'receivedAt': receivedAt,
      'ethCommitTxHash': ethCommitTxHash,
      'ethProveTxHash': ethProveTxHash,
      'ethExecuteTxHash': ethExecuteTxHash,
    };
  }
}

class ZkSyncProof {
  final String address;
  final List<StorageProof> storageProof;

  ZkSyncProof({
    required this.address,
    required this.storageProof,
  });

  // Factory constructor to create an instance from JSON
  factory ZkSyncProof.fromJson(Map<String, dynamic> json) {
    var proofList = json['storageProof'] as List;
    List<StorageProof> storageProofList =
        proofList.map((item) => StorageProof.fromJson(item)).toList();

    return ZkSyncProof(
      address: json['address'],
      storageProof: storageProofList,
    );
  }

  // Optionally, you can add a `toJson` method if you want to serialize back to JSON
  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'storageProof': storageProof.map((item) => item.toJson()).toList(),
    };
  }
}

class StorageProof {
  final String key;
  final List<String> proof;
  final String value;
  final int index;

  StorageProof({
    required this.key,
    required this.proof,
    required this.value,
    required this.index,
  });

  // Factory constructor to create an instance from JSON
  factory StorageProof.fromJson(Map<String, dynamic> json) {
    var proofList = json['proof'] as List;
    List<String> proofListStr = List<String>.from(proofList);

    return StorageProof(
      key: json['key'],
      proof: proofListStr,
      value: json['value'],
      index: json['index'],
    );
  }

  // Optionally, you can add a `toJson` method if you want to serialize back to JSON
  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'proof': proof,
      'value': value,
      'index': index,
    };
  }
}
