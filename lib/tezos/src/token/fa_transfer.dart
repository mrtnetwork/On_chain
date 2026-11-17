import 'package:on_chain/tezos/src/address/address.dart';
import 'package:on_chain/tezos/src/micheline/micheline.dart';
import 'package:on_chain/tezos/src/operations/entry_point/entry_point.dart';

/// FA token standards for transfer-argument builders.
enum FaTokenStandard {
  /// TZIP-7 fungible token.
  fa12,

  /// TZIP-12 multi-asset token.
  fa2,
}

abstract final class TezosFaTransferUtils {
  /// Builds the `transfer` entrypoint argument for FA1.2 tokens:
  /// `Pair (from : address) (Pair (to : address) (value : nat))` (TZIP-7).
  static MichelineExpr buildFa12TransferArg({
    required TezosAddress from,
    required TezosAddress to,
    required BigInt value,
  }) {
    return MichelineUtils.pair(
      MichelineUtils.address(from),
      MichelineUtils.pair(
        MichelineUtils.address(to),
        MichelineUtils.nat(value),
      ),
    );
  }

  /// Builds one FA2 transfer item:
  /// `Pair (from_ : address) (list (Pair (to_ : address) (Pair (token_id : nat) (amount : nat))))`.
  static MichelineExpr buildFa2TransferItem({
    required TezosAddress from,
    required TezosAddress to,
    required BigInt tokenId,
    required BigInt amount,
  }) {
    return MichelineUtils.pair(
      MichelineUtils.address(from),
      MichelineUtils.seq([
        MichelineUtils.pair(
          MichelineUtils.address(to),
          MichelineUtils.pair(
            MichelineUtils.nat(tokenId),
            MichelineUtils.nat(amount),
          ),
        ),
      ]),
    );
  }

  /// Builds the full FA2 `transfer` argument (a list with a single item).
  /// Supports one recipient; build a longer list manually for batch transfers.
  static MichelineExpr buildFa2TransferArg({
    required TezosAddress from,
    required TezosAddress to,
    required BigInt tokenId,
    required BigInt amount,
  }) {
    return MichelineUtils.seq([
      buildFa2TransferItem(
        from: from,
        to: to,
        tokenId: tokenId,
        amount: amount,
      ),
    ]);
  }

  /// Builds [TezosContractParameters] for an FA token transfer.
  /// [tokenId] is required for [FaTokenStandard.fa2]; null defaults to token 0.
  static TezosContractParameters buildFaTransferParameters({
    required FaTokenStandard standard,
    required TezosAddress from,
    required TezosAddress to,
    required BigInt value,
    BigInt? tokenId,
  }) {
    final MichelineExpr arg = switch (standard) {
      FaTokenStandard.fa12 => buildFa12TransferArg(
        from: from,
        to: to,
        value: value,
      ),
      FaTokenStandard.fa2 => buildFa2TransferArg(
        from: from,
        to: to,
        tokenId: tokenId ?? BigInt.zero,
        amount: value,
      ),
    };
    return TezosContractParameters(
      entrypoint: TezosEntrypointNamed('transfer'),
      value: arg,
    );
  }
}
