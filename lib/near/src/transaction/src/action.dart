// ============================================================
// Permissions
// ============================================================

import 'package:blockchain_utils/crypto/quick_crypto.dart';

import 'package:blockchain_utils/helper/extensions/extensions.dart';
import 'package:blockchain_utils/encoding/encoding.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/near/src/crypto/public_key/public_key.dart';
import 'package:on_chain/near/src/crypto/types/types.dart';
import 'package:on_chain/near/src/nep/prefix.dart';

class NearDelegateAction with LayoutSerializable {
  final String senderId;
  final String receiverId;
  final List<NearClassicAction> actions;
  final BigInt nonce;
  final BigInt maxBlockHeight;
  final NearPublicKey publicKey; // NearPublicKey
  factory NearDelegateAction.deserialize(List<int> bytes) {
    final decode = LayoutSerializable.deserialize(
      bytes: bytes,
      layout: NearDelegateAction.layout(),
    );
    return NearDelegateAction.deserializeJson(decode);
  }
  const NearDelegateAction({
    required this.senderId,
    required this.receiverId,
    required this.actions,
    required this.nonce,
    required this.maxBlockHeight,
    required this.publicKey,
  });

  factory NearDelegateAction.deserializeJson(Map<String, dynamic> json) {
    return NearDelegateAction(
      senderId: json.valueAsString('senderId'),
      receiverId: json.valueAsString('receiverId'),
      actions:
          json
              .valueEnsureAsList<Map<String, dynamic>>('actions')
              .map((e) => NearClassicAction.deserializeJson(e))
              .toList(),
      nonce: json.valueAsBigInt('nonce'),
      maxBlockHeight: json.valueAsBigInt('maxBlockHeight'),
      publicKey: NearPublicKey.deserializeJson(
        json.valueEnsureAsMap("publicKey"),
      ),
    );
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.string(property: "senderId"),
      LayoutConst.string(property: "receiverId"),
      LayoutConst.vec(NearClassicAction.layout(), property: "actions"),
      LayoutConst.u64(property: "nonce"),
      LayoutConst.u64(property: "maxBlockHeight"),
      NearPublicKey.layout(property: "publicKey"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'actions': actions.map((e) => e.toSerializeVariantJson()).toList(),
      'nonce': nonce,
      'maxBlockHeight': maxBlockHeight,
      'publicKey': publicKey.toSerializeVariantJson(),
    };
  }

  List<int> encodeSign() {
    final prefix = DelegateActionPrefix().toSerializeBytes();
    final bytes = toSerializeBytes();
    return QuickCrypto.sha256Hash([...prefix, ...bytes]);
  }
}

class NearFunctionCallPermission with LayoutSerializable {
  final BigInt? allowance;
  final String receiverId;
  final List<String> methodNames;

  const NearFunctionCallPermission({
    this.allowance,
    required this.receiverId,
    required this.methodNames,
  });
  factory NearFunctionCallPermission.deserialize(List<int> bytes) {
    final decode = LayoutSerializable.deserialize(
      bytes: bytes,
      layout: NearFunctionCallPermission.layout(),
    );
    return NearFunctionCallPermission.deserializeJson(decode);
  }
  factory NearFunctionCallPermission.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return NearFunctionCallPermission(
      allowance: json.valueAsBigInt('allowance'),
      receiverId: json.valueAsString('receiverId'),
      methodNames: json.valueAsList<List<String>>('methodNames'),
    );
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.optional(LayoutConst.u128(), property: "allowance"),
      LayoutConst.string(property: "receiverId"),
      LayoutConst.vec(LayoutConst.string(), property: "methodNames"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {
      "allowance": allowance,
      "receiverId": receiverId,
      "methodNames": methodNames,
    };
  }
}

class NearFullAccessPermission with LayoutSerializable {
  const NearFullAccessPermission();

  factory NearFullAccessPermission.deserializeJson(Map<String, dynamic> json) {
    return NearFullAccessPermission();
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.noArgs(property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {};
  }
}

enum NearAccessKeyPermissionType {
  functionCall(0),
  fullAccess(1);

  const NearAccessKeyPermissionType(this.value);
  final int value;
  static NearAccessKeyPermissionType fromValue(int? value) => values.firstWhere(
    (e) => e.value == value,
    orElse:
        () =>
            throw OnChainErrors.nearPlugin(
              "NearAccessKeyPermissionType.lookup",
              reason: "Invalid NearAccessKeyPermissionType value.",
              details: {"value": "$value"},
            ),
  );
  static NearAccessKeyPermissionType fromName(String? name) =>
      values.firstWhere(
        (e) => e.name == name,
        orElse:
            () =>
                throw OnChainErrors.nearPlugin(
                  "NearAccessKeyPermissionType.lookup",
                  reason: "Invalid NearAccessKeyPermissionType name.",
                  details: {"name": "$name"},
                ),
      );
}

sealed class NearAccessKeyPermission with VariantLayoutSerializable {
  final NearAccessKeyPermissionType type;
  const NearAccessKeyPermission(this.type);

  factory NearAccessKeyPermission.deserializeJson(Map<String, dynamic> json) {
    final decode = VariantLayoutSerializable.toVariantDecodeResult(json);
    final type = NearAccessKeyPermissionType.fromName(decode.variantName);
    return switch (type) {
      NearAccessKeyPermissionType.functionCall =>
        NearAccessKeyPermissionFunctionCall.deserializeJson(decode.value),
      NearAccessKeyPermissionType.fullAccess =>
        NearAccessKeyPermissionFullAccess.deserializeJson(decode.value),
    };
  }
  factory NearAccessKeyPermission.deserialize(List<int> bytes) {
    final decode = LayoutSerializable.deserialize(
      bytes: bytes,
      layout: NearAccessKeyPermission.layout(),
    );
    return NearAccessKeyPermission.deserializeJson(decode);
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.lazyEnum([
      LazyVariantModel(
        layout: NearAccessKeyPermissionFunctionCall.layout,
        property: NearAccessKeyPermissionType.functionCall.name,
        index: NearAccessKeyPermissionType.functionCall.value,
      ),
      LazyVariantModel(
        layout: NearAccessKeyPermissionFullAccess.layout,
        property: NearAccessKeyPermissionType.fullAccess.name,
        index: NearAccessKeyPermissionType.fullAccess.value,
      ),
    ], property: property);
  }

  @override
  String get variantName => type.name;

  @override
  Layout<Map<String, dynamic>> toVariantLayout({String? property}) {
    return layout(property: property);
  }
}

class NearAccessKeyPermissionFunctionCall extends NearAccessKeyPermission {
  final NearFunctionCallPermission functionCall;
  const NearAccessKeyPermissionFunctionCall(this.functionCall)
    : super(NearAccessKeyPermissionType.functionCall);
  factory NearAccessKeyPermissionFunctionCall.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return NearAccessKeyPermissionFunctionCall(
      NearFunctionCallPermission.deserializeJson(
        json.valueEnsureAsMap<String, dynamic>("functionCall"),
      ),
    );
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      NearFunctionCallPermission.layout(property: "functionCall"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {"functionCall": functionCall.toSerializeJson()};
  }
}

class NearAccessKeyPermissionFullAccess extends NearAccessKeyPermission {
  const NearAccessKeyPermissionFullAccess()
    : super(NearAccessKeyPermissionType.fullAccess);
  factory NearAccessKeyPermissionFullAccess.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return NearAccessKeyPermissionFullAccess();
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.noArgs(property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {};
  }
}

class NearAccessKey with LayoutSerializable {
  final BigInt nonce;
  final NearAccessKeyPermission permission;

  const NearAccessKey({required this.nonce, required this.permission});
  factory NearAccessKey.deserialize(List<int> bytes) {
    final decode = LayoutSerializable.deserialize(
      bytes: bytes,
      layout: NearAccessKey.layout(),
    );
    return NearAccessKey.deserializeJson(decode);
  }
  factory NearAccessKey.deserializeJson(Map<String, dynamic> json) {
    return NearAccessKey(
      nonce: json.valueAsBigInt("nonce"),
      permission: NearAccessKeyPermission.deserializeJson(
        json.valueEnsureAsMap("permission"),
      ),
    );
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.u64(property: "nonce"),
      NearAccessKeyPermission.layout(property: "permission"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {"nonce": nonce, "permission": permission.toSerializeVariantJson()};
  }
}

// ============================================================
// Simple Actions
// ============================================================

class NearDeployContract with LayoutSerializable {
  final List<int> code;
  const NearDeployContract(this.code);
  factory NearDeployContract.deserialize(List<int> bytes) {
    final decode = LayoutSerializable.deserialize(
      bytes: bytes,
      layout: NearDeployContract.layout(),
    );
    return NearDeployContract.deserializeJson(decode);
  }
  factory NearDeployContract.deserializeJson(Map<String, dynamic> json) {
    return NearDeployContract(json.valueAsBytes("code"));
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.vec(LayoutConst.u8(), property: "code"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {"code": code};
  }
}

class NearFunctionCall with LayoutSerializable {
  final String methodName;
  final List<int> args;
  final BigInt gas;
  final BigInt deposit;
  factory NearFunctionCall.deserialize(List<int> bytes) {
    final decode = LayoutSerializable.deserialize(
      bytes: bytes,
      layout: NearFunctionCall.layout(),
    );
    return NearFunctionCall.deserializeJson(decode);
  }
  const NearFunctionCall({
    required this.methodName,
    required this.args,
    required this.gas,
    required this.deposit,
  });

  factory NearFunctionCall.deserializeJson(Map<String, dynamic> json) {
    return NearFunctionCall(
      methodName: json.valueAsString('methodName'),
      args: json.valueAsBytes('args'),
      gas: json.valueAsBigInt('gas'),
      deposit: json.valueAsBigInt('deposit'),
    );
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.string(property: "methodName"),
      LayoutConst.vec(LayoutConst.u8(), property: "args"),
      LayoutConst.u64(property: "gas"),
      LayoutConst.u128(property: "deposit"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {
      'methodName': methodName,
      'args': args,
      'gas': gas,
      'deposit': deposit,
    };
  }
}

class NearTransfer with LayoutSerializable {
  final BigInt deposit;
  const NearTransfer({required this.deposit});
  factory NearTransfer.deserialize(List<int> bytes) {
    final decode = LayoutSerializable.deserialize(
      bytes: bytes,
      layout: NearTransfer.layout(),
    );
    return NearTransfer.deserializeJson(decode);
  }
  factory NearTransfer.deserializeJson(Map<String, dynamic> json) {
    return NearTransfer(deposit: json.valueAsBigInt('deposit'));
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.u128(property: "deposit"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {'deposit': deposit};
  }
}

class NearStake with LayoutSerializable {
  final BigInt stake;
  final NearPublicKey publicKey; // NearPublicKey

  const NearStake({required this.stake, required this.publicKey});
  factory NearStake.deserialize(List<int> bytes) {
    final decode = LayoutSerializable.deserialize(
      bytes: bytes,
      layout: NearStake.layout(),
    );
    return NearStake.deserializeJson(decode);
  }
  factory NearStake.deserializeJson(Map<String, dynamic> json) {
    return NearStake(
      stake: json.valueAsBigInt('stake'),
      publicKey: json.valueTo<NearPublicKey, Map<String, dynamic>>(
        key: "publicKey",
        parse: (v) => NearPublicKey.deserializeJson(v),
      ),
    );
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.u128(property: "stake"),
      NearPublicKey.layout(property: "publicKey"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {'stake': stake, "publicKey": publicKey.toSerializeVariantJson()};
  }
}

class NearAddKey with LayoutSerializable {
  final NearPublicKey publicKey; // NearPublicKey
  final NearAccessKey accessKey;

  const NearAddKey({required this.publicKey, required this.accessKey});
  factory NearAddKey.deserialize(List<int> bytes) {
    final decode = LayoutSerializable.deserialize(
      bytes: bytes,
      layout: NearAddKey.layout(),
    );
    return NearAddKey.deserializeJson(decode);
  }

  factory NearAddKey.deserializeJson(Map<String, dynamic> json) {
    return NearAddKey(
      publicKey: NearPublicKey.deserializeJson(
        json.valueEnsureAsMap('publicKey'),
      ),
      accessKey: NearAccessKey.deserializeJson(
        json.valueEnsureAsMap('accessKey'),
      ),
    );
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      NearPublicKey.layout(property: "publicKey"),
      NearAccessKey.layout(property: "accessKey"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {
      "publicKey": publicKey.toSerializeVariantJson(),
      'accessKey': accessKey.toSerializeJson(),
    };
  }
}

class NearDeleteKey with LayoutSerializable {
  final NearPublicKey publicKey; // NearPublicKey
  const NearDeleteKey({required this.publicKey});
  factory NearDeleteKey.deserialize(List<int> bytes) {
    final decode = LayoutSerializable.deserialize(
      bytes: bytes,
      layout: NearDeleteKey.layout(),
    );
    return NearDeleteKey.deserializeJson(decode);
  }
  factory NearDeleteKey.deserializeJson(Map<String, dynamic> json) {
    return NearDeleteKey(
      publicKey: NearPublicKey.deserializeJson(
        json.valueEnsureAsMap('publicKey'),
      ),
    );
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      NearPublicKey.layout(property: "publicKey"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {"publicKey": publicKey.toSerializeVariantJson()};
  }
}

class NearDeleteAccount with LayoutSerializable {
  final String beneficiaryId;
  const NearDeleteAccount(this.beneficiaryId);

  factory NearDeleteAccount.deserializeJson(Map<String, dynamic> json) {
    return NearDeleteAccount(json.valueAsString('beneficiaryId'));
  }
  factory NearDeleteAccount.deserialize(List<int> bytes) {
    final decode = LayoutSerializable.deserialize(
      bytes: bytes,
      layout: NearDeleteAccount.layout(),
    );
    return NearDeleteAccount.deserializeJson(decode);
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.string(property: "beneficiaryId"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {"beneficiaryId": beneficiaryId};
  }
}

class NearSignedDelegate with LayoutSerializable {
  final NearDelegateAction delegateAction; // DelegateAction
  final NearSignature signature; // Signature

  const NearSignedDelegate({
    required this.delegateAction,
    required this.signature,
  });

  factory NearSignedDelegate.deserializeJson(Map<String, dynamic> json) {
    return NearSignedDelegate(
      delegateAction: NearDelegateAction.deserializeJson(
        json.valueEnsureAsMap<String, dynamic>("delegateAction"),
      ),
      signature: NearSignature.deserializeJson(
        json.valueEnsureAsMap<String, dynamic>("signature"),
      ),
    );
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      NearDelegateAction.layout(property: "delegateAction"),
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
      "delegateAction": delegateAction.toSerializeJson(),
      "signature": signature.toSerializeVariantJson(),
    };
  }
}

// ============================================================
// Global Contract
// ============================================================
enum NearGlobalContractDeployModeType {
  codeHash(0),
  accountId(1);

  final int value;
  const NearGlobalContractDeployModeType(this.value);
  static NearGlobalContractDeployModeType fromName(String? name) =>
      values.firstWhere(
        (e) => e.name == name,
        orElse:
            () =>
                throw OnChainErrors.nearPlugin(
                  "NearGlobalContractDeployModeType.lookup",
                  reason: "Invalid NearGlobalContractDeployModeType name.",
                  details: {"name": "$name"},
                ),
      );
}

sealed class NearGlobalContractDeployMode with VariantLayoutSerializable {
  final NearGlobalContractDeployModeType type;
  const NearGlobalContractDeployMode(this.type);

  factory NearGlobalContractDeployMode.deserializeJson(
    Map<String, dynamic> json,
  ) {
    final decode = VariantLayoutSerializable.toVariantDecodeResult(json);
    final type = NearGlobalContractDeployModeType.fromName(decode.variantName);
    return switch (type) {
      NearGlobalContractDeployModeType.codeHash =>
        NearGlobalContractDeployModeCodeHash.deserializeJson(decode.value),
      NearGlobalContractDeployModeType.accountId =>
        NearGlobalContractDeployModeAccountId.deserializeJson(decode.value),
    };
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.lazyEnum([
      LazyVariantModel(
        layout: NearGlobalContractDeployModeCodeHash.layout,
        property: NearGlobalContractDeployModeType.codeHash.name,
        index: NearGlobalContractDeployModeType.codeHash.value,
      ),
      LazyVariantModel(
        layout: NearGlobalContractDeployModeAccountId.layout,
        property: NearGlobalContractDeployModeType.accountId.name,
        index: NearGlobalContractDeployModeType.accountId.value,
      ),
    ], property: property);
  }

  @override
  String get variantName => type.name;
  @override
  Layout<Map<String, dynamic>> toVariantLayout({String? property}) {
    return layout(property: property);
  }
}

class NearGlobalContractDeployModeCodeHash
    extends NearGlobalContractDeployMode {
  const NearGlobalContractDeployModeCodeHash()
    : super(NearGlobalContractDeployModeType.codeHash);

  factory NearGlobalContractDeployModeCodeHash.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return NearGlobalContractDeployModeCodeHash();
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.noArgs(property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {};
  }
}

class NearGlobalContractDeployModeAccountId
    extends NearGlobalContractDeployMode {
  const NearGlobalContractDeployModeAccountId()
    : super(NearGlobalContractDeployModeType.accountId);

  factory NearGlobalContractDeployModeAccountId.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return NearGlobalContractDeployModeAccountId();
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.noArgs(property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {};
  }
}

enum NearGlobalContractIdentifierType {
  codeHash(0),
  accountId(1);

  final int value;
  const NearGlobalContractIdentifierType(this.value);
  static NearGlobalContractIdentifierType fromName(String? name) =>
      values.firstWhere(
        (e) => e.name == name,
        orElse:
            () =>
                throw OnChainErrors.nearPlugin(
                  "NearGlobalContractIdentifierType.lookup",
                  reason: "Invalid NearGlobalContractIdentifierType name.",
                  details: {"name": "$name"},
                ),
      );
}

sealed class NearGlobalContractIdentifier with VariantLayoutSerializable {
  final NearGlobalContractIdentifierType type;
  const NearGlobalContractIdentifier(this.type);
  factory NearGlobalContractIdentifier.deserialize(List<int> bytes) {
    final decode = LayoutSerializable.deserialize(
      bytes: bytes,
      layout: NearGlobalContractIdentifier.layout(),
    );
    return NearGlobalContractIdentifier.deserializeJson(decode);
  }
  factory NearGlobalContractIdentifier.deserializeJson(
    Map<String, dynamic> json,
  ) {
    final decode = VariantLayoutSerializable.toVariantDecodeResult(json);
    final type = NearGlobalContractIdentifierType.fromName(decode.variantName);
    return switch (type) {
      NearGlobalContractIdentifierType.codeHash =>
        NearGlobalContractIdentifierCodeHash.deserializeJson(decode.value),
      NearGlobalContractIdentifierType.accountId =>
        NearGlobalContractIdentifierAccountId.deserializeJson(decode.value),
    };
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.lazyEnum([
      LazyVariantModel(
        layout: NearGlobalContractIdentifierCodeHash.layout,
        property: NearGlobalContractIdentifierType.codeHash.name,
        index: NearGlobalContractIdentifierType.codeHash.value,
      ),
      LazyVariantModel(
        layout: NearGlobalContractIdentifierAccountId.layout,
        property: NearGlobalContractIdentifierType.accountId.name,
        index: NearGlobalContractIdentifierType.accountId.value,
      ),
    ], property: property);
  }

  @override
  String get variantName => type.name;

  @override
  Layout<Map<String, dynamic>> toVariantLayout({String? property}) {
    return layout(property: property);
  }
}

class NearGlobalContractIdentifierCodeHash
    extends NearGlobalContractIdentifier {
  final List<int> codeHash;
  NearGlobalContractIdentifierCodeHash(List<int> codeHash)
    : codeHash = codeHash.asImmutableBytes.exc(
        length: 32,
        operation: "Invalid codeHash bytes length.",
      ),
      super(NearGlobalContractIdentifierType.codeHash);
  factory NearGlobalContractIdentifierCodeHash.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return NearGlobalContractIdentifierCodeHash(json.valueAsBytes("codeHash"));
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.fixedBlob32(property: "codeHash"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {"codeHash": codeHash};
  }
}

class NearGlobalContractIdentifierAccountId
    extends NearGlobalContractIdentifier {
  final String accountId;
  const NearGlobalContractIdentifierAccountId(this.accountId)
    : super(NearGlobalContractIdentifierType.accountId);
  factory NearGlobalContractIdentifierAccountId.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return NearGlobalContractIdentifierAccountId(
      json.valueAsString("accountId"),
    );
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.string(property: "accountId"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {"accountId": accountId};
  }
}

class NearDeployGlobalContract with LayoutSerializable {
  final List<int> code;
  final NearGlobalContractDeployMode deployMode;

  const NearDeployGlobalContract({
    required this.code,
    required this.deployMode,
  });
  factory NearDeployGlobalContract.deserialize(List<int> bytes) {
    final decode = LayoutSerializable.deserialize(
      bytes: bytes,
      layout: NearDeployGlobalContract.layout(),
    );
    return NearDeployGlobalContract.deserializeJson(decode);
  }
  factory NearDeployGlobalContract.deserializeJson(Map<String, dynamic> json) {
    return NearDeployGlobalContract(
      code: json.valueAsBytes('code'),
      deployMode: NearGlobalContractDeployMode.deserializeJson(
        json.valueEnsureAsMap('deployMode'),
      ),
    );
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.vec(LayoutConst.u8(), property: "code"),
      NearGlobalContractDeployMode.layout(property: "deployMode"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {"code": code, "deployMode": deployMode.toSerializeVariantJson()};
  }
}

class NearUseGlobalContract with LayoutSerializable {
  final NearGlobalContractIdentifier contractIdentifier;

  const NearUseGlobalContract({required this.contractIdentifier});
  factory NearUseGlobalContract.deserialize(List<int> bytes) {
    final decode = LayoutSerializable.deserialize(
      bytes: bytes,
      layout: NearUseGlobalContract.layout(),
    );
    return NearUseGlobalContract.deserializeJson(decode);
  }
  factory NearUseGlobalContract.deserializeJson(Map<String, dynamic> json) {
    return NearUseGlobalContract(
      contractIdentifier: NearGlobalContractIdentifier.deserializeJson(
        json.valueEnsureAsMap('contractIdentifier'),
      ),
    );
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      NearGlobalContractIdentifier.layout(property: "contractIdentifier"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {"contractIdentifier": contractIdentifier.toSerializeVariantJson()};
  }
}

enum NearActionType {
  createAccount(0),
  deployContract(1),
  functionCall(2),
  transfer(3),
  stake(4),
  addKey(5),
  deleteKey(6),
  deleteAccount(7),
  signedDelegate(8),
  deployGlobalContract(9),
  useGlobalContract(10);

  const NearActionType(this.value);

  final int value;
  static NearActionType fromValue(int? value) => values.firstWhere(
    (e) => e.value == value,
    orElse:
        () =>
            throw OnChainErrors.nearPlugin(
              "NearActionType.lookup",
              reason: "Invalid NearActionType value.",
              details: {"value": "$value"},
            ),
  );
  static NearActionType fromName(String? name) => values.firstWhere(
    (e) => e.name == name,
    orElse:
        () =>
            throw OnChainErrors.nearPlugin(
              "NearActionType.lookup",
              reason: "Invalid NearActionType name.",
              details: {"name": "$name"},
            ),
  );
}

sealed class BaseNearAction with VariantLayoutSerializable {
  final NearActionType type;
  const BaseNearAction(this.type);
  @override
  String get variantName => type.name;
  static Layout<Map<String, dynamic>> layout(
    bool classicAction, {
    String? property,
  }) => LayoutConst.lazyEnum([
    LazyVariantModel(
      layout: ActionCreateAccount.layout,
      property: NearActionType.createAccount.name,
      index: NearActionType.createAccount.value,
    ),
    LazyVariantModel(
      layout: ActionDeployContract.layout,
      property: NearActionType.deployContract.name,
      index: NearActionType.deployContract.value,
    ),
    LazyVariantModel(
      layout: ActionFunctionCall.layout,
      property: NearActionType.functionCall.name,
      index: NearActionType.functionCall.value,
    ),
    LazyVariantModel(
      layout: ActionTransfer.layout,
      property: NearActionType.transfer.name,
      index: NearActionType.transfer.value,
    ),
    LazyVariantModel(
      layout: ActionStake.layout,
      property: NearActionType.stake.name,
      index: NearActionType.stake.value,
    ),
    LazyVariantModel(
      layout: ActionAddKey.layout,
      property: NearActionType.addKey.name,
      index: NearActionType.addKey.value,
    ),
    LazyVariantModel(
      layout: ActionDeleteKey.layout,
      property: NearActionType.deleteKey.name,
      index: NearActionType.deleteKey.value,
    ),
    LazyVariantModel(
      layout: ActionDeleteAccount.layout,
      property: NearActionType.deleteAccount.name,
      index: NearActionType.deleteAccount.value,
    ),
    LazyVariantModel(
      layout: ({property}) {
        if (classicAction) {
          throw OnChainErrors.nearPlugin(
            "NearClassicAction.layout",
            reason:
                "NearSignedDelegate action not supported by classic actions.",
          );
        }
        return ActionSignedDelegate.layout(property: property);
      },
      property: NearActionType.signedDelegate.name,
      index: NearActionType.signedDelegate.value,
    ),
    LazyVariantModel(
      layout: ActionDeployGlobalContract.layout,
      property: NearActionType.deployGlobalContract.name,
      index: NearActionType.deployGlobalContract.value,
    ),
    LazyVariantModel(
      layout: ActionUseGlobalContract.layout,
      property: NearActionType.useGlobalContract.name,
      index: NearActionType.useGlobalContract.value,
    ),
  ], property: property);
}

sealed class NearClassicAction extends BaseNearAction {
  const NearClassicAction(super.type);
  factory NearClassicAction.deserialize(List<int> bytes) {
    final decode = LayoutSerializable.deserialize(
      bytes: bytes,
      layout: NearClassicAction.layout(),
    );
    return NearClassicAction.deserializeJson(decode);
  }
  factory NearClassicAction.deserializeJson(Map<String, dynamic> json) {
    final decode = VariantLayoutSerializable.toVariantDecodeResult(json);
    final type = NearActionType.fromName(decode.variantName);
    return switch (type) {
      NearActionType.createAccount => ActionCreateAccount.deserializeJson(
        decode.value,
      ),
      NearActionType.deployContract => ActionDeployContract.deserializeJson(
        decode.value,
      ),
      NearActionType.functionCall => ActionFunctionCall.deserializeJson(
        decode.value,
      ),
      NearActionType.transfer => ActionTransfer.deserializeJson(decode.value),
      NearActionType.stake => ActionStake.deserializeJson(decode.value),
      NearActionType.addKey => ActionAddKey.deserializeJson(decode.value),
      NearActionType.deleteKey => ActionDeleteKey.deserializeJson(decode.value),
      NearActionType.deleteAccount => ActionDeleteAccount.deserializeJson(
        decode.value,
      ),
      NearActionType.signedDelegate =>
        throw OnChainErrors.nearPlugin(
          "NearClassicAction.serialize",
          reason: "NearSignedDelegate action not supported by classic actions.",
        ),
      NearActionType.deployGlobalContract =>
        ActionDeployGlobalContract.deserializeJson(decode.value),
      NearActionType.useGlobalContract =>
        ActionUseGlobalContract.deserializeJson(decode.value),
    };
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return BaseNearAction.layout(true, property: property);
  }

  @override
  Layout<Map<String, dynamic>> toVariantLayout({String? property}) {
    return layout(property: property);
  }
}

sealed class NearAction extends BaseNearAction {
  const NearAction(super.type);

  factory NearAction.deserializeJson(Map<String, dynamic> json) {
    final decode = VariantLayoutSerializable.toVariantDecodeResult(json);
    final type = NearActionType.fromName(decode.variantName);

    return switch (type) {
      NearActionType.createAccount => ActionCreateAccount.deserializeJson(
        decode.value,
      ),
      NearActionType.deployContract => ActionDeployContract.deserializeJson(
        decode.value,
      ),
      NearActionType.functionCall => ActionFunctionCall.deserializeJson(
        decode.value,
      ),
      NearActionType.transfer => ActionTransfer.deserializeJson(decode.value),
      NearActionType.stake => ActionStake.deserializeJson(decode.value),
      NearActionType.addKey => ActionAddKey.deserializeJson(decode.value),
      NearActionType.deleteKey => ActionDeleteKey.deserializeJson(decode.value),
      NearActionType.deleteAccount => ActionDeleteAccount.deserializeJson(
        decode.value,
      ),
      NearActionType.signedDelegate => ActionSignedDelegate.deserializeJson(
        decode.value,
      ),
      NearActionType.deployGlobalContract =>
        ActionDeployGlobalContract.deserializeJson(decode.value),
      NearActionType.useGlobalContract =>
        ActionUseGlobalContract.deserializeJson(decode.value),
    };
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return BaseNearAction.layout(false, property: property);
  }

  @override
  Layout<Map<String, dynamic>> toVariantLayout({String? property}) {
    return layout(property: property);
  }
}

class ActionCreateAccount extends NearAction implements NearClassicAction {
  const ActionCreateAccount() : super(NearActionType.createAccount);
  factory ActionCreateAccount.deserializeJson(Map<String, dynamic> json) {
    return ActionCreateAccount();
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.noArgs(property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {};
  }
}

class ActionDeployContract extends NearAction implements NearClassicAction {
  final NearDeployContract deployContract;
  const ActionDeployContract(this.deployContract)
    : super(NearActionType.deployContract);
  factory ActionDeployContract.deserializeJson(Map<String, dynamic> json) {
    return ActionDeployContract(
      NearDeployContract.deserializeJson(
        json.valueEnsureAsMap("deployContract"),
      ),
    );
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      NearDeployContract.layout(property: "deployContract"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {"deployContract": deployContract.toSerializeJson()};
  }
}

class ActionFunctionCall extends NearAction implements NearClassicAction {
  final NearFunctionCall functionCall;
  const ActionFunctionCall(this.functionCall)
    : super(NearActionType.functionCall);
  factory ActionFunctionCall.deserializeJson(Map<String, dynamic> json) {
    return ActionFunctionCall(
      NearFunctionCall.deserializeJson(json.valueEnsureAsMap("functionCall")),
    );
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      NearFunctionCall.layout(property: "functionCall"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {"functionCall": functionCall.toSerializeJson()};
  }
}

class ActionTransfer extends NearAction implements NearClassicAction {
  final NearTransfer transfer;
  const ActionTransfer(this.transfer) : super(NearActionType.transfer);
  factory ActionTransfer.deserializeJson(Map<String, dynamic> json) {
    return ActionTransfer(
      NearTransfer.deserializeJson(json.valueEnsureAsMap("transfer")),
    );
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      NearTransfer.layout(property: "transfer"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {"transfer": transfer.toSerializeJson()};
  }
}

class ActionStake extends NearAction implements NearClassicAction {
  final NearStake stake;
  const ActionStake(this.stake) : super(NearActionType.stake);
  factory ActionStake.deserializeJson(Map<String, dynamic> json) {
    return ActionStake(
      NearStake.deserializeJson(json.valueEnsureAsMap("stake")),
    );
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      NearStake.layout(property: "stake"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {"stake": stake.toSerializeJson()};
  }
}

class ActionAddKey extends NearAction implements NearClassicAction {
  final NearAddKey addKey;
  const ActionAddKey(this.addKey) : super(NearActionType.addKey);
  factory ActionAddKey.deserializeJson(Map<String, dynamic> json) {
    return ActionAddKey(
      NearAddKey.deserializeJson(json.valueEnsureAsMap("addKey")),
    );
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      NearAddKey.layout(property: "addKey"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {"addKey": addKey.toSerializeJson()};
  }
}

class ActionDeleteKey extends NearAction implements NearClassicAction {
  final NearDeleteKey deleteKey;
  const ActionDeleteKey(this.deleteKey) : super(NearActionType.deleteKey);
  factory ActionDeleteKey.deserializeJson(Map<String, dynamic> json) {
    return ActionDeleteKey(
      NearDeleteKey.deserializeJson(json.valueEnsureAsMap("deleteKey")),
    );
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      NearDeleteKey.layout(property: "deleteKey"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {"deleteKey": deleteKey.toSerializeJson()};
  }
}

class ActionDeleteAccount extends NearAction implements NearClassicAction {
  final NearDeleteAccount deleteAccount;
  const ActionDeleteAccount(this.deleteAccount)
    : super(NearActionType.deleteAccount);
  factory ActionDeleteAccount.deserializeJson(Map<String, dynamic> json) {
    return ActionDeleteAccount(
      NearDeleteAccount.deserializeJson(json.valueEnsureAsMap("deleteAccount")),
    );
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      NearDeleteAccount.layout(property: "deleteAccount"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {"deleteAccount": deleteAccount.toSerializeJson()};
  }
}

class ActionSignedDelegate extends NearAction {
  final NearSignedDelegate signedDelegate;
  const ActionSignedDelegate(this.signedDelegate)
    : super(NearActionType.signedDelegate);
  factory ActionSignedDelegate.deserializeJson(Map<String, dynamic> json) {
    return ActionSignedDelegate(
      NearSignedDelegate.deserializeJson(
        json.valueEnsureAsMap("signedDelegate"),
      ),
    );
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      NearSignedDelegate.layout(property: "signedDelegate"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {"signedDelegate": signedDelegate.toSerializeJson()};
  }
}

class ActionDeployGlobalContract extends NearAction
    implements NearClassicAction {
  final NearDeployGlobalContract deployGlobalContract;
  const ActionDeployGlobalContract(this.deployGlobalContract)
    : super(NearActionType.deployGlobalContract);
  factory ActionDeployGlobalContract.deserializeJson(
    Map<String, dynamic> json,
  ) {
    return ActionDeployGlobalContract(
      NearDeployGlobalContract.deserializeJson(
        json.valueEnsureAsMap("deployGlobalContract"),
      ),
    );
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      NearDeployGlobalContract.layout(property: "deployGlobalContract"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {"deployGlobalContract": deployGlobalContract.toSerializeJson()};
  }
}

class ActionUseGlobalContract extends NearAction implements NearClassicAction {
  final NearUseGlobalContract useGlobalContract;
  const ActionUseGlobalContract(this.useGlobalContract)
    : super(NearActionType.useGlobalContract);
  factory ActionUseGlobalContract.deserializeJson(Map<String, dynamic> json) {
    return ActionUseGlobalContract(
      NearUseGlobalContract.deserializeJson(
        json.valueEnsureAsMap("useGlobalContract"),
      ),
    );
  }
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      NearUseGlobalContract.layout(property: "useGlobalContract"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {"useGlobalContract": useGlobalContract.toSerializeJson()};
  }
}
