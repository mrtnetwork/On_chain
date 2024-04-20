import 'dart:developer';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/address/address.dart';
import 'package:on_chain/ada/src/builder/builder/tranasction_builder_utils.dart';
import 'package:on_chain/ada/src/models/ada_models.dart';
import 'package:on_chain/ada/src/provider/provider.dart';

typedef ONSignADA = ADABaseTransactionWitness Function(
    {required List<int> digest, required ADAAddress address});

class ADATransactionBuilder {
  ADATransactionBuilder({
    required this.utxos,
    required List<TransactionOutput> outputs,
    this.metadata,
  }) : _outputs = List<TransactionOutput>.unmodifiable(outputs);
  final List<ADAAccountUTXOResponse> utxos;
  final GeneralTransactionMetadata? metadata;
  List<TransactionOutput> _outputs;
  List<TransactionOutput> get outputs => List<TransactionOutput>.from(_outputs);
  BigInt? _fee;
  BigInt? get fee => _fee;

  void setFee(BigInt fee) => _fee = fee;

  BigInt get sumOflovelace {
    return utxos.sumOflovelace;
  }

  MultiAsset get multiAsset {
    return utxos.multiAsset;
  }

  List<ADAAddress> get signers {
    final Set<String> addresses = utxos.map((e) => e.address).toSet();
    return addresses.map((e) => ADAAddress.fromAddress(e)).toList();
  }

  TransactionOutput? _changeOutput(ADAAddress addr) {
    final lovelence =
        (utxos.sumOflovelace - (_outputs.sumOflovelace + (fee ?? BigInt.zero)));
    final multiAsset = utxos.multiAsset;
    final asset = multiAsset - _outputs.multiAsset;
    if (lovelence.isNegative) {
      throw MessageException("Insufficient input in transaction.", details: {
        "utxo lovelence": utxos.sumOflovelace,
        "output lovelence": _outputs.sumOflovelace
      });
    }

    if (lovelence > BigInt.zero || asset.hasAsset) {
      return TransactionOutput(
          address: addr,
          amount: Value(
              coin: lovelence, multiAsset: asset.hasAsset ? asset : null));
    }
    return null;
  }

  int estimateSize({ADAAddress? onChangeAddress}) {
    if (utxos.isEmpty || _outputs.isEmpty) {
      throw MessageException("Utxos and outputs must not be not empty.");
    }
    // final change = _changeOutput(onChangeAddress ?? utxos.first.toAdddress);
    final outs = _outputs.map((e) {
      if (e.amount.coin == BigInt.zero) {
        return e.copyWith(amount: e.amount.copyWith(coin: maxU64));
      }
      return e;
    }).toList();
    log("outs: $outs");
    final transactionSigners = signers;
    final aux = auxiliaryData;
    final ADATransaction transaction = ADATransaction(
      data: aux,
      body: TransactionBody(
          inputs: utxos.map((e) => e.toInput).toList(),
          outputs: outs,
          fee: BigInt.from(mask32),
          auxiliaryDataHash: aux?.toHash()),
      witnessSet: TransactionWitnessSet(
        bootstraps: transactionSigners
            .where((element) => element.addressType == ADAAddressType.byron)
            .map((e) =>
                ADATransactionBuilderUtils.fakeBootStrapWitness(e.address))
            .toList(),
        vKeys: transactionSigners
            .where((element) => element.addressType != ADAAddressType.byron)
            .map((e) => ADATransactionBuilderUtils.fakeVkeyWitnessWitness())
            .toList(),
      ),
    );
    return transaction.size;
  }

  Future<void> calculateFees(BlockforestProvider provider) async {
    final protocol = await provider
        .request(BlockfrostRequestLatestEpochProtocolParameters());
    _fee = BigInt.from(protocol.minFeeA * estimateSize() + protocol.minFeeB);
  }

  TransactionOutput? onChangeAddress(ADAAddress onChangeAddress) {
    if (_fee == null) {
      throw MessageException(
          "please calculation the transaction fees befor using change address.");
    }
    final change = _changeOutput(onChangeAddress);
    if (change != null) {
      _outputs = [..._outputs, change];
    }
    return change;
  }

  AuxiliaryData? get auxiliaryData {
    if (metadata == null) return null;
    return AuxiliaryData(metadata: metadata);
  }

  TransactionBody buildTxBody({AuxiliaryDataHash? auxHash}) {
    if (fee == null) {
      throw MessageException(
          "cannot build transaction body before calculation fee.");
    }
    return TransactionBody(
        fee: fee!,
        inputs: utxos.map((e) => e.toInput).toList(),
        outputs: outputs,
        auxiliaryDataHash: auxHash);
  }

  ADATransaction signAndBuildTransaction(ONSignADA onSignADA) {
    _validateAmounts();
    final aux = auxiliaryData;
    final trBody = buildTxBody(auxHash: aux?.toHash());
    final bodyHash = List<int>.unmodifiable(trBody.toHash().data);
    final List<ADABaseTransactionWitness> witnesses = [];
    final transactionSigners = signers;

    for (final i in transactionSigners) {
      final wit = onSignADA(address: i, digest: bodyHash);
      witnesses.add(wit);
    }
    return ADATransaction(
        body: trBody,
        data: aux,
        witnessSet: TransactionWitnessSet(
            vKeys: witnesses.whereType<Vkeywitness>().toList(),
            bootstraps: witnesses.whereType<BootstrapWitness>().toList()));
  }

  void _validateAmounts() {
    final lovelence =
        utxos.sumOflovelace - (outputs.sumOflovelace + (fee ?? BigInt.zero));
    final asset = utxos.multiAsset - outputs.multiAsset;
    if (lovelence != BigInt.zero || asset != MultiAsset.empty) {
      throw MessageException(
          "The amount of inputs and outputs is not calculated correctly",
          details: {"lovelence": lovelence, "asset": asset});
    }
  }
}
