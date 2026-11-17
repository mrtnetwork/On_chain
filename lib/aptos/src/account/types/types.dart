/// Abstract class defining a contract for authentication key schemes
abstract class AptosAuthenticationKeyScheme {
  // Each implementing class or enum must provide a unique integer value for the scheme
  abstract final int value;
}

/// Enum representing the address schemes
enum AptosEd25519AddressScheme implements AptosAuthenticationKeyScheme {
  // Legacy Ed25519 address scheme
  ed25519(value: 0),

  // Single key address scheme
  signleKey(value: 2);

  @override
  final int value; // The integer representation of the address scheme

  // Constructor to initialize the value of the scheme
  const AptosEd25519AddressScheme({required this.value});
}

/// Enum representing the different signing schemes.
enum AptosSigningScheme implements AptosAuthenticationKeyScheme {
  // The Ed25519 signing scheme
  ed25519(value: 0),

  // The multi-signature Ed25519 scheme
  multiEd25519(value: 1),

  // A single key signing scheme (likely used for single-key accounts)
  signleKey(value: 2),

  // A multi-key signing scheme where multiple different types of keys are involved
  multikey(value: 3);

  @override
  final int value;

  // Constructor for initializing the value associated with each signing scheme
  const AptosSigningScheme({required this.value});
}
