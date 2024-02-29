import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/types/candy_guard_types/types.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class GuardSet extends LayoutSerializable {
  final BotTax? botTax;
  final SolPayment? solPayment;
  final TokenPayment? tokenPayment;
  final StartDate? startDate;
  final ThirdPartySigner? thirdPartySigner;
  final TokenGate? tokenGate;
  final Gatekeeper? gatekeeper;
  final EndDate? endDate;
  final AllowList? allowList;
  final MintLimit? mintLimit;
  final NFTPayment? nftPayment;
  final RedeemedAmount? redeemedAmount;
  final AddressGate? addressGate;
  final NftGate? nftGate;
  final NftBurn? nftBurn;
  final TokenBurn? tokenBurn;
  final FreezeSolPayment? freezeSolPayment;
  final FreezeTokenPayment? freezeTokenPayment;
  final ProgramGate? programGate;
  final Allocation? allocation;
  final Token2022Payment? token2022Payment;

  const GuardSet(
      {required this.botTax,
      required this.solPayment,
      required this.tokenPayment,
      required this.startDate,
      required this.thirdPartySigner,
      required this.tokenGate,
      required this.gatekeeper,
      required this.endDate,
      required this.allowList,
      required this.mintLimit,
      required this.nftPayment,
      required this.redeemedAmount,
      required this.addressGate,
      required this.nftGate,
      required this.nftBurn,
      required this.tokenBurn,
      required this.freezeSolPayment,
      required this.freezeTokenPayment,
      required this.programGate,
      required this.allocation,
      required this.token2022Payment});
  factory GuardSet.fromJson(Map<String, dynamic> json) {
    return GuardSet(
        botTax: BotTax.fromJson(json["botTax"]),
        solPayment: SolPayment.fromJson(json["solPayment"]),
        tokenPayment: TokenPayment.fromJson(json["tokenPayment"]),
        startDate: StartDate.fromJson(json["startDate"]),
        thirdPartySigner: ThirdPartySigner.fromJson(json["thirdPartySigner"]),
        tokenGate: TokenGate.fromJson(json["tokenGate"]),
        gatekeeper: Gatekeeper.fromJson(json["gatekeeper"]),
        endDate: EndDate.fromJson(json["endDate"]),
        allowList: AllowList.fromJson(json["allowList"]),
        mintLimit: MintLimit.fromJson(json["mintLimit"]),
        nftPayment: NFTPayment.fromJson(json["nftPayment"]),
        redeemedAmount: RedeemedAmount.fromJson(json["redeemedAmount"]),
        addressGate: AddressGate.fromJson(json["addressGate"]),
        nftGate: NftGate.fromJson(json["nftGate"]),
        nftBurn: NftBurn.fromJson(json["nftBurn"]),
        tokenBurn: TokenBurn.fromJson(json["tokenBurn"]),
        freezeSolPayment: FreezeSolPayment.fromJson(json["freezeSolPayment"]),
        freezeTokenPayment:
            FreezeTokenPayment.fromJson(json["freezeTokenPayment"]),
        programGate: ProgramGate.fromJson(json["programGate"]),
        allocation: Allocation.fromJson(json["allocation"]),
        token2022Payment: Token2022Payment.fromJson(json["token2022Payment"]));
  }

  static final Structure staticLayout = LayoutUtils.struct([
    LayoutUtils.optional(BotTax.staticLayout, property: "botTax"),
    LayoutUtils.optional(SolPayment.staticLayout, property: "solPayment"),
    LayoutUtils.optional(TokenPayment.staticLayout, property: "tokenPayment"),
    LayoutUtils.optional(StartDate.staticLayout, property: "startDate"),
    LayoutUtils.optional(ThirdPartySigner.staticLayout,
        property: "thirdPartySigner"),
    LayoutUtils.optional(TokenGate.staticLayout, property: "tokenGate"),
    LayoutUtils.optional(Gatekeeper.staticLayout, property: "gatekeeper"),
    LayoutUtils.optional(EndDate.staticLayout, property: "endDate"),
    LayoutUtils.optional(AllowList.staticLayout, property: "allowList"),
    LayoutUtils.optional(MintLimit.staticLayout, property: "mintLimit"),
    LayoutUtils.optional(NFTPayment.staticLayout, property: "nftPayment"),
    LayoutUtils.optional(RedeemedAmount.staticLayout,
        property: "redeemedAmount"),
    LayoutUtils.optional(AddressGate.staticLayout, property: "addressGate"),
    LayoutUtils.optional(NftGate.staticLayout, property: "nftGate"),
    LayoutUtils.optional(NftBurn.staticLayout, property: "nftBurn"),
    LayoutUtils.optional(TokenBurn.staticLayout, property: "tokenBurn"),
    LayoutUtils.optional(FreezeSolPayment.staticLayout,
        property: "freezeSolPayment"),
    LayoutUtils.optional(FreezeTokenPayment.staticLayout,
        property: "freezeTokenPayment"),
    LayoutUtils.optional(ProgramGate.staticLayout, property: "programGate"),
    LayoutUtils.optional(Allocation.staticLayout, property: "allocation"),
    LayoutUtils.optional(Token2022Payment.staticLayout,
        property: "token2022Payment"),
  ], "guards");

  @override
  Structure get layout => staticLayout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "botTax": botTax?.serialize(),
      "solPayment": solPayment?.serialize(),
      "tokenPayment": tokenPayment?.serialize(),
      "startDate": startDate?.serialize(),
      "thirdPartySigner": thirdPartySigner?.serialize(),
      "tokenGate": tokenGate?.serialize(),
      "gatekeeper": gatekeeper?.serialize(),
      "endDate": endDate?.serialize(),
      "allowList": allowList?.serialize(),
      "mintLimit": mintLimit?.serialize(),
      "nftPayment": nftPayment?.serialize(),
      "redeemedAmount": redeemedAmount?.serialize(),
      "addressGate": addressGate?.serialize(),
      "nftGate": nftGate?.serialize(),
      "nftBurn": nftBurn?.serialize(),
      "tokenBurn": tokenBurn?.serialize(),
      "freezeSolPayment": freezeSolPayment?.serialize(),
      "freezeTokenPayment": freezeTokenPayment?.serialize(),
      "programGate": programGate?.serialize(),
      "allocation": allocation?.serialize(),
      "token2022Payment": token2022Payment?.serialize()
    };
  }

  @override
  String toString() {
    return "GuardSet${serialize()}";
  }
}
