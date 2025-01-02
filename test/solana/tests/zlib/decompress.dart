import 'package:blockchain_utils/blockchain_utils.dart';

import 'bit_reader.dart';
import 'constant.dart';

class ZlibDecoder {
  static List<int> decompress(List<int> input) {
    final bitReader = BitReader(input);
    final cmf = bitReader.readByte();
    final cm = cmf & 15;
    if (cm != 8) {
      throw const MessageException('invalid CM');
    }
    final cinfo = (cmf >> 4) & 15; // Compression info
    if (cinfo > 7) {
      throw const MessageException('invalid CINFO');
    }
    final flg = bitReader.readByte();
    if ((cmf * 256 + flg) % 31 != 0) {
      throw const MessageException('CMF+FLG checksum failed');
    }
    final fdict = (flg >> 5) & 1;
    if (fdict != 0) {
      throw const MessageException('preset dictionary not supported');
    }
    final out = _inflate(bitReader); // decompress DEFLATE data

    bitReader.readBytes(4);
    return out;
  }

  static void _noCompressionBlock(BitReader bitReader, List<int> out) {
    final len = bitReader.readBytes(2);
    bitReader.readBytes(2);
    for (var i = 0; i < len; i++) {
      out.add(bitReader.readByte());
    }
  }

  static String _decodeSymbol(BitReader bitReader, _HuffmanTree tree) {
    var node = tree.root;
    while (node.left != null || node.right != null) {
      final b = bitReader.readBit();
      node = (b != 0) ? node.right! : node.left!;
    }
    return node.symbol;
  }

  static void _inflateBlock(BitReader bitReader, _HuffmanTree lengthTree,
      _HuffmanTree distanceTree, List<int> out) {
    while (true) {
      final sym = _decodeSymbol(bitReader, lengthTree);
      var symbol = int.parse(sym);
      if (symbol <= 255) {
        out.add(symbol);
      } else if (symbol == 256) {
        return;
      } else {
        symbol -= 257;
        final length = bitReader.readBits(ZlibConst.lengthExtraBits[symbol]) +
            ZlibConst.lengthBase[symbol];
        final distSym = _decodeSymbol(bitReader, distanceTree);
        final dist = bitReader
                .readBits(ZlibConst.distanceExtraBits[int.parse(distSym)]) +
            ZlibConst.distanceBase[int.parse(distSym)];
        for (var i = 0; i < length; i++) {
          out.add(out[out.length - dist]);
        }
      }
    }
  }

  static List<int> _inflate(BitReader bitReader) {
    var bitFinal = 0;
    final out = <int>[];
    while (bitFinal != 1) {
      bitFinal = bitReader.readBit();
      final type = bitReader.readBits(2);
      if (type == 0) {
        _noCompressionBlock(bitReader, out);
      } else if (type == 1) {
        _fixedBlock(bitReader, out);
      } else if (type == 2) {
        _dynamicBlock(bitReader, out);
      } else {
        throw const MessageException('Invalid compressed type');
      }
    }
    return out;
  }

  static void _dynamicBlock(BitReader bitReader, List<int> out) {
    final trees = _decodeTrees(bitReader);
    _inflateBlock(bitReader, trees.item1, trees.item2, out);
  }

  static void _fixedBlock(BitReader bitReader, List<int> out) {
    var bl = <int>[
      ...List<int>.filled(144, 8),
      ...List<int>.filled(112, 9),
      ...List<int>.filled(24, 7),
      ...List<int>.filled(8, 8)
    ];
    final literalLengthTree =
        _blListToTree(bl, List<int>.generate(286, (index) => index));

    bl = List<int>.filled(32, 5);
    final distanceTree =
        _blListToTree(bl, List<int>.generate(30, (index) => index));

    _inflateBlock(bitReader, literalLengthTree, distanceTree, out);
  }

  /// cc
  static _HuffmanTree _blListToTree(List<int> bl, List<int> alphabet) {
    final maxBits =
        bl.reduce((value, element) => value > element ? value : element);
    final blCount = List<int>.filled(maxBits + 1, 0);
    for (final bitlen in bl) {
      if (bitlen != 0) {
        blCount[bitlen]++;
      }
    }

    final nextCode = <int>[0, 0];
    for (var bits = 2; bits <= maxBits; bits++) {
      nextCode.add((nextCode[bits - 1] + blCount[bits - 1]) << 1);
    }

    final t = _HuffmanTree();
    final min = alphabet.length < bl.length ? alphabet.length : bl.length;
    for (var i = 0; i < min; i++) {
      final c = alphabet[i];
      final bitlen = bl[i];
      if (bitlen != 0) {
        t.insert(nextCode[bitlen], bitlen, c.toString());
        nextCode[bitlen]++;
      }
    }
    return t;
  }

  static Tuple<_HuffmanTree, _HuffmanTree> _decodeTrees(BitReader r) {
    final hlit = r.readBits(5) + 257;
    final hdist = r.readBits(5) + 1;
    final hclen = r.readBits(4) + 4;
    final codeLengthTreeBl = List<int>.filled(19, 0);
    for (var i = 0; i < hclen; i++) {
      codeLengthTreeBl[ZlibConst.codeLengthCodesOrder[i]] = r.readBits(3);
    }
    final codeLengthTree = _blListToTree(
        codeLengthTreeBl, List<int>.generate(19, (index) => index));
    final bl = <int>[];
    while (bl.length < hlit + hdist) {
      final sym = _decodeSymbol(r, codeLengthTree);
      final symbol = int.parse(sym);
      if (symbol >= 0 && symbol <= 15) {
        bl.add(symbol);
      } else if (symbol == 16) {
        final prevCodeLength = bl[bl.length - 1];
        final repeatLength = r.readBits(2) + 3;
        for (var i = 0; i < repeatLength; i++) {
          bl.add(prevCodeLength);
        }
      } else if (symbol == 17) {
        final repeatLength = r.readBits(3) + 3;
        for (var i = 0; i < repeatLength; i++) {
          bl.add(0);
        }
      } else if (symbol == 18) {
        final repeatLength = r.readBits(7) + 11;
        for (var i = 0; i < repeatLength; i++) {
          bl.add(0);
        }
      } else {
        throw const MessageException('invalid symbol');
      }
    }
    final literalLengthTree = _blListToTree(
        bl.sublist(0, hlit), List<int>.generate(286, (index) => index));
    final distanceTree = _blListToTree(
        bl.sublist(hlit), List<int>.generate(30, (index) => index));
    return Tuple(literalLengthTree, distanceTree);
  }
}

class _Node {
  String symbol = '';
  _Node? left;
  _Node? right;
  @override
  String toString() {
    return 'symbol: $symbol left: $left rightL $right';
  }
}

class _HuffmanTree {
  _Node root = _Node();
  @override
  String toString() {
    return 'root: $root';
  }

  void insert(int codeword, int n, String symbol) {
    // Insert an entry into the tree mapping `codeword` of len `n` to `symbol`
    var node = root;
    for (var i = n - 1; i >= 0; i--) {
      final b = codeword & (1 << i);
      _Node? nextNode;
      if (b != 0) {
        nextNode = node.right;
        if (nextNode == null) {
          node.right = _Node();
          nextNode = node.right;
        }
      } else {
        nextNode = node.left;
        if (nextNode == null) {
          node.left = _Node();
          nextNode = node.left;
        }
      }
      node = nextNode!;
    }
    node.symbol = symbol;
  }
}
