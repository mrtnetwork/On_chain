import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/solana.dart';
import 'package:test/test.dart';

import '../../../utils.dart';

const _payer = SolAddress.unchecked(
  '9eaiUBgyT7EY1go2qrCmdRZMisYkGdtrrem3TgP9WSDb',
);
const _owner = SolAddress.unchecked(
  '527pWSWfeQGLM7SoyVXjCRkrSZBtDkH6ShEBJB3nUDkA',
);
const _mint = SolAddress.unchecked(
  'So11111111111111111111111111111111111111112',
);
const _asset = SolAddress.unchecked(
  'HcEjuQ7Eate3eyNBaZV2cwATcdAH8F7VGygVqkkoqUjf',
);

void solanaNewStandardsTest() {
  group('Solana/New Standards', () {
    _secp256r1();
    _splTokenMissing();
    _confidentialTransfer();
    _bubblegumCompress();
    _tokenMetadataFixes();
    _candyMachineMintV2();
    _mplCore();
    _coreCandyMachine();
    _tokenAuthRules();
    _newRpcs();
  });
}

void main() {
  OnChainUtilsTestApi.runTest(solanaNewStandardsTest, "Layout");
}

void _secp256r1() {
  test('secp256r1 layout round trip', () {
    final message = StringUtils.encode('hello solana');
    final layout = Secp256r1Layout.fromParts(
      publicKey: List<int>.filled(33, 7),
      message: message,
      signature: List<int>.filled(64, 9),
    );
    // Header: numSignatures=1, padding=0; offsets struct is 12 bytes.
    expect(layout.toBytes().sublist(0, 2), [1, 0]);
    expect(layout.signatureOffset, 14);
    expect(layout.publicKeyOffset, 78);
    expect(layout.messageDataOffset, 111);
    final decode = Secp256r1Layout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
    expect(decode.publicKey, List<int>.filled(33, 7));
    expect(decode.message, message);
    final ix = Secp256r1Program(layout: layout);
    expect(ix.programId, Secp256r1ProgramConst.programId);
    final back = Secp256r1Program.fromBytes(
      keys: [],
      instructionBytes: ix.data,
    );
    expect(back.data, ix.data);
  });
  test('secp256r1 rejects bad lengths', () {
    expect(
      () => Secp256r1Layout.fromParts(
        publicKey: List<int>.filled(32, 1),
        message: const [1],
        signature: List<int>.filled(64, 1),
      ),
      throwsA(isA<BuError>()),
    );
    expect(
      () => Secp256r1Layout.fromParts(
        publicKey: List<int>.filled(33, 1),
        message: const [1],
        signature: List<int>.filled(65, 1),
      ),
      throwsA(isA<BuError>()),
    );
  });
}

void _splTokenMissing() {
  test('initializeMultisig2', () {
    final layout = SPLTokenInitializeMultisig2Layout(
      numberOfRequiredSignatures: 2,
    );
    expect(layout.toHex(), '1302');
    final decode = SPLTokenProgramLayout.fromBytes(layout.toBytes());
    expect(decode, isA<SPLTokenInitializeMultisig2Layout>());
    expect(decode.toBytes(), layout.toBytes());
    final ix = SPLTokenProgram.initializeMultisig2(
      layout: layout,
      account: _owner,
      signers: [_payer, _mint],
    );
    // No rent sysvar: account + signers only.
    expect(ix.keys.length, 3);
  });
  test('getAccountDataSize', () {
    const layout = SPLTokenGetAccountDataSizeLayout();
    expect(layout.toHex(), '15');
    final decode = SPLTokenProgramLayout.fromBytes(layout.toBytes());
    expect(decode, isA<SPLTokenGetAccountDataSizeLayout>());
    expect(decode.toBytes(), layout.toBytes());
  });
  test('defaultAccountState + memoTransfer decode', () {
    final init = SPLToken2022InitializeDefaultAccountStateLayout(
      accountState: AccountState.initialized,
    );
    final initDecode = SPLTokenProgramLayout.fromBytes(init.toBytes());
    expect(initDecode, isA<SPLToken2022InitializeDefaultAccountStateLayout>());
    final update = SPLToken2022UpdateDefaultAccountStateLayout(
      accountState: AccountState.frozen,
    );
    expect(
      SPLTokenProgramLayout.fromBytes(update.toBytes()),
      isA<SPLToken2022UpdateDefaultAccountStateLayout>(),
    );
    final memo = SPLToken2022ToggleMemoTransferLayout(
      memoTransfer: MemoTransferInstruction.enable,
    );
    expect(
      SPLTokenProgramLayout.fromBytes(memo.toBytes()),
      isA<SPLToken2022ToggleMemoTransferLayout>(),
    );
  });
  test('group/member/metadata pointer lookups', () {
    expect(
      SPLTokenProgramInstruction.getInstruction(39),
      SPLTokenProgramInstruction.metadataPointerExtension,
    );
    expect(
      SPLTokenProgramInstruction.getInstruction(40),
      SPLTokenProgramInstruction.groupPointerExtension,
    );
    expect(
      SPLTokenProgramInstruction.getInstruction(41),
      SPLTokenProgramInstruction.groupMemberPointerExtension,
    );
  });
}

List<int> _elGamalPubkey(int fill) => List<int>.filled(32, fill);
List<int> _elGamalCipher(int fill) => List<int>.filled(64, fill);

void _confidentialTransfer() {
  test('confidential layouts round trip + dispatch', () {
    final layouts = <SPLTokenProgramLayout>[
      SPLToken2022ConfidentialInitializeMintLayout(
        authority: _payer,
        autoApproveNewAccounts: true,
        auditorElGamalPubkey: _elGamalPubkey(1),
      ),
      SPLToken2022ConfidentialUpdateMintLayout(
        autoApproveNewAccounts: false,
        auditorElGamalPubkey: null,
      ),
      SPLToken2022ConfidentialConfigureAccountLayout(
        decryptableZeroBalance: List<int>.filled(36, 2),
        maximumPendingBalanceCreditCounter: BigInt.from(42),
        proofInstructionOffset: -1,
      ),
      const SPLToken2022ConfidentialApproveAccountLayout(),
      const SPLToken2022ConfidentialEmptyAccountLayout(
        proofInstructionOffset: 0,
      ),
      SPLToken2022ConfidentialDepositLayout(
        amount: BigInt.from(1000),
        decimals: 6,
      ),
      SPLToken2022ConfidentialWithdrawLayout(
        amount: BigInt.from(500),
        decimals: 6,
        newDecryptableAvailableBalance: List<int>.filled(36, 3),
        equalityProofInstructionOffset: 1,
        rangeProofInstructionOffset: 2,
      ),
      SPLToken2022ConfidentialTransferLayout(
        newSourceDecryptableAvailableBalance: List<int>.filled(36, 4),
        transferAmountAuditorCiphertextLo: _elGamalCipher(5),
        transferAmountAuditorCiphertextHi: _elGamalCipher(6),
        equalityProofInstructionOffset: -2,
        ciphertextValidityProofInstructionOffset: 1,
        rangeProofInstructionOffset: 2,
      ),
      SPLToken2022ConfidentialApplyPendingBalanceLayout(
        expectedPendingBalanceCreditCounter: BigInt.from(7),
        newDecryptableAvailableBalance: List<int>.filled(36, 8),
      ),
      const SPLToken2022ConfidentialToggleCreditsLayout(
        toggle: ConfidentialTransferInstruction.enableConfidentialCredits,
      ),
      const SPLToken2022ConfidentialToggleCreditsLayout(
        toggle: ConfidentialTransferInstruction.disableNonConfidentialCredits,
      ),
      SPLToken2022ConfidentialTransferWithFeeLayout(
        newSourceDecryptableAvailableBalance: List<int>.filled(36, 9),
        transferAmountAuditorCiphertextLo: _elGamalCipher(10),
        transferAmountAuditorCiphertextHi: _elGamalCipher(11),
        equalityProofInstructionOffset: 1,
        transferAmountCiphertextValidityProofInstructionOffset: 2,
        feeSigmaProofInstructionOffset: -1,
        feeCiphertextValidityProofInstructionOffset: 3,
        rangeProofInstructionOffset: 4,
      ),
      const SPLToken2022ConfidentialConfigureAccountWithRegistryLayout(),
    ];
    for (final layout in layouts) {
      final decode = SPLTokenProgramLayout.fromBytes(layout.toBytes());
      expect(decode.runtimeType, layout.runtimeType);
      expect(decode.toBytes(), layout.toBytes());
    }
    // Wire prefixes: outer 27 + extension byte.
    expect(
      SPLToken2022ConfidentialDepositLayout(
        amount: BigInt.one,
        decimals: 9,
      ).toBytes().sublist(0, 2),
      [27, 5],
    );
    expect(
      SPLTokenProgramInstruction.getInstruction(27),
      SPLTokenProgramInstruction.confidentialTransferExtension,
    );
  });
  test('confidential factories build', () {
    final ix = SPLToken2022ExtensionsProgram.confidentialDeposit(
      token: _owner,
      mint: _mint,
      authority: _owner,
      layout: SPLToken2022ConfidentialDepositLayout(
        amount: BigInt.from(10),
        decimals: 6,
      ),
    );
    expect(ix.programId, SPLTokenProgramConst.token2022ProgramId);
    expect(ix.data.sublist(0, 2), [27, 5]);
    final toggle = SPLToken2022ExtensionsProgram.confidentialToggleCredits(
      token: _owner,
      owner: _payer,
      layout: const SPLToken2022ConfidentialToggleCreditsLayout(
        toggle: ConfidentialTransferInstruction.disableConfidentialCredits,
      ),
    );
    expect(toggle.data.sublist(0, 2), [27, 10]);
  });
}

void _bubblegumCompress() {
  test('bubblegum compress decodes', () {
    expect(
      MetaplexBubblegumProgramInstruction.getInstruction(
        MetaplexBubblegumProgramInstruction.compress.instruction,
      ),
      MetaplexBubblegumProgramInstruction.compress,
    );
    const layout = MetaplexBubblegumCompressLayout();
    final decode = MetaplexBubblegumProgramLayout.fromBytes(layout.toBytes());
    expect(decode, isA<MetaplexBubblegumCompressLayout>());
  });
}

void _tokenMetadataFixes() {
  test('printV2 factory + decode', () {
    final ix = MetaplexTokenMetaDataProgram.printV2(
      editionMetadata: _asset,
      edition: _asset,
      editionMint: _mint,
      editionTokenAccountOwner: _owner,
      editionTokenAccount: _owner,
      editionMintAuthority: _payer,
      masterEdition: _asset,
      editionMarkerPda: _asset,
      payer: _payer,
      masterTokenAccountOwner: _owner,
      masterTokenAccount: _owner,
      masterMetadata: _asset,
      updateAuthority: _payer,
      splTokenProgram: SPLTokenProgramConst.tokenProgramId,
      splAtaProgram:
          AssociatedTokenAccountProgramConst.associatedTokenProgramId,
      sysvarInstructions: SystemProgramConst.sysvarInstructionsPubkey,
      layout: MetaplexTokenMetaDataPrintV2Layout(editionNumber: BigInt.from(3)),
    );
    expect(ix.data.sublist(0, 2), [55, 1]);
    final decode = MetaplexTokenMetaDataProgramLayout.fromBytes(ix.data);
    expect(decode, isA<MetaplexTokenMetaDataPrintV2Layout>());
    expect(
      (decode as MetaplexTokenMetaDataPrintV2Layout).editionNumber,
      BigInt.from(3),
    );
  });
  test('revoke variants decode', () {
    final revoke = MetaplexTokenMetaDataProgram.revoke(
      delegate: _owner,
      metadata: _asset,
      authority: _payer,
      payer: _payer,
      mint: _mint,
      sysvarInstructions: SystemProgramConst.sysvarInstructionsPubkey,
      layout: MetaplexTokenMetaDataRevokeLayout(revoke: Revoke.collectionV1),
    );
    expect(
      MetaplexTokenMetaDataProgramLayout.fromBytes(revoke.data),
      isA<MetaplexTokenMetaDataRevokeLayout>(),
    );
    final revokeCollection =
        MetaplexTokenMetaDataProgram.revokeCollectionAuthority(
          collectionAuthorityRecord: _asset,
          delegateAuthority: _owner,
          revokeAuthority: _payer,
          metadata: _asset,
          mint: _mint,
        );
    expect(
      MetaplexTokenMetaDataProgramLayout.fromBytes(revokeCollection.data),
      isA<MetaplexTokenMetaDataRevokeCollectionAuthorityLayout>(),
    );
    expect(
      MetaplexTokenMetaDataProgramInstruction.getInstruction(0) != null,
      true,
    );
  });
}

void _candyMachineMintV2() {
  test('candy mintV2 alias decodes by payload', () {
    // Machine mintV2 carries args (len > 8).
    final layout = MetaplexCandyMachineMintV2Layout(
      mintArgs: const [1, 2, 3],
      group: 'default',
    );
    final decode = MetaplexCandyMachineProgramLayout.fromBytes(
      layout.toBytes(),
    );
    expect(decode, isA<MetaplexCandyMachineMintV2Layout>());
    expect(decode.toBytes(), layout.toBytes());
    // Guard mintFromCandyMachineV2 is the bare 8-byte discriminant.
    const guardEmpty = [120, 121, 23, 146, 173, 110, 199, 205];
    final guardDecode = MetaplexCandyMachineProgramLayout.fromBytes(guardEmpty);
    expect(
      guardDecode,
      isA<MetaplexCandyMachineMintFromCandyMachineV2Layout>(),
    );
    // Same for the mint pair.
    const guardMintEmpty = [51, 57, 225, 47, 182, 146, 137, 166];
    expect(
      MetaplexCandyMachineProgramLayout.fromBytes(guardMintEmpty),
      isA<MetaplexCandyMachineMintFromCandyMachineLayout>(),
    );
  });
  test('candy withdraw factories + decode', () {
    final machine = MetaplexCandyMachineCoreProgram.withdrawCandyMachine(
      candyMachine: _asset,
      authority: _payer,
    );
    expect(
      MetaplexCandyMachineProgramLayout.fromBytes(machine.data),
      isA<MetaplexCandyMachineWithdrawCandyMachineLayout>(),
    );
    // Guard withdraw shares the exact bytes: default decode resolves to the
    // machine withdraw layout (documented alias policy); the guard layout
    // round-trips through its own fromBuffer.
    final guard = MetaplexCandyMachineCoreProgram.withdrawCandyGuard(
      candyGuard: _asset,
      authority: _payer,
    );
    expect(guard.data, machine.data);
    expect(
      MetaplexCandyMachineProgramLayout.fromBytes(guard.data),
      isA<MetaplexCandyMachineWithdrawCandyMachineLayout>(),
    );
    expect(
      MetaplexCandyMachineWithdrawCandyGuardLayout.fromBuffer(
        guard.data,
      ).toBytes(),
      guard.data,
    );
  });
}

void _mplCore() {
  test('mpl core discriminants 0-41', () {
    expect(MplCoreProgramInstruction.values.length, 42);
    for (var i = 0; i < 42; i++) {
      expect(
        MplCoreProgramInstruction.getInstruction(i)?.instruction,
        i,
        reason: 'discriminant $i',
      );
    }
  });
  test('mpl core typed layouts round trip', () {
    final create = MplCoreCreateV1Layout(
      dataState: MplCoreDataState.accountState,
      name: 'Core Asset',
      uri: 'https://example.com/a.json',
    );
    // Default: no plugins (None).
    expect(create.toBytes().last, 0);
    final createBack = MplCoreCreateV1Layout.fromBuffer(create.toBytes());
    expect(createBack.name, 'Core Asset');
    expect(createBack.dataState, MplCoreDataState.accountState);

    final update = MplCoreUpdateLayout(
      instruction: MplCoreProgramInstruction.updateV1,
      newName: 'Renamed',
      newUpdateAuthority: MplCoreUpdateAuthority.collection(_asset),
    );
    final updateBack = MplCoreProgramLayout.fromBytes(update.toBytes());
    expect(updateBack, isA<MplCoreUpdateLayout>());
    expect(updateBack.toBytes(), update.toBytes());

    final approve = MplCoreApprovePluginAuthorityLayout(
      instruction: MplCoreProgramInstruction.approvePluginAuthorityV1,
      pluginType: MplCorePluginType.royalties,
      newAuthority: MplCoreAuthority.address(_payer),
    );
    expect(
      MplCoreProgramLayout.fromBytes(approve.toBytes()).toBytes(),
      approve.toBytes(),
    );

    final transfer = MplCoreCompressionProofLayout(
      instruction: MplCoreProgramInstruction.transferV1,
    );
    expect(transfer.toBytes().last, 0);
    expect(
      MplCoreProgramLayout.fromBytes(transfer.toBytes()).toBytes(),
      transfer.toBytes(),
    );

    // All-None update encodes three 0x00 option tags.
    const emptyUpdate = MplCoreUpdateLayout(
      instruction: MplCoreProgramInstruction.updateV1,
    );
    expect(emptyUpdate.toBytes(), [15, 0, 0, 0]);
    expect(
      MplCoreProgramLayout.fromBytes(emptyUpdate.toBytes()).toBytes(),
      emptyUpdate.toBytes(),
    );

    final groups = MplCorePubkeyVecLayout(
      instruction: MplCoreProgramInstruction.removeAssetsFromGroupV1,
      pubkeys: [_asset, _mint],
    );
    final groupsBack = MplCoreProgramLayout.fromBytes(groups.toBytes());
    expect(groupsBack, isA<MplCorePubkeyVecLayout>());
    expect((groupsBack as MplCorePubkeyVecLayout).pubkeys, [_asset, _mint]);

    final execute = MplCoreExecuteV1Layout(instructionData: const [9, 9, 9]);
    expect(
      MplCoreProgramLayout.fromBytes(execute.toBytes()).toBytes(),
      execute.toBytes(),
    );

    final info = MplCoreUpdateCollectionInfoV1Layout(
      updateType: MplCoreUpdateType.mint,
      amount: 2,
    );
    expect(
      MplCoreProgramLayout.fromBytes(info.toBytes()).toBytes(),
      info.toBytes(),
    );

    const empty = MplCoreEmptyLayout(
      instruction: MplCoreProgramInstruction.collect,
    );
    expect(
      MplCoreProgramLayout.fromBytes(empty.toBytes()).toBytes(),
      empty.toBytes(),
    );
  });
  test('mpl core factories + program decode', () {
    final createIx = MplCoreProgram.createV1(
      asset: _asset,
      payer: _payer,
      layout: MplCoreCreateV1Layout(
        dataState: MplCoreDataState.accountState,
        name: 'n',
        uri: 'u',
      ),
    );
    expect(createIx.programId, MplCoreProgramConst.programId);
    expect(createIx.keys.length, 8);
    final back = MplCoreProgram.fromBytes(
      keys: createIx.keys,
      instructionBytes: createIx.data,
    );
    expect(back.data, createIx.data);

    final transferIx = MplCoreProgram.transferV1(
      asset: _asset,
      newOwner: _owner,
      payer: _payer,
    );
    expect(
      MplCoreProgramLayout.fromBytes(transferIx.data),
      isA<MplCoreCompressionProofLayout>(),
    );

    final groupIx = MplCoreProgram.createGroupV1(
      group: _asset,
      payer: _payer,
      layout: MplCoreCreateGroupV1Layout(name: 'g', uri: 'u'),
    );
    expect(groupIx.keys.first.isWritable, true);

    final executeIx = MplCoreProgram.executeV1(
      asset: _asset,
      payer: _payer,
      programId: SystemProgramConst.programId,
      layout: MplCoreExecuteV1Layout(instructionData: const [0]),
      remainingAccounts: [_owner],
    );
    expect(executeIx.keys.length, 8);
  });
}

void _coreCandyMachine() {
  test('core candy machine dispatch', () {
    final add = CoreCandyMachineAddConfigLinesLayout(
      index: 0,
      configLines: const [CoreCandyMachineConfigLine(name: 'a', uri: 'u')],
    );
    final decode = CoreCandyMachineProgramLayoutDispatch.machineFromBytes(
      add.toBytes(),
    );
    expect(decode, isA<CoreCandyMachineAddConfigLinesLayout>());
    expect(decode.toBytes(), add.toBytes());

    final setAuth = CoreCandyMachineSetAuthorityLayout(
      programInstruction: CoreCandyMachineProgramInstruction.setAuthority,
      newAuthority: _payer,
    );
    expect(
      CoreCandyMachineProgramLayoutDispatch.machineFromBytes(setAuth.toBytes()),
      isA<CoreCandyMachineSetAuthorityLayout>(),
    );

    final mintIx = CoreCandyMachineProgram.mintAsset(
      candyMachine: _asset,
      authorityPda: _asset,
      mintAuthority: _payer,
      payer: _payer,
      assetOwner: _owner,
      asset: _asset,
      collection: _mint,
      args: const [1, 2, 3],
    );
    expect(mintIx.keys.length, 11);
    expect(
      CoreCandyMachineProgramLayoutDispatch.machineFromBytes(mintIx.data),
      isA<CoreCandyMachineRawArgsLayout>(),
    );
  });
  test('core candy guard dispatch differs by program', () {
    final mint = CoreCandyGuardMintV1Layout(
      mintArgs: const [7, 7],
      label: 'og',
    );
    final guardBack = CoreCandyMachineProgramLayoutDispatch.guardFromBytes(
      mint.toBytes(),
    );
    expect(guardBack, isA<CoreCandyGuardMintV1Layout>());
    expect(guardBack.toBytes(), mint.toBytes());

    // Same discriminant family, other program: guard update (raw) vs
    // machine update (raw) share bytes but dispatch by programId.
    final guardUpdate = CoreCandyGuardProgram.update(
      candyGuard: _asset,
      authority: _payer,
      payer: _payer,
      data: const [5, 5],
    );
    final machineUpdate = CoreCandyMachineProgram.update(
      candyMachine: _asset,
      authority: _payer,
      data: const [5, 5],
    );
    expect(guardUpdate.data, machineUpdate.data);
    expect(
      CoreCandyMachineProgramLayoutDispatch.fromBytes(
        data: guardUpdate.data,
        programId: CoreCandyMachineProgramConst.candyGuardProgramId,
      ),
      isA<CoreCandyMachineRawArgsLayout>(),
    );
    expect(
      CoreCandyMachineProgramLayoutDispatch.fromBytes(
        data: machineUpdate.data,
        programId: CoreCandyMachineProgramConst.candyMachineProgramId,
      ),
      isA<CoreCandyMachineRawArgsLayout>(),
    );

    final wrap = CoreCandyGuardProgram.wrap(
      candyGuard: _asset,
      authority: _payer,
      candyMachine: _mint,
      candyMachineProgram: CoreCandyMachineProgramConst.candyMachineProgramId,
      candyMachineAuthority: _payer,
    );
    expect(
      CoreCandyMachineProgramLayoutDispatch.guardFromBytes(wrap.data),
      isA<CoreCandyMachineEmptyLayout>(),
    );
  });
}

void _tokenAuthRules() {
  test('token auth rules round trip', () {
    final create = TokenAuthRulesCreateOrUpdateLayout(
      serializedRuleSet: const [1, 2, 3],
    );
    final createBack = TokenAuthRulesProgramLayoutDispatch.fromBytes(
      create.toBytes(),
    );
    expect(createBack, isA<TokenAuthRulesCreateOrUpdateLayout>());
    expect(createBack.toBytes(), create.toBytes());

    final write = TokenAuthRulesWriteToBufferLayout(
      serializedRuleSet: const [4, 5],
      overwrite: true,
    );
    expect(
      TokenAuthRulesProgramLayoutDispatch.fromBytes(write.toBytes()).toBytes(),
      write.toBytes(),
    );

    const puff = TokenAuthRulesPuffRuleSetLayout(ruleSetName: 'rules');
    expect(
      TokenAuthRulesProgramLayoutDispatch.fromBytes(puff.toBytes()).toBytes(),
      puff.toBytes(),
    );

    final validate = TokenAuthRulesValidateLayout(
      validateBody: const [9, 9, 9],
    );
    expect(validate.toBytes().sublist(0, 2), [1, 0]);
    expect(
      TokenAuthRulesProgramLayoutDispatch.fromBytes(
        validate.toBytes(),
      ).toBytes(),
      validate.toBytes(),
    );

    final ix = TokenAuthRulesProgram.createOrUpdate(
      payer: _payer,
      ruleSetPda: _asset,
      serializedRuleSet: const [1],
    );
    expect(ix.programId, TokenAuthRulesProgramConst.programId);
    expect(ix.keys.length, 3);
    final withBuffer = TokenAuthRulesProgram.createOrUpdate(
      payer: _payer,
      ruleSetPda: _asset,
      serializedRuleSet: const [1],
      bufferPda: _mint,
    );
    expect(withBuffer.keys.length, 4);
  });
}

void _newRpcs() {
  test('mpl core rpc requests build', () {
    const req = SolanaRPCGetMplCoreAssetAccount(account: _asset);
    expect(req.method, 'getAccountInfo');
    expect(req.toJson().first, _asset.address);
    expect(req.onResponse(null), null);

    const collectionReq = SolanaRPCGetMplCoreCollectionAccount(account: _asset);
    expect(collectionReq.toJson().first, _asset.address);
    expect(collectionReq.onResponse(null), null);

    const groupReq = SolanaRPCGetMplCoreGroupAccount(account: _asset);
    expect(groupReq.toJson().first, _asset.address);
    expect(groupReq.onResponse(null), null);
  });
  test('mpl core asset header decodes typed fields', () {
    final account = MplCoreAssetAccount(
      key: MplCoreKey.assetV1,
      owner: _owner,
      updateAuthority: MplCoreUpdateAuthority.collection(_asset),
      name: 'Core Asset',
      uri: 'https://example.com/a.json',
      seq: null,
      pluginBytes: const [9, 9],
    );
    final back = MplCoreAssetAccount.fromBuffer(account.toBytes());
    expect(back.key, MplCoreKey.assetV1);
    expect(back.owner, _owner);
    expect(
      back.updateAuthority.serialize(),
      MplCoreUpdateAuthority.collection(_asset).serialize(),
    );
    expect(back.name, 'Core Asset');
    expect(back.uri, 'https://example.com/a.json');
    expect(back.seq, null);
    expect(back.pluginBytes, [9, 9]);
    expect(back.toBytes(), account.toBytes());
    // Wrong record type rejected (collection key on the asset decoder).
    expect(
      () => MplCoreAssetAccount.fromBuffer(
        MplCoreCollectionAccount(
          key: MplCoreKey.collectionV1,
          updateAuthority: _payer,
          name: 'c',
          uri: 'u',
          numMinted: 0,
          currentSize: 0,
        ).toBytes(),
      ),
      throwsA(isA<BuError>()),
    );
  });
  test('mpl core collection + group decode typed fields', () {
    final collection = MplCoreCollectionAccount(
      key: MplCoreKey.collectionV1,
      updateAuthority: _payer,
      name: 'Collection',
      uri: 'https://example.com/c.json',
      numMinted: 3,
      currentSize: 7,
    );
    final collectionBack = MplCoreCollectionAccount.fromBuffer(
      collection.toBytes(),
    );
    expect(collectionBack.numMinted, 3);
    expect(collectionBack.currentSize, 7);
    expect(collectionBack.updateAuthority, _payer);
    expect(collectionBack.toBytes(), collection.toBytes());

    final group = MplCoreGroupAccount(
      key: MplCoreKey.groupV1,
      updateAuthority: _payer,
      name: 'Group',
      uri: 'https://example.com/g.json',
      collections: [_asset],
      groups: const [],
      parentGroups: const [],
      assets: [_mint, _owner],
    );
    final groupBack = MplCoreGroupAccount.fromBuffer(group.toBytes());
    expect(groupBack.collections, [_asset]);
    expect(groupBack.assets, [_mint, _owner]);
    expect(groupBack.groups, isEmpty);
    expect(groupBack.toBytes(), group.toBytes());
  });
  test('core candy rpc requests + accounts round trip', () {
    const machineReq = SolanaRPCGetCoreCandyMachineAccount(account: _asset);
    expect(machineReq.method, 'getAccountInfo');
    expect(machineReq.toJson().first, _asset.address);
    expect(machineReq.onResponse(null), null);

    const guardReq = SolanaRPCGetCoreCandyGuardAccount(account: _asset);
    expect(guardReq.toJson().first, _asset.address);
    expect(guardReq.onResponse(null), null);

    final machine = CoreCandyMachineAccount(
      authority: _payer,
      mintAuthority: _payer,
      collectionMint: _mint,
      itemsRedeemed: BigInt.from(2),
      data: CoreCandyMachineData(
        itemsAvailable: BigInt.from(100),
        maxSupply: BigInt.zero,
        isMutable: true,
        configLineSettings: const CoreCandyConfigLineSettings(
          prefixName: 'OG #',
          nameLength: 4,
          prefixUri: 'https://ex.com/',
          uriLength: 8,
          isSequential: true,
        ),
      ),
    );
    final machineBack = CoreCandyMachineAccount.fromBuffer(machine.toBytes());
    expect(machineBack.authority, _payer);
    expect(machineBack.collectionMint, _mint);
    expect(machineBack.itemsRedeemed, BigInt.from(2));
    expect(machineBack.data.itemsAvailable, BigInt.from(100));
    expect(machineBack.data.configLineSettings?.prefixName, 'OG #');
    expect(machineBack.data.hiddenSettings, null);
    expect(machineBack.toBytes(), machine.toBytes());

    const guard = CoreCandyGuardAccount(
      base: _asset,
      bump: 255,
      authority: _payer,
    );
    final guardBack = CoreCandyGuardAccount.fromBuffer(guard.toBytes());
    expect(guardBack.base, _asset);
    expect(guardBack.bump, 255);
    expect(guardBack.authority, _payer);
    expect(
      () => CoreCandyGuardAccount.fromBuffer(const [1, 2]),
      throwsException,
    );
  });
  test('token auth rules rpc requests + accounts round trip', () {
    const ruleSetReq = SolanaRPCGetTokenAuthRulesRuleSetAccount(
      account: _asset,
    );
    expect(ruleSetReq.method, 'getAccountInfo');
    expect(ruleSetReq.toJson().first, _asset.address);
    expect(ruleSetReq.onResponse(null), null);

    const bufferReq = SolanaRPCGetTokenAuthRulesBufferAccount(account: _asset);
    expect(bufferReq.toJson().first, _asset.address);
    expect(bufferReq.onResponse(null), null);

    final ruleSet = TokenAuthRulesRuleSetAccount.fromBuffer(const [1, 2, 3]);
    expect(ruleSet.rawBytes, [1, 2, 3]);
    final buffer = TokenAuthRulesBufferAccount.fromBuffer(const [4, 5]);
    expect(buffer.rawBytes, [4, 5]);
    expect(
      () => TokenAuthRulesRuleSetAccount.fromBuffer(const []),
      throwsA(isA<BuError>()),
    );
  });
}
