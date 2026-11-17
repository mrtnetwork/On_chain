import 'dart:io';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:onchain_proto/onchain_proto.dart';

class TronPackageRegistryBuilderTarget {
  final String output;
  final String className;
  final String typeName;
  const TronPackageRegistryBuilderTarget({
    required this.output,
    required this.className,
    required this.typeName,
  });
}

class TronPackageRegisteryBuilder {
  final List<ProtoWritePackageResult> packages;
  final List<String> imports;
  const TronPackageRegisteryBuilder({
    required this.packages,
    this.imports = const [],
  });
  void _writeTypeUrl() {
    final buf = StringBuffer();
    buf.writeln("import 'package:blockchain_utils/blockchain_utils.dart';");
    buf.writeln(
      "import 'package:on_chain/tron/src/serialization/protobuf/proto.dart';",
    );
    buf.writeln('enum DefaultTronProtoTypeUrl implements TronProtoTypeUrl {');
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
      ' const DefaultTronProtoTypeUrl({required this.typeUrl, this.serviceUrl});',
    );
    buf.writeln('  static DefaultTronProtoTypeUrl? fromUrl(String? value) {');
    buf.writeln(
      '    return DefaultTronProtoTypeUrl.values.firstWhereNullable(',
    );
    buf.writeln('      (e) => e.typeUrl == value || e.serviceUrl == value,');
    buf.writeln('    );');
    buf.writeln('  }');

    buf.writeln(' String getServiceUrl() {');
    buf.writeln('    final serviceUrl = this.serviceUrl;');
    buf.writeln('if (serviceUrl == null) {throw ItemNotFoundException(); }');
    buf.writeln('return serviceUrl;');
    buf.writeln('  }');

    buf.writeln('}');
    File("lib/tron/src/proto_messages/types.dart")
      ..createSync(recursive: true)
      ..writeAsStringSync(buf.toString());
  }

  void write() {
    _writeTypeUrl();
  }
}

class TronProtoPackagesBuilder {
  final ProtoCompiler compiler;
  const TronProtoPackagesBuilder._({required this.compiler});
  factory TronProtoPackagesBuilder() {
    final compiler = ProtoCompiler.fromDirectory(
      classNamePrefix: 'Tron',
      builder: TronProtoCodegenTarget(),
      writer: ProtoPackageWriter(
        skipMessages:
            TronProtoCodegenTarget.skipMessages
                .map(
                  (e) => SkipMessages(
                    fullTypeName: e,
                    importPath:
                        "package:on_chain/tron/src/models/contracts/contracts.dart",
                    package: e == "Any" ? "google.protobuf" : "protocol",
                  ),
                )
                .toList(),
        packageRoot: "package:on_chain/tron/src/proto_messages",
        outputRoot: "lib/tron/src/proto_messages",
      ),
      sourceDirectory: "proto/tron/protocol-GreatVoyage-v4.8.2-Pyrrho-",
    );
    return TronProtoPackagesBuilder._(compiler: compiler);
  }
  void compile() {
    compiler.compile();
    final result = compiler.writeAll(writeToFile: true);
    final registeryBuilder = TronPackageRegisteryBuilder(
      packages: result,
      imports: [],
    );
    registeryBuilder.write();
  }
}

void main() {
  final builder = TronProtoPackagesBuilder();
  builder.compile();
}

class TronProtoCodegenTarget extends DefaultProtoCodegenTarget {
  @override
  String get messageBaseClassName => "TronProtoMessage";
  static const queryMixinName = "ITronProtoServiceMessage";
  static const List<String> knownQueryServices = [
    "Wallet",
    "WalletSolidity",
    "WalletExtension",
  ];
  final List<String> imports;
  static const List<String> tronContracts = [
    "AccountCreateContract",
    "TransferContract",
    "TransferAssetContract",
    "VoteAssetContract",
    "VoteWitnessContract",
    "WitnessCreateContract",
    "AssetIssueContract",
    "WitnessUpdateContract",
    "ParticipateAssetIssueContract",
    "AccountUpdateContract",
    "FreezeBalanceContract",
    "UnfreezeBalanceContract",
    "WithdrawBalanceContract",
    "UnfreezeAssetContract",
    "UpdateAssetContract",
    "ProposalCreateContract",
    "ProposalApproveContract",
    "ProposalDeleteContract",
    "SetAccountIdContract",
    "CustomContract",
    "CreateSmartContract",
    "TriggerSmartContract",
    "GetContract",
    "UpdateSettingContract",
    "ExchangeCreateContract",
    "ExchangeInjectContract",
    "ExchangeWithdrawContract",
    "ExchangeTransactionContract",
    "UpdateEnergyLimitContract",
    "AccountPermissionUpdateContract",
    "ClearABIContract",
    "UpdateBrokerageContract",
    "ShieldedTransferContract",
    "MarketSellAssetContract",
    "MarketCancelOrderContract",
    "FreezeBalanceV2Contract",
    "UnfreezeBalanceV2Contract",
    "WithdrawExpireUnfreezeContract",
    "DelegateResourceContract",
    "UnDelegateResourceContract",
    "CancelAllUnfreezeV2Contract",
  ];

  static const List<String> skipMessages = [
    ...tronContracts,
    "Transactionraw",
    "TransactionContract",
    "Transaction",
    "Permission",
    "Key",
    "VoteWitnessContractVote",
    "SmartContract",
    "AccountResourceMessage",
    "Any",
  ];

  const TronProtoCodegenTarget({
    this.imports = const [
      'package:on_chain/tron/src/proto_messages/types.dart',
      'package:on_chain/tron/src/serialization/protobuf/proto.dart',
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
  List<String> defaultImports(ProtoFile file) {
    return [...super.defaultImports(file), ...imports];
  }

  static const String tronContract = "ITronContract";
  @override
  List<String> mixinsFor(
    ProtoMessage message,
    ProtoCompiler resolver,
    Set<ProtoTypeLocation> importRefrences,
  ) {
    List<String> mixins = [];

    // if (message.services.isEmpty) return [];

    for (final i in message.services) {
      if (knownQueryServices.contains(i.serviceName)) {
        mixins.add(
          '$queryMixinName<${ProtoRuntimeTypeMapper.bareDartType(type: i.type, importRefrences: importRefrences, resolver: resolver)}>',
        );
        break;
      }
    }
    if (tronContracts.contains(message.fullTypeName())) {
      mixins.add(tronContract);
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
      'DefaultTronProtoTypeUrl get declarationId => DefaultTronProtoTypeUrl.$name;',
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

      buf.writeln('  @override');
      buf.writeln(
        '  ${ProtoRuntimeTypeMapper.bareDartType(type: query, importRefrences: importRefrences, resolver: resolver)} onServiceResponseJson(Map<String, dynamic> json) {',
      );
      buf.writeln(
        "     return ${ProtoRuntimeTypeMapper.bareDartType(type: query, importRefrences: importRefrences, resolver: resolver)}.fromJson(json, config: jsonConfig);",
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
  String? buildToJson(
    ProtoMessage message,
    ProtoCompiler resolver, {
    bool camelCase = false,
    bool allowNullValue = true,
    String configGetter =
        "TronProtoJsonConfig config = TronProtoJsonConfig.config",
  }) {
    if (message.services.isNotEmpty) {
      assert(message.fields.length == 1);
      final buf = StringBuffer();
      buf.writeln('  @override');
      buf.writeln('  Map<String, dynamic> toJson({$configGetter}) {');

      final f = message.fields[0];
      final dartFieldName = OnChainProtoUtils.fieldName(f.name);
      final g = ProtoRuntimeTypeMapper.toJsonValueExpr(
        type: f.type,
        accessor: dartFieldName,
        optional: true,
        resolver: resolver,
        required: f.required,
        options: f.options,
      );
      buf.writeln('    return $g ?? {};');
      buf.writeln('   }');
      return buf.toString();
    }
    return super.buildToJson(
      message,
      resolver,
      camelCase: camelCase,
      configGetter: configGetter,
      allowNullValue: false,
    );
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
        "TronProtoJsonConfig config = TronProtoJsonConfig.config",
  }) {
    if (message.services.isNotEmpty) return null;
    return super.buildFromJson(
      message,
      resolver,
      className,
      importRefrences,
      buf: buf,
      camelCase: camelCase,
      defaultOnMissing: true,
      configGetter: configGetter,
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
            final message = ProtoMessage(
              name: "${service.name}${rpc.name}",
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
    if (message.services.isEmpty) {
      return super.buildConfigMembers(
        message,
        resolver,
        syntax,
        importRefrences,
      );
    }
    final buf = StringBuffer();
    assert(message.fields.length == 1, "unexpected service");
    final field = message.fields.first;
    buf.writeln('  @override');
    buf.writeln(
      '  ProtoMessageConfig protoConfig() =>${OnChainProtoUtils.fieldName(field.name)}?.protoConfig() ?? ProtoMessageConfig();',
    );
    buf.writeln();

    buf.writeln('  @override');
    buf.writeln(
      '  List<Object?> get protoValues => ${OnChainProtoUtils.fieldName(field.name)}?.protoValues?? [];',
    );
    return buf.toString();
  }

  @override
  String buildMessageBodyAndConstructor({
    required ProtoMessage message,
    required ProtoCompiler resolver,
    required Set<ProtoTypeLocation> importRefrences,
    StringBuffer? buf,
    Map<ProtoField, String?> extraFields = const {},
  }) {
    final jsonFile = ProtoField(
      name: "json_config",
      tag: -1,
      type: ProtoMessageRefrence(
        fullName: "TronProtoJsonConfig",
        typeName: "TronProtoJsonConfig",
        package: "",
        nestedName: null,
      ),
      options: [],
      comments: '',
      required: true,
    );
    return super.buildMessageBodyAndConstructor(
      message: message,
      resolver: resolver,
      importRefrences: importRefrences,
      buf: buf,
      extraFields:
          message.services.isEmpty
              ? {}
              : {jsonFile: " TronProtoJsonConfig.config"},
    );
  }
}
