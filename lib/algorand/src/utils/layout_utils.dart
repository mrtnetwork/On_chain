import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/algorand/src/address/address.dart';
import 'package:on_chain/exception/onchain_error.dart';

class AlgoBinaryLayout {
  static MsgPackBinaryLayout? defaultBinaryLayout(
    String? property,
    RequestLayoutParams<dynamic, Map<String, dynamic>, LayoutRepository>
    params, {
    bool optional = false,
    int? length,
  }) {
    if (params.action.isEncode) {
      final List? data = JsonParser.valueAsList(params.encodeValue);
      if (data == null) {
        if (!optional) {
          throw OnChainErrors.algoPlugin(
            "defaultBinaryLayout",
            reason: "Missing binary source",
            details: {"property": property},
          );
        }
        return null;
      }
      if (length != null) {
        if (data.length != length) {
          throw OnChainErrors.algoPlugin(
            "defaultBinaryLayout",
            reason: "Invalid binary source length",
            details: {"property": property},
          );
        }
        if (data.every((e) => e == 0)) return null;
      } else {
        if (data.isEmpty) return null;
      }
    }
    return MsgPackBinaryLayout(property: property);
  }

  static MsgPackBinaryLayout? optionalDefaultBinaryLayout(
    String? property,
    RequestLayoutParams<dynamic, Map<String, dynamic>, LayoutRepository> params,
  ) => defaultBinaryLayout(property, params, optional: true);

  static MsgPackBinaryLayout? defaultBinary32Layout(
    String? property,
    RequestLayoutParams<dynamic, Map<String, dynamic>, LayoutRepository> params,
  ) => defaultBinaryLayout(property, params, optional: false, length: 32);

  static MsgPackBinaryLayout? optionalDefaultBinary32Layout(
    String? property,
    RequestLayoutParams<dynamic, Map<String, dynamic>, LayoutRepository> params,
  ) => defaultBinaryLayout(property, params, optional: true, length: 32);
  static MsgPackBinaryLayout? optionalDefaultBinary64Layout(
    String? property,
    RequestLayoutParams<dynamic, Map<String, dynamic>, LayoutRepository> params,
  ) => defaultBinaryLayout(property, params, optional: true, length: 64);
  static MsgPackBinaryLayout? defaultBinary64Layout(
    String? property,
    RequestLayoutParams<dynamic, Map<String, dynamic>, LayoutRepository> params,
  ) => defaultBinaryLayout(property, params, optional: false, length: 64);
}

class AlgoAddressLayout {
  static MsgPackBinaryLayout? defaultAddressLayout(
    String? property,
    RequestLayoutParams<dynamic, Map<String, dynamic>, LayoutRepository>
    params, {
    bool optional = false,
  }) {
    if (params.action.isEncode) {
      final List<int>? data = JsonParser.valueAsBytes(params.encodeValue);
      if (data == null) {
        if (!optional) {
          throw OnChainErrors.algoPlugin(
            "defaultAddressLayout",
            reason: "Missing address source",
            details: {"property": property},
          );
        }
        return null;
      }
      if (data.length != AlgoAddress.bytesLength) {
        throw OnChainErrors.algoPlugin(
          "defaultAddressLayout",
          reason: "Invalid address bytes length.",
          details: {"property": property},
        );
      }
      if (data.every((e) => e == 0)) return null;
    }
    return MsgPackBinaryLayout();
  }

  static MsgPackBinaryLayout? optionalDefaultAddressLayout(
    String? property,
    RequestLayoutParams<dynamic, Map<String, dynamic>, LayoutRepository> params,
  ) => defaultAddressLayout(property, params, optional: true);
}

class AlgoStringLayout {
  static MsgPackStringLayout? defaultStringLayout(
    String? property,
    RequestLayoutParams<dynamic, Map<String, dynamic>, LayoutRepository>
    params, {
    bool optional = false,
  }) {
    if (params.action.isEncode) {
      final String? data = JsonParser.valueAsString(params.encodeValue);
      if (data == null) {
        if (!optional) {
          throw OnChainErrors.algoPlugin(
            "defaultStringLayout",
            reason: "Missing string source",
            details: {"property": property},
          );
        }
        return null;
      }
      if (data.isEmpty) return null;
    }
    return MsgPackStringLayout(property: property);
  }

  static MsgPackStringLayout? optionalDefaultStringLayout(
    String? property,
    RequestLayoutParams<dynamic, Map<String, dynamic>, LayoutRepository> params,
  ) => defaultStringLayout(property, params, optional: true);
}

class AlgoBigIntLayout {
  static MsgPackBigIntLayout? defaultU64Layout(
    String? property,
    RequestLayoutParams<dynamic, Map<String, dynamic>, LayoutRepository>
    params, {
    bool optional = false,
  }) {
    if (params.action.isEncode) {
      final BigInt? data = JsonParser.valueAsBigInt(params.encodeValue);
      if (data == null) {
        if (!optional) {
          throw OnChainErrors.algoPlugin(
            "defaultU64Layout",
            reason: "Missing bigint source",
            details: {"property": property},
          );
        }
        return null;
      }
      if (data.isNegative) {
        throw OnChainErrors.algoPlugin(
          "defaultU64Layout",
          reason: "Invalid unsigned BigInt.",
          details: {"property": property, "value": data.toString()},
        );
      }
      if (data == BigInt.zero) return null;
    }

    return MsgPackBigIntLayout(
      property: property,
      validator: LayoutConst.u64(),
    );
  }

  static MsgPackBigIntLayout? optionalDefaultU64Layout(
    String? property,
    RequestLayoutParams<dynamic, Map<String, dynamic>, LayoutRepository> params,
  ) {
    return defaultU64Layout(property, params, optional: true);
  }
}

class AlgoMapLayout {
  static MsgPackFixedKeyDynamicLazyValueMapLayout? optionalDefaultMapLayout(
    MsgPackFixedKeyDynamicLazyValueMapLayout layout,
    RequestLayoutParams<dynamic, Map<String, dynamic>, LayoutRepository> params,
  ) {
    if (params.action.isEncode && params.encodeValue == null) {
      return null;
    }
    return layout;
  }

  static MsgPackFixedKeyFixedLazyValueMapLayout?
  optionalDefaultFixedKeyValueMapLayout(
    MsgPackFixedKeyFixedLazyValueMapLayout layout,
    RequestLayoutParams<dynamic, Map<String, dynamic>, LayoutRepository> params,
  ) {
    if (params.action.isEncode && params.encodeValue == null) {
      return null;
    }
    return layout;
  }
}

class AlgoLayoutArray {
  static MsgPackArrayLayout? defaultArrayLayout(
    Layout inner,
    String? property,
    RequestLayoutParams<dynamic, Map<String, dynamic>, LayoutRepository>
    params, {
    bool optional = false,
  }) {
    if (params.action.isEncode) {
      final List? data = JsonParser.valueAsList(params.encodeValue);
      if (data == null) {
        if (!optional) {
          throw OnChainErrors.algoPlugin(
            "defaultArrayLayout",
            reason: "Missing array source",
            details: {"property": property},
          );
        }
        return null;
      }
      if (data.isEmpty) return null;
    }
    return MsgPackArrayLayout(inner, property: property);
  }

  static MsgPackArrayLayout? optionalDefaultArrayLayout(
    Layout inner,
    String? property,
    RequestLayoutParams<dynamic, Map<String, dynamic>, LayoutRepository> params,
  ) {
    return defaultArrayLayout(inner, property, params, optional: true);
  }

  static MsgPackArrayLayout? optionalDefaultArrayOfBinaryLayout(
    String? property,
    RequestLayoutParams<dynamic, Map<String, dynamic>, LayoutRepository> params,
  ) {
    return defaultArrayLayout(
      MsgPackBinaryLayout(),
      property,
      params,
      optional: true,
    );
  }

  static MsgPackArrayLayout? defaultArrayOfBinaryLayout(
    String? property,
    RequestLayoutParams<dynamic, Map<String, dynamic>, LayoutRepository> params,
  ) {
    return defaultArrayLayout(
      MsgPackBinaryLayout(),
      property,
      params,
      optional: false,
    );
  }

  static MsgPackArrayLayout? defaultArrayOfBinary32Layout(
    String? property,
    RequestLayoutParams<dynamic, Map<String, dynamic>, LayoutRepository> params,
  ) {
    return defaultArrayLayout(
      MsgPackBinaryLayout(fixedLength: 32),
      property,
      params,
      optional: false,
    );
  }

  static MsgPackArrayLayout? defaultArrayOfAddressLayout(
    String? property,
    RequestLayoutParams<dynamic, Map<String, dynamic>, LayoutRepository> params,
  ) {
    return defaultArrayLayout(
      MsgPackBinaryLayout(fixedLength: 32),
      property,
      params,
      optional: false,
    );
  }

  static MsgPackArrayLayout? optionalDefaultArrayOfAddressLayout(
    String? property,
    RequestLayoutParams<dynamic, Map<String, dynamic>, LayoutRepository> params,
  ) {
    return defaultArrayLayout(
      MsgPackBinaryLayout(fixedLength: 32),
      property,
      params,
      optional: true,
    );
  }

  static MsgPackArrayLayout? optionalDefaultArrayOfU64Layout(
    String? property,
    RequestLayoutParams<dynamic, Map<String, dynamic>, LayoutRepository> params,
  ) {
    return defaultArrayLayout(
      MsgPackBigIntLayout(validator: LayoutConst.u64()),
      property,
      params,
      optional: true,
    );
  }

  static MsgPackArrayLayout? defaultArrayOfU64Layout(
    String? property,
    RequestLayoutParams<dynamic, Map<String, dynamic>, LayoutRepository> params,
  ) {
    return defaultArrayLayout(
      MsgPackBigIntLayout(validator: LayoutConst.u64(), property: property),
      property,
      params,
      optional: false,
    );
  }
}

class AlgoBooleanLayout {
  static MsgPackBoolLayout? defaultBooleanLayout(
    String? property,
    RequestLayoutParams<dynamic, Map<String, dynamic>, LayoutRepository>
    params, {
    bool optional = false,
  }) {
    if (params.action.isEncode) {
      final bool? data = JsonParser.valueAsBool(params.encodeValue);
      if (data == null) {
        if (!optional) {
          throw OnChainErrors.algoPlugin(
            "defaultBooleanLayout",
            reason: "Missing bool source",
            details: {"property": property},
          );
        }
        return null;
      }
      if (!data) return null;
    }
    return MsgPackBoolLayout(property: property);
  }

  static MsgPackBoolLayout? optionalDefaultBooleanLayout(
    String? property,
    RequestLayoutParams<dynamic, Map<String, dynamic>, LayoutRepository>
    params, {
    bool optional = false,
  }) {
    return defaultBooleanLayout(property, params, optional: true);
  }
}
