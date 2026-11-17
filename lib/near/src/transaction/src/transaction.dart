import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/near/src/crypto/public_key/public_key.dart';
import 'package:on_chain/near/src/transaction/src/action.dart';
import 'package:on_chain/near/src/crypto/types/types.dart';

class NearTransaction with LayoutSerializable {
  final String signerId;
  final NearPublicKey publicKey;
  final BigInt nonce;
  final String receiverId;
  final List<NearAction> actions;
  final BuBytes blockHash;
  factory NearTransaction.deserialize(List<int> bytes) {
    final decode = LayoutSerializable.deserialize(
      bytes: bytes,
      layout: NearTransaction.layout(),
    );
    return NearTransaction.deserializeJson(decode);
  }
  NearTransaction({
    required this.signerId,
    required this.publicKey,
    required this.nonce,
    required this.receiverId,
    required List<NearAction> actions,
    required List<int> blockHash,
  }) : actions = actions.immutable,
       blockHash =
           blockHash
               .exc(
                 length: 32,
                 operation: "NearTransaction",
                 reason: "Invalid block hash bytes length.",
               )
               .asImmutableBytes;
  factory NearTransaction.deserializeJson(Map<String, dynamic> json) {
    return NearTransaction(
      signerId: json.valueAsString('signerId'),
      publicKey: NearPublicKey.deserializeJson(
        json.valueEnsureAsMap("publicKey"),
      ),
      receiverId: json.valueAsString('receiverId'),
      nonce: json.valueAsBigInt('nonce'),
      actions:
          json
              .valueEnsureAsList<Map<String, dynamic>>('actions')
              .map((e) => NearAction.deserializeJson(e))
              .toList(),
      blockHash: json.valueAsBytes('blockHash'),
    );
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.string(property: "signerId"),
      NearPublicKey.layout(property: "publicKey"),
      LayoutConst.u64(property: "nonce"),
      LayoutConst.string(property: "receiverId"),
      LayoutConst.fixedBlob32(property: "blockHash"),
      LayoutConst.vec(NearAction.layout(), property: "actions"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {
      'signerId': signerId,
      'publicKey': publicKey.toSerializeVariantJson(),
      'nonce': nonce,
      'receiverId': receiverId,
      'actions': actions.map((e) => e.toSerializeVariantJson()).toList(),

      'blockHash': blockHash,
    };
  }
}

class NearSignedTransaction with LayoutSerializable {
  final NearTransaction transaction;
  final NearSignature signature;
  NearSignedTransaction({required this.transaction, required this.signature});
  factory NearSignedTransaction.deserializeJson(Map<String, dynamic> json) {
    return NearSignedTransaction(
      transaction: NearTransaction.deserializeJson(
        json.valueEnsureAsMap("transaction"),
      ),
      signature: NearSignature.deserializeJson(
        json.valueEnsureAsMap("signature"),
      ),
    );
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      NearTransaction.layout(property: "transaction"),
      NearSignature.layout(property: "signature"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {
      'transaction': transaction.toSerializeJson(),
      'signature': signature.toSerializeVariantJson(),
    };
  }
}
