import 'package:blockchain_utils/helper/extensions/extensions.dart';
import 'package:on_chain/near/src/address/address.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

sealed class NearBlockReference {
  T fold<T extends Object>({
    required T Function(NearRpcBlockId blockId) onBlockId,
    required T Function(NearRpcFinality finality) onFinality,
  });
  const NearBlockReference();
  static const NearBlockReference optimistic = NearBlockRefrenceFinality(
    finality: NearRpcFinality.optimistic,
  );
}

class NearBlockRefrenceBlockId implements NearBlockReference {
  final NearRpcBlockId blockId;
  const NearBlockRefrenceBlockId(this.blockId);
  factory NearBlockRefrenceBlockId.height(int height) =>
      NearBlockRefrenceBlockId(
        NearRpcBlockIdBlockHeight(BigInt.from(height.asPositive)),
      );
  factory NearBlockRefrenceBlockId.hash(String hash) =>
      NearBlockRefrenceBlockId(NearRpcBlockIdCryptoHash(hash));

  @override
  T fold<T extends Object>({
    required T Function(NearRpcBlockId blockId) onBlockId,
    required T Function(NearRpcFinality finality) onFinality,
  }) {
    return onBlockId(blockId);
  }
}

class NearBlockRefrenceFinality implements NearBlockReference {
  final NearRpcFinality finality;
  const NearBlockRefrenceFinality({this.finality = NearRpcFinality.optimistic});

  @override
  T fold<T extends Object>({
    required T Function(NearRpcBlockId blockId) onBlockId,
    required T Function(NearRpcFinality finality) onFinality,
  }) {
    return onFinality(finality);
  }
}

class NearApproval {
  final BaseNearAddress ownerId;
  final int approvalId;
  NearApproval({required this.ownerId, required int approvalId})
    : approvalId = approvalId.asPositive;

  List<String> toJson() => [ownerId.address, approvalId.toString()];
}
