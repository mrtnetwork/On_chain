import 'package:blockchain_utils/encoding/encoding.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/tezos/src/crypto/crypto.dart';
import 'utils.dart';

class TezosSignatureLayout extends Layout<TezosSignature?> {
  const TezosSignatureLayout({super.property}) : super(-1);

  @override
  LayoutDecodeResult<TezosSignature?> decode(
    LayoutByteReader bytes, {
    int offset = 0,
  }) {
    final total = bytes.length - offset;
    if (total == 0) {
      return LayoutDecodeResult(consumed: 0, value: null);
    }
    if (total < TezosKeyType.ed25519.signatureLength) {
      throw OnChainErrors.tezosPlugin(
        "TezosSignatureLayout.decode",
        reason: "Invalid signature bytes length.",
      );
    }
    if (total == TezosKeyType.ed25519.signatureLength) {
      return LayoutDecodeResult(
        consumed: TezosKeyType.ed25519.signatureLength,
        value: TezosGenericSignature(
          bytes.sublist(offset, offset + TezosKeyType.ed25519.signatureLength),
        ),
      );
    }
    int span = 0;
    int flag = bytes.at(offset);
    if (flag != TezosSignatureConst.signaturePrefixMarkerTag) {
      throw OnChainErrors.tezosPlugin(
        "TezosSignatureLayout.decode",
        reason: "Invalid signature bytes.",
      );
    }
    span += 1;
    final r = TezosSignaturePrefix.layout().decode(
      bytes,
      offset: offset + span,
    );
    span += r.consumed;
    final type = r.value.algoTag;
    final signature = [
      ...r.value.bytes,
      ...bytes.sublist(
        offset + span,
        offset +
            span +
            type.signatureLength -
            TezosKeyType.ed25519.signatureLength,
      ),
    ];
    span += type.signatureLength - TezosKeyType.ed25519.signatureLength;
    return LayoutDecodeResult(
      consumed: span,
      value: switch (type) {
        TezosKeyType.bls => TezosBlsSignature(signature),
        TezosKeyType.mlDsa => TezosMlDsa44Signature(signature),
        _ =>
          throw OnChainErrors.tezosPlugin(
            "TezosSignatureLayout.decode",
            reason: "Unexpected signature type.",
          ),
      },
    );
  }

  @override
  int encode(
    TezosSignature? source,
    LayoutByteWriter writer, {
    int offset = 0,
  }) {
    if (source == null) return 0;
    int span = 0;

    final (prefix, suffix) = TezosLayoutUtils.splitSignature(source);
    if (prefix == null) {
      writer.setAll(offset, suffix);
      return suffix.length;
    }

    writer.set(offset + span, TezosSignatureConst.signaturePrefixMarkerTag);
    span += 1;
    span += TezosSignaturePrefix.layout().encode(
      prefix,
      writer,
      offset: offset + span,
    );

    writer.setAll(offset + span, suffix);
    span += suffix.length;
    return span;
  }

  @override
  TezosSignatureLayout clone({String? newProperty}) =>
      TezosSignatureLayout(property: newProperty);
}
