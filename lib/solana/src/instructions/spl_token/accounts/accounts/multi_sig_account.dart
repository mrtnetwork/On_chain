import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class SolanaMultiSigAccountUtils {
  static final Structure layout = LayoutUtils.struct([
    LayoutUtils.u8('numberOfSigners'),
    LayoutUtils.u8('numberOfPossibleSigners'),
    LayoutUtils.boolean(property: 'isInitialized'),
    LayoutUtils.array(LayoutUtils.publicKey(), 11, property: "signers"),
  ]);

  static int get multisigSize => layout.span;
}

/// Multisignature data.
class SolanaMultiSigAccount extends LayoutSerializable {
  final SolAddress address;

  /// Number of signers required
  final int numberOfSigners;

  /// Number of valid signers
  final int numberOfPossibleSigners;

  /// Is `true` if this structure has been initialized
  final bool isInitialized;

  /// Signer addresses
  final List<SolAddress> signers;

  const SolanaMultiSigAccount(
      {required this.address,
      required this.numberOfSigners,
      required this.numberOfPossibleSigners,
      required this.isInitialized,
      required this.signers});
  factory SolanaMultiSigAccount.fromBuffer(
      {required List<int> data, required SolAddress address}) {
    if (data.length != SolanaMultiSigAccountUtils.multisigSize) {
      throw MessageException("Account data length is insufficient.", details: {
        "Expected": SolanaMultiSigAccountUtils.multisigSize,
        "length": data.length
      });
    }

    final decode = LayoutSerializable.decode(
        bytes: data, layout: SolanaMultiSigAccountUtils.layout);
    final n = decode["numberOfPossibleSigners"];
    return SolanaMultiSigAccount(
        address: address,
        numberOfSigners: decode["numberOfSigners"],
        numberOfPossibleSigners: n,
        isInitialized: decode["isInitialized"],
        signers: (decode["signers"] as List).cast<SolAddress>().sublist(0, n));
  }

  @override
  Structure get layout => SolanaMultiSigAccountUtils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      "numberOfSigners": numberOfSigners,
      "numberOfPossibleSigners": numberOfPossibleSigners,
      "isInitialized": isInitialized,
      "signers": List.generate(
          11,
          (index) => signers.length > index
              ? signers.elementAt(index)
              : SolAddress.defaultPubKey)
    };
  }

  @override
  String toString() {
    return "SolanaMultiSigAccount${serialize()}";
  }
}
