/// A Dart library for working with Ethereum ABI (Application Binary Interface),
/// EIP-712 (Ethereum Improvement Proposal 712), and related utilities.
///
/// This library provides various components, including ABIs for different data
/// types like addresses, arrays, booleans, bytes, numbers, strings, tuples, and
/// functions. It also includes utilities for Ethereum EIP-712, and common
/// blockchain-related functionality.
///
/// The library is structured into different parts, each corresponding to a
/// specific category or type. The `utils` part contains general utility
/// functions, and other parts contain implementations for specific types and
/// standards.
///
/// Parts:
/// - `utils`: General utility functions used across the library.
/// - `address`: Implements ABIs for Ethereum and Tron addresses.
/// - `array`: Implements ABIs for arrays.
/// - `boolean`: Implements ABIs for boolean values.
/// - `bytes`: Implements ABIs for byte arrays.
/// - `numbers`: Implements ABIs for numeric types.
/// - `string`: Implements ABIs for string values.
/// - `tuple`: Implements ABIs for tuples.
/// - `function`: Implements ABIs for function calls.
/// - `core`: Contains the core ABIs and utility functions.
/// - `eip712`: Implements support for Ethereum EIP-712 standard.
/// - `eip712/utils`: Utilities specific to Ethereum EIP-712.
library;

import 'package:on_chain/solidity/address/core.dart';
import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

part 'utils/utils.dart';
part 'exception/abi_exception.dart';
part 'types/address.dart';
part 'types/array.dart';
part 'types/boolean.dart';
part 'types/bytes.dart';
part 'types/numbers.dart';
part 'types/string.dart';
part 'types/tuple.dart';
part 'types/function.dart';
part 'core/abi.dart';
part 'eip712/eip712.dart';
part 'eip712/utils.dart';
