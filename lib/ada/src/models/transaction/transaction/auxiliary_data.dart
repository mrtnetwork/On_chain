import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/metadata/general_transaction_metadata/general_transaction_metadata.dart';
import 'package:on_chain/ada/src/models/metadata/utils/metadata_utils.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';
import 'package:on_chain/ada/src/models/native_script/core/native_script.dart';
import 'package:on_chain/ada/src/models/plutus/plutus_script/language/language.dart';
import 'package:on_chain/ada/src/models/plutus/plutus_script/script/plutus_script.dart';
import 'package:on_chain/ada/src/models/utils.dart';

/// Represents auxiliary data in a transaction.
class AuxiliaryData with ADASerialization {
  final GeneralTransactionMetadata? metadata;
  final List<NativeScript>? nativeScripts;
  final List<PlutusScript>? plutusScripts;
  final bool preferAlonzoFormat;

  AuxiliaryData({
    this.metadata,
    List<NativeScript>? nativeScripts,
    List<PlutusScript>? plutusScripts,
    this.preferAlonzoFormat = false,
  })  : nativeScripts = AdaTransactionUtils.unmodifiable(nativeScripts),
        plutusScripts = AdaTransactionUtils.unmodifiable(plutusScripts);

  /// Constructs an AuxiliaryData object from CBOR bytes.
  factory AuxiliaryData.fromCborBytes(List<int> cborBytes) {
    return AuxiliaryData.deserialize(CborObject.fromCbor(cborBytes));
  }

  factory AuxiliaryData.deserialize(CborObject cbor) {
    TransactionMetadataUtils.validateAuxiliaryDataCbor(cbor);
    if (cbor is CborMapValue) {
      return AuxiliaryData(
          metadata: GeneralTransactionMetadata.deserialize(cbor));
    } else if (cbor is CborListValue) {
      return AuxiliaryData(
        metadata: cbor
            .getIndex<CborObject?>(0)
            ?.castTo<GeneralTransactionMetadata, CborMapValue>(
                (e) => GeneralTransactionMetadata.deserialize(e)),
        nativeScripts: cbor
            .getIndex<CborObject?>(1)
            ?.castTo<List<NativeScript>, CborListValue>((e) =>
                e.value.map((i) => NativeScript.deserialize(i)).toList()),
      );
    } else {
      cbor as CborTagValue;
      final CborMapValue cobrList = cbor.getValue();
      return AuxiliaryData(
          preferAlonzoFormat: true,
          metadata: cobrList
              .getValueFromIntKey<CborObject?>(0)
              ?.castTo<GeneralTransactionMetadata, CborMapValue>(
                  (e) => GeneralTransactionMetadata.deserialize(e)),
          nativeScripts: cobrList
              .getValueFromIntKey<CborObject?>(1)
              ?.castTo<List<NativeScript>, CborListValue>((e) =>
                  e.value.map((i) => NativeScript.deserialize(i)).toList()),
          plutusScripts: cobrList
              .getValueFromIntKey<CborObject?>(2)
              ?.castTo<List<PlutusScript>, CborListValue>((e) {
            final v1 = e.value.map((i) => PlutusScript.deserialize(i)).toList();
            final v2 = cobrList
                .getValueFromIntKey<CborObject?>(3)
                ?.castTo<List<PlutusScript>, CborListValue>((e) {
              return e.value
                  .map((i) =>
                      PlutusScript.deserialize(i, language: Language.plutusV2))
                  .toList();
            });
            return [...v1, ...v2 ?? <PlutusScript>[]];
          }));
    }
  }
  factory AuxiliaryData.fromJson(Map<String, dynamic> json) {
    return AuxiliaryData(
        metadata: json["metadata"] == null
            ? null
            : GeneralTransactionMetadata.fromJson(json["metadata"]),
        nativeScripts: (json["native_scripts"] as List?)
            ?.map((e) => NativeScript.fromJson(e))
            .toList(),
        plutusScripts: (json["plutusScripts"] as List?)
            ?.map((e) => PlutusScript.fromJson(e))
            .toList(),
        preferAlonzoFormat: json["prefer_alonzo_format"]);
  }

  AuxiliaryData copyWith({
    GeneralTransactionMetadata? metadata,
    List<NativeScript>? nativeScripts,
    List<PlutusScript>? plutusScripts,
    bool? preferAlonzoFormat,
  }) {
    return AuxiliaryData(
      metadata: metadata ?? this.metadata,
      nativeScripts: nativeScripts ?? this.nativeScripts,
      plutusScripts: plutusScripts ?? this.plutusScripts,
      preferAlonzoFormat: preferAlonzoFormat ?? this.preferAlonzoFormat,
    );
  }

  @override
  CborObject toCbor() {
    if (!preferAlonzoFormat && metadata != null && plutusScripts == null) {
      if (nativeScripts != null) {
        return CborListValue.fixedLength([
          metadata!.toCbor(),
          CborListValue.fixedLength(
              nativeScripts!.map((e) => e.toCbor()).toList())
        ]);
      }
      return metadata!.toCbor();
    }
    final plutusV2 = CborListValue.fixedLength(plutusScripts
            ?.where((element) => element.language == Language.plutusV2)
            .map((e) => e.toCbor())
            .toList() ??
        []);
    return CborTagValue(
        CborMapValue.fixedLength({
          if (metadata != null) ...{const CborIntValue(0): metadata!.toCbor()},
          if (nativeScripts?.isNotEmpty ?? false) ...{
            const CborIntValue(1): CborListValue.fixedLength(
                nativeScripts!.map((e) => e.toCbor()).toList())
          },
          if (plutusScripts != null) ...{
            const CborIntValue(2): CborListValue.fixedLength(plutusScripts!
                .where((element) => element.language == Language.plutusV1)
                .map((e) => e.toCbor())
                .toList())
          },
          if (plutusV2.value.isNotEmpty) ...{const CborIntValue(3): plutusV2},
        }),
        TransactionMetadataUtils.auxiliaryDataCborTag);
  }

  AuxiliaryDataHash toHash() {
    return AuxiliaryDataHash(QuickCrypto.blake2b256Hash(serialize()));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "metadata": metadata?.toJson(),
      "native_scripts": nativeScripts?.map((e) => e.toJson()).toList(),
      "plutus_scripts": plutusScripts?.map((e) => e.toJson()).toList(),
      "prefer_alonzo_format": preferAlonzoFormat
    };
  }
}
