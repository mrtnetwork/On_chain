import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/tron/src/proto_messages/protocol/src/tron.dart';

extension ExtTronBlockHeaderRaw on TronBlockHeaderraw {
  BuBytes get blockHash => QuickCrypto.sha256Hash(toBuffer());

  /// TRON block ID: `sha256` of the header raw data with the first 8 bytes
  /// replaced by the big-endian block number (java-tron `BlockId` scheme).
  /// This is what nodes return as `blockID` — the raw [blockHash] alone only
  /// matches its last 24 bytes. Verified against Nile blocks 0 and 1.
  ///
  BuBytes get blockId {
    /// maybe user want to calculate block hash
    final number = this.number ?? BigInt.zero;
    final hash = blockHash.toList();
    final numBytes = number.toU64BeBytes();
    return [...numBytes, ...hash.sublist(8)].asImmutableBytes;
  }

  /// Bytes 8-16 of the block hash, used as the transaction reference.
  BuBytes get refBlockHash => blockHash.sublist(8, 16);

  /// Last two bytes of the big-endian block number, used as transaction reference.
  ///
  BuBytes get refBlockBytes {
    final number = this.number;
    if (number == null) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        "Missing block number in raw data.",
      );
    }
    return number.toU64BeBytes().sublist(6, 8);
  }
}

extension ExtTronBlockHeader on TronBlockHeader {
  /// Transaction reference hash derived from the raw block data.
  BuBytes get refBlockHash {
    final rawData = this.rawData;

    if (rawData == null) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        "Missing block raw data in header.",
      );
    }

    return rawData.refBlockHash;
  }

  /// Transaction reference bytes derived from the raw block data.
  BuBytes get refBlockBytes {
    final rawData = this.rawData;
    if (rawData == null) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        "Missing block raw data in header.",
      );
    }
    return rawData.refBlockBytes;
  }
}

extension ExtTronBlock on TronBlock {
  /// Transaction reference hash derived from the block header.
  BuBytes get refBlockHash {
    final rawData = blockHeader;
    if (rawData == null) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        "Missing block header data in block.",
      );
    }

    return rawData.refBlockHash;
  }

  /// Transaction reference bytes derived from the block header.
  BuBytes get refBlockBytes {
    final rawData = blockHeader;
    if (rawData == null) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        "Missing block header data in block.",
      );
    }
    return rawData.refBlockBytes;
  }

  BigInt get timestamp {
    final timestamp = blockHeader?.rawData?.timestamp;
    if (timestamp == null) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        "Missing block header timestamp in block.",
      );
    }
    return timestamp;
  }

  String get blockId {
    final rawData = blockHeader?.rawData;
    if (rawData == null) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        "Missing block raw data in block.",
      );
    }
    return rawData.blockId.toHex();
  }
}

extension ExtTronChainParameters on List<TronChainParametersChainParameter> {
  BigInt _getValue(String key) {
    return firstWhere(
          (e) => e.key == key,
          orElse:
              () =>
                  throw BuError(
                    DefaultErrorType.notFound,
                    "Chain parameter '$key' not found.",
                  ),
        ).value ??
        BigInt.zero;
  }

  int _getInt(String key) => _getValue(key).asSafeInt;

  /// Fee getters for well-known chain parameters.
  int get getCreateAccountFee => _getInt("getCreateAccountFee");
  int get getCreateNewAccountFeeInSystemContract =>
      _getInt("getCreateNewAccountFeeInSystemContract");
  int get getMemoFee => _getInt("getMemoFee");
  int get getTransactionFee => _getInt("getTransactionFee");
  int get getEnergyFee => _getInt("getEnergyFee");
  int get getMultiSignFee => _getInt("getMultiSignFee");
  BigInt get getAssetIssueFee => _getValue("getAssetIssueFee");
  BigInt get getUpdateAccountPermissionFee =>
      _getValue("getUpdateAccountPermissionFee");
  BigInt get getAccountUpgradeCost => _getValue("getAccountUpgradeCost");
}

extension ExtTronTransactionResult on TronTransactionResult {
  bool isSuccess() {
    final ret = this.ret ?? TronTransactionResultcode.sucess;
    final contractRet =
        this.contractRet ?? TronTransactionResultcontractResult.success;
    return ret == TronTransactionResultcode.sucess &&
        (contractRet == TronTransactionResultcontractResult.success ||
            contractRet == TronTransactionResultcontractResult.default_);
  }
}

extension ExtExtTronTransactionResultItrable on List<TronTransactionResult> {
  bool isSuccess() => every((e) => e.isSuccess());
}
