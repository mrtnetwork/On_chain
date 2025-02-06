import 'package:on_chain/on_chain.dart';
import 'api_methods.dart';

void main() async {
  /// token created in `publish_token_example`
  final account = SuiSecp256r1Account(
      SuiSecp256r1PrivateKey.fromBytes(List<int>.filled(32, 12)));
  final object = await suiProvider.request(const SuiRequestGetObject(
      objectId:
          "0xbfc3886de764de5632877a0f17b19796914d19714872ed5a8e05b36da126a027"));
  final input1 = SuiCallArgObject(
      SuiObjectArgImmOrOwnedObject(object.data!.toObjectRef()));
  final input2 = MoveU64.parse(1200000000);
  final gasCommands = SuiCommandMoveCall(SuiProgrammableMoveCall(
      package: SuiAddress(
          "0x6c1505f80c06a8919a3cf8237634eca6c4cc2be728bada91048df96aae60ea03"),
      module: "my_coin",
      function: "mint",
      typeArguments: [],
      arguments: [
        SuiArgumentInput(0),
        SuiArgumentInput(1),
        SuiArgumentInput(2),
      ]));

  final gasPrice = await getGasPrice();
  SuiTransactionDataV1 tx = SuiTransactionDataV1(
      expiration: const SuiTransactionExpirationNone(),
      sender: account.toAddress(),
      gasData: SuiGasData(
          payment: [],
          owner: account.toAddress(),
          price: gasPrice,
          budget: maxGas),
      kind: SuiTransactionKindProgrammableTransaction(
          SuiProgrammableTransaction(
              inputs: [input1, input2, account.toAddress()],
              commands: [gasCommands])));
  tx = await dryRunTx(tx);
  tx = await filledGasPayment(tx);

  final ser = tx.serializeSign();

  final signature = account.signTransaction(ser);
  final r = await excuteTx(tx: tx, signatures: [signature]);
  assert(r.effects?.status.status == SuiApiExecutionStatusType.success,
      r.effects?.status.error);

  /// https://suiscan.xyz/devnet/tx/AmEndwvJ7igx3LqyuofK5zQoTkHX9eynSD8RWwqot57R
}
