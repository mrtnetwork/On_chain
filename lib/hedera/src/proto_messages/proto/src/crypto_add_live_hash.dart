import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart" as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/duration.dart" as proto_duration;

/// *
///  * # Add Live Hash
///  * Associate content to an account via a SHA-384 hash.
///  *
///  * &gt; Important
///  * &gt;&gt; This transaction is obsolete and not supported.&lt;br/&gt;
///  * &gt;&gt; Any transaction of this type that is submitted SHALL fail
///  * &gt;&gt; with a `PRE_CHECK` result of `NOT_SUPPORTED`.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.token"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * A Live Hash value associating some item of content to an account.
///  *
///  * This message represents a desired entry in the ledger for a SHA-384
///  * hash of some content, an associated specific account, a list of authorized
///  * keys, and a duration the live hash is "valid".
class HederaLiveHash extends HederaProtoMessage with Equality {
    /// *
  ///      * An account associated via this live hash to the hashed content.
  final proto_basic_types.HederaAccountID? accountId;

    /// *
  ///      * A SHA-384 hash of some content that is associated to the account
  ///      * or account holder.
  final List<int>? hash;

    /// *
  ///      * A list of keys, all of which MUST sign the transaction to add the
  ///      * live hash.&lt;br/&gt;
  ///      * Any one of these keys may, however, remove the live hash to revoke
  ///      * the association.
  final proto_basic_types.HederaKeyList? keys;

    /// *
  ///      * A duration describing how long this Live Hash SHALL remain valid.&lt;br/&gt;
  ///      * A Live Hash SHOULD NOT be relied upon after this duration has elapsed.
  final proto_duration.HederaDuration? duration;

  const HederaLiveHash({
    this.accountId,
    this.hash,
    this.keys,
    this.duration,
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
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.message(5),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        accountId,
        hash,
        keys,
        duration,
      ];


HederaLiveHash copyWith(
{proto_basic_types.HederaAccountID? accountId,

List<int>? hash,

proto_basic_types.HederaKeyList? keys,

proto_duration.HederaDuration? duration,

}) {
    return HederaLiveHash(
accountId: accountId ?? this.accountId,
hash: hash ?? this.hash,
keys: keys ?? this.keys,
duration: duration ?? this.duration,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'accountId': config.encodeMessage(accountId),
      'hash': config.encodeBinary(hash),
      'keys': config.encodeMessage(keys),
      'duration': config.encodeMessage(duration),
    };
  }


  factory HederaLiveHash.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaLiveHash(
      accountId: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'accountId',
        parse: (v) => proto_basic_types.HederaAccountID.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      hash: config.decodeBinary<List<int>?>(json.valueAs('hash', normalizeKeyLookup: config.normalizeKeys)),
      keys: json.valueTo<proto_basic_types.HederaKeyList?, Object>(
        key: 'keys',
        parse: (v) => proto_basic_types.HederaKeyList.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
      duration: json.valueTo<proto_duration.HederaDuration?, Object>(
        key: 'duration',
        parse: (v) => proto_duration.HederaDuration.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaLiveHash.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaLiveHash(
      accountId: decode.messageTo<proto_basic_types.HederaAccountID?>(1, (b) => proto_basic_types.HederaAccountID.deserialize(b)),
      hash: decode.getBytes<List<int>?>(2),
      keys: decode.messageTo<proto_basic_types.HederaKeyList?>(3, (b) => proto_basic_types.HederaKeyList.deserialize(b)),
      duration: decode.messageTo<proto_duration.HederaDuration?>(5, (b) => proto_duration.HederaDuration.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoLiveHash;

}


/// *
///  * Add a hash value to the ledger and associate it with an account.
///  *
///  * Create an entry in the ledger for a SHA-384 hash of some content, and
///  * associate that with a specific account.  This is sometimes used to associate
///  * a credential or certificate with an account as a public record.&lt;br/&gt;
///  * The entry created is also associated with a list of keys, all of which
///  * MUST sign this transaction.&lt;br/&gt;
///  * The account key for the associated account MUST sign this transaction.&lt;br/&gt;
///  *
///  * The live hash, once created, MAY be removed from the ledger with one
///  * or more signatures.
///  * - The account key of the account associated to the live hash.
///  * - Any one key from the key list in the live hash entry.
///  * - Any combination of keys from the key list in the live hash entry.
class HederaCryptoAddLiveHashTransactionBody extends HederaProtoMessage with Equality {
    /// *
  ///      * A Live Hash to be added to the ledger and associated with
  ///      * the identified account.
  final HederaLiveHash? liveHash;

  const HederaCryptoAddLiveHashTransactionBody({
    this.liveHash,
  });

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.message(3),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
        liveHash,
      ];


HederaCryptoAddLiveHashTransactionBody copyWith(
{HederaLiveHash? liveHash,

}) {
    return HederaCryptoAddLiveHashTransactionBody(
liveHash: liveHash ?? this.liveHash,
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
      'liveHash': config.encodeMessage(liveHash),
    };
  }


  factory HederaCryptoAddLiveHashTransactionBody.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaCryptoAddLiveHashTransactionBody(
      liveHash: json.valueTo<HederaLiveHash?, Object>(
        key: 'liveHash',
        parse: (v) => HederaLiveHash.fromJson(JsonParser.valueAs(v), config: config),
        normalizeKeyLookup: config.normalizeKeys      ),
    );
  }

  factory HederaCryptoAddLiveHashTransactionBody.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaCryptoAddLiveHashTransactionBody(
      liveHash: decode.messageTo<HederaLiveHash?>(3, (b) => HederaLiveHash.deserialize(b)),
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.protoCryptoAddLiveHashTransactionBody;

}


