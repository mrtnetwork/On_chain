import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/address/address.dart';
import 'package:on_chain/ada/src/builder/builder/tranasction_builder_utils.dart';
import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/ada/src/models/models.dart';
import 'package:on_chain/ada/src/provider/provider.dart';
import 'certificate_builder.dart';
import 'deposit.dart';
import 'mint_builder.dart';

typedef ONSignADA = List<ADABaseTransactionWitness> Function(
    {required List<int> digest, required ADAAddress address});

typedef ONSignADAAsync = Future<List<ADABaseTransactionWitness>> Function(
    {required List<int> digest, required ADAAddress address});

class ADATransactionBuilder {
  BigInt? _fee;
  BigInt? get fee => _fee;

  final List<TransactionUnspentOutput> utxos;
  final GeneralTransactionMetadata? metadata;
  final List<ADAMinsBuilder> mints;
  final List<ADACertificateBuilder> certificates;
  final List<ADADepositBuilder> deposits;
  final List<ADADepositBuilder> refundDeposits;
  final NativeScripts? nativeScripts;
  List<TransactionOutput> _outputs;
  List<TransactionOutput> get outputs => List<TransactionOutput>.from(_outputs);

  ADATransactionBuilder({
    required this.utxos,
    required List<TransactionOutput> outputs,
    List<ADAMinsBuilder> mints = const [],
    List<ADADepositBuilder> deposits = const [],
    List<ADADepositBuilder> refundDeposits = const [],
    final List<ADACertificateBuilder> certificates = const [],
    this.nativeScripts,
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

  late final BigInt totalLovelace =
      utxos.fold(BigInt.zero, (c, p) => c + p.output.amount.coin);

  late final MultiAsset totalAssets = utxos.fold(MultiAsset.empty,
      (c, p) => c + (p.output.amount.multiAsset ?? MultiAsset.empty));

  List<ADAAddress> get signers {
    final addresses = {
      ...utxos.map((e) => e.output.address),
      ...mints.map((e) => e.owner),
      ...certificates
          .where((element) => element.signer != null)
          .map((e) => e.signer!)
    }.toSet();
    return addresses.toList();
  }

  // List<NativeScript>? get transactionNativeScripts {
  //   final scripts = mints.map((e) => e.minterScript).toList();
  //   return scripts.isEmpty ? null : scripts;
  // }

  TransactionOutput? _changeOutput(ADAAddress addr) {
    final lovelace =
        (totalLovelace - (_outputs.sumOflovelace + (fee ?? BigInt.zero)));
    final asset = totalAssets - _outputs.multiAsset;
    if (lovelace.isNegative) {
      throw ADAPluginException('Insufficient input in transaction.', details: {
        'utxo lovelace': totalLovelace,
        'output lovelace': _outputs.sumOflovelace
      });
    }

    if (lovelace > BigInt.zero || asset.hasAsset) {
      return TransactionOutput(
          address: addr,
          amount:
              Value(coin: lovelace, multiAsset: asset.hasAsset ? asset : null));
    }
    return null;
  }

  ADATransaction buildEstimateTx(ONSignADA onSignADA) {
    if (utxos.isEmpty || _outputs.isEmpty) {
      throw const ADAPluginException(
          'Utxos and outputs must not be not empty.');
    }
    final outs = _outputs.map((e) {
      if (e.amount.coin == BigInt.zero) {
        return e.copyWith(amount: e.amount.copyWith(coin: BinaryOps.maxU64));
      }
      return e;
    }).toList();
    final transactionSigners = signers;
    final aux = auxiliaryData;
    final body = TransactionBody(
        inputs: TransactionInputs(utxos.map((e) => e.input).toList()),
        outputs: TransactionOutputs(outs),
        mint: getMint(),
        fee: BigInt.from(BinaryOps.mask32),
        certificates: certificates.isEmpty
            ? null
            : Certificates(certificates.map((e) => e.certificate).toList()),
        auxiliaryDataHash: aux?.toHash());
    final bodyHash = ADATransactionBuilderUtils.fakeBodyHash;
    final witnesses = <ADABaseTransactionWitness>[];
    for (final i in transactionSigners) {
      final witness = onSignADA(address: i, digest: bodyHash);
      witnesses.addAll(witness);
    }
    final vkeys = witnesses.whereType<Vkeywitness>().toList();
    final bootstraps = witnesses.whereType<BootstrapWitness>().toList();
    final transaction = ADATransaction(
      data: aux,
      body: body,
      witnessSet: TransactionWitnessSet(
          bootstraps: BootstrapWitnesses(bootstraps),
          nativeScripts: nativeScripts,
          vKeys: VkeyWitnesses(vkeys)),
    );
    return transaction;
  }

  int estimateSize() {
    if (utxos.isEmpty || _outputs.isEmpty) {
      throw const ADAPluginException(
          'Utxos and outputs must not be not empty.');
    }
    final outs = _outputs.map((e) {
      if (e.amount.coin == BigInt.zero) {
        return e.copyWith(amount: e.amount.copyWith(coin: BinaryOps.maxU64));
      }
      return e;
    }).toList();
    final transactionSigners = signers;
    final aux = auxiliaryData;

    final transaction = ADATransaction(
      data: aux,
      body: TransactionBody(
          inputs: TransactionInputs(utxos.map((e) => e.input).toList()),
          outputs: TransactionOutputs(outs),
          mint: getMint(),
          fee: BigInt.from(BinaryOps.mask32),
          certificates: certificates.isEmpty
              ? null
              : Certificates(certificates.map((e) => e.certificate).toList()),
          auxiliaryDataHash: aux?.toHash()),
      witnessSet: TransactionWitnessSet(
        bootstraps: BootstrapWitnesses(transactionSigners
            .where((element) => element.addressType == ADAAddressType.byron)
            .map((e) =>
                ADATransactionBuilderUtils.fakeBootStrapWitness(e.cast()))
            .toList()),
        nativeScripts: nativeScripts,
        vKeys: VkeyWitnesses(transactionSigners
            .where((element) => element.addressType != ADAAddressType.byron)
            .map((e) => ADATransactionBuilderUtils.fakeVkeyWitnessWitness())
            .toList()),
      ),
    );
    return transaction.size;
  }

  Future<void> calculateFees(BlockFrostProvider provider) async {
    final protocol = await provider
        .request(BlockfrostRequestLatestEpochProtocolParameters());
    _fee = BigInt.from(protocol.minFeeA * estimateSize() + protocol.minFeeB);
  }

  TransactionOutput? onChangeAddress(ADAAddress onChangeAddress) {
    if (_fee == null) {
      throw const ADAPluginException(
          'please calculation the transaction fees befor using change address.');
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
        metadata: metadata,
        nativeScripts: mints.map((e) => e.minterScript).toList());
  }

  TransactionBody buildTxBody({AuxiliaryDataHash? auxHash}) {
    if (fee == null) {
      throw const ADAPluginException(
          'cannot build transaction body before calculation fee.');
    }
    final mint = getMint();

    return TransactionBody(
        fee: fee!,
        inputs: TransactionInputs(utxos.map((e) => e.input).toList()),
        outputs: TransactionOutputs(outputs),
        certificates: certificates.isEmpty
            ? null
            : Certificates(certificates.map((e) => e.certificate).toList()),
        mint: mint,
        auxiliaryDataHash: auxHash);
  }

  ADATransaction signAndBuildTransaction(ONSignADA onSignADA) {
    _validateAmounts();
    final aux = auxiliaryData;
    final trBody = buildTxBody(auxHash: aux?.toHash());
    final bodyHash = List<int>.unmodifiable(trBody.toHash().data);
    final witnesses = <ADABaseTransactionWitness>[];
    final transactionSigners = signers;

    for (final i in transactionSigners) {
      final witness = onSignADA(address: i, digest: bodyHash);
      witnesses.addAll(witness);
    }
    final vkeys = witnesses.whereType<Vkeywitness>().toSet().toList();
    final bootstraps = witnesses.whereType<BootstrapWitness>().toSet().toList();
    return ADATransaction(
        body: trBody,
        data: aux,
        witnessSet: TransactionWitnessSet(
            vKeys: vkeys.isEmpty ? null : VkeyWitnesses(vkeys),
            nativeScripts: nativeScripts,
            bootstraps:
                bootstraps.isEmpty ? null : BootstrapWitnesses(bootstraps)));
  }

  Future<ADATransaction> signAndBuildTransactionAsync(
      ONSignADAAsync onSignADA) async {
    _validateAmounts();
    final aux = auxiliaryData;
    final trBody = buildTxBody(auxHash: aux?.toHash());
    final bodyHash = List<int>.unmodifiable(trBody.toHash().data);
    final witnesses = <ADABaseTransactionWitness>[];
    final transactionSigners = signers;

    for (final i in transactionSigners) {
      final witness = await onSignADA(address: i, digest: bodyHash);
      witnesses.addAll(witness);
    }
    final vkeys = witnesses.whereType<Vkeywitness>().toSet().toList();
    final bootstraps = witnesses.whereType<BootstrapWitness>().toSet().toList();
    return ADATransaction(
        body: trBody,
        data: aux,
        witnessSet: TransactionWitnessSet(
            vKeys: vkeys.isEmpty ? null : VkeyWitnesses(vkeys),
            nativeScripts: nativeScripts,
            bootstraps:
                bootstraps.isEmpty ? null : BootstrapWitnesses(bootstraps)));
  }

  void _validateAmounts() {
    final BigInt depositAmouts = deposits.fold(BigInt.zero,
        (previousValue, element) => previousValue + element.deposit);
    final BigInt refundAmounts = refundDeposits.fold(BigInt.zero,
        (previousValue, element) => previousValue + element.deposit);
    final lovelace = totalLovelace +
        refundAmounts -
        (outputs.sumOflovelace + (fee ?? BigInt.zero)) -
        depositAmouts;
    final asset = totalAssets - outputs.multiAsset;
    if (lovelace != BigInt.zero || asset != MultiAsset.empty) {
      throw ADAPluginException(
          'The amount of inputs and outputs is not calculated correctly',
          details: {'lovelace': lovelace, 'asset': asset});
    }
  }
}
