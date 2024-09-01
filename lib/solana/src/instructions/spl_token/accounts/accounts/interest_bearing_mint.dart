import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/instructions.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static final StructLayout layout = LayoutConst.struct([
    SolanaLayoutUtils.publicKey('rateAuthority'),
    LayoutConst.ns64(property: 'initializationTimestamp'),
    LayoutConst.s16(property: "preUpdateAverageRate"),
    LayoutConst.ns64(property: 'lastUpdateTimestamp'),
    LayoutConst.s16(property: "currentRate"),
  ]);

  static int get accountSize => layout.span;

  static Map<String, dynamic> decode(List<int> extensionData) {
    try {
      if (extensionData.length < accountSize) {
        throw SolanaPluginException("Account data length is insufficient.",
            details: {"Expected": accountSize, "length": extensionData.length});
      }
      return LayoutSerializable.decode(bytes: extensionData, layout: layout);
    } catch (e) {
      throw const SolanaPluginException("Invalid extionsion bytes");
    }
  }

  static Map<String, dynamic> decodeFromAccount(List<int> accountBytes) {
    try {
      final extensionBytes =
          SPLToken2022Utils.readExtionsionBytesFromAccountData(
              accountBytes: accountBytes,
              extensionType: ExtensionType.interestBearingConfig);
      return LayoutSerializable.decode(bytes: extensionBytes, layout: layout);
    } catch (e) {
      throw const SolanaPluginException("Invalid extionsion bytes");
    }
  }
}

/// Interest-bearing extension data for mints
class InterestBearingMintConfigState extends LayoutSerializable {
  /// Authority that can set the interest rate and authority
  final SolAddress rateAuthority;

  /// Timestamp of initialization, from which to base interest calculations
  final BigInt initializationTimestamp;

  /// Average rate from initialization until the last time it was updated
  final int preUpdateAverageRate;

  /// Timestamp of the last update, used to calculate the total amount accrued
  final BigInt lastUpdateTimestamp;

  /// Current rate, since the last update
  final int currentRate;

  const InterestBearingMintConfigState(
      {required this.rateAuthority,
      required this.initializationTimestamp,
      required this.preUpdateAverageRate,
      required this.lastUpdateTimestamp,
      required this.currentRate});

  factory InterestBearingMintConfigState.fromBuffer(List<int> extensionData) {
    final decode = _Utils.decode(extensionData);
    return InterestBearingMintConfigState(
        rateAuthority: decode["rateAuthority"],
        initializationTimestamp: decode["initializationTimestamp"],
        preUpdateAverageRate: decode["preUpdateAverageRate"],
        lastUpdateTimestamp: decode["lastUpdateTimestamp"],
        currentRate: decode["currentRate"]);
  }
  factory InterestBearingMintConfigState.fromAccountBytes(
      List<int> accountBytes) {
    final decode = _Utils.decodeFromAccount(accountBytes);
    return InterestBearingMintConfigState(
        rateAuthority: decode["rateAuthority"],
        initializationTimestamp: decode["initializationTimestamp"],
        preUpdateAverageRate: decode["preUpdateAverageRate"],
        lastUpdateTimestamp: decode["lastUpdateTimestamp"],
        currentRate: decode["currentRate"]);
  }

  @override
  StructLayout get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "rateAuthority": rateAuthority,
      "initializationTimestamp": initializationTimestamp,
      "preUpdateAverageRate": preUpdateAverageRate,
      "lastUpdateTimestamp": lastUpdateTimestamp,
      "currentRate": currentRate
    };
  }

  @override
  String toString() {
    return "InterestBearingMintConfigState${serialize()}";
  }
}
