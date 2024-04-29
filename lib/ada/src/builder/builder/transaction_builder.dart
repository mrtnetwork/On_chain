import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/address/address.dart';
import 'package:on_chain/ada/src/builder/builder/tranasction_builder_utils.dart';
import 'package:on_chain/ada/src/models/ada_models.dart';
import 'package:on_chain/ada/src/provider/provider.dart';
import 'certificate_builder.dart';
import 'deposit.dart';
import 'mint_builder.dart';

typedef ONSignADA = ADABaseTransactionWitness Function(
    {required List<int> digest, required ADAAddress address});

class ADATransactionBuilder {
  BigInt? _fee;
  BigInt? get fee => _fee;

  final List<ADAAccountUTXOResponse> utxos;
  final GeneralTransactionMetadata? metadata;
  final List<ADAMinsBuilder> mints;
  final List<ADACertificateBuilder> certificates;
  final List<ADADepositBuilder> deposits;
  final List<ADADepositBuilder> refundDeposits;
  List<TransactionOutput> _outputs;
  List<TransactionOutput> get outputs => List<TransactionOutput>.from(_outputs);

  ADATransactionBuilder({
    required this.utxos,
    required List<TransactionOutput> outputs,
    List<ADAMinsBuilder> mints = const [],
    List<ADADepositBuilder> deposits = const [],
    List<ADADepositBuilder> refundDeposits = const [],
    final List<ADACertificateBuilder> certificates = const [],
    this.metadata,
  })  : _outputs = List<TransactionOutput>.unmodifiable(outputs),
        mints = List<ADAMinsBuilder>.unmodifiable(mints),
        deposits = List<ADADepositBuilder>.unmodifiable(deposits),
        certificates = List<ADACertificateBuilder>.unmodifiable(certificates),
        refundDeposits = List<ADADepositBuilder>.unmodifiable(refundDeposits);

  Mint? getMint() {
    if (mints.isEmpty) return null;
    return Mint(mints.map((e) => e.toMintInfo()).toList());
  }

  void setFee(BigInt fee) => _fee = fee;

  BigInt get sumOflovelace {
    return utxos.sumOflovelace;
  }

  MultiAsset get multiAsset {
    return utxos.multiAsset;
  }

  List<ADAAddress> get signers {
    final Set<String> addresses = {
      ...utxos.map((e) => e.address),
      ...mints.map((e) => e.owner.address),
      ...certificates
          .where((element) => element.signer != null)
          .map((e) => e.signer!.address)
    }.toSet();
    return addresses.map((e) => ADAAddress.fromAddress(e)).toList();
  }

  List<NativeScript>? get transactionNativeScripts {
    final scripts = mints.map((e) => e.toScript()).toList();
    return scripts.isEmpty ? null : scripts;
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
    final outs = _outputs.map((e) {
      if (e.amount.coin == BigInt.zero) {
        return e.copyWith(amount: e.amount.copyWith(coin: maxU64));
      }
      return e;
    }).toList();
    final transactionSigners = signers;
    final aux = auxiliaryData;

    final ADATransaction transaction = ADATransaction(
      data: aux,
      body: TransactionBody(
          inputs: utxos.map((e) => e.toInput).toList(),
          outputs: outs,
          mint: getMint(),
          fee: BigInt.from(mask32),
          certs: certificates.map((e) => e.certificate).toList(),
          auxiliaryDataHash: aux?.toHash()),
      witnessSet: TransactionWitnessSet(
        bootstraps: transactionSigners
            .where((element) => element.addressType == ADAAddressType.byron)
            .map((e) =>
                ADATransactionBuilderUtils.fakeBootStrapWitness(e.address))
            .toList(),
        nativeScripts: transactionNativeScripts,
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
    if (metadata == null && mints.isEmpty) return null;
    return AuxiliaryData(
        metadata: metadata, nativeScripts: transactionNativeScripts);
  }

  TransactionBody buildTxBody({AuxiliaryDataHash? auxHash}) {
    if (fee == null) {
      throw MessageException(
          "cannot build transaction body before calculation fee.");
    }
    final mint = getMint();

    return TransactionBody(
        fee: fee!,
        inputs: utxos.map((e) => e.toInput).toList(),
        outputs: outputs,
        certs: certificates.map((e) => e.certificate).toList(),
        mint: mint,
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
    final vkeys = witnesses.whereType<Vkeywitness>().toList();
    final bootstraps = witnesses.whereType<BootstrapWitness>().toList();
    return ADATransaction(
        body: trBody,
        data: aux,
        witnessSet: TransactionWitnessSet(
            vKeys: vkeys,
            nativeScripts: transactionNativeScripts,
            bootstraps: bootstraps));
  }

  void _validateAmounts() {
    final BigInt depositAmouts = deposits.fold(BigInt.zero,
        (previousValue, element) => previousValue + element.deposit);
    final BigInt refundAmounts = refundDeposits.fold(BigInt.zero,
        (previousValue, element) => previousValue + element.deposit);
    final lovelence = utxos.sumOflovelace +
        refundAmounts -
        (outputs.sumOflovelace + (fee ?? BigInt.zero)) -
        depositAmouts;
    final asset = utxos.multiAsset - outputs.multiAsset;

    if (lovelence != BigInt.zero || asset != MultiAsset.empty) {
      throw MessageException(
          "The amount of inputs and outputs is not calculated correctly",
          details: {"lovelence": lovelence, "asset": asset});
    }
  }
}
