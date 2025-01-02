import 'dart:convert';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('serializ contract', () {
    final ownerAddress = TronAddress('TMcbQBuj5ATtm9feRiMp6QRd587hT7HHyU');
    final contract = AccountUpdateContract(
      ownerAddress: ownerAddress,
      accountName: utf8.encode('MRTNETWORK'),
    );
    expect(contract.toHex,
        '0a0a4d52544e4554574f524b1215417fbb78c66505876284a49ad89bee3df2e0b7ca5e');
  });
  test('serialize freezversion2', () {
    final ownerAddress = TronAddress('TMcbQBuj5ATtm9feRiMp6QRd587hT7HHyU');
    final contract = FreezeBalanceV2Contract(
        ownerAddress: ownerAddress,
        frozenBalance: TronHelper.toSun('3.5'),
        resource: ResourceCode.energy);
    expect(contract.toHex,
        '0a15417fbb78c66505876284a49ad89bee3df2e0b7ca5e10e0cfd5011801');
  });
  test('serialize unfreez balanceV2', () {
    final ownerAddress = TronAddress('TMcbQBuj5ATtm9feRiMp6QRd587hT7HHyU');
    final contract = UnfreezeBalanceV2Contract(
      ownerAddress: ownerAddress,
      unfreezeBalance: TronHelper.toSun('1.2'),
    );
    expect(contract.toHex,
        '0a15417fbb78c66505876284a49ad89bee3df2e0b7ca5e10809f49');
  });
  test('serialize fully transfer transaction', () {
    final ownerAddress = TronAddress('TMcbQBuj5ATtm9feRiMp6QRd587hT7HHyU');
    final toAddress = TronAddress('TF3cDajEAaJ8jFXFB2KF3XSUbTpZWzuSrp');
    final contract = TransferContract(
        ownerAddress: ownerAddress,
        toAddress: toAddress,
        amount: TronHelper.toSun('1'));
    final any = Any(typeUrl: contract.typeURL, value: contract);
    final transactionContract =
        TransactionContract(type: contract.contractType, parameter: any);
    final rawTr = TransactionRaw(
        refBlockBytes: BytesUtils.fromHexString('3453'),
        refBlockHash: BytesUtils.fromHexString('cb28dee9a3e77b2d'),
        expiration: BigInt.from(1704206303296),
        contract: [transactionContract],
        feeLimit: TronHelper.toSun('10'),
        data: utf8.encode('https://github.com/mrtnetwork'),
        timestamp: BigInt.from(1704163098000));
    expect(rawTr.toHex,
        '0a0234532208cb28dee9a3e77b2d40c080f2d4cc31521d68747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b5a67080112630a2d747970652e676f6f676c65617069732e636f6d2f70726f746f636f6c2e5472616e73666572436f6e747261637412320a15417fbb78c66505876284a49ad89bee3df2e0b7ca5e12154137adac2502fd8a6f9c2856423068be3760214cf918c0843d7090fba4c0cc31900180ade204');
  });
  test('serialize fully create new account transaction', () {
    final ownerAddress = TronAddress('TMcbQBuj5ATtm9feRiMp6QRd587hT7HHyU');
    final accountToCreate = TronAddress('TEZ98gFyVsnNMfDYzEuyUoxAVuEwzk3HRY');
    final contract = AccountCreateContract(
        ownerAddress: ownerAddress,
        accountAddress: accountToCreate,
        type: AccountType.contract);
    final any = Any(typeUrl: contract.typeURL, value: contract);
    final transactionContract =
        TransactionContract(type: contract.contractType, parameter: any);
    final rawTr = TransactionRaw(
        refBlockBytes: BytesUtils.fromHexString('3501'),
        refBlockHash: BytesUtils.fromHexString('5b4c7310ae2abd4a'),
        expiration: BigInt.from(1704206823136),
        contract: [transactionContract],
        feeLimit: TronHelper.toSun('10'),
        data: utf8.encode('https://github.com/mrtnetwork'),
        timestamp: BigInt.from(1704163620000));
    expect(rawTr.toHex,
        '0a02350122085b4c7310ae2abd4a40e0dd91d5cc31521d68747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b5a6812660a32747970652e676f6f676c65617069732e636f6d2f70726f746f636f6c2e4163636f756e74437265617465436f6e747261637412300a15417fbb78c66505876284a49ad89bee3df2e0b7ca5e121541324b6a9ccc7afa0f0009a7aa54ae67d8e63e4d0b180270a0e9c4c0cc31900180ade204');
  });
  test('serialize fully issue trc10', () {
    final ownerAddress = TronAddress('TMKmNTqGaJwhPGzn4UWEGJgzJRarz98aXL');
    final contract = AssetIssueContract(
        ownerAddress: ownerAddress,
        abbr: utf8.encode('MRTB2'),
        name: utf8.encode('MRTTRC101'),
        description: utf8.encode('TOKEN FOR FUN'),
        url: utf8.encode('https://github.com/mrtnetworks'),
        totalSupply: BigInt.from(30000000000000000),
        num: 5,
        frozenSupply: [
          AssetIssueContractFrozenSupply(
              frozenAmount: BigInt.from(1000000), frozenDays: BigInt.from(10))
        ],
        precision: 3,
        trxNum: 5,
        endTime: BigInt.from(1706756499781),
        startTime: BigInt.from(1704164559781));
    final any = Any(typeUrl: contract.typeURL, value: contract);
    final transactionContract =
        TransactionContract(type: contract.contractType, parameter: any);
    final rawTr = TransactionRaw(
        refBlockBytes: BytesUtils.fromHexString('3621'),
        refBlockHash: BytesUtils.fromHexString('1e7c2525a5d0ea27'),
        expiration: BigInt.from(1704207701347),
        contract: [transactionContract],
        feeLimit: TronHelper.toSun('10'),
        data: utf8.encode('https://github.com/mrtnetwork'),
        timestamp: BigInt.from(1704164496000));
    expect(rawTr.toHex,
        '0a02362122081e7c2525a5d0ea2740e3aac7d5cc31521d68747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b5ab701080612b2010a2f747970652e676f6f676c65617069732e636f6d2f70726f746f636f6c2e41737365744973737565436f6e7472616374127f0a15417c8cb921dcc4ea6a2fc4930c0e2394af31fda77c12094d52545452433130311a054d525442322080808cfaf49aa5352a0608c0843d100a30053803400548a597fec0cc3150c5d2f594d631a2010d544f4b454e20464f522046554eaa011e68747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b737080a5fac0cc31900180ade204');
  });
  test('serialize fully update issue trc10', () {
    final ownerAddress = TronAddress('TMKmNTqGaJwhPGzn4UWEGJgzJRarz98aXL');
    final contract = UpdateAssetContract(
        ownerAddress: ownerAddress,
        description: utf8.encode('MEAW :D'),
        url: utf8.encode('https://github.com/mrtnetworks'),
        newLimit: BigInt.from(100000),
        newPublicLimit: BigInt.from(50000));
    final any = Any(typeUrl: contract.typeURL, value: contract);
    final transactionContract =
        TransactionContract(type: contract.contractType, parameter: any);
    final rawTr = TransactionRaw(
        refBlockBytes: BytesUtils.fromHexString('368d'),
        refBlockHash: BytesUtils.fromHexString('9c7d6e12523ad77b'),
        expiration: BigInt.from(1704208022531),
        contract: [transactionContract],
        feeLimit: TronHelper.toSun('10'),
        data: utf8.encode('https://github.com/mrtnetwork'),
        timestamp: BigInt.from(1704164820000));
    expect(rawTr.toHex,
        '0a02368d22089c7d6e12523ad77b4083f8dad5cc31521d68747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b5a8001080f127c0a30747970652e676f6f676c65617069732e636f6d2f70726f746f636f6c2e5570646174654173736574436f6e747261637412480a15417c8cb921dcc4ea6a2fc4930c0e2394af31fda77c12074d454157203a441a1e68747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b7320a08d0628d0860370a0888ec1cc31900180ade204');
  });
  test('serialize fully transfer trc-10', () {
    final ownerAddress = TronAddress('TMKmNTqGaJwhPGzn4UWEGJgzJRarz98aXL');
    final contract = TransferAssetContract(
        ownerAddress: ownerAddress,
        toAddress: TronAddress('TE263xAUZrxuDwY8U4qouKsmYfywHbPwVN'),
        amount: BigInt.from(25000000),
        assetName: utf8.encode('1001452'));
    final any = Any(typeUrl: contract.typeURL, value: contract);
    final transactionContract =
        TransactionContract(type: contract.contractType, parameter: any);
    final rawTr = TransactionRaw(
        refBlockBytes: BytesUtils.fromHexString('3700'),
        refBlockHash: BytesUtils.fromHexString('81cdd58dadb24009'),
        expiration: BigInt.from(1704208374200),
        contract: [transactionContract],
        feeLimit: TronHelper.toSun('10'),
        data: utf8.encode('https://github.com/mrtnetwork'),
        timestamp: BigInt.from(1704165171000));
    expect(rawTr.toHex,
        '0a023700220881cdd58dadb2400940b8b3f0d5cc31521d68747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b5a76080212720a32747970652e676f6f676c65617069732e636f6d2f70726f746f636f6c2e5472616e736665724173736574436f6e7472616374123c0a07313030313435321215417c8cb921dcc4ea6a2fc4930c0e2394af31fda77c1a15412c6bf308a40c17fbdd4d65c2a55141b0528c9c5320c0f0f50b70b8bea3c1cc31900180ade204');
  });
  test('serialize fully ParticipateAssetIssueContract', () {
    final ownerAddress = TronAddress('TCFvmqhxFrEdPbnQzKWaGNdXz7X3za7w5r');
    final contract = ParticipateAssetIssueContract(
        ownerAddress: ownerAddress,
        toAddress: TronAddress('TMKmNTqGaJwhPGzn4UWEGJgzJRarz98aXL'),
        amount: BigInt.from(25),
        assetName: utf8.encode('1001452'));
    final any = Any(typeUrl: contract.typeURL, value: contract);
    final transactionContract =
        TransactionContract(type: contract.contractType, parameter: any);
    final rawTr = TransactionRaw(
        refBlockBytes: BytesUtils.fromHexString('3753'),
        refBlockHash: BytesUtils.fromHexString('aebf74db502f8583'),
        expiration: BigInt.from(1704208622699),
        contract: [transactionContract],
        feeLimit: TronHelper.toSun('10'),
        data: utf8.encode('https://github.com/mrtnetwork'),
        timestamp: BigInt.from(1704165420000));
    expect(rawTr.toHex,
        '0a0237532208aebf74db502f858340ebc8ffd5cc31521d68747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b5a7b080912770a3a747970652e676f6f676c65617069732e636f6d2f70726f746f636f6c2e506172746963697061746541737365744973737565436f6e747261637412390a15411919c6cbb89b7df009038afe38f48fb5e1b126311215417c8cb921dcc4ea6a2fc4930c0e2394af31fda77c1a0731303031343532201970e0d7b2c1cc31900180ade204');
  });
  test('serialize fully payable triggerSmartCotract with trx', () {
    final ownerAddress = TronAddress('TMcbQBuj5ATtm9feRiMp6QRd587hT7HHyU');
    final contract = TriggerSmartContract(
        ownerAddress: ownerAddress,
        contractAddress: TronAddress('TFXP3tb7MABUNLL2FqGFNjSwHP6gnQ7vrg'),
        callValue: TronHelper.toSun('10'),
        data: BytesUtils.fromHexString('b3240967'));
    final any = Any(typeUrl: contract.typeURL, value: contract);
    final transactionContract =
        TransactionContract(type: contract.contractType, parameter: any);
    final rawTr = TransactionRaw(
        refBlockBytes: BytesUtils.fromHexString('3be8'),
        refBlockHash: BytesUtils.fromHexString('0f9d69bec7c32111'),
        expiration: BigInt.from(1704169089000),
        contract: [transactionContract],
        feeLimit: TronHelper.toSun('25'),
        data: utf8.encode('https://github.com/mrtnetwork'),
        timestamp: BigInt.from(1704169031512));
    expect(rawTr.toHex,
        '0a023be822080f9d69bec7c3211140e8cf92c3cc31521d68747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b5a72081f126e0a31747970652e676f6f676c65617069732e636f6d2f70726f746f636f6c2e54726967676572536d617274436f6e747261637412390a15417fbb78c66505876284a49ad89bee3df2e0b7ca5e1215413cee53f968c1ed1413fd98c3e7feec609be8e4491880ade2042204b324096770d88e8fc3cc319001c0f0f50b');
  });
  test('serialize fully payable triggerSmartCotract with token value and trx',
      () {
    final ownerAddress = TronAddress('TMKmNTqGaJwhPGzn4UWEGJgzJRarz98aXL');
    final contract = TriggerSmartContract(
        ownerAddress: ownerAddress,
        contractAddress: TronAddress('TFXP3tb7MABUNLL2FqGFNjSwHP6gnQ7vrg'),
        callValue: TronHelper.toSun('10'),
        data: BytesUtils.fromHexString('0f3ecc64'),
        callTokenValue: BigInt.from(25000000),
        tokenId: BigInt.from(1001452));
    final any = Any(typeUrl: contract.typeURL, value: contract);
    final transactionContract =
        TransactionContract(type: contract.contractType, parameter: any);
    final rawTr = TransactionRaw(
        refBlockBytes: BytesUtils.fromHexString('3d10'),
        refBlockHash: BytesUtils.fromHexString('da3b800cfc135b16'),
        expiration: BigInt.from(1704169989000),
        contract: [transactionContract],
        feeLimit: TronHelper.toSun('25'),
        data: utf8.encode('https://github.com/mrtnetwork'),
        timestamp: BigInt.from(1704169931910));
    expect(rawTr.toHex,
        '0a023d102208da3b800cfc135b164088c7c9c3cc31521d68747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b5a7b081f12770a31747970652e676f6f676c65617069732e636f6d2f70726f746f636f6c2e54726967676572536d617274436f6e747261637412420a15417c8cb921dcc4ea6a2fc4930c0e2394af31fda77c1215413cee53f968c1ed1413fd98c3e7feec609be8e4491880ade20422040f3ecc6428c0f0f50b30ec8f3d708689c6c3cc319001c0f0f50b');
  });
  test('serialize fully vote witness', () {
    final ownerAddress = TronAddress('TMcbQBuj5ATtm9feRiMp6QRd587hT7HHyU');
    final contract = VoteWitnessContract(ownerAddress: ownerAddress, votes: [
      VoteWitnessContractVote(
        voteAddress: TronAddress('TUi55uuhgWkj8cKdWiJS9ViqrycYL8Jewz'),
        voteCount: BigInt.from(1),
      ),
      VoteWitnessContractVote(
        voteAddress: TronAddress('TKxbe4UiGtoYV11t73PMzRYTXtACYM8cVB'),
        voteCount: BigInt.from(1),
      ),
      VoteWitnessContractVote(
        voteAddress: TronAddress('TX8QA6WWvfa3r4JagzoqrS4kxDGSC17DCz'),
        voteCount: BigInt.from(1),
      ),
      VoteWitnessContractVote(
        voteAddress: TronAddress('TSPFGdtTLe2JYGe4iDQ5Nfmc6SFwABx7Ef'),
        voteCount: BigInt.from(1),
      ),
    ]);
    final any = Any(typeUrl: contract.typeURL, value: contract);
    final transactionContract =
        TransactionContract(type: contract.contractType, parameter: any);
    final rawTr = TransactionRaw(
        refBlockBytes: BytesUtils.fromHexString('3f86'),
        refBlockHash: BytesUtils.fromHexString('96a55a5c6ef64070'),
        expiration: BigInt.from(1704214987782),
        contract: [transactionContract],
        feeLimit: TronHelper.toSun('10'),
        data: utf8.encode('https://github.com/mrtnetwork'),
        timestamp: BigInt.from(1704171783000));
    expect(rawTr.toHex,
        '0a023f86220896a55a5c6ef6407040868884d9cc31521d68747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b5abd01080412b8010a30747970652e676f6f676c65617069732e636f6d2f70726f746f636f6c2e566f74655769746e657373436f6e74726163741283010a15417fbb78c66505876284a49ad89bee3df2e0b7ca5e12190a1541cd8d8ad1b4a5bd7afe46949421d2b411a3601717100112190a15416d93bd35508007a45a1c7cdb8b982e70bf391775100112190a1541e817b29047a50558cc8f5e97c5bb99d4723cbaa2100112190a1541b40de3abd90961539517d57d0f79f477072ebda0100170d886b7c4cc31900180ade204');
  });
}
