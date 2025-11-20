import 'package:blockchain_utils/helper/helper.dart';
import 'package:on_chain/ethereum/src/models/access_list.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/transaction/zksync.dart';

/// Estimates the gas required for an L1 to L2 transaction.
/// [zksync.io](https://docs.zksync.io/zksync-protocol/api/zks-rpc#zks_estimategasl1tol2)
class ZKSRequestEstimateGasL1toL2 extends EthereumRequest<BigInt, String> {
  ZKSRequestEstimateGasL1toL2(
      {this.from,
      this.to,
      this.gas,
      this.gasPrice,
      this.maxFeePerGas,
      this.maxPriorityFeePerGas,
      this.value,
      this.data,
      this.nonce,
      this.transactionType,
      this.accessList,
      this.gasPerPubdata,
      this.customSignature,
      this.paymaster,
      this.factoryDeps})
      : super();

  /// Sender address. Arbitrary if not provided.
  final String? from;

  /// Recipient address. Required for eth_call
  final String? to;

  /// Gas limit for the transaction. Defaults if not provided.
  final BigInt? gas;

  /// Gas price for the transaction. Defaults if not provided.
  final BigInt? gasPrice;

  /// Maximum fee per unit of gas.
  final BigInt? maxFeePerGas;

  /// Maximum priority fee per unit of gas.
  final BigInt? maxPriorityFeePerGas;

  /// Value transferred in the transaction. None for no transfer.
  final BigInt? value;

  /// Data sent with the transaction. Empty if not provided.
  final String? data;

  /// Transaction nonce.
  final int? nonce;

  /// Type of the transaction.
  final int? transactionType;

  /// EIP-2930 access list.
  final List<AccessEntry>? accessList;

  /// Extra parameters for EIP712 transactions
  final BigInt? gasPerPubdata;
  final String? customSignature;
  final ZKSyncPaymaster? paymaster;
  final List<List<String>>? factoryDeps;

  @override
  String get method => "zks_estimategasl1tol2";
  @override
  List<dynamic> toJson() {
    return [
      {
        "from": from,
        "to": to,
        "gas": gas?.toString(),
        "gas_price": gasPrice?.toString(),
        "max_fee_per_gas": maxFeePerGas?.toString(),
        "max_priority_fee_per_gas": maxPriorityFeePerGas?.toString(),
        "value": value?.toString(),
        "data": data ?? "0x",
        "nonce": nonce,
        "transaction_type": transactionType,
        "access_list": accessList?.map((e) => e.toJson()).toList(),
        "paymasterParams": paymaster?.toJson(),
        "customSignature": customSignature,
        "gasPerPubdata": gasPerPubdata?.toString(),
        "factoryDeps": factoryDeps
      }.notNullValue
    ];
  }

  @override
  BigInt onResonse(String result) {
    return EthereumRequest.onBigintResponse(result);
  }
}
