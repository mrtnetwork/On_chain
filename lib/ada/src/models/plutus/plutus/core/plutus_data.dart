import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/address/address.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/credential/core/stake_cred.dart';
import 'package:on_chain/ada/src/models/credential/core/stake_cred_type.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';
import 'package:on_chain/ada/src/models/plutus/plutus/core/config.dart';
import 'package:on_chain/ada/src/models/plutus/plutus/core/plutus_data_type.dart';
import 'package:on_chain/ada/src/models/plutus/plutus/core/plutus_json_schame.dart';
import 'package:on_chain/ada/src/models/plutus/plutus/types/constr_plutus_data.dart';
import 'package:on_chain/ada/src/models/plutus/plutus/types/integer.dart';
import 'package:on_chain/ada/src/models/plutus/plutus/types/bytes.dart';
import 'package:on_chain/ada/src/models/plutus/plutus/types/list.dart';
import 'package:on_chain/ada/src/models/plutus/plutus/types/map.dart';
import 'package:on_chain/ada/src/models/plutus/utils/utils.dart';

/// Abstract class representing Plutus data.
abstract class PlutusData
    with ADASerialization
    implements Comparable<PlutusData> {
  const PlutusData();

  /// The type of Plutus data.
  abstract final PlutusDataType type;

  /// Constructs a [PlutusData] instance from JSON.
  factory PlutusData.fromJson(Map<String, dynamic> json) {
    PlutusDataType type;
    try {
      type = PlutusDataType.fromName(json.keys.first);
    } on StateError {
      throw MessageException("Invalid PlutusData json.",
          details: {"json": json});
    }
    switch (type) {
      case PlutusDataType.constrPlutusData:
        return ConstrPlutusData.fromJson(json);
      case PlutusDataType.map:
        return PlutusMap.fromJson(json);
      case PlutusDataType.list:
        return PlutusList.fromJson(json);
      case PlutusDataType.integer:
        return PlutusInteger.fromJson(json);
      default:
        return PlutusBytes.fromJson(json);
    }
  }

  /// Constructs a [PlutusData] instance from JSON.
  factory PlutusData.fromJsonSchema({
    required dynamic json,
    required PlutusJsonSchema schema,
  }) {
    return PlutusDataUtils.parsePlutus(json, schema);
  }

  /// Constructs a [PlutusData] instance from its serialized form.
  factory PlutusData.deserialize(CborObject cbor) {
    if (cbor is CborTagValue) {
      return ConstrPlutusData.deserialize(cbor);
    } else if (cbor is CborListValue) {
      return PlutusList.deserialize(cbor);
    } else if (cbor is CborMapValue) {
      return PlutusMap.deserialize(cbor);
    } else if (cbor is CborBytesValue || cbor is CborDynamicBytesValue) {
      return PlutusBytes.deserialize(cbor);
    } else if (cbor is CborNumeric) {
      return PlutusInteger.deserialize(cbor);
    }
    throw MessageException(
      "Invalid cbor object.",
      details: {"Value": cbor, "Type": cbor.runtimeType},
    );
  }

  /// Constructs a [PlutusData] instance from CBOR bytes.
  factory PlutusData.fromCborBytes(List<int> cborBytes) {
    return PlutusData.deserialize(CborObject.fromCbor(cborBytes));
  }

  /// Constructs a [PlutusData] instance from a stake credential.
  factory PlutusData.fromStakeCredential(StakeCred credential) {
    return ConstrPlutusData(
      alternative:
          credential.type == StakeCredType.key ? BigInt.zero : BigInt.one,
      data: PlutusList([
        PlutusBytes(value: credential.data),
      ]),
    );
  }

  /// Constructs a [PlutusData] instance from a pointer.
  factory PlutusData.fromPointer(Pointer pointer) {
    return ConstrPlutusData(
      alternative: BigInt.one,
      data: PlutusList([
        PlutusInteger(pointer.slot),
        PlutusInteger(pointer.txIndex),
        PlutusInteger(pointer.certIndex),
      ]),
    );
  }

  /// Constructs a [PlutusData] instance from an address.
  factory PlutusData.fromAddress(ADAShellyAddress address) {
    PlutusData? stakeData;
    if (address.addressType == ADAAddressType.base) {
      stakeData = ConstrPlutusData(
        alternative: BigInt.zero,
        data: PlutusList([
          PlutusData.fromStakeCredential(
              (address as ADABaseAddress).stakeCredential),
        ]),
      );
    }
    PlutusData? pointerData;
    if (address is ADAPointerAddress) {
      pointerData = PlutusData.fromPointer(address.pointer);
    }
    final PlutusData paymentData =
        PlutusData.fromStakeCredential(address.paymentCredential);

    final PlutusList data = PlutusList([
      paymentData,
      ConstrPlutusData(
        alternative:
            stakeData != null || pointerData != null ? BigInt.zero : BigInt.one,
        data: PlutusList([
          if (pointerData != null || stakeData != null)
            pointerData ?? stakeData!,
        ]),
      ),
    ]);
    return ConstrPlutusData(alternative: BigInt.zero, data: data);
  }

  /// Converts the Plutus data to JSON.
  @override
  dynamic toJson();

  dynamic toJsonSchema({
    PlutusSchemaConfig config =
        const PlutusSchemaConfig(jsonSchema: PlutusJsonSchema.basicConversions),
  });

  /// Converts the Plutus data to its hash representation.
  DataHash toHash() {
    return DataHash(QuickCrypto.blake2b256Hash(serialize()));
  }

  @override
  String toString() {
    return toJson().toString();
  }

  @override
  int compareTo(PlutusData other) {
    return runtimeType.toString().compareTo(other.runtimeType.toString());
  }
}
