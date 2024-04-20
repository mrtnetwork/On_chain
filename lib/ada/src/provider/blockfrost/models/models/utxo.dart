import 'package:blockchain_utils/bip/address/ada/ada_addres_type.dart';
import 'package:on_chain/ada/src/address/era/core/address.dart';
import 'package:on_chain/ada/src/models/ada_models.dart';
import 'amount.dart';

class ADAAccountUTXOResponse {
  /// Bech32 encoded address - useful when querying by payment_cred
  final String address;

  ADAAddress get toAdddress => ADAAddress.fromAddress(address);
  ADAAddressType get type => toAdddress.addressType;

  TransactionInput get toInput => TransactionInput(
      index: outputIndex, transactionId: TransactionHash.fromHex(txHash));

  /// Transaction hash of the UTXO
  final String txHash;

  final List<ADAAmountResponse> amount;

  /// UTXO index in the transaction
  /// deprecated
  final int? txIndex;

  /// UTXO index in the transaction
  final int outputIndex;

  /// Block hash of the UTXO
  final String block;

  /// The hash of the transaction output datum
  final String? dataHash;

  /// CBOR encoded inline datum
  final String? inlineDatum;

  /// The hash of the reference script of the output
  final String? referenceScriptHash;

  TransactionInput get input => TransactionInput(
      index: outputIndex, transactionId: TransactionHash.fromHex(txHash));

  late final BigInt sumOflovelace = amount.fold(
      BigInt.zero,
      (previousValue, element) =>
          previousValue +
          (element.islovelace ? BigInt.parse(element.quantity) : BigInt.zero));

  late final MultiAsset multiAsset = _multiAsset;
  bool get haveAsset => _multiAsset.assets.isNotEmpty;

  MultiAsset get _multiAsset {
    final Map<PolicyID, Assets> assets = {};
    for (final i in amount) {
      if (i.islovelace) continue;
      final assetInfo = i.policyAndAssetName!;
      final asset = Assets({assetInfo.item2: BigInt.parse(i.quantity)});
      if (assets.containsKey(assetInfo.item1)) {
        assets[assetInfo.item1] = assets[assetInfo.item1]! + asset;
      } else {
        assets[assetInfo.item1] = asset;
      }
    }
    return MultiAsset(assets);
  }

  ADAAccountUTXOResponse({
    required this.address,
    required this.txHash,
    this.txIndex,
    required this.outputIndex,
    required this.block,
    this.dataHash,
    this.inlineDatum,
    this.referenceScriptHash,
    required this.amount,
  });

  factory ADAAccountUTXOResponse.fromJson(Map<String, dynamic> json) {
    return ADAAccountUTXOResponse(
        address: json['address'],
        txHash: json['tx_hash'],
        txIndex: json['tx_index'],
        outputIndex: json['output_index'],
        block: json['block'],
        dataHash: json['data_hash'],
        inlineDatum: json['inline_datum'],
        referenceScriptHash: json['reference_script_hash'],
        amount: (json["amount"] as List)
            .map((e) => ADAAmountResponse.fromJson(e))
            .toList());
  }

  Map<String, dynamic> toJson() => {
        'address': address,
        'tx_hash': txHash,
        'tx_index': txIndex,
        'output_index': outputIndex,
        'block': block,
        'data_hash': dataHash,
        'inline_datum': inlineDatum,
        'reference_script_hash': referenceScriptHash,
        "amount": amount.map((e) => e.toJson()).toList()
      };
  @override
  String toString() {
    return "ADAAccountUTXOResponse${toJson()}";
  }
}

extension QuicketADAUtxoCalculation on List<ADAAccountUTXOResponse> {
  BigInt get sumOflovelace {
    return fold(BigInt.zero,
        (previousValue, element) => previousValue + element.sumOflovelace);
  }

  MultiAsset get multiAsset {
    return fold(MultiAsset({}),
        (previousValue, element) => previousValue + element.multiAsset);
  }
}
