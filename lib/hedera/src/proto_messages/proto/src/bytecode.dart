import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

/// *
///  * # EVM Bytecode
///  * The verified bytecode of an EVM contract for the Hedera Smart Contract service.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in [RFC2119](https://www.ietf.org/rfc/rfc2119)
///  * and clarified in [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// SPDX-License-Identifier: Apache-2.0
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.node.state.contract"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * The bytecode for a contract account.
///  *
///  * This is not referred to by any other protocol buffer, but is used internally
///  * within the Hedera Node software.
class HederaBytecode extends HederaProtoMessage with Equality {
  /// *
  ///      * The raw bytes (not hex-encoded) of a contract's bytecode.
  final List<int>? code;

  const HederaBytecode({this.code});

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [ProtoFieldConfig.bytes(1)],
    );
  }

  @override
  List<Object?> get protoValues => [code];

  HederaBytecode copyWith({List<int>? code}) {
    return HederaBytecode(code: code ?? this.code);
  }

  @override
  List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({
    ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig,
  }) {
    return {'code': config.encodeBinary(code)};
  }

  factory HederaBytecode.fromJson(
    Map<String, dynamic> json, {
    HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig,
  }) {
    return HederaBytecode(
      code: config.decodeBinary<List<int>?>(
        json.valueAs('code', normalizeKeyLookup: config.normalizeKeys),
      ),
    );
  }

  factory HederaBytecode.deserialize(List<int> bytes) {
    final decode = HederaProtoMessage.decode(bytes, protoConfigStatic());
    return HederaBytecode(code: decode.getBytes<List<int>?>(1));
  }

  @override
  DefaultHederaProtoTypeUrl get declarationId =>
      DefaultHederaProtoTypeUrl.protoBytecode;
}
