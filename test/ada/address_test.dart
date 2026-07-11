import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/ada.dart';
import 'package:test/test.dart';

void main() {
  group('addresses', () {
    _byron();
    _shelly();
  });
}

void _byron() {
  test('Byron testnetPreprod', () {
    final byron = ADAByronAddress(
      'KjgoiXJS2coTnqpCLHXFtd89Hv9ttjsE6yW4msyLXFNkykUpTsyBs85r2rDDia2uKrhdpGKCJnmFXwvPSWLe75564ixZWdTxRh7TnuaDLnHx',
    );
    final decode = ADAByronAddress.deserialize(byron.toCbor().as());
    expect(
      BytesUtils.toHexString(byron.attributeSerialize()),
      'a201581e581cfc15b0b8bb8d0e5f9f7a01c0477b47bd32e10aea16046fad41e56c2c024101',
    );
    expect(decode.address, byron.address);
    expect(decode.network, ADANetwork.testnetPreprod);
    expect(
      decode.bech32Address,
      'addr_test1stvpskz9sdvpca5q87fsveqf3600axweryz7dntnj08296rv5tknu74sj23qzkq7tqw0c9dshzac6rjlnaaqrsz80drm6vhppt4pvpr044q72mpvqfqszqq6ygskuqcnwnent',
    );
    expect(
      byron,
      ADAAddress.deserializeIAddress(bytes: byron.encodeAsIAddress()),
    );
  });
  test('byrom mainnet_2', () {
    final byron = ADAByronAddress(
      'Ae2tdPwUPEZ4YjgvykNpoFeYUxoyhNj2kg8KfKWN2FizsSpLUPv68MpTVDo',
    );
    final decode = ADAByronAddress.deserialize(byron.toCbor().as());
    expect(BytesUtils.toHexString(byron.attributeSerialize()), 'a0');
    expect(decode.address, byron.address);
    expect(decode.network, ADANetwork.mainnet);
    expect(
      decode.bech32Address,
      'addr1stvpskppsdvpcnv5w5qaazp0vnd6gakrg24udvce0xlper865q05yjc80xsqqxjqshtfvvnugpx',
    );
    expect(
      byron,
      ADAAddress.deserializeIAddress(bytes: byron.encodeAsIAddress()),
    );
  });
  test('byron testnet_3', () {
    final byron = ADAByronAddress(
      '2cWKMJemoBaipzQe9BArYdo2iPUfJQdZAjm4iCzDA1AfNxJSTgm9FZQTmFCYhKkeYrede',
    );
    final decode = ADAByronAddress.deserialize(byron.toCbor().as());
    expect(
      BytesUtils.toHexString(byron.attributeSerialize()),
      'a102451a4170cb17',
    );
    expect(decode.address, byron.address);
    expect(decode.network, ADANetwork.testnet);
    expect(
      decode.bech32Address,
      'addr_test1stvpskpgsdvpcewkhhcnc6lkmgah6004km90dwe47jy0e5ynhqw7fqkls7ssy3g6g9cvk9cqrg6u9k8e7fgu5t',
    );
    expect(
      byron,
      ADAAddress.deserializeIAddress(bytes: byron.encodeAsIAddress()),
    );
  });
  test('byron testnet_4', () {
    final byron = ADAByronAddress(
      '2cWKMJemoBaipzQe9BArYdo2iPUfJQdZAjm4iCzDA1AfNxJSTgm9FZQTmFCYhKkeYrede',
    );
    final decode = ADAAddress.deserialize(byron.toCbor().as());
    expect(
      BytesUtils.toHexString(byron.attributeSerialize()),
      'a102451a4170cb17',
    );
    expect(decode.address, byron.address);
    expect(decode.network, ADANetwork.testnet);
    expect(
      byron,
      ADAAddress.deserializeIAddress(bytes: byron.encodeAsIAddress()),
    );
  });
  test('byron redemption mainnet', () {
    final byron = ADAByronAddress(
      'Ae2tdPwUPEZ3MHKkpT5Bpj549vrRH7nBqYjNXnCV8G2Bc2YxNcGHEa8ykDp',
    );
    final decode = ADAAddress.deserialize(byron.toCbor().as());
    expect(BytesUtils.toHexString(byron.attributeSerialize()), 'a0');
    expect(byron.extendedAddress.payload.type, ADAByronAddrTypes.redemption);
    expect(
      byron.bech32Address,
      'addr1stvpskppsdvpcsv5r57g6w5sleyn2pgffcugl2qze4wsgw4dm9eqv6mygjsqyxsf475qxec7dra',
    );
    expect(decode.address, byron.address);
    expect(
      byron,
      ADAAddress.deserializeIAddress(bytes: byron.encodeAsIAddress()),
    );
  });
  test('byron icarus mainnet', () {
    final bip32 = CardanoIcarusBip32.fromSeed(_entropy2);
    final spend = bip32.derivePath("44'/1815'/0'/0/0");
    final byron = ADAByronAddress.fromPublicKey(
      chaincode: spend.publicKey.chainCode.toBytes(),
      publicKey: spend.publicKey.compressed,
      network: ADANetwork.mainnet,
    );

    expect(
      byron.address,
      'Ae2tdPwUPEZHtBmjZBF4YpMkK9tMSPTE2ADEZTPN97saNkhG78TvXdp3GDk',
    );
    final decode = ADAAddress.deserialize(byron.toCbor().as());
    expect(decode.address, byron.address);
    expect(
      byron,
      ADAAddress.deserializeIAddress(bytes: byron.encodeAsIAddress()),
    );
  });
}

void _shelly() {
  test('base address', () {
    final bip32 = CardanoIcarusBip32.fromSeed(_entropy);
    final spend = bip32.derivePath("1852'/1815'/0'/0/0");
    final stake = bip32.derivePath("1852'/1815'/0'/2/0");
    ADABaseAddress addr = ADABaseAddress.fromPublicKey(
      basePubkeyBytes: spend.publicKey.compressed,
      stakePubkeyBytes: stake.publicKey.compressed,
      network: ADANetwork.testnet,
    );
    expect(
      addr.address,
      'addr_test1qz2fxv2umyhttkxyxp8x0dlpdt3k6cwng5pxj3jhsydzer3jcu5d8ps7zex2k2xt3uqxgjqnnj83ws8lhrn648jjxtwq2ytjqp',
    );
    addr = ADABaseAddress.fromPublicKey(
      basePubkeyBytes: spend.publicKey.compressed,
      stakePubkeyBytes: stake.publicKey.compressed,
      network: ADANetwork.mainnet,
    );
    expect(
      addr.address,
      'addr1qx2fxv2umyhttkxyxp8x0dlpdt3k6cwng5pxj3jhsydzer3jcu5d8ps7zex2k2xt3uqxgjqnnj83ws8lhrn648jjxtwqfjkjv7',
    );
    final decode = ADAAddress.fromBytes(addr.serialize());
    expect(decode.address, addr.address);
    expect(decode.network, addr.network);
    expect(
      addr,
      ADAAddress.deserializeIAddress(bytes: addr.encodeAsIAddress()),
    );
  });
  test('base address 2', () {
    final bip32 = CardanoIcarusBip32.fromSeed(_entropy2);
    final spend = bip32.derivePath("1852'/1815'/0'/0/0");
    final stake = bip32.derivePath("1852'/1815'/0'/2/0");
    ADABaseAddress addr = ADABaseAddress.fromPublicKey(
      basePubkeyBytes: spend.publicKey.compressed,
      stakePubkeyBytes: stake.publicKey.compressed,
      network: ADANetwork.testnet,
    );
    expect(
      addr.address,
      'addr_test1qpu5vlrf4xkxv2qpwngf6cjhtw542ayty80v8dyr49rf5ewvxwdrt70qlcpeeagscasafhffqsxy36t90ldv06wqrk2qum8x5w',
    );
    {
      final differTestnetNetwork = ADABaseAddress(
        addr.address,
        network: ADANetwork.testnetPreprod,
      );
      expect(differTestnetNetwork.network, ADANetwork.testnetPreprod);
      expect(addr.address, differTestnetNetwork.address);
    }
    {
      final differTestnetNetwork = ADABaseAddress(
        addr.address,
        network: ADANetwork.testnetPreview,
      );
      expect(differTestnetNetwork.network, ADANetwork.testnetPreview);
      expect(addr.address, differTestnetNetwork.address);
    }
    addr = ADABaseAddress.fromPublicKey(
      basePubkeyBytes: spend.publicKey.compressed,
      stakePubkeyBytes: stake.publicKey.compressed,
      network: ADANetwork.mainnet,
    );
    expect(
      addr.address,
      'addr1q9u5vlrf4xkxv2qpwngf6cjhtw542ayty80v8dyr49rf5ewvxwdrt70qlcpeeagscasafhffqsxy36t90ldv06wqrk2qld6xc3',
    );
    final decode = ADAAddress.fromBytes(addr.serialize());
    expect(decode.address, addr.address);
    expect(decode.network, addr.network);
    expect(
      addr,
      ADAAddress.deserializeIAddress(bytes: addr.encodeAsIAddress()),
    );
  });
  test('Enterprise address', () {
    final bip32 = CardanoIcarusBip32.fromSeed(_entropy);
    final spend = bip32.derivePath("1852'/1815'/0'/0/0");
    ADAEnterpriseAddress addr = ADAEnterpriseAddress.fromPublicKey(
      pubkeyBytes: spend.publicKey.compressed,
      network: ADANetwork.testnet,
    );
    expect(
      addr.address,
      'addr_test1vz2fxv2umyhttkxyxp8x0dlpdt3k6cwng5pxj3jhsydzerspjrlsz',
    );
    {
      final differTestnetNetwork = ADAAddress.fromAddress(
        addr.address,
        network: ADANetwork.testnetPreprod,
      );
      expect(differTestnetNetwork.network, ADANetwork.testnetPreprod);
      expect(addr.address, differTestnetNetwork.address);
      expect(addr.addressType, ADAAddressType.enterprise);
    }
    {
      final differTestnetNetwork = ADAAddress.fromAddress(
        addr.address,
        network: ADANetwork.testnetPreview,
      );
      expect(differTestnetNetwork.network, ADANetwork.testnetPreview);
      expect(addr.address, differTestnetNetwork.address);
      expect(addr.addressType, ADAAddressType.enterprise);
      expect(
        () => ADAAddress.fromAddress(addr.address, network: ADANetwork.mainnet),
        throwsA(isA<ADAPluginException>()),
      );
    }
    {
      final differTestnetNetwork = ADAAddress.fromRawBytes(
        addr.toBytes(),
        network: ADANetwork.testnetPreview,
      );
      expect(differTestnetNetwork.network, ADANetwork.testnetPreview);
    }
    addr = ADAEnterpriseAddress.fromPublicKey(
      pubkeyBytes: spend.publicKey.compressed,
      network: ADANetwork.mainnet,
    );
    expect(
      addr.address,
      'addr1vx2fxv2umyhttkxyxp8x0dlpdt3k6cwng5pxj3jhsydzers66hrl8',
    );
    final decode = ADAAddress.fromBytes(addr.serialize());
    expect(decode.address, addr.address);
    expect(decode.network, addr.network);
    expect(
      addr,
      ADAAddress.deserializeIAddress(bytes: addr.encodeAsIAddress()),
    );
  });
  test('Enterprise address 2', () {
    final bip32 = CardanoIcarusBip32.fromSeed(_entropy2);
    final spend = bip32.derivePath("1852'/1815'/0'/0/0");
    ADAEnterpriseAddress addr = ADAEnterpriseAddress.fromPublicKey(
      pubkeyBytes: spend.publicKey.compressed,
      network: ADANetwork.testnet,
    );
    expect(
      addr.address,
      'addr_test1vpu5vlrf4xkxv2qpwngf6cjhtw542ayty80v8dyr49rf5eg57c2qv',
    );
    addr = ADAEnterpriseAddress.fromPublicKey(
      pubkeyBytes: spend.publicKey.compressed,
      network: ADANetwork.mainnet,
    );
    expect(
      addr.address,
      'addr1v9u5vlrf4xkxv2qpwngf6cjhtw542ayty80v8dyr49rf5eg0kvk0f',
    );
    final decode = ADAAddress.fromBytes(addr.serialize());
    expect(decode.address, addr.address);
    expect(decode.network, addr.network);
    expect(
      addr,
      ADAAddress.deserializeIAddress(bytes: addr.encodeAsIAddress()),
    );
  });
  test('Ada pointer address', () {
    final bip32 = CardanoIcarusBip32.fromSeed(_entropy);
    final spend = bip32.derivePath("1852'/1815'/0'/0/0");
    ADAPointerAddress addr = ADAPointerAddress.fromPublicKey(
      pubkeyBytes: spend.publicKey.compressed,
      network: ADANetwork.testnet,
      pointer: Pointer(
        slot: BigInt.one,
        txIndex: BigInt.two,
        certIndex: BigInt.from(3),
      ),
    );
    expect(
      addr.address,
      'addr_test1gz2fxv2umyhttkxyxp8x0dlpdt3k6cwng5pxj3jhsydzerspqgpsqe70et',
    );
    {
      final differTestnetNetwork = ADAAddress.fromAddress(
        addr.address,
        network: ADANetwork.testnetPreview,
      );
      expect(differTestnetNetwork.network, ADANetwork.testnetPreview);
      expect(addr.address, differTestnetNetwork.address);
      expect(addr.addressType, ADAAddressType.pointer);
      expect(
        () => ADAAddress.fromAddress(addr.address, network: ADANetwork.mainnet),
        throwsA(isA<ADAPluginException>()),
      );
    }
    {
      final differTestnetNetwork = ADAAddress.fromRawBytes(
        addr.toBytes(),
        network: ADANetwork.testnetPreview,
      );
      expect(differTestnetNetwork.network, ADANetwork.testnetPreview);
    }
    addr = ADAPointerAddress.fromPublicKey(
      pubkeyBytes: spend.publicKey.compressed,
      network: ADANetwork.mainnet,
      pointer: Pointer(
        slot: BigInt.from(24157),
        txIndex: BigInt.from(177),
        certIndex: BigInt.from(42),
      ),
    );
    expect(
      addr.address,
      'addr1gx2fxv2umyhttkxyxp8x0dlpdt3k6cwng5pxj3jhsydzer5ph3wczvf2w8lunk',
    );
    final ADAPointerAddress decode = ADAAddress.fromBytes(addr.serialize());
    expect(decode.address, addr.address);
    expect(decode.network, addr.network);
    expect(decode.pointer.certIndex, BigInt.from(42));
    expect(decode.pointer.txIndex, BigInt.from(177));
    expect(decode.pointer.slot, BigInt.from(24157));
    expect(
      addr,
      ADAAddress.deserializeIAddress(bytes: addr.encodeAsIAddress()),
    );
  });
  test('pointer address 3', () {
    final ADAPointerAddress ada = ADAAddress.fromAddress(
      'addr_test1grqe6lg9ay8wkcu5k5e38lne63c80h3nq6xxhqfmhewf645pllllllllllll7lupllllllllllll7lupllllllllllll7lc9wayvj',
    );

    expect(ada.pointer.certIndex, BigInt.parse('18446744073709551615'));
    expect(ada.pointer.slot, BigInt.parse('18446744073709551615'));
    expect(ada.pointer.txIndex, BigInt.parse('18446744073709551615'));
    expect(ada, ADAAddress.deserializeIAddress(bytes: ada.encodeAsIAddress()));
  });
  test('Ada pointer address 2', () {
    final bip32 = CardanoIcarusBip32.fromSeed(_entropy2);
    final spend = bip32.derivePath("1852'/1815'/0'/0/0");
    ADAPointerAddress addr = ADAPointerAddress.fromPublicKey(
      pubkeyBytes: spend.publicKey.compressed,
      network: ADANetwork.testnet,
      pointer: Pointer(
        slot: BigInt.one,
        txIndex: BigInt.two,
        certIndex: BigInt.from(3),
      ),
    );
    expect(
      addr.address,
      'addr_test1gpu5vlrf4xkxv2qpwngf6cjhtw542ayty80v8dyr49rf5egpqgpsdhdyc0',
    );
    final ADAPointerAddress decode = ADAAddress.fromBytes(addr.serialize());
    expect(decode.address, addr.address);
    expect(decode.network, addr.network);
    expect(decode.pointer.certIndex, BigInt.from(3));
    expect(decode.pointer.txIndex, BigInt.two);
    expect(decode.pointer.slot, BigInt.one);

    addr = ADAPointerAddress.fromPublicKey(
      pubkeyBytes: spend.publicKey.compressed,
      network: ADANetwork.mainnet,
      pointer: Pointer(
        slot: BigInt.from(24157),
        txIndex: BigInt.from(177),
        certIndex: BigInt.from(42),
      ),
    );
    expect(
      addr.address,
      'addr1g9u5vlrf4xkxv2qpwngf6cjhtw542ayty80v8dyr49rf5evph3wczvf2kd5vam',
    );
    expect(
      addr,
      ADAAddress.deserializeIAddress(bytes: addr.encodeAsIAddress()),
    );
  });
  test('Reward address', () {
    final bip32 = CardanoIcarusBip32.fromSeed(_entropy);
    final spend = bip32.derivePath("1852'/1815'/0'/2/0");
    ADARewardAddress addr = ADARewardAddress.fromPublicKey(
      pubkeyBytes: spend.publicKey.compressed,
      network: ADANetwork.testnet,
    );
    expect(
      addr.address,
      'stake_test1uqevw2xnsc0pvn9t9r9c7qryfqfeerchgrlm3ea2nefr9hqp8n5xl',
    );
    {
      final differTestnetNetwork = ADAAddress.fromAddress(
        addr.address,
        network: ADANetwork.testnetPreview,
      );
      expect(differTestnetNetwork.network, ADANetwork.testnetPreview);
      expect(addr.address, differTestnetNetwork.address);
      expect(addr.addressType, ADAAddressType.reward);
      expect(
        () => ADAAddress.fromAddress(addr.address, network: ADANetwork.mainnet),
        throwsA(isA<ADAPluginException>()),
      );
    }
    addr = ADARewardAddress.fromPublicKey(
      pubkeyBytes: spend.publicKey.compressed,
      network: ADANetwork.mainnet,
    );
    expect(
      addr.address,
      'stake1uyevw2xnsc0pvn9t9r9c7qryfqfeerchgrlm3ea2nefr9hqxdekzz',
    );
    final decode = ADAAddress.fromBytes(addr.serialize());
    expect(decode.address, addr.address);
    expect(decode.network, addr.network);
    expect(
      addr,
      ADAAddress.deserializeIAddress(bytes: addr.encodeAsIAddress()),
    );
  });
  test('multisig base address', () {
    final bip32 = CardanoIcarusBip32.fromSeed(_entropy3);
    final spend = bip32.derivePath("1852'/1815'/0'/0/0");
    final keyHash = Ed25519KeyHash.fromPubkey(spend.publicKey.compressed);

    final List<NativeScript> scripts = [NativeScriptScriptPubkey(keyHash)];
    final oneOfNativeScript = NativeScriptScriptNOfK(
      n: 1,
      nativeScripts: scripts,
    );
    final scriptHash = oneOfNativeScript.toHash();

    ADABaseAddress addr = ADABaseAddress.fromCredential(
      baseCredential: CredentialScript(scriptHash.data),
      stakeCredential: CredentialScript(scriptHash.data),
      network: ADANetwork.testnet,
    );
    expect(
      addr.address,
      'addr_test1xr0de0mz3m9xmgtlmqqzu06s0uvfsczskdec8k7v4jhr7077mjlk9rk2dkshlkqq9cl4qlccnps9pvmns0duet9w8uls8flvxc',
    );
    addr = ADABaseAddress.fromCredential(
      baseCredential: CredentialScript(scriptHash.data),
      stakeCredential: CredentialScript(scriptHash.data),
    );
    expect(
      addr.address,
      'addr1x80de0mz3m9xmgtlmqqzu06s0uvfsczskdec8k7v4jhr7077mjlk9rk2dkshlkqq9cl4qlccnps9pvmns0duet9w8ulsylzv28',
    );
    final decode = ADAAddress.fromBytes(addr.serialize());
    expect(decode.address, addr.address);
    expect(decode.network, addr.network);
  });
}

final List<int> _entropy = [
  0xdf,
  0x9e,
  0xd2,
  0x5e,
  0xd1,
  0x46,
  0xbf,
  0x43,
  0x33,
  0x6a,
  0x5d,
  0x7c,
  0xf7,
  0x39,
  0x59,
  0x94,
];
final List<int> _entropy2 = [
  0x0c,
  0xcb,
  0x74,
  0xf3,
  0x6b,
  0x7d,
  0xa1,
  0x64,
  0x9a,
  0x81,
  0x44,
  0x67,
  0x55,
  0x22,
  0xd4,
  0xd8,
  0x09,
  0x7c,
  0x64,
  0x12,
];
final List<int> _entropy3 = [
  0x4e,
  0x82,
  0x8f,
  0x9a,
  0x67,
  0xdd,
  0xcf,
  0xf0,
  0xe6,
  0x39,
  0x1a,
  0xd4,
  0xf2,
  0x6d,
  0xdb,
  0x75,
  0x79,
  0xf5,
  0x9b,
  0xa1,
  0x4b,
  0x6d,
  0xd4,
  0xba,
  0xf6,
  0x3d,
  0xcf,
  0xdb,
  0x9d,
  0x24,
  0x20,
  0xda,
];
