import 'package:blockchain_utils/bip/address/p2pkh_addr.dart';
import 'package:on_chain/on_chain.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test("keys 1", () {
    final privateKey = TronPrivateKey(
        "8E3399B2E2F644302CAF24237DB80B89C2449F0C6A09C43912623186DB26DA68");
    final publicKey = privateKey.publicKey();
    final address = publicKey.toAddress();
    expect(publicKey.toHex(mode: PubKeyModes.uncompressed).toUpperCase(),
        "04A0AB41BB5AE610AF57FDA427B396D92D760194419993C0D6D99A94D58C5E0E310C05DDDB29F3CCC11C1E8853F2D72FFCD66F5BA7629C8E33042DBED9116A6979");
    expect(address.toString(), "TZGQapz7RjDt1JJcm814rbZZnoRvyGmMNY");
    expect(address.toAddress(false).toUpperCase(),
        "41FF8BA1FACC3D11FE98FCE25010317004ADF4961A");
  });
  test("keys 2", () {
    final privateKey = TronPrivateKey(
        "FF67892CCB0EA1456BCFB3AE89C4EA7822551BF203DF87B44C8A797AE8C397D6");
    final publicKey = privateKey.publicKey();
    final address = publicKey.toAddress();
    expect(publicKey.toHex(mode: PubKeyModes.uncompressed).toUpperCase(),
        "0488DCE5344108CE3AFAD8D024A2A8A4ECE308F0964626F55D05E730150F4C5B7A882110EDF8362EC1B577E680C5A54445367B1608E97FF139831602074AFB60AD");
    expect(address.toString(), "TC6CGE3UqVXwFjUfpnnydhxi9DviHY7V1a");
    expect(address.toAddress(false).toUpperCase(),
        "4117428BFCD8FBA0688310CF11A5197A4A44877EA7");
  });
  test("keys 3", () {
    final privateKey = TronPrivateKey(
        "3D0DF8303E6BA686BC114B3B1F5BAADBCE7D398D447BC71B7A4D8B6E231048AA");
    final publicKey = privateKey.publicKey();
    final address = publicKey.toAddress();
    expect(publicKey.toHex(mode: PubKeyModes.uncompressed).toUpperCase(),
        "04A7E15F82616519706E0510CD981FCB504777A9BDD4EECBD1C5E1B478A9A13ECE42A8E677675EB6842A7B6246A242072720495BF98FAFF57FD04B7B128C66EDEB");
    expect(address.toString(), "TW5dqkS9DyR5VUNHtMiHGvfTkvUHuFBqWp");
    expect(address.toAddress(false).toUpperCase(),
        "41DC99BF14DA4E005BE89EF542CB01575891381CB2");
  });
  test("keys 4", () {
    final privateKey = TronPrivateKey(
        "0DF402F65F72E37555F619787AADF08E98D5C84C5A292ACA7BACFDF4D52AB3A2");
    final publicKey = privateKey.publicKey();
    final address = publicKey.toAddress();
    expect(publicKey.toHex(mode: PubKeyModes.uncompressed).toUpperCase(),
        "0432E127F8D94445991126BA7F073022210FB79C5CB15CC1F0E0A3101010780341382C1C82925B38F71E62F0CD72BE00828D955B86EE41464742558FB34051684C");
    expect(address.toString(), "TMZmuvsQWdVm44syzkvahRcZysCnxw4jYR");
    expect(address.toAddress(false).toUpperCase(),
        "417F32FFDFF03DDB078371BCF0706E30C2E57FEA2D");
  });
}
