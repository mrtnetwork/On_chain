import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';
import "package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart"
    as proto_basic_types;
import "package:on_chain/hedera/src/proto_messages/proto/src/timestamp.dart"
    as proto_timestamp;

/// *
///  * # NFT.
///  * This is a single, whole, unique, non-fungible token within the Hedera network.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in [RFC2119](https://www.ietf.org/rfc/rfc2119)
///  * and clarified in [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.state.token"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * An Hedera Token Service non-fungible token (NFT).&lt;br/&gt;
///  * Every NFT is a unique instance of a token with non-fungible type.
///  *
///  * The NFT SHALL be identified by token ID and serial number.&lt;br/&gt;
///  * The token treasury account SHALL own all minted NFTs of that token type
///  * initially.&lt;br/&gt;
///  * NFTs owned by the token treasury SHALL NOT be linked into that account's
///  * virtual linked list of NFTs.&lt;br/&gt;
///  * NFTs not owned by the token treasury SHALL be linked into the owner
///  * account's virtual linked list of NFTs.
class HederaNft extends HederaProtoMessage with Equality {
  /// *
  ///      * The id of this NFT, consisting of a Token ID and serial number.
  final proto_basic_types.HederaNftID? nftId;

  /// *
  ///      * The account or contract id that owns this NFT.
  ///      * &lt;p&gt;
  ///      * If this NFT is owned by its token type's current treasury account,
  ///      * this value SHALL be zero.
  final proto_basic_types.HederaAccountID? ownerId;

  /// *
  ///      * The account or contract id approved to spend this NFT.
  ///      * &lt;p&gt;
  ///      * If there is no approved spender, this value SHALL be null.
  final proto_basic_types.HederaAccountID? spenderId;

  /// *
  ///      * The consensus time of the TokenMint that created this NFT as
  ///      * offset from the epoch.
  ///      * &lt;p&gt;
  ///      * For this purpose, `epoch` SHALL be the UNIX epoch with 0 at `1970-01-01T00:00:00.000Z`.
  final proto_timestamp.HederaTimestamp? mintTime;

  /// *
  ///      * The metadata bytes for this NFT. This is often a URI value.
  ///      * &lt;p&gt;
  ///      * This value, if set, SHALL NOT exceed 100 bytes.
  final List<int>? metadata;

  /// *
  ///      * The NFT ID of the previous entry in the current owner's "virtual
  ///      * double-linked list" of owned NFTs.
  ///      * &lt;p&gt;
  ///      * If the owner of this NFT is the token treasury, this SHALL be unset.
  final proto_basic_types.HederaNftID? ownerPreviousNftId;

  /// *
  ///      * The NFT ID of the next entry in the current owner's "virtual
  ///      * double-linked list" of owned NFTs.
  ///      * &lt;p&gt;
  ///      * If the owner of this NFT is the token treasury, this SHALL be unset.
  final proto_basic_types.HederaNftID? ownerNextNftId;

  const HederaNft({
    this.nftId,
    this.ownerId,
    this.spenderId,
    this.mintTime,
    this.metadata,
    this.ownerPreviousNftId,
    this.ownerNextNftId,
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
        ProtoFieldConfig.message(3),
        ProtoFieldConfig.message(4),
        ProtoFieldConfig.bytes(5),
        ProtoFieldConfig.message(6),
        ProtoFieldConfig.message(7),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    nftId,
    ownerId,
    spenderId,
    mintTime,
    metadata,
    ownerPreviousNftId,
    ownerNextNftId,
  ];

  HederaNft copyWith({
    proto_basic_types.HederaNftID? nftId,

    proto_basic_types.HederaAccountID? ownerId,

    proto_basic_types.HederaAccountID? spenderId,

    proto_timestamp.HederaTimestamp? mintTime,

    List<int>? metadata,

    proto_basic_types.HederaNftID? ownerPreviousNftId,

    proto_basic_types.HederaNftID? ownerNextNftId,
  }) {
    return HederaNft(
      nftId: nftId ?? this.nftId,
      ownerId: ownerId ?? this.ownerId,
      spenderId: spenderId ?? this.spenderId,
      mintTime: mintTime ?? this.mintTime,
      metadata: metadata ?? this.metadata,
      ownerPreviousNftId: ownerPreviousNftId ?? this.ownerPreviousNftId,
      ownerNextNftId: ownerNextNftId ?? this.ownerNextNftId,
    );
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {
      'nft_id': config.encodeMessage(nftId),
      'owner_id': config.encodeMessage(ownerId),
      'spender_id': config.encodeMessage(spenderId),
      'mint_time': config.encodeMessage(mintTime),
      'metadata': config.encodeBinary(metadata),
      'owner_previous_nft_id': config.encodeMessage(ownerPreviousNftId),
      'owner_next_nft_id': config.encodeMessage(ownerNextNftId),
    };
  }

  factory HederaNft.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaNft(
      nftId: json.valueTo<proto_basic_types.HederaNftID?, Object>(
        key: 'nft_id',
        parse:
            (v) => proto_basic_types.HederaNftID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      ownerId: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'owner_id',
        parse:
            (v) => proto_basic_types.HederaAccountID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      spenderId: json.valueTo<proto_basic_types.HederaAccountID?, Object>(
        key: 'spender_id',
        parse:
            (v) => proto_basic_types.HederaAccountID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      mintTime: json.valueTo<proto_timestamp.HederaTimestamp?, Object>(
        key: 'mint_time',
        parse:
            (v) => proto_timestamp.HederaTimestamp.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      metadata: config.decodeBinary<List<int>?>(
        json.valueAs('metadata', normalizeKeyLookup: config.normalizeKeys),
      ),
      ownerPreviousNftId: json.valueTo<proto_basic_types.HederaNftID?, Object>(
        key: 'owner_previous_nft_id',
        parse:
            (v) => proto_basic_types.HederaNftID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
      ownerNextNftId: json.valueTo<proto_basic_types.HederaNftID?, Object>(
        key: 'owner_next_nft_id',
        parse:
            (v) => proto_basic_types.HederaNftID.fromJson(
              JsonParser.valueAs(v),
              config: config,
            ),
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory HederaNft.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaNft(
      nftId: decode.messageTo<proto_basic_types.HederaNftID?>(
        1,
        (b) => proto_basic_types.HederaNftID.deserialize(b),
      ),
      ownerId: decode.messageTo<proto_basic_types.HederaAccountID?>(
        2,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      spenderId: decode.messageTo<proto_basic_types.HederaAccountID?>(
        3,
        (b) => proto_basic_types.HederaAccountID.deserialize(b),
      ),
      mintTime: decode.messageTo<proto_timestamp.HederaTimestamp?>(
        4,
        (b) => proto_timestamp.HederaTimestamp.deserialize(b),
      ),
      metadata: decode.getBytes<List<int>?>(5),
      ownerPreviousNftId: decode.messageTo<proto_basic_types.HederaNftID?>(
        6,
        (b) => proto_basic_types.HederaNftID.deserialize(b),
      ),
      ownerNextNftId: decode.messageTo<proto_basic_types.HederaNftID?>(
        7,
        (b) => proto_basic_types.HederaNftID.deserialize(b),
      ),
    );
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoNft;
}
