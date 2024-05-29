import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/address/era/core/address.dart';
import 'package:on_chain/ada/src/address/utils/utils.dart';
import 'package:on_chain/ada/src/models/transaction/output/models/multi_assets.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/data_options/core/data_option.dart';
import 'package:on_chain/ada/src/models/data_options/core/data_option_type.dart';
import 'package:on_chain/ada/src/models/transaction/output/script_ref/core/script_ref.dart';
import 'package:on_chain/ada/src/models/transaction/output/models/value.dart';

/// Represents a transaction output.
class TransactionOutput with ADASerialization {
  /// The address of the output.
  final ADAAddress address;

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
      this.scriptRef});
  factory TransactionOutput.fromJson(Map<String, dynamic> json) {
    return TransactionOutput(
        address: ADAAddress.fromAddress(json["address"]),
        amount: Value.fromJson(json["amount"]),
        plutusData: json["plutus_data"] == null
            ? null
            : DataOption.fromJson(json["plutus_data"]),
        scriptRef: json["script_ref"] == null
            ? null
            : ScriptRef.fromJson(json["script_ref"]));
  }

  /// Deserializes a [TransactionOutput] instance from a CBOR object.
  factory TransactionOutput.deserialize(CborObject cbor) {
    if (cbor is CborListValue) {
      final address = AdaAddressUtils.encodeBytes(cbor.getIndex<List<int>>(0));
      return TransactionOutput(
          address: address,
          amount: Value.deserialize(cbor.getIndex<CborObject>(1)),
          plutusData: cbor
              .getIndex<CborObject?>(2)
              ?.to<DataOption, CborObject>((e) => DataOption.deserialize(e)),
          scriptRef: cbor
              .getIndex<CborObject?>(3)
              ?.to<ScriptRef, CborListValue>((e) => ScriptRef.deserialize(e)));
    }
    final CborMapValue<CborObject, CborObject> cborMap = cbor.cast();
    final address =
        AdaAddressUtils.encodeBytes(cborMap.getValueFromIntKey<List<int>>(0));
    return TransactionOutput(
        address: address,
        amount: Value.deserialize(cborMap.getValueFromIntKey(1)),
        plutusData: cborMap
            .getValueFromIntKey<CborObject?>(2)
            ?.to<DataOption, CborObject>((e) => DataOption.deserialize(e)),
        scriptRef: cborMap
            .getValueFromIntKey<CborTagValue?>(3)
            ?.to<ScriptRef, CborTagValue>((e) => ScriptRef.deserialize(e)));
  }
  TransactionOutput copyWith({
    ADAAddress? address,
    Value? amount,
    DataOption? plutusData,
    ScriptRef? scriptRef,
  }) {
    return TransactionOutput(
      address: address ?? this.address,
      amount: amount ?? this.amount,
      plutusData: plutusData ?? this.plutusData,
      scriptRef: scriptRef ?? this.scriptRef,
    );
  }

  @override
  CborObject toCbor() {
    if (scriptRef != null ||
        plutusData?.type == TransactionDataOptionType.data) {
      return CborMapValue.fixedLength({
        const CborIntValue(0): address.toCbor(),
        const CborIntValue(1): amount.toCbor(),
        if (plutusData != null) ...{
          const CborIntValue(2): plutusData!.toCbor(false)
        },
        if (scriptRef != null) ...{
          const CborIntValue(3): scriptRef!.toScriptRefCbor()
        }
      });
    }
    return CborListValue.fixedLength([
      address.toCbor(),
      amount.toCbor(),
      if (plutusData != null) plutusData!.toCbor(true)
    ]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "address": address.toJson(),
      "amount": amount.toJson(),
      "plutus_data": plutusData?.toJson(),
      "script_ref": scriptRef?.toJson()
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
