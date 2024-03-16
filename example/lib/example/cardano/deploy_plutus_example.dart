import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/ada.dart';
import 'provider_example/provider.dart';

const String _plData =
    "590dda01000033323233223232323232332232323232323232323322323232323232323233322232323232323232322223223232325335001102813263202d33573892010350543500028323232533500313300b49010b4275726e206661696c656400323235004223335530101200132335012223335003220020020013500122001123300101b02e2350012222533530080032103210323500222222222222200a3200135503322533500115021221350022253353301700200713502600113006003300f0021335502c300b49010b4d696e74206661696c656400330163232323500322222222222233355301b120013233501d2233350032200200200135001220011233001225335002103b100103825335333573466e3c03cd400488d4008880080e40e04ccd5cd19b8700e35001223500222001039038103800c3500b220013500a22002500133010335502c33555017237246ecccdd2a400066ae80dd398170009bb102f3355501725335333355300d1200133500e22230033002001200122533500121350032235003223500222350295335333573466e3c0080180cc0c84cd540eccd540ec008cdc0000802801899aa81d80499a81c80200189a81119aa81a001281999919191919191919118011803800990009aa81d11299a800898011801a81d110a99a800880111098031803802990009aa81c91299a8008a81c910a99a800880191099a81e198038020011803000990009aa81c111299a8010800910a99a8018802110a999a99806002001099a81e00219803801802899a81e00119803803000899a81e002198038018029a8019110009a8011110011a80091100199918008009119091a990919980091a801911180180211a801911180100211a8019111800802091a98018021a8020008009801001091111998021299a80089a80a89119801281c800910a99a80089a80b89119801002800910a999a998050020010999803001119a81d80280080089998038011a80c891198010030008008999803001119a81d802800800911299a800899a81c19a81c0018011803281c910a999a99805002801099a81d19a81d0028021804001899980380119a81d002802000899a81d19a81d002802180400191119299a80109800a4c442a666a6601600c004266600e0044600c66a07800e002002260069309998038011180319a81e003800800919a81c98019a80c0911980100300098038011919111a801111a80191912999a999a80d8048028018999a80d8040020008a8010a8010999a80c80380180099999999a80a11199ab9a3370e00400205a05844a66a666ae68cdc3801000816816080c8a99a999ab9a3371200400205a058202e203044666ae68cdc400100081681611199ab9a3371200400205a05844666ae68cdc480100081601691199ab9a3371000400205805a44a66a666ae68cdc48010008168160800880111299a999ab9a3371200400205a0582004200266666666a02602244a66a666ae68cdc7801000816015880c0a99a999ab9a33722004002058056202c202e44666ae68cdc800100081601591199ab9a3372200400205805644666ae68cdc880100081581611199ab9a3372000400205605844a66a666ae68cdc88010008160158800880111299a999ab9a3372200400205805620042002002a03e426a0024466a0660040022a062400266aa05866aaa02e644a66a002420022004a06066aaa02e646446004002640026aa06644a66a0022a0424426a00444a66a6602e00400e26a04c0022600c006601e00466aaa02e400246a002444444444444010a00201426a002440046666ae68cdc39aab9d5003480008cc8848cc00400c008c8c8c8c8c8c8c8c8c8c8c8c8c8cccd5cd19b8735573aa018900011999999999999111111111110919999999999980080680600580500480400380300280200180119a8128131aba1500c33502502635742a01666a04a04e6ae854028ccd540a5d728141aba150093335502975ca0506ae854020cd40940c0d5d0a803999aa814818bad35742a00c6464646666ae68cdc39aab9d5002480008cc8848cc00400c008c8c8c8cccd5cd19b8735573aa004900011991091980080180119a81dbad35742a00460786ae84d5d1280111931902219ab9c04003f042135573ca00226ea8004d5d0a8011919191999ab9a3370e6aae754009200023322123300100300233503b75a6ae854008c0f0d5d09aba2500223263204433573808007e08426aae7940044dd50009aba135744a004464c6408066ae700f00ec0f84d55cf280089baa00135742a00a66a04aeb8d5d0a802199aa81481690009aba150033335502975c40026ae854008c0bcd5d09aba2500223263203c33573807006e07426ae8940044d5d1280089aba25001135744a00226ae8940044d5d1280089aba25001135744a00226ae8940044d5d1280089aab9e5001137540026ae85400cc07cd5d09aba2500323263202e3357380540520586666ae68cdc3a80224004424400446666ae68cdc3a802a40004244002464c6405c66ae700a80a40b00ac4d55cf280089baa001135573a6ea8004894cd400440804cd5ce00100f990009aa8131108911299a80089a80191000910999a802910011802001199aa98038900080280200089109198008018010919a800a811281191a800911999a80091931901219ab9c4901024c680001f20012326320243357389201024c680001f2326320243357389201024c680001f22333573466e3c00800406c06848d40048888888801c48888888848cccccccc00402402001c01801401000c008488800c48880084888004894cd400840044050444888c00cc00800448c88c008dd6000990009aa80d911999aab9f0012501c233501b30043574200460066ae880080548c8c8cccd5cd19b8735573aa004900011991091980080180118061aba150023005357426ae8940088c98c8068cd5ce00b00a80c09aab9e5001137540024646464646666ae68cdc39aab9d5004480008cccc888848cccc00401401000c008c8c8c8cccd5cd19b8735573aa0049000119910919800801801180a9aba1500233500d014357426ae8940088c98c807ccd5ce00d80d00e89aab9e5001137540026ae854010ccd54021d728039aba150033232323333573466e1d4005200423212223002004357426aae79400c8cccd5cd19b875002480088c84888c004010dd71aba135573ca00846666ae68cdc3a801a400042444006464c6404266ae7007407007c0780744d55cea80089baa00135742a00466a012eb8d5d09aba2500223263201b33573802e02c03226ae8940044d5d1280089aab9e500113754002266aa002eb9d6889119118011bab00132001355018223233335573e0044a034466a03266aa036600c6aae754008c014d55cf280118021aba200301313574200224464646666ae68cdc3a800a400046a00e600a6ae84d55cf280191999ab9a3370ea00490011280391931900c19ab9c014013016015135573aa00226ea800448488c00800c44880048c8c8cccd5cd19b875001480188c848888c010014c01cd5d09aab9e500323333573466e1d400920042321222230020053009357426aae7940108cccd5cd19b875003480088c848888c004014c01cd5d09aab9e500523333573466e1d40112000232122223003005375c6ae84d55cf280311931900b19ab9c012011014013012011135573aa00226ea80048c8c8cccd5cd19b8735573aa004900011991091980080180118029aba15002375a6ae84d5d1280111931900919ab9c00e00d010135573ca00226ea80048c8cccd5cd19b8735573aa002900011bae357426aae7940088c98c8040cd5ce00600580709baa001232323232323333573466e1d4005200c21222222200323333573466e1d4009200a21222222200423333573466e1d400d2008233221222222233001009008375c6ae854014dd69aba135744a00a46666ae68cdc3a8022400c4664424444444660040120106eb8d5d0a8039bae357426ae89401c8cccd5cd19b875005480108cc8848888888cc018024020c030d5d0a8049bae357426ae8940248cccd5cd19b875006480088c848888888c01c020c034d5d09aab9e500b23333573466e1d401d2000232122222223005008300e357426aae7940308c98c8064cd5ce00a80a00b80b00a80a00980900889aab9d5004135573ca00626aae7940084d55cf280089baa0012323232323333573466e1d400520022333222122333001005004003375a6ae854010dd69aba15003375a6ae84d5d1280191999ab9a3370ea0049000119091180100198041aba135573ca00c464c6402466ae7003803404003c4d55cea80189aba25001135573ca00226ea80048c8c8cccd5cd19b875001480088c8488c00400cdd71aba135573ca00646666ae68cdc3a8012400046424460040066eb8d5d09aab9e500423263200f33573801601401a01826aae7540044dd500089119191999ab9a3370ea00290021091100091999ab9a3370ea00490011190911180180218031aba135573ca00846666ae68cdc3a801a400042444004464c6402066ae7003002c0380340304d55cea80089baa0012323333573466e1d40052002200523333573466e1d40092000200523263200c33573801000e01401226aae74dd500089100109100089000a481035054310011223002001320013550052253350011376200644266ae80d400888cdd2a400066ae80dd480119aba037500026ec401cc01000526112200212212233001004003112212330010030021123230010012233003300200200148920accff338b53d84833cc95e53a921005858d0a499020a4d72058ccaaaccc67e92003351223300248920036113b2561c39aa68bcafb5593d533a1393a61475c773ed53e844303eed2e8100480008848cc00400c0088005";
void main() async {
  const mnemonic =
      "puzzle echo foil leopard depth purchase guard update tonight force cheese athlete slice cereal axis";
  final seed = CardanoIcarusSeedGenerator(mnemonic).generate();
  final cip = Cip1852.fromSeed(seed, Cip1852Coins.cardanoIcarusTestnet);
  final cardanoWallet =
      CardanoShelley.fromCip1852Object(cip.purpose.coin.account(0));
  final external = cardanoWallet.change(Bip44Changes.chainExt).addressIndex(0);
  final internal = cardanoWallet.change(Bip44Changes.chainInt).addressIndex(0);
  final externalAddress = ADABaseAddress.fromPublicKey(
      basePubkeyBytes: external.bip44.publicKey.compressed,
      stakePubkeyBytes: external.bip44Sk.publicKey.compressed,
      network: ADANetwork.testnetPreprod);
  final internalAddress = ADABaseAddress.fromPublicKey(
      basePubkeyBytes: internal.bip44.publicKey.compressed,
      stakePubkeyBytes: internal.bip44Sk.publicKey.compressed,
      network: ADANetwork.testnetPreprod);

  PlutusList plutusData = PlutusData.fromJsonSchema(
      json: StringUtils.toJson(
          '{"list":[{"constructor":0,"fields":[{"constructor":0,"fields":[{"bytes":"e93957943cf62a16bf6bedb2ac554a1b15849d14107bccf1f76cc146"}]},{"constructor":0,"fields":[{"map":[{"k":{"constructor":0,"fields":[{"constructor":0,"fields":[{"constructor":0,"fields":[]},{"constructor":0,"fields":[{"constructor":0,"fields":[{"bytes":"812691b6428b976e5e72e004f1876c1566a3f3f8cc05c9405b75c8cc"}]},{"constructor":0,"fields":[{"constructor":0,"fields":[{"constructor":0,"fields":[{"bytes":"e454ee23d6dc526c1ed6fd12e3a06a3e80ab7aad863331da0135518a"}]}]}]}]}]},{"constructor":0,"fields":[{"bytes":""},{"bytes":""}]}]},"v":{"int":2000000}}]},{"map":[]},{"map":[]},{"int":0}]},{"constructor":3,"fields":[{"list":[{"constructor":0,"fields":[{"constructor":0,"fields":[{"constructor":1,"fields":[{"bytes":"4164612070726f7669646572"}]},{"constructor":1,"fields":[{"bytes":"4164612070726f7669646572"}]},{"constructor":0,"fields":[{"bytes":""},{"bytes":""}]},{"constructor":5,"fields":[{"constructor":1,"fields":[{"int":1000000}]},{"constructor":1,"fields":[{"int":0}]}]}]},{"constructor":3,"fields":[{"list":[{"constructor":0,"fields":[{"constructor":0,"fields":[{"constructor":1,"fields":[{"bytes":"446f6c6c61722070726f7669646572"}]},{"constructor":1,"fields":[{"bytes":"446f6c6c61722070726f7669646572"}]},{"constructor":0,"fields":[{"bytes":"85bb65085bb65085bb65085bb65085bb65085bb65085bb65085bb650"},{"bytes":"646f6c6c6172"}]},{"constructor":1,"fields":[{"int":0}]}]},{"constructor":1,"fields":[{"constructor":1,"fields":[{"bytes":"4164612070726f7669646572"}]},{"constructor":1,"fields":[{"constructor":1,"fields":[{"bytes":"446f6c6c61722070726f7669646572"}]}]},{"constructor":0,"fields":[{"bytes":""},{"bytes":""}]},{"constructor":5,"fields":[{"constructor":1,"fields":[{"int":1000000}]},{"constructor":1,"fields":[{"int":0}]}]},{"constructor":1,"fields":[{"constructor":1,"fields":[{"bytes":"446f6c6c61722070726f7669646572"}]},{"constructor":1,"fields":[{"constructor":1,"fields":[{"bytes":"4164612070726f7669646572"}]}]},{"constructor":0,"fields":[{"bytes":"85bb65085bb65085bb65085bb65085bb65085bb65085bb65085bb650"},{"bytes":"646f6c6c6172"}]},{"constructor":1,"fields":[{"int":0}]},{"constructor":0,"fields":[]}]}]}]}]},{"int":1710267503680},{"constructor":0,"fields":[]}]}]}]},{"int":1710265703680},{"constructor":0,"fields":[]}]}]}]}'),
      schema: PlutusJsonSchema.detailedSchema) as PlutusList;
  plutusData = plutusData.copyWith(definiteEncoding: true);

  final input = TransactionInput(
      transactionId: TransactionHash.fromHex(
          "036113b2561c39aa68bcafb5593d533a1393a61475c773ed53e844303eed2e81"),
      index: 0);
  final output1 = TransactionOutput(
      address: internalAddress, amount: Value(coin: BigInt.from(9995151452)));

  final output2 = TransactionOutput(
      address: ADAAddress.fromAddress(
          "addr_test1wrv9l2du900ajl27hk79u07xda68vgfugrppkua5zftlp8g0l9djk"),
      amount: Value(coin: BigInt.from(2000000)),
      plutusData: DataOptionDataHash(DataHash.fromHex(
          "ce787ddbc72d440642a22f06d646988853203a76cc4412b6090127060657b56c")));

  final output3 = TransactionOutput(
    address: externalAddress,
    amount: Value(
        coin: BigInt.from(1180940),
        multiAsset: MultiAsset({
          PolicyID.fromHex(
                  "e93957943cf62a16bf6bedb2ac554a1b15849d14107bccf1f76cc146"):
              Assets(
                  {AssetName.fromHex("4164612070726f7669646572"): BigInt.one})
        })),
  );
  final output4 = TransactionOutput(
    address: externalAddress,
    amount: Value(
      coin: BigInt.from(1193870),
      multiAsset: MultiAsset(
        {
          PolicyID.fromHex(
                  "e93957943cf62a16bf6bedb2ac554a1b15849d14107bccf1f76cc146"):
              Assets({
            AssetName.fromHex("446f6c6c61722070726f7669646572"): BigInt.one,
          })
        },
      ),
    ),
  );
  final mint = Mint([
    MintInfo(
        policyID: PolicyID.fromHex(
            "e93957943cf62a16bf6bedb2ac554a1b15849d14107bccf1f76cc146"),
        assets: MintAssets({
          AssetName.fromHex("4164612070726f7669646572"): BigInt.one,
          AssetName.fromHex("446f6c6c61722070726f7669646572"): BigInt.one,
        }))
  ]);
  final collateral = TransactionInput(
      transactionId: TransactionHash.fromHex(
          "036113b2561c39aa68bcafb5593d533a1393a61475c773ed53e844303eed2e81"),
      index: 0);
  final collateralreturn = TransactionOutput(
      address: internalAddress, amount: Value(coin: BigInt.from(9999289393)));
  final BigInt totalcollateral = BigInt.from(710607);

  final metadata = TransactionMetadata.fromJsonSchema(json: [
    2,
    [
      [
        "run-lite",
        [""]
      ],
      [
        [
          "run-lite-addr_test1qzqjdydkg29ewmj7wtsqfuv8ds2kdglnlrxqtj2qtd6u3",
          "n8y2nhz84ku2fkpa4hazt36q637sz4h4tvxxvca5qf42x9qxud62y"
        ]
      ]
    ]
  ], jsonSchema: MetadataJsonSchema.noConversions);

  final AuxiliaryData auxiliaryData = AuxiliaryData(
      preferAlonzoFormat: true,
      metadata:
          GeneralTransactionMetadata(metadata: {BigInt.from(1564): metadata}));

  final body = TransactionBody(
    inputs: [input],
    auxiliaryDataHash: auxiliaryData.toHash(),
    outputs: [
      output1,
      output2,
      output3,
      output4,
    ],
    fee: BigInt.from(473738),
    scriptDataHash: ScriptDataHash.fromHex(
        "5f56ac7d96f2a5c8eda8696adf2fb6451b955b303314a98eca6ff0b24ed8cfa8"),
    mint: mint,
    collateral: [collateral],
    collateralReturn: collateralreturn,
    totalCollateral: totalcollateral,
  );
  final signerKey = AdaPrivateKey.fromBytes(external.bip44.privateKey.raw);
  final ws = TransactionWitnessSet(
    plutusScripts: [
      PlutusScript(
          bytes: BytesUtils.fromHexString(_plData),
          language: Language.plutusV2),
    ],
    vKeys: [
      Vkeywitness(
          vKey: Vkey(external.bip44.publicKey.compressed.sublist(1)),
          signature: Ed25519Signature(signerKey.sign(body.toHash().data)))
    ],
    plutusData: plutusData,
    redeemers: [
      Redeemer(
          tag: RedeemerTag.mint,
          index: BigInt.zero,
          data:
              ConstrPlutusData(alternative: BigInt.zero, data: PlutusList([])),
          exUnits:
              ExUnits(mem: BigInt.from(1123976), steps: BigInt.from(354221445)))
    ],
  );
  final transaction =
      ADATransaction(body: body, witnessSet: ws, data: auxiliaryData);
  final hash = body.toHash().toHex();
  assert(hash ==
      "05ddd72d58d663c4a1d4c282ee653184ecc44df8595e07e70562badf03a90ba0");
  final provider = BlockforestProvider(BlockforestHTTPProvider(
      url: "https://cardano-preprod.blockfrost.io/api/v0/",
      projectId: "preprodMVwzqm4PuBDBSfEULoMzoj5QZcy5o3z5"));
  await provider.request(BlockfrostRequestSubmitTransaction(
      transactionCborBytes: transaction.serialize()));

  /// https://preprod.cardanoscan.io/transaction/05ddd72d58d663c4a1d4c282ee653184ecc44df8595e07e70562badf03a90ba0?tab=tokenmint
}