import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/types/types.dart';
import 'package:on_chain/solana/src/instructions/metaplex/fixed_price_sale/types/types/creator.dart';

class MetaplexBubblegumProgramUtils {
  static List<int> computeDataHash(MetaData metaData) {
    final metaDataHash = QuickCrypto.keccack256Hash(metaData.toBytes());
    final pointBytes = metaData.sellerFeeBasisPoints.toU16LeBytes();
    return QuickCrypto.keccack256Hash([...metaDataHash, ...pointBytes]);
  }

  static List<int> computeCreatorHash(List<Creator> creators) {
    final creatorBytes =
        creators
            .map((e) => [...e.address.toBytes(), e.verified ? 1 : 0, e.share])
            .expand((element) => element)
            .toList();
    return QuickCrypto.keccack256Hash(creatorBytes);
  }

  static List<int> computeCompressedNFTHash({
    required SolAddress assetId,
    required SolAddress owner,
    required SolAddress delegate,
    required BigInt treeNonce,
    required MetaData metaData,
  }) {
    return QuickCrypto.keccack256Hash([
      0x1,
      ...assetId.toBytes(),
      ...owner.toBytes(),
      ...delegate.toBytes(),
      ...treeNonce.toU64LeBytes(),
      ...computeDataHash(metaData),
      ...computeCreatorHash(metaData.creators),
    ]);
  }
}
