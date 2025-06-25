import 'package:blockchain_utils/exception/exception/exception.dart';
import 'package:blockchain_utils/utils/numbers/utils/bigint_utils.dart';
import 'package:blockchain_utils/utils/numbers/utils/int_utils.dart';
import 'package:on_chain/sui/src/exception/exception.dart';

extension QuickMap on Map<String, dynamic> {
  static const Map<String, dynamic> _map = {};
  static const List _list = [];
  T as<T>(String key, {BlockchainUtilsException? error}) {
    final value = this[key];
    if (value == null) {
      if (null is T) {
        return null as T;
      }
      throw error ??
          DartSuiPluginException('Key not found.',
              details: {'key': key, 'data': this});
    }
    try {
      return value as T;
    } on TypeError {
      throw error ??
          DartSuiPluginException('Incorrect value.', details: {
            'key': key,
            'expected': '$T',
            'value': value.runtimeType,
            'data': this
          });
    }
  }

  T asBigInt<T>(String key) {
    final value = this[key];
    if (value == null) {
      if (null is T) {
        return null as T;
      }
      throw DartSuiPluginException('Key not found.',
          details: {'key': key, 'data': this});
    }
    try {
      return BigintUtils.parse(value) as T;
    } on TypeError {
      throw DartSuiPluginException('Incorrect value.', details: {
        'key': key,
        'expected': '$T',
        'value': value.runtimeType,
        'data': this
      });
    }
  }

  T asInt<T>(String key) {
    final value = this[key];
    if (value == null) {
      if (null is T) {
        return null as T;
      }
      throw DartSuiPluginException('Key not found.',
          details: {'key': key, 'data': this});
    }
    try {
      return IntUtils.parse(value) as T;
    } on TypeError {
      throw DartSuiPluginException('Incorrect value.', details: {
        'key': key,
        'expected': '$T',
        'value': value.runtimeType,
        'data': this
      });
    }
  }

  E asMap<E>(String key, {BlockchainUtilsException? error}) {
    if (_map is! E) {
      throw const DartSuiPluginException(
          'Invalid map casting. only use `asMap` method for casting Map<String,dynamic>.');
    }
    final Map? value = as(key);
    if (value == null) {
      if (null is E) {
        return null as E;
      }
      throw error ??
          DartSuiPluginException('Key not found.',
              details: {'key': key, 'data': this});
    }
    try {
      return value.cast<String, dynamic>() as E;
    } on TypeError {
      throw error ??
          DartSuiPluginException('Incorrect value.', details: {
            'key': key,
            'expected': '$E',
            'value': value.runtimeType,
            'data': this
          });
    }
  }

  E asBytes<E>(String key) {
    if (<int>[] is! E) {
      throw const DartSuiPluginException(
          'Invalid bytes casting. only use `valueAsList` method for bytes.');
    }
    final List? value = as(key);
    if (value == null) {
      if (null is E) {
        return null as E;
      }
      throw DartSuiPluginException('Key not found.',
          details: {'key': key, 'data': this});
    }
    try {
      return value.cast<int>() as E;
    } on TypeError {
      throw DartSuiPluginException('Incorrect value.', details: {
        'key': key,
        'expected': '$E',
        'value': value.runtimeType,
        'data': this
      });
    }
  }

  List<Map<String, dynamic>>? asListOfMap(String key,
      {bool throwOnNull = true}) {
    final List? value = as(key);
    if (value == null) {
      if (!throwOnNull) {
        return null;
      }
      throw DartSuiPluginException('Key not found.',
          details: {'key': key, 'data': this});
    }
    try {
      return value.map((e) => (e as Map).cast<String, dynamic>()).toList();
    } catch (e, s) {
      throw DartSuiPluginException('Incorrect value.', details: {
        'key': key,
        'value': value.runtimeType,
        'data': this,
        'error': e.toString(),
        'stack': s.toString()
      });
    }
  }

  List<String>? asListOfString(String key, {bool throwOnNull = true}) {
    final List? value = as(key);
    if (value == null) {
      if (!throwOnNull) {
        return null;
      }
      throw DartSuiPluginException('Key not found.',
          details: {'key': key, 'data': this});
    }
    try {
      return value.cast<String>();
    } catch (e, s) {
      throw DartSuiPluginException('Incorrect value.', details: {
        'key': key,
        'value': value.runtimeType,
        'data': this,
        'error': e.toString(),
        'stack': s.toString()
      });
    }
  }

  List<List<int>>? asListOfBytes(String key, {bool throwOnNull = true}) {
    final List? value = as(key);
    if (value == null) {
      if (!throwOnNull) {
        return null;
      }
      throw DartSuiPluginException('Key not found.',
          details: {'key': key, 'data': this});
    }
    try {
      return value.map((e) => (e as List).cast<int>()).toList();
    } catch (e, s) {
      throw DartSuiPluginException('Incorrect value.', details: {
        'key': key,
        'value': value.runtimeType,
        'data': this,
        'error': e.toString(),
        'stack': s.toString()
      });
    }
  }

  E _valueAsList<T, E>(String key) {
    if (_list is! E) {
      throw const DartSuiPluginException(
          'Invalid list casting. only use `valueAsList` method for list casting.');
    }
    final List? value = as(key);
    if (value == null) {
      if (null is E) {
        return null as E;
      }
      throw DartSuiPluginException('Key not found.',
          details: {'key': key, 'data': this});
    }
    try {
      if (_map is T) {
        return value.map((e) => (e as Map).cast<String, dynamic>()).toList()
            as E;
      }
      return value.cast<T>() as E;
    } on TypeError {
      throw DartSuiPluginException('Incorrect value.', details: {
        'key': key,
        'expected': '$T',
        'value': value.runtimeType,
        'data': this
      });
    }
  }

  E? mybeAs<E, T>({required String key, required E Function(T e) onValue}) {
    if (this[key] != null) {
      if (_map is T) {
        return onValue(asMap(key));
      }

      if (_list is T) {
        return onValue(_valueAsList(key));
      }
      return onValue(as(key));
    }
    return null;
  }
}
