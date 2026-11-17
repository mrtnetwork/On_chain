/// Offline Solana instruction round-trip checks (no network needed).
library;

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/solana.dart';

/// Deterministic demo addresses (same seeds as solana.dart).
SolanaPrivateKey _demoKey(int seedByte) =>
    SolanaPrivateKey.fromBytes(List<int>.filled(32, seedByte));
SolAddress get _faucet => _demoKey(12).publicKey().toAddress();
SolAddress get _alice => _demoKey(23).publicKey().toAddress();
SolAddress get _bob => _demoKey(25).publicKey().toAddress();

void _show(String title, TransactionInstruction ix) {
  final bytes = ix.data;
  final preview = bytes.length > 24
      ? '${BytesUtils.toHexString(bytes.sublist(0, 24))}...'
      : BytesUtils.toHexString(bytes);
  print('  $title');
  print('    program: ${ix.programId.address}');
  print('    data[${bytes.length}]: $preview');
  print('    accounts: ${ix.keys.length}');
}

/// 4. New standards tour (offline encode + decode).
Future<void> exampleNewStandards() async {
  print('\n== 4. new standards tour (offline) ==');

  // secp256r1 verify layout (WebAuthn/P-256 style).
  final r1 = Secp256r1Layout.fromParts(
    publicKey: List<int>.filled(33, 7),
    message: StringUtils.encode('hello solana'),
    signature: List<int>.filled(64, 9),
  );
  final r1Back = Secp256r1Layout.fromBuffer(r1.toBytes());
  assert(r1Back.toBytes().length == r1.toBytes().length);
  _show('secp256r1 verify', Secp256r1Program(layout: r1));

  // Token-2022 confidential deposit (outer 27, inner 5).
  final deposit = SPLToken2022ConfidentialDepositLayout(
    amount: BigInt.from(1000),
    decimals: 6,
  );
  final depositBack =
      SPLTokenProgramLayout.fromBytes(deposit.toBytes());
  assert(depositBack is SPLToken2022ConfidentialDepositLayout);
  _show(
    'confidential deposit',
    SPLToken2022ExtensionsProgram.confidentialDeposit(
      token: _faucet,
      mint: _alice,
      authority: _faucet,
      layout: deposit,
    ),
  );

  // MPL Core: create -> transfer -> update -> burn (uncompressed: None proof).
  final createIx = MplCoreProgram.createV1(
    asset: _alice,
    payer: _faucet,
    layout: MplCoreCreateV1Layout(
      dataState: MplCoreDataState.accountState,
      name: 'Demo Core Asset',
      uri: 'https://example.com/asset.json',
    ),
  );
  final createBack =
      MplCoreProgramLayout.fromBytes(createIx.data);
  assert(createBack is MplCoreCreateV1Layout);
  _show('mpl-core createV1', createIx);

  final transferIx = MplCoreProgram.transferV1(
    asset: _alice,
    newOwner: _bob,
    payer: _faucet,
  );
  assert(
    MplCoreProgramLayout.fromBytes(transferIx.data)
        is MplCoreCompressionProofLayout,
  );
  _show('mpl-core transferV1', transferIx);

  final updateIx = MplCoreProgram.updateV1(
    asset: _alice,
    payer: _faucet,
    newName: 'Renamed',
    newUpdateAuthority: MplCoreUpdateAuthority.collection(_alice),
  );
  _show('mpl-core updateV1', updateIx);

  // Core Candy Machine: add a config line (typed) + mint (raw args).
  final addLine = CoreCandyMachineAddConfigLinesLayout(
    index: 0,
    configLines: const [
      CoreCandyMachineConfigLine(name: 'OG', uri: 'https://ex.com/og.json'),
    ],
  );
  assert(
    CoreCandyMachineProgramLayoutDispatch.machineFromBytes(addLine.toBytes())
        is CoreCandyMachineAddConfigLinesLayout,
  );
  _show(
    'core-candy addConfigLines',
    CoreCandyMachineProgram.addConfigLines(
      candyMachine: _alice,
      authority: _faucet,
      layout: addLine,
    ),
  );

  // Token Authorization Rules: store a rule set + validate shell.
  final ruleSet = TokenAuthRulesCreateOrUpdateLayout(
    serializedRuleSet: const [1, 2, 3, 4],
  );
  assert(
    TokenAuthRulesProgramLayoutDispatch.fromBytes(ruleSet.toBytes())
        is TokenAuthRulesCreateOrUpdateLayout,
  );
  _show(
    'auth-rules createOrUpdate',
    TokenAuthRulesProgram.createOrUpdate(
      payer: _faucet,
      ruleSetPda: _alice,
      serializedRuleSet: const [1, 2, 3, 4],
    ),
  );

  print('  all new-standard instructions encoded + decoded.');
}

/// Offline entry point (no RPC needed).
Future<void> main() async {
  await exampleNewStandards();
  print('\nNew-standards example completed.');
}
