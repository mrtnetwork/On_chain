import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/address/address.dart';
import 'package:on_chain/ada/src/models/credential/core/stake_cred.dart';
import 'package:on_chain/ada/src/models/credential/core/stake_cred_type.dart';

/// Represents a stake credential using a public key.
class StakeCredKey extends StakeCred {
  /// Constructs a [StakeCredKey] with the specified [data].
  StakeCredKey(super.data);

  /// Constructs a [StakeCredKey] from a hexadecimal string [hexBytes].
  StakeCredKey.fromHex(super.hexBytes) : super.fromHex();

  /// Constructs a [StakeCredKey] from a public key [pubKeyBytes].
  /// It derives the credential from the public key bytes using hashing.
  StakeCredKey.fromPublicKey(List<int> pubKeyBytes)
      : super(AdaAddressUtils.publicKeyToHash(pubKeyBytes));

  /// Deserializes a [StakeCredKey] from CBOR bytes [cbor].
  factory StakeCredKey.deserialize(CborBytesValue cbor) {
    return StakeCredKey(cbor.value);
  }

  /// Returns the type of this stake credential, which is [StakeCredType.key].
  @override
  StakeCredType get type => StakeCredType.key;

  @override
  Map<String, dynamic> toJson() {
    return {'key': super.toJson()};
  }
}
