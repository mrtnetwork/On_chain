import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

/// this test copied from aptos ts sdk
/// https://github.com/aptos-labs/aptos-ts-sdk/blob/main/tests/e2e/transaction/transactionArguments.test.ts

final int _maxU8 = 255;
final int _maxU16 = 65535;
final int _maxU32 = 4294967295;
final BigInt _maxU64 = BigInt.parse("18446744073709551615");
final BigInt _maxU128 = BigInt.parse("340282366920938463463374607431768211455");
final BigInt _maxU256 = BigInt.parse(
    "115792089237316195423570985008687907853269984665640564039457584007913129639935");

void main() {
  _testAbi();
}

_testAbi() {
  test("aptos module abi parsing arguments", () {
    final AptosApiMoveModule abi = AptosApiMoveModule.fromJson(_abiJson);
    final function =
        abi.exposedFunctions.firstWhere((e) => e.name == 'private_arguments');

    final accountAddress = AptosAddress(
        "0x2cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c");

    List<AptosAddress> moduleObjects = [
      AptosAddress(
          "0x0dfefad774a605207859eab623b2fb803a39149240db274b88a74ffbf1a89d2b"),
      AptosAddress(
          "0xe158b3f59918f261c07511f779402d2dbc4094fc694c37429653f1c8ca2f10ba"),
      AptosAddress(
          "0x4599d326884a3a9dae56c5f2bf863c6dc5cc02fb6653163df0ad39670e20538d")
    ];

    final entryArguments = AptosFunctionEntryArgumentUtils.parseArguments(
        function: function,
        values: [
          true,
          1,
          2,
          3,
          4,
          5,
          6,
          accountAddress,
          "expected_string",
          moduleObjects[0],
          [],
          [true, false, true],
          [0, 1, 2, _maxU8 - 2, _maxU8 - 1, _maxU8],
          [0, 1, 2, _maxU16 - 2, _maxU16 - 1, _maxU16],
          [0, 1, 2, _maxU32 - 2, _maxU32 - 1, _maxU32],
          [
            0,
            1,
            2,
            _maxU64 - BigInt.from(2),
            _maxU64 - BigInt.from(1),
            _maxU64
          ],
          [
            0,
            1,
            2,
            _maxU128 - BigInt.from(2),
            _maxU128 - BigInt.from(1),
            _maxU128
          ],
          [
            0,
            1,
            2,
            _maxU256 - BigInt.from(2),
            _maxU256 - BigInt.from(1),
            _maxU256
          ],
          [
            "0x0",
            BytesUtils.fromHexString(
                "0x0000000000000000000000000000000000000000000000000000000000000abc"),
            BytesUtils.fromHexString(
                "0x0000000000000000000000000000000000000000000000000000000000000def"),
            BytesUtils.fromHexString(
                "0x0000000000000000000000000000000000000000000000000000000000000123"),
            BytesUtils.fromHexString(
                "0x0000000000000000000000000000000000000000000000000000000000000456"),
            BytesUtils.fromHexString(
                "0x0000000000000000000000000000000000000000000000000000000000000789"),
          ],
          ["expected_string", "abc", "def", "123", "456", "789"],
          moduleObjects,
          null,
          true,
          1,
          2,
          3,
          4,
          5,
          6,
          accountAddress,
          "expected_string",
          moduleObjects[0]
        ]);
    final payload = AptosTransactionPayloadEntryFunction(
        entryFunction: AptosTransactionEntryFunction(
            moduleId:
                AptosModuleId(address: accountAddress, name: 'tx_args_module'),
            functionName: 'public_arguments',
            args: entryArguments));
    expect(payload.toVariantBcsHex(),
        "022cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c0e74785f617267735f6d6f64756c65107075626c69635f617267756d656e747300200101010102020004030000000804000000000000001005000000000000000000000000000000200600000000000000000000000000000000000000000000000000000000000000202cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c100f65787065637465645f737472696e67200dfefad774a605207859eab623b2fb803a39149240db274b88a74ffbf1a89d2b010004030100010706000102fdfeff0d06000001000200fdfffeffffff1906000000000100000002000000fdfffffffeffffffffffffff3106000000000000000001000000000000000200000000000000fdfffffffffffffffeffffffffffffffffffffffffffffff6106000000000000000000000000000000000100000000000000000000000000000002000000000000000000000000000000fdfffffffffffffffffffffffffffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc10106000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000fdfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc1010600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000abc0000000000000000000000000000000000000000000000000000000000000def00000000000000000000000000000000000000000000000000000000000001230000000000000000000000000000000000000000000000000000000000000456000000000000000000000000000000000000000000000000000000000000078925060f65787065637465645f737472696e67036162630364656603313233033435360337383961030dfefad774a605207859eab623b2fb803a39149240db274b88a74ffbf1a89d2be158b3f59918f261c07511f779402d2dbc4094fc694c37429653f1c8ca2f10ba4599d326884a3a9dae56c5f2bf863c6dc5cc02fb6653163df0ad39670e20538d010002010102010103010200050103000000090104000000000000001101050000000000000000000000000000002101060000000000000000000000000000000000000000000000000000000000000021012cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c11010f65787065637465645f737472696e6721010dfefad774a605207859eab623b2fb803a39149240db274b88a74ffbf1a89d2b");
  });

  test("aptos module abi parsing arguments", () {
    final AptosApiMoveModule abi = AptosApiMoveModule.fromJson(_abiJson);
    final function =
        abi.exposedFunctions.firstWhere((e) => e.name == 'private_arguments');
    final accountAddress = AptosAddress(
        "0x2cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c");

    List<AptosAddress> moduleObjects = [
      AptosAddress(
          "0x0dfefad774a605207859eab623b2fb803a39149240db274b88a74ffbf1a89d2b"),
      AptosAddress(
          "0xe158b3f59918f261c07511f779402d2dbc4094fc694c37429653f1c8ca2f10ba"),
      AptosAddress(
          "0x4599d326884a3a9dae56c5f2bf863c6dc5cc02fb6653163df0ad39670e20538d")
    ];

    final arguments = AptosFunctionEntryArgumentUtils
        .parseArguments(function: function, values: [
      MoveBool(true),
      MoveU8(1),
      MoveU16(2),
      MoveU32(3),
      MoveU64.parse(4),
      MoveU128.parse(5),
      MoveU256.parse(6),
      accountAddress,
      MoveString("expected_string"),
      moduleObjects[0],
      MoveVector<MoveU8>([]),
      MoveVector.boolean([true, false, true]),
      MoveVector.u8([0, 1, 2, _maxU8 - 2, _maxU8 - 1, _maxU8]),
      MoveVector.u16([0, 1, 2, _maxU16 - 2, _maxU16 - 1, _maxU16]),
      MoveVector.u32([0, 1, 2, _maxU32 - 2, _maxU32 - 1, _maxU32]),
      MoveVector.u64([
        0,
        1,
        2,
        _maxU64 - BigInt.from(2),
        _maxU64 - BigInt.from(1),
        _maxU64
      ]),
      MoveVector.u128([
        0,
        1,
        2,
        _maxU128 - BigInt.from(2),
        _maxU128 - BigInt.from(1),
        _maxU128
      ]),
      MoveVector.u256([
        0,
        1,
        2,
        _maxU256 - BigInt.from(2),
        _maxU256 - BigInt.from(1),
        _maxU256
      ]),
      MoveVector<MoveAddress>([
        AptosAddress("0x0"),
        AptosAddress(
            "0x0000000000000000000000000000000000000000000000000000000000000abc"),
        AptosAddress(
            "0x0000000000000000000000000000000000000000000000000000000000000def"),
        AptosAddress(
            "0x0000000000000000000000000000000000000000000000000000000000000123"),
        AptosAddress(
            "0x0000000000000000000000000000000000000000000000000000000000000456"),
        AptosAddress(
            "0x0000000000000000000000000000000000000000000000000000000000000789"),
      ]),
      MoveVector.string(["expected_string", "abc", "def", "123", "456", "789"]),
      moduleObjects,
      MoveOption<MoveBool>(null),
      MoveOption(MoveBool(true)),
      MoveOption(MoveU8(1)),
      MoveOption(MoveU16(2)),
      MoveOption(MoveU32(3)),
      MoveOption(MoveU64.parse(4)),
      MoveOption(MoveU128.parse(5)),
      MoveOption(MoveU256.parse(6)),
      accountAddress,
      MoveOption(MoveString("expected_string")),
      moduleObjects[0],
    ]);
    final payload = AptosTransactionPayloadEntryFunction(
        entryFunction: AptosTransactionEntryFunction(
            moduleId:
                AptosModuleId(address: accountAddress, name: 'tx_args_module'),
            functionName: 'public_arguments',
            args: arguments));
    expect(payload.toVariantBcsHex(),
        "022cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c0e74785f617267735f6d6f64756c65107075626c69635f617267756d656e747300200101010102020004030000000804000000000000001005000000000000000000000000000000200600000000000000000000000000000000000000000000000000000000000000202cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c100f65787065637465645f737472696e67200dfefad774a605207859eab623b2fb803a39149240db274b88a74ffbf1a89d2b010004030100010706000102fdfeff0d06000001000200fdfffeffffff1906000000000100000002000000fdfffffffeffffffffffffff3106000000000000000001000000000000000200000000000000fdfffffffffffffffeffffffffffffffffffffffffffffff6106000000000000000000000000000000000100000000000000000000000000000002000000000000000000000000000000fdfffffffffffffffffffffffffffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc10106000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000fdfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc1010600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000abc0000000000000000000000000000000000000000000000000000000000000def00000000000000000000000000000000000000000000000000000000000001230000000000000000000000000000000000000000000000000000000000000456000000000000000000000000000000000000000000000000000000000000078925060f65787065637465645f737472696e67036162630364656603313233033435360337383961030dfefad774a605207859eab623b2fb803a39149240db274b88a74ffbf1a89d2be158b3f59918f261c07511f779402d2dbc4094fc694c37429653f1c8ca2f10ba4599d326884a3a9dae56c5f2bf863c6dc5cc02fb6653163df0ad39670e20538d010002010102010103010200050103000000090104000000000000001101050000000000000000000000000000002101060000000000000000000000000000000000000000000000000000000000000021012cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c11010f65787065637465645f737472696e6721010dfefad774a605207859eab623b2fb803a39149240db274b88a74ffbf1a89d2b");
  });

  test("aptos module abi parsing arguments", () {
    final AptosApiMoveModule abi = AptosApiMoveModule.fromJson(_abiJson);
    final function = abi.exposedFunctions
        .firstWhere((e) => e.name == 'public_arguments_multiple_signers');
    // final t = AptosFunctionEntryAbi.parse(f);
    final accountAddress = AptosAddress(
        "0x2cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c");

    List<AptosAddress> moduleObjects = [
      AptosAddress(
          "0x0dfefad774a605207859eab623b2fb803a39149240db274b88a74ffbf1a89d2b"),
      AptosAddress(
          "0xe158b3f59918f261c07511f779402d2dbc4094fc694c37429653f1c8ca2f10ba"),
      AptosAddress(
          "0x4599d326884a3a9dae56c5f2bf863c6dc5cc02fb6653163df0ad39670e20538d")
    ];

    final arguments = AptosFunctionEntryArgumentUtils
        .parseArguments(function: function, values: [
      MoveVector<MoveAddress>([
        AptosAddress(
            "0x2cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c"),
        AptosAddress(
            "0x56ef0b6e3b2fcdff991c9928c6d10bbbee80b2b564817119a79f4b9bf8faa176"),
        AptosAddress(
            "0xf9c46552a4f5e50659ed1d2db0e18b5b38ff734673565906e7a78de8942a783a"),
        AptosAddress(
            "0xcff690283be5002767d1c41fef789215f9d093c1b732bf2091b0f2a8c6b1b767"),
        AptosAddress(
            "0x06accbd0ded4b3dd3a1697ad774de5be8e52e04ca36b920216d4f2f5b72c372b")
      ]),
      MoveBool(true),
      MoveU8(1),
      MoveU16(2),
      MoveU32(3),
      MoveU64.parse(4),
      MoveU128.parse(5),
      MoveU256.parse(6),
      accountAddress,
      MoveString("expected_string"),
      moduleObjects[0],
      MoveVector<MoveU8>([]),
      MoveVector.boolean([true, false, true]),
      MoveVector.u8([0, 1, 2, _maxU8 - 2, _maxU8 - 1, _maxU8]),
      MoveVector.u16([0, 1, 2, _maxU16 - 2, _maxU16 - 1, _maxU16]),
      MoveVector.u32([0, 1, 2, _maxU32 - 2, _maxU32 - 1, _maxU32]),
      MoveVector.u64([
        0,
        1,
        2,
        _maxU64 - BigInt.from(2),
        _maxU64 - BigInt.from(1),
        _maxU64
      ]),
      MoveVector.u128([
        0,
        1,
        2,
        _maxU128 - BigInt.from(2),
        _maxU128 - BigInt.from(1),
        _maxU128
      ]),
      MoveVector.u256([
        0,
        1,
        2,
        _maxU256 - BigInt.from(2),
        _maxU256 - BigInt.from(1),
        _maxU256
      ]),
      MoveVector<MoveAddress>([
        AptosAddress("0x0"),
        AptosAddress(
            "0x0000000000000000000000000000000000000000000000000000000000000abc"),
        AptosAddress(
            "0x0000000000000000000000000000000000000000000000000000000000000def"),
        AptosAddress(
            "0x0000000000000000000000000000000000000000000000000000000000000123"),
        AptosAddress(
            "0x0000000000000000000000000000000000000000000000000000000000000456"),
        AptosAddress(
            "0x0000000000000000000000000000000000000000000000000000000000000789"),
      ]),
      MoveVector.string(["expected_string", "abc", "def", "123", "456", "789"]),
      moduleObjects,
      MoveOption<MoveBool>(null),
      MoveOption(MoveBool(true)),
      MoveOption(MoveU8(1)),
      MoveOption(MoveU16(2)),
      MoveOption(MoveU32(3)),
      MoveOption(MoveU64.parse(4)),
      MoveOption(MoveU128.parse(5)),
      MoveOption(MoveU256.parse(6)),
      accountAddress,
      MoveOption(MoveString("expected_string")),
      moduleObjects[0],
    ]);
    final payload = AptosTransactionPayloadEntryFunction(
        entryFunction: AptosTransactionEntryFunction(
            typeArgs: [],
            moduleId:
                AptosModuleId(address: accountAddress, name: 'tx_args_module'),
            functionName: 'public_arguments_multiple_signers',
            args: arguments));
    expect(payload.toVariantBcsHex(),
        "022cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c0e74785f617267735f6d6f64756c65217075626c69635f617267756d656e74735f6d756c7469706c655f7369676e6572730021a101052cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c56ef0b6e3b2fcdff991c9928c6d10bbbee80b2b564817119a79f4b9bf8faa176f9c46552a4f5e50659ed1d2db0e18b5b38ff734673565906e7a78de8942a783acff690283be5002767d1c41fef789215f9d093c1b732bf2091b0f2a8c6b1b76706accbd0ded4b3dd3a1697ad774de5be8e52e04ca36b920216d4f2f5b72c372b0101010102020004030000000804000000000000001005000000000000000000000000000000200600000000000000000000000000000000000000000000000000000000000000202cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c100f65787065637465645f737472696e67200dfefad774a605207859eab623b2fb803a39149240db274b88a74ffbf1a89d2b010004030100010706000102fdfeff0d06000001000200fdfffeffffff1906000000000100000002000000fdfffffffeffffffffffffff3106000000000000000001000000000000000200000000000000fdfffffffffffffffeffffffffffffffffffffffffffffff6106000000000000000000000000000000000100000000000000000000000000000002000000000000000000000000000000fdfffffffffffffffffffffffffffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc10106000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000fdfffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc1010600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000abc0000000000000000000000000000000000000000000000000000000000000def00000000000000000000000000000000000000000000000000000000000001230000000000000000000000000000000000000000000000000000000000000456000000000000000000000000000000000000000000000000000000000000078925060f65787065637465645f737472696e67036162630364656603313233033435360337383961030dfefad774a605207859eab623b2fb803a39149240db274b88a74ffbf1a89d2be158b3f59918f261c07511f779402d2dbc4094fc694c37429653f1c8ca2f10ba4599d326884a3a9dae56c5f2bf863c6dc5cc02fb6653163df0ad39670e20538d010002010102010103010200050103000000090104000000000000001101050000000000000000000000000000002101060000000000000000000000000000000000000000000000000000000000000021012cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c11010f65787065637465645f737472696e6721010dfefad774a605207859eab623b2fb803a39149240db274b88a74ffbf1a89d2b");
  });

  test("aptos module abi parsing arguments", () {
    final accountAddress = AptosAddress(
        "0x2cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c");
    List<AptosAddress> moduleObjects = [
      AptosAddress(
          "0x0dfefad774a605207859eab623b2fb803a39149240db274b88a74ffbf1a89d2b"),
      AptosAddress(
          "0xe158b3f59918f261c07511f779402d2dbc4094fc694c37429653f1c8ca2f10ba"),
      AptosAddress(
          "0x4599d326884a3a9dae56c5f2bf863c6dc5cc02fb6653163df0ad39670e20538d")
    ];

    final payload = AptosTransactionPayloadScript(
        script: AptosScript(
            typeArgs: [],
            arguments: [
          AptosAddress(
              "0x2cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c"),
          AptosAddress(
              "0x6b61aea9dab34e82f4c0e7ac866aaf5e51486be808a0858613a3d917258b1255"),
          AptosAddress(
              "0xfea1cacb49d729d2bf5c779e3a6cb20488b774fe715bfc01cadde3ce40ca9f4b"),
          AptosAddress(
              "0xb353cd8decea3fc037a643ff2dc80c276d69626852cde3f92c266ea1466732a5"),
          AptosAddress(
              "0xa0f9c85f2357868cd5f001c93e83de0a0d2b05ec3c7c7f6b68f7c3f7ef225003"),
          MoveBool(true),
          MoveU8(1),
          MoveU16(2),
          MoveU32(3),
          MoveU64.parse(4),
          MoveU128.parse(5),
          MoveU256.parse(6),
          accountAddress,
          MoveString("expected_string"),
          moduleObjects[0],
          MoveVector.u8([0, 1, 2, _maxU8 - 2, _maxU8 - 1, _maxU8]),
        ],
            byteCode: BytesUtils.fromHexString(
                "a11ceb0b060000000601000802080e03160a05203907596408bd0140000000010002010302040700000507010001030608000107020300030804010015060c060c060c060c060c050505050501020d0e03040f0508000b010108020a020001060c01050b01020d0e03040f0508000b010108020a02066f626a656374067369676e657206737472696e670e74785f617267735f6d6f64756c6506537472696e67064f626a6563740d456d7074795265736f757263650a616464726573735f6f66186173736572745f76616c7565735f666f725f73637269707400000000000000000000000000000000000000000000000000000000000000012cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c000001490b0011000b0521040605100b04010b03010b02010b0101066400000000000000270b0111000b06210416051e0b04010b03010b0201066500000000000000270b0211000b07210424052a0b04010b0301066600000000000000270b0311000b0821043005340b0401066700000000000000270b0411000b0921043a053c066800000000000000270b0a0b0b0b0c0b0d0b0e0b0f0b100b110b120b130b141101022cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c000001490b0011000b0521040605100b04010b03010b02010b0101066400000000000000270b0111000b06210416051e0b04010b03010b0201066500000000000000270b0211000b07210424052a0b04010b0301066600000000000000270b0311000b0821043005340b0401066700000000000000270b0411000b0921043a053c066800000000000000270b0a0b0b0b0c0b0d0b0e0b0f0b100b110b120b130b141101022cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c000001150b0011000b012104060508066400000000000000270b020b030b040b050b060b070b080b090b0a0b0b0b0c110102")));
    expect(payload.toVariantBcsHex(),
        "00d305a11ceb0b060000000601000802080e03160a05203907596408bd0140000000010002010302040700000507010001030608000107020300030804010015060c060c060c060c060c050505050501020d0e03040f0508000b010108020a020001060c01050b01020d0e03040f0508000b010108020a02066f626a656374067369676e657206737472696e670e74785f617267735f6d6f64756c6506537472696e67064f626a6563740d456d7074795265736f757263650a616464726573735f6f66186173736572745f76616c7565735f666f725f73637269707400000000000000000000000000000000000000000000000000000000000000012cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c000001490b0011000b0521040605100b04010b03010b02010b0101066400000000000000270b0111000b06210416051e0b04010b03010b0201066500000000000000270b0211000b07210424052a0b04010b0301066600000000000000270b0311000b0821043005340b0401066700000000000000270b0411000b0921043a053c066800000000000000270b0a0b0b0b0c0b0d0b0e0b0f0b100b110b120b130b141101022cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c000001490b0011000b0521040605100b04010b03010b02010b0101066400000000000000270b0111000b06210416051e0b04010b03010b0201066500000000000000270b0211000b07210424052a0b04010b0301066600000000000000270b0311000b0821043005340b0401066700000000000000270b0411000b0921043a053c066800000000000000270b0a0b0b0b0c0b0d0b0e0b0f0b100b110b120b130b141101022cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c000001150b0011000b012104060508066400000000000000270b020b030b040b050b060b070b080b090b0a0b0b0b0c1101020010032cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c036b61aea9dab34e82f4c0e7ac866aaf5e51486be808a0858613a3d917258b125503fea1cacb49d729d2bf5c779e3a6cb20488b774fe715bfc01cadde3ce40ca9f4b03b353cd8decea3fc037a643ff2dc80c276d69626852cde3f92c266ea1466732a503a0f9c85f2357868cd5f001c93e83de0a0d2b05ec3c7c7f6b68f7c3f7ef2250030501000106020007030000000104000000000000000205000000000000000000000000000000080600000000000000000000000000000000000000000000000000000000000000032cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c040f65787065637465645f737472696e67030dfefad774a605207859eab623b2fb803a39149240db274b88a74ffbf1a89d2b0406000102fdfeff");
  });
}

const _abiJson = {
  "address":
      "0x2cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c",
  "name": "tx_args_module",
  "friends": [],
  "exposed_functions": [
    {
      "name": "assert_values_for_script",
      "visibility": "public",
      "is_entry": false,
      "is_view": false,
      "generic_type_params": [],
      "params": [
        "bool",
        "u8",
        "u16",
        "u32",
        "u64",
        "u128",
        "u256",
        "address",
        "0x1::string::String",
        "0x1::object::Object<0x2cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c::tx_args_module::EmptyResource>",
        "vector<u8>"
      ],
      "return": []
    },
    {
      "name": "complex_arguments",
      "visibility": "private",
      "is_entry": true,
      "is_view": false,
      "generic_type_params": [],
      "params": [
        "vector<vector<u8>>",
        "vector<vector<0x1::string::String>>",
        "vector<0x1::option::Option<vector<0x1::string::String>>>",
        "vector<vector<0x1::option::Option<vector<0x1::string::String>>>>"
      ],
      "return": []
    },
    {
      "name": "get_expected_vector_string",
      "visibility": "public",
      "is_entry": false,
      "is_view": true,
      "generic_type_params": [],
      "params": [],
      "return": ["vector<0x1::string::String>"]
    },
    {
      "name": "get_test_object_addresses",
      "visibility": "public",
      "is_entry": false,
      "is_view": true,
      "generic_type_params": [],
      "params": [],
      "return": ["address", "address", "address"]
    },
    {
      "name": "get_test_objects",
      "visibility": "public",
      "is_entry": false,
      "is_view": true,
      "generic_type_params": [],
      "params": [],
      "return": [
        "0x1::object::Object<0x2cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c::tx_args_module::EmptyResource>",
        "0x1::object::Object<0x2cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c::tx_args_module::EmptyResource>",
        "0x1::object::Object<0x2cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c::tx_args_module::EmptyResource>"
      ]
    },
    {
      "name": "private_arguments",
      "visibility": "private",
      "is_entry": true,
      "is_view": false,
      "generic_type_params": [],
      "params": [
        "&signer",
        "bool",
        "u8",
        "u16",
        "u32",
        "u64",
        "u128",
        "u256",
        "address",
        "0x1::string::String",
        "0x1::object::Object<0x2cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c::tx_args_module::EmptyResource>",
        "vector<u8>",
        "vector<bool>",
        "vector<u8>",
        "vector<u16>",
        "vector<u32>",
        "vector<u64>",
        "vector<u128>",
        "vector<u256>",
        "vector<address>",
        "vector<0x1::string::String>",
        "vector<0x1::object::Object<0x2cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c::tx_args_module::EmptyResource>>",
        "0x1::option::Option<u8>",
        "0x1::option::Option<bool>",
        "0x1::option::Option<u8>",
        "0x1::option::Option<u16>",
        "0x1::option::Option<u32>",
        "0x1::option::Option<u64>",
        "0x1::option::Option<u128>",
        "0x1::option::Option<u256>",
        "0x1::option::Option<address>",
        "0x1::option::Option<0x1::string::String>",
        "0x1::option::Option<0x1::object::Object<0x2cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c::tx_args_module::EmptyResource>>"
      ],
      "return": []
    },
    {
      "name": "private_arguments_multiple_signers",
      "visibility": "private",
      "is_entry": true,
      "is_view": false,
      "generic_type_params": [],
      "params": [
        "&signer",
        "signer",
        "&signer",
        "signer",
        "&signer",
        "vector<address>",
        "bool",
        "u8",
        "u16",
        "u32",
        "u64",
        "u128",
        "u256",
        "address",
        "0x1::string::String",
        "0x1::object::Object<0x2cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c::tx_args_module::EmptyResource>",
        "vector<u8>",
        "vector<bool>",
        "vector<u8>",
        "vector<u16>",
        "vector<u32>",
        "vector<u64>",
        "vector<u128>",
        "vector<u256>",
        "vector<address>",
        "vector<0x1::string::String>",
        "vector<0x1::object::Object<0x2cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c::tx_args_module::EmptyResource>>",
        "0x1::option::Option<u8>",
        "0x1::option::Option<bool>",
        "0x1::option::Option<u8>",
        "0x1::option::Option<u16>",
        "0x1::option::Option<u32>",
        "0x1::option::Option<u64>",
        "0x1::option::Option<u128>",
        "0x1::option::Option<u256>",
        "0x1::option::Option<address>",
        "0x1::option::Option<0x1::string::String>",
        "0x1::option::Option<0x1::object::Object<0x2cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c::tx_args_module::EmptyResource>>"
      ],
      "return": []
    },
    {
      "name": "public_arguments",
      "visibility": "public",
      "is_entry": true,
      "is_view": false,
      "generic_type_params": [],
      "params": [
        "&signer",
        "bool",
        "u8",
        "u16",
        "u32",
        "u64",
        "u128",
        "u256",
        "address",
        "0x1::string::String",
        "0x1::object::Object<0x2cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c::tx_args_module::EmptyResource>",
        "vector<u8>",
        "vector<bool>",
        "vector<u8>",
        "vector<u16>",
        "vector<u32>",
        "vector<u64>",
        "vector<u128>",
        "vector<u256>",
        "vector<address>",
        "vector<0x1::string::String>",
        "vector<0x1::object::Object<0x2cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c::tx_args_module::EmptyResource>>",
        "0x1::option::Option<u8>",
        "0x1::option::Option<bool>",
        "0x1::option::Option<u8>",
        "0x1::option::Option<u16>",
        "0x1::option::Option<u32>",
        "0x1::option::Option<u64>",
        "0x1::option::Option<u128>",
        "0x1::option::Option<u256>",
        "0x1::option::Option<address>",
        "0x1::option::Option<0x1::string::String>",
        "0x1::option::Option<0x1::object::Object<0x2cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c::tx_args_module::EmptyResource>>"
      ],
      "return": []
    },
    {
      "name": "public_arguments_multiple_signers",
      "visibility": "public",
      "is_entry": true,
      "is_view": false,
      "generic_type_params": [],
      "params": [
        "&signer",
        "signer",
        "&signer",
        "signer",
        "&signer",
        "vector<address>",
        "bool",
        "u8",
        "u16",
        "u32",
        "u64",
        "u128",
        "u256",
        "address",
        "0x1::string::String",
        "0x1::object::Object<0x2cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c::tx_args_module::EmptyResource>",
        "vector<u8>",
        "vector<bool>",
        "vector<u8>",
        "vector<u16>",
        "vector<u32>",
        "vector<u64>",
        "vector<u128>",
        "vector<u256>",
        "vector<address>",
        "vector<0x1::string::String>",
        "vector<0x1::object::Object<0x2cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c::tx_args_module::EmptyResource>>",
        "0x1::option::Option<u8>",
        "0x1::option::Option<bool>",
        "0x1::option::Option<u8>",
        "0x1::option::Option<u16>",
        "0x1::option::Option<u32>",
        "0x1::option::Option<u64>",
        "0x1::option::Option<u128>",
        "0x1::option::Option<u256>",
        "0x1::option::Option<address>",
        "0x1::option::Option<0x1::string::String>",
        "0x1::option::Option<0x1::object::Object<0x2cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c::tx_args_module::EmptyResource>>"
      ],
      "return": []
    },
    {
      "name": "type_tags",
      "visibility": "public",
      "is_entry": true,
      "is_view": false,
      "generic_type_params": [
        {"constraints": []},
        {"constraints": []},
        {"constraints": []},
        {"constraints": []},
        {"constraints": []},
        {"constraints": []},
        {"constraints": []},
        {"constraints": []},
        {"constraints": []},
        {"constraints": []},
        {"constraints": []},
        {"constraints": []},
        {"constraints": []},
        {"constraints": []},
        {"constraints": []},
        {"constraints": []},
        {"constraints": []},
        {"constraints": []},
        {"constraints": []},
        {"constraints": []},
        {"constraints": []},
        {"constraints": []},
        {"constraints": []},
        {"constraints": []},
        {"constraints": []},
        {"constraints": []},
        {"constraints": []},
        {"constraints": []},
        {"constraints": []},
        {"constraints": []},
        {"constraints": []}
      ],
      "params": [],
      "return": []
    },
    {
      "name": "type_tags_for_args",
      "visibility": "public",
      "is_entry": true,
      "is_view": false,
      "generic_type_params": [
        {
          "constraints": ["drop"]
        },
        {
          "constraints": ["drop"]
        },
        {
          "constraints": ["drop"]
        },
        {
          "constraints": ["drop"]
        },
        {
          "constraints": ["key"]
        }
      ],
      "params": ["T0", "T1", "T2", "T3", "0x1::object::Object<T4>"],
      "return": []
    },
    {
      "name": "view_all_arguments",
      "visibility": "public",
      "is_entry": false,
      "is_view": true,
      "generic_type_params": [],
      "params": [
        "bool",
        "u8",
        "u16",
        "u32",
        "u64",
        "u128",
        "u256",
        "address",
        "0x1::string::String",
        "0x1::object::Object<0x2cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c::tx_args_module::EmptyResource>",
        "vector<u8>",
        "vector<bool>",
        "vector<u8>",
        "vector<u16>",
        "vector<u32>",
        "vector<u64>",
        "vector<u128>",
        "vector<u256>",
        "vector<address>",
        "vector<0x1::string::String>",
        "vector<0x1::object::Object<0x2cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c::tx_args_module::EmptyResource>>",
        "0x1::option::Option<u8>",
        "0x1::option::Option<bool>",
        "0x1::option::Option<u8>",
        "0x1::option::Option<u16>",
        "0x1::option::Option<u32>",
        "0x1::option::Option<u64>",
        "0x1::option::Option<u128>",
        "0x1::option::Option<u256>",
        "0x1::option::Option<address>",
        "0x1::option::Option<0x1::string::String>",
        "0x1::option::Option<0x1::object::Object<0x2cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c::tx_args_module::EmptyResource>>"
      ],
      "return": [
        "bool",
        "u8",
        "u16",
        "u32",
        "u64",
        "u128",
        "u256",
        "address",
        "0x1::string::String",
        "0x1::object::Object<0x2cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c::tx_args_module::EmptyResource>",
        "vector<u8>",
        "vector<bool>",
        "vector<u8>",
        "vector<u16>",
        "vector<u32>",
        "vector<u64>",
        "vector<u128>",
        "vector<u256>",
        "vector<address>",
        "vector<0x1::string::String>",
        "vector<0x1::object::Object<0x2cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c::tx_args_module::EmptyResource>>",
        "0x1::option::Option<u8>",
        "0x1::option::Option<bool>",
        "0x1::option::Option<u8>",
        "0x1::option::Option<u16>",
        "0x1::option::Option<u32>",
        "0x1::option::Option<u64>",
        "0x1::option::Option<u128>",
        "0x1::option::Option<u256>",
        "0x1::option::Option<address>",
        "0x1::option::Option<0x1::string::String>",
        "0x1::option::Option<0x1::object::Object<0x2cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c::tx_args_module::EmptyResource>>"
      ]
    }
  ],
  "structs": [
    {
      "name": "EmptyResource",
      "is_native": false,
      "is_event": false,
      "abilities": ["key"],
      "generic_type_params": [],
      "fields": [
        {"name": "dummy_field", "type": "bool"}
      ]
    },
    {
      "name": "SetupData",
      "is_native": false,
      "is_event": false,
      "abilities": ["key"],
      "generic_type_params": [],
      "fields": [
        {
          "name": "empty_object_1",
          "type":
              "0x1::object::Object<0x2cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c::tx_args_module::EmptyResource>"
        },
        {
          "name": "empty_object_2",
          "type":
              "0x1::object::Object<0x2cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c::tx_args_module::EmptyResource>"
        },
        {
          "name": "empty_object_3",
          "type":
              "0x1::object::Object<0x2cca48b8b0d7f77ef28bfd608883c599680c5b8db8192c5e3baaae1aee45114c::tx_args_module::EmptyResource>"
        }
      ]
    }
  ]
};
