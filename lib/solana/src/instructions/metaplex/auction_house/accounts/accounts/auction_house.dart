import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/auction_house/types/types/authority_scope.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class _Utils {
  static const List<int> discriminator = [40, 108, 215, 107, 213, 85, 245, 48];
  static StructLayout get layout => LayoutConst.struct([
        LayoutConst.blob(8, property: 'discriminator'),
        SolanaLayoutUtils.publicKey('auctionHouseFeeAccount'),
        SolanaLayoutUtils.publicKey('auctionHouseTreasury'),
        SolanaLayoutUtils.publicKey('treasuryWithdrawalDestination'),
        SolanaLayoutUtils.publicKey('feeWithdrawalDestination'),
        SolanaLayoutUtils.publicKey('treasuryMint'),
        SolanaLayoutUtils.publicKey('authority'),
        SolanaLayoutUtils.publicKey('creator'),
        LayoutConst.u8(property: 'bump'),
        LayoutConst.u8(property: 'treasuryBump'),
        LayoutConst.u8(property: 'feePayerBump'),
        LayoutConst.u16(property: 'sellerFeeBasisPoints'),
        LayoutConst.boolean(property: 'requiresSignOff'),
        LayoutConst.boolean(property: 'canChangeSalePrice'),
        LayoutConst.u8(property: 'escrowPaymentBump'),
        LayoutConst.boolean(property: 'hasAuctioneer'),
        SolanaLayoutUtils.publicKey('auctioneerAddress'),
        LayoutConst.array(LayoutConst.boolean(), 7, property: 'scopes')
      ]);

  static List<AuthorityScope> decodeScoops(List<bool> bytes) {
    final List<AuthorityScope> scopes = [];
    for (int i = 0; i < AuthorityScope.values.length; i++) {
      if (!bytes[i]) continue;
      scopes.add(AuthorityScope.fromValue(i));
    }
    return scopes;
  }
}

class AuctionHouse extends BorshLayoutSerializable {
  static int get size => _Utils.layout.span;
  final SolAddress auctionHouseFeeAccount;
  final SolAddress auctionHouseTreasury;
  final SolAddress treasuryWithdrawalDestination;
  final SolAddress feeWithdrawalDestination;
  final SolAddress treasuryMint;
  final SolAddress authority;
  final SolAddress creator;
  final int bump;
  final int treasuryBump;
  final int feePayerBump;
  final int sellerFeeBasisPoints;
  final bool requiresSignOff;
  final bool canChangeSalePrice;
  final int escrowPaymentBump;
  final bool hasAuctioneer;
  final SolAddress auctioneerAddress;
  final List<bool> scopes;

  const AuctionHouse(
      {required this.auctionHouseFeeAccount,
      required this.auctionHouseTreasury,
      required this.treasuryWithdrawalDestination,
      required this.feeWithdrawalDestination,
      required this.treasuryMint,
      required this.authority,
      required this.creator,
      required this.bump,
      required this.treasuryBump,
      required this.feePayerBump,
      required this.sellerFeeBasisPoints,
      required this.requiresSignOff,
      required this.canChangeSalePrice,
      required this.escrowPaymentBump,
      required this.hasAuctioneer,
      required this.auctioneerAddress,
      required this.scopes});
  factory AuctionHouse.fromBuffer(List<int> data) {
    final decode = BorshLayoutSerializable.decode(
        bytes: data,
        layout: _Utils.layout,
        validator: {'discriminator': _Utils.discriminator});
    return AuctionHouse(
        auctionHouseFeeAccount: decode['auctionHouseFeeAccount'],
        auctionHouseTreasury: decode['auctionHouseTreasury'],
        treasuryWithdrawalDestination: decode['treasuryWithdrawalDestination'],
        feeWithdrawalDestination: decode['feeWithdrawalDestination'],
        treasuryMint: decode['treasuryMint'],
        authority: decode['authority'],
        creator: decode['creator'],
        bump: decode['bump'],
        treasuryBump: decode['treasuryBump'],
        feePayerBump: decode['feePayerBump'],
        sellerFeeBasisPoints: decode['sellerFeeBasisPoints'],
        requiresSignOff: decode['requiresSignOff'],
        canChangeSalePrice: decode['canChangeSalePrice'],
        escrowPaymentBump: decode['escrowPaymentBump'],
        hasAuctioneer: decode['hasAuctioneer'],
        auctioneerAddress: decode['auctioneerAddress'],
        scopes: (decode['scopes'] as List).cast());
  }

  List<AuthorityScope> get activeScoopes => _Utils.decodeScoops(scopes);

  @override
  StructLayout get layout => _Utils.layout;
  @override
  Map<String, dynamic> serialize() {
    return {
      'discriminator': _Utils.discriminator,
      'auctionHouseFeeAccount': auctionHouseFeeAccount,
      'auctionHouseTreasury': auctionHouseTreasury,
      'treasuryWithdrawalDestination': treasuryWithdrawalDestination,
      'feeWithdrawalDestination': feeWithdrawalDestination,
      'treasuryMint': treasuryMint,
      'authority': authority,
      'creator': creator,
      'bump': bump,
      'treasuryBump': treasuryBump,
      'feePayerBump': feePayerBump,
      'sellerFeeBasisPoints': sellerFeeBasisPoints,
      'requiresSignOff': requiresSignOff,
      'canChangeSalePrice': canChangeSalePrice,
      'escrowPaymentBump': escrowPaymentBump,
      'hasAuctioneer': hasAuctioneer,
      'auctioneerAddress': auctioneerAddress,
      'scopes': scopes,
    };
  }

  @override
  String toString() {
    return 'AuctionHouse${serialize()}';
  }
}
