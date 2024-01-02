# ON CHAIN Dart Package
Onchain Plugin for Dart—an advanced cross-platform solution that seamlessly integrates with Ethereum and Tron blockchains, supporting key features such as Legacy EIP1559, EIP2930, EIP71, and now, the cutting-edge EIP721 standard. This plugin empowers developers with comprehensive capabilities for Ethereum transactions, smart contracts, and token standards, including NFTs through EIP721. Beyond Ethereum, it facilitates a wide range of Tron operations, including account creation, asset transfer, and smart contract executions.

## Features

### EVM Network

Unleash the potential of your Dart applications on the Ethereum Virtual Machine (EVM) network. With the Onchain Plugin, seamlessly transact, deploy smart contracts, and engage with decentralized applications on one of the most influential blockchain networks. Effortlessly harness the power of EIP1559, EIP2930, and the latest EIP721 standard for enhanced Ethereum capabilities.

- Sign (Transaction, Personal Signing): Enable secure transaction and personal data signing within your Dart applications, ensuring cryptographic integrity and authentication.

- EIP1559: Embrace the efficiency of the Ethereum Improvement Proposal 1559, optimizing transaction fee mechanisms for enhanced predictability and user experience.

- EIP2930 (Access List): Streamline contract interactions with the Ethereum blockchain using Access Lists, enhancing efficiency and reducing transaction costs by specifying accounts with direct access permissions.


- Interact with Contract: Seamlessly engage with Ethereum smart contracts, unlocking the full potential of decentralized applications through efficient contract interactions within your Dart projects.

- Interact with Ethereum Node (JSON RPC): Facilitate direct communication with Ethereum nodes through JSON RPC, enabling your Dart applications to access and query blockchain data in a standardized and efficient manner.

- EIP712 (Legacy, v3, v4): Implement Ethereum Improvement Proposal 712 standards for structured and secure message signing, supporting legacy as well as versions 3 and 4 to ensure compatibility and compliance across diverse Ethereum ecosystems.


### TVM Networks

Dive into the Tron Virtual Machine (TVM) networks with confidence. The Onchain Plugin for Dart extends support to Tron, enabling smooth account creation, asset transfers, and execution of various smart contracts. Explore a multitude of Tron contracts, including smart contracts, with ease, empowering your Dart applications to thrive in the diverse Tron blockchain ecosystem.

- Sign (Transaction, Personal Signing) for Tron: Securely authorize Tron transactions and sign personal data within your Dart applications, ensuring cryptographic integrity and user authentication.

- Multi-Signature: Enhance security and decentralized decision-making on the Tron blockchain with multi-signature capabilities. Enable collaboration by requiring multiple cryptographic signatures for transactions, reinforcing trust and integrity within the Tron network. Empower your Dart applications with sophisticated multi-signature functionality for a resilient and collaborative approach to transaction authorization on Tron.

- Interact with Tron Smart Contract: Seamlessly engage with Tron's smart contracts, enabling your Dart projects to execute and manage transactions on the Tron blockchain with ease.

- Create Tron Native Contract Transactions: Effortlessly initiate a wide array of Tron native contract transactions, including account creation, asset transfers, voting, smart contract creation, and more. Explore a comprehensive list of supported contract operations tailored for Tron's blockchain.

- Interact with Tron HTTP Node: Facilitate direct communication with Tron's blockchain through HTTP nodes, allowing your Dart applications to query and interact with Tron's network in a standardized and efficient manner.

- All Features of Tron: Harness the full potential of Tron's blockchain by leveraging all its features, including shielded transfers, market transactions, resource delegation, contract management, and more. Empower your Dart applications with comprehensive functionality for a rich and dynamic Tron blockchain experience.

## EXAMPLES

### Key and addresses
  - Private and public key

    ```
    /// Ethereum
    /// Initialize an Ethereum private key.
    final ETHPrivateKey ethereumPrivateKey = ETHPrivateKey("..."); 

    /// Generate a cryptographic signature for a transaction digest.
    final String sign = ethereumPrivateKey.sign("txDigest"); 

    /// Generate a cryptographic signature for a personal message.
    final String personalSign = ethereumPrivateKey.signPersonalMessage("message"); 

    /// Obtain the corresponding public key.
    final ETHPublicKey publicKey = ethereumPrivateKey.publicKey(); 

    /// Verify the authenticity of a personal message using the public key.
    final bool verify = publicKey.verifyPersonalMessage("message", "signature"); 

    /// Derive the Ethereum address associated with the public key.
    final EthereumAddress ethereumAddress = publicKey.toAddress(); 

    /// Tron
    /// Initialize a Tron private key.
    final TronPrivateKey tronPrivateKey = TronPrivateKey("..."); 

    /// Generate a cryptographic signature for a Tron transaction digest.
    final String tronSign = tronPrivateKey.sign("txDigest"); 

    /// Generate a cryptographic signature for a Tron personal message.
    final String tronPersonalSign = tronPrivateKey.signPersonalMessage("message"); 

    /// Obtain the corresponding Tron public key.
    final TronPublicKey tronPublicKey = tronPrivateKey.publicKey(); 

    /// Verify the authenticity of a Tron personal message using the public key.
    final bool verifyTron = tronPublicKey.verifyPersonalMessage("message", "signature"); 

    /// Derive the Tron address associated with the public key.
    final TronAddress tronAddress = tronPublicKey.toAddress(); 

    /// Convert the Tron address to a base58-encoded format.
    final String base58TronAddress = tronAddress.toString(true); 

    /// Convert the Tron address to a hexadecimal format.
    final String hexTronAddress = tronAddress.toString(false); 
    ```
  - Ethreum transaction

    ```
    /// Connect to the WebSocket service
    final wsocketService = await RPCWebSocketService.connect(
        "wss://polygon-mumbai-bor.publicnode.com");

    /// Create an Ethereum RPC instance
    final rpc = EVMRPC(wsocketService);

    /// Define a seed for generating a private key
    final seed = BytesUtils.fromHexString(
        "6fed8bf347b201c4ff0379c9173a042163dbd5f1110bcb983ac8615dcbb98c853f7c1b524dcebdf47e2d19778d0b30e25065d5a5012d83b874ab7034e95a713f");

    /// Derive the BIP44 path for Ethereum
    final bip44 = Bip44.fromSeed(seed, Bip44Coins.ethereum).deriveDefaultPath;

    /// Create an Ethereum private key from the BIP44 private key
    final privateKey = ETHPrivateKey.fromBytes(bip44.privateKey.raw);

    /// Derive the public key and Ethereum address from the private key
    final publicKey = privateKey.publicKey();
    final address = publicKey.toAddress();

    /// Define the target ERC-20 contract address
    final contractAddress =
        ETHAddress("0x6c6b4fd6502c74ed8a15d54b9152973f3aa24e51");

    /// Define the transfer function fragment using ABI
    final transferFragment = AbiFunctionFragment.fromJson({
      "inputs": [
        {"internalType": "address", "name": "to", "type": "address"},
        {"internalType": "uint256", "name": "value", "type": "uint256"}
      ],
      "name": "transfer",
      "stateMutability": "nonpayable",
     "type": "function"
    }, false);

    /// Request gas price from the RPC service
    final gasPrice = await rpc.request(RPCGetGasPrice());

    /// Request nonce (transaction count) for the sender's address
    final nonce =
        await rpc.request(RPCGetTransactionCount(address: address.address));

    /// Build an Ethereum transaction for a contract call (transfer)
    ETHTransaction tr = ETHTransaction(
      type: ETHTransactionType.legacy,

      /// Sender's Ethereum address
      from: address,

      /// Target ERC-20 contract address
      to: contractAddress,

      /// Nonce (transaction count) for the sender
      nonce: nonce,

      /// Placeholder for gas limit (to be estimated later)
      gasLimit: BigInt.zero,

      /// Gas price obtained from RPC service (only for legacy and eip2930 transaction)
      gasPrice: gasPrice,

      data: transferFragment.encode([
        /// Recipient address
        ETHAddress("0xBfD365373f559Cd398A408b975FD18B16632d348"),

        /// Amount to transfer (in Wei)
        ETHHelper.toWei("100")
      ]),

      /// No Ether value sent with the transaction
      value: BigInt.zero,

      /// Ethereum chain ID (Mumbai testnet)
      chainId: BigInt.from(80001),
    );

    /// Estimate gas limit for the transaction
    final gasLimit = await rpc.request(RPCEstimateGas(
      transaction: tr.toEstimate(),
    ));

    /// Update the transaction with the estimated gas limit
    tr = tr.copyWith(gasLimit: gasLimit);

    /// Serialize the unsigned transaction
    final unsignedSerialized = tr.serialized;

    /// Sign the transaction with the private key
    final signature = privateKey.sign(unsignedSerialized);

    /// Serialize the signed transaction
    final signedSerialized =
        BytesUtils.toHexString(tr.signedSerialized(signature), prefix: "0x");

    /// Send the signed transaction to the Ethereum network
      await rpc.request(RPCSendRawTransaction(transaction: signedSerialized));

    ```
  - Contract intraction
    Tron and Ethereum
    ```
    /// For Tron: If the output parameters include an address, set isTron to true.
    /// If it doesn't, set isTron to false to receive an ETH address instead of a Tron address.
    final contract = ContractABI.fromJson(tronContract["entrys"]!, isTron: true);
    final rpc = EVMRPC(RPCHttpService("https://api.shasta.trongrid.io/jsonrpc"));
    final call1 = await rpc.request(RPCCall.fromMethod(
        contractAddress:

            /// use hex address (visible to false)
            TronAddress("TLKdBQPmZbScLWENtAW5uVJCwJWMb2n6vU").toAddress(false),
        function: contract.functionFromName("checkInt"),
        params: [
          BigInt.from(12),
          -BigInt.from(150),
          BigInt.from(25),
          BigInt.from(2),
        ]));

    ```
    Tron with Http Node

    ```
    final contract = ContractABI.fromJson(tronContract["entrys"]!, isTron: true);
    final rpc =
        TronProvider(TronHTTPProvider(url: "https://api.shasta.trongrid.io"));
    final call1 = await rpc.request(TronRequestTriggerConstantContract.fromMethod(
      ownerAddress: TronAddress("TLKdBQPmZbScLWENtAW5uVJCwJWMb2n6vU"),
      contractAddress: TronAddress("TLKdBQPmZbScLWENtAW5uVJCwJWMb2n6vU"),
      function: contract.functionFromName("checkInt"),
      /// trx amount in call
      callValue: null,

      /// trc10 amount and token id in call
      callTokenValue: null,
      tokenId: null,

      params: [
        -BigInt.from(12),
        -BigInt.from(150),
        BigInt.from(25),
        BigInt.from(2),
      ],
    ));
    ```
  - Tron transaction
    Transfer TRX

    ```
    /// intialize private key, address, receiver and ....
    final seed = BytesUtils.fromHexString(
        "6fed8bf347b201c4ff0379c9173a042163dbd5f1110bcb983ac8615dcbb98c853f7c1b524dcebdf47e2d19778d0b30e25065d5a5012d83b874ab7034e95a713f");
    final bip44 = Bip44.fromSeed(seed, Bip44Coins.tron);
    final prv = TronPrivateKey.fromBytes(bip44.privateKey.raw);
    final publicKey = prv.publicKey();
    final address = publicKey.toAddress();
    final receiverAddress = TronAddress("TF3cDajEAaJ8jFXFB2KF3XSUbTpZWzuSrp");

    /// intialize shasta http provider to send and receive requests
    final rpc =
        TronProvider(TronHTTPProvider(url: "https://api.shasta.trongrid.io"));

    /// create transfer contract (TRX Transfer)
    final transferContract = TransferContract(
      /// 10 TRX
      amount: TronHelper.toSun("10"),
      ownerAddress: address,
      toAddress: receiverAddress,
    );

    /// validate transacation and got required data like block hash and ....
    final request = await rpc.request(TronRequestCreateTransaction.fromContract(

      /// params: permission ID (multi-sig Transaction), optional data like memo
      transferContract,
      visible: false));

    /// An error has occurred with the request, and we need to investigate the issue to determine what is happening.
    if (!request.isSuccess) {
      /// print(request.error ?? request.respose);
      return;
    }

    /// get transactionRaw from response and make sure sed fee limit
    final rawTr =
        request.transactionRaw!.copyWith(feeLimit: BigInt.from(10000000));

    // txID
    final _ = rawTr.txID;

    /// get transaaction digest and sign with private key
    final sign = prv.sign(rawTr.toBuffer());

    /// create transaction object and add raw data and signature to this
    final transaction = Transaction(rawData: rawTr, signature: [sign]);

    /// get raw data buffer
    final raw = BytesUtils.toHexString(transaction.toBuffer());

    /// send transaction to network
    await rpc.request(TronRequestBroadcastHex(transaction: raw));
    ```

    Frozen balance (bandwidth, energy)
    ```
    /// create contract
    final contract = FreezeBalanceV2Contract(
        ownerAddress: ownerAddress,
        frozenBalance: TronHelper.toSun("3.5"),
        resource: ResourceCode.bandWidth);

    /// validate transacation and got required data like block hash and ....
    final request = await rpc.request(TronRequestFreezeBalanceV2.fromContract(

        /// params: permission ID (multi-sig Transaction)
        contract));

    /// An error has occurred with the request, and we need to investigate the issue to determine what is happening.
    if (!request.isSuccess) {
      //// print(request.error);
      return;
    }

    /// get transactionRaw from response and make sure set fee limit
    final rawTr = request.transactionRaw!.copyWith(
        feeLimit: BigInt.from(10000000),
        data: utf8.encode("https://github.com/mrtnetwork"));

    final _ = rawTr.txID;

    /// get transaaction digest and sign with private key
    final sign = ownerPrivateKey.sign(rawTr.toBuffer());

    /// create transaction object and add raw data and signature to this
    final transaction = Transaction(rawData: rawTr, signature: [sign]);

    /// send transaction to network
    await rpc.request(TronRequestBroadcastHex(transaction: transaction.toHex));
    ```
  
  - EIP-712
    ```
    /// Create an EIP-712 message
    final Eip712TypedData eip712 = Eip712TypedData(
      types: {
        "EIP712Domain": [
          const Eip712TypeDetails(name: "name", type: "string"),
          const Eip712TypeDetails(name: "version", type: "string"),
          const Eip712TypeDetails(name: "chainId", type: "uint256"),
          const Eip712TypeDetails(name: "verifyingContract", type: "address"),
        ],
        "Person": [
          const Eip712TypeDetails(name: "name", type: "string"),
          const Eip712TypeDetails(name: "wallet", type: "address"),
        ],
        "Mail": [
          const Eip712TypeDetails(name: "from", type: "Person"),
          const Eip712TypeDetails(name: "to", type: "Person"),
          const Eip712TypeDetails(name: "contents", type: "string")
        ],
      },
      primaryType: "Mail",
      domain: {
        "name": "Ether Mail",
        "version": "1",
        "chainId": BigInt.from(80001),
        "verifyingContract": "0xCcCCccccCCCCcCCCCCCcCcCccCcCCCcCcccccccC",
      },
      message: {
        "from": {
          "name": "Cow",
          "wallet": "0xCD2a3d9F938E13CD947Ec05AbC7FE734Df8DD826"
        },
        "to": {
          "name": "Bob",
          "wallet": "0xbBbBBBBbbBBBbbbBbbBbbbbBBbBbbbbBbBbbBBbB"
        },
        "contents": "Hello, Bob!",
      });

    /// Encode the types of the EIP-712 message
    final encodeTypes = eip712.encode();

    /// Define a private key for signing the EIP-712 message
    final privateKey = ETHPrivateKey(
        "db8cf18222bb47698309de20e0befa9a55ef1f0af001dcefa79d31446484dc65");

    /// Sign the encoded types with the private key, setting hashMessage to false
    final _ = privateKey.sign(encodeTypes, hashMessage: false).toHex();
    ```

  - JSON-RPC
    Explore all available methods in the ethereum/rpc/methods/ directory.
    ```
    /// HTTP RPC Service
    final httpRpc = RPCHttpService("https://bsc-testnet.drpc.org/");
    // Initialize an HTTP RPC service for interacting with the Binance Smart Chain (BSC) testnet.

    /// WebSocket RPC Service
    final websocketRpc = await RPCWebSocketService.connect(
        "wss://go.getblock.io/b9c91d92aaeb4e5ba2d4cca664ab708c",
        onEvents: (p0) {},
        onClose: (p0) {});
    // Establish a WebSocket RPC connection to the specified endpoint for real-time updates.

    /// Ethereum RPC
    final rpc = EVMRPC(httpRpc);
    // Create an Ethereum RPC instance using the HTTP RPC service.

    /// Get Balance
    final balance = await rpc.request(RPCGetBalance(
        address:
            ETHAddress("0x7Fbb78c66505876284a49Ad89BEE3df2e0B7ca5E").address));
    // Request the balance of a specific Ethereum address using the RPC service.

    /// Get Block
      final block = await rpc
          .request(RPCGetBlockByNumber(blockNumber: BlockTagOrNumber.latest));
    // Request information about the latest Ethereum block using the RPC service.

    /// Contract Call
    final call =
        await rpc.request(RPCCall.fromRaw(contractAddress: ".....", raw: "raw"));
    // Make a contract call using the RPC service, specifying the contract address and raw data.

    /// Methods Reference
    /// Explore all available methods in the ethereum/rpc/methods/ directory.
    /// These methods encapsulate various Ethereum RPC calls for convenient usage.
    }

    ```

  - Tron Full-Http node
    Explore over 90 classes to interact with the Tron HTTP node,
    ```
    /// Tron Provider Initialization
    final rpc = TronProvider(TronHTTPProvider(url: "https://api.trongrid.io"));
    // Initialize a Tron Provider using an HTTP endpoint to interact with the Tron blockchain.

    /// Get Account Information
    final accountInfo = await rpc.request(TronRequestGetAccount(
        address: TronAddress("TMcbQBuj5ATtm9feRiMp6QRd587hT7HHyU")));
    // Request detailed account information for the specified Tron address.

    /// Get Account Resource Information
    final accountResource = await rpc.request(TronRequestGetAccountResource(
      address: TronAddress("TMcbQBuj5ATtm9feRiMp6QRd587hT7HHyU")));
    // Retrieve resource-related information for the specified Tron address.

    /// Get Chain Parameters
    final chainParameters = await rpc.request(TronRequestGetChainParameters());
    // Fetch parameters specific to the Tron blockchain.

    /// Get Latest Block Information
    final block = await rpc.request(TronRequestGetNowBlock());
    ```


## Contributing

Contributions are welcome! Please follow these guidelines:
 - Fork the repository and create a new branch.
 - Make your changes and ensure tests pass.
 - Submit a pull request with a detailed description of your changes.

## Feature requests and bugs #

Please file feature requests and bugs in the issue tracker.


