import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/google/protobuf/src/wrappers.dart"
    as google_protobuf_wrappers;

/// *
///  * # Contract Message Types
///  * Message types used in contract transactions.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.contract"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Context of an internal call in an EVM transaction that is not otherwise externalized.&lt;br/&gt;
///  * This message does not say anything about whether an EVM transaction is itself a logical
///  * transaction in a Hiero transactional unit. It simply provides context on an internal
///  * message call within an EVM transaction.
class HederaInternalCallContext extends HederaProtoMessage with Equality {
  /// *
  ///      * The gas available for the call.&lt;br/&gt;
  final BigInt? gas;

  /// *
  ///      * The value sent with the call.&lt;br/&gt;
  final BigInt? value;

  /// *
  ///      * The call data for the call.&lt;br/&gt;
  final List<int>? callData;

  const HederaInternalCallContext({this.gas, this.value, this.callData});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.uint64(1),
        ProtoFieldConfig.uint64(2),
        ProtoFieldConfig.bytes(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [gas, value, callData];

  HederaInternalCallContext copyWith({
    BigInt? gas,

    BigInt? value,

    List<int>? callData,
  }) {
    return HederaInternalCallContext(
      gas: gas ?? this.gas,
      value: value ?? this.value,
      callData: callData ?? this.callData,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'gas': config.encodeBigint(gas),
      'value': config.encodeBigint(value),
      'call_data': config.encodeBinary(callData),
    };
  }

  factory HederaInternalCallContext.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaInternalCallContext(
      gas: json.valueAsBigInt<BigInt?>(
        'gas',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      value: json.valueAsBigInt<BigInt?>(
        'value',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      callData: config.decodeBinary<List<int>?>(
        json.valueAs('call_data', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory HederaInternalCallContext.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaInternalCallContext(
      gas: decode.getBigInt<BigInt?>(1),
      value: decode.getBigInt<BigInt?>(2),
      callData: decode.getBytes<List<int>?>(3),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoInternalCallContext;
}

/// *
///  * Results of executing a EVM transaction.&lt;br/&gt;
class HederaEvmTransactionResult extends HederaProtoMessage with Equality {
  /// *
  ///      * The Hedera id of the caller.&lt;br/&gt;
  final proto_basic_types.HederaAccountID? senderId;

  /// *
  ///      * The Hedera id of the contract receiving the call.&lt;br/&gt;
  final proto_basic_types.HederaContractID? contractId;

  /// *
  ///      * Result data from the function call.
  final List<int>? resultData;

  /// *
  ///      * Any error message produced by the contract call. Max size of 100 bytes.
  ///      * &lt;p&gt;
  ///      * This SHALL be unset if the contract call succeeded.
  final String? errorMessage;

  /// *
  ///      * EVM gas used.
  final BigInt? gasUsed;

  /// *
  ///      * If not already externalized in a transaction body, the context of the
  ///      * internal call producing this result.
  final HederaInternalCallContext? internalCallContext;

  /// *
  ///      * If set, the id of the executed hook.
  final proto_basic_types.HederaHookId? executedHookId;

  /// *
  ///      * A list of contract account nonce values.&lt;br/&gt;
  ///      * This list SHALL contain a nonce value for each contract account modified
  ///      * as a result of this contract call. These nonce values SHALL be the value
  ///      * after the contract call is completed.
  final List<HederaContractNonceInfo> contractNonces;

  /// *
  ///      * In an EthereumTransaction, the nonce of the signer account at the end of
  ///      * the transaction.&lt;br/&gt;
  final google_protobuf_wrappers.HederaInt64Value? signerNonce;

  const HederaEvmTransactionResult({
    this.senderId,
    this.contractId,
    this.resultData,
    this.errorMessage,
    this.gasUsed,
    this.internalCallContext,
    this.executedHookId,
    this.contractNonces = const [],
    this.signerNonce,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.message(2),
        ProtoFieldConfig.bytes(3),
        ProtoFieldConfig.string(4),
        ProtoFieldConfig.uint64(5),
        ProtoFieldConfig.message(6),
        ProtoFieldConfig.message(7),
        ProtoFieldConfig.repeated(
          fieldNumber: 8,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.message(9),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    senderId,
    contractId,
    resultData,
    errorMessage,
    gasUsed,
    internalCallContext,
    executedHookId,
    contractNonces,
    signerNonce,
  ];

  HederaEvmTransactionResult copyWith({
    proto_basic_types.HederaAccountID? senderId,

    proto_basic_types.HederaContractID? contractId,

    List<int>? resultData,

    String? errorMessage,

    BigInt? gasUsed,

    HederaInternalCallContext? internalCallContext,

    proto_basic_types.HederaHookId? executedHookId,

    List<HederaContractNonceInfo>? contractNonces,

    google_protobuf_wrappers.HederaInt64Value? signerNonce,
  }) {
    return HederaEvmTransactionResult(
      senderId: senderId ?? this.senderId,
      contractId: contractId ?? this.contractId,
      resultData: resultData ?? this.resultData,
      errorMessage: errorMessage ?? this.errorMessage,
      gasUsed: gasUsed ?? this.gasUsed,
      internalCallContext: internalCallContext ?? this.internalCallContext,
      executedHookId: executedHookId ?? this.executedHookId,
      contractNonces: contractNonces ?? this.contractNonces,
      signerNonce: signerNonce ?? this.signerNonce,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'sender_id': config.encodeMessage(senderId),
      'contract_id': config.encodeMessage(contractId),
      'result_data': config.encodeBinary(resultData),
      'error_message': errorMessage,
      'gas_used': config.encodeBigint(gasUsed),
      'internal_call_context': config.encodeMessage(internalCallContext),
      'executed_hook_id': config.encodeMessage(executedHookId),
      'contract_nonces':
          contractNonces.map((e) => config.encodeMessage(e)).toList(),
      'signer_nonce': config.encodeMessage(signerNonce),
    };
  }

  factory HederaEvmTransactionResult.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaEvmTransactionResult(
      senderId: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'sender_id',
        parse:
            (v) => proto_basic_types.HederaAccountID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      contractId: json.valueTo<proto_basic_types.HederaContractID?, Object>(
        key: 'contract_id',
        parse:
            (v) => proto_basic_types.HederaContractID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      resultData: config.decodeBinary<List<int>?>(
        json.valueAs('result_data', normalizeKeyLookup: config.normalizeKeys),
      ),
      errorMessage: json.valueAsString<String?>(
        'error_message',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      gasUsed: json.valueAsBigInt<BigInt?>(
        'gas_used',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      internalCallContext: json.valueTo<HederaInternalCallContext?, Object>(
        key: 'internal_call_context',
        parse:
            (v) => HederaInternalCallContext.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      executedHookId: json.valueTo<proto_basic_types.HederaHookId?, Object>(
        key: 'executed_hook_id',
        parse:
            (v) => proto_basic_types.HederaHookId.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      contractNonces:
          (json.valueEnsureAsList<dynamic>(
                'contract_nonces',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<HederaContractNonceInfo, Object>(
                  value: e,
                  parse:
                      (v) => HederaContractNonceInfo.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      signerNonce: json
          .valueTo<google_protobuf_wrappers.HederaInt64Value?, Object>(
            key: 'signer_nonce',
            parse:
                (v) => google_protobuf_wrappers.HederaInt64Value.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
    );
  }

  factory HederaEvmTransactionResult.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaEvmTransactionResult(
      senderId: decode.messageTo<proto_basic_types.HederaAccountID?>(
        1,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      contractId: decode.messageTo<proto_basic_types.HederaContractID?>(
        2,
        (b) => proto_basic_types.HederaContractID.deserialize(b),
      ),
      resultData: decode.getBytes<List<int>?>(3),
      errorMessage: decode.getString<String?>(4),
      gasUsed: decode.getBigInt<BigInt?>(5),
      internalCallContext: decode.messageTo<HederaInternalCallContext?>(
        6,
        (b) => HederaInternalCallContext.deserialize(b),
      ),
      executedHookId: decode.messageTo<proto_basic_types.HederaHookId?>(
        7,
        (b) => proto_basic_types.HederaHookId.deserialize(b),
      ),
      contractNonces:
          decode
              .getListOfBytes(8)
              .map((b) => HederaContractNonceInfo.deserialize(b))
              .toList(),
      signerNonce: decode.messageTo<google_protobuf_wrappers.HederaInt64Value?>(
        9,
        (b) => google_protobuf_wrappers.HederaInt64Value.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoEvmTransactionResult;
}

/// *
///  * A contract "nonce" reference.&lt;br/&gt;
///  * This connects a contract and its "nonce" value, and is primarily for use in
///  * query responses.  A "nonce" is short for "nonsense" and is usually a value
///  * with no particular meaning.
///  *
///  * The nonce of a contract SHALL be incremented when that contract creates
///  * another contract.
class HederaContractNonceInfo extends HederaProtoMessage with Equality {
  /// *
  ///      * A contract identifier.&lt;br/&gt;
  ///      * This refers to the contract that holds this nonce value.
  final proto_basic_types.HederaContractID? contractId;

  /// *
  ///      * A "nonce" value.
  ///      * The current value of the nonce associated with the identified contract.
  final BigInt? nonce;

  const HederaContractNonceInfo({this.contractId, this.nonce});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.message(1), ProtoFieldConfig.int64(2)],
    );
  }

  @override
  List<Object?> get protoValues => [contractId, nonce];

  HederaContractNonceInfo copyWith({
    proto_basic_types.HederaContractID? contractId,

    BigInt? nonce,
  }) {
    return HederaContractNonceInfo(
      contractId: contractId ?? this.contractId,
      nonce: nonce ?? this.nonce,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'contract_id': config.encodeMessage(contractId),
      'nonce': config.encodeBigint(nonce),
    };
  }

  factory HederaContractNonceInfo.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaContractNonceInfo(
      contractId: json.valueTo<proto_basic_types.HederaContractID?, Object>(
        key: 'contract_id',
        parse:
            (v) => proto_basic_types.HederaContractID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      nonce: json.valueAsBigInt<BigInt?>(
        'nonce',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaContractNonceInfo.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaContractNonceInfo(
      contractId: decode.messageTo<proto_basic_types.HederaContractID?>(
        1,
        (b) => proto_basic_types.HederaContractID.deserialize(b),
      ),
      nonce: decode.getBigInt<BigInt?>(2),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoContractNonceInfo;
}

/// *
///  * EVM log data for a contract call.&lt;br/&gt;
///  * The EVM log information produced by a smart contract function call.
///  *
///  * Each contract function call MAY return zero or more log events.
class HederaContractLoginfo extends HederaProtoMessage with Equality {
  /// *
  ///      * A contract identifier.&lt;br/&gt;
  ///      * This refers to the contract that generated this log entry.
  final proto_basic_types.HederaContractID? contractID;

  /// *
  ///      * A bloom filter.&lt;br/&gt;
  ///      * This filter applies to this log entry and indexes the contract log data
  ///      * in the full data of the Ethereum block.&lt;br/&gt;
  ///      * EIP-7668 proposes to remove bloom filters as they are quite low value
  ///      * in practice and separate indexing services are more effective.
  final List<int>? bloom;

  /// *
  ///      * A list of the "topics" in this log entry.&lt;br/&gt;
  ///      * The EVM permits up to 4 topics, each of which is 32 bytes (one EVM word).
  ///      * &lt;p&gt;
  ///      * The first "topic" is special, and MUST contain the keccak256 hash of the
  ///      * event signature, if the event is not anonymous.
  final List<List<int>> topic;

  /// *
  ///      * Event data for this log entry.&lt;br/&gt;
  ///      * This is binary data consisting of an arbitrary number of 256 bit
  ///      * (32 byte) words. The content of that data is determined by the smart
  ///      * contract code.&lt;br/&gt;
  final List<int>? data;

  const HederaContractLoginfo({
    this.contractID,
    this.bloom,
    this.topic = const [],
    this.data,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.bytes,
        ),
        ProtoFieldConfig.bytes(4),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [contractID, bloom, topic, data];

  HederaContractLoginfo copyWith({
    proto_basic_types.HederaContractID? contractID,

    List<int>? bloom,

    List<List<int>>? topic,

    List<int>? data,
  }) {
    return HederaContractLoginfo(
      contractID: contractID ?? this.contractID,
      bloom: bloom ?? this.bloom,
      topic: topic ?? this.topic,
      data: data ?? this.data,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'contractID': config.encodeMessage(contractID),
      'bloom': config.encodeBinary(bloom),
      'topic': topic.map((e) => config.encodeBinary(e)).toList(),
      'data': config.encodeBinary(data),
    };
  }

  factory HederaContractLoginfo.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaContractLoginfo(
      contractID: json.valueTo<proto_basic_types.HederaContractID?, Object>(
        key: 'contractID',
        parse:
            (v) => proto_basic_types.HederaContractID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      bloom: config.decodeBinary<List<int>?>(
        json.valueAs('bloom', normalizeKeyLookup: config.normalizeKeys),
      ),
      topic:
          (json.valueEnsureAsList<dynamic>(
            'topic',
            normalizeKeyLookup: config.normalizeKeys,
            onMissing: () => [],
          )).map((e) => config.decodeBinary<List<int>>(e)).toList(),
      data: config.decodeBinary<List<int>?>(
        json.valueAs('data', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory HederaContractLoginfo.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaContractLoginfo(
      contractID: decode.messageTo<proto_basic_types.HederaContractID?>(
        1,
        (b) => proto_basic_types.HederaContractID.deserialize(b),
      ),
      bloom: decode.getBytes<List<int>?>(2),
      topic: decode.getListOfBytes(3),
      data: decode.getBytes<List<int>?>(4),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoContractLoginfo;
}

/// *
///  * A contract function result.&lt;br/&gt;
///  * The result returned by a call to a smart contract function. This is part of
///  * the response to a ContractCallLocal query, and is in the record for a
///  * ContractCall. The ContractCreateInstance transaction record also carries a
///  * function result, which is the results of the call to the constructor.
class HederaContractFunctionResult extends HederaProtoMessage with Equality {
  /// No comments here: PBJ issue #217
  /// Removed Field.
  /// *
  ///      * A contract identifier.&lt;br/&gt;
  ///      * This identifies the smart contract that defines the function called.
  final proto_basic_types.HederaContractID? contractID;

  /// *
  ///      * Result data from the function call.
  ///      * &lt;p&gt;
  ///      * This SHALL be encoded in RLP bytecode format.
  final List<int>? contractCallResult;

  /// *
  ///      * Any error message produced by the contract call.
  ///      * &lt;p&gt;
  ///      * This SHALL be unset if the contract call succeeded.
  final String? errorMessage;

  /// *
  ///      * A bloom filter produced by this contract call.&lt;br/&gt;
  ///      * Ethereum uses this bloom filter to search for call results in the
  ///      * Ethereum block history. High false positive rates make the bloom
  ///      * filters quite limited value.
  final List<int>? bloom;

  /// *
  ///      * A quantity of "gas" used.&lt;br/&gt;
  ///      * This represents the resource units expended to execute this
  ///      * contract call, and correlates to transaction costs.
  final BigInt? gasUsed;

  /// *
  ///      * Any Log events produced by this contract call.
  final List<HederaContractLoginfo> logInfo;

  /// *
  ///      * Replaced by values in transaction records to support
  ///      * `CREATE2` calls.&lt;br/&gt;
  ///      * &lt;p&gt;
  ///      * The list of smart contracts that were created by the function call.&lt;br/&gt;
  ///      * The created ids will now _also_ be externalized through internal
  ///      * transaction records, where each record has its alias field populated
  ///      * with the new contract's EVM address.&lt;br/&gt;
  ///      * This is needed for contracts created with CREATE2, which removes the
  ///      * trivial relationship between a new contract's Identifier and its
  ///      * Solidity address.
  final List<proto_basic_types.HederaContractID> createdContractIDs;

  /// *
  ///      * A created contract address.&lt;br/&gt;
  ///      * If the function created a new contract (e.g. `CREATE2`),
  ///      * this is the primary 20-byte EVM address for that contract.
  ///      * &lt;p&gt;
  ///      * Every contract SHALL have a "base" EVM address that is determined by its
  ///      * `shard.realm.num` contract ID.&lt;br/&gt;
  ///      * This address is constructed as follows
  ///      * &lt;ol&gt;
  ///      *   &lt;li&gt;The first 4 bytes are the big-endian
  ///      *       representation of the shard.&lt;/li&gt;
  ///      *   &lt;li&gt;The next 8 bytes are the big-endian
  ///      *       representation of the realm.&lt;/li&gt;
  ///      *   &lt;li&gt;The final 8 bytes are the big-endian
  ///      *       representation of the number.&lt;/li&gt;
  ///      * &lt;/ol&gt;
  ///      * &lt;p&gt;
  ///      * Contracts created via `CREATE2` SHALL have an _additional_, primary,
  ///      * address that is derived from the
  ///      * &lt;a href="https://eips.ethereum.org/EIPS/eip-1014"&gt;&lt;tt&gt;EIP-1014&lt;/tt&gt;&lt;/a&gt;
  ///      * specification. This additional address SHALL NOT be directly related to
  ///      * the `shard.realm.num` contract ID.&lt;br/&gt;
  ///      * It should be emphasized that Contracts created via a `CREATE2` call can
  ///      * also be referenced via the same "base" EVM address as described above.
  final google_protobuf_wrappers.HederaBytesValue? evmAddress;

  /// *
  ///      * The amount of gas available for this call, sometimes referred to as the
  ///      * gasLimit.&lt;br/&gt;
  ///      * This field SHALL NOT be populated when the associated `TransactionBody`
  ///      * in the block stream is a `ContractCreateTransactionBody` or
  ///      * a `ContractCallTransactionBody`.
  final BigInt? gas;

  /// *
  ///      * An amount, in tinybar, sent by this function call.&lt;br/&gt;
  ///      * This SHALL be zero(0) if the function called is not `payable`.&lt;br/&gt;
  ///      * This field SHALL NOT be populated when the associated `TransactionBody`
  ///      * in the block stream is a `ContractCreateTransactionBody` or
  ///      * a `ContractCallTransactionBody`.
  final BigInt? amount;

  /// *
  ///      * The smart contract function to call, and the parameters to pass to that
  ///      * function.&lt;br/&gt;
  ///      * These SHALL be presented in EVM bytecode function call format.&lt;br/&gt;
  ///      * This field SHALL NOT be populated when the associated `TransactionBody`
  ///      * in the block stream is a `ContractCreateTransactionBody` or
  ///      * a `ContractCallTransactionBody`.
  final List<int>? functionParameters;

  /// *
  ///      * The account that was the "sender" for this contract call.&lt;br/&gt;
  ///      * If this is not set it SHALL be read from the accountId in the
  ///      * transactionId for the contract call.&lt;br/&gt;
  ///      * This field SHALL NOT be populated when the associated `TransactionBody`
  ///      * in the block stream is a `ContractCreateTransactionBody` or
  ///      * a `ContractCallTransactionBody`.
  final proto_basic_types.HederaAccountID? senderId;

  /// *
  ///      * A list of contract account nonce values.&lt;br/&gt;
  ///      * This list SHALL contain a nonce value for each contract account modified
  ///      * as a result of this contract call. These nonce values SHALL be the value
  ///      * after the contract call is completed.
  final List<HederaContractNonceInfo> contractNonces;

  /// *
  ///      * A nonce value for the "signer account".&lt;br/&gt;
  ///      * If the contract call updated the signer nonce for the signer account
  ///      * (i.e. by creating another contract), this field SHALL contain the
  ///      * updated value.&lt;br/&gt;
  ///      * If the signer account nonce was not updated, this field SHALL be `null`.
  final google_protobuf_wrappers.HederaInt64Value? signerNonce;

  const HederaContractFunctionResult({
    this.contractID,
    this.contractCallResult,
    this.errorMessage,
    this.bloom,
    this.gasUsed,
    this.logInfo = const [],
    this.createdContractIDs = const [],
    this.evmAddress,
    this.gas,
    this.amount,
    this.functionParameters,
    this.senderId,
    this.contractNonces = const [],
    this.signerNonce,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(1),
        ProtoFieldConfig.bytes(2),
        ProtoFieldConfig.string(3),
        ProtoFieldConfig.bytes(4),
        ProtoFieldConfig.uint64(5),
        ProtoFieldConfig.repeated(
          fieldNumber: 6,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 7,
          elementType: ProtoFieldType.message,
          options: [ProtoOptionBool(name: "deprecated", value: true)],
        ),
        ProtoFieldConfig.message(9),
        ProtoFieldConfig.int64(10),
        ProtoFieldConfig.int64(11),
        ProtoFieldConfig.bytes(12),
        ProtoFieldConfig.message(13),
        ProtoFieldConfig.repeated(
          fieldNumber: 14,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.message(15),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    contractID,
    contractCallResult,
    errorMessage,
    bloom,
    gasUsed,
    logInfo,
    createdContractIDs,
    evmAddress,
    gas,
    amount,
    functionParameters,
    senderId,
    contractNonces,
    signerNonce,
  ];

  HederaContractFunctionResult copyWith({
    proto_basic_types.HederaContractID? contractID,

    List<int>? contractCallResult,

    String? errorMessage,

    List<int>? bloom,

    BigInt? gasUsed,

    List<HederaContractLoginfo>? logInfo,

    List<proto_basic_types.HederaContractID>? createdContractIDs,

    google_protobuf_wrappers.HederaBytesValue? evmAddress,

    BigInt? gas,

    BigInt? amount,

    List<int>? functionParameters,

    proto_basic_types.HederaAccountID? senderId,

    List<HederaContractNonceInfo>? contractNonces,

    google_protobuf_wrappers.HederaInt64Value? signerNonce,
  }) {
    return HederaContractFunctionResult(
      contractID: contractID ?? this.contractID,
      contractCallResult: contractCallResult ?? this.contractCallResult,
      errorMessage: errorMessage ?? this.errorMessage,
      bloom: bloom ?? this.bloom,
      gasUsed: gasUsed ?? this.gasUsed,
      logInfo: logInfo ?? this.logInfo,
      createdContractIDs: createdContractIDs ?? this.createdContractIDs,
      evmAddress: evmAddress ?? this.evmAddress,
      gas: gas ?? this.gas,
      amount: amount ?? this.amount,
      functionParameters: functionParameters ?? this.functionParameters,
      senderId: senderId ?? this.senderId,
      contractNonces: contractNonces ?? this.contractNonces,
      signerNonce: signerNonce ?? this.signerNonce,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'contractID': config.encodeMessage(contractID),
      'contractCallResult': config.encodeBinary(contractCallResult),
      'errorMessage': errorMessage,
      'bloom': config.encodeBinary(bloom),
      'gasUsed': config.encodeBigint(gasUsed),
      'logInfo': logInfo.map((e) => config.encodeMessage(e)).toList(),
      'createdContractIDs':
          createdContractIDs.map((e) => config.encodeMessage(e)).toList(),
      'evm_address': config.encodeMessage(evmAddress),
      'gas': config.encodeBigint(gas),
      'amount': config.encodeBigint(amount),
      'functionParameters': config.encodeBinary(functionParameters),
      'sender_id': config.encodeMessage(senderId),
      'contract_nonces':
          contractNonces.map((e) => config.encodeMessage(e)).toList(),
      'signer_nonce': config.encodeMessage(signerNonce),
    };
  }

  factory HederaContractFunctionResult.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaContractFunctionResult(
      contractID: json.valueTo<proto_basic_types.HederaContractID?, Object>(
        key: 'contractID',
        parse:
            (v) => proto_basic_types.HederaContractID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      contractCallResult: config.decodeBinary<List<int>?>(
        json.valueAs(
          'contractCallResult',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      errorMessage: json.valueAsString<String?>(
        'errorMessage',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      bloom: config.decodeBinary<List<int>?>(
        json.valueAs('bloom', normalizeKeyLookup: config.normalizeKeys),
      ),
      gasUsed: json.valueAsBigInt<BigInt?>(
        'gasUsed',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      logInfo:
          (json.valueEnsureAsList<dynamic>(
                'logInfo',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<HederaContractLoginfo, Object>(
                  value: e,
                  parse:
                      (v) => HederaContractLoginfo.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      createdContractIDs:
          (json.valueEnsureAsList<dynamic>(
                'createdContractIDs',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<
                  proto_basic_types.HederaContractID,
                  Object
                >(
                  value: e,
                  parse:
                      (v) => proto_basic_types.HederaContractID.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      evmAddress: json
          .valueTo<google_protobuf_wrappers.HederaBytesValue?, Object>(
            key: 'evm_address',
            parse:
                (v) => google_protobuf_wrappers.HederaBytesValue.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
      gas: json.valueAsBigInt<BigInt?>(
        'gas',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      amount: json.valueAsBigInt<BigInt?>(
        'amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      functionParameters: config.decodeBinary<List<int>?>(
        json.valueAs(
          'functionParameters',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      senderId: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'sender_id',
        parse:
            (v) => proto_basic_types.HederaAccountID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      contractNonces:
          (json.valueEnsureAsList<dynamic>(
                'contract_nonces',
                normalizeKeyLookup: config.normalizeKeys,
                onMissing: () => [],
              ))
              .map(
                (e) => JsonParser.valueTo<HederaContractNonceInfo, Object>(
                  value: e,
                  parse:
                      (v) => HederaContractNonceInfo.fromJson(
                        JsonParser.valueAs(v),
                        config: config,
                      ),
                ),
              )
              .toList(),
      signerNonce: json
          .valueTo<google_protobuf_wrappers.HederaInt64Value?, Object>(
            key: 'signer_nonce',
            parse:
                (v) => google_protobuf_wrappers.HederaInt64Value.fromJson(
                  JsonParser.valueAs(v),
                  config: config,
                ),
            normalizeKeyLookup: config.normalizeKeys,
          ),
    );
  }

  factory HederaContractFunctionResult.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaContractFunctionResult(
      contractID: decode.messageTo<proto_basic_types.HederaContractID?>(
        1,
        (b) => proto_basic_types.HederaContractID.deserialize(b),
      ),
      contractCallResult: decode.getBytes<List<int>?>(2),
      errorMessage: decode.getString<String?>(3),
      bloom: decode.getBytes<List<int>?>(4),
      gasUsed: decode.getBigInt<BigInt?>(5),
      logInfo:
          decode
              .getListOfBytes(6)
              .map((b) => HederaContractLoginfo.deserialize(b))
              .toList(),
      createdContractIDs:
          decode
              .getListOfBytes(7)
              .map((b) => proto_basic_types.HederaContractID.deserialize(b))
              .toList(),
      evmAddress: decode.messageTo<google_protobuf_wrappers.HederaBytesValue?>(
        9,
        (b) => google_protobuf_wrappers.HederaBytesValue.deserialize(b),
      ),
      gas: decode.getBigInt<BigInt?>(10),
      amount: decode.getBigInt<BigInt?>(11),
      functionParameters: decode.getBytes<List<int>?>(12),
      senderId: decode.messageTo<proto_basic_types.HederaAccountID?>(
        13,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      contractNonces:
          decode
              .getListOfBytes(14)
              .map((b) => HederaContractNonceInfo.deserialize(b))
              .toList(),
      signerNonce: decode.messageTo<google_protobuf_wrappers.HederaInt64Value?>(
        15,
        (b) => google_protobuf_wrappers.HederaInt64Value.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoContractFunctionResult;
}
