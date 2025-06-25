import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';
import 'package:on_chain/utils/utils/utils.dart';

/// Participate the transaction of exchange pair
class ExchangeTransactionContract extends TronBaseContract {
  /// Create a new [ExchangeTransactionContract] instance by parsing a JSON map.
  factory ExchangeTransactionContract.fromJson(Map<String, dynamic> json) {
    return ExchangeTransactionContract(
      ownerAddress: OnChainUtils.parseTronAddress(
          value: json['owner_address'], name: 'owner_address'),
      exchangeId: OnChainUtils.parseBigInt(
          value: json['exchange_id'], name: 'exchange_id'),
      tokenId:
          OnChainUtils.parseBytes(value: json['token_id'], name: 'token_id'),
      quant: OnChainUtils.parseBigInt(value: json['quant'], name: 'quant'),
      expected:
          OnChainUtils.parseBigInt(value: json['expected'], name: 'expected'),
    );
  }

  /// Create a new [ExchangeTransactionContract] instance with specified parameters.
  ExchangeTransactionContract(
      {required this.ownerAddress,
      this.exchangeId,
      List<int>? tokenId,
      this.quant,
      this.expected})
      : tokenId = BytesUtils.tryToBytes(tokenId);
  factory ExchangeTransactionContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return ExchangeTransactionContract(
        ownerAddress: TronAddress.fromBytes(decode.getField(1)),
        exchangeId: decode.getField(2),
        tokenId: decode.getField(3),
        quant: decode.getField(4),
        expected: decode.getField(5));
  }

  /// Trader's wallet address
  @override
  final TronAddress ownerAddress;

  /// Transaction Pair ID
  final BigInt? exchangeId;

  /// ID of the sold token
  final List<int>? tokenId;

  /// Quantity of the token being sold. If TRX being sold, need to express in units of SUN.
  final BigInt? quant;

  /// Expected quantity of the token being purchased.
  final BigInt? expected;

  @override
  List<int> get fieldIds => [1, 2, 3, 4, 5];

  @override
  List get values => [ownerAddress, exchangeId, tokenId, quant, expected];

  /// Convert the [ExchangeTransactionContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson({bool visible = true}) {
    return {
      'owner_address': ownerAddress.toAddress(visible),
      'exchange_id': exchangeId?.toString(),
      'token_id': BytesUtils.tryToHexString(tokenId),
      'quant': quant?.toString(),
      'expected': expected?.toString(),
    }..removeWhere((key, value) => value == null);
  }

  /// Convert the [ExchangeTransactionContract] object to its string representation.
  @override
  String toString() {
    return 'ExchangeTransactionContract{${toJson()}}';
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.exchangeTransactionContract;
}
