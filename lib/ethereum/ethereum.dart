/// Library for Ethereum-related functionality and utilities.
library onchain_ethereum;

/// Export individual components for ease of use.
///
/// Ethereum address utilities
export 'address/evm_address.dart';

/// Ethereum private key and public key managment
export 'keys/keys.dart';

/// Ethereum context models
export 'models/models.dart';

/// Ethereum RPC communication
export 'rpc/rpc.dart';

/// Recursive Length Prefix encoding
export 'rlp/rlp.dart';

/// Ethereum transaction handling
export 'transaction/transaction.dart';

/// General Ethereum-related helper functions
export 'utils/helper.dart';
