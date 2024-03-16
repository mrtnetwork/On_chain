import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/credential/core/stake_cred_type.dart';
import 'package:on_chain/ada/src/models/credential/key.dart';
import 'package:on_chain/ada/src/models/credential/script.dart';
import 'package:on_chain/ada/src/models/constant.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/core/fixed_bytes.dart';

/// Represents a stake credential.
abstract class StakeCred extends FixedBytes {
  /// Constructs a [StakeCred] instance with the specified [hashBytes].
  StakeCred(List<int> hashBytes)
      : super(hashBytes, AdaTransactionConstant.blake2b224DigestSize);

  /// Constructs a [StakeCred] instance from a hexadecimal string [hexBytes].
  StakeCred.fromHex(String hexBytes)
      : super.fromHex(hexBytes, AdaTransactionConstant.blake2b224DigestSize);

  /// Deserializes a [StakeCred] from a CBOR list value [cbor].
  factory StakeCred.deserialize(CborListValue cbor) {
    final type = StakeCredType.deserialize(cbor.getIndex(0));
    switch (type) {
      case StakeCredType.key:
        return StakeCredKey(cbor.getIndex(1));
      default:
        return StakeCredScript(cbor.getIndex(1));
    }
  }
  factory StakeCred.fromJson(Map<String, dynamic> json) {
    final type = StakeCredType.fromName(json.keys.first);
    switch (type) {
      case StakeCredType.key:
        return StakeCredKey.fromHex(json[type.name]);
      default:
        return StakeCredScript.fromHex(json[type.name]);
    }
  }

  /// Returns the type of the stake credential.
  StakeCredType get type;

  @override
  CborObject toCbor() {
    return CborListValue.fixedLength([
      type.toCbor(),
      super.toCbor(),
    ]);
  }
}
