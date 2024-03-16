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

### Solana

Delve confidently into the Solana blockchain ecosystem with the Onchain Plugin for Dart, your gateway to seamless integration with Solana's powerful network. Empower your Dart applications to navigate the Solana landscape with ease, from account creation to asset transfers and execution of a diverse range of smart contracts. Uncover the full potential of Solana's network, harnessing its scalability and performance to drive innovation and growth in your projects. Explore the multitude of Solana contracts, including smart contracts, and unlock new possibilities for your Dart applications to flourish within the dynamic Solana blockchain ecosystem.

- Transaction: Versioned Transaction Generation, Serialization, and Deserialization.

- Sign: Effortlessly Sign Transactions

- Instructions: The plugin offers numerous pre-built instructions, simplifying the process of creating your own transactions. Here are some examples:
  
  - addressLockupTable
  - associatedTokenAccount
  - computeBudget
  - ed25519
  - memo
  - nameService
  - secp256k1
  - splToken
  - splTokenMetaData
  - splTokenSwap
  - stake
  - stakePool
  - system
  - tokenLending
  - vote
  - Metaplex
    - auctionHouse
    - auctioneer
    - bubblegum
    - candyMachineCore
    - fixedPriceSale
    - gumdrop
    - hydra
    - nftPacks
    - tokenEntangler
    - tokenMetaData

- Custom Programs: The plugin facilitates the Solana Buffer layout structure, enabling effortless encoding and decoding of pertinent data

### Cardano

Dive confidently into the Cardano blockchain ecosystem with "on_chain" - your gateway to seamless integration with Cardano's powerful network. Empower your Dart applications to navigate the Cardano landscape with ease, from account creation to asset transfers and execution of a diverse range of smart contracts. Uncover the full potential of Cardano's network, harnessing its scalability and performance to drive innovation and growth in your projects. Explore the multitude of Cardano contracts, including smart contracts, and unlock new possibilities for your Dart applications to flourish within the dynamic Cardano blockchain ecosystem.

- Transaction: Generate and construct Cardano transactions across both the Byron and Shelley eras. Serialization, and Deserialization.

- Sign: Effortlessly Sign Transactions

- Addresses: Comprehensive address support, base, reward, pointer, enterprise, as well as both Byron and legacy Byron formats.

- HD-Wallet: Seed generator for legacy and Icarus formats, alongside HD wallet management for both Shelley and Byron era

- Transactions: The plugin boasts extensive support for a variety of Cardano transactions. 
Here are some examples:

  - Mint
  - Plutus
  - NativeScripts
  - Certificate (Stake, Pool, MIR)
  - Metadata
  - Withdrawals

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


    /// Solana
    /// Initialize a Solana private key.
    final SolanaPrivateKey solanaPrivateKey = SolanaPrivateKey.fromSeedHex("...");

    /// Generate a cryptographic signature for a solana transaction serialized.
    final String solanaSign = solanaPrivateKey.sign("txDigestBytes");

    /// Obtain the corresponding Solana public key.
    final SolanaPublicKey solanaPublicKey = solanaPrivateKey.publicKey();

    /// Verify signature.
    final bool verifySignature =
        solanaPublicKey.verify("messageBytes", "signatureBytes");

    /// Derive the Solana address associated with the public key.
    final SolAddress solanaAddress = solanaPublicKey.toAddress();

    /// Cardano
    // Define a private key
    final privateKey = AdaPrivateKey.fromBytes(...);

    // Create a Byron address
    final byronAddress =
      ADAByronAddress.fromPublicKey(publicKey: ..., chaincode: ...);

    // Generate a legacy Byron address
    final byronLegacyAddress = ADAByronAddress.legacy(
        publicKey: .., chaincode: .., hdPathKey:.., hdPath: '');

    // Construct a Shelley base address
    final shellyBase = ADABaseAddress(
        "addr_test1qzkrh0ytcw257np6x6lxp74a6p4erj7rqt9azycnckgp2f27p5uc85frnln985tjn0xv8fmdv4t696d3j9zvu0ktx0gs62w8wv");

    // Formulate a Shelley reward address
    final shellyReward = ADARewardAddress("stake...");

    // Create a Shelley pointer address
    final shellyPointer = ADAPointerAddress.fromPublicKey(
        pubkeyBytes: ...Bip32KholawMstKeyGeneratorConst.masterKeyHmacKey,
       pointer: Pointer(slot: slot, txIndex: txIndex, certIndex: certIndex));

    // Define an enterprise address
    final enterpriseAddress = ADAEnterpriseAddress("...");
    ```
 
 ### Transaction

  - Ethreum transaction

    Check out all the examples at the provided [link](https://github.com/mrtnetwork/On_chain/tree/main/lib/ethereum/transaction).

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
    
    Check out all the examples at the provided [link](https://github.com/mrtnetwork/On_chain/tree/main/example/lib/example/contract).

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
    
    Check out all the examples at the provided [link](https://github.com/mrtnetwork/On_chain/tree/main/example/lib/example/tron/transactions/smart_contract).

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
    
    Check out all the examples at the provided [link](https://github.com/mrtnetwork/On_chain/tree/main/example/lib/example/tron/transactions).
    
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
  
  - Solana transaction
    
    Check out all the examples at the provided [link](https://github.com/mrtnetwork/On_chain/tree/main/example/lib/example/solana).
    
    Transfer SOL
    ```
    /// Set up the RPC service with the Solana devnet endpoint.
    final service = RPCHttpService("https://api.devnet.solana.com");

    /// Initialize the Solana RPC client.
    final rpc = SolanaRPC(service);

    /// Define the owner's private key and derive the owner's public key.
    final ownerPrivateKey = SolanaPrivateKey.fromSeedHex(
      "4e27902b3df33d7857dc9d218a3b34a6550e9c7621a6d601d06240a517d22017");
    final owner = ownerPrivateKey.publicKey().toAddress();

    /// Define the recipient's address.
    final receiver = SolAddress("9eaiUBgyT7EY1go2qrCmdRZMisYkGdtrrem3TgP9WSDb");

    /// Retrieve the latest block hash.
    final blockHash = await rpc.request(const SolanaRPCGetLatestBlockhash());

    /// Create a transfer instruction to move funds from the owner to the receiver.
    final transferInstruction = SystemProgram.transfer(
        from: owner,
        layout: SystemTransferLayout(lamports: SolanaUtils.toLamports("0.001")),
        to: receiver);

    /// Construct a Solana transaction with the transfer instruction.
    final transaction = SolanaTransaction(
        instructions: [transferInstruction],
        recentBlockhash: blockHash.blockhash,
        payerKey: owner,
        type: TransactionType.v0);

    /// Sign the transaction with the owner's private key.
    final ownerSignature = ownerPrivateKey.sign(transaction.serializeMessage());
    transaction.addSignature(owner, ownerSignature);

    /// Serialize the transaction.
    final serializedTransaction = transaction.serializeString();

    /// Send the transaction to the Solana network.
    await rpc.request(
      SolanaRPCSendTransaction(encodedTransaction: serializedTransaction));

    ```


  - Cardano Transaction
    Check out all the examples at the provided [link](https://github.com/mrtnetwork/On_chain/tree/main/example/lib/example/cardano).
    
    Transfer ADA
    ```
    /// Create a BIP32 derivation from a seed
    final bip32 = CardanoIcarusBip32.fromSeed(List<int>.filled(20, 12));

    /// Derive a spending key from the BIP32 derivation path
    final spend = bip32.derivePath("1852'/1815'/0'/0/0");

    /// Extract the private key from the spending key
    final privateKey = AdaPrivateKey.fromBytes(spend.privateKey.raw);

    /// Define the sender enterprise address
    ADAEnterpriseAddress addr = ADAEnterpriseAddress(
        "addr_test1vp0q6wvr6y3elejn69efhnxr5akk24azaxcez3xw8m9n85gmr5qny",
        network: ADANetwork.testnetPreprod);

    /// Define the receiver enterprise address
    ADAEnterpriseAddress receiver = ADAEnterpriseAddress(
        "addr_test1vp0q6wvr6y3elejn69efhnxr5akk24azaxcez3xw8m9n85gmr5qny",
        network: ADANetwork.testnetPreprod);

    /// Set up the Blockfrost provider
    final provider = BlockforestProvider(BlockforestHTTPProvider(
        url: "https://cardano-preprod.blockfrost.io/api/v0/",
        projectId: "preprodMVwzqm4PuBDBSfEULoMzoj5QZcy5o3z5"));

    /// Define transaction inputs and outputs
    final input = TransactionInput(
        transactionId: TransactionHash.fromHex(
            "6419830644a3310e8ddf55998154bd07afe9f4a73872b6dd4d39ac43ff59ad8c"),
        index: 0);
    final output = TransactionOutput(
        address: receiver, amount: Value(coin: ADAHelper.toLovelaces("1")));
    final change = TransactionOutput(
        address: addr,
       amount: Value(
          coin: ADAHelper.toLovelaces("10000") - ADAHelper.toLovelaces("1.2")));
    final fee = ADAHelper.toLovelaces("0.2");

    /// Construct the transaction body
    final body =
        TransactionBody(inputs: [input], outputs: [change, output], fee: fee);

    /// Create the ADA transaction with witness
    final transaction = ADATransaction(
        body: body,
       witnessSet: TransactionWitnessSet(vKeys: [
          privateKey.createSignatureWitness(body.toHash().data),
        ]));

    /// Submit the transaction via Blockfrost provider
    await provider.request(BlockfrostRequestSubmitTransaction(
        transactionCborBytes: transaction.serialize()));
    ```

### EIP712

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
### Solana-Specific
The plugin offers extensive support for pre-built programs, each comprising four key sections:

1. Layouts: These receive the desired data for each program and decode it for transaction processing.
2. Programs: These are responsible for generating instructions.
3. Account: This section manages accounts associated with the program.
4. RPC: Utilized for obtaining accounts linked to the program.
5. Utils: Provides various program utilities.

Example:
```
 /// Define the layout for initializing the candy machine.
  final initializeCandyMachineLayout =
      MetaplexCandyMachineInitializeCandyMachineLayout(
          data: CandyMachineData(
              itemsAvailable: BigInt.two,
              symbol: "MRT",
              sellerFeeBasisPoints: 100,
              maxSupply: BigInt.from(1000),
              isMutable: false,
              creators: [Creator(address: address, verified: true, share: 0)]));

  /// Find the mint counter PDA.
  final mint = MetaplexCandyMachineProgramUtils.findMintCounterPda(
      id: id, user: user, candyGuard: candyGuard, candyMachine: candyMachine);

  /// Initialize the candy machine.
  final instruction = MetaplexCandyMachineCoreProgram.initializeCandyMachine(
      candyMachine: candyMachine,
      authorityPda: authorityPda,
      authority: authority,
      payer: payer,
      collectionMetadata: collectionMetadata,
      collectionMint: collectionMint,
      collectionMasterEdition: collectionMasterEdition,
      collectionUpdateAuthority: collectionUpdateAuthority,
      collectionAuthorityRecord: collectionAuthorityRecord,
      tokenMetadataProgram: tokenMetadataProgram,
      layout: layout);

  /// Request the candy machine account information from the RPC.
  final CandyMachineAccount account =
      await rpc.request(SolanaRPCGetCandyMachineAccount(account: account));

  /// Extract the authority from the candy machine account.
  final authority = account.authority;

```


### JSON-RPC

  - Ethereum

    Discover the full spectrum of methods in the [link](https://github.com/mrtnetwork/On_chain/tree/main/lib/ethereum/src/rpc/methds).

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
    
    Discover the full spectrum of methods in the [link](https://github.com/mrtnetwork/On_chain/tree/main/lib/tron/src/provider/methods).
    
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
  - Solana RPC
    
    Discover the full spectrum of methods in the [link](https://github.com/mrtnetwork/On_chain/tree/main/lib/solana/src/rpc/methods).
    
    ```
    /// Initialize the Solana RPC client with the devnet endpoint.
    final service = SolanaRPC(RPCHttpService("https://api.devnet.solana.com"));

    /// Retrieve the account information for a specific address.
    final accountModel = await service.request(const SolanaRPCGetAccountInfo(
      account: SolAddress.unchecked(
          "527pWSWfeQGLM7SoyVXjCRkrSZBtDkH6ShEBJB3nUDkA")));

    /// Retrieve the account information for a specific address with context.
    final accountModelWithContext = await service.requestWithContext(
      const SolanaRPCGetAccountInfo(
          account: SolAddress.unchecked(
              "527pWSWfeQGLM7SoyVXjCRkrSZBtDkH6ShEBJB3nUDkA")));

    /// Retrieve the account information for a specific address and return as JSON.
    final accountResponseInJson = await service.requestDynamic(
        const SolanaRPCGetAccountInfo(
            account: SolAddress.unchecked(
                "527pWSWfeQGLM7SoyVXjCRkrSZBtDkH6ShEBJB3nUDkA")));
    ```
  - Cardano (blockfrost)
  
    Discover the full spectrum of methods in the [link](https://github.com/mrtnetwork/On_chain/tree/main/lib/ada/src/provider/blockfrost/methods).
    
    ```
    /// Set up the Blockfrost provider with the specified URL and project ID
    final provider = BlockforestProvider(BlockforestHTTPProvider(
      url: "https://cardano-preprod.blockfrost.io/api/v0/",
      projectId: "preprodMVwzqm4PuBDBSfEULoMzoj5QZcy5o3z5"));

    /// Retrieve UTXOs for a specific Cardano address
    final List<ADAAccountUTXOResponse> accountUtxos = await provider.request(
      BlockfrostRequestAddressUTXOs(ADAAddress.fromAddress(
          "addr_test1vp0q6wvr6y3elejn69efhnxr5akk24azaxcez3xw8m9n85gmr5qny")));

    /// Fetch the latest epoch's protocol parameters
    final ADAEpochParametersResponse protocolParams =
      await provider.request(BlockfrostRequestLatestEpochProtocolParameters());

    /// Get UTXOs associated with a specific transaction
    final ADATransactionUTXOSResponse transaction = await provider.request(
      BlockfrostRequestTransactionUTXOs(
          "69edd1c1c4fdc282e3fe1d90f368a228d7702316dc33e494e5bee7db81d6183b"));
    ```
### BIP-39, Addresses, and HD Wallet Key Management Process
```
  /// Generate a 12-word mnemonic phrase.
  final mnemonic =
      Bip39MnemonicGenerator().fromWordsNumber(Bip39WordsNum.wordsNum12);

  /// Generate a seed from the mnemonic phrase with a specific passphrase.
  final seed = Bip39SeedGenerator(mnemonic).generate("MRTNETWORK");

  /// Define the cryptocurrency coins.
  final solanaCoin = Bip44Coins.solana;
  final tronCoin = Bip44Coins.tron;
  final ethereumCoin = Bip44Coins.ethereum;

  /// Derive the default derivation paths for Solana, Tron, and Ethereum.
  final solanaDefaultPath = Bip44.fromSeed(seed, solanaCoin).deriveDefaultPath;
  final tronDefaultPath = Bip44.fromSeed(seed, tronCoin).deriveDefaultPath;
  final ethereumDefaultPath =
      Bip44.fromSeed(seed, ethereumCoin).deriveDefaultPath;

  /// Generate private keys for Solana, Tron, and Ethereum from their respective derivation paths.
  final solanaPrivateKey =
      SolanaPrivateKey.fromSeed(solanaDefaultPath.privateKey.raw);
  final tronPrivateKey =
      TronPrivateKey.fromBytes(tronDefaultPath.privateKey.raw);
  final ethereumPrivateKey =
      ETHPrivateKey.fromBytes(ethereumDefaultPath.privateKey.raw);
  
  
  /// Cardano
  /// Generate a mnemonic using 15 words
  final mnemonic =
      Bip39MnemonicGenerator().fromWordsNumber(Bip39WordsNum.wordsNum15);

  /// Generate seeds for Cardano Icarus and legacy Byron wallets using the mnemonic
  final seed = CardanoIcarusSeedGenerator(mnemonic.toStr()).generate();
  final legacySeed =
      CardanoByronLegacySeedGenerator(mnemonic.toStr()).generate();

  /// Create a CIP-1852 object from the seed for Cardano Icarus
  final cip1852 = Cip1852.fromSeed(seed, Cip1852Coins.cardanoIcarus);

  /// Initialize Cardano Shelley from the CIP-1852 object
  final shelly = CardanoShelley.fromCip1852Object(cip1852);

  /// Extract private keys for payment and stake from the Shelley wallet
  final payment = shelly.bip44.privateKey;
  final stake = shelly.bip44Sk.privateKey;

  /// Derive a BIP-44 wallet from the legacy seed for Cardano Byron Ledger
  final bip44 = Bip44.fromSeed(legacySeed, Bip44Coins.cardanoByronLedger);

  /// Create a Cardano Byron Legacy wallet from the legacy seed
  final byron = CardanoByronLegacy.fromSeed(legacySeed);

```



## Contributing

Contributions are welcome! Please follow these guidelines:
 - Fork the repository and create a new branch.
 - Make your changes and ensure tests pass.
 - Submit a pull request with a detailed description of your changes.

## Feature requests and bugs #

Please file feature requests and bugs in the issue tracker.


