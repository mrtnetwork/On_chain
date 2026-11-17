import 'package:blockchain_utils/chain/address/address.dart';
import 'package:blockchain_utils/encoding/encoding.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/tezos/src/address/address.dart';
import 'package:on_chain/tezos/src/crypto/crypto.dart';

class TezosLayoutUtils {
  static Layout<int> get tzUint8 => LayoutConst.u8();
  static Layout<int> get tzUint16 => LayoutConst.u16be();
  static Layout<int> get tzUint32 => LayoutConst.u32be();
  static Layout<int> get tzInt8 => LayoutConst.i8();
  static Layout<int> get tzInt32 => LayoutConst.i32Be();
  static Layout<bool> get tzBool =>
      LayoutConst.boolean(trueFlag: BinaryOps.mask8);
  static Layout<T?> optionLayout<T>(Layout<T> layout) =>
      OptionalLayout(layout, someFlag: BinaryOps.mask8);
  static Layout<BigInt> get tzNat => NatLayout();
  static Layout<BigInt> get tzZ => ZarithIntLayout();

  /// UTF-8 string, length-prefixed the same way as [DynamicBytesLayout].
  static Layout<String> get tzString => ConvLayout<String, List<int>>(
    const DynamicBytesLayout(),
    toWire: (s) => StringUtils.encode(s),
    fromWire: (b) => StringUtils.decode(b),
  );

  static Layout<T> _pkCase<T extends TezosPublicKey>(
    int width,
    T Function(List<int>) wrap,
  ) => ConvLayout<T, List<int>>(
    LayoutConst.fixedBlobN(width),
    toWire: (pk) => pk.toBytes(),
    fromWire: wrap,
  );

  static Layout<TezosPublicKey> publicKeyLayout() =>
      TaggedUnionLayout<TezosPublicKey>(
        tagLayout: TezosLayoutUtils.tzUint8,
        tagFor: (pk) => pk.type.tag,
        cases: [
          UnionCase<TezosPublicKey>(
            TezosKeyType.ed25519.tag,
            _pkCase<TezosEd25519PublicKey>(32, TezosEd25519PublicKey.fromBytes),
          ),
          UnionCase<TezosPublicKey>(
            TezosKeyType.secp256k1.tag,
            _pkCase<TezosSecp256k1PublicKey>(
              33,
              TezosSecp256k1PublicKey.fromBytes,
            ),
          ),
          UnionCase<TezosPublicKey>(
            TezosKeyType.secp256r1.tag,
            _pkCase<TezosSecp256r1PublicKey>(
              33,
              TezosSecp256r1PublicKey.fromBytes,
            ),
          ),
          UnionCase<TezosBlsPublicKey>(
            TezosKeyType.bls.tag,
            _pkCase<TezosBlsPublicKey>(48, TezosBlsPublicKey.fromBytes),
          ),
        ],
      );

  static Layout<T> _pkhCase<T extends TezosAddress>(
    T Function(List<int>) wrap,
  ) => ConvLayout<T, List<int>>(
    LayoutConst.fixedBlobN(20),
    toWire: (pkh) => pkh.hashBytes,
    fromWire: wrap,
  );

  static Layout<TezosAddress> publicKeyHashLayout() =>
      TaggedUnionLayout<TezosAddress>(
        tagLayout: TezosLayoutUtils.tzUint8,
        tagFor: (pkh) {
          final type = TezosKeyType.fromAddressType(pkh.type);
          return type.tag;
        },
        cases: [
          UnionCase<TezosAddress>(
            0,
            _pkhCase<TezosAddress>(
              (p0) => TezosAddress.fromBytes(p0, type: XtzAddrPrefixes.tz1),
            ),
          ),
          UnionCase<TezosAddress>(
            1,
            _pkhCase<TezosAddress>(
              (p0) => TezosAddress.fromBytes(p0, type: XtzAddrPrefixes.tz2),
            ),
          ),
          UnionCase<TezosAddress>(
            2,
            _pkhCase<TezosAddress>(
              (p0) => TezosAddress.fromBytes(p0, type: XtzAddrPrefixes.tz3),
            ),
          ),
          UnionCase<TezosAddress>(
            3,
            _pkhCase<TezosAddress>(
              (p0) => TezosAddress.fromBytes(p0, type: XtzAddrPrefixes.tz4),
            ),
          ),
          UnionCase<TezosAddress>(
            4,
            _pkhCase<TezosAddress>(
              (p0) => TezosAddress.fromBytes(p0, type: XtzAddrPrefixes.tz5),
            ),
          ),
        ],
      );

  static Layout<TezosSignaturePrefix> signaturePrefixCase(
    TezosKeyType algoTag,
    int width,
  ) => ConvLayout<TezosSignaturePrefix, List<int>>(
    LayoutConst.fixedBlobN(width),
    toWire: (p) => p.bytes,
    fromWire: (b) => TezosSignaturePrefix(algoTag, b),
  );

  /// Mirrors `TezosSignature.split_signature`.
  static (TezosSignaturePrefix?, List<int>) splitSignature(
    TezosSignature? signature,
  ) {
    switch (signature) {
      case null:
        return (null, List<int>.filled(64, 0));
      case TezosGenericSignature g:
        return (null, g.bytes);
      case TezosBlsSignature b:
        return (
          TezosSignaturePrefix(
            TezosKeyType.bls,
            b.bytes.sublist(0, TezosSignatureConst.blsSignaturePrefixWidth),
          ),
          b.bytes.sublist(TezosSignatureConst.blsSignaturePrefixWidth),
        );
      case TezosMlDsa44Signature m:
        return (
          TezosSignaturePrefix(
            TezosKeyType.mlDsa,
            m.bytes.sublist(0, TezosSignatureConst.mldsa44SignaturePrefixWidth),
          ),
          m.bytes.sublist(TezosSignatureConst.mldsa44SignaturePrefixWidth),
        );
    }
  }
}
