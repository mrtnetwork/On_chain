import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/bcs/serialization.dart';
import 'package:on_chain/sui/src/exception/exception.dart';
import 'package:on_chain/sui/src/transaction/types/types.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

class SuiIntentMessage extends BcsSerialization {
  final SuiIntent intent;
  final BcsSerialization message;
  const SuiIntentMessage({required this.intent, required this.message});
  static (SuiIntentMessage, int) deserializeWithConsumedLength(List<int> bytes,
      {String? property}) {
    final intent = SuiIntent.deserialize(bytes);
    switch (intent.scope) {
      case SuiIntentScope.transactionData:
        final layout = LayoutConst.struct([
          SuiIntent.layout(property: "intent"),
          SuiTransactionData.layout(property: "message")
        ], property: property);
        final decode = layout.deserialize(bytes);
        return (SuiIntentMessage.fromStruct(decode.value), decode.consumed);
      default:
        throw DartSuiPluginException("Intent message does not supported.",
            details: {
              "scope": intent.scope.name,
              "version": intent.version.name,
              "application_id": intent.applicationId.name
            });
    }
  }

  factory SuiIntentMessage.deserialize(List<int> bytes, {String? property}) {
    return deserializeWithConsumedLength(bytes).$1;
  }
  factory SuiIntentMessage.fromStruct(Map<String, dynamic> json) {
    final intent = SuiIntent.fromStruct(json.asMap("intent"));
    return switch (intent.scope) {
      SuiIntentScope.transactionData => SuiIntentMessage(
          intent: intent,
          message: SuiTransactionData.fromStruct(json.asMap("message"))),
      _ => throw DartSuiPluginException("Intent message does not supported.",
            details: {
              "scope": intent.scope.name,
              "version": intent.version.name,
              "application_id": intent.applicationId.name
            })
    };
  }

  factory SuiIntentMessage.transactionData(
      {required SuiTransactionData transaction, SuiIntent? intent}) {
    return SuiIntentMessage(
        intent: intent ??
            SuiIntent(
                scope: SuiIntentScope.transactionData,
                version: SuiIntentVersion.v0,
                applicationId: SuiIntentApplicationId.sui),
        message: transaction);
  }
  factory SuiIntentMessage.personalMessage(SuiPersonalMessage message) {
    return SuiIntentMessage(
        intent: SuiIntent(
            scope: SuiIntentScope.personalMessage,
            version: SuiIntentVersion.v0,
            applicationId: SuiIntentApplicationId.sui),
        message: message);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return LayoutConst.struct([
      intent.createLayout(property: "intent"),
      if (message.serializableType == BcsSerializableType.variant)
        (message as BcsVariantSerialization)
            .createVariantLayout(property: "message")
      else
        message.createLayout(property: "message"),
    ], property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    Map<String, dynamic> message = {};
    if (this.message.serializableType == BcsSerializableType.variant) {
      message =
          (this.message as BcsVariantSerialization).toVariantLayoutStruct();
    } else {
      message = this.message.toLayoutStruct();
    }
    return {"intent": intent.toLayoutStruct(), "message": message};
  }
}

class SuiPersonalMessage extends BcsSerialization {
  final List<int> message;
  SuiPersonalMessage({required List<int> message})
      : message = message.asImmutableBytes;
  factory SuiPersonalMessage.deserialize(List<int> bytes) {
    final decode = BcsSerialization.deserialize(bytes: bytes, layout: layout());
    return SuiPersonalMessage.fromStruct(decode);
  }
  factory SuiPersonalMessage.fromStruct(Map<String, dynamic> json) {
    return SuiPersonalMessage(message: json.asBytes("message"));
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([LayoutConst.bcsBytes(property: "message")],
        property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"message": message};
  }
}

class SuiIntentScope extends BcsVariantSerialization {
  final String name;
  final int value;
  const SuiIntentScope._({required this.name, required this.value});
  factory SuiIntentScope.fromStruct(Map<String, dynamic> json) {
    final decode = BcsVariantSerialization.toVariantDecodeResult(json);
    return fromName(decode.variantName);
  }

  /// Used for a user signature on a transaction data.
  static const SuiIntentScope transactionData =
      SuiIntentScope._(name: "TransactionData", value: 0);

  /// Used for an authority signature on transaction effects.
  static const SuiIntentScope transactionEffects =
      SuiIntentScope._(name: "TransactionEffects", value: 1);

  /// Used for an authority signature on a checkpoint summary.
  static const SuiIntentScope checkpointSummary =
      SuiIntentScope._(name: "CheckpointSummary", value: 2);

  /// Used for a user signature on a personal message.
  static const SuiIntentScope personalMessage =
      SuiIntentScope._(name: "PersonalMessage", value: 3);

  /// Used for an authority signature on a user signed transaction.
  static const SuiIntentScope senderSignedTransaction =
      SuiIntentScope._(name: "SuiSenderSignedTransaction", value: 4);

  /// Used as a signature representing an authority's proof of possession of its authority protocol key.
  static const SuiIntentScope proofOfPossession =
      SuiIntentScope._(name: "ProofOfPossession", value: 5);

  /// Used for narwhal authority signature on header digest.
  static const SuiIntentScope headerDigest =
      SuiIntentScope._(name: "HeaderDigest", value: 6);

  /// for bridge purposes but it's currently not included in messages.
  static const SuiIntentScope bridgeEventUnused =
      SuiIntentScope._(name: "BridgeEventUnused", value: 7);

  /// Used for consensus authority signature on block's digest.
  static const SuiIntentScope consensusBlock =
      SuiIntentScope._(name: "ConsensusBlock", value: 8);

  /// Used for reporting peer addresses in discovery.
  static const SuiIntentScope discoveryPeers =
      SuiIntentScope._(name: "DiscoveryPeers", value: 9);

  static const List<SuiIntentScope> values = [
    transactionData,
    transactionEffects,
    checkpointSummary,
    personalMessage,
    senderSignedTransaction,
    proofOfPossession,
    headerDigest,
    bridgeEventUnused,
    consensusBlock,
    discoveryPeers
  ];

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return LayoutConst.noArgs(property: property);
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.lazyEnum(
        values
            .map((e) => LazyVariantModel(
                layout: LayoutConst.noArgs, property: e.name, index: e.value))
            .toList(),
        property: property);
  }

  @override
  Layout<Map<String, dynamic>> createVariantLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {};
  }

  @override
  String get variantName => name;
  static SuiIntentScope fromName(String name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw DartSuiPluginException(
            "cannot find correct scope from the given name.",
            details: {"name": name}));
  }
}

class SuiIntentVersion extends BcsVariantSerialization {
  final String name;
  final int value;
  const SuiIntentVersion._({required this.name, required this.value});
  factory SuiIntentVersion.fromStruct(Map<String, dynamic> json) {
    final decode = BcsVariantSerialization.toVariantDecodeResult(json);
    return fromName(decode.variantName);
  }
  static const SuiIntentVersion v0 = SuiIntentVersion._(name: "V0", value: 0);
  static const List<SuiIntentVersion> values = [v0];
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.lazyEnum(
        values
            .map((e) => LazyVariantModel(
                layout: LayoutConst.noArgs, property: e.name, index: e.value))
            .toList(),
        property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return LayoutConst.noArgs(property: property);
  }

  @override
  Layout<Map<String, dynamic>> createVariantLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {};
  }

  @override
  String get variantName => name;
  static SuiIntentVersion fromName(String name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw DartSuiPluginException(
            "cannot find correct intent version from the given name.",
            details: {"name": name}));
  }
}

class SuiIntentApplicationId extends BcsVariantSerialization {
  final String name;
  final int value;
  const SuiIntentApplicationId._({required this.name, required this.value});
  static const SuiIntentApplicationId sui =
      SuiIntentApplicationId._(name: "Sui", value: 0);
  static const List<SuiIntentApplicationId> values = [sui];
  factory SuiIntentApplicationId.fromStruct(Map<String, dynamic> json) {
    final decode = BcsVariantSerialization.toVariantDecodeResult(json);
    return fromName(decode.variantName);
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.lazyEnum(
        values
            .map((e) => LazyVariantModel(
                layout: LayoutConst.noArgs, property: e.name, index: e.value))
            .toList(),
        property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return LayoutConst.noArgs(property: property);
  }

  @override
  Layout<Map<String, dynamic>> createVariantLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {};
  }

  @override
  String get variantName => name;
  static SuiIntentApplicationId fromName(String name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw DartSuiPluginException(
            "cannot find correct application ID from the given name.",
            details: {"name": name}));
  }
}

class SuiIntent extends BcsSerialization {
  final SuiIntentScope scope;
  final SuiIntentVersion version;
  final SuiIntentApplicationId applicationId;
  const SuiIntent(
      {required this.scope,
      required this.version,
      required this.applicationId});
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      SuiIntentScope.layout(property: "scope"),
      SuiIntentVersion.layout(property: "version"),
      SuiIntentApplicationId.layout(property: 'applicationId')
    ], property: property);
  }

  factory SuiIntent.deserialize(List<int> bytes, {String? property}) {
    final decode = BcsSerialization.deserialize(
        bytes: bytes, layout: layout(property: property));
    return SuiIntent.fromStruct(decode);
  }
  factory SuiIntent.fromStruct(Map<String, dynamic> json) {
    return SuiIntent(
        scope: SuiIntentScope.fromStruct(json.asMap("scope")),
        version: SuiIntentVersion.fromStruct(json.asMap("version")),
        applicationId:
            SuiIntentApplicationId.fromStruct(json.asMap("applicationId")));
  }
  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {
      "scope": scope.toVariantLayoutStruct(),
      "version": version.toVariantLayoutStruct(),
      "applicationId": applicationId.toVariantLayoutStruct()
    };
  }
}
