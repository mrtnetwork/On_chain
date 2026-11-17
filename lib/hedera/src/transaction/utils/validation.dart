import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/models.dart';

/// Validates a fully assembled Hedera transaction body at build time.
///
/// Field-level checks that run when calling set*/add* stay there.
/// This layer covers cross-field rules that only make sense on the complete
/// body (e.g. transfer balance, required pairs of fields).
class TransactionBuilderValidation {
  TransactionBuilderValidation._();

  static void validateBody(HederaTransactionBody body) {
    final kind = _detectKind(body);
    if (kind == null) {
      throw OnChainErrors.hederaTx(
        'validateTransaction',
        reason: 'No transaction body type is set.',
      );
    }

    switch (kind) {
      case _TxKind.cryptoTransfer:
        _validateCryptoTransfer(body.cryptoTransfer!);
      case _TxKind.cryptoCreate:
        _validateCryptoCreate(body.cryptoCreateAccount!);
      case _TxKind.cryptoUpdate:
        _validateCryptoUpdate(body.cryptoUpdateAccount!);
      case _TxKind.cryptoDelete:
        _validateCryptoDelete(body.cryptoDelete!);
      case _TxKind.cryptoApproveAllowance:
        _validateApproveAllowance(body.cryptoApproveAllowance!);
      case _TxKind.cryptoDeleteAllowance:
        _validateDeleteAllowance(body.cryptoDeleteAllowance!);
      case _TxKind.contractCall:
        _validateContractCall(body.contractCall!);
      case _TxKind.contractCreate:
        _validateContractCreate(body.contractCreateInstance!);
      case _TxKind.contractUpdate:
        _validateContractUpdate(body.contractUpdateInstance!);
      case _TxKind.contractDelete:
        _validateContractDelete(body.contractDeleteInstance!);
      case _TxKind.fileCreate:
        _validateFileCreate(body.fileCreate!);
      case _TxKind.fileAppend:
        _validateFileAppend(body.fileAppend!);
      case _TxKind.fileUpdate:
        _validateFileUpdate(body.fileUpdate!);
      case _TxKind.fileDelete:
        _validateFileDelete(body.fileDelete!);
      case _TxKind.systemDelete:
        _validateSystemDelete(body.systemDelete!);
      case _TxKind.systemUndelete:
        _validateSystemUndelete(body.systemUndelete!);
      case _TxKind.freeze:
        break; // optional fields only
      case _TxKind.consensusCreate:
        break;
      case _TxKind.consensusUpdate:
        _require(body.consensusUpdateTopic?.topicID != null, 'topicID');
      case _TxKind.consensusDelete:
        _require(body.consensusDeleteTopic?.topicID != null, 'topicID');
      case _TxKind.consensusSubmit:
        _validateConsensusSubmit(body.consensusSubmitMessage!);
      case _TxKind.tokenCreate:
        _validateTokenCreate(body.tokenCreation!);
      case _TxKind.tokenUpdate:
        _require(body.tokenUpdate?.token != null, 'token');
      case _TxKind.tokenDelete:
        _require(body.tokenDeletion?.token != null, 'token');
      case _TxKind.tokenMint:
        _validateTokenMint(body.tokenMint!);
      case _TxKind.tokenBurn:
        _validateTokenBurn(body.tokenBurn!);
      case _TxKind.tokenWipe:
        _validateTokenWipe(body.tokenWipe!);
      case _TxKind.tokenAssociate:
        _validateTokenAssociate(body.tokenAssociate!);
      case _TxKind.tokenDissociate:
        _validateTokenDissociate(body.tokenDissociate!);
      case _TxKind.tokenFreeze:
        _validateTokenAccountOp(
          body.tokenFreeze?.token,
          body.tokenFreeze?.account,
          'tokenFreeze',
        );
      case _TxKind.tokenUnfreeze:
        _validateTokenAccountOp(
          body.tokenUnfreeze?.token,
          body.tokenUnfreeze?.account,
          'tokenUnfreeze',
        );
      case _TxKind.tokenGrantKyc:
        _validateTokenAccountOp(
          body.tokenGrantKyc?.token,
          body.tokenGrantKyc?.account,
          'tokenGrantKyc',
        );
      case _TxKind.tokenRevokeKyc:
        _validateTokenAccountOp(
          body.tokenRevokeKyc?.token,
          body.tokenRevokeKyc?.account,
          'tokenRevokeKyc',
        );
      case _TxKind.tokenPause:
        _require(body.tokenPause?.token != null, 'token');
      case _TxKind.tokenUnpause:
        _require(body.tokenUnpause?.token != null, 'token');
      case _TxKind.tokenFeeScheduleUpdate:
        _validateTokenFeeSchedule(body.tokenFeeScheduleUpdate!);
      case _TxKind.tokenUpdateNfts:
        _validateTokenUpdateNfts(body.tokenUpdateNfts!);
      case _TxKind.tokenReject:
        _validateTokenReject(body.tokenReject!);
      case _TxKind.tokenAirdrop:
        _validateTokenAirdrop(body.tokenAirdrop!);
      case _TxKind.tokenCancelAirdrop:
        _require(
          body.tokenCancelAirdrop?.pendingAirdrops.isNotEmpty == true,
          'pendingAirdrops',
        );
      case _TxKind.tokenClaimAirdrop:
        _require(
          body.tokenClaimAirdrop?.pendingAirdrops.isNotEmpty == true,
          'pendingAirdrops',
        );
      case _TxKind.scheduleCreate:
        _require(
          body.scheduleCreate?.scheduledTransactionBody != null,
          'scheduledTransactionBody',
        );
      case _TxKind.scheduleDelete:
        _require(body.scheduleDelete?.scheduleID != null, 'scheduleID');
      case _TxKind.scheduleSign:
        _require(body.scheduleSign?.scheduleID != null, 'scheduleID');
      case _TxKind.ethereum:
        _validateEthereum(body.ethereumTransaction!);
      case _TxKind.utilPrng:
        final r = body.utilPrng?.range;
        if (r != null && r <= 0) {
          _fail('utilPrng.range must be > 0 when set');
        }
    }
  }

  // ── Crypto transfer ──────────────────────────────────────────────────────

  static void _validateCryptoTransfer(HederaCryptoTransferTransactionBody t) {
    final hbar = t.transfers?.accountAmounts ?? const <HederaAccountAmount>[];
    final tokens = t.tokenTransfers;

    if (hbar.isEmpty && tokens.isEmpty) {
      _fail('cryptoTransfer must contain HBAR and/or token transfers');
    }

    if (hbar.isNotEmpty) {
      _validateHbarTransfers(hbar);
    }

    for (final list in tokens) {
      _validateTokenTransferList(list);
    }
  }

  /// Net HBAR must be zero (debits == credits).
  static void _validateHbarTransfers(List<HederaAccountAmount> amounts) {
    if (amounts.length < 2) {
      _fail(
        'HBAR transfer list must have at least two AccountAmounts '
        '(one debit and one credit)',
      );
    }

    BigInt sum = BigInt.zero;
    var hasDebit = false;
    var hasCredit = false;
    for (final a in amounts) {
      final amt = a.amount ?? BigInt.zero;
      if (amt == BigInt.zero) {
        _fail('HBAR AccountAmount.amount cannot be zero');
      }
      if (a.accountID == null) {
        _fail('HBAR AccountAmount.accountID is required');
      }
      if (amt.isNegative) hasDebit = true;
      if (amt > BigInt.zero) hasCredit = true;
      sum += amt;
    }
    if (!hasDebit || !hasCredit) {
      _fail('HBAR transfers must include both debits (-) and credits (+)');
    }
    if (sum != BigInt.zero) {
      _fail(
        'HBAR transfer list is unbalanced: sum of amounts is $sum '
        '(must be 0 so inputs equal outputs)',
      );
    }
  }

  static void _validateTokenTransferList(HederaTokenTransferList list) {
    if (list.token == null) {
      _fail('TokenTransferList.token is required');
    }

    final fungible = list.transfers;
    final nfts = list.nftTransfers;

    if (fungible.isEmpty && nfts.isEmpty) {
      _fail(
        'TokenTransferList for token ${list.token} must have '
        'fungible transfers and/or nftTransfers',
      );
    }

    if (fungible.isNotEmpty) {
      if (fungible.length < 2) {
        _fail(
          'Fungible token transfers for ${list.token} must have at least '
          'two AccountAmounts',
        );
      }
      BigInt sum = BigInt.zero;
      var hasDebit = false;
      var hasCredit = false;
      for (final a in fungible) {
        final amt = a.amount ?? BigInt.zero;
        if (amt == BigInt.zero) {
          _fail('Fungible token amount cannot be zero');
        }
        if (a.accountID == null) {
          _fail('Fungible token AccountAmount.accountID is required');
        }
        if (amt.isNegative) hasDebit = true;
        if (amt > BigInt.zero) hasCredit = true;
        sum += amt;
      }
      if (!hasDebit || !hasCredit) {
        _fail(
          'Fungible transfers for ${list.token} must include debits and credits',
        );
      }
      if (sum != BigInt.zero) {
        _fail(
          'Fungible transfers for ${list.token} are unbalanced: sum=$sum (must be 0)',
        );
      }
    }

    final seenSerials = <BigInt>{};
    for (final nft in nfts) {
      if (nft.senderAccountID == null || nft.receiverAccountID == null) {
        _fail('NFT transfer requires senderAccountID and receiverAccountID');
      }
      final serial = nft.serialNumber;
      if (serial == null || serial <= BigInt.zero) {
        _fail('NFT transfer serialNumber must be > 0');
      }
      if (serial != null && !seenSerials.add(serial)) {
        _fail(
          'Duplicate NFT serial $serial in token transfer list for ${list.token}',
        );
      }
      // Same account send+receive is invalid
      if (_sameAccount(nft.senderAccountID, nft.receiverAccountID)) {
        _fail(
          'NFT serial $serial sender and receiver must be different accounts',
        );
      }
    }
  }

  static bool _sameAccount(HederaAccountID? a, HederaAccountID? b) {
    if (a == null || b == null) return false;
    return a.shardNum == b.shardNum &&
        a.realmNum == b.realmNum &&
        a.accountNum == b.accountNum &&
        BytesUtils.bytesEqual(a.alias ?? const [], b.alias ?? const []);
  }

  // ── Crypto account ───────────────────────────────────────────────────────

  static void _validateCryptoCreate(HederaCryptoCreateTransactionBody b) {
    if (b.key == null) _fail('cryptoCreateAccount.key is required');
    final bal = b.initialBalance;
    if (bal != null && bal.isNegative) {
      _fail('cryptoCreateAccount.initialBalance cannot be negative');
    }
  }

  static void _validateCryptoUpdate(HederaCryptoUpdateTransactionBody b) {
    if (b.accountIDToUpdate == null) {
      _fail('cryptoUpdateAccount.accountIDToUpdate is required');
    }
  }

  static void _validateCryptoDelete(HederaCryptoDeleteTransactionBody b) {
    if (b.deleteAccountID == null) {
      _fail('cryptoDelete.deleteAccountID is required');
    }
    if (b.transferAccountID == null) {
      _fail('cryptoDelete.transferAccountID is required');
    }
    if (_sameAccount(b.deleteAccountID, b.transferAccountID)) {
      _fail('cryptoDelete: delete and transfer accounts must differ');
    }
  }

  static void _validateApproveAllowance(
    HederaCryptoApproveAllowanceTransactionBody b,
  ) {
    if (b.cryptoAllowances.isEmpty &&
        b.tokenAllowances.isEmpty &&
        b.nftAllowances.isEmpty) {
      _fail('cryptoApproveAllowance needs at least one allowance');
    }
  }

  static void _validateDeleteAllowance(
    HederaCryptoDeleteAllowanceTransactionBody b,
  ) {
    if (b.nftAllowances.isEmpty) {
      _fail('cryptoDeleteAllowance.nftAllowances cannot be empty');
    }
  }

  // ── Contract ─────────────────────────────────────────────────────────────

  static void _validateContractCall(HederaContractCallTransactionBody b) {
    if (b.contractID == null) _fail('contractCall.contractID is required');
    final gas = b.gas;
    if (gas == null || gas <= BigInt.zero) {
      _fail('contractCall.gas must be > 0');
    }
    final amount = b.amount;
    if (amount != null && amount.isNegative) {
      _fail('contractCall.amount cannot be negative');
    }
  }

  static void _validateContractCreate(HederaContractCreateTransactionBody b) {
    final hasFile = b.fileID != null;
    final hasInit = b.initcode != null && b.initcode!.isNotEmpty;
    if (!hasFile && !hasInit) {
      _fail('contractCreate requires fileID or initcode');
    }
    final gas = b.gas;
    if (gas == null || gas <= BigInt.zero) {
      _fail('contractCreate.gas must be > 0');
    }
  }

  static void _validateContractUpdate(HederaContractUpdateTransactionBody b) {
    if (b.contractID == null) _fail('contractUpdate.contractID is required');
  }

  static void _validateContractDelete(HederaContractDeleteTransactionBody b) {
    if (b.contractID == null) _fail('contractDelete.contractID is required');
    if (b.transferAccountID == null && b.transferContractID == null) {
      _fail('contractDelete requires transferAccountID or transferContractID');
    }
  }

  // ── File / system ────────────────────────────────────────────────────────

  static void _validateFileCreate(HederaFileCreateTransactionBody b) {
    if (b.contents == null || b.contents!.isEmpty) {
      _fail('fileCreate.contents cannot be empty');
    }
  }

  static void _validateFileAppend(HederaFileAppendTransactionBody b) {
    if (b.fileID == null) _fail('fileAppend.fileID is required');
    if (b.contents == null || b.contents!.isEmpty) {
      _fail('fileAppend.contents cannot be empty');
    }
  }

  static void _validateFileUpdate(HederaFileUpdateTransactionBody b) {
    if (b.fileID == null) _fail('fileUpdate.fileID is required');
  }

  static void _validateFileDelete(HederaFileDeleteTransactionBody b) {
    if (b.fileID == null) _fail('fileDelete.fileID is required');
  }

  static void _validateSystemDelete(HederaSystemDeleteTransactionBody b) {
    if (b.fileID == null && b.contractID == null) {
      _fail('systemDelete requires fileID or contractID');
    }
  }

  static void _validateSystemUndelete(HederaSystemUndeleteTransactionBody b) {
    if (b.fileID == null && b.contractID == null) {
      _fail('systemUndelete requires fileID or contractID');
    }
  }

  static void _validateConsensusSubmit(
    HederaConsensusSubmitMessageTransactionBody b,
  ) {
    if (b.topicID == null) _fail('consensusSubmitMessage.topicID is required');
    if (b.message == null || b.message!.isEmpty) {
      _fail('consensusSubmitMessage.message cannot be empty');
    }
  }

  // ── Token ────────────────────────────────────────────────────────────────

  static void _validateTokenCreate(HederaTokenCreateTransactionBody b) {
    if (b.name == null || b.name!.isEmpty) _fail('tokenCreate.name required');
    if (b.symbol == null || b.symbol!.isEmpty) {
      _fail('tokenCreate.symbol required');
    }
    if (b.treasury == null) _fail('tokenCreate.treasury required');
    final supply = b.initialSupply ?? BigInt.zero;
    if (supply.isNegative) {
      _fail('tokenCreate.initialBalance cannot be negative');
    }
    final max = b.maxSupply;
    if (max != null && max < supply) {
      _fail('tokenCreate.maxSupply must be >= initialSupply');
    }
  }

  static void _validateTokenMint(HederaTokenMintTransactionBody b) {
    if (b.token == null) _fail('tokenMint.token is required');
    final amount = b.amount;
    final meta = b.metadata;
    final hasAmount = amount != null && amount > BigInt.zero;
    final hasMeta = meta.isNotEmpty;
    if (!hasAmount && !hasMeta) {
      _fail('tokenMint requires amount (fungible) or metadata (NFT)');
    }
    if (hasAmount && hasMeta) {
      _fail('tokenMint cannot set both amount and metadata');
    }
  }

  static void _validateTokenBurn(HederaTokenBurnTransactionBody b) {
    if (b.token == null) _fail('tokenBurn.token is required');
    final amount = b.amount;
    final serials = b.serialNumbers;
    final hasAmount = amount != null && amount > BigInt.zero;
    final hasSerials = serials.isNotEmpty;
    if (!hasAmount && !hasSerials) {
      _fail('tokenBurn requires amount or serialNumbers');
    }
    if (hasAmount && hasSerials) {
      _fail('tokenBurn cannot set both amount and serialNumbers');
    }
  }

  static void _validateTokenWipe(HederaTokenWipeAccountTransactionBody b) {
    if (b.token == null) _fail('tokenWipe.token is required');
    if (b.account == null) _fail('tokenWipe.account is required');
    final amount = b.amount;
    final serials = b.serialNumbers;
    final hasAmount = amount != null && amount > BigInt.zero;
    final hasSerials = serials.isNotEmpty;
    if (!hasAmount && !hasSerials) {
      _fail('tokenWipe requires amount or serialNumbers');
    }
  }

  static void _validateTokenAssociate(HederaTokenAssociateTransactionBody b) {
    if (b.account == null) _fail('tokenAssociate.account is required');
    if (b.tokens.isEmpty) _fail('tokenAssociate.tokens cannot be empty');
  }

  static void _validateTokenDissociate(HederaTokenDissociateTransactionBody b) {
    if (b.account == null) _fail('tokenDissociate.account is required');
    if (b.tokens.isEmpty) _fail('tokenDissociate.tokens cannot be empty');
  }

  static void _validateTokenAccountOp(
    HederaTokenID? token,
    HederaAccountID? account,
    String name,
  ) {
    if (token == null) _fail('$name.token is required');
    if (account == null) _fail('$name.account is required');
  }

  static void _validateTokenFeeSchedule(
    HederaTokenFeeScheduleUpdateTransactionBody b,
  ) {
    if (b.tokenId == null) _fail('tokenFeeScheduleUpdate.tokenId is required');
  }

  static void _validateTokenUpdateNfts(HederaTokenUpdateNftsTransactionBody b) {
    if (b.token == null) _fail('tokenUpdateNfts.token is required');
    if (b.serialNumbers.isEmpty) {
      _fail('tokenUpdateNfts.serialNumbers cannot be empty');
    }
  }

  static void _validateTokenReject(HederaTokenRejectTransactionBody b) {
    if (b.owner == null) _fail('tokenReject.owner is required');
    if (b.rejections.isEmpty) {
      _fail('tokenReject.rejections cannot be empty');
    }
  }

  static void _validateTokenAirdrop(HederaTokenAirdropTransactionBody b) {
    if (b.tokenTransfers.isEmpty) {
      _fail('tokenAirdrop.tokenTransfers cannot be empty');
    }
    for (final list in b.tokenTransfers) {
      _validateTokenTransferList(list);
    }
  }

  static void _validateEthereum(HederaEthereumTransactionBody b) {
    if (b.ethereumData == null || b.ethereumData!.isEmpty) {
      _fail('ethereumTransaction.ethereumData cannot be empty');
    }
  }

  // ── helpers ──────────────────────────────────────────────────────────────

  static void _require(bool ok, String field) {
    if (!ok) _fail('$field is required');
  }

  static void _fail(String reason) {
    throw OnChainErrors.hederaTx('validateTransaction', reason: reason);
  }

  static _TxKind? _detectKind(HederaTransactionBody body) {
    if (body.cryptoTransfer != null) return _TxKind.cryptoTransfer;
    if (body.cryptoCreateAccount != null) return _TxKind.cryptoCreate;
    if (body.cryptoUpdateAccount != null) return _TxKind.cryptoUpdate;
    if (body.cryptoDelete != null) return _TxKind.cryptoDelete;
    if (body.cryptoApproveAllowance != null) {
      return _TxKind.cryptoApproveAllowance;
    }
    if (body.cryptoDeleteAllowance != null) {
      return _TxKind.cryptoDeleteAllowance;
    }
    if (body.contractCall != null) return _TxKind.contractCall;
    if (body.contractCreateInstance != null) return _TxKind.contractCreate;
    if (body.contractUpdateInstance != null) return _TxKind.contractUpdate;
    if (body.contractDeleteInstance != null) return _TxKind.contractDelete;
    if (body.fileCreate != null) return _TxKind.fileCreate;
    if (body.fileAppend != null) return _TxKind.fileAppend;
    if (body.fileUpdate != null) return _TxKind.fileUpdate;
    if (body.fileDelete != null) return _TxKind.fileDelete;
    if (body.systemDelete != null) return _TxKind.systemDelete;
    if (body.systemUndelete != null) return _TxKind.systemUndelete;
    if (body.freeze != null) return _TxKind.freeze;
    if (body.consensusCreateTopic != null) return _TxKind.consensusCreate;
    if (body.consensusUpdateTopic != null) return _TxKind.consensusUpdate;
    if (body.consensusDeleteTopic != null) return _TxKind.consensusDelete;
    if (body.consensusSubmitMessage != null) return _TxKind.consensusSubmit;
    if (body.tokenCreation != null) return _TxKind.tokenCreate;
    if (body.tokenUpdate != null) return _TxKind.tokenUpdate;
    if (body.tokenDeletion != null) return _TxKind.tokenDelete;
    if (body.tokenMint != null) return _TxKind.tokenMint;
    if (body.tokenBurn != null) return _TxKind.tokenBurn;
    if (body.tokenWipe != null) return _TxKind.tokenWipe;
    if (body.tokenAssociate != null) return _TxKind.tokenAssociate;
    if (body.tokenDissociate != null) return _TxKind.tokenDissociate;
    if (body.tokenFreeze != null) return _TxKind.tokenFreeze;
    if (body.tokenUnfreeze != null) return _TxKind.tokenUnfreeze;
    if (body.tokenGrantKyc != null) return _TxKind.tokenGrantKyc;
    if (body.tokenRevokeKyc != null) return _TxKind.tokenRevokeKyc;
    if (body.tokenPause != null) return _TxKind.tokenPause;
    if (body.tokenUnpause != null) return _TxKind.tokenUnpause;
    if (body.tokenFeeScheduleUpdate != null) {
      return _TxKind.tokenFeeScheduleUpdate;
    }
    if (body.tokenUpdateNfts != null) return _TxKind.tokenUpdateNfts;
    if (body.tokenReject != null) return _TxKind.tokenReject;
    if (body.tokenAirdrop != null) return _TxKind.tokenAirdrop;
    if (body.tokenCancelAirdrop != null) return _TxKind.tokenCancelAirdrop;
    if (body.tokenClaimAirdrop != null) return _TxKind.tokenClaimAirdrop;
    if (body.scheduleCreate != null) return _TxKind.scheduleCreate;
    if (body.scheduleDelete != null) return _TxKind.scheduleDelete;
    if (body.scheduleSign != null) return _TxKind.scheduleSign;
    if (body.ethereumTransaction != null) return _TxKind.ethereum;
    if (body.utilPrng != null) return _TxKind.utilPrng;
    return null;
  }
}

enum _TxKind {
  cryptoTransfer,
  cryptoCreate,
  cryptoUpdate,
  cryptoDelete,
  cryptoApproveAllowance,
  cryptoDeleteAllowance,
  contractCall,
  contractCreate,
  contractUpdate,
  contractDelete,
  fileCreate,
  fileAppend,
  fileUpdate,
  fileDelete,
  systemDelete,
  systemUndelete,
  freeze,
  consensusCreate,
  consensusUpdate,
  consensusDelete,
  consensusSubmit,
  tokenCreate,
  tokenUpdate,
  tokenDelete,
  tokenMint,
  tokenBurn,
  tokenWipe,
  tokenAssociate,
  tokenDissociate,
  tokenFreeze,
  tokenUnfreeze,
  tokenGrantKyc,
  tokenRevokeKyc,
  tokenPause,
  tokenUnpause,
  tokenFeeScheduleUpdate,
  tokenUpdateNfts,
  tokenReject,
  tokenAirdrop,
  tokenCancelAirdrop,
  tokenClaimAirdrop,
  scheduleCreate,
  scheduleDelete,
  scheduleSign,
  ethereum,
  utilPrng,
}
