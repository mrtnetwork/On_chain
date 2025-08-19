import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/address/era/core/address.dart';
import 'package:on_chain/ada/src/address/utils/utils.dart';
import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/ada/src/models/transaction/assets/models/multi_assets.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/data_options/models/data_option.dart';
import 'package:on_chain/ada/src/models/transaction/output/models/script_ref.dart';
import 'package:on_chain/ada/src/models/transaction/assets/models/value.dart';

enum TransactionOutputCborEncoding {
  shellyEra,
  alonzoEra;

  static TransactionOutputCborEncoding fromName(String? name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => throw const ADAPluginException("Invalid encoding type."));
  }
}

class TransactionOutputSerializationConfig {
  final TransactionOutputCborEncoding encoding;
  const TransactionOutputSerializationConfig(
      {this.encoding = TransactionOutputCborEncoding.alonzoEra});
  factory TransactionOutputSerializationConfig.fromJson(
      Map<String, dynamic> json) {
    return TransactionOutputSerializationConfig(
        encoding: json["encoding"] == null
            ? TransactionOutputCborEncoding.alonzoEra
            : TransactionOutputCborEncoding.fromName(json["encoding"]));
  }
  Map<String, dynamic> toJson() {
    return {"encoding": encoding.name};
  }
}

/// Represents a transaction output.
class TransactionOutput with ADASerialization {
  // final ADAObjectCborEncodingType encoding;

  /// The address of the output.
  final ADAAddress address;
  final TransactionOutputSerializationConfig serializationConfig;

  /// The value of the output.
  final Value amount;

  /// Plutus data associated with the output, if any.
  final DataOption? plutusData;

  /// Script reference associated with the output, if any.
  final ScriptRef? scriptRef;

  /// Constructs a [TransactionOutput] instance.
  const TransactionOutput(
      {required this.address,
      required this.amount,
      this.plutusData,
      this.scriptRef,
      this.serializationConfig = const TransactionOutputSerializationConfig()});
  factory TransactionOutput.fromJson(Map<String, dynamic> json) {
    return TransactionOutput(
        address: ADAAddress.fromAddress(json['address']),
        amount: Value.fromJson(json['amount']),
        serializationConfig: TransactionOutputSerializationConfig.fromJson(
            json["serialization_config"] ?? {}),
        plutusData: json['plutus_data'] == null
            ? null
            : DataOption.fromJson(json['plutus_data']),
        scriptRef: json['script_ref'] == null
            ? null
            : ScriptRef.fromJson(json['script_ref']));
  }

  /// Deserializes a [TransactionOutput] instance from a CBOR object.
  factory TransactionOutput.deserialize(CborObject cbor) {
    if (cbor.hasType<CborListValue>()) {
      final list = cbor.as<CborListValue>("TransactionOutput");
      final address =
          AdaAddressUtils.encodeBytes(list.elementAt<CborBytesValue>(0).value);
      return TransactionOutput(
          address: address,
          amount: Value.deserialize(list.elementAt<CborObject>(1)),
          plutusData: list
              .elementAt<CborObject?>(2)
              ?.convertTo<DataOption, CborObject>(
                  (e) => DataOption.deserialize(e)),
          scriptRef: list
              .elementAt<CborObject?>(3)
              ?.convertTo<ScriptRef, CborListValue>(
                  (e) => ScriptRef.deserialize(e)),
          serializationConfig: TransactionOutputSerializationConfig(
              encoding: TransactionOutputCborEncoding.shellyEra));
    }

    final CborMapValue<CborObject, CborObject> cborMap =
        cbor.as("TransactionOutput");
    final address = AdaAddressUtils.encodeBytes(
        cborMap.getIntValueAs<CborBytesValue>(0).value);
    return TransactionOutput(
        address: address,
        amount: Value.deserialize(cborMap.getIntValueAs<CborObject>(1)),
        plutusData: cborMap
            .getIntValueAs<CborObject?>(2)
            ?.convertTo<DataOption, CborObject>(
                (e) => DataOption.deserialize(e)),
        scriptRef: cborMap
            .getIntValueAs<CborTagValue?>(3)
            ?.convertTo<ScriptRef, CborTagValue>(
                (e) => ScriptRef.deserialize(e)));
  }
  TransactionOutput copyWith(
      {ADAAddress? address,
      Value? amount,
      DataOption? plutusData,
      ScriptRef? scriptRef,
      TransactionOutputSerializationConfig? serializationConfig}) {
    return TransactionOutput(
        address: address ?? this.address,
        amount: amount ?? this.amount,
        plutusData: plutusData ?? this.plutusData,
        scriptRef: scriptRef ?? this.scriptRef,
        serializationConfig: serializationConfig ?? this.serializationConfig);
  }

  @override
  CborObject toCbor() {
    switch (serializationConfig.encoding) {
      case TransactionOutputCborEncoding.alonzoEra:
        return CborMapValue.definite({
          const CborIntValue(0): address.toCbor(),
          const CborIntValue(1): amount.toCbor(),
          if (plutusData != null)
            const CborIntValue(2): plutusData!.toCbor(false),
          if (scriptRef != null)
            const CborIntValue(3): scriptRef!.toScriptRefCbor()
        });
      case TransactionOutputCborEncoding.shellyEra:
        return CborListValue.definite([
          address.toCbor(),
          amount.toCbor(),
          if (plutusData != null) plutusData!.toCbor(true)
        ]);
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'address': address.toJson(),
      'amount': amount.toJson(),
      'plutus_data': plutusData?.toJson(),
      'script_ref': scriptRef?.toJson(),
      'serialization_config': serializationConfig.toJson()
    };
  }

  /// In the Babbage era, unspent transaction outputs will be required to contain at least
  /// [coinsPerUtxoSize] its epoch porotocol parameters variable
  /// in this case this output value should not be lower than result
  BigInt minAda(int coinsPerUtxoSize) {
    return BigInt.from((160 + serialize().length) * coinsPerUtxoSize);
  }
}

extension QuickTransactionOutput on List<TransactionOutput> {
  BigInt get sumOflovelace {
    return fold<BigInt>(BigInt.zero,
        (previousValue, element) => previousValue + element.amount.coin);
  }

  MultiAsset get multiAsset {
    return fold(
        MultiAsset({}),
        (previousValue, element) =>
            previousValue + (element.amount.multiAsset ?? MultiAsset.empty));
  }
}
