/// Library for Ethereum-related functionality and utilities.
library;

/// Export individual components for ease of use.
///
/// Ethereum address utilities
export 'src/address/evm_address.dart';

/// Ethereum private key and public key managment
export 'src/keys/keys.dart';

/// Ethereum context models
export 'src/models/models.dart';

/// Ethereum RPC communication
export 'src/rpc/rpc.dart';

/// Recursive Length Prefix encoding
export 'src/rlp/rlp.dart';

/// Ethereum transaction handling
export 'src/transaction/transaction.dart';

/// General Ethereum-related helper functions
export 'src/utils/helper.dart';

/// All related ethereum exception
export 'src/exception/exception.dart';
export 'src/eip_4361/eip_4361.dart';
export 'src/contracts/contracts.dart';
