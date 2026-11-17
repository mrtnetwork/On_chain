import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/tezos/src/address/address.dart';
import 'michline.dart';

class MichelineUtils {
  static List<int> _annotsToWire(List<String> annots) {
    if (annots.isEmpty) return const [];
    return StringUtils.encode(annots.join(' '));
  }

  static List<String> _annotsFromWire(List<int> bytes) {
    if (bytes.isEmpty) return const [];
    final s = StringUtils.decode(bytes);
    if (s.isEmpty) return const [];
    return s.split(' ');
  }

  static Layout<MichelineExpr> layout() =>
      LazyLayout<MichelineExpr>(() => MichelineExpr.layout());

  /// Annots on wire: [DynamicBytesLayout] = uint30 + space-joined UTF-8/ASCII.
  static ConvLayout<List<String>, List<int>> annotslayout() =>
      ConvLayout<List<String>, List<int>>(
        const DynamicBytesLayout(),
        toWire: _annotsToWire,
        fromWire: _annotsFromWire,
      );

  /// Unit value.
  static MichelinePrimNoArgsNoAnnots unit() =>
      MichelinePrimNoArgsNoAnnots('Unit');

  /// Boolean true.
  static MichelinePrimNoArgsNoAnnots boolTrue() =>
      MichelinePrimNoArgsNoAnnots('True');

  /// Boolean false.
  static MichelinePrimNoArgsNoAnnots boolFalse() =>
      MichelinePrimNoArgsNoAnnots('False');

  /// Boolean from a Dart [bool].
  static MichelinePrimNoArgsNoAnnots michelineBool(bool value) =>
      value ? boolTrue() : boolFalse();

  /// None (option).
  static MichelinePrimNoArgsNoAnnots none() =>
      MichelinePrimNoArgsNoAnnots('None');

  /// Some(value).
  static MichelinePrim1ArgNoAnnots some(MichelineExpr value) =>
      MichelinePrim1ArgNoAnnots('Some', value);

  /// Left(value) for `or` type.
  static MichelinePrim1ArgNoAnnots left(MichelineExpr value) =>
      MichelinePrim1ArgNoAnnots('Left', value);

  /// Right(value) for `or` type.
  static MichelinePrim1ArgNoAnnots right(MichelineExpr value) =>
      MichelinePrim1ArgNoAnnots('Right', value);

  /// Pair(left, right).
  static MichelinePrim2ArgsNoAnnots pair(
    MichelineExpr left,
    MichelineExpr right,
  ) => MichelinePrim2ArgsNoAnnots('Pair', left, right);

  static MichelineExpr pairN(List<MichelineExpr> values) {
    if (values.isEmpty) {
      throw OnChainErrors.tezosMicheline(
        'pairN',
        reason: 'PairN requires at least one value.',
      );
    }
    if (values.length == 1) return values.first;
    var result = values.last;
    for (var i = values.length - 2; i >= 0; i--) {
      result = pair(values[i], result);
    }
    return result;
  }

  /// Elt(key, value) used inside maps / big_maps.
  static MichelinePrim2ArgsNoAnnots elt(
    MichelineExpr key,
    MichelineExpr value,
  ) => MichelinePrim2ArgsNoAnnots('Elt', key, value);

  /// Natural number (non-negative).
  static MichelineInt nat(BigInt value) {
    if (value.isNegative) {
      throw OnChainErrors.tezosMicheline(
        'nat',
        reason: 'Nat cannot be negative.',
      );
    }
    return MichelineInt(value);
  }

  static MichelineInt natFromInt(int value) => nat(BigInt.from(value));

  /// Signed integer.
  static MichelineInt mint(BigInt value) => MichelineInt(value);

  static MichelineInt mintFromInt(int value) =>
      MichelineInt(BigInt.from(value));

  /// Mutez (also encoded as int in MichelineExpr).
  static MichelineInt mutez(BigInt value) {
    if (value.isNegative) {
      throw OnChainErrors.tezosMicheline(
        'mutez',
        reason: 'Mutez cannot be negative.',
      );
    }
    return MichelineInt(value);
  }

  /// Timestamp as seconds since epoch (int form).
  static MichelineInt timestamp(BigInt seconds) => MichelineInt(seconds);

  /// Address / key / key_hash / signature / chain_id as readable string.
  static MichelineString address(TezosAddress addr) =>
      MichelineString(addr.address);

  static MichelineString string(String str) => MichelineString(str);

  static MichelineString key(String k) => MichelineString(k);
  static MichelineString keyHash(String kh) => MichelineString(kh);
  static MichelineString signature(String sig) => MichelineString(sig);
  static MichelineString chainId(String id) => MichelineString(id);
  static MichelineString michelineString(String s) => MichelineString(s);
  static MichelineExpr seq(List<MichelineExpr> items) =>
      MichelineSequence(items);

  /// Bytes from hex or raw.
  static MichelineBytes bytes(List<int> data) => MichelineBytes(data);
  static MichelineBytes bytesFromHex(String hex) =>
      MichelineBytes(BytesUtils.fromHexString(hex));
}
