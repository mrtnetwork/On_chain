import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/mpl_core/layouts/layouts/mpl_core_types.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

/// Core record header (`Key`, Borsh u8, IDL order). The first
/// byte of every Core account tells which struct follows.
class MplCoreKey {
  static const int uninitialized = 0;
  static const int assetV1 = 1;
  static const int hashedAssetV1 = 2;
  static const int pluginHeaderV1 = 3;
  static const int pluginRegistryV1 = 4;
  static const int collectionV1 = 5;
  static const int groupV1 = 6;
}

/// Typed MPL Core AssetV1 header: `key`, `owner`,
/// `updateAuthority`, `name`, `uri`, `seq`. Plugin header/registry records
/// appended after `seq` travel raw in [pluginBytes].
class MplCoreAssetAccount {
  final int key;
  final SolAddress owner;
  final MplCoreUpdateAuthority updateAuthority;
  final String name;
  final String uri;

  /// Sequence number (only set on compressed assets).
  final BigInt? seq;

  /// Raw plugin header/registry bytes after the fixed header (may be empty).
  final List<int> pluginBytes;

  MplCoreAssetAccount({
    required this.key,
    required this.owner,
    required this.updateAuthority,
    required this.name,
    required this.uri,
    required this.seq,
    required List<int> pluginBytes,
  }) : pluginBytes = List<int>.unmodifiable(pluginBytes);

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.u8(property: 'key'),
    SolanaLayoutUtils.publicKey('owner'),
    LayoutConst.wrap(
      MplCoreUpdateAuthority.staticLayout,
      property: 'updateAuthority',
    ),
    LayoutConst.string(property: 'name'),
    LayoutConst.string(property: 'uri'),
    LayoutConst.optional(LayoutConst.u64(), property: 'seq'),
  ]);

  Map<String, dynamic> _headerFields() {
    return {
      'key': key,
      'owner': owner,
      'updateAuthority': updateAuthority.serialize(),
      'name': name,
      'uri': uri,
      'seq': seq,
    };
  }

  /// Full account bytes (Borsh header + raw plugin tail).
  List<int> toBytes() {
    final head = _layout.serialize(_headerFields());
    return [...head, ...pluginBytes];
  }

  factory MplCoreAssetAccount.fromBuffer(List<int> bytes) {
    final decode = BorshLayoutSerializable.decode(
      bytes: bytes,
      layout: _layout,
    );
    if (decode['key'] != MplCoreKey.assetV1) {
      throw BuError(
        OnChainErrorType.solanaPlugin,
        'Not an MPL Core asset account',
        details: {'key': decode['key']?.toString()},
      );
    }
    final account = MplCoreAssetAccount(
      key: decode['key'],
      owner: decode['owner'],
      updateAuthority: MplCoreUpdateAuthority.fromJson(
        (decode['updateAuthority'] as Map).cast<String, dynamic>(),
      ),
      name: decode['name'],
      uri: decode['uri'],
      seq: decode['seq'],
      pluginBytes: const [],
    );
    final headerLength = _layout.serialize(account._headerFields()).length;
    return MplCoreAssetAccount(
      key: account.key,
      owner: account.owner,
      updateAuthority: account.updateAuthority,
      name: account.name,
      uri: account.uri,
      seq: account.seq,
      pluginBytes: bytes.sublist(headerLength),
    );
  }
}

/// Typed MPL Core CollectionV1: `key`, `updateAuthority`,
/// `name`, `uri`, `numMinted`, `currentSize`.
class MplCoreCollectionAccount extends BorshLayoutSerializable {
  final int key;
  final SolAddress updateAuthority;
  final String name;
  final String uri;
  final int numMinted;
  final int currentSize;

  const MplCoreCollectionAccount({
    required this.key,
    required this.updateAuthority,
    required this.name,
    required this.uri,
    required this.numMinted,
    required this.currentSize,
  });

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.u8(property: 'key'),
    SolanaLayoutUtils.publicKey('updateAuthority'),
    LayoutConst.string(property: 'name'),
    LayoutConst.string(property: 'uri'),
    LayoutConst.u32(property: 'numMinted'),
    LayoutConst.u32(property: 'currentSize'),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'key': key,
      'updateAuthority': updateAuthority,
      'name': name,
      'uri': uri,
      'numMinted': numMinted,
      'currentSize': currentSize,
    };
  }

  factory MplCoreCollectionAccount.fromBuffer(List<int> bytes) {
    final decode = BorshLayoutSerializable.decode(
      bytes: bytes,
      layout: _layout,
    );
    if (decode['key'] != MplCoreKey.collectionV1) {
      throw BuError(
        OnChainErrorType.solanaPlugin,
        'Not an MPL Core collection account',
        details: {'key': decode['key']?.toString()},
      );
    }
    return MplCoreCollectionAccount(
      key: decode['key'],
      updateAuthority: decode['updateAuthority'],
      name: decode['name'],
      uri: decode['uri'],
      numMinted: decode['numMinted'],
      currentSize: decode['currentSize'],
    );
  }
}

/// Typed MPL Core GroupV1: `key`, `updateAuthority`, `name`,
/// `uri` plus the four member vectors (`collections`, `groups`,
/// `parentGroups`, `assets`).
class MplCoreGroupAccount extends BorshLayoutSerializable {
  final int key;
  final SolAddress updateAuthority;
  final String name;
  final String uri;
  final List<SolAddress> collections;
  final List<SolAddress> groups;
  final List<SolAddress> parentGroups;
  final List<SolAddress> assets;

  MplCoreGroupAccount({
    required this.key,
    required this.updateAuthority,
    required this.name,
    required this.uri,
    required List<SolAddress> collections,
    required List<SolAddress> groups,
    required List<SolAddress> parentGroups,
    required List<SolAddress> assets,
  }) : collections = List<SolAddress>.unmodifiable(collections),
       groups = List<SolAddress>.unmodifiable(groups),
       parentGroups = List<SolAddress>.unmodifiable(parentGroups),
       assets = List<SolAddress>.unmodifiable(assets);

  static Layout _vec(String property) =>
      LayoutConst.vec(SolanaLayoutUtils.publicKey(), property: property);

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.u8(property: 'key'),
    SolanaLayoutUtils.publicKey('updateAuthority'),
    LayoutConst.string(property: 'name'),
    LayoutConst.string(property: 'uri'),
    _vec('collections'),
    _vec('groups'),
    _vec('parentGroups'),
    _vec('assets'),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'key': key,
      'updateAuthority': updateAuthority,
      'name': name,
      'uri': uri,
      'collections': collections,
      'groups': groups,
      'parentGroups': parentGroups,
      'assets': assets,
    };
  }

  static List<SolAddress> _addrs(dynamic value) =>
      (value as List).cast<SolAddress>();

  factory MplCoreGroupAccount.fromBuffer(List<int> bytes) {
    final decode = BorshLayoutSerializable.decode(
      bytes: bytes,
      layout: _layout,
    );
    if (decode['key'] != MplCoreKey.groupV1) {
      throw BuError(
        OnChainErrorType.solanaPlugin,
        'Not an MPL Core group account',
        details: {'key': decode['key']?.toString()},
      );
    }
    return MplCoreGroupAccount(
      key: decode['key'],
      updateAuthority: decode['updateAuthority'],
      name: decode['name'],
      uri: decode['uri'],
      collections: _addrs(decode['collections']),
      groups: _addrs(decode['groups']),
      parentGroups: _addrs(decode['parentGroups']),
      assets: _addrs(decode['assets']),
    );
  }
}
