import 'package:blockchain_utils/encoding/encoding.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

class CoreCandyConfigLineSettings extends BorshLayoutSerializable {
  final String prefixName;
  final int nameLength;
  final String prefixUri;
  final int uriLength;
  final bool isSequential;

  const CoreCandyConfigLineSettings({
    required this.prefixName,
    required this.nameLength,
    required this.prefixUri,
    required this.uriLength,
    required this.isSequential,
  });

  static StructLayout get staticLayout => LayoutConst.struct([
    LayoutConst.string(property: 'prefixName'),
    LayoutConst.u32(property: 'nameLength'),
    LayoutConst.string(property: 'prefixUri'),
    LayoutConst.u32(property: 'uriLength'),
    LayoutConst.boolean(property: 'isSequential'),
  ]);

  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'prefixName': prefixName,
      'nameLength': nameLength,
      'prefixUri': prefixUri,
      'uriLength': uriLength,
      'isSequential': isSequential,
    };
  }

  factory CoreCandyConfigLineSettings.fromJson(Map<String, dynamic> json) {
    return CoreCandyConfigLineSettings(
      prefixName: json['prefixName'],
      nameLength: json['nameLength'],
      prefixUri: json['prefixUri'],
      uriLength: json['uriLength'],
      isSequential: json['isSequential'],
    );
  }
}

class CoreCandyHiddenSettings extends BorshLayoutSerializable {
  final String name;
  final String uri;
  final List<int> hash;

  CoreCandyHiddenSettings({
    required this.name,
    required this.uri,
    required List<int> hash,
  }) : hash = List<int>.unmodifiable(hash);

  static StructLayout get staticLayout => LayoutConst.struct([
    LayoutConst.string(property: 'name'),
    LayoutConst.string(property: 'uri'),
    LayoutConst.blob(32, property: 'hash'),
  ]);

  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {'name': name, 'uri': uri, 'hash': hash};
  }

  factory CoreCandyHiddenSettings.fromJson(Map<String, dynamic> json) {
    return CoreCandyHiddenSettings(
      name: json['name'],
      uri: json['uri'],
      hash: (json['hash'] as List).cast<int>(),
    );
  }
}

/// Core Candy Machine configuration data (`CandyMachineData`
/// in the Core Candy IDL).
class CoreCandyMachineData extends BorshLayoutSerializable {
  final BigInt itemsAvailable;
  final BigInt maxSupply;
  final bool isMutable;
  final CoreCandyConfigLineSettings? configLineSettings;
  final CoreCandyHiddenSettings? hiddenSettings;

  const CoreCandyMachineData({
    required this.itemsAvailable,
    required this.maxSupply,
    required this.isMutable,
    this.configLineSettings,
    this.hiddenSettings,
  });

  static StructLayout get staticLayout => LayoutConst.struct([
    LayoutConst.u64(property: 'itemsAvailable'),
    LayoutConst.u64(property: 'maxSupply'),
    LayoutConst.boolean(property: 'isMutable'),
    LayoutConst.optional(
      CoreCandyConfigLineSettings.staticLayout,
      property: 'configLineSettings',
    ),
    LayoutConst.optional(
      CoreCandyHiddenSettings.staticLayout,
      property: 'hiddenSettings',
    ),
  ], property: 'data');

  @override
  StructLayout get layout => staticLayout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'itemsAvailable': itemsAvailable,
      'maxSupply': maxSupply,
      'isMutable': isMutable,
      'configLineSettings': configLineSettings?.serialize(),
      'hiddenSettings': hiddenSettings?.serialize(),
    };
  }

  factory CoreCandyMachineData.fromJson(Map<String, dynamic> json) {
    return CoreCandyMachineData(
      itemsAvailable: json['itemsAvailable'],
      maxSupply: json['maxSupply'],
      isMutable: json['isMutable'],
      configLineSettings:
          json['configLineSettings'] == null
              ? null
              : CoreCandyConfigLineSettings.fromJson(
                (json['configLineSettings'] as Map).cast<String, dynamic>(),
              ),
      hiddenSettings:
          json['hiddenSettings'] == null
              ? null
              : CoreCandyHiddenSettings.fromJson(
                (json['hiddenSettings'] as Map).cast<String, dynamic>(),
              ),
    );
  }
}

/// Typed Core Candy Machine account (Anchor account:
/// 8-byte discriminator + `authority`, `mintAuthority`, `collectionMint`,
/// `itemsRedeemed`, `data: CandyMachineData`).
class CoreCandyMachineAccount extends BorshLayoutSerializable {
  /// sha256("account:CandyMachine")[0..8], verified against the IDL build.
  static const List<int> discriminator = [51, 173, 177, 113, 25, 241, 109, 189];

  final SolAddress authority;
  final SolAddress mintAuthority;
  final SolAddress collectionMint;
  final BigInt itemsRedeemed;
  final CoreCandyMachineData data;

  const CoreCandyMachineAccount({
    required this.authority,
    required this.mintAuthority,
    required this.collectionMint,
    required this.itemsRedeemed,
    required this.data,
  });

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.blob(8, property: 'discriminator'),
    SolanaLayoutUtils.publicKey('authority'),
    SolanaLayoutUtils.publicKey('mintAuthority'),
    SolanaLayoutUtils.publicKey('collectionMint'),
    LayoutConst.u64(property: 'itemsRedeemed'),
    CoreCandyMachineData.staticLayout,
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'discriminator': discriminator,
      'authority': authority,
      'mintAuthority': mintAuthority,
      'collectionMint': collectionMint,
      'itemsRedeemed': itemsRedeemed,
      'data': data.serialize(),
    };
  }

  factory CoreCandyMachineAccount.fromBuffer(List<int> bytes) {
    final decode = BorshLayoutSerializable.decode(
      bytes: bytes,
      layout: _layout,
      validator: {'discriminator': discriminator},
    );
    return CoreCandyMachineAccount(
      authority: decode['authority'],
      mintAuthority: decode['mintAuthority'],
      collectionMint: decode['collectionMint'],
      itemsRedeemed: decode['itemsRedeemed'],
      data: CoreCandyMachineData.fromJson(
        (decode['data'] as Map).cast<String, dynamic>(),
      ),
    );
  }
}
