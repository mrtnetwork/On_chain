import 'package:on_chain/ada/src/provider/provider.dart';

/// The parameters that are used to calculate the fee of a transaction.
///
/// The fee of a Cardano transaction is the linear function
/// `minFeeA * size + minFeeB` of the size of the transaction and every output
/// of a transaction must hold at least `coinsPerUtxoSize * (160 + size)`
/// lovelace.
class ADAFeeParameters {
  /// The linear factor of the minimum fee calculation.
  final int minFeeA;

  /// The constant factor of the minimum fee calculation.
  final int minFeeB;

  /// The amount of lovelace that every byte of an output costs.
  final int coinsPerUtxoSize;

  const ADAFeeParameters({
    required this.minFeeA,
    required this.minFeeB,
    required this.coinsPerUtxoSize,
  });

  /// Creates the fee parameters of the given protocol parameters of an epoch.
  factory ADAFeeParameters.fromProtocolParameters(
    ADAEpochParametersResponse protocolParameters,
  ) {
    return ADAFeeParameters(
      minFeeA: protocolParameters.minFeeA,
      minFeeB: protocolParameters.minFeeB,
      coinsPerUtxoSize: protocolParameters.coinsPerUtxoSize,
    );
  }
}
