import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/models/credential/core/stake_cred.dart';
import 'package:on_chain/ada/src/models/credential/core/stake_cred_type.dart';

/// Represents a stake credential using a script.
class StakeCredScript extends StakeCred {
  /// Constructs a [StakeCredScript] with the specified [data].
  StakeCredScript(List<int> data) : super(data);

  /// Constructs a [StakeCredScript] from a hexadecimal string [hexBytes].
  StakeCredScript.fromHex(String hexBytes) : super.fromHex(hexBytes);

  /// Deserializes a [StakeCredScript] from CBOR bytes [cbor].
  factory StakeCredScript.deserialize(CborBytesValue cbor) {
    return StakeCredScript(cbor.value);
  }

  /// Returns the type of this stake credential, which is [StakeCredType.script].
  @override
  StakeCredType get type => StakeCredType.script;

  @override
  Map<String, dynamic> toJson() {
    return {"script": super.toJson()};
  }
}
