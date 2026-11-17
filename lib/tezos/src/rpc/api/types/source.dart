import 'package:blockchain_utils/chain/address/address.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/tezos/src/address/address.dart';
import 'package:on_chain/tezos/src/crypto/crypto.dart';
import 'package:on_chain/tezos/src/operations/operations/content.dart';

abstract class TezosOperationSource {
  final TezosAddress address;
  Future<TezosRevealOperation> getReveal();
  Future<TezosPublicKey> getPublicKey();
  Future<TezosSigner> getSigner();
  const TezosOperationSource(this.address);
}

class DefaultTezosOperationSource implements TezosOperationSource {
  @override
  final TezosAddress address;
  final TezosPublicKey publicKey;
  final CbTezosSigner signer;
  const DefaultTezosOperationSource({
    required this.address,
    required this.publicKey,
    required this.signer,
  });
  DefaultTezosOperationSource.fromPublicKey({
    required this.publicKey,
    required this.signer,
  }) : address = publicKey.toAddress();

  @override
  Future<TezosPublicKey> getPublicKey() async {
    return publicKey;
  }

  @override
  Future<TezosRevealOperation> getReveal() async {
    if (address.type != XtzAddrPrefixes.tz4) {
      return TezosRevealOperation(
        source: address,
        fee: BigInt.zero,
        counter: BigInt.zero,
        gasLimit: BigInt.zero,
        storageLimit: BigInt.zero,
        publicKey: publicKey,
        proof: null,
      );
    }
    final sk = await signer(address);
    if (sk case TezosBlsSecretKey()) {
      final signature = await sk.proof();
      return TezosRevealOperation(
        source: address,
        fee: BigInt.zero,
        counter: BigInt.zero,
        gasLimit: BigInt.zero,
        storageLimit: BigInt.zero,
        publicKey: publicKey,
        proof: signature,
      );
    }
    throw OnChainErrors.tezosPlugin(
      "getReveal",
      reason:
          "Revealing a tz4 account requires a BLS signer to generate the proof.",
    );
  }

  @override
  Future<TezosSigner> getSigner() {
    return signer(address);
  }
}
