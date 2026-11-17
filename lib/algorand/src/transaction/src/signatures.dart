import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/algorand/src/address/address.dart';
import 'package:on_chain/algorand/src/utils/layout_utils.dart';
import 'package:on_chain/algorand/src/utils/utils.dart';

import 'transaction.dart';

class AlgoMultisigSubsig with LayoutSerializable {
  final BuBytes publicKey; // pk (32)
  final BuBytes? signature; // s (64), optional until signed

  AlgoMultisigSubsig({required List<int> publicKey, List<int>? signature})
    : signature =
          signature
              ?.exc(
                length: CryptoSignerConst.ed25519SignatureLength,
                operation: "AlgoMultisigSubsig",
                reason: "Invalid signature bytes length.",
              )
              .asImmutableBytes,
      publicKey =
          publicKey
              .exc(
                length: Ed25519KeysConst.pubKeyByteLen,
                operation: "AlgoMultisigSubsig",
                reason: "Invalid public key bytes length.",
              )
              .asImmutableBytes;

  factory AlgoMultisigSubsig.deserializeJson(Map<String, dynamic> json) {
    return AlgoMultisigSubsig(
      publicKey: json.valueAsBytes(
        'pk',
        onMissing: () => List<int>.filled(32, 0),
        encoding: StringEncoding.base64,
      ),
      signature: json.valueAsBytes(
        's',
        onMissing: () => List<int>.filled(64, 0),
        encoding: StringEncoding.base64,
      ),
    );
  }

  static MsgPackFixedKeyDynamicLazyValueMapLayout<
    String,
    dynamic,
    LayoutRepository
  >
  layout({String? property}) {
    return MsgPackFixedKeyDynamicLazyValueMapLayout<
      String,
      dynamic,
      LayoutRepository
    >(
      keyLayout: MsgPackStringLayout(),
      sortKeys: true,
      valueLayouts: [
        MapEntry(
          'pk',
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.defaultBinary32Layout,
          ),
        ),
        MapEntry(
          's',
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.optionalDefaultBinary64Layout,
          ),
        ),
      ],
      property: property,
    );
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) =>
      layout(property: property);

  @override
  Map<String, dynamic> toSerializeJson() {
    return {'pk': publicKey, 's': signature}.notNullValue;
  }

  bool signed() {
    final signature = this.signature;
    if (signature == null || signature.every((e) => e == 0)) return false;
    return true;
  }
}

class AlgoMultisigSig with LayoutSerializable {
  final BigInt version; // v
  final BigInt threshold; // thr
  final List<AlgoMultisigSubsig> subsigs; // subsig

  const AlgoMultisigSig({
    required this.version,
    required this.threshold,
    required this.subsigs,
  });

  factory AlgoMultisigSig.deserializeJson(Map<String, dynamic> json) {
    return AlgoMultisigSig(
      version: json.valueAsBigInt('v', onMissing: () => BigInt.zero),
      threshold: json.valueAsBigInt('thr', onMissing: () => BigInt.zero),
      subsigs:
          (json.valueEnsureAsList<Map<String, dynamic>>(
            'subsig',
            onMissing: () => [],
          )).map(AlgoMultisigSubsig.deserializeJson).toList(),
    );
  }

  bool get isBlank =>
      version == BigInt.zero && threshold == BigInt.zero && subsigs.isEmpty;

  static MsgPackFixedKeyDynamicLazyValueMapLayout<
    String,
    dynamic,
    LayoutRepository
  >
  layout({String? property}) {
    return MsgPackFixedKeyDynamicLazyValueMapLayout<
      String,
      dynamic,
      LayoutRepository
    >(
      keyLayout: MsgPackStringLayout(),
      sortKeys: true,
      valueLayouts: [
        MapEntry(
          'v',
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.defaultU64Layout,
          ),
        ),
        MapEntry(
          'thr',
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.defaultU64Layout,
          ),
        ),
        MapEntry(
          'subsig',
          LazyMsgPackMapLayoutBuilder(
            layout:
                (property, params) => AlgoLayoutArray.defaultArrayLayout(
                  AlgoMultisigSubsig.layout(),
                  property,
                  params,
                  optional: true,
                ),
          ),
        ),
      ],
      property: property,
    );
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) =>
      layout(property: property);

  @override
  Map<String, dynamic> toSerializeJson() {
    return {
      'v': version,
      'thr': threshold,
      'subsig': subsigs.map((e) => e.toSerializeJson()).toList(),
    }.notNullValue;
  }
}

class AlgoPQSig with LayoutSerializable {
  final BuBytes scheme; // sch (2 bytes)
  final BigInt salt; // slt
  final BuBytes publicKey; // pk
  final BuBytes signature; // sig

  AlgoPQSig({
    required List<int> scheme,
    required this.salt,
    required List<int> publicKey,
    required List<int> signature,
  }) : signature = signature.asImmutableBytes,
       publicKey = publicKey.asImmutableBytes,
       scheme = scheme.asImmutableBytes;

  factory AlgoPQSig.deserializeJson(Map<String, dynamic> json) {
    return AlgoPQSig(
      scheme: json.valueAsBytes(
        'sch',
        onMissing: () => List<int>.filled(2, 0),
        encoding: StringEncoding.base64,
      ),
      salt: json.valueAsBigInt('slt', onMissing: () => BigInt.zero),
      publicKey: json.valueAsBytes(
        'pk',
        onMissing: () => <int>[],
        encoding: StringEncoding.base64,
      ),
      signature: json.valueAsBytes(
        'sig',
        onMissing: () => <int>[],
        encoding: StringEncoding.base64,
      ),
    );
  }

  static MsgPackFixedKeyDynamicLazyValueMapLayout<
    String,
    dynamic,
    LayoutRepository
  >
  layout({String? property}) {
    return MsgPackFixedKeyDynamicLazyValueMapLayout<
      String,
      dynamic,
      LayoutRepository
    >(
      keyLayout: MsgPackStringLayout(),
      sortKeys: true,
      valueLayouts: [
        MapEntry(
          'sch',
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.optionalDefaultBinaryLayout,
          ),
        ),
        MapEntry(
          'slt',
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBigIntLayout.optionalDefaultU64Layout,
          ),
        ),
        MapEntry(
          'pk',
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.optionalDefaultBinaryLayout,
          ),
        ),
        MapEntry(
          'sig',
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.optionalDefaultBinaryLayout,
          ),
        ),
      ],
      property: property,
    );
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) =>
      layout(property: property);

  @override
  Map<String, dynamic> toSerializeJson() {
    return {
      'sch': scheme,
      'slt': salt,
      'pk': publicKey,
      'sig': signature,
    }.notNullValue;
  }
}

class AlgoLogicSig with LayoutSerializable {
  final BuBytes logic; // l
  final BuBytes? signature; // sig (64) — delegated single-sig
  final AlgoMultisigSig? msig; // msig
  final AlgoMultisigSig? lmsig;

  /// Not supported yet.
  final AlgoPQSig? pqsig; // pqsig
  final List<BuBytes> args; // arg

  AlgoLogicSig({
    required List<int> logic,
    List<int>? signature,
    this.msig,
    this.lmsig,
    this.pqsig,
    List<List<int>> args = const [],
  }) : signature =
           signature
               ?.exc(
                 length: CryptoSignerConst.ed25519SignatureLength,
                 operation: "AlgoLogicSig",
                 reason: "Invalid signature bytes length.",
               )
               .asImmutableBytes,
       logic = logic.asImmutableBytes,
       args = args.map((e) => e.asImmutableBytes).toImutableList;
  bool isValid() {
    return [signature, msig, lmsig].whereType<Object>().length <= 1;
  }

  factory AlgoLogicSig.deserializeJson(Map<String, dynamic> json) {
    return AlgoLogicSig(
      logic: json.valueAsBytes(
        'l',
        onMissing: () => <int>[],
        encoding: StringEncoding.base64,
      ),
      signature: json.valueAsBytes('sig', encoding: StringEncoding.base64),
      msig: json.valueTo<AlgoMultisigSig?, Map<String, dynamic>>(
        key: 'msig',
        parse: AlgoMultisigSig.deserializeJson,
      ),
      lmsig: json.valueTo<AlgoMultisigSig?, Map<String, dynamic>>(
        key: 'lmsig',
        parse: AlgoMultisigSig.deserializeJson,
      ),
      pqsig: json.valueTo<AlgoPQSig?, Map<String, dynamic>>(
        key: 'pqsig',
        parse: AlgoPQSig.deserializeJson,
      ),
      args:
          json
              .valueEnsureAsList<List>('arg', onMissing: () => [])
              .map(
                (e) => JsonParser.valueAsBytes<List<int>>(
                  e,
                  encoding: StringEncoding.base64,
                ),
              )
              .toList(),
    );
  }

  static MsgPackFixedKeyDynamicLazyValueMapLayout<
    String,
    dynamic,
    LayoutRepository
  >
  layout({String? property}) {
    return MsgPackFixedKeyDynamicLazyValueMapLayout<
      String,
      dynamic,
      LayoutRepository
    >(
      keyLayout: MsgPackStringLayout(),
      sortKeys: true,
      valueLayouts: [
        MapEntry(
          'l',
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.defaultBinaryLayout,
          ),
        ),
        MapEntry(
          'sig',
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.optionalDefaultBinary64Layout,
          ),
        ),
        MapEntry(
          'msig',
          LazyMsgPackMapLayoutBuilder(
            layout:
                (property, params) => AlgoMapLayout.optionalDefaultMapLayout(
                  AlgoMultisigSig.layout(property: property),
                  params,
                ),
          ),
        ),
        MapEntry(
          'lmsig',
          LazyMsgPackMapLayoutBuilder(
            layout:
                (property, params) => AlgoMapLayout.optionalDefaultMapLayout(
                  AlgoMultisigSig.layout(property: property),
                  params,
                ),
          ),
        ),
        MapEntry(
          'pqsig',
          LazyMsgPackMapLayoutBuilder(
            layout:
                (property, params) => AlgoMapLayout.optionalDefaultMapLayout(
                  AlgoPQSig.layout(property: property),
                  params,
                ),
          ),
        ),
        MapEntry(
          'arg',
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoLayoutArray.defaultArrayOfBinaryLayout,
          ),
        ),
      ],
      property: property,
    );
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) =>
      layout(property: property);

  @override
  Map<String, dynamic> toSerializeJson() {
    return {
      'l': logic,
      'sig': signature,
      'msig': msig?.toSerializeJson(),
      'lmsig': lmsig?.toSerializeJson(),
      'pqsig': pqsig?.toSerializeJson(),
      'arg': args,
    }.notNullValue;
  }
}

class AlgoSignedTxn with LayoutSerializable {
  final BuBytes? signature; // sig (64) — ed25519
  final AlgoMultisigSig? msig; // msig
  final AlgoLogicSig? lsig; // lsig
  final AlgoPQSig? pqsig; // pqsig
  final AlgoTransaction transaction; // txn (required)
  final AlgoAddress? authAddr; // sgnr

  AlgoSignedTxn({
    List<int>? signature,
    this.msig,
    this.lsig,
    this.pqsig,
    required this.transaction,
    this.authAddr,
  }) : signature = signature?.asImmutableBytes;

  /// Single-sig signed transaction.
  factory AlgoSignedTxn.sig({
    required List<int>? signature,
    required AlgoTransaction transaction,
    AlgoAddress? authAddr,
  }) {
    return AlgoSignedTxn(
      signature: signature,
      transaction: transaction,
      authAddr: authAddr,
    );
  }

  /// Multisig signed transaction.
  factory AlgoSignedTxn.msig({
    required AlgoMultisigSig msig,
    required AlgoTransaction transaction,
    AlgoAddress? authAddr,
  }) {
    return AlgoSignedTxn(
      msig: msig,
      transaction: transaction,
      authAddr: authAddr,
    );
  }

  /// AlgoLogicSig signed transaction.
  factory AlgoSignedTxn.lsig({
    required AlgoLogicSig lsig,
    required AlgoTransaction transaction,
    AlgoAddress? authAddr,
  }) {
    return AlgoSignedTxn(
      lsig: lsig,
      transaction: transaction,
      authAddr: authAddr,
    );
  }

  factory AlgoSignedTxn.deserializeJson(Map<String, dynamic> json) {
    return AlgoSignedTxn(
      signature: json.valueAsBytes('sig', encoding: StringEncoding.base64),
      msig: json.valueTo<AlgoMultisigSig?, Map<String, dynamic>>(
        key: 'msig',
        parse: AlgoMultisigSig.deserializeJson,
      ),
      lsig: json.valueTo<AlgoLogicSig?, Map<String, dynamic>>(
        key: 'lsig',
        parse: AlgoLogicSig.deserializeJson,
      ),
      pqsig: json.valueTo<AlgoPQSig?, Map<String, dynamic>>(
        key: 'pqsig',
        parse: AlgoPQSig.deserializeJson,
      ),
      transaction: json.valueTo<AlgoTransaction, Map<String, dynamic>>(
        key: 'txn',
        parse: AlgoTransaction.deserializeJson,
      ),
      authAddr: json.valueTo<AlgoAddress?, Object>(
        key: 'sgnr',
        parse: (e) => AlgoUtils.parseAddress(e),
      ),
    );
  }

  static MsgPackFixedKeyDynamicLazyValueMapLayout<
    String,
    dynamic,
    LayoutRepository
  >
  layout({String? property}) {
    return MsgPackFixedKeyDynamicLazyValueMapLayout<
      String,
      dynamic,
      LayoutRepository
    >(
      keyLayout: MsgPackStringLayout(),
      sortKeys: true,
      valueLayouts: [
        MapEntry(
          'txn',
          LazyMsgPackMapLayoutBuilder(
            layout: (property, _) => AlgoTransaction.layout(property: property),
          ),
        ),
        MapEntry(
          'sig',
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoBinaryLayout.optionalDefaultBinary64Layout,
          ),
        ),
        MapEntry(
          'msig',
          LazyMsgPackMapLayoutBuilder(
            layout:
                (property, params) => AlgoMapLayout.optionalDefaultMapLayout(
                  AlgoMultisigSig.layout(property: property),
                  params,
                ),
          ),
        ),
        MapEntry(
          'lsig',
          LazyMsgPackMapLayoutBuilder(
            layout:
                (property, params) => AlgoMapLayout.optionalDefaultMapLayout(
                  AlgoLogicSig.layout(property: property),
                  params,
                ),
          ),
        ),
        MapEntry(
          'pqsig',
          LazyMsgPackMapLayoutBuilder(
            layout:
                (property, params) => AlgoMapLayout.optionalDefaultMapLayout(
                  AlgoPQSig.layout(property: property),
                  params,
                ),
          ),
        ),

        MapEntry(
          'sgnr',
          LazyMsgPackMapLayoutBuilder(
            layout: AlgoAddressLayout.optionalDefaultAddressLayout,
          ),
        ),
      ],
      property: property,
    );
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) =>
      layout(property: property);

  @override
  Map<String, dynamic> toSerializeJson() {
    return {
      'sig': signature,
      'msig': msig?.toSerializeJson(),
      'lsig': lsig?.toSerializeJson(),
      'pqsig': pqsig?.toSerializeJson(),
      'txn': transaction.toSerializeJson(),
      'sgnr': authAddr?.toBytes(),
    }.notNullValue;
  }
}
