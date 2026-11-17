import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/ada/src/address/address.dart';
import 'package:on_chain/ada/src/builder/builder/certificate_builder.dart';
import 'package:on_chain/ada/src/builder/builder/deposit.dart';
import 'package:on_chain/ada/src/builder/builder/mint_builder.dart';
import 'package:on_chain/ada/src/builder/builder/tranasction_builder_utils.dart';
import 'package:on_chain/ada/src/builder/builder_new/types/types.dart';
import 'package:on_chain/ada/src/models/models.dart';
import 'package:on_chain/exception/onchain_error.dart';

/// A transaction builder for the Cardano network.
///
/// The builder is immutable: every step returns a new instance, so a builder
/// cannot be used in an invalid state (a transaction without a fee, a
/// transaction whose outputs do not match the inputs, ...).
///
/// The transaction is built in three steps:
///
/// 1. [finalize] calculates the fee and the change output of the transaction.
///    The fee of a Cardano transaction is a linear function of the size of the
///    transaction and the size depends on the change output, so the fee and
///    the change are calculated together until they are consistent.
/// 2. [sign] (or [signAsync]) asks the signers for the witnesses of the
///    transaction and validates them.
/// 3. The transaction is ready to be submitted.
///
/// The rules of the ledger that the builder relies on:
///
/// - the minimum fee of a transaction is `minFeeA * txSize + minFeeB` and it
///   is checked against the size of the **final** transaction, so the fee has
///   to be calculated with the change output of the transaction;
/// - a transaction can pay a fee that is higher than the minimum fee;
/// - an output must hold at least `coinsPerUtxoSize * (160 + size of the
///   serialized output)` lovelace, an output that holds only native assets
///   with zero lovelace is valid;
/// - the vkey witnesses of the witness set are a set, so they are unique and
///   they are serialized in the canonical order (ascending order of the raw
///   vkey bytes).
class ADATransactionBuilderV2 {
  /// The utxos that are spent by the transaction.
  final List<TransactionUnspentOutput> utxos;

  /// The outputs of the transaction.
  final List<TransactionOutput> outputs;

  /// The assets that are minted by the transaction.
  final List<ADAMinsBuilder> mints;

  /// The certificates of the transaction.
  final List<ADACertificateBuilder> certificates;

  /// The deposits that are locked by the transaction.
  final List<ADADepositBuilder> deposits;

  /// The deposits that are refunded by the transaction.
  final List<ADADepositBuilder> refundDeposits;

  /// The metadata of the transaction.
  final GeneralTransactionMetadata? metadata;

  /// The native scripts of the credentials of the inputs.
  final NativeScripts? nativeScripts;

  /// The fee of the transaction, it is set by [finalize].
  final BigInt? fee;

  /// The size of the transaction that has been used to calculate the [fee].
  final int? estimatedSize;

  ADATransactionBuilderV2({
    required List<TransactionUnspentOutput> utxos,
    required List<TransactionOutput> outputs,
    List<ADAMinsBuilder> mints = const [],
    List<ADADepositBuilder> deposits = const [],
    List<ADADepositBuilder> refundDeposits = const [],
    List<ADACertificateBuilder> certificates = const [],
    this.nativeScripts,
    this.metadata,
    this.fee,
    this.estimatedSize,
  }) : utxos = List<TransactionUnspentOutput>.unmodifiable(utxos),
       outputs = List<TransactionOutput>.unmodifiable(outputs),
       mints = List<ADAMinsBuilder>.unmodifiable(mints),
       deposits = List<ADADepositBuilder>.unmodifiable(deposits),
       refundDeposits = List<ADADepositBuilder>.unmodifiable(refundDeposits),
       certificates = List<ADACertificateBuilder>.unmodifiable(certificates);

  /// Returns a copy of the builder with the given values.
  ADATransactionBuilderV2 copyWith({
    List<TransactionUnspentOutput>? utxos,
    List<TransactionOutput>? outputs,
    List<ADAMinsBuilder>? mints,
    List<ADADepositBuilder>? deposits,
    List<ADADepositBuilder>? refundDeposits,
    List<ADACertificateBuilder>? certificates,
    NativeScripts? nativeScripts,
    GeneralTransactionMetadata? metadata,
    BigInt? fee,
    int? estimatedSize,
  }) {
    return ADATransactionBuilderV2(
      utxos: utxos ?? this.utxos,
      outputs: outputs ?? this.outputs,
      mints: mints ?? this.mints,
      deposits: deposits ?? this.deposits,
      refundDeposits: refundDeposits ?? this.refundDeposits,
      certificates: certificates ?? this.certificates,
      nativeScripts: nativeScripts ?? this.nativeScripts,
      metadata: metadata ?? this.metadata,
      fee: fee ?? this.fee,
      estimatedSize: estimatedSize ?? this.estimatedSize,
    );
  }

  /// The total amount of lovelace of the inputs.
  BigInt get totalLovelace => utxos.fold(
    BigInt.zero,
    (previousValue, element) => previousValue + element.output.amount.coin,
  );

  /// The total assets of the inputs.
  MultiAsset get totalAssets => utxos.fold(
    MultiAsset.empty,
    (previousValue, element) =>
        previousValue + (element.output.amount.multiAsset ?? MultiAsset.empty),
  );

  /// The total amount of lovelace that is locked by the deposits.
  BigInt get totalDeposit => deposits.fold(
    BigInt.zero,
    (previousValue, element) => previousValue + element.deposit,
  );

  /// The total amount of lovelace that is refunded by the deposits.
  BigInt get totalRefund => refundDeposits.fold(
    BigInt.zero,
    (previousValue, element) => previousValue + element.deposit,
  );

  /// The addresses that have to sign the transaction.
  ///
  /// They are the owners of the inputs, the owners of the minted assets and
  /// the signers of the certificates.
  List<ADAAddress> get signers {
    final addresses = {
      ...utxos.map((e) => e.output.address),
      ...mints.map((e) => e.owner),
      ...certificates
          .where((element) => element.signer != null)
          .map((e) => e.signer!),
    };
    return List<ADAAddress>.unmodifiable(addresses);
  }

  /// The mint of the transaction.
  Mint? getMint() {
    if (mints.isEmpty) return null;
    return Mint(mints.map((e) => e.toMintInfo()).toList());
  }

  /// The auxiliary data of the transaction.
  AuxiliaryData? get auxiliaryData {
    if (metadata == null && mints.isEmpty) return null;
    return AuxiliaryData(
      metadata: metadata,
      nativeScripts: mints.map((e) => e.minterScript).toList(),
    );
  }

  /// Returns a new builder with the change output and the fee of the
  /// transaction.
  ///
  /// The fee of a Cardano transaction is the linear function
  /// `minFeeA * size + minFeeB` of the size of the transaction and the size
  /// of the transaction depends on the change output that is added to it, so
  /// the fee and the change are calculated together until they are consistent.
  ///
  /// The leftover that is too small to be a valid output (an output must hold
  /// at least `coinsPerUtxoSize * (160 + size)` lovelace) is added to the fee
  /// instead of being returned as a change output.
  ///
  /// [witnessTemplate] are the witnesses that are used to calculate the size
  /// of the transaction, when they are not provided a fake witness for every
  /// signer is used.
  ADATransactionBuilderV2 finalize({
    required ADAAddress changeAddress,
    required ADAFeeParameters feeParameters,
    List<ADABaseTransactionWitness>? witnessTemplate,
  }) {
    final minFeeA = feeParameters.minFeeA;
    final minFeeB = feeParameters.minFeeB;
    final coinsPerUtxoSize = feeParameters.coinsPerUtxoSize;
    var currentFee = BigInt.from(
      minFeeA *
              _estimateSize(
                outputs: outputs,
                fee: BigInt.zero,
                witnessTemplate: witnessTemplate,
              ) +
          minFeeB,
    );
    for (var i = 0; i < _maxFeeIterations; i++) {
      /// the change of the transaction
      final change = _changeOutput(
        fee: currentFee,
        changeAddress: changeAddress,
        coinsPerUtxoSize: coinsPerUtxoSize,
      );
      final newOutputs =
          change.output != null ? [...outputs, change.output!] : outputs;

      /// the size of the transaction with the current fee and change
      final size = _estimateSize(
        outputs: newOutputs,
        fee: currentFee,
        witnessTemplate: witnessTemplate,
      );
      final minFee = BigInt.from(minFeeA * size + minFeeB);
      if (currentFee < minFee) {
        /// the fee was too low for the size of the transaction
        currentFee = minFee;
        continue;
      }
      if (change.absorbed > BigInt.zero) {
        /// the change was too small to be a valid output, it is added to the fee
        currentFee += change.absorbed;
        continue;
      }
      return copyWith(
        outputs: newOutputs,
        fee: currentFee,
        estimatedSize: size,
      );
    }
    throw const BuError(
      OnChainErrorType.adaPlugin,
      'Could not calculate a consistent fee for the transaction.',
    );
  }

  /// The size of the transaction with the current outputs and fee.
  int estimateSize({List<ADABaseTransactionWitness>? witnessTemplate}) {
    final currentFee = fee;
    if (currentFee == null) {
      throw const BuError(
        DefaultErrorType.invalidState,
        'Cannot estimate the size of the transaction before the calculation of the fee.',
      );
    }
    return _estimateSize(
      outputs: outputs,
      fee: currentFee,
      witnessTemplate: witnessTemplate,
    );
  }

  /// Builds the transaction with the given witnesses, without asking the
  /// signers for them.
  ///
  /// It is used to preview a transaction and to calculate the size of a
  /// transaction whose witnesses are already known.
  ADATransaction buildUnsignedTransaction({
    List<ADABaseTransactionWitness>? witnesses,
  }) {
    final currentFee = fee;
    if (currentFee == null) {
      throw const BuError(
        DefaultErrorType.invalidState,
        'Cannot build the transaction before the calculation of the fee.',
      );
    }
    final aux = auxiliaryData;
    final transactionWitnesses = witnesses ?? _fakeWitnesses();
    return ADATransaction(
      body: _buildBody(auxHash: aux?.toHash(), fee: currentFee),
      data: aux,
      witnessSet: _buildWitnessSet(transactionWitnesses),
    );
  }

  /// Builds and signs the transaction.
  ///
  /// [onSign] is called once with all the addresses that have to sign the
  /// transaction and it returns the witnesses of every address.
  ADATransaction sign(ADATransactionSigner onSign) {
    final prepared = _prepare();
    final witnesses = onSign(digest: prepared.bodyHash, addresses: signers);
    return _buildTransaction(prepared: prepared, witnesses: witnesses);
  }

  /// Builds and signs the transaction asynchronously.
  ///
  /// [onSign] is called once with all the addresses that have to sign the
  /// transaction and it returns the witnesses of every address.
  Future<ADATransaction> signAsync(ADATransactionSignerAsync onSign) async {
    final prepared = _prepare();
    final witnesses = await onSign(
      digest: prepared.bodyHash,
      addresses: signers,
    );
    return _buildTransaction(prepared: prepared, witnesses: witnesses);
  }

  /// The body of the transaction, the auxiliary data and the hash that the
  /// signers have to sign.
  ({TransactionBody body, AuxiliaryData? aux, BuBytes bodyHash}) _prepare() {
    final currentFee = fee;
    if (currentFee == null) {
      throw const BuError(
        DefaultErrorType.invalidState,
        'Cannot build the transaction before the calculation of the fee.',
      );
    }
    _validateAmounts();
    final aux = auxiliaryData;
    final body = _buildBody(auxHash: aux?.toHash(), fee: currentFee);
    return (
      body: body,
      aux: aux,
      bodyHash: body.toHash().data.asImmutableBytes,
    );
  }

  /// Builds the transaction with the witnesses of the signers.
  ADATransaction _buildTransaction({
    required ({TransactionBody body, AuxiliaryData? aux, BuBytes bodyHash})
    prepared,
    required Map<ADAAddress, List<ADABaseTransactionWitness>> witnesses,
  }) {
    final collected = _collectWitnesses(witnesses);
    final transaction = ADATransaction(
      body: prepared.body,
      data: prepared.aux,
      witnessSet: _buildWitnessSet(collected),
    );

    /// the fee has been calculated for a transaction of [estimatedSize] bytes,
    /// when the real transaction is bigger the fee does not cover it.
    final currentEstimatedSize = estimatedSize;
    if (currentEstimatedSize != null &&
        transaction.size > currentEstimatedSize) {
      throw BuError(
        OnChainErrorType.adaPlugin,
        'The fee of the transaction does not cover the size of the transaction.',
        details: {
          'fee': fee.toString(),
          'size': transaction.size.toString(),
          'estimatedSize': currentEstimatedSize.toString(),
        },
      );
    }
    return transaction;
  }

  /// The body of the transaction.
  TransactionBody _buildBody({
    required AuxiliaryDataHash? auxHash,
    required BigInt fee,
    List<TransactionOutput>? outputs,
  }) {
    return TransactionBody(
      fee: fee,
      inputs: TransactionInputs(utxos.map((e) => e.input).toList()),
      outputs: TransactionOutputs(outputs ?? this.outputs),
      certificates:
          certificates.isEmpty
              ? null
              : Certificates(certificates.map((e) => e.certificate).toList()),
      mint: getMint(),
      auxiliaryDataHash: auxHash,
    );
  }

  /// The witness set of the transaction.
  TransactionWitnessSet _buildWitnessSet(
    List<ADABaseTransactionWitness> witnesses,
  ) {
    final vkeys = witnesses.whereType<Vkeywitness>().toList();
    final bootstraps = witnesses.whereType<BootstrapWitness>().toList();
    return TransactionWitnessSet(
      vKeys: vkeys.isEmpty ? null : VkeyWitnesses(vkeys),
      nativeScripts: nativeScripts,
      bootstraps: bootstraps.isEmpty ? null : BootstrapWitnesses(bootstraps),
    );
  }

  /// The size of the transaction with the given outputs and fee.
  int _estimateSize({
    required List<TransactionOutput> outputs,
    required BigInt fee,
    List<ADABaseTransactionWitness>? witnessTemplate,
  }) {
    final aux = auxiliaryData;
    final transaction = ADATransaction(
      body: _buildBody(auxHash: aux?.toHash(), fee: fee, outputs: outputs),
      data: aux,
      witnessSet: _buildWitnessSet(witnessTemplate ?? _fakeWitnesses()),
    );
    return transaction.size;
  }

  /// A fake witness for every signer of the transaction, it is used to
  /// calculate the size of the transaction.
  List<ADABaseTransactionWitness> _fakeWitnesses() {
    final witnesses = <ADABaseTransactionWitness>[];
    for (final signer in signers) {
      if (signer.isByron) {
        witnesses.add(
          ADATransactionBuilderUtils.fakeBootStrapWitness(
            signer.cast<ADAByronAddress>(),
          ),
        );
        continue;
      }
      witnesses.add(ADATransactionBuilderUtils.fakeVkeyWitnessWitness());
    }
    return witnesses;
  }

  /// The change of the transaction.
  ///
  /// The leftover that is too small to be a valid output is returned as
  /// [absorbed] and it has to be added to the fee.
  ({TransactionOutput? output, BigInt absorbed}) _changeOutput({
    required BigInt fee,
    required ADAAddress changeAddress,
    required int coinsPerUtxoSize,
  }) {
    final lovelace =
        totalLovelace +
        totalRefund -
        (outputs.sumOflovelace + fee) -
        totalDeposit;
    if (lovelace.isNegative) {
      throw BuError(
        OnChainErrorType.adaPlugin,
        'Insufficient input in transaction.',
        details: {
          'utxo lovelace': totalLovelace.toString(),
          'output lovelace': outputs.sumOflovelace.toString(),
          'fee': fee.toString(),
        },
      );
    }
    final asset = _leftoverAssets();
    if (lovelace == BigInt.zero && !asset.hasAsset) {
      return (output: null, absorbed: BigInt.zero);
    }

    /// an output must hold at least `coinsPerUtxoSize * (160 + size)` lovelace
    /// (the size of the serialized output), when the lovelace of the change is
    /// too small it is added to the fee.
    final minAda = TransactionOutput(
      address: changeAddress,
      amount: Value(coin: lovelace, multiAsset: asset.hasAsset ? asset : null),
    ).minAda(coinsPerUtxoSize);
    if (lovelace > BigInt.zero && lovelace < minAda) {
      /// the lovelace of the change output is added to the fee, the change
      /// output only holds the assets that are not spent (an output with zero
      /// lovelace and native assets is valid).
      return (
        output:
            asset.hasAsset
                ? TransactionOutput(
                  address: changeAddress,
                  amount: Value(coin: BigInt.zero, multiAsset: asset),
                )
                : null,
        absorbed: lovelace,
      );
    }
    final change = TransactionOutput(
      address: changeAddress,
      amount: Value(coin: lovelace, multiAsset: asset.hasAsset ? asset : null),
    );
    return (output: change, absorbed: BigInt.zero);
  }

  /// The assets of the inputs that are not spent by the outputs.
  MultiAsset _leftoverAssets() {
    final available = _availableAssets();
    final required = _requiredAssets();
    final leftover = <PolicyID, Assets>{};
    for (final policy in available.keys) {
      for (final name in available[policy]!.keys) {
        final amount =
            available[policy]![name]! -
            (required[policy]?[name] ?? BigInt.zero);
        if (amount <= BigInt.zero) continue;
        leftover[policy] = (leftover[policy] ?? Assets({})).updateAssetName(
          name,
          amount,
        );
      }
    }
    return MultiAsset(leftover);
  }

  /// The assets that can be spent by the transaction, the assets of the inputs
  /// and the minted ones.
  Map<PolicyID, Map<AssetName, BigInt>> _availableAssets() {
    final available = <PolicyID, Map<AssetName, BigInt>>{};
    final multiAssets = [totalAssets, ...mints.map((e) => e.toMultiAssets())];
    for (final multiAsset in multiAssets) {
      _addAssets(available, multiAsset);
    }
    return available;
  }

  /// The assets that are spent by the outputs of the transaction.
  Map<PolicyID, Map<AssetName, BigInt>> _requiredAssets() {
    final required = <PolicyID, Map<AssetName, BigInt>>{};
    for (final output in outputs) {
      final multiAsset = output.amount.multiAsset;
      if (multiAsset == null) continue;
      _addAssets(required, multiAsset);
    }
    return required;
  }

  /// Adds the assets of the given [multiAsset] to the given [assets].
  void _addAssets(
    Map<PolicyID, Map<AssetName, BigInt>> assets,
    MultiAsset multiAsset,
  ) {
    for (final policy in multiAsset.assets.keys) {
      final policyAssets = multiAsset.assets[policy]!.assets;
      for (final name in policyAssets.keys) {
        assets[policy] ??= <AssetName, BigInt>{};
        assets[policy]![name] =
            (assets[policy]![name] ?? BigInt.zero) + policyAssets[name]!;
      }
    }
  }

  /// Validates that the amount of the inputs and the amount of the outputs of
  /// the transaction are the same.
  void _validateAmounts() {
    final currentFee = fee!;
    final lovelace =
        totalLovelace +
        totalRefund -
        (outputs.sumOflovelace + currentFee) -
        totalDeposit;
    if (lovelace != BigInt.zero) {
      throw BuError(
        OnChainErrorType.adaPlugin,
        'The amount of inputs and outputs is not calculated correctly.',
        details: {
          'inputAmount': totalLovelace.toString(),
          'outputAmount': outputs.sumOflovelace.toString(),
          'fee': currentFee.toString(),
          'depositAmount': totalDeposit.toString(),
          'refundAmount': totalRefund.toString(),
          'difference': lovelace.toString(),
        },
      );
    }

    /// the assets of the inputs (and the minted ones) are the assets that the
    /// transaction is able to spend.
    final available = _availableAssets();
    final required = _requiredAssets();
    for (final policy in required.keys) {
      for (final name in required[policy]!.keys) {
        final availableAmount = available[policy]?[name] ?? BigInt.zero;
        final requiredAmount = required[policy]![name]!;
        if (availableAmount < requiredAmount) {
          throw BuError(
            OnChainErrorType.adaPlugin,
            'The transaction spends more assets than the inputs hold.',
            details: {
              'policyId': policy.toHex(),
              'assetName': name.toHex(),
              'requiredAmount': requiredAmount.toString(),
              'availableAmount': availableAmount.toString(),
            },
          );
        }
      }
    }
  }

  /// Validates the witnesses of the signers and returns all the witnesses of
  /// the transaction.
  List<ADABaseTransactionWitness> _collectWitnesses(
    Map<ADAAddress, List<ADABaseTransactionWitness>> witnesses,
  ) {
    final transactionSigners = signers;
    final missing =
        transactionSigners
            .where(
              (e) =>
                  (witnesses[e] ?? const <ADABaseTransactionWitness>[]).isEmpty,
            )
            .toList();
    if (missing.isNotEmpty) {
      throw BuError(
        DefaultErrorType.invalidState,
        'Some signers did not sign the transaction.',
        details: {'missingSigners': missing.map((e) => e.address).join(',')},
      );
    }
    final unexpected =
        witnesses.keys.where((e) => !transactionSigners.contains(e)).toList();
    if (unexpected.isNotEmpty) {
      throw BuError(
        DefaultErrorType.invalidState,
        'The transaction has been signed by an address that does not have to sign it.',
        details: {
          'unexpectedSigners': unexpected.map((e) => e.address).join(','),
        },
      );
    }
    final vkeys = <String, Vkeywitness>{};
    final bootstraps = <BootstrapWitness>[];
    for (final entry in witnesses.entries) {
      final address = entry.key;
      for (final witness in entry.value) {
        if (address.isByron) {
          if (witness is! BootstrapWitness) {
            throw BuError(
              DefaultErrorType.invalidAddress,
              'Invalid witness for a Byron address.',
              details: {'address': address.address},
            );
          }
          final attributes =
              address.cast<ADAByronAddress>().attributeSerialize();
          if (!BytesUtils.bytesEqual(attributes, witness.attributes)) {
            throw BuError(
              DefaultErrorType.cryptoVerifyFailed,
              'The bootstrap witness does not match the Byron address.',
              details: {'address': address.address},
            );
          }
          bootstraps.add(witness);
          continue;
        }
        if (witness is! Vkeywitness) {
          throw BuError(
            DefaultErrorType.invalidAddress,
            'Invalid witness for the address.',
            details: {'address': address.address},
          );
        }
        final publicKey = witness.vKey.toHex();
        final exists = vkeys[publicKey];
        if (exists != null &&
            !BytesUtils.bytesEqual(
              exists.signature.data,
              witness.signature.data,
            )) {
          throw BuError(
            OnChainErrorType.adaPlugin,
            'The transaction has two different signatures for the same public key.',
            details: {'publicKey': publicKey},
          );
        }
        vkeys[publicKey] = witness;
      }
    }

    /// the vkey witnesses of the witness set must be in the canonical order
    /// (ascending order of the raw vkey bytes) and the same holds for the
    /// bootstrap witnesses.
    final sortedVkeys =
        vkeys.values.toList()
          ..sort((a, b) => BytesUtils.compareBytes(a.vKey.data, b.vKey.data));
    final sortedBootstraps =
        bootstraps.toList()
          ..sort((a, b) => BytesUtils.compareBytes(a.vkey.data, b.vkey.data));
    return [...sortedVkeys, ...sortedBootstraps];
  }

  /// The maximum number of iterations that are used to calculate the fee and
  /// the change of the transaction.
  static const int _maxFeeIterations = 20;
}
