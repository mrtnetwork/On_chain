import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/numbers/numbers.dart';
import 'package:on_chain/ada/src/address/era/core/address.dart';
import 'package:on_chain/ada/src/address/era/shelly/ada_reward_address.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';

class Withdrawals with ADASerialization {
  final Map<ADAAddress, BigInt> withdrawals;

  Withdrawals(Map<ADAAddress, BigInt> withdrawals)
      : withdrawals = Map<ADARewardAddress, BigInt>.unmodifiable(withdrawals);
  factory Withdrawals.deserialize(CborMapValue cbor) {
    return Withdrawals({
      for (final i
          in cbor.cast<CborMapValue<CborObject, CborObject>>().value.entries)
        ADAAddress.deserialize<ADARewardAddress>(i.key.cast()):
            i.value.getInteger()
    });
  }
  factory Withdrawals.fromJson(Map<String, dynamic> json) {
    return Withdrawals({
      for (final i in json.entries)
        ADAAddress.fromAddress(i.key): BigintUtils.parse(i.value)
    });
  }
  Withdrawals copyWith({Map<ADAAddress, BigInt>? withdrawals}) {
    return Withdrawals(withdrawals ?? this.withdrawals);
  }

  @override
  CborObject toCbor() {
    return CborMapValue.fixedLength({
      for (final i in withdrawals.entries)
        i.key.toCbor(): CborUnsignedValue.u64(i.value)
    });
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      for (final i in withdrawals.entries) i.key.toJson(): i.value.toString()
    };
  }
}
