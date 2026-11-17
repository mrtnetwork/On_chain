import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/proto_messages/types.dart';
import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';

/// *
///  * # File Service
///  * Block stream messages that report the results of transactions handled
///  * by the `File` service.
///  *
///  * A `file` in Hedera is an arbitrary sequence of bytes and may be up to
///  * `1048576` total bytes. Files are used anywhere a transaction requires a
///  * large amount of data (anything that would not fit within the
///  * transaction size limit).
///  *
///  * Examples
///  *  - smart contract bytecode
///  *  - network configuration updates
///  *  - network fee schedules
///  *  - image files for NFTs
///  *  - property title documents
///  * There are many other uses; these examples are illustrative.
///  *
///  * ### Keywords
///  * The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
///  * "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this
///  * document are to be interpreted as described in
///  * [RFC2119](https://www.ietf.org/rfc/rfc2119) and clarified in
///  * [RFC8174](https://www.ietf.org/rfc/rfc8174).
/// * Copyright (C) 2024 Hedera Hashgraph, LLC
///  *
///  * Licensed under the Apache License, Version 2.0 (the "License");
///  * you may not use this file except in compliance with the License.
///  * You may obtain a copy of the License at
///  *
///  *      http://www.apache.org/licenses/LICENSE-2.0
///  *
///  * Unless required by applicable law or agreed to in writing, software
///  * distributed under the License is distributed on an "AS IS" BASIS,
///  * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
///  * See the License for the specific language governing permissions and
///  * limitations under the License.
/// &lt;&lt;&lt;pbj.java_package = "com.hedera.hapi.block.stream.output"&gt;&gt;&gt; This comment is special code for setting PBJ Compiler java package
/// *
///  * Block Stream data for a `fileAppend` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained
///  * in the original transaction.
class HederaAppendFileOutput extends HederaProtoMessage with Equality {
  const HederaAppendFileOutput();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
      ];


HederaAppendFileOutput copyWith(
) {
    return HederaAppendFileOutput(
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
    };
  }


  factory HederaAppendFileOutput.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaAppendFileOutput(
    );
  }

  factory HederaAppendFileOutput.deserialize(List<int> bytes) {
    return HederaAppendFileOutput(
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputAppendFileOutput;

}


/// *
///  * Block Stream data for a `fileCreate` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaCreateFileOutput extends HederaProtoMessage with Equality {
  const HederaCreateFileOutput();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
      ];


HederaCreateFileOutput copyWith(
) {
    return HederaCreateFileOutput(
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
    };
  }


  factory HederaCreateFileOutput.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaCreateFileOutput(
    );
  }

  factory HederaCreateFileOutput.deserialize(List<int> bytes) {
    return HederaCreateFileOutput(
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputCreateFileOutput;

}


/// *
///  * Block Stream data for a `fileDelete` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaDeleteFileOutput extends HederaProtoMessage with Equality {
  const HederaDeleteFileOutput();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
      ];


HederaDeleteFileOutput copyWith(
) {
    return HederaDeleteFileOutput(
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
    };
  }


  factory HederaDeleteFileOutput.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaDeleteFileOutput(
    );
  }

  factory HederaDeleteFileOutput.deserialize(List<int> bytes) {
    return HederaDeleteFileOutput(
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputDeleteFileOutput;

}


/// *
///  * Block Stream data for a `fileUpdate` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaUpdateFileOutput extends HederaProtoMessage with Equality {
  const HederaUpdateFileOutput();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
      ];


HederaUpdateFileOutput copyWith(
) {
    return HederaUpdateFileOutput(
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
    };
  }


  factory HederaUpdateFileOutput.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaUpdateFileOutput(
    );
  }

  factory HederaUpdateFileOutput.deserialize(List<int> bytes) {
    return HederaUpdateFileOutput(
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputUpdateFileOutput;

}


/// *
///  * Block Stream data for a `systemDelete` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaSystemDeleteOutput extends HederaProtoMessage with Equality {
  const HederaSystemDeleteOutput();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
      ];


HederaSystemDeleteOutput copyWith(
) {
    return HederaSystemDeleteOutput(
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
    };
  }


  factory HederaSystemDeleteOutput.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaSystemDeleteOutput(
    );
  }

  factory HederaSystemDeleteOutput.deserialize(List<int> bytes) {
    return HederaSystemDeleteOutput(
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputSystemDeleteOutput;

}


/// *
///  * Block Stream data for a `systemUndelete` transaction.
///  *
///  * This message SHALL NOT duplicate information already contained in
///  * the original transaction.
class HederaSystemUndeleteOutput extends HederaProtoMessage with Equality {
  const HederaSystemUndeleteOutput();

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
      ];


HederaSystemUndeleteOutput copyWith(
) {
    return HederaSystemUndeleteOutput(
    );
  }
  @override
List<dynamic> get variables => protoValues;

  @override
  Map<String, dynamic> toJson({ProtoJsonConfig config = DefaultProtoJsonConfig.defaultConfig}) {
    return {
    };
  }


  factory HederaSystemUndeleteOutput.fromJson(Map<String, dynamic> json, {HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig}) {
    return HederaSystemUndeleteOutput(
    );
  }

  factory HederaSystemUndeleteOutput.deserialize(List<int> bytes) {
    return HederaSystemUndeleteOutput(
    );
  }

  @override
DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.comHederaHapiBlockStreamOutputSystemUndeleteOutput;

}


