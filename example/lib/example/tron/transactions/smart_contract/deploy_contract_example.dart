import 'dart:convert';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:example/example/tron/provider_service/provider_service.dart';
import 'package:on_chain/on_chain.dart';

void main() async {
  final seed = BytesUtils.fromHexString(
      "6fed8bf347b201c4ff0379c9173a042163dbd5f1110bcb983ac8615dcbb98c853f7c1b524dcebdf47e2d19778d0b30e25065d5a5012d83b874ab7034e95a713f");
  final bip44 = Bip44.fromSeed(seed, Bip44Coins.tron);
  final ownerPrivateKey = TronPrivateKey.fromBytes(bip44.privateKey.raw);
  final ownerPublicKey = ownerPrivateKey.publicKey();
  final ownerAddress = ownerPublicKey.toAddress();

  final rpc =
      TronProvider(TronHTTPProvider(url: "https://api.shasta.trongrid.io"));
  final request = await rpc.request(TronRequestDeployContract(
      abi: _abiToDeploy,
      byteCode: _byteCodeToDeploy,
      name: "MRTNETWORK",
      ownerAddress: ownerAddress,
      originEnergyLimit: 1));

  /// get transactionRaw from response and make sure set fee limit
  TransactionRaw rawTr = request.transactionRaw!.copyWith(

      /// for fake tr we see fee limit to max
      /// for g
      feeLimit: TronHelper.toSun("1000"),
      data: utf8.encode("https://github.com/mrtnetwork"));

  /// txID
  final _ = rawTr.txID;

  /// get transaaction digest and sign with private key
  final sign = ownerPrivateKey.sign(rawTr.toBuffer());

  /// create transaction object and add raw data and signature to this
  final transaction = Transaction(rawData: rawTr, signature: [sign]);

  /// get raw data buffer
  final raw = transaction.toHex;

  /// send transaction to network
  await rpc.request(TronRequestBroadcastHex(transaction: raw));

  /// https://shasta.tronscan.org/#/transaction/a1bf2dd74ff1f3adfa34c5087d6249da296ebe773d49e852e8cfadc812a9a50c
}

final _abiToDeploy = [
  {
    "inputs": [],
    "name": "getSum",
    "outputs": [
      {"internalType": "uint256", "name": "", "type": "uint256"}
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "j",
    "outputs": [
      {"internalType": "uint256", "name": "", "type": "uint256"}
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [
      {"internalType": "uint256", "name": "v", "type": "uint256"}
    ],
    "name": "test2",
    "outputs": [
      {"internalType": "uint256", "name": "", "type": "uint256"}
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "x",
    "outputs": [
      {"internalType": "uint256", "name": "", "type": "uint256"}
    ],
    "stateMutability": "view",
    "type": "function"
  },
  {
    "inputs": [],
    "name": "y",
    "outputs": [
      {"internalType": "uint256", "name": "", "type": "uint256"}
    ],
    "stateMutability": "view",
    "type": "function"
  }
];

const _byteCodeToDeploy =
    "608060405260145f556014600155348015610018575f80fd5b5061025d806100265f395ff3fe608060405234801561000f575f80fd5b5060043610610055575f3560e01c80630c55699c14610059578063569c5f6d14610077578063a56dfe4a14610095578063b582ec5f146100b3578063caf44683146100d1575b5f80fd5b610061610101565b60405161006e9190610155565b60405180910390f35b61007f610106565b60405161008c9190610155565b60405180910390f35b61009d61011b565b6040516100aa9190610155565b60405180910390f35b6100bb610121565b6040516100c89190610155565b60405180910390f35b6100eb60048036038101906100e6919061019c565b610127565b6040516100f89190610155565b60405180910390f35b5f5481565b5f6001545f5461011691906101f4565b905090565b60015481565b60025481565b5f6001548261013691906101f4565b9050919050565b5f819050919050565b61014f8161013d565b82525050565b5f6020820190506101685f830184610146565b92915050565b5f80fd5b61017b8161013d565b8114610185575f80fd5b50565b5f8135905061019681610172565b92915050565b5f602082840312156101b1576101b061016e565b5b5f6101be84828501610188565b91505092915050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52601160045260245ffd5b5f6101fe8261013d565b91506102098361013d565b9250828201905080821115610221576102206101c7565b5b9291505056fea2646970667358221220764b87afed3af284f021cf469847bafb17909837c0d325668d80cf86df5f7cf264736f6c63430008160033";
