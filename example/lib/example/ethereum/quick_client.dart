/// Ethereum quick-client tour on a local Anvil node (reads, deploy, ERC-20/721/1155 calls).
library;

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';

import 'rpc/http_service.dart';

/// Local Anvil RPC (chain id 31337).
const String rpcUrl = 'http://127.0.0.1:28545';
const int chainId = 31337;

/// Anvil default account 0 (faucet / deployer), 10000 ETH.
const String faucetKeyHex =
    '0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80';

/// Anvil default account 1 (used as the transfer recipient).
const String aliceKeyHex =
    '0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d';

/// Contracts deployed by /home/mohsen/Documents/networks/ethereum/deploy.sh.
const String erc20Address = '0x0165878A594ca255338adfa4d48449f69242Eb8F';
const String erc721Address = '0xA51c1fc2f0D1a1b8494Ed1FE312d7C3a78Ed91C0';
const String erc1155Address = '0x2279B7A0a67DB372996a5FaB50D91eAA73d2eBe6';

/// Creation bytecode of the tiny `Tiny` contract (uint256 `value` + `setValue`),
/// compiled with solc 0.8.26.
const String tinyBin =
    '6080604052348015600e575f80fd5b506101268061001c5f395ff3fe'
    '6080604052348015600e575f80fd5b50600436106030575f3560e01c'
    '80633fa4f2451460345780635524107714604e575b5f80fd5b603a606656'
    '5b60405160459190608a565b60405180910390f35b606460048036038101'
    '906060919060ca565b606b565b005b5f5481565b805f8190555050565b5f'
    '819050919050565b6084816074565b82525050565b5f60208201905060'
    '9b5f830184607d565b92915050565b5f80fd5b60ac816074565b811460b5'
    '575f80fd5b50565b5f8135905060c48160a5565b92915050565b5f602082'
    '8403121560dc5760db60a1565b5b5f60e78482850160b8565b9150509291'
    '505056fea26469706673582212202187b131387668332dfcd83486a0d424'
    'a6134b0abd55652477e8cea05dc6a2a264736f6c634300081a0033';

/// Minimal ABIs for the functions used below.
final List<Map<String, dynamic>> _erc20Abi = [
  {
    "inputs": [],
    "name": "decimals",
    "outputs": [
      {"internalType": "uint8", "name": "", "type": "uint8"},
    ],
    "stateMutability": "view",
    "type": "function",
  },
  {
    "inputs": [],
    "name": "symbol",
    "outputs": [
      {"internalType": "string", "name": "", "type": "string"},
    ],
    "stateMutability": "view",
    "type": "function",
  },
  {
    "inputs": [
      {"internalType": "address", "name": "to", "type": "address"},
      {"internalType": "uint256", "name": "value", "type": "uint256"},
    ],
    "name": "transfer",
    "outputs": [
      {"internalType": "bool", "name": "", "type": "bool"},
    ],
    "stateMutability": "nonpayable",
    "type": "function",
  },
];

final List<Map<String, dynamic>> _erc721Abi = [
  {
    "inputs": [
      {"internalType": "address", "name": "from", "type": "address"},
      {"internalType": "address", "name": "to", "type": "address"},
      {"internalType": "uint256", "name": "tokenId", "type": "uint256"},
    ],
    "name": "transferFrom",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function",
  },
];

final List<Map<String, dynamic>> _erc1155Abi = [
  {
    "inputs": [
      {"internalType": "address", "name": "from", "type": "address"},
      {"internalType": "address", "name": "to", "type": "address"},
      {"internalType": "uint256", "name": "id", "type": "uint256"},
      {"internalType": "uint256", "name": "amount", "type": "uint256"},
      {"internalType": "bytes", "name": "data", "type": "bytes"},
    ],
    "name": "safeTransferFrom",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function",
  },
];

/// The QuickClient and raw provider used by every example.
final EthereumQuickClient quick = DefaultEthereumQuickClient(
  provider: EthereumProvider(RPCHttpService(rpcUrl)),
);

final ETHPrivateKey faucetKey = ETHPrivateKey.fromHex(faucetKeyHex);
final ETHAddress faucet = faucetKey.publicKey().toAddress();

final ETHPrivateKey aliceKey = ETHPrivateKey.fromHex(aliceKeyHex);
final ETHAddress alice = aliceKey.publicKey().toAddress();

/// Builds a state-changing contract transaction and submits it.
Future<TransactionReceipt> sendContractCall({
  required ETHAddress contract,
  required String functionName,
  required List<dynamic> args,
}) async {
  final abi = ContractABI.fromJson(_erc20Abi);
  final builder = ETHTransactionBuilder(
    from: faucet,
    to: contract,
    value: BigInt.zero,
    chainId: BigInt.from(chainId),
    data: abi.functionFromName(functionName).encode(args),
    transactionType: ETHTransactionType.eip1559,
  );
  await builder.autoFill(quick.provider);
  builder.sign(faucetKey);
  final txId = builder.transactionID;
  final receipt = await builder.submitAndWatchTransactionAsync(
    quick.provider,
    blockInterval: const Duration(seconds: 1),
  );
  print('  tx: $txId  status=${receipt.status}  gas=${receipt.gasUsed}');
  return receipt;
}

/// Deploys a contract via a raw EIP-1559 contract-creation transaction.
Future<String> deployContract(List<int> creationBytecode) async {
  final nonce = await quick.getAccountNonce(faucet);
  final gasLimit = await quick.estimateGasLimit({
    'from': faucet.address,
    'data': BytesUtils.toHexString(creationBytecode, prefix: '0x'),
    'value': '0x0',
  });
  final gas = await quick.gasPrice();
  final maxFee =
      gas == BigInt.zero ? BigInt.from(1000000000) : gas * BigInt.two;

  final tx = ETHTransaction(
    nonce: nonce,
    gasLimit: gasLimit,
    data: creationBytecode,
    value: BigInt.zero,
    chainId: BigInt.from(chainId),
    type: ETHTransactionType.eip1559,
    maxFeePerGas: maxFee,
    maxPriorityFeePerGas: BigInt.from(1000000000),
  );
  final signature = faucetKey.sign(tx.serialized);
  final signed = tx.copyWith(signature: signature);
  final raw = BytesUtils.toHexString(signed.signedSerialized(), prefix: '0x');
  final txId = await quick.sendRawTransaction(raw);
  final receipt = await quick.trackTransaction(
    transactionId: txId,
    periodicTimeOut: const Duration(seconds: 1),
  );
  final address = receipt.contractAddress;
  if (address == null) {
    throw StateError('deploy failed, no contract address in receipt');
  }
  return address;
}

/// 1. QuickClient tour.
Future<void> exampleQuickClientTour() async {
  print('\n== 1. QuickClient tour ==');

  print('  chain id:        ${await quick.getChainId()}');
  print('  block height:    ${await quick.getBlockHeight()}');
  print('  gas price:       ${await quick.gasPrice()}');
  final fee = await quick.getHistoricalFee();
  print('  fee slow/normal/high: ${fee.slow}/${fee.normal}/${fee.high}');
  print('  faucet balance:  ${await quick.getBalance(faucet)} wei');
  print('  faucet nonce:    ${await quick.getAccountNonce(faucet)}');

  final isErc20 = await quick.isContract(SolidityAddress(erc20Address));
  print('  erc20 isContract:$isErc20');

  final std = await quick.detectContractStandard(
    contract: SolidityAddress(erc20Address),
    from: SolidityAddress(faucet.address),
  );
  print('  erc20 standard:  ${std?.name ?? 'unknown'}');

  final meta = await quick.getERC20Details(SolidityAddress(erc20Address));
  print(
      '  erc20 metadata:  ${meta?.name} (${meta?.symbol}) ${meta?.decimals}d');
  final token = await quick.getAccountERC20Token(
    SolidityAddress(faucet.address),
    SolidityAddress(erc20Address),
  );
  print('  erc20 balance:   ${token?.balance}');
}

/// 2. Deploy the tiny contract and call it.
Future<void> exampleDeployAndCall() async {
  print('\n== 2. Deploy a contract ==');
  final address = await deployContract(
    BytesUtils.fromHexString(tinyBin),
  );
  print('  deployed Tiny at: $address');
  print(
      '  isContract:       ${await quick.isContract(SolidityAddress(address))}');

  // State-changing call: setValue(12345).
  final abi = ContractABI.fromJson([
    {
      "inputs": [
        {"internalType": "uint256", "name": "v", "type": "uint256"},
      ],
      "name": "setValue",
      "outputs": [],
      "stateMutability": "nonpayable",
      "type": "function",
    },
  ]);
  final builder = ETHTransactionBuilder(
    from: faucet,
    to: ETHAddress(address),
    value: BigInt.zero,
    chainId: BigInt.from(chainId),
    data: abi.functionFromName("setValue").encode([BigInt.from(12345)]),
    transactionType: ETHTransactionType.eip1559,
  );
  await builder.autoFill(quick.provider);
  builder.sign(faucetKey);
  await builder.submitAndWatchTransactionAsync(
    quick.provider,
    blockInterval: const Duration(seconds: 1),
  );
  print('  setValue(12345) confirmed');
}

/// 3. Contract view calls.
Future<void> exampleViewCalls() async {
  print('\n== 3. Contract view calls ==');
  final erc20 = SolidityAddress(erc20Address);
  final erc721 = SolidityAddress(erc721Address);
  final erc1155 = SolidityAddress(erc1155Address);

  print('  erc20 name:      ${await quick.getERC20Name(erc20)}');
  print('  erc20 symbol:    ${await quick.getERC20Symbol(erc20)}');
  print(
    '  erc20 allowance: ${await quick.getAllowance(contract: erc20, owner: SolidityAddress(faucet.address), spender: SolidityAddress(alice.address))}',
  );

  final owner = await quick.getERC721Owner(
    contract: erc721,
    tokenId: BigInt.one,
  );
  print('  erc721 ownerOf(1): ${owner?.address ?? 'none'}');
  print(
    '  erc721 tokenURI: ${await quick.getERC721TokenUri(contract: erc721, tokenId: BigInt.one)}',
  );

  print(
    '  erc1155 uri(1): ${await quick.getERC1155Uri(contract: erc1155, tokenId: BigInt.one)}',
  );
  print(
    '  erc1155 bal:    ${await quick.getERC1155Balance(address: SolidityAddress(faucet.address), contract: erc1155, tokenId: BigInt.one)}',
  );

  final supports = await quick.supportsInterface(
    standard: EthereumContractStandard.erc1155,
    contract: erc1155,
    from: SolidityAddress(faucet.address),
  );
  print('  erc1155 ERC165:  $supports');
}

/// 4. State-changing calls: ERC-20 transfer, ERC-721 transfer, ERC-1155 transfer.
Future<void> exampleCalls() async {
  print('\n== 4. Contract call examples ==');

  // ERC-20 transfer(faucet -> alice, 1 token unit).
  print('  -- ERC-20 transfer --');
  final before = await quick.getTokenBalance(
    address: SolidityAddress(alice.address),
    contract: SolidityAddress(erc20Address),
  );
  await sendContractCall(
    contract: ETHAddress(erc20Address),
    functionName: 'transfer',
    args: [alice, BigInt.one],
  );
  final after = await quick.getTokenBalance(
    address: SolidityAddress(alice.address),
    contract: SolidityAddress(erc20Address),
  );
  print('  alice erc20: $before -> $after');

  // ERC-721 transferFrom(faucet -> alice, token 1) when faucet owns it.
  final nftOwner = await quick.getERC721Owner(
    contract: SolidityAddress(erc721Address),
    tokenId: BigInt.one,
  );
  print('  -- ERC-721 transferFrom --');
  if (nftOwner != null && nftOwner.address == faucet.address) {
    final abi = ContractABI.fromJson(_erc721Abi);
    final builder = ETHTransactionBuilder(
      from: faucet,
      to: ETHAddress(erc721Address),
      value: BigInt.zero,
      chainId: BigInt.from(chainId),
      data: abi.functionFromName('transferFrom').encode([
        faucet,
        alice,
        BigInt.one,
      ]),
      transactionType: ETHTransactionType.eip1559,
    );
    await builder.autoFill(quick.provider);
    builder.sign(faucetKey);
    await builder.submitAndWatchTransactionAsync(
      quick.provider,
      blockInterval: const Duration(seconds: 1),
    );
    final newOwner = await quick.getERC721Owner(
      contract: SolidityAddress(erc721Address),
      tokenId: BigInt.one,
    );
    print('  erc721 ownerOf(1): ${newOwner?.address ?? 'none'}');
  } else {
    print('  skipped (faucet does not own token 1)');
  }

  // ERC-1155 safeTransferFrom(faucet -> alice, id 0, 1 unit).
  // The local deploy mints id 0 (fungible) to the faucet.
  print('  -- ERC-1155 safeTransferFrom --');
  final tokenId = BigInt.zero;
  try {
    final erc1155Before = await quick.getERC1155Balance(
      address: SolidityAddress(alice.address),
      contract: SolidityAddress(erc1155Address),
      tokenId: tokenId,
    );
    final abi = ContractABI.fromJson(_erc1155Abi);
    final builder = ETHTransactionBuilder(
      from: faucet,
      to: ETHAddress(erc1155Address),
      value: BigInt.zero,
      chainId: BigInt.from(chainId),
      data: abi.functionFromName('safeTransferFrom').encode([
        faucet,
        alice,
        tokenId,
        BigInt.one,
        <int>[],
      ]),
      transactionType: ETHTransactionType.eip1559,
    );
    await builder.autoFill(quick.provider);
    builder.sign(faucetKey);
    await builder.submitAndWatchTransactionAsync(
      quick.provider,
      blockInterval: const Duration(seconds: 1),
    );
    final erc1155After = await quick.getERC1155Balance(
      address: SolidityAddress(alice.address),
      contract: SolidityAddress(erc1155Address),
      tokenId: tokenId,
    );
    print('  alice erc1155 id0: $erc1155Before -> $erc1155After');
  } catch (e) {
    print('  skipped (faucet cannot send id 0): $e');
  }
}

Future<void> main() async {
  print('Ethereum local Anvil (QuickClient)');
  print('  rpc:     $rpcUrl');
  print('  chainId: $chainId');
  print('  faucet:  ${faucet.address}');

  final balance = await quick.getBalance(faucet);
  if (balance == BigInt.zero) {
    print('\nFaucet has no ETH. Fund it:');
    print(
        '  cd /home/mohsen/Documents/networks/ethereum && ./faucet.sh ${faucet.address}');
    return;
  }

  await exampleQuickClientTour();
  await exampleViewCalls();
  await exampleDeployAndCall();
  await exampleCalls();

  print('\nAll Ethereum examples completed.');
}
