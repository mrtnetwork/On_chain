import 'package:test/test.dart';
import 'package:on_chain/solana/solana.dart';

void main() {
  group('spl token layout', () {
    _amountToUiAmount();
    _approve();
    _approveChecked();
    _burn();
    _burnChecked();
    _createNativeMint();
    _freezeAccount();
    _initializeAccount();
    _initializeAccount2();
    _initializeAccount3();
    _initializeImmutableOwner();
    _initializeMint();
    _initializeMint2();
    _closeAuthority();
    _initializeMultisig();
    _initializeNonTransferableMint();
    _initializePermanentDelegate();
    _mintTo();
    _mintToChecked();
    _realloc();
    _setAuthority();
    _syncNative();
    _thawAccount();
    _transfer();
    _transferChecked();
    _uiAmountToAmount();
  });
}

void _amountToUiAmount() {
  test('amountToUiAmount', () {
    final layout = SPLTokenAmountToUiAmountLayout(amount: BigInt.from(250000));
    expect(layout.toHex(), '1790d0030000000000');
    final decode = SPLTokenAmountToUiAmountLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _approve() {
  test('approve', () {
    final layout = SPLTokenApproveLayout(amount: BigInt.from(350000));
    expect(layout.toHex(), '043057050000000000');
    final decode = SPLTokenApproveLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _approveChecked() {
  test('approveChecked', () {
    final layoyt =
        SPLTokenApproveCheckedLayout(amount: BigInt.from(350000), decimals: 8);
    expect(layoyt.toHex(), '0d305705000000000008');
    final decode = SPLTokenApproveCheckedLayout.fromBuffer(layoyt.toBytes());
    expect(layoyt.toBytes(), decode.toBytes());
  });
}

void _burn() {
  test('burn', () {
    final layoyt = SPLTokenBurnLayout(amount: BigInt.from(350000));
    expect(layoyt.toHex(), '083057050000000000');
    final decode = SPLTokenBurnLayout.fromBuffer(layoyt.toBytes());
    expect(layoyt.toBytes(), decode.toBytes());
  });
}

void _burnChecked() {
  test('burnchecked', () {
    final layoyt =
        SPLTokenBurnCheckedLayout(amount: BigInt.from(350000), decimals: 8);
    expect(layoyt.toHex(), '0f305705000000000008');
    final decode = SPLTokenBurnCheckedLayout.fromBuffer(layoyt.toBytes());
    expect(layoyt.toBytes(), decode.toBytes());
  });
}

void _createNativeMint() {
  test('createNativeMint', () {
    final layoyt = SPLTokenCreateNativeMintLayout();
    expect(layoyt.toHex(), '1f');
    final decode = SPLTokenCreateNativeMintLayout.fromBuffer(layoyt.toBytes());
    expect(layoyt.toBytes(), decode.toBytes());
  });
}

void _freezeAccount() {
  test('freezeAccount', () {
    final layoyt = SPLTokenFreezAccountLayout();
    expect(layoyt.toHex(), '0a');
    final decode = SPLTokenFreezAccountLayout.fromBuffer(layoyt.toBytes());
    expect(layoyt.toBytes(), decode.toBytes());
  });
}

void _initializeAccount() {
  test('initializeAccount', () {
    final layoyt = SPLTokenInitializeAccountLayout();
    expect(layoyt.toHex(), '01');
    final decode = SPLTokenInitializeAccountLayout.fromBuffer(layoyt.toBytes());
    expect(layoyt.toBytes(), decode.toBytes());
  });
}

void _initializeAccount2() {
  test('initializeAccount2', () {
    final account = SolAddress('6jwLNd4w4RfZsj5WCszKB4wKHmU2gX24JLq2DH42No5s');
    final layoyt = SPLTokenInitializeAccount2Layout(owner: account);
    expect(layoyt.toHex(),
        '10554a43a7b8e1a60dac1b800be310f94e55f8fb7415780b78177c3ede1aa0b7ca');
    final decode =
        SPLTokenInitializeAccount2Layout.fromBuffer(layoyt.toBytes());
    expect(layoyt.toBytes(), decode.toBytes());
  });
}

void _initializeAccount3() {
  test('initializeAccount3', () {
    final account = SolAddress('6jwLNd4w4RfZsj5WCszKB4wKHmU2gX24JLq2DH42No5s');
    final layoyt = SPLTokenInitializeAccount3Layout(owner: account);
    expect(layoyt.toHex(),
        '12554a43a7b8e1a60dac1b800be310f94e55f8fb7415780b78177c3ede1aa0b7ca');
    final decode =
        SPLTokenInitializeAccount3Layout.fromBuffer(layoyt.toBytes());
    expect(layoyt.toBytes(), decode.toBytes());
  });
}

/// SPLTokenInitializeImmutableOwnerLayout
void _initializeImmutableOwner() {
  test('initializeImmutableOwner', () {
    final layoyt = SPLTokenInitializeImmutableOwnerLayout();
    expect(layoyt.toHex(), '16');
    final decode =
        SPLTokenInitializeImmutableOwnerLayout.fromBuffer(layoyt.toBytes());
    expect(layoyt.toBytes(), decode.toBytes());
  });
}

///

void _initializeMint() {
  test('initializeMint', () {
    final account = SolAddress('57BYVwU1nZvkDkQZvqnNL71SE4jvegfGoEr6Eo6QgNyJ');
    final layoyt = SPLTokenInitializeMintLayout(
        decimals: 8, mintAuthority: account, freezeAuthority: null);
    expect(layoyt.toHex(),
        '00083d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d000000000000000000000000000000000000000000000000000000000000000000');
    final decode = SPLTokenInitializeMintLayout.fromBuffer(layoyt.toBytes());
    expect(layoyt.toBytes(), decode.toBytes());
  });
  test('initializeMint_1', () {
    final account = SolAddress('57BYVwU1nZvkDkQZvqnNL71SE4jvegfGoEr6Eo6QgNyJ');
    final freezeAuthority =
        SolAddress('6TawjkZGjtaDwvRRRakPKTAHDT5xvyVdoY4sr1FrZ9W4');
    final layoyt = SPLTokenInitializeMintLayout(
        decimals: 8, mintAuthority: account, freezeAuthority: freezeAuthority);
    expect(layoyt.toHex(),
        '00083d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d015119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af32936429205');
    final decode = SPLTokenInitializeMintLayout.fromBuffer(layoyt.toBytes());
    expect(layoyt.toBytes(), decode.toBytes());
  });
}

void _initializeMint2() {
  test('initializeMint2', () {
    final account = SolAddress('57BYVwU1nZvkDkQZvqnNL71SE4jvegfGoEr6Eo6QgNyJ');
    final layoyt = SPLTokenInitializeMint2Layout(
        decimals: 8, mintAuthority: account, freezeAuthority: null);
    expect(layoyt.toHex(),
        '14083d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d000000000000000000000000000000000000000000000000000000000000000000');
    final decode = SPLTokenInitializeMint2Layout.fromBuffer(layoyt.toBytes());
    expect(layoyt.toBytes(), decode.toBytes());
  });
  test('initializeMint2_1', () {
    final account = SolAddress('57BYVwU1nZvkDkQZvqnNL71SE4jvegfGoEr6Eo6QgNyJ');
    final freezeAuthority =
        SolAddress('6TawjkZGjtaDwvRRRakPKTAHDT5xvyVdoY4sr1FrZ9W4');
    final layoyt = SPLTokenInitializeMint2Layout(
        decimals: 8, mintAuthority: account, freezeAuthority: freezeAuthority);
    expect(layoyt.toHex(),
        '14083d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d015119ea7dac547c8a6eaa56be1d5ecb4c6e70d653a2f41fdf495af32936429205');
    final decode = SPLTokenInitializeMint2Layout.fromBuffer(layoyt.toBytes());
    expect(layoyt.toBytes(), decode.toBytes());
  });
}

/// SPLTokenInitializeMintCloseAuthorityLayout(closeAuthority: null)
void _closeAuthority() {
  test('closeAuthority', () {
    final layoyt = SPLTokenInitializeMintCloseAuthorityLayout();
    expect(layoyt.toHex(),
        '19000000000000000000000000000000000000000000000000000000000000000000');
    final decode =
        SPLTokenInitializeMintCloseAuthorityLayout.fromBuffer(layoyt.toBytes());
    expect(layoyt.toBytes(), decode.toBytes());
  });
  test('closeAuthority_1', () {
    final account = SolAddress('57BYVwU1nZvkDkQZvqnNL71SE4jvegfGoEr6Eo6QgNyJ');

    final layoyt =
        SPLTokenInitializeMintCloseAuthorityLayout(closeAuthority: account);
    expect(layoyt.toHex(),
        '19013d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d');
    final decode =
        SPLTokenInitializeMintCloseAuthorityLayout.fromBuffer(layoyt.toBytes());
    expect(layoyt.toBytes(), decode.toBytes());
  });
}

void _initializeMultisig() {
  test('initializeMultisig', () {
    final layoyt =
        SPLTokenInitializeMultisigLayout(numberOfRequiredSignatures: 2);
    expect(layoyt.toHex(), '0202');
    final decode =
        SPLTokenInitializeMultisigLayout.fromBuffer(layoyt.toBytes());
    expect(layoyt.toBytes(), decode.toBytes());
  });
}

void _initializeNonTransferableMint() {
  test('initializeNonTransferableMint', () {
    /// SPLTokenInitializeNonTransferableMintLayout
    final layoyt = SPLTokenInitializeNonTransferableMintLayout();
    expect(layoyt.toHex(), '20');
    final decode = SPLTokenInitializeNonTransferableMintLayout.fromBuffer(
        layoyt.toBytes());
    expect(layoyt.toBytes(), decode.toBytes());
  });
}

// SPLTokenInitializePermanentDelegateLayout(delegate: account3.address)
void _initializePermanentDelegate() {
  test('initializePermanentDelegate', () {
    final account = SolAddress('57BYVwU1nZvkDkQZvqnNL71SE4jvegfGoEr6Eo6QgNyJ');

    /// SPLTokenInitializeNonTransferableMintLayout
    final layoyt = SPLTokenInitializePermanentDelegateLayout(delegate: account);
    expect(layoyt.toHex(),
        '233d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d');
    final decode =
        SPLTokenInitializePermanentDelegateLayout.fromBuffer(layoyt.toBytes());
    expect(layoyt.toBytes(), decode.toBytes());
  });
  test('initializePermanentDelegate_1', () {
    final layoyt = SPLTokenInitializePermanentDelegateLayout(delegate: null);
    expect(layoyt.toHex(),
        '230000000000000000000000000000000000000000000000000000000000000000');
    final decode =
        SPLTokenInitializePermanentDelegateLayout.fromBuffer(layoyt.toBytes());
    expect(layoyt.toBytes(), decode.toBytes());
  });
}

void _mintTo() {
  test('mintTo', () {
    final layoyt = SPLTokenMintToLayout(amount: BigInt.from(25000));
    expect(layoyt.toHex(), '07a861000000000000');
    final decode = SPLTokenMintToLayout.fromBuffer(layoyt.toBytes());
    expect(layoyt.toBytes(), decode.toBytes());
  });
}

void _mintToChecked() {
  test('mintToChecked', () {
    final layoyt =
        SPLTokenMintToCheckedLayout(amount: BigInt.from(25000), decimals: 6);
    expect(layoyt.toHex(), '0ea86100000000000006');
    final decode = SPLTokenMintToCheckedLayout.fromBuffer(layoyt.toBytes());
    expect(layoyt.toBytes(), decode.toBytes());
  });
  test('mintToChecked_1', () {
    final layoyt =
        SPLTokenMintToCheckedLayout(amount: BigInt.from(25000), decimals: 0);
    expect(layoyt.toHex(), '0ea86100000000000000');
    final decode = SPLTokenMintToCheckedLayout.fromBuffer(layoyt.toBytes());
    expect(layoyt.toBytes(), decode.toBytes());
  });
}

void _realloc() {
  test('realloc', () {
    final layoyt = SPLTokenReallocateLayout(extensionTypes: [
      ExtensionType.confidentialTransferAccount,
      ExtensionType.cpiGuard,
      ExtensionType.immutableOwner
    ]);
    expect(layoyt.toHex(), '1d05000b000700');
    final decode = SPLTokenReallocateLayout.fromBuffer(layoyt.toBytes());
    expect(layoyt.toBytes(), decode.toBytes());
  });
  test('realloc_1', () {
    final layoyt = SPLTokenReallocateLayout(extensionTypes: []);
    expect(layoyt.toHex(), '1d');
    final decode = SPLTokenReallocateLayout.fromBuffer(layoyt.toBytes());
    expect(layoyt.toBytes(), decode.toBytes());
  });
}

void _setAuthority() {
  test('setAuthority', () {
    final layoyt = SPLTokenSetAuthorityLayout(
        authorityType: AuthorityType.freezeAccount, newAuthority: null);
    expect(layoyt.toHex(),
        '0601000000000000000000000000000000000000000000000000000000000000000000');
    final decode = SPLTokenSetAuthorityLayout.fromBuffer(layoyt.toBytes());
    expect(layoyt.toBytes(), decode.toBytes());
  });
  test('setAuthority_1', () {
    final account = SolAddress('57BYVwU1nZvkDkQZvqnNL71SE4jvegfGoEr6Eo6QgNyJ');
    final layoyt = SPLTokenSetAuthorityLayout(
        authorityType: AuthorityType.freezeAccount, newAuthority: account);
    expect(layoyt.toHex(),
        '0601013d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d');
    final decode = SPLTokenSetAuthorityLayout.fromBuffer(layoyt.toBytes());
    expect(layoyt.toBytes(), decode.toBytes());
  });
}

void _syncNative() {
  test('syncNative', () {
    final layoyt = SPLTokenSyncNativeLayout();
    expect(layoyt.toHex(), '11');
    final decode = SPLTokenSyncNativeLayout.fromBuffer(layoyt.toBytes());
    expect(layoyt.toBytes(), decode.toBytes());
  });
}

void _thawAccount() {
  test('thawAccount', () {
    final layoyt = SPLTokenThawAccountLayout();
    expect(layoyt.toHex(), '0b');
    final decode = SPLTokenThawAccountLayout.fromBuffer(layoyt.toBytes());
    expect(layoyt.toBytes(), decode.toBytes());
  });
}

void _transfer() {
  test('transfer', () {
    final layoyt = SPLTokenTransferLayout(amount: BigInt.from(35000));
    expect(layoyt.toHex(), '03b888000000000000');
    final decode = SPLTokenTransferLayout.fromBuffer(layoyt.toBytes());
    expect(layoyt.toBytes(), decode.toBytes());
  });
}

void _transferChecked() {
  test('transferChecked', () {
    final layoyt =
        SPLTokenTransferCheckedLayout(amount: BigInt.from(35000), decimals: 8);
    expect(layoyt.toHex(), '0cb88800000000000008');
    final decode = SPLTokenTransferCheckedLayout.fromBuffer(layoyt.toBytes());
    expect(layoyt.toBytes(), decode.toBytes());
  });
}

/// SPLTokenUiAmountToAmountLayout(amount: "MRT"),
void _uiAmountToAmount() {
  test('uiAmountToAmount', () {
    final layoyt = SPLTokenUiAmountToAmountLayout(amount: 'MRT');
    expect(layoyt.toHex(), '184d5254');
    final decode = SPLTokenUiAmountToAmountLayout.fromBuffer(layoyt.toBytes());
    expect(layoyt.toBytes(), decode.toBytes());
  });
}
