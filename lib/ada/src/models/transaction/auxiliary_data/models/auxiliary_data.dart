import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/metadata/models/general_transaction_metadata.dart';
import 'package:on_chain/ada/src/models/metadata/utils/metadata_utils.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';
import 'package:on_chain/ada/src/models/native_script/models/native_script.dart';
import 'package:on_chain/ada/src/models/plutus/plutus_script/models/language.dart';
import 'package:on_chain/ada/src/models/plutus/plutus_script/models/plutus_script.dart';

enum AuxiliaryDataCborEncoding {
  shellyEra,
  alonzoEra,
  conwayEra;

  static AuxiliaryDataCborEncoding fromName(String? name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw const ADAPluginException("Invalid encoding type."));
  }
}

/// Represents auxiliary data in a transaction.
class AuxiliaryData with ADASerialization {
  final GeneralTransactionMetadata? metadata;
  final List<NativeScript>? nativeScripts;
  final List<PlutusScript>? plutusScripts;
  final AuxiliaryDataCborEncoding encoding;

  AuxiliaryData({
    this.metadata,
    List<NativeScript>? nativeScripts,
    List<PlutusScript>? plutusScripts,
    this.encoding = AuxiliaryDataCborEncoding.conwayEra,
  })  : nativeScripts = nativeScripts?.immutable,
        plutusScripts = plutusScripts?.immutable;

  /// Constructs an AuxiliaryData object from CBOR bytes.
  factory AuxiliaryData.fromCborBytes(List<int> cborBytes) {
    return AuxiliaryData.deserialize(CborObject.fromCbor(cborBytes));
  }

  factory AuxiliaryData.deserialize(CborObject cbor) {
    if (cbor.hasType<CborMapValue>()) {
      return AuxiliaryData(
          metadata:
              GeneralTransactionMetadata.deserialize(cbor.as("AuxiliaryData")),
          encoding: AuxiliaryDataCborEncoding.shellyEra);
    }
    if (cbor.hasType<CborListValue>()) {
      final list = cbor.as<CborListValue>("AuxiliaryData");
      return AuxiliaryData(
        encoding: AuxiliaryDataCborEncoding.alonzoEra,
        metadata: list
            .elementAt<CborObject?>(0)
            ?.convertTo<GeneralTransactionMetadata, CborMapValue>(
                (e) => GeneralTransactionMetadata.deserialize(e)),
        nativeScripts: list
            .elementAt<CborObject?>(1)
            ?.convertTo<List<NativeScript>, CborListValue>((e) => e
                .valueAsListOf<CborListValue>()
                .map((i) => NativeScript.deserialize(i))
                .toList()),
      );
    }
    final tag = cbor.as<CborTagValue>("AuxiliaryData");
    final CborMapValue cobrList = tag.valueAs<CborMapValue>("AuxiliaryData");
    final pV1 = cobrList
        .getIntValueAs<CborObject?>(2)
        ?.convertTo<List<PlutusScript>, CborListValue>((e) {
      return e
          .valueAsListOf<CborBytesValue>("plutusScripts")
          .map((i) => PlutusScript.deserialize(i))
          .toList();
    });
    final pV2 = cobrList
        .getIntValueAs<CborObject?>(3)
        ?.convertTo<List<PlutusScript>, CborListValue>((e) {
      return e
          .valueAsListOf<CborBytesValue>("plutusScripts")
          .map((i) => PlutusScript.deserialize(i, language: Language.plutusV2))
          .toList();
    });
    final pV3 = cobrList
        .getIntValueAs<CborObject?>(4)
        ?.convertTo<List<PlutusScript>, CborListValue>((e) {
      return e
          .valueAsListOf<CborBytesValue>("plutusScripts")
          .map((i) => PlutusScript.deserialize(i, language: Language.plutusV3))
          .toList();
    });
    bool hasPlutus = pV1 != null || pV2 != null || pV3 != null;
    final List<PlutusScript> plutus = [
      ...pV1 ?? [],
      ...pV2 ?? [],
      ...pV3 ?? []
    ];
    return AuxiliaryData(
        encoding: AuxiliaryDataCborEncoding.conwayEra,
        metadata: cobrList
            .getIntValueAs<CborObject?>(0)
            ?.convertTo<GeneralTransactionMetadata, CborMapValue>(
                (e) => GeneralTransactionMetadata.deserialize(e)),
        nativeScripts: cobrList
            .getIntValueAs<CborObject?>(1)
            ?.convertTo<List<NativeScript>, CborListValue>((e) => e
                .valueAsListOf<CborListValue>()
                .map((i) => NativeScript.deserialize(i))
                .toList()),
        plutusScripts: hasPlutus ? plutus : null);
  }
  factory AuxiliaryData.fromJson(Map<String, dynamic> json) {
    return AuxiliaryData(
        metadata: json['metadata'] == null
            ? null
            : GeneralTransactionMetadata.fromJson(json['metadata']),
        nativeScripts: (json['native_scripts'] as List?)
            ?.map((e) => NativeScript.fromJson(e))
            .toList(),
        plutusScripts: (json['plutus_scripts'] as List?)
            ?.map((e) => PlutusScript.fromJson(e))
            .toList(),
        encoding: AuxiliaryDataCborEncoding.fromName(json["encoding"]));
  }

  AuxiliaryData copyWith({
    GeneralTransactionMetadata? metadata,
    List<NativeScript>? nativeScripts,
    List<PlutusScript>? plutusScripts,
    AuxiliaryDataCborEncoding? encoding,
  }) {
    return AuxiliaryData(
      metadata: metadata ?? this.metadata,
      nativeScripts: nativeScripts ?? this.nativeScripts,
      plutusScripts: plutusScripts ?? this.plutusScripts,
      encoding: encoding ?? this.encoding,
    );
  }

  @override
  CborObject toCbor() {
    switch (encoding) {
      case AuxiliaryDataCborEncoding.shellyEra:
        return metadata?.toCbor() ??
            CborMapValue.definite(<CborObject, CborObject>{});
      case AuxiliaryDataCborEncoding.alonzoEra:
        return CborListValue.definite([
          metadata?.toCbor() ?? CborNullValue(),
          if (nativeScripts != null)
            CborListValue.definite(
                nativeScripts!.map((e) => e.toCbor()).toList())
        ]);
      case AuxiliaryDataCborEncoding.conwayEra:
        final plutusV2 = CborListValue.definite(plutusScripts
                ?.where((element) => element.language == Language.plutusV2)
                .map((e) => e.toCbor())
                .toList() ??
            <CborObject>[]);
        final plutusV3 = CborListValue.definite(plutusScripts
                ?.where((element) => element.language == Language.plutusV3)
                .map((e) => e.toCbor())
                .toList() ??
            <CborObject>[]);
        return CborTagValue(
            CborMapValue.definite({
              if (metadata != null) ...{
                const CborIntValue(0): metadata!.toCbor()
              },
              if (nativeScripts?.isNotEmpty ?? false) ...{
                const CborIntValue(1): CborListValue.definite(
                    nativeScripts!.map((e) => e.toCbor()).toList())
              },
              if (plutusScripts != null) ...{
                const CborIntValue(2): CborListValue.definite(plutusScripts!
                    .where((element) => element.language == Language.plutusV1)
                    .map((e) => e.toCbor())
                    .toList())
              },
              if (plutusV2.value.isNotEmpty) ...{
                const CborIntValue(3): plutusV2
              },
              if (plutusV3.value.isNotEmpty) ...{
                const CborIntValue(4): plutusV3
              },
            }),
            TransactionMetadataUtils.auxiliaryDataCborTag);
    }
  }

  AuxiliaryDataHash toHash() {
    return AuxiliaryDataHash(QuickCrypto.blake2b256Hash(serialize()));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'metadata': metadata?.toJson(),
      'native_scripts': nativeScripts?.map((e) => e.toJson()).toList(),
      'plutus_scripts': plutusScripts?.map((e) => e.toJson()).toList(),
      'encoding': encoding.name
    };
  }
}
