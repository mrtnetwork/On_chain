import 'dart:io';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:onchain_proto/onchain_proto.dart';

class HederaPackageRegistryBuilderTarget {
  final String output;
  final String className;
  final String typeName;
  const HederaPackageRegistryBuilderTarget({
    required this.output,
    required this.className,
    required this.typeName,
  });
}

class HederaPackageRegisteryBuilder {
  final List<ProtoWritePackageResult> packages;
  final List<String> imports;
  const HederaPackageRegisteryBuilder({
    required this.packages,
    this.imports = const [],
  });
  void _writeTypeUrl() {
    final buf = StringBuffer();
    buf.writeln("import 'package:blockchain_utils/blockchain_utils.dart';");
    buf.writeln(
      "import 'package:on_chain/hedera/src/serialization/protobuf/proto.dart';",
    );
    buf.writeln(
      "import 'package:on_chain/hedera/src/exception/exception.dart';",
    );
    buf.writeln(
      'enum DefaultHederaProtoTypeUrl implements HederaProtoTypeUrl {',
    );
    final messages =
        packages
            .expand((e) => e.files)
            .expand((e) => e.fileData.classInfo)
            .toList();
    // final
    for (final i in messages.indexed) {
      final msg = i.$2;
      final isLast = i.$1 == messages.length - 1;
      final name = OnChainProtoUtils.snakeToCamel(
        "${msg.package}.${msg.message.fullName()}".replaceAll(".", "_"),
        capitalizeFirst: false,
      );
      String? serviceUrl;
      final service = msg.message.services.firstOrNull;
      if (service != null) {
        serviceUrl = "/${msg.package}.${service.fullName()}";
      }

      buf.writeln(
        "  $name(typeUrl: '${msg.typeUrl}',${serviceUrl == null ? '' : 'serviceUrl: "$serviceUrl"'})${isLast ? ';' : ','}",
      );
    }
    buf.writeln('@override');
    buf.writeln('final String typeUrl;');
    buf.writeln('@override');
    buf.writeln('final String? serviceUrl;');
    buf.writeln(
      ' const DefaultHederaProtoTypeUrl({required this.typeUrl, this.serviceUrl});',
    );
    buf.writeln('  static DefaultHederaProtoTypeUrl? fromUrl(String? value) {');
    buf.writeln(
      '    return DefaultHederaProtoTypeUrl.values.firstWhereNullable(',
    );
    buf.writeln('      (e) => e.typeUrl == value || e.serviceUrl == value,');
    buf.writeln('    );');
    buf.writeln('  }');

    buf.writeln(' String getServiceUrl() {');
    buf.writeln('    final serviceUrl = this.serviceUrl;');
    buf.writeln(
      'if (serviceUrl == null) {throw HederaPluginException("Missing proto service url.", details: {"type_url": typeUrl}, ); }',
    );
    buf.writeln('return serviceUrl;');
    buf.writeln('  }');

    buf.writeln('}');
    File("lib/hedera/src/proto_messages/types.dart")
      ..createSync(recursive: true)
      ..writeAsStringSync(buf.toString());
  }

  void write() {
    _writeTypeUrl();
  }
}

class HederaProtoPackagesBuilder {
  final ProtoCompiler compiler;
  const HederaProtoPackagesBuilder._({required this.compiler});
  factory HederaProtoPackagesBuilder() {
    final compiler = ProtoCompiler.fromDirectory(
      classNamePrefix: 'Hedera',
      builder: HederaProtoCodegenTarget(),
      writer: ProtoPackageWriter(
        packageRoot: "package:on_chain/hedera/src/proto_messages",
        outputRoot: "lib/hedera/src/proto_messages",
      ),
      sourceDirectory: "proto/hedera/hedera-protobufs-0.75.1",
    );
    return HederaProtoPackagesBuilder._(compiler: compiler);
  }
  void compile() {
    compiler.compile();
    final result = compiler.writeAll(writeToFile: true);
    final registeryBuilder = HederaPackageRegisteryBuilder(
      packages: result,
      imports: [],
    );
    registeryBuilder.write();
  }
}

/// running from root directory of project
/// zcash_dart$ dart run proto/builder.dart

void main() {
  final builder = HederaProtoPackagesBuilder();
  builder.compile();
}

class HederaProtoCodegenTarget extends DefaultProtoCodegenTarget {
  @override
  String get messageBaseClassName => "HederaProtoMessage";
  static const serviceMixinName = "IHederaServiceMessage";
  static const queryMixinName = "IHederaQuery";
  static const queryResponseMixinName = "IHederaQueryRespone";

  ProtoMessage? _query;
  ProtoMessage? _queryResponse;
  ProtoMessage? _queryHeader;

  final List<ProtoMessage> _queryMessage = [];
  final List<ProtoMessage> _queryResponsemessages = [];
  final List<ProtoMessage> _copyWith = [];

  static const List<String> knownQueryServices = [
    "ConsensusService",
    "ConsensusService",
    "CryptoService",
    "FileService",
    "FreezeService",
    "NetworkService",
    "ScheduleService",
    "SmartContractService",
    "TokenService",
  ];
  final List<String> imports;
  HederaProtoCodegenTarget({
    this.imports = const [
      "package:on_chain/hedera/src/proto_messages/types.dart",
      "package:on_chain/hedera/src/serialization/protobuf/proto.dart",
    ],
  });

  @override
  List<ProtoOption> filterFieldOptions(ProtoField field) {
    return field.options;
  }

  @override
  List<ProtoOption> filterMessageOptions(
    ProtoMessage message,
    List<ServiceMessageOption> services,
  ) {
    return message.options;
  }

  @override
  List<ProtoMessageRefrence> refrenceMessages(
    ProtoCompiler resolver,
    ProtoFile file,
  ) {
    final query = getQuery();
    List<ProtoMessageRefrence> refrences = [];
    for (final i in file.messages) {
      if (_queryMessage.contains(i)) {
        refrences.add(query.toTypeRef());
        String typeName = i.fullTypeName();
        assert(typeName.endsWith("Query"));
        typeName = typeName.substring(0, typeName.length - 5);
        final responeType = "${typeName}Response";
        final responseC = _queryResponsemessages.firstWhere(
          (e) => e.fullName() == responeType,
        );
        refrences.add(responseC.toTypeRef());
      }
    }
    return refrences;
  }

  @override
  List<String> defaultImports(ProtoFile file) {
    return [...super.defaultImports(file), ...imports];
  }

  ProtoMessage getQuery() {
    final query = _query;
    if (query == null) {
      throw OnChainProtoException("code gen not initialized.");
    }
    return query;
  }

  ProtoMessage getQueryResponse() {
    final query = _queryResponse;
    if (query == null) {
      throw OnChainProtoException("code gen not initialized.");
    }
    return query;
  }

  ProtoMessage getQueryHeader() {
    final query = _queryHeader;
    if (query == null) {
      throw OnChainProtoException("code gen not initialized.");
    }
    return query;
  }

  @override
  void init(ProtoCompiler resolver) {
    _query =
        resolver.getMessageByFullTypeName("proto", "Query") as ProtoMessage;
    _queryResponse =
        resolver.getMessageByFullTypeName("proto", "Response") as ProtoMessage;
    _queryHeader =
        resolver.getMessageByFullTypeName("proto", "QueryHeader")
            as ProtoMessage;
    final packages = resolver.generatedPackages;
    final query = getQuery();
    final response = getQueryResponse();
    for (final i in packages.entries) {
      for (final file in i.value.files) {
        for (final message in file.file.messages) {
          final fullTypeName = message.fullTypeName();
          bool isQueryField = query.fields.any(
            (e) => e.type.isRefrenceOf(fullTypeName),
          );
          bool isQueryRespone = response.fields.any(
            (e) => e.type.isRefrenceOf(fullTypeName),
          );
          if (isQueryField) {
            _queryMessage.add(message);
            _copyWith.add(message);
          }
          if (isQueryRespone) {
            _queryResponsemessages.add(message);
          }
        }
      }
    }
  }

  @override
  List<String> mixinsFor(
    ProtoMessage message,
    ProtoCompiler resolver,
    Set<ProtoTypeLocation> importRefrences,
  ) {
    List<String> mixins = [];
    mixins.add("Equality");
    if (_queryMessage.contains(message)) {
      String typeName = message.fullTypeName();
      assert(typeName.endsWith("Query"));
      typeName = typeName.substring(0, typeName.length - 5);
      final responeType = "${typeName}Response";
      final responseC = _queryResponsemessages.firstWhere(
        (e) => e.fullName() == responeType,
      );

      mixins.add(
        '$queryMixinName<${ProtoRuntimeTypeMapper.bareDartType(type: responseC.toTypeRef(), importRefrences: importRefrences, resolver: resolver)}>',
      );

      // mixins.add(queryMixinName);
    }
    if (_queryResponsemessages.contains(message)) {
      mixins.add(queryResponseMixinName);
    }

    for (final i in message.services) {
      if (knownQueryServices.contains(i.serviceName)) {
        mixins.add(
          '$serviceMixinName<${ProtoRuntimeTypeMapper.bareDartType(type: i.type, importRefrences: importRefrences, resolver: resolver)}>',
        );
        break;
      }
    }
    return mixins;
  }

  @override
  String buildExtraMembers(
    ProtoMessage message,
    ProtoCompiler resolver,
    Set<ProtoTypeLocation> importRefrences,
  ) {
    // Same rationale as CosmosProtoCodegenTarget.buildExtraMembers: keep
    // this tied to proto-space names, not the (possibly prefixed) Dart
    // class name.

    final name = OnChainProtoUtils.snakeToCamel(
      "${message.package}.${message.fullName()}".replaceAll(".", "_"),
      capitalizeFirst: false,
    );
    final buf = StringBuffer();
    buf.writeln('  @override');
    buf.writeln(
      'DefaultHederaProtoTypeUrl get declarationId => DefaultHederaProtoTypeUrl.$name;',
    );

    final queryService = message.services.firstWhereNullable(
      (e) => knownQueryServices.contains(e.serviceName),
    );
    if (queryService != null) {
      final query = queryService.type;
      buf.writeln('  @override');
      buf.writeln(
        '  ${ProtoRuntimeTypeMapper.bareDartType(type: query, importRefrences: importRefrences, resolver: resolver)} onServiceResponse(List<int> bytes) {',
      );
      buf.writeln(
        "    return ${ProtoRuntimeTypeMapper.bareDartType(type: query, importRefrences: importRefrences, resolver: resolver)}.deserialize(bytes);",
      );
      buf.writeln('  }');
    }
    return buf.toString();
  }

  @override
  List<ProtoService> filterServices(List<ProtoService> services) {
    return services.where((e) => knownQueryServices.contains(e.name)).toList();
  }

  @override
  String? buildFromJson(
    ProtoMessage message,
    ProtoCompiler resolver,
    String className,
    Set<ProtoTypeLocation> importRefrences, {
    bool camelCase = false,
    bool defaultOnMissing = true,
    StringBuffer? buf,
    String configGetter =
        "HederaProtoJsonConfig config = HederaProtoJsonConfig.defaultConfig",
  }) {
    return super.buildFromJson(
      message,
      resolver,
      className,
      importRefrences,
      camelCase: camelCase,
      buf: buf,
      configGetter: configGetter,
      defaultOnMissing: defaultOnMissing,
    );
  }

  @override
  List<ProtoFile> attachServiceMetadata(Map<String, List<ProtoFile>> packages) {
    final resolved = packages.clone();

    void replace(ProtoFile oldFile, ProtoFile newFile) {
      final files = resolved[oldFile.package]!;
      final index = files.indexWhere((e) => identical(e, oldFile));
      files[index] = newFile;
    }

    for (final package in packages.values) {
      for (final proto in package) {
        final services = filterServices(proto.services);
        for (final service in services) {
          for (final rpc in service.rpcs) {
            final sName =
                "Service${OnChainProtoUtils.snakeToCamel(service.name, capitalizeFirst: true)}${OnChainProtoUtils.snakeToCamel(rpc.name, capitalizeFirst: true)}";
            final message = ProtoMessage(
              name: sName,
              comments: "",
              options: [],
              fields: [
                ProtoField(
                  name: rpc.name,
                  tag: 0,
                  type: rpc.request,
                  options: [],
                  comments: rpc.comments,
                ),
              ],
              package: proto.package,
              services: [
                ServiceMessageOption(
                  rpc: rpc,
                  type: rpc.response,
                  serviceName: service.name,
                ),
              ],
            );
            final sourceFile = resolved[rpc.request.package]!
                .firstWhereNullable((file) {
                  return file.messages.any((m) => m.isEqualTo(rpc.request));
                });
            if (sourceFile == null) {
              continue;
            }
            replace(
              sourceFile,
              sourceFile.copyWith(messages: [...sourceFile.messages, message]),
            );
          }
        }
      }
    }

    return resolved.values.expand((e) => e).toList();
  }

  @override
  String? buildDeserialize(
    ProtoMessage message,
    ProtoCompiler resolver,
    String className,
    Set<ProtoTypeLocation> importRefrences, {
    StringEncoding? bytesEncoding,
    bool camelCase = false,
  }) {
    if (message.services.isEmpty) {
      return super.buildDeserialize(
        message,
        resolver,
        className,
        importRefrences,
        camelCase: camelCase,
      );
    }
    return null;
  }

  @override
  String buildConfigMembers(
    ProtoMessage message,
    ProtoCompiler resolver,
    ProtoSyntax syntax,
    Set<ProtoTypeLocation> importRefrences,
  ) {
    final buf = StringBuffer();

    if (message.services.isEmpty) {
      final config = super.buildConfigMembers(
        message,
        resolver,
        syntax,
        importRefrences,
      );
      buf.writeln(config);
    }

    String className = OnChainProtoUtils.className(
      message.fullTypeName(),
      prefix: resolver.classNamePrefix,
    );
    buf.writeln('$className copyWith(');
    if (message.fields.isNotEmpty) {
      buf.write("{");
    }
    for (final f in message.fields) {
      String dartType = ProtoRuntimeTypeMapper.dartFieldType(
        type: f.type,
        optional: f.optional,
        resolver: resolver,
        importRefrences: importRefrences,
        required: f.required,
        forceNullable: true,
      );
      final dartFieldName = OnChainProtoUtils.fieldName(f.name);
      buf.writeln('$dartType $dartFieldName,');
      buf.writeln();
    }
    if (message.fields.isNotEmpty) {
      buf.write("}");
    }
    buf.writeln(') {');
    buf.writeln('    return $className(');
    for (final f in message.fields) {
      final dartFieldName = OnChainProtoUtils.fieldName(f.name);
      buf.writeln('$dartFieldName: $dartFieldName ?? this.$dartFieldName,');
    }
    buf.writeln('    );');
    buf.writeln('  }');

    if (_queryMessage.contains(message)) {
      final query = getQuery();
      final header = getQueryHeader();
      String queryClassName = OnChainProtoUtils.className(
        query.fullTypeName(),
        prefix: resolver.classNamePrefix,
      );
      String headerClassName = OnChainProtoUtils.className(
        query.fullTypeName(),
        prefix: resolver.classNamePrefix,
      );
      queryClassName = importRefrences.qualifyType(
        queryClassName,
        query.toTypeRef(),
      );
      headerClassName = importRefrences.qualifyType(
        headerClassName,
        header.toTypeRef(),
      );
      final headerField = message.fields.firstWhere(
        (e) => e.type.isRefrenceOf(header.fullTypeName()),
      );
      String headerDartType = ProtoRuntimeTypeMapper.dartFieldType(
        type: headerField.type,
        optional: headerField.optional,
        resolver: resolver,
        importRefrences: importRefrences,
        required: headerField.required,
        forceNullable: true,
      );
      final headerDartFieldName = OnChainProtoUtils.fieldName(headerField.name);

      final f = query.fields.firstWhere(
        (e) => e.type.isRefrenceOf(message.fullTypeName()),
      );

      final dartFieldName = OnChainProtoUtils.fieldName(f.name);
      buf.writeln('  @override');
      buf.writeln(
        '$queryClassName toQueryRequest({$headerDartType $headerDartFieldName}) => $queryClassName($dartFieldName: copyWith($headerDartFieldName:$headerDartFieldName));',
      );
    }

    if (message.services.isNotEmpty) {
      final field = message.fields.first;
      buf.writeln('  @override');
      buf.writeln(
        '  ProtoMessageConfig protoConfig() =>${OnChainProtoUtils.fieldName(field.name)}?.protoConfig() ?? ProtoMessageConfig();',
      );
      buf.writeln();

      assert(message.fields.length == 1, "unexpected service");

      buf.writeln('  @override');
      buf.writeln(
        '  List<Object?> get protoValues => ${OnChainProtoUtils.fieldName(field.name)}?.protoValues??[];',
      );
    }
    buf.writeln('  @override');
    buf.writeln('List<dynamic> get variables => protoValues;');

    return buf.toString();
  }
}
