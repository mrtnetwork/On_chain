import 'package:blockchain_utils/blockchain_utils.dart';

import 'bit_reader.dart';
import 'constant.dart';

class ZlibDecoder {
  static List<int> decompress(List<int> input) {
    BitReader bitReader = BitReader(input);
    final int cmf = bitReader.readByte();
    int cm = cmf & 15;
    if (cm != 8) {
      throw MessageException('invalid CM');
    }
    int cinfo = (cmf >> 4) & 15; // Compression info
    if (cinfo > 7) {
      throw MessageException('invalid CINFO');
    }
    int flg = bitReader.readByte();
    if ((cmf * 256 + flg) % 31 != 0) {
      throw MessageException('CMF+FLG checksum failed');
    }
    int fdict = (flg >> 5) & 1;
    if (fdict != 0) {
      throw MessageException('preset dictionary not supported');
    }
    List<int> out = _inflate(bitReader); // decompress DEFLATE data

    bitReader.readBytes(4);
    return out;
  }

  static void _noCompressionBlock(BitReader bitReader, List<int> out) {
    int len = bitReader.readBytes(2);
    bitReader.readBytes(2);
    for (int i = 0; i < len; i++) {
      out.add(bitReader.readByte());
    }
  }

  static String _decodeSymbol(BitReader bitReader, _HuffmanTree tree) {
    _Node node = tree.root;
    while (node.left != null || node.right != null) {
      int b = bitReader.readBit();
      node = (b != 0) ? node.right! : node.left!;
    }
    return node.symbol;
  }

  static void _inflateBlock(BitReader bitReader, _HuffmanTree lengthTree,
      _HuffmanTree distanceTree, List<int> out) {
    while (true) {
      String sym = _decodeSymbol(bitReader, lengthTree);
      int symbol = int.parse(sym);
      if (symbol <= 255) {
        out.add(symbol);
      } else if (symbol == 256) {
        return;
      } else {
        symbol -= 257;
        int length = bitReader.readBits(ZlibConst.lengthExtraBits[symbol]) +
            ZlibConst.lengthBase[symbol];
        String distSym = _decodeSymbol(bitReader, distanceTree);
        int dist = bitReader
                .readBits(ZlibConst.distanceExtraBits[int.parse(distSym)]) +
            ZlibConst.distanceBase[int.parse(distSym)];
        for (int i = 0; i < length; i++) {
          out.add(out[out.length - dist]);
        }
      }
    }
  }

  static List<int> _inflate(BitReader bitReader) {
    int bitFinal = 0;
    List<int> out = [];
    while (bitFinal != 1) {
      bitFinal = bitReader.readBit();
      int type = bitReader.readBits(2);
      if (type == 0) {
        _noCompressionBlock(bitReader, out);
      } else if (type == 1) {
        _fixedBlock(bitReader, out);
      } else if (type == 2) {
        _dynamicBlock(bitReader, out);
      } else {
        throw MessageException('Invalid compressed type');
      }
    }
    return out;
  }

  static void _dynamicBlock(BitReader bitReader, List<int> out) {
    final trees = _decodeTrees(bitReader);
    _inflateBlock(bitReader, trees.item1, trees.item2, out);
  }

  static void _fixedBlock(BitReader bitReader, List<int> out) {
    List<int> bl = [
      ...List<int>.filled(144, 8),
      ...List<int>.filled(112, 9),
      ...List<int>.filled(24, 7),
      ...List<int>.filled(8, 8)
    ];
    _HuffmanTree literalLengthTree =
        _blListToTree(bl, List<int>.generate(286, (index) => index));

    bl = List<int>.filled(32, 5);
    _HuffmanTree distanceTree =
        _blListToTree(bl, List<int>.generate(30, (index) => index));

    _inflateBlock(bitReader, literalLengthTree, distanceTree, out);
  }

  /// cc
  static _HuffmanTree _blListToTree(List<int> bl, List<int> alphabet) {
    int maxBits =
        bl.reduce((value, element) => value > element ? value : element);
    List<int> blCount = List<int>.filled(maxBits + 1, 0);
    for (var bitlen in bl) {
      if (bitlen != 0) {
        blCount[bitlen]++;
      }
    }

    List<int> nextCode = [0, 0];
    for (int bits = 2; bits <= maxBits; bits++) {
      nextCode.add((nextCode[bits - 1] + blCount[bits - 1]) << 1);
    }

    _HuffmanTree t = _HuffmanTree();
    int min = alphabet.length < bl.length ? alphabet.length : bl.length;
    for (int i = 0; i < min; i++) {
      int c = alphabet[i];
      int bitlen = bl[i];
      if (bitlen != 0) {
        t.insert(nextCode[bitlen], bitlen, c.toString());
        nextCode[bitlen]++;
      }
    }
    return t;
  }

  static Tuple<_HuffmanTree, _HuffmanTree> _decodeTrees(BitReader r) {
    int hlit = r.readBits(5) + 257;
    int hdist = r.readBits(5) + 1;
    int hclen = r.readBits(4) + 4;
    List<int> codeLengthTreeBl = List<int>.filled(19, 0);
    for (int i = 0; i < hclen; i++) {
      codeLengthTreeBl[ZlibConst.codeLengthCodesOrder[i]] = r.readBits(3);
    }
    _HuffmanTree codeLengthTree = _blListToTree(
        codeLengthTreeBl, List<int>.generate(19, (index) => index));
    List<int> bl = [];
    while (bl.length < hlit + hdist) {
      String sym = _decodeSymbol(r, codeLengthTree);
      int symbol = int.parse(sym);
      if (symbol >= 0 && symbol <= 15) {
        bl.add(symbol);
      } else if (symbol == 16) {
        int prevCodeLength = bl[bl.length - 1];
        int repeatLength = r.readBits(2) + 3;
        for (int i = 0; i < repeatLength; i++) {
          bl.add(prevCodeLength);
        }
      } else if (symbol == 17) {
        int repeatLength = r.readBits(3) + 3;
        for (int i = 0; i < repeatLength; i++) {
          bl.add(0);
        }
      } else if (symbol == 18) {
        int repeatLength = r.readBits(7) + 11;
        for (int i = 0; i < repeatLength; i++) {
          bl.add(0);
        }
      } else {
        throw MessageException('invalid symbol');
      }
    }
    _HuffmanTree literalLengthTree = _blListToTree(
        bl.sublist(0, hlit), List<int>.generate(286, (index) => index));
    _HuffmanTree distanceTree = _blListToTree(
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
    return "symbol: $symbol left: $left rightL $right";
  }
}

class _HuffmanTree {
  _Node root = _Node();
  @override
  String toString() {
    return "root: $root";
  }

  void insert(int codeword, int n, String symbol) {
    // Insert an entry into the tree mapping `codeword` of len `n` to `symbol`
    _Node node = root;
    for (int i = n - 1; i >= 0; i--) {
      int b = codeword & (1 << i);
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
