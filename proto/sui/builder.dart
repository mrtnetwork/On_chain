import 'dart:io';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:onchain_proto/onchain_proto.dart';

class SuiPackageRegisteryBuilder {
  final List<ProtoWritePackageResult> packages;
  final List<String> imports;
  const SuiPackageRegisteryBuilder({
    required this.packages,
    this.imports = const [],
  });

  void _writeTypeUrl() {
    final buf = StringBuffer();
    buf.writeln("import 'package:blockchain_utils/blockchain_utils.dart';");
    buf.writeln(
      "import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';",
    );
    buf.writeln('enum DefaultSuiProtoTypeUrl implements SuiProtoTypeUrl {');
    final messages =
        packages
            .expand((e) => e.files)
            .expand((e) => e.fileData.classInfo)
            .toList();
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
      ' const DefaultSuiProtoTypeUrl({required this.typeUrl, this.serviceUrl});',
    );
    buf.writeln('  static DefaultSuiProtoTypeUrl? fromUrl(String? value) {');
    buf.writeln(
      '    return DefaultSuiProtoTypeUrl.values.firstWhereNullable(',
    );
    buf.writeln('      (e) => e.typeUrl == value || e.serviceUrl == value,');
    buf.writeln('  );');
    buf.writeln('  }');
    buf.writeln(' String getServiceUrl() {');
    buf.writeln('    final serviceUrl = this.serviceUrl;');
    buf.writeln('    if (serviceUrl == null) {throw ItemNotFoundException(); }');
    buf.writeln('    return serviceUrl;');
    buf.writeln('  }');
    buf.writeln('}');
    File("lib/sui/src/proto_messages/types.dart")
      ..createSync(recursive: true)
      ..writeAsStringSync(buf.toString());
  }

  void write() {
    _writeTypeUrl();
  }
}

class SuiProtoPackagesBuilder {
  final ProtoCompiler compiler;
  const SuiProtoPackagesBuilder._({required this.compiler});
  factory SuiProtoPackagesBuilder() {
    final compiler = ProtoCompiler.fromDirectory(
      classNamePrefix: 'Sui',
      builder: SuiProtoCodegenTarget(),
      writer: ProtoPackageWriter(
        packageRoot: "package:on_chain/sui/src/proto_messages",
        outputRoot: "lib/sui/src/proto_messages",
        skipMessages: const [
          // `google.protobuf.Any` is served by the blockchain_utils runtime;
          // generating it would clash with `SuiProtoMessage.typeUrl()`.
          SkipMessages(
            fullTypeName: "Any",
            package: "google.protobuf",
            importPath:
                "package:blockchain_utils/encoding/proto/google/any.dart",
          ),
        ],
      ),
      sourceDirectory: "proto/sui",
    );
    return SuiProtoPackagesBuilder._(compiler: compiler);
  }

  void compile() {
    compiler.compile();
    final result = compiler.writeAll(writeToFile: true);
    _postProcess();
    final registeryBuilder = SuiPackageRegisteryBuilder(
      packages: result,
      imports: [],
    );
    registeryBuilder.write();
  }

  /// Mechanical post-process (re-applied on every run; no hand logic lands
  /// in generated files):
  /// - maps the skipped `google.protobuf.Any` reference to the shared
  ///   runtime type (the skip prefix makes it unresolvable otherwise);
  /// - rewrites WKT static factories to [SuiWktUtils] in
  ///   `serialization/protobuf/wkt.dart` (extensions cannot add statics);
  /// - imports `wkt.dart` wherever WKT JSON helpers are used.
  void _postProcess() {
    final root = Directory('lib/sui/src/proto_messages');
    for (final entity in root.listSync(recursive: true)) {
      if (entity is! File || !entity.path.endsWith('.dart')) continue;
      if (entity.path.endsWith('types.dart')) continue;
      var content = entity.readAsStringSync();
      var patched = content;
      if (patched.contains('google_protobuf_any.SuiAny')) {
        patched = patched
            .replaceAll('google_protobuf_any.SuiAny', 'ProtoGoogleAny')
            .replaceAll(
              'import "package:blockchain_utils/encoding/proto/google/any.dart" as google_protobuf_any;\n',
              '',
            );
      }
      patched = patched
          .replaceAll(
            'SuiTimestamp.fromRfc3339(',
            'SuiWktUtils.timestampFromRfc3339(',
          )
          .replaceAll(
            'SuiDuration.fromString(',
            'SuiWktUtils.durationFromString(',
          );
      if (patched.contains('.toRfc3339()') ||
          patched.contains('.encodeString(') ||
          patched.contains('SuiWktUtils.timestampFromRfc3339(') ||
          patched.contains('SuiWktUtils.durationFromString(')) {
        const wktImport =
            "import 'package:on_chain/sui/src/serialization/protobuf/wkt.dart';\n";
        if (!patched.contains(wktImport)) {
          patched = patched.replaceFirst(
            "import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';",
            "import 'package:on_chain/sui/src/serialization/protobuf/proto.dart';\n$wktImport",
          );
        }
      }
      if (patched != content) entity.writeAsStringSync(patched);
    }
  }
}

class SuiProtoCodegenTarget extends DefaultProtoCodegenTarget {
  @override
  String get messageBaseClassName => "SuiProtoMessage";
  static const queryMixinName = "ISuiProtoServiceMessage";

  /// Unary gRPC services wired into request messages. SubscriptionService
  /// (streaming) is included for method URLs; streaming calls go through
  /// `provider.requestStream` with [SuiGrpcRequestMessage].
  static const List<String> knownQueryServices = [
    "LedgerService",
    "StateService",
    "MovePackageService",
    "SignatureVerificationService",
    "TransactionExecutionService",
    "NameService",
    "SubscriptionService",
  ];

  const SuiProtoCodegenTarget({
    this.imports = const [
      'package:on_chain/sui/src/proto_messages/types.dart',
      'package:on_chain/sui/src/serialization/protobuf/proto.dart',
    ],
  });
  final List<String> imports;

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

  @override
  List<String> mixinsFor(
    ProtoMessage message,
    ProtoCompiler resolver,
    Set<ProtoTypeLocation> importRefrences,
  ) {
    final List<String> mixins = [];
    for (final i in message.services) {
      if (knownQueryServices.contains(i.serviceName)) {
        mixins.add(
          '$queryMixinName<${ProtoRuntimeTypeMapper.bareDartType(type: i.type, importRefrences: importRefrences, resolver: resolver)}>',
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
    final name = OnChainProtoUtils.snakeToCamel(
      "${message.package}.${message.fullName()}".replaceAll(".", "_"),
      capitalizeFirst: false,
    );
    final buf = StringBuffer();
    buf.writeln('  @override');
    buf.writeln(
      'DefaultSuiProtoTypeUrl get declarationId => DefaultSuiProtoTypeUrl.$name;',
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
        "    return ${ProtoRuntimeTypeMapper.bareDartType(type: query, importRefrences: importRefrences, resolver: resolver)}.fromJson(json);",
      );
      buf.writeln('  }');
    }
    return buf.toString();
  }

  @override
  List<ProtoService> filterServices(List<ProtoService> services) {
    return services.where((e) => knownQueryServices.contains(e.name)).toList();
  }
}

/// running from root directory of project
/// on_chain$ dart run proto/sui/builder.dart
void main() {
  final builder = SuiProtoPackagesBuilder();
  builder.compile();
}
