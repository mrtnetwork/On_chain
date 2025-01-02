import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/models/contract/base_contract/base.dart';
import 'package:on_chain/tron/src/protbuf/decoder.dart';
import 'package:on_chain/utils/utils.dart';

/// Creates a proposal transaction.
class ProposalCreateContract extends TronBaseContract {
  /// Create a new [ProposalCreateContract] instance by parsing a JSON map.
  factory ProposalCreateContract.fromJson(Map<String, dynamic> json) {
    return ProposalCreateContract(
      ownerAddress: OnChainUtils.parseTronAddress(
          value: json['owner_address'], name: 'owner_address'),
      parameters: OnChainUtils.parseMap<dynamic, dynamic>(
                  value: json['parameters'], name: 'parameters') ==
              null
          ? null
          : (json['parameters'] as Map).map(
              (key, value) => MapEntry<BigInt, BigInt>(
                  OnChainUtils.parseBigInt(value: key, name: 'parameters'),
                  OnChainUtils.parseBigInt(value: value, name: 'parameters')),
            ),
    );
  }
  factory ProposalCreateContract.deserialize(List<int> bytes) {
    final decode = TronProtocolBufferImpl.decode(bytes);
    return ProposalCreateContract(
        ownerAddress: TronAddress.fromBytes(decode.getField(1)),
        parameters: decode.getMap<BigInt, BigInt>(2));
  }

  /// Create a new [ProposalCreateContract] instance with specified parameters.
  ProposalCreateContract(
      {required this.ownerAddress, Map<BigInt, BigInt>? parameters})
      : parameters = parameters == null
            ? null
            : Map<BigInt, BigInt>.unmodifiable(parameters);

  /// Account address
  @override
  final TronAddress ownerAddress;

  /// Parameters proposed to be modified and their values
  final Map<BigInt, BigInt>? parameters;

  @override
  List<int> get fieldIds => [1, 2];

  @override
  List get values => [ownerAddress, parameters];

  /// Convert the [ProposalCreateContract] object to a JSON representation.
  @override
  Map<String, dynamic> toJson() {
    return {
      'owner_address': ownerAddress.toString(),
      'parameters': parameters
          ?.map((key, value) => MapEntry(key.toString(), value.toString())),
    };
  }

  /// Convert the [ProposalCreateContract] object to its string representation.
  @override
  String toString() {
    return 'ProposalCreateContract{${toJson()}}';
  }

  @override
  TransactionContractType get contractType =>
      TransactionContractType.proposalCreateContract;
}
