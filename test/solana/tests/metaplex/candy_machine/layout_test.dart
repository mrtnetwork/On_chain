import 'package:on_chain/solana/solana.dart';
import 'package:test/test.dart';

const _owner =
    SolAddress.unchecked("91KRjTdVaXbdosGDn5AnFczYSApddsFj1SKuShbTUMEB");
void main() {
  group("candy machine", () {
    _candyMachine();
    _candyMachineData();
    _initializeCandyMachineV2();
  });
}

void _candyMachine() {
  test("add connfig", () {
    final layout = MetaplexCandyMachineAddConfigLinesLayout(
        index: 1, configLines: [const ConfigLine(name: "MRT", uri: "jafar")]);
    expect(layout.toHex(),
        "df32e0e39708736a0100000001000000030000004d5254050000006a61666172");
    final decode =
        MetaplexCandyMachineAddConfigLinesLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _candyMachineData() {
  test("CandyMachineData", () {
    final layout = MetaplexCandyMachineInitializeCandyMachineLayout(
        data: CandyMachineData(
            itemsAvailable: BigInt.one,
            symbol: "MRT",
            sellerFeeBasisPoints: 1,
            maxSupply: BigInt.two,
            isMutable: false,
            creators: [
          const Creator(address: _owner, verified: false, share: 3)
        ]));
    expect(layout.toHex(),
        "afaf6d1f0d989bed0100000000000000030000004d525401000200000000000000000100000076f25489958a097dac92ed4953a1ad36b69e7c3b2671150a4c8c4c04f2ceeb6400030000");
    final decode = MetaplexCandyMachineInitializeCandyMachineLayout.fromBuffer(
        layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test("CandyMachineData_2", () {
    final layout = MetaplexCandyMachineInitializeCandyMachineLayout(
      data: CandyMachineData(
          itemsAvailable: BigInt.one,
          symbol: "MRT",
          sellerFeeBasisPoints: 1,
          maxSupply: BigInt.two,
          isMutable: false,
          configLineSettings: const ConfigLineSettings(
            prefixName: "MRT",
            nameLength: 3,
            prefixUri: "https://github.com/mrtnetwork",
            uriLength: 5,
            isSequential: false,
          ),
          creators: [
            const Creator(address: _owner, verified: false, share: 3)
          ]),
    );
    expect(layout.toHex(),
        "afaf6d1f0d989bed0100000000000000030000004d525401000200000000000000000100000076f25489958a097dac92ed4953a1ad36b69e7c3b2671150a4c8c4c04f2ceeb64000301030000004d5254030000001d00000068747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b050000000000");
    final decode = MetaplexCandyMachineInitializeCandyMachineLayout.fromBuffer(
        layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test("CandyMachineData_3", () {
    final layout = MetaplexCandyMachineInitializeCandyMachineLayout(
      data: CandyMachineData(
          itemsAvailable: BigInt.one,
          symbol: "MRT",
          sellerFeeBasisPoints: 1,
          maxSupply: BigInt.two,
          isMutable: false,
          configLineSettings: const ConfigLineSettings(
            prefixName: "MRT",
            nameLength: 3,
            prefixUri: "https://github.com/mrtnetwork",
            uriLength: 5,
            isSequential: false,
          ),
          hiddenSettings: CandyMachineHiddenSettings(
              name: "MRT",
              /** Shared URI */
              uri: "https://github.com/mrtnetwork",
              hash: List<int>.filled(32, 0)..fillRange(0, 20, 10)),
          creators: [
            const Creator(address: _owner, verified: false, share: 3)
          ]),
    );
    expect(layout.toHex(),
        "afaf6d1f0d989bed0100000000000000030000004d525401000200000000000000000100000076f25489958a097dac92ed4953a1ad36b69e7c3b2671150a4c8c4c04f2ceeb64000301030000004d5254030000001d00000068747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b050000000001030000004d52541d00000068747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a0a000000000000000000000000");
    final decode = MetaplexCandyMachineInitializeCandyMachineLayout.fromBuffer(
        layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _initializeCandyMachineV2() {
  test("candyMachineV2", () {
    final layout = MetaplexCandyMachineInitializeCandyMachineV2Layout(
        tokenStandard: MetaDataTokenStandard.nonFungible,
        data: CandyMachineData(
            itemsAvailable: BigInt.one,
            symbol: "MRT",
            sellerFeeBasisPoints: 1,
            maxSupply: BigInt.two,
            isMutable: false,
            creators: [
              const Creator(address: _owner, verified: false, share: 3)
            ]));
    expect(layout.toHex(),
        "4399af27da1026200100000000000000030000004d525401000200000000000000000100000076f25489958a097dac92ed4953a1ad36b69e7c3b2671150a4c8c4c04f2ceeb640003000000");
    final decode =
        MetaplexCandyMachineInitializeCandyMachineV2Layout.fromBuffer(
            layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}
