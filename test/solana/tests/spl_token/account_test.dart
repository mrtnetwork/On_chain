import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/solana.dart';
import 'package:test/test.dart';

void main() {
  _transferConfigAccount();
  group('spl token', () {
    _mintAccount();
    _multisigaccount();
    _transferConfigAccount();
  });
}

void _mintAccount() {
  test('mint', () {
    const data =
        '010000005e0c3791ca6e476689c9cc6373a2cd43154d6deb9f60517d923291c81e2196a200f0ab75a40d0000090100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000101006c005e0c3791ca6e476689c9cc6373a2cd43154d6deb9f60517d923291c81e2196a25e0c3791ca6e476689c9cc6373a2cd43154d6deb9f60517d923291c81e2196a200000000000000007102000000000000e80300000000000032007302000000000000005039278c040000d007';
    final account = SolanaMintAccount.fromBuffer(
        data: BytesUtils.fromHexString(data),
        address: const SolAddress.unchecked(
            'HZUdBDVne3K9LkHjnTBBPW1FviBEP8JhMNUkqXNNBxSB'));
    expect(account.mintAuthority?.address,
        '7L88T2bagkBNcSvazPPL3QzLeZff9C94f89iT375mMeH');
    expect(account.supply, BigInt.parse('15000000000000'));
    expect(account.decimals, 9);
  });
}

void _multisigaccount() {
  test('multisig account', () {
    const data =
        '050501e5ac2627b50a0ffd58e83b8dde7292a7beb8e2472a7c2619c15e9739b11d8739ed6743d479ac69d44430dd24cb5eea5412443aca29a6ec1a67133b6ec1d5fb53f316fbc6f1980d8653d1b6113a02cbb7fd08d6319ee3b774175e0f85ebe7ab5d138ba0288f356116b5ffc4185d22f1f16cdb7c5496e51496648cf6baea5a4654e559e9275ed2de687d841a1255299ddec5fb69bf4af23a4a66ad2d8e8e69b165000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000';
    final account = SolanaMultiSigAccount.fromBuffer(
        data: BytesUtils.fromHexString(data),
        address: const SolAddress.unchecked(
            '24sMxSzbsSHmRiheSk9v3F7Wfqc4jKxKetfyJL7QvfKP'));
    expect(account.numberOfPossibleSigners, 5);
    expect(account.numberOfSigners, 5);
    expect(account.isInitialized, true);
    const List<String> signers = [
      'GTYcWh15ib8VnmWpqiYiv4gUmrdPmVV2BtipYNci2H3n',
      'GyixExQipFFwbLtJeKRDszPNVM43CCXrHspfFdXhdyCN',
      'HMvQ3TqHgYjWXexL2Fn2uAV2ik7m4yRjkKRjaByeCqGp',
      '2KJESzBSue2QRDvpYBm97UJdTPbuSsjYfLkKUwCG4vMH',
      'GSHt4PLKrPwxMbobBnWir2EgYKeH3GX7U5yBFwTWkCep'
    ];
    for (int i = 0; i < account.signers.length; i++) {
      expect(account.signers.elementAt(i).address, signers.elementAt(i));
    }
    expect(account.toHex(), data);
  });
}

void _transferConfigAccount() {
  test('transfer confing ', () {
    const data =
        '5e0c3791ca6e476689c9cc6373a2cd43154d6deb9f60517d923291c81e2196a25e0c3791ca6e476689c9cc6373a2cd43154d6deb9f60517d923291c81e2196a200000000000000007102000000000000e80300000000000032007302000000000000005039278c040000d007';
    final account =
        TransferFeeConfig.fromBuffer(BytesUtils.fromHexString(data));
    expect(account.transferFeeConfigAuthority.address,
        '7L88T2bagkBNcSvazPPL3QzLeZff9C94f89iT375mMeH');
    expect(account.withdrawWithheldAuthority.address,
        '7L88T2bagkBNcSvazPPL3QzLeZff9C94f89iT375mMeH');
    expect(account.withheldAmount, BigInt.zero);
    expect(account.olderTransferFee.epoch, BigInt.from(625));
    expect(account.newerTransferFee.epoch, BigInt.from(627));
    expect(account.olderTransferFee.maximumFee, BigInt.from(1000));
    expect(account.newerTransferFee.maximumFee, BigInt.from(5000000000000));
  });
}
