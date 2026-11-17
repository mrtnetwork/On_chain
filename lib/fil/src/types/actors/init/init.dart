import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/fil/src/crypto/cid/cid.dart';
import 'package:on_chain/fil/src/serialization/seriaization.dart';

/// Parameters for **Init.Exec** (method 2).
///
/// Used to create new built-in actors such as Multisig or PaymentChannel.
/// The message is sent to the Init actor (`f01` / `t01`) with:
/// - [codeCid] – code CID of the actor type to instantiate
/// - [constructorParams] – already CBOR-encoded constructor parameters
///
/// On success the Init actor returns [FilExecReturn] containing the new
/// ID address and robust (actor) address.
///
/// Example:
/// ```dart
/// final exec = FilInitExecParams(
///   codeCid: network.getLatestActor(FilActorNames.multisig).cid,
///   constructorParams: FilMultisigConstructorParams(...).toCbor().encode(),
/// );
/// ```
class FilInitExecParams with FilSerialization {
  /// Code CID of the actor to create (e.g. latest Multisig or Paych CID).
  final Cid codeCid;

  /// CBOR-encoded constructor parameters for the target actor.
  final BuBytes constructorParams;

  FilInitExecParams({
    required this.codeCid,
    required List<int> constructorParams,
  }) : constructorParams = constructorParams.asImmutableBytes;

  @override
  CborListValue toCbor() {
    return CborSerializable.listFromObjects([
      codeCid.builder().toCbor(),
      constructorParams.toCborBytes(),
    ]);
  }

  Map<String, dynamic> toJson() => {
    'CodeCid': codeCid,
    'ConstructorParams': constructorParams,
  };
}
