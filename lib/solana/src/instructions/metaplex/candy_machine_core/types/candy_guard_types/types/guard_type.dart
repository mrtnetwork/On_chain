import 'package:on_chain/solana/src/exception/exception.dart';

class GuardType {
  final String name;
  final int value;

  const GuardType._(this.name, this.value);

  static const GuardType botTax = GuardType._("BotTax", 0);
  static const GuardType solPayment = GuardType._("SolPayment", 1);
  static const GuardType tokenPayment = GuardType._("TokenPayment", 2);
  static const GuardType startDate = GuardType._("StartDate", 3);
  static const GuardType thirdPartySigner = GuardType._("ThirdPartySigner", 4);
  static const GuardType tokenGate = GuardType._("TokenGate", 5);
  static const GuardType gatekeeper = GuardType._("Gatekeeper", 6);
  static const GuardType endDate = GuardType._("EndDate", 7);
  static const GuardType allowList = GuardType._("AllowList", 8);
  static const GuardType mintLimit = GuardType._("MintLimit", 9);
  static const GuardType nftPayment = GuardType._("NftPayment", 10);
  static const GuardType redeemedAmount = GuardType._("RedeemedAmount", 11);
  static const GuardType addressGate = GuardType._("AddressGate", 12);
  static const GuardType nftGate = GuardType._("NftGate", 13);
  static const GuardType nftBurn = GuardType._("NftBurn", 14);
  static const GuardType tokenBurn = GuardType._("TokenBurn", 15);
  static const GuardType freezeSolPayment = GuardType._("FreezeSolPayment", 16);
  static const GuardType freezeTokenPayment =
      GuardType._("FreezeTokenPayment", 17);
  static const GuardType programGate = GuardType._("ProgramGate", 18);
  static const GuardType allocation = GuardType._("Allocation", 19);
  static const GuardType token2022Payment = GuardType._("Token2022Payment", 20);

  static const List<GuardType> values = [
    botTax,
    solPayment,
    tokenPayment,
    startDate,
    thirdPartySigner,
    tokenGate,
    gatekeeper,
    endDate,
    allowList,
    mintLimit,
    nftPayment,
    redeemedAmount,
    addressGate,
    nftGate,
    nftBurn,
    tokenBurn,
    freezeSolPayment,
    freezeTokenPayment,
    programGate,
    allocation,
    token2022Payment,
  ];

  static GuardType fromValue(int value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw SolanaPluginException(
          "No GuardType found matching the specified value",
          details: {"value": value}),
    );
  }
}
