import 'package:on_chain/ada/ada.dart';
import 'package:test/test.dart';

void main() {
  group("description", () {
    _moveInstantaneousReward();
    _header();
    _headerBody();
  });
}

void _moveInstantaneousReward() {
  test("MoveInstantaneousReward", () {
    MoveInstantaneousReward reservesToPot = MoveInstantaneousReward(
        pot: MIRPot.treasury, variant: ToOtherPot(BigInt.from(143546464)));
    expect(reservesToPot.serializeHex(), "82011a088e5860");
    MoveInstantaneousReward decode =
        MoveInstantaneousReward.fromCborBytes(reservesToPot.serialize());
    expect(decode.serialize(), reservesToPot.serialize());
    reservesToPot = MoveInstantaneousReward(
        pot: MIRPot.treasury, variant: ToOtherPot(BigInt.zero));
    expect(reservesToPot.serializeHex(), "820100");
    decode = MoveInstantaneousReward.fromCborBytes(reservesToPot.serialize());
    expect(decode.serialize(), reservesToPot.serialize());
    final stake = MIRToStakeCredentials(
        {StakeCredScript(List<int>.filled(28, 54)): BigInt.from(-314159265)});
    reservesToPot =
        MoveInstantaneousReward(pot: MIRPot.treasury, variant: stake);
    expect(reservesToPot.serializeHex(),
        "8201a18201581c363636363636363636363636363636363636363636363636363636363a12b9b0a0");
    final mirDecode =
        MoveInstantaneousReward.fromCborBytes(reservesToPot.serialize());
    expect(mirDecode.serialize(), reservesToPot.serialize());
  });
}

List<int> _fakeBytes32(int first) {
  return [
    first,
    239,
    181,
    120,
    142,
    135,
    19,
    200,
    68,
    223,
    211,
    43,
    46,
    145,
    222,
    30,
    48,
    159,
    239,
    255,
    213,
    85,
    248,
    39,
    204,
    158,
    225,
    100,
    1,
    2,
    3,
    4
  ];
}

void _headerBody() {
  test("HeaderBody", () {
    final headerBody = HeaderBody(
        blockBodyHash: BlockHash(_fakeBytes32(4)),
        slot: BigInt.from(123),
        blockBodySize: 123456,
        blockNumber: 123,
        issuerKey: AdaPublicKey.fromHex(
            "e8dae31d3e915bfabf4322aca5489dc6efc4d210dd778342c15b1f62509f2e2a"),
        leaderCert: HeaderLeaderCertNonceAndLeader(
          nonceVrf: VRFCert(
            output: _fakeBytes32(4),
            proof: List<int>.filled(80, 1),
          ),
          leaderVrf: VRFCert(
            output: _fakeBytes32(5),
            proof: List<int>.filled(80, 2),
          ),
        ),
        operationalCert: OperationalCert(
            hotVkey: KESVKey(_fakeBytes32(5)),
            sequenceNumber: 123,
            kesPeriod: 456,
            sigma: Ed25519Signature(List<int>.filled(64, 6))),
        prevHash: BlockHash(_fakeBytes32(1)),
        protocolVersion: const ProtocolVersion(major: 12, minor: 13),
        vrfvKey: VRFVKey(_fakeBytes32(2)));
    expect(headerBody.serializeHex(),
        "8f187b187b582001efb5788e8713c844dfd32b2e91de1e309fefffd555f827cc9ee164010203045820e8dae31d3e915bfabf4322aca5489dc6efc4d210dd778342c15b1f62509f2e2a582002efb5788e8713c844dfd32b2e91de1e309fefffd555f827cc9ee1640102030482582004efb5788e8713c844dfd32b2e91de1e309fefffd555f827cc9ee164010203045850010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010182582005efb5788e8713c844dfd32b2e91de1e309fefffd555f827cc9ee16401020304585002020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202021a0001e240582004efb5788e8713c844dfd32b2e91de1e309fefffd555f827cc9ee16401020304582005efb5788e8713c844dfd32b2e91de1e309fefffd555f827cc9ee16401020304187b1901c85840060606060606060606060606060606060606060606060606060606060606060606060606060606060606060606060606060606060606060606060606060606060c0d");
    final decode = HeaderBody.fromCborBytes(headerBody.serialize());
    expect(decode.serialize(), headerBody.serialize());
  });
  test("HeaderBody_2", () {
    final headerBody = HeaderBody(
        blockBodyHash: BlockHash(_fakeBytes32(4)),
        slot: BigInt.from(123),
        blockBodySize: 123456,
        blockNumber: 123,
        issuerKey: AdaPublicKey.fromHex(
            "61519c127b42c58aa3bda284d4d5c9bd4b7d4f006e47540a3d7cc7bc3a8d6fa1"),
        leaderCert: HeaderLeaderCertVrfResult(VRFCert(
          output: _fakeBytes32(3),
          proof: List<int>.filled(80, 0),
        )),
        operationalCert: OperationalCert(
            hotVkey: KESVKey(_fakeBytes32(5)),
            sequenceNumber: 123,
            kesPeriod: 456,
            sigma: Ed25519Signature(List<int>.filled(64, 6))),
        prevHash: BlockHash(_fakeBytes32(1)),
        protocolVersion: const ProtocolVersion(major: 12, minor: 13),
        vrfvKey: VRFVKey(_fakeBytes32(2)));
    expect(headerBody.serializeHex(),
        "8f187b187b582001efb5788e8713c844dfd32b2e91de1e309fefffd555f827cc9ee16401020304582061519c127b42c58aa3bda284d4d5c9bd4b7d4f006e47540a3d7cc7bc3a8d6fa1582002efb5788e8713c844dfd32b2e91de1e309fefffd555f827cc9ee1640102030482582003efb5788e8713c844dfd32b2e91de1e309fefffd555f827cc9ee16401020304585000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001a0001e240582004efb5788e8713c844dfd32b2e91de1e309fefffd555f827cc9ee16401020304582005efb5788e8713c844dfd32b2e91de1e309fefffd555f827cc9ee16401020304187b1901c85840060606060606060606060606060606060606060606060606060606060606060606060606060606060606060606060606060606060606060606060606060606060c0d");

    final decode = HeaderBody.fromCborBytes(headerBody.serialize());
    expect(decode.serialize(), headerBody.serialize());
  });
}

void _header() {
  test("Header", () {
    final headerBody = HeaderBody(
        blockBodyHash: BlockHash(_fakeBytes32(4)),
        slot: BigInt.from(123),
        blockBodySize: 123456,
        blockNumber: 123,
        issuerKey: AdaPublicKey.fromHex(
            "61519c127b42c58aa3bda284d4d5c9bd4b7d4f006e47540a3d7cc7bc3a8d6fa1"),
        leaderCert: HeaderLeaderCertVrfResult(VRFCert(
          output: _fakeBytes32(3),
          proof: List<int>.filled(80, 0),
        )),
        operationalCert: OperationalCert(
            hotVkey: KESVKey(_fakeBytes32(5)),
            sequenceNumber: 123,
            kesPeriod: 456,
            sigma: Ed25519Signature(List<int>.filled(64, 6))),
        prevHash: BlockHash(_fakeBytes32(1)),
        protocolVersion: const ProtocolVersion(major: 12, minor: 13),
        vrfvKey: VRFVKey(_fakeBytes32(2)));
    expect(headerBody.serializeHex(),
        "8f187b187b582001efb5788e8713c844dfd32b2e91de1e309fefffd555f827cc9ee16401020304582061519c127b42c58aa3bda284d4d5c9bd4b7d4f006e47540a3d7cc7bc3a8d6fa1582002efb5788e8713c844dfd32b2e91de1e309fefffd555f827cc9ee1640102030482582003efb5788e8713c844dfd32b2e91de1e309fefffd555f827cc9ee16401020304585000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001a0001e240582004efb5788e8713c844dfd32b2e91de1e309fefffd555f827cc9ee16401020304582005efb5788e8713c844dfd32b2e91de1e309fefffd555f827cc9ee16401020304187b1901c85840060606060606060606060606060606060606060606060606060606060606060606060606060606060606060606060606060606060606060606060606060606060c0d");
    final decode = HeaderBody.fromCborBytes(headerBody.serialize());
    expect(decode.serialize(), headerBody.serialize());
    final header = Header(
        headerBody: headerBody,
        signature: KESSignature(List<int>.filled(KESSignature.length, 0)));

    final decodeHeader = Header.fromCborBytes(header.serialize());
    expect(header.serialize(), decodeHeader.serialize());
  });
  test("header legacy", () {
    final headerBody = HeaderBody(
        blockBodyHash: BlockHash(_fakeBytes32(4)),
        slot: BigInt.from(123),
        blockBodySize: 123456,
        blockNumber: 123,
        issuerKey: AdaPublicKey.fromHex(
            "e8dae31d3e915bfabf4322aca5489dc6efc4d210dd778342c15b1f62509f2e2a"),
        leaderCert: HeaderLeaderCertNonceAndLeader(
          nonceVrf: VRFCert(
            output: _fakeBytes32(4),
            proof: List<int>.filled(80, 1),
          ),
          leaderVrf: VRFCert(
            output: _fakeBytes32(5),
            proof: List<int>.filled(80, 2),
          ),
        ),
        operationalCert: OperationalCert(
            hotVkey: KESVKey(_fakeBytes32(5)),
            sequenceNumber: 123,
            kesPeriod: 456,
            sigma: Ed25519Signature(List<int>.filled(64, 6))),
        prevHash: BlockHash(_fakeBytes32(1)),
        protocolVersion: const ProtocolVersion(major: 12, minor: 13),
        vrfvKey: VRFVKey(_fakeBytes32(2)));
    expect(headerBody.serializeHex(),
        "8f187b187b582001efb5788e8713c844dfd32b2e91de1e309fefffd555f827cc9ee164010203045820e8dae31d3e915bfabf4322aca5489dc6efc4d210dd778342c15b1f62509f2e2a582002efb5788e8713c844dfd32b2e91de1e309fefffd555f827cc9ee1640102030482582004efb5788e8713c844dfd32b2e91de1e309fefffd555f827cc9ee164010203045850010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010182582005efb5788e8713c844dfd32b2e91de1e309fefffd555f827cc9ee16401020304585002020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202021a0001e240582004efb5788e8713c844dfd32b2e91de1e309fefffd555f827cc9ee16401020304582005efb5788e8713c844dfd32b2e91de1e309fefffd555f827cc9ee16401020304187b1901c85840060606060606060606060606060606060606060606060606060606060606060606060606060606060606060606060606060606060606060606060606060606060c0d");
    final decode = HeaderBody.fromCborBytes(headerBody.serialize());
    expect(decode.serialize(), headerBody.serialize());
    final header = Header(
        headerBody: headerBody,
        signature: KESSignature(List<int>.filled(KESSignature.length, 0)));
    final decodeHeader = Header.fromCborBytes(header.serialize());
    expect(header.serialize(), decodeHeader.serialize());
  });
}
