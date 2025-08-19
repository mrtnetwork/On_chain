import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/ada/src/address/era/core/address.dart';
import 'package:on_chain/ada/src/address/era/shelly/ada_reward_address.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';

class Withdrawals with ADASerialization {
  final Map<ADARewardAddress, BigInt> withdrawals;

  Withdrawals(Map<ADARewardAddress, BigInt> withdrawals)
      : withdrawals = Map<ADARewardAddress, BigInt>.unmodifiable(withdrawals);
  factory Withdrawals.deserialize(CborMapValue cbor) {
    return Withdrawals({
      for (final i in cbor.valueAsMap<CborObject, CborObject>().entries)
        ADAAddress.deserialize<ADARewardAddress>(i.key.as("Withdrawals")):
            i.value.as<CborNumeric>("Withdrawals").toBigInt()
    });
  }
  factory Withdrawals.fromJson(Map<String, dynamic> json) {
    return Withdrawals({
      for (final i in (json["withdrawals"] as Map).entries)
        ADAAddress.fromAddress(i.key): BigintUtils.parse(i.value)
    });
  }
  Withdrawals copyWith({Map<ADARewardAddress, BigInt>? withdrawals}) {
    return Withdrawals(withdrawals ?? this.withdrawals);
  }

  @override
  CborObject toCbor() {
    return CborMapValue.definite({
      for (final i in withdrawals.entries)
        i.key.toCbor(): CborUnsignedValue.u64(i.value)
    });
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "withdrawals": {
        for (final i in withdrawals.entries) i.key.toJson(): i.value.toString()
      }
    };
  }
}
