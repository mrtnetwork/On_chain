import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/address/tron_address.dart';

import 'package:on_chain/tron/src/models/contracts/core/contract.dart';
import 'package:on_chain/tron/src/proto_messages/protocol/src/shield_contract.dart';
import 'package:on_chain/tron/src/proto_messages/protocol/src/tron.dart'
    show TronTransactionContractContractType;
import 'package:on_chain/tron/src/proto_messages/types.dart';
import 'package:on_chain/tron/src/serialization/protobuf/proto.dart';

class TronShieldedTransferContract extends ITronContract {
  final BuBytes? transparentFromAddress;

  /// transparent address
  final BigInt? fromAmount;

  final List<TronSpendDescription> spendDescription;

  final List<TronReceiveDescription> receiveDescription;

  final BuBytes? bindingSignature;

  final BuBytes? transparentToAddress;

  /// transparent address
  final BigInt? toAmount;

  TronShieldedTransferContract({
    List<int>? transparentFromAddress,
    this.fromAmount,
    this.spendDescription = const [],
    this.receiveDescription = const [],
    List<int>? bindingSignature,
    List<int>? transparentToAddress,
    this.toAmount,
  }) : transparentFromAddress = transparentFromAddress?.asImmutableBytes,
       bindingSignature = bindingSignature?.asImmutableBytes,
       transparentToAddress = transparentToAddress?.asImmutableBytes,
       super(TronTransactionContractContractType.shieldedTransferContract);

  @override
  ProtoMessageConfig protoConfig() => protoConfigStatic();

  static ProtoMessageConfig protoConfigStatic() {
    return ProtoMessageConfig(
      syntax: ProtoSyntax.v3,
      options: const [],
      fields: [
        ProtoFieldConfig.bytes(1),
        ProtoFieldConfig.int64(2),
        ProtoFieldConfig.repeated(
          fieldNumber: 3,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.repeated(
          fieldNumber: 4,
          elementType: ProtoFieldType.message,
        ),
        ProtoFieldConfig.bytes(5),
        ProtoFieldConfig.bytes(6),
        ProtoFieldConfig.int64(7),
      ],
    );
  }

  @override
  List<Object?> get protoValues => [
    transparentFromAddress,
    fromAmount,
    spendDescription,
    receiveDescription,
    bindingSignature,
    transparentToAddress,
    toAmount,
  ];

  @override
  Map<String, dynamic> toJson({
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return {
      'transparent_from_address': config.encodeBinary(transparentFromAddress),
      'from_amount': config.encodeBigint(fromAmount),
      'spend_description': spendDescription.map(config.encodeMessage).toList(),
      'receive_description':
          receiveDescription.map(config.encodeMessage).toList(),
      'binding_signature': config.encodeBinary(bindingSignature),
      'transparent_to_address': config.encodeBinary(transparentToAddress),
      'to_amount': config.encodeBigint(toAmount),
    }.notNullValue;
  }

  factory TronShieldedTransferContract.fromJson(
    Map<String, dynamic> json, {
    TronProtoJsonConfig config = TronProtoJsonConfig.config,
  }) {
    return TronShieldedTransferContract(
      transparentFromAddress: config.decodeBinary<List<int>?>(
        json.valueAs(
          'transparent_from_address',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      fromAmount: json.valueAsBigInt<BigInt?>(
        'from_amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
      spendDescription:
          (json.valueEnsureAsList<dynamic>(
                'spend_description',
                normalizeKeyLookup: config.normalizeKeys,
              ))
              .map(
                (e) => JsonParser.valueTo<
                  TronSpendDescription,
                  Map<String, dynamic>
                >(value: e, parse: (v) => TronSpendDescription.fromJson(v)),
              )
              .toList(),
      receiveDescription:
          (json.valueEnsureAsList<dynamic>(
                'receive_description',
                normalizeKeyLookup: config.normalizeKeys,
              ))
              .map(
                (e) => JsonParser.valueTo<
                  TronReceiveDescription,
                  Map<String, dynamic>
                >(value: e, parse: (v) => TronReceiveDescription.fromJson(v)),
              )
              .toList(),
      bindingSignature: config.decodeBinary<List<int>?>(
        json.valueAs(
          'binding_signature',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      transparentToAddress: config.decodeBinary<List<int>?>(
        json.valueAs(
          'transparent_to_address',
          normalizeKeyLookup: config.normalizeKeys,
        ),
      ),
      toAmount: json.valueAsBigInt<BigInt?>(
        'to_amount',
        normalizeKeyLookup: config.normalizeKeys,
      ),
    );
  }

  factory TronShieldedTransferContract.deserialize(List<int> bytes) {
    final decode = TronProtoMessage.decode(bytes, protoConfigStatic());
    return TronShieldedTransferContract(
      transparentFromAddress: decode.getBytes<List<int>?>(1),
      fromAmount: decode.getBigInt<BigInt?>(2),
      spendDescription:
          decode
              .getListOfBytes(3)
              .map((b) => TronSpendDescription.deserialize(b))
              .toList(),
      receiveDescription:
          decode
              .getListOfBytes(4)
              .map((b) => TronReceiveDescription.deserialize(b))
              .toList(),
      bindingSignature: decode.getBytes<List<int>?>(5),
      transparentToAddress: decode.getBytes<List<int>?>(6),
      toAmount: decode.getBigInt<BigInt?>(7),
    );
  }

  @override
  DefaultTronProtoTypeUrl get declarationId =>
      DefaultTronProtoTypeUrl.protocolShieldedTransferContract;

  @override
  TronAddress get ownerAddress =>
      throw BuError(
        DefaultErrorType.invalidAddress,
        "Shielded transfers have no transparent owner address.",
      );
}
