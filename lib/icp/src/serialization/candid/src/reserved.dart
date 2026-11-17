import 'serializer.dart';

/// Candid reserved type.
class Reserved {
  const Reserved();
  void serialize(Serializer s) => s.serializeNull();
}

/// Candid empty type (cannot be serialized).
class Empty {
  const Empty();
}
