import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/near/src/address/address.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';
import 'package:on_chain/near/src/types/types.dart';

class StorageBalanceBounds {
  final BigInt min;
  final BigInt? max;
  const StorageBalanceBounds({required this.max, required this.min});
  factory StorageBalanceBounds.fromJson(Map<String, dynamic> json) {
    return StorageBalanceBounds(
      max: json.valueAsBigInt("max"),
      min: json.valueAsBigInt("min"),
    );
  }
}

class StorageBalance {
  final BigInt total;
  final BigInt available;
  const StorageBalance({required this.available, required this.total});
  factory StorageBalance.fromJson(Map<String, dynamic> json) {
    return StorageBalance(
      total: json.valueAsBigInt("total"),
      available: json.valueAsBigInt("available"),
    );
  }
}

class FTMetadata {
  final String? spec;
  final String name;
  final String symbol;
  final int decimals;
  final String? image;
  const FTMetadata({
    this.spec,
    required this.name,
    required this.symbol,
    required this.decimals,
    this.image,
  });
}

class MultiTokenTokenMetadata {
  final String? description;
  final String? expiresAt;
  final String? extra;
  final String? issuedAt;
  final String? media;
  final String? mediaHash;
  final String? reference;
  final String? referenceHash;
  final String? startsAt;
  final String? title;
  final String? updatedAt;
  const MultiTokenTokenMetadata({
    this.description,
    this.expiresAt,
    this.extra,
    this.issuedAt,
    this.media,
    this.mediaHash,
    this.reference,
    this.referenceHash,
    this.startsAt,
    this.title,
    this.updatedAt,
  });
  factory MultiTokenTokenMetadata.fromJson(Map<String, dynamic> json) {
    return MultiTokenTokenMetadata(
      description: json.valueAs("description"),
      expiresAt: json.valueAs("expires_at"),
      extra: json.valueAs("extra"),
      issuedAt: json.valueAs("issued_at"),
      media: json.valueAs("media"),
      mediaHash: json.valueAs("media_hash"),
      reference: json.valueAs("reference"),
      referenceHash: json.valueAs("reference_hash"),
      startsAt: json.valueAs("starts_at"),
      title: json.valueAs("title"),
      updatedAt: json.valueAs("updated_at"),
    );
  }
}

class MultiTokenBaseMetadata {
  final String? baseUri;
  final String? copies;
  final String? decimals;
  final String? icon;
  final String id;
  final String name;
  final String? reference;
  final String? referenceHash;
  final String? symbol;
  const MultiTokenBaseMetadata({
    this.baseUri,
    this.copies,
    this.decimals,
    this.icon,
    required this.id,
    required this.name,
    this.reference,
    this.referenceHash,
    this.symbol,
  });
  factory MultiTokenBaseMetadata.fromJson(Map<String, dynamic> json) {
    return MultiTokenBaseMetadata(
      id: json.valueAs("id"),
      symbol: json.valueAs("symbol"),
      baseUri: json.valueAs("base_uri"),
      copies: json.valueAs("copies"),
      decimals: json.valueAs("decimals"),
      icon: json.valueAs("icon"),
      reference: json.valueAs("reference"),
      referenceHash: json.valueAs("reference_hash"),
      name: json.valueAs("name"),
    );
  }
}

class MultiTokenTokenMetadataAll {
  final MultiTokenBaseMetadata base;
  final MultiTokenTokenMetadata token;
  const MultiTokenTokenMetadataAll({required this.base, required this.token});
  factory MultiTokenTokenMetadataAll.fromJson(Map<String, dynamic> json) {
    return MultiTokenTokenMetadataAll(
      base: MultiTokenBaseMetadata.fromJson(json.valueEnsureAsMap("base")),
      token: MultiTokenTokenMetadata.fromJson(json.valueEnsureAsMap("token")),
    );
  }
}

abstract class BaseTokenBalanceArgs {}

class SignleTokenContractBalanceArgs implements BaseTokenBalanceArgs {
  final BaseNearAddress accountId;
  const SignleTokenContractBalanceArgs(this.accountId);
}

class MultiTokenContractBalanceArgs implements BaseTokenBalanceArgs {
  final BaseNearAddress accountId;
  final String tokenId;
  const MultiTokenContractBalanceArgs({
    required this.accountId,
    required this.tokenId,
  });
}

abstract class BaseTokenTransferArgs {}

class NativeTokenTransferArgs implements BaseTokenTransferArgs {
  final BaseNearAddress accountId;
  final BaseNearAddress receiverId;
  final BigInt amount;
  final NearRpcTxExecutionStatus waitUntil;
  const NativeTokenTransferArgs({
    required this.accountId,
    required this.receiverId,
    required this.amount,
    this.waitUntil = NearRpcTxExecutionStatus.executedOptimistic,
  });
}

class FungibleTokenTransferArgs implements BaseTokenTransferArgs {
  final BaseNearAddress receiverId;
  final BaseNearAddress accountId;
  final BigInt amount;
  final String? message;
  final BigInt? deposit;
  final BigInt? gas;
  final NearRpcTxExecutionStatus waitUntil;
  const FungibleTokenTransferArgs({
    required this.accountId,
    required this.receiverId,
    required this.amount,
    this.message,
    this.deposit,
    this.gas,
    this.waitUntil = NearRpcTxExecutionStatus.executedOptimistic,
  });
}

class MultiTokenTransferAmount {
  final String tokenId;
  final BigInt amount;
  const MultiTokenTransferAmount({required this.tokenId, required this.amount});
}

class MultiTokenContractTransferArgs implements BaseTokenTransferArgs {
  final BaseNearAddress receiverId;
  final BaseNearAddress accountId;
  final String tokenId;
  final BigInt amount;
  final String? memo;
  final String? message;
  final BigInt? deposit;
  final BigInt? gas;
  final NearApproval? approval;
  final NearRpcTxExecutionStatus waitUntil;
  const MultiTokenContractTransferArgs({
    required this.accountId,
    required this.receiverId,
    required this.amount,
    required this.tokenId,
    this.memo,
    this.approval,
    this.message,
    this.deposit,
    this.gas,
    this.waitUntil = NearRpcTxExecutionStatus.executedOptimistic,
  });
}

class MultiTokenContractBatchTransferArgs implements BaseTokenTransferArgs {
  final BaseNearAddress receiverId;
  final BaseNearAddress accountId;
  final List<MultiTokenTransferAmount> amounts;
  final String? memo;
  final String? message;
  final BigInt? deposit;
  final BigInt? gas;
  final List<NearApproval?>? approvals;
  final NearRpcTxExecutionStatus waitUntil;
  const MultiTokenContractBatchTransferArgs({
    required this.accountId,
    required this.receiverId,
    required this.amounts,
    this.memo,
    this.approvals,
    this.message,
    this.deposit,
    this.gas,
    this.waitUntil = NearRpcTxExecutionStatus.executedOptimistic,
  });
}
