import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/hedera/src/address/src/address.dart';

import 'package:on_chain/hedera/src/crypto/public_key/public_key.dart';
import 'package:on_chain/hedera/src/crypto/utils/utils.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/models.dart';
import 'package:on_chain/hedera/src/rpc/api/api/client/client.dart';
import 'package:on_chain/ethereum/ethereum.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

/// Semantic role of a required signer on a transaction.
enum TxSignerRole {
  // Envelope
  payer,

  // Crypto transfer / account
  cryptoTransferDebit,
  cryptoTransferTokenDebit,
  cryptoTransferNftSender,
  cryptoTransferReceiverSigRequired,
  cryptoCreateKey,
  cryptoUpdateAccount,
  cryptoUpdateNewKey,
  cryptoDeleteAccount,
  approveAllowanceCryptoOwner,
  approveAllowanceTokenOwner,
  approveAllowanceNftOwner,
  deleteAllowanceNftOwner,

  // Contract
  contractCreateAdminKey,
  contractCreateAutoRenewAccount,
  contractUpdateAdminKey,
  contractUpdateAutoRenewAccount,
  contractAdminKey, // state: current admin
  // File
  fileCreateKey,
  fileUpdateKey,
  fileKey, // state
  // Consensus
  consensusCreateAdminKey,
  consensusCreateSubmitKey,
  consensusCreateAutoRenewAccount,
  consensusUpdateAdminKey,
  consensusUpdateSubmitKey,
  consensusUpdateAutoRenewAccount,
  topicAdminKey, // state
  topicSubmitKey, // state
  // Token create / update (body fields)
  tokenCreateTreasury,
  tokenCreateAutoRenewAccount,
  tokenCreateAdminKey,
  tokenCreateKycKey,
  tokenCreateFreezeKey,
  tokenCreateWipeKey,
  tokenCreateSupplyKey,
  tokenCreateFeeScheduleKey,
  tokenCreatePauseKey,
  tokenCreateMetadataKey,
  tokenUpdateTreasury,
  tokenUpdateAutoRenewAccount,
  tokenUpdateAdminKey,
  tokenUpdateKycKey,
  tokenUpdateFreezeKey,
  tokenUpdateWipeKey,
  tokenUpdateSupplyKey,
  tokenUpdateFeeScheduleKey,
  tokenUpdatePauseKey,
  tokenUpdateMetadataKey,

  // Token ops (state authorities)
  tokenAdminKey,
  tokenSupplyKey,
  tokenWipeKey,
  tokenFreezeKey,
  tokenKycKey,
  tokenPauseKey,
  tokenFeeScheduleKey,
  tokenMetadataKey,

  // Token account ops
  tokenAssociateAccount,
  tokenDissociateAccount,
  tokenRejectOwner,
  tokenAirdropDebit,
  tokenAirdropNftSender,
  tokenClaimAirdropReceiver,
  tokenCancelAirdropSender,

  // Schedule
  scheduleCreateAdminKey,
  scheduleCreatePayer,
  scheduleAdminKey,

  /// Sender recovered from the wrapped Ethereum transaction's own ECDSA
  /// signature. Informational only — see [TxBodySigners.ethereumSender].
  /// Never appears in [TxBodySigners.required]: that party already
  /// authorized `ethereumData` itself and doesn't additionally sign the
  /// HAPI transaction.
  ethereumSender,
}

/// Authority grouping for [TxSignerRole] (body vs state keys that mean the same).
enum TxSignerAuthority {
  payer,
  account,
  key,
  adminKey,
  supplyKey,
  wipeKey,
  freezeKey,
  kycKey,
  pauseKey,
  feeScheduleKey,
  metadataKey,
  submitKey,
  fileKey,
  treasury,
  autoRenewAccount,
  other,
}

extension TxSignerRoleX on TxSignerRole {
  /// Coarse authority used to match body keys with state keys.
  TxSignerAuthority get authority {
    switch (this) {
      case TxSignerRole.payer:
        return TxSignerAuthority.payer;
      case TxSignerRole.tokenAdminKey:
      case TxSignerRole.tokenCreateAdminKey:
      case TxSignerRole.tokenUpdateAdminKey:
      case TxSignerRole.contractAdminKey:
      case TxSignerRole.contractCreateAdminKey:
      case TxSignerRole.contractUpdateAdminKey:
      case TxSignerRole.topicAdminKey:
      case TxSignerRole.consensusCreateAdminKey:
      case TxSignerRole.consensusUpdateAdminKey:
      case TxSignerRole.scheduleAdminKey:
      case TxSignerRole.scheduleCreateAdminKey:
        return TxSignerAuthority.adminKey;
      case TxSignerRole.tokenSupplyKey:
      case TxSignerRole.tokenCreateSupplyKey:
      case TxSignerRole.tokenUpdateSupplyKey:
        return TxSignerAuthority.supplyKey;
      case TxSignerRole.tokenWipeKey:
      case TxSignerRole.tokenCreateWipeKey:
      case TxSignerRole.tokenUpdateWipeKey:
        return TxSignerAuthority.wipeKey;
      case TxSignerRole.tokenFreezeKey:
      case TxSignerRole.tokenCreateFreezeKey:
      case TxSignerRole.tokenUpdateFreezeKey:
        return TxSignerAuthority.freezeKey;
      case TxSignerRole.tokenKycKey:
      case TxSignerRole.tokenCreateKycKey:
      case TxSignerRole.tokenUpdateKycKey:
        return TxSignerAuthority.kycKey;
      case TxSignerRole.tokenPauseKey:
      case TxSignerRole.tokenCreatePauseKey:
      case TxSignerRole.tokenUpdatePauseKey:
        return TxSignerAuthority.pauseKey;
      case TxSignerRole.tokenFeeScheduleKey:
      case TxSignerRole.tokenCreateFeeScheduleKey:
      case TxSignerRole.tokenUpdateFeeScheduleKey:
        return TxSignerAuthority.feeScheduleKey;
      case TxSignerRole.tokenMetadataKey:
      case TxSignerRole.tokenCreateMetadataKey:
      case TxSignerRole.tokenUpdateMetadataKey:
        return TxSignerAuthority.metadataKey;
      case TxSignerRole.topicSubmitKey:
      case TxSignerRole.consensusCreateSubmitKey:
      case TxSignerRole.consensusUpdateSubmitKey:
        return TxSignerAuthority.submitKey;
      case TxSignerRole.fileKey:
      case TxSignerRole.fileCreateKey:
      case TxSignerRole.fileUpdateKey:
        return TxSignerAuthority.fileKey;
      case TxSignerRole.tokenCreateTreasury:
      case TxSignerRole.tokenUpdateTreasury:
        return TxSignerAuthority.treasury;
      case TxSignerRole.tokenCreateAutoRenewAccount:
      case TxSignerRole.tokenUpdateAutoRenewAccount:
      case TxSignerRole.contractCreateAutoRenewAccount:
      case TxSignerRole.contractUpdateAutoRenewAccount:
      case TxSignerRole.consensusCreateAutoRenewAccount:
      case TxSignerRole.consensusUpdateAutoRenewAccount:
        return TxSignerAuthority.autoRenewAccount;
      default:
        if (name.contains('Account') ||
            name.contains('Owner') ||
            name.contains('Debit') ||
            name.contains('Sender') ||
            name.contains('Receiver') ||
            name.contains('Payer') ||
            name.contains('Treasury')) {
          return TxSignerAuthority.account;
        }
        return TxSignerAuthority.other;
    }
  }

  /// Best-effort guess at [TxSignerKind] from the role alone — used only for
  /// roles that ended up in [TxBodySigners.missingKeys], where we know an
  /// authority is required but never got to construct a [TxRequiredSigner]
  /// for it (so there's no concrete `kind` to read).
  TxSignerKind get impliedKind {
    switch (authority) {
      case TxSignerAuthority.payer:
      case TxSignerAuthority.account:
      case TxSignerAuthority.treasury:
      case TxSignerAuthority.autoRenewAccount:
        return TxSignerKind.account;
      default:
        return TxSignerKind.key;
    }
  }
}

enum TxSignerKind {
  /// HAPI account must provide a signature.
  account,

  /// [HederaKey] (or its primitives) must sign.
  key,
}

/// One authority that must authorize the transaction.
///
/// [role] is the *semantic family* this requirement belongs to (used for
/// authority matching between body keys and state keys). Because a single
/// family can legitimately need more than one signer in the same
/// transaction (e.g. three different debited accounts all carry
/// [TxSignerRole.cryptoTransferDebit]), [occurrence] disambiguates each
/// instance and [uniqueRole] gives you a string that is guaranteed to be
/// unique across every entry in a given [TxBodySigners.required] list.
class TxRequiredSigner {
  final HederaAddress? account;
  final HederaKey? key;
  final TxSignerRole role;
  final TxSignerKind kind;
  final String? note;
  final bool fromState;
  final int occurrence;

  /// For account-kind requirements only: the signer's key, when the caller
  /// supplied one via [TxBodySignerLookupParams.providedAccountKeys]. Lets
  /// [TxSigningRequirement.totalSignatures] compute the real threshold-key
  /// signature count for THIS specific account instead of assuming 1.
  /// Always null on key-kind requirements — [key] already covers that case.
  final HederaKey? accountKey;

  String get uniqueRole =>
      occurrence == 0 ? role.name : '${role.name}#$occurrence';

  const TxRequiredSigner.account({
    required HederaAddress this.account,
    required this.role,
    this.note,
    this.occurrence = 0,
    this.accountKey, // NEW
  }) : key = null,
       kind = TxSignerKind.account,
       fromState = false;

  const TxRequiredSigner.key({
    required HederaKey this.key,
    required this.role,
    this.note,
    this.fromState = false,
    this.occurrence = 0,
  }) : account = null,
       kind = TxSignerKind.key,
       accountKey = null; // NEW: n/a on the key variant

  @override
  String toString() {
    if (kind == TxSignerKind.account) {
      final keyNote = accountKey != null ? ', key known' : '';
      return 'TxRequiredSigner.account($uniqueRole: ${account?.address}$keyNote)';
    }
    return 'TxRequiredSigner.key($uniqueRole${fromState ? ' [state]' : ''})';
  }
}

/// One authority that MUST sign, regardless of whether we ever managed to
/// resolve its concrete account/key data.
///
/// [TxRequiredSigner] only exists for authorities we successfully resolved.
/// [TxSigningRequirement] widens that: it also covers roles that ended up in
/// [TxBodySigners.missingKeys] — cases where a lookup was blocked, the
/// entity was missing, or the strategy didn't allow the query. Those parties
/// still legally must sign; we just don't have their key/account bytes on
/// hand. [resolved] tells you which situation you're in for each entry.
class TxSigningRequirement {
  final TxSignerRole role;
  final TxSignerKind kind;
  final bool resolved;
  final HederaAddress? account;
  final HederaKey? key;

  /// Mirrors [TxRequiredSigner.accountKey] — the known signer key for
  /// [account], when supplied. Only meaningful when [kind] is account.
  final HederaKey? accountKey; // NEW

  final String? note;
  final bool fromState;
  final int occurrence;

  String get uniqueRole =>
      occurrence == 0 ? role.name : '${role.name}#$occurrence';

  int totalSignatures() {
    if (!resolved) return 1;
    // Account-kind: use the caller-supplied key for THIS account if we
    // have one, otherwise fall back to the old flat assumption of 1.
    if (kind == TxSignerKind.account) {
      final k = accountKey;
      if (k == null) return 1;
      return HederaCryptoUtils.requiredSignatureCount(k);
    }
    final key = this.key;
    if (key == null) return 1;
    return HederaCryptoUtils.requiredSignatureCount(key);
  }

  const TxSigningRequirement({
    required this.role,
    required this.kind,
    required this.resolved,
    required this.occurrence,
    this.account,
    this.key,
    this.accountKey, // NEW
    this.note,
    this.fromState = false,
  });

  factory TxSigningRequirement._fromRequired(
    TxRequiredSigner r,
    int occurrence,
  ) => TxSigningRequirement(
    role: r.role,
    kind: r.kind,
    resolved: true,
    occurrence: occurrence,
    account: r.account,
    key: r.key,
    accountKey: r.accountKey, // NEW
    note: r.note,
    fromState: r.fromState,
  );

  factory TxSigningRequirement._fromMissing(
    TxSignerRole role,
    int occurrence,
  ) => TxSigningRequirement(
    role: role,
    kind: role.impliedKind,
    resolved: false,
    occurrence: occurrence,
    note:
        'Authority required but the concrete key/account could not be '
        'resolved — this party still MUST sign. Obtain the key out of band '
        '(TxBodySignerLookupParams.providedKeys) or enable a lookup '
        'strategy that can reach it.',
  );

  @override
  String toString() {
    final target =
        kind == TxSignerKind.account
            ? '${account?.address}'
            : (key == null ? '<unresolved key>' : 'key');
    return 'TxSigningRequirement($uniqueRole, resolved=$resolved, $target)';
  }
}

/// Full set of authorities required to authorize a [HederaTransactionBody].
class TxBodySigners {
  static List<TxRequiredSigner> _requireDistinctRoles(
    List<TxRequiredSigner> required,
  ) {
    if (!_allUniqueRolesDistinct(required)) {
      throw OnChainErrors.hederaTx(
        "TxBodySigners",
        reason:
            "TxBodySigners.required contains two entries with the same uniqueRole.",
      );
    }
    return required;
  }

  final List<TxRequiredSigner> required;
  final String bodyType;

  /// Lookups that failed (entity missing, query error) — non-fatal.
  final List<String> lookupWarnings;

  /// Roles that were required but could not be resolved to an account or key
  /// (strategy blocked, entity missing, empty key on state, etc.).
  final List<TxSignerRole> missingKeys;

  /// Sender recovered from the wrapped Ethereum transaction's own signature,
  /// when [bodyType] is `ethereumTransaction` and recovery succeeded.
  /// Informational only — never appears in [required]: that party already
  /// authorized `ethereumData` with its own ECDSA signature and doesn't
  /// additionally sign the HAPI transaction. Typed as [TxRequiredSigner]
  /// (role [TxSignerRole.ethereumSender], `account` set via
  /// `HederaAddress.fromEthAddress`, no `accountId`) rather than a bare
  /// address string so it carries the same shape as everything else if you
  /// want to display it alongside [required] — just don't fold it into
  /// [accounts]/[keys]/[allSigningRequirements], which is exactly why it's
  /// kept off [required] instead of being merged in.
  final TxRequiredSigner? ethereumSender;

  TxBodySigners({
    required List<TxRequiredSigner> required,
    required this.bodyType,
    this.lookupWarnings = const [],
    this.missingKeys = const [],
    this.ethereumSender,
  }) : required = _requireDistinctRoles(required);

  /// Every authority that MUST sign this transaction — resolved (has real
  /// account/key data) and unresolved (role only, from [missingKeys]) alike.
  /// This is the single place to ask "who has to sign, whether or not I
  /// managed to look them all up?".
  List<TxSigningRequirement> get allSigningRequirements {
    final counts = <TxSignerRole, int>{};
    int next(TxSignerRole role) {
      final n = counts[role] ?? 0;
      counts[role] = n + 1;
      return n;
    }

    final out = <TxSigningRequirement>[
      for (final r in required)
        TxSigningRequirement._fromRequired(r, next(r.role)),
      for (final role in missingKeys)
        TxSigningRequirement._fromMissing(role, next(role)),
    ];
    return out;
  }

  /// The subset of [allSigningRequirements] we couldn't resolve — must still
  /// sign, but there's no account/key data to hand to a wallet/signer yet.
  List<TxSigningRequirement> get unresolvedSigningRequirements =>
      allSigningRequirements.where((r) => !r.resolved).toList();

  static bool _allUniqueRolesDistinct(List<TxRequiredSigner> list) {
    final seen = <String>{};
    for (final r in list) {
      if (!seen.add(r.uniqueRole)) return false;
    }
    return true;
  }

  Set<HederaAddress> get accounts {
    final s = <HederaAddress>{};
    for (final r in required) {
      if (r.account != null) s.add(r.account!);
    }
    return s;
  }

  List<HederaKey> get keys {
    final list = <HederaKey>[];
    for (final r in required) {
      if (r.key != null && !_isEmptyKey(r.key)) list.add(r.key!);
    }
    return list;
  }

  List<TxRequiredSigner> get accountRequirements =>
      required.where((r) => r.kind == TxSignerKind.account).toList();

  List<TxRequiredSigner> get keyRequirements =>
      required.where((r) => r.kind == TxSignerKind.key).toList();

  List<TxRequiredSigner> get stateKeyRequirements =>
      required.where((r) => r.kind == TxSignerKind.key && r.fromState).toList();

  /// All requirements sharing the same [TxSignerRole] family (e.g. every
  /// debited account in a crypto transfer, regardless of occurrence).
  List<TxRequiredSigner> byRole(TxSignerRole role) =>
      required.where((r) => r.role == role).toList();

  /// Lookup by the guaranteed-unique [TxRequiredSigner.uniqueRole].
  Map<String, TxRequiredSigner> get byUniqueRole => {
    for (final r in required) r.uniqueRole: r,
  };

  bool get isEmpty => required.isEmpty;

  bool get hasMissingKeys => missingKeys.isNotEmpty;

  @override
  String toString() =>
      'TxBodySigners($bodyType, accounts=${accounts.length}, keys=${keys.length}, '
      'missing=${missingKeys.length}, warnings=${lookupWarnings.length})';

  static bool _isEmptyKey(HederaKey? k) {
    if (k == null) return true;
    final list = k.keyList;
    if (list != null && list.keys.isEmpty) return true;
    return false;
  }
}

class _SignerCollector {
  final List<TxRequiredSigner> items = [];
  final Set<String> _seen = {};
  final List<String> warnings = [];
  final List<TxSignerRole> missingRoles = [];
  TxRequiredSigner? ethereumSender;
  final Map<TxSignerRole, int> _roleOccurrence = {};

  /// NEW: address-string-keyed lookup, sourced from
  /// [TxBodySignerLookupParams.providedAccountKeys]. Kept on the collector
  /// itself (rather than passed into every static body collector) so
  /// `_cryptoTransfer`, `_tokenAirdrop`, etc. don't need signature changes —
  /// they already funnel every account through `c.account(...)`.
  final Map<String, HederaKey> providedAccountKeys;

  _SignerCollector({this.providedAccountKeys = const {}});

  int _nextOccurrence(TxSignerRole role) {
    final n = _roleOccurrence[role] ?? 0;
    _roleOccurrence[role] = n + 1;
    return n;
  }

  void account(
    HederaAccountID? id, {
    required TxSignerRole role,
    String? note,
  }) {
    if (id == null) return;
    final dedupKey =
        'a:${id.shardNum}.${id.realmNum}.${id.accountNum}:${role.name}';
    if (!_seen.add(dedupKey)) return;
    final addr = HederaAddress.fromAccountId(id);
    items.add(
      TxRequiredSigner.account(
        account: addr,
        role: role,
        note: note,
        occurrence: _nextOccurrence(role),
        accountKey: providedAccountKeys[addr.address], // NEW
      ),
    );
  }

  void key(
    HederaKey? k, {
    required TxSignerRole role,
    String? note,
    bool fromState = false,
  }) {
    if (k == null) return;
    if (TxBodySigners._isEmptyKey(k)) return;
    final dedupKey = 'k:${role.name}:${_keyFingerprint(k)}:$fromState';
    if (!_seen.add(dedupKey)) return;
    items.add(
      TxRequiredSigner.key(
        key: k,
        role: role,
        note: note,
        fromState: fromState,
        occurrence: _nextOccurrence(role),
      ),
    );
  }

  /// Content-based fingerprint of a [HederaKey] for dedup purposes.
  ///
  /// `identityHashCode` is wrong here: two [HederaKey] instances can be
  /// bitwise-identical (the same simple key handed in once via
  /// `providedKeys` and once resolved from state, or the same threshold key
  /// parsed out of two different protobuf messages) while still being two
  /// distinct Dart objects — `identityHashCode` would hash them differently
  /// and let a duplicate signer requirement slip past `_seen`.
  ///
  /// Flatten to the key's leaf [HederaPublicKey]s, sort (they're
  /// `Comparable`, so the fingerprint doesn't depend on the order keys
  /// happened to be declared in a `KeyList`/`ThresholdKey`), concatenate
  /// their bytes, and hash. This is only a `Set<String>` membership check —
  /// not a security boundary — but a wrong dedup match here means a real
  /// signer silently drops out of `required`, so we still want a hash with
  /// negligible accidental-collision odds rather than the fastest one
  /// available. Blake2b-256 is the safe default; CRC32 is there if you'd
  /// rather trade a little of that margin for speed on very large key lists.
  static String _keyFingerprint(HederaKey k) {
    final leaves = HederaCryptoUtils.flattenHederaKey(k)..sort();
    if (leaves.isEmpty) return 'empty';
    final buffer = <int>[];
    for (final pk in leaves) {
      buffer.addAll(pk.toBytes());
    }
    final digest = Crc32().quickIntDigest(buffer);
    return digest.toString();
  }

  /// True if a key requirement for [role] (exact or same [TxSignerAuthority]) exists.
  bool hasKeyRole(TxSignerRole role) {
    final auth = role.authority;
    for (final r in items) {
      if (r.kind != TxSignerKind.key) continue;
      if (r.role == role || r.role.authority == auth) return true;
    }
    return false;
  }

  void warn(String message) => warnings.add(message);

  void markMissing(TxSignerRole role, [String? message]) {
    if (!missingRoles.contains(role)) missingRoles.add(role);
    if (message != null) warn(message);
  }

  void markMissingAll(Iterable<TxSignerRole> roles, [String? message]) {
    for (final r in roles) {
      if (!missingRoles.contains(r)) missingRoles.add(r);
    }
    if (message != null) warn(message);
  }

  static HederaAddress? _toAddress(HederaAccountID id) {
    final num = id.accountNum;
    if (num == null) return null;
    return HederaAddress.fromNum(
      shard: id.shardNum ?? BigInt.zero,
      realm: id.realmNum ?? BigInt.zero,
      num: num,
    );
  }
}

class TxBodySignerLookupParams {
  final bool resolveStateKeys;

  /// Keys for role families that occur AT MOST ONCE per body — state/body
  /// key-kind authorities like adminKey, supplyKey, submitKey, etc.
  /// NOT for account-kind roles that can repeat within one body (multiple
  /// debits, multiple allowance owners, multiple airdrop senders/receivers)
  /// — a role name alone can't disambiguate which occurrence a key belongs
  /// to. Use [providedAccountKeys] for those.
  final Map<TxSignerRole, HederaKey> providedKeys;

  /// Keys for specific *accounts*, keyed by [HederaAddress.address] string.
  /// Use this whenever the same role can appear more than once in a body
  /// (e.g. TxSignerRole.cryptoTransferDebit across a multi-sender
  /// CryptoTransfer) — each debited account's key is looked up by its own
  /// address, so multiple occurrences of the same role never collide the
  /// way they would under [providedKeys].
  final Map<String, HederaKey> providedAccountKeys;

  final bool preferBodyKeys;

  const TxBodySignerLookupParams({
    this.resolveStateKeys = true,
    this.providedKeys = const {},
    this.providedAccountKeys = const {},
    this.preferBodyKeys = true,
  });

  HederaKey? provided(TxSignerRole role) => providedKeys[role];

  HederaKey? providedForAccount(HederaAddress address) =>
      providedAccountKeys[address.address];
}

extension HederaTransactionBodySigners on HederaTransactionBody {
  TxBodySigners detectSignersLocal({
    TxBodySignerLookupParams lookup = const TxBodySignerLookupParams(),
  }) {
    final c = _SignerCollector(providedAccountKeys: lookup.providedAccountKeys);
    c.account(
      transactionID?.accountID,
      role: TxSignerRole.payer,
      note: 'transactionID.accountID — pays fees and authorizes submission',
    );
    final bodyType = _collectBodySigners(c);
    return TxBodySigners(
      required: c.items,
      bodyType: bodyType,
      lookupWarnings: c.warnings,
      missingKeys: List.unmodifiable(c.missingRoles),
      ethereumSender: c.ethereumSender,
    );
  }

  List<TxSigningRequirement> detectAllSigningRequirementsLocal({
    TxBodySignerLookupParams lookup = const TxBodySignerLookupParams(),
  }) => detectSignersLocal(lookup: lookup).allSigningRequirements;

  Future<TxBodySigners> detectSigners({
    required HederaClient client,
    TxBodySignerLookupParams lookup = const TxBodySignerLookupParams(),
  }) async {
    final c = _SignerCollector(
      providedAccountKeys: lookup.providedAccountKeys,
    ); // CHANGED
    c.account(
      transactionID?.accountID,
      role: TxSignerRole.payer,
      note: 'transactionID.accountID — pays fees and authorizes submission',
    );
    final bodyType = _collectBodySigners(c);

    for (final e in lookup.providedKeys.entries) {
      c.key(
        e.value,
        role: e.key,
        note: 'user-provided key for ${e.key.name}',
        fromState: false,
      );
    }

    if (lookup.resolveStateKeys) {
      await _resolveStateKeys(c, client: client, lookup: lookup);
    }

    return TxBodySigners(
      required: c.items,
      bodyType: bodyType,
      lookupWarnings: c.warnings,
      missingKeys: List.unmodifiable(c.missingRoles),
      ethereumSender: c.ethereumSender,
    );
  }

  /// Detect all signing requirements (resolved + unresolved), loading
  /// state-only keys via [client]. Shorthand for
  /// `(await detectSigners(...)).allSigningRequirements` — the one call to
  /// reach for when you need "everyone who must sign, whether or not I have
  /// their key yet".
  Future<List<TxSigningRequirement>> detectAllSigningRequirements({
    required HederaClient client,
    TxBodySignerLookupParams lookup = const TxBodySignerLookupParams(),
  }) async {
    final signers = await detectSigners(client: client, lookup: lookup);
    return signers.allSigningRequirements;
  }

  Set<HederaAddress> detectSignerAccounts() => detectSignersLocal().accounts;

  List<HederaKey> detectSignerKeys() => detectSignersLocal().keys;

  // ── oneof enforcement ────────────────────────────────────────────────────

  /// Every top-level `data` oneof field on [HederaTransactionBody]. Exactly
  /// one of these is expected to be non-null on a well-formed body — this is
  /// what makes it a *single* transaction type, never a mix of several.
  Map<String, bool> get _txTypeFlags => {
    'cryptoTransfer': cryptoTransfer != null,
    'cryptoCreateAccount': cryptoCreateAccount != null,
    'cryptoUpdateAccount': cryptoUpdateAccount != null,
    'cryptoDelete': cryptoDelete != null,
    'cryptoApproveAllowance': cryptoApproveAllowance != null,
    'cryptoDeleteAllowance': cryptoDeleteAllowance != null,
    'contractCall': contractCall != null,
    'contractCreateInstance': contractCreateInstance != null,
    'contractUpdateInstance': contractUpdateInstance != null,
    'contractDeleteInstance': contractDeleteInstance != null,
    'fileCreate': fileCreate != null,
    'fileAppend': fileAppend != null,
    'fileUpdate': fileUpdate != null,
    'fileDelete': fileDelete != null,
    'systemDelete': systemDelete != null,
    'systemUndelete': systemUndelete != null,
    'freeze': freeze != null,
    'consensusCreateTopic': consensusCreateTopic != null,
    'consensusUpdateTopic': consensusUpdateTopic != null,
    'consensusDeleteTopic': consensusDeleteTopic != null,
    'consensusSubmitMessage': consensusSubmitMessage != null,
    'tokenCreation': tokenCreation != null,
    'tokenUpdate': tokenUpdate != null,
    'tokenDeletion': tokenDeletion != null,
    'tokenMint': tokenMint != null,
    'tokenBurn': tokenBurn != null,
    'tokenWipe': tokenWipe != null,
    'tokenAssociate': tokenAssociate != null,
    'tokenDissociate': tokenDissociate != null,
    'tokenFreeze': tokenFreeze != null,
    'tokenUnfreeze': tokenUnfreeze != null,
    'tokenGrantKyc': tokenGrantKyc != null,
    'tokenRevokeKyc': tokenRevokeKyc != null,
    'tokenPause': tokenPause != null,
    'tokenUnpause': tokenUnpause != null,
    'tokenFeeScheduleUpdate': tokenFeeScheduleUpdate != null,
    'tokenUpdateNfts': tokenUpdateNfts != null,
    'tokenReject': tokenReject != null,
    'tokenAirdrop': tokenAirdrop != null,
    'tokenCancelAirdrop': tokenCancelAirdrop != null,
    'tokenClaimAirdrop': tokenClaimAirdrop != null,
    'scheduleCreate': scheduleCreate != null,
    'scheduleDelete': scheduleDelete != null,
    'scheduleSign': scheduleSign != null,
    'ethereumTransaction': ethereumTransaction != null,
    'utilPrng': utilPrng != null,
  };

  /// Throws [BuError] if more than one `data`
  /// oneof field is set — a [HederaTransactionBody] must contain exactly
  /// one transaction type.
  void _assertSingleTxType() {
    final flags = _txTypeFlags;
    final setFields =
        flags.entries.where((e) => e.value).map((e) => e.key).toList();
    if (setFields.length > 1) {
      throw OnChainErrors.hederaTx(
        "_assertSingleTxType",
        reason:
            'Malformed HederaTransactionBody: ${setFields.length} transaction '
            'types are set at once (${setFields.join(', ')}). A transaction '
            'body must contain exactly one type; refusing to detect signers for '
            'an ambiguous body.',
        details: {'count': '${setFields.length}'},
      );
    }
  }

  String _collectBodySigners(_SignerCollector c) {
    _assertSingleTxType();

    if (cryptoTransfer != null) {
      _cryptoTransfer(c, cryptoTransfer!);
      return 'cryptoTransfer';
    }
    if (cryptoCreateAccount != null) {
      _cryptoCreate(c, cryptoCreateAccount!);
      return 'cryptoCreateAccount';
    }
    if (cryptoUpdateAccount != null) {
      _cryptoUpdate(c, cryptoUpdateAccount!);
      return 'cryptoUpdateAccount';
    }
    if (cryptoDelete != null) {
      _cryptoDelete(c, cryptoDelete!);
      return 'cryptoDelete';
    }
    if (cryptoApproveAllowance != null) {
      _cryptoApproveAllowance(c, cryptoApproveAllowance!);
      return 'cryptoApproveAllowance';
    }
    if (cryptoDeleteAllowance != null) {
      _cryptoDeleteAllowance(c, cryptoDeleteAllowance!);
      return 'cryptoDeleteAllowance';
    }
    if (contractCall != null) {
      c.warn(
        'contractCall: signer detection for contract-internal authorities '
        '(e.g. allowance owners spent via HTS precompiles) is not modeled; '
        'only the payer is guaranteed.',
      );
      return 'contractCall';
    }
    if (contractCreateInstance != null) {
      _contractCreate(c, contractCreateInstance!);
      return 'contractCreateInstance';
    }
    if (contractUpdateInstance != null) {
      _contractUpdate(c, contractUpdateInstance!);
      return 'contractUpdateInstance';
    }
    if (contractDeleteInstance != null) return 'contractDeleteInstance';
    if (fileCreate != null) {
      _fileCreate(c, fileCreate!);
      return 'fileCreate';
    }
    if (fileAppend != null) return 'fileAppend';
    if (fileUpdate != null) {
      _fileUpdate(c, fileUpdate!);
      return 'fileUpdate';
    }
    if (fileDelete != null) return 'fileDelete';
    if (systemDelete != null) return 'systemDelete';
    if (systemUndelete != null) return 'systemUndelete';
    if (freeze != null) return 'freeze';
    if (consensusCreateTopic != null) {
      _consensusCreate(c, consensusCreateTopic!);
      return 'consensusCreateTopic';
    }
    if (consensusUpdateTopic != null) {
      _consensusUpdate(c, consensusUpdateTopic!);
      return 'consensusUpdateTopic';
    }
    if (consensusDeleteTopic != null) return 'consensusDeleteTopic';
    if (consensusSubmitMessage != null) return 'consensusSubmitMessage';
    if (tokenCreation != null) {
      _tokenCreate(c, tokenCreation!);
      return 'tokenCreation';
    }
    if (tokenUpdate != null) {
      _tokenUpdate(c, tokenUpdate!);
      return 'tokenUpdate';
    }
    if (tokenDeletion != null) return 'tokenDeletion';
    if (tokenMint != null) return 'tokenMint';
    if (tokenBurn != null) return 'tokenBurn';
    if (tokenWipe != null) return 'tokenWipe';
    if (tokenAssociate != null) {
      _tokenAssociate(c, tokenAssociate!);
      return 'tokenAssociate';
    }
    if (tokenDissociate != null) {
      _tokenDissociate(c, tokenDissociate!);
      return 'tokenDissociate';
    }
    if (tokenFreeze != null) return 'tokenFreeze';
    if (tokenUnfreeze != null) return 'tokenUnfreeze';
    if (tokenGrantKyc != null) return 'tokenGrantKyc';
    if (tokenRevokeKyc != null) return 'tokenRevokeKyc';
    if (tokenPause != null) return 'tokenPause';
    if (tokenUnpause != null) return 'tokenUnpause';
    if (tokenFeeScheduleUpdate != null) return 'tokenFeeScheduleUpdate';
    if (tokenUpdateNfts != null) return 'tokenUpdateNfts';
    if (tokenReject != null) {
      _tokenReject(c, tokenReject!);
      return 'tokenReject';
    }
    if (tokenAirdrop != null) {
      _tokenAirdrop(c, tokenAirdrop!);
      return 'tokenAirdrop';
    }
    if (tokenCancelAirdrop != null) {
      _tokenCancelAirdrop(c, tokenCancelAirdrop!);
      return 'tokenCancelAirdrop';
    }
    if (tokenClaimAirdrop != null) {
      _tokenClaimAirdrop(c, tokenClaimAirdrop!);
      return 'tokenClaimAirdrop';
    }
    if (scheduleCreate != null) {
      _scheduleCreate(c, scheduleCreate!);
      return 'scheduleCreate';
    }
    if (scheduleDelete != null) return 'scheduleDelete';
    if (scheduleSign != null) return 'scheduleSign';
    if (ethereumTransaction != null) {
      _ethereumTransaction(c, ethereumTransaction!);
      return 'ethereumTransaction';
    }
    if (utilPrng != null) return 'utilPrng';
    return 'unknown';
  }

  // ── State key resolution via client ──────────────────────────────────────

  Future<void> _resolveStateKeys(
    _SignerCollector c, {
    required HederaClient client,
    required TxBodySignerLookupParams lookup,
  }) async {
    // Token operations that require keys from TokenInfo
    final tokenId =
        tokenDeletion?.token ??
        tokenMint?.token ??
        tokenBurn?.token ??
        tokenWipe?.token ??
        tokenFreeze?.token ??
        tokenUnfreeze?.token ??
        tokenGrantKyc?.token ??
        tokenRevokeKyc?.token ??
        tokenPause?.token ??
        tokenUnpause?.token ??
        tokenFeeScheduleUpdate?.tokenId ??
        tokenUpdateNfts?.token ??
        tokenUpdate?.token;

    if (tokenId != null) {
      await _loadTokenKeys(c, client: client, lookup: lookup, tokenId: tokenId);
    }

    // Contract delete / update: admin on contract state
    final contractId =
        contractDeleteInstance?.contractID ??
        contractUpdateInstance?.contractID;
    if (contractId != null &&
        (contractDeleteInstance != null ||
            (contractUpdateInstance != null &&
                contractUpdateInstance!.adminKey == null))) {
      await _loadContractKeys(
        c,
        client: client,
        lookup: lookup,
        contractId: contractId,
      );
    }

    // Topic delete / submit / update without body keys
    final topicId =
        consensusDeleteTopic?.topicID ??
        consensusSubmitMessage?.topicID ??
        consensusUpdateTopic?.topicID;
    if (topicId != null &&
        (consensusDeleteTopic != null ||
            consensusSubmitMessage != null ||
            consensusUpdateTopic != null)) {
      await _loadTopicKeys(c, client: client, lookup: lookup, topicId: topicId);
    }

    // File append / delete / update without keys on body
    final fileId =
        fileAppend?.fileID ?? fileDelete?.fileID ?? fileUpdate?.fileID;
    if (fileId != null &&
        (fileAppend != null ||
            fileDelete != null ||
            (fileUpdate != null && fileUpdate!.keys == null))) {
      await _loadFileKeys(c, client: client, lookup: lookup, fileId: fileId);
    }

    // Schedule delete / sign
    final scheduleId = scheduleDelete?.scheduleID ?? scheduleSign?.scheduleID;
    if (scheduleId != null) {
      await _loadScheduleKeys(c, client: client, lookup: lookup);
    }

    // Crypto transfer: receiverSigRequired on credit accounts (state)
    if (cryptoTransfer != null) {
      await _loadReceiverSigRequired(
        c,
        client: client,
        transfer: cryptoTransfer!,
      );
    }
  }

  Future<void> _loadTokenKeys(
    _SignerCollector c, {
    required HederaClient client,
    required HederaTokenID tokenId,
    required TxBodySignerLookupParams lookup,
  }) async {
    final needed = <TxSignerRole>[];
    if (tokenDeletion != null) needed.add(TxSignerRole.tokenAdminKey);
    if (tokenMint != null || tokenBurn != null) {
      needed.add(TxSignerRole.tokenSupplyKey);
    }
    if (tokenWipe != null) needed.add(TxSignerRole.tokenWipeKey);
    if (tokenFreeze != null || tokenUnfreeze != null) {
      needed.add(TxSignerRole.tokenFreezeKey);
    }
    if (tokenGrantKyc != null || tokenRevokeKyc != null) {
      needed.add(TxSignerRole.tokenKycKey);
    }
    if (tokenPause != null || tokenUnpause != null) {
      needed.add(TxSignerRole.tokenPauseKey);
    }
    if (tokenFeeScheduleUpdate != null) {
      needed.add(TxSignerRole.tokenFeeScheduleKey);
    }
    if (tokenUpdateNfts != null) needed.add(TxSignerRole.tokenMetadataKey);
    if (tokenUpdate != null) needed.add(TxSignerRole.tokenAdminKey);

    bool stillNeeded(TxSignerRole role) {
      if (lookup.provided(role) != null) return false;
      if (lookup.preferBodyKeys && c.hasKeyRole(role)) {
        if (tokenUpdate != null && role == TxSignerRole.tokenAdminKey) {
          return true;
        }
        return false;
      }
      return true;
    }

    final missing = needed.where(stillNeeded).toList();
    if (missing.isEmpty) return;

    if (!client.strategy.allowMirror && !client.strategy.allowPaidQuery) {
      c.markMissingAll(
        missing,
        'Token state keys not resolved for $tokenId: enable mirror or paid node '
        'query strategy (or pass providedKeys for $missing).',
      );
      return;
    }
    if (!client.strategy.allowMirror &&
        client.strategy.allowNode &&
        !client.strategy.allowPaidQuery) {
      c.markMissingAll(
        missing,
        'Token state keys not resolved for $tokenId: node free-query strategy '
        'cannot pay TokenGetInfo; enable mirror, paid query, or providedKeys.',
      );
      return;
    }

    final keys = await client.getTokenKeys(tokenId);
    void add(HederaKey? k, TxSignerRole role, String note) {
      if (!stillNeeded(role)) return;
      if (k == null || TxBodySigners._isEmptyKey(k)) {
        c.markMissing(
          role,
          'Token role $role missing on $tokenId (${keys.source.name})',
        );
        return;
      }
      c.key(k, role: role, note: note, fromState: true);
    }

    if (tokenDeletion != null) {
      add(
        keys.admin,
        TxSignerRole.tokenAdminKey,
        'Token adminKey from ${keys.source.name}',
      );
    }
    if (tokenMint != null || tokenBurn != null) {
      add(
        keys.supply,
        TxSignerRole.tokenSupplyKey,
        'Token supplyKey from ${keys.source.name}',
      );
    }
    if (tokenWipe != null) {
      add(
        keys.wipe,
        TxSignerRole.tokenWipeKey,
        'Token wipeKey from ${keys.source.name}',
      );
    }
    if (tokenFreeze != null || tokenUnfreeze != null) {
      add(
        keys.freeze,
        TxSignerRole.tokenFreezeKey,
        'Token freezeKey from ${keys.source.name}',
      );
    }
    if (tokenGrantKyc != null || tokenRevokeKyc != null) {
      add(
        keys.kyc,
        TxSignerRole.tokenKycKey,
        'Token kycKey from ${keys.source.name}',
      );
    }
    if (tokenPause != null || tokenUnpause != null) {
      add(
        keys.pause,
        TxSignerRole.tokenPauseKey,
        'Token pauseKey from ${keys.source.name}',
      );
    }
    if (tokenFeeScheduleUpdate != null) {
      add(
        keys.feeSchedule,
        TxSignerRole.tokenFeeScheduleKey,
        'Token feeScheduleKey from ${keys.source.name}',
      );
    }
    if (tokenUpdateNfts != null) {
      add(
        keys.metadata,
        TxSignerRole.tokenMetadataKey,
        'Token metadataKey from ${keys.source.name}',
      );
    }
    if (tokenUpdate != null) {
      add(
        keys.admin,
        TxSignerRole.tokenAdminKey,
        'Current token adminKey from ${keys.source.name}',
      );
    }
  }

  Future<void> _loadContractKeys(
    _SignerCollector c, {
    required HederaClient client,
    required HederaContractID contractId,
    required TxBodySignerLookupParams lookup,
  }) async {
    const role = TxSignerRole.contractAdminKey;
    final bodyIsNewKeyOnly = contractUpdateInstance != null;
    if (lookup.provided(role) != null) return;
    if (lookup.preferBodyKeys && c.hasKeyRole(role) && !bodyIsNewKeyOnly) {
      return;
    }
    if (!client.strategy.allowMirror && !client.strategy.allowPaidQuery) {
      c.markMissing(
        role,
        'Contract adminKey not resolved for $contractId: enable mirror or paid '
        'node query (or providedKeys[TxSignerRole.contractAdminKey]).',
      );
      return;
    }
    final addr = HederaAddress(
      '${contractId.shardNum ?? 0}.${contractId.realmNum ?? 0}.${contractId.contractNum ?? 0}',
    );
    final keys = await client.getContractKeys(addr, contractId: contractId);
    if (keys.admin == null || TxBodySigners._isEmptyKey(keys.admin)) {
      c.markMissing(
        role,
        'Contract adminKey empty on $contractId (${keys.source.name})',
      );
      return;
    }
    c.key(
      keys.admin,
      role: role,
      note: 'Contract adminKey from ${keys.source.name}',
      fromState: true,
    );
  }

  Future<void> _loadTopicKeys(
    _SignerCollector c, {
    required HederaClient client,
    required HederaTopicID topicId,
    required TxBodySignerLookupParams lookup,
  }) async {
    bool need(TxSignerRole role) {
      if (lookup.provided(role) != null) return false;
      if (consensusUpdateTopic != null &&
          (role == TxSignerRole.topicAdminKey ||
              role == TxSignerRole.topicSubmitKey)) {
        return true;
      }
      if (lookup.preferBodyKeys && c.hasKeyRole(role)) return false;
      return true;
    }

    final needAdmin =
        (consensusDeleteTopic != null || consensusUpdateTopic != null) &&
        need(TxSignerRole.topicAdminKey);
    final needSubmit =
        (consensusSubmitMessage != null || consensusUpdateTopic != null) &&
        need(TxSignerRole.topicSubmitKey);
    if (!needAdmin && !needSubmit) return;

    if (!client.strategy.allowMirror && !client.strategy.allowPaidQuery) {
      if (needAdmin) {
        c.markMissing(
          TxSignerRole.topicAdminKey,
          'Topic keys not resolved for $topicId: enable mirror or paid node query.',
        );
      }
      if (needSubmit) {
        c.markMissing(
          TxSignerRole.topicSubmitKey,
          'Topic keys not resolved for $topicId: enable mirror or paid node query.',
        );
      }
      return;
    }

    final keys = await client.getTopicKeys(topicId);
    if (needAdmin) {
      if (keys.admin == null || TxBodySigners._isEmptyKey(keys.admin)) {
        c.markMissing(
          TxSignerRole.topicAdminKey,
          'Topic adminKey empty on $topicId (${keys.source.name})',
        );
      } else {
        c.key(
          keys.admin,
          role: TxSignerRole.topicAdminKey,
          note: 'Topic adminKey from ${keys.source.name}',
          fromState: true,
        );
      }
    }
    if (needSubmit) {
      if (keys.submit == null || TxBodySigners._isEmptyKey(keys.submit)) {
        c.markMissing(
          TxSignerRole.topicSubmitKey,
          'Topic submitKey empty on $topicId (${keys.source.name})',
        );
      } else {
        c.key(
          keys.submit,
          role: TxSignerRole.topicSubmitKey,
          note: 'Topic submitKey from ${keys.source.name}',
          fromState: true,
        );
      }
    }
  }

  Future<void> _loadFileKeys(
    _SignerCollector c, {
    required HederaClient client,
    required HederaFileID fileId,
    required TxBodySignerLookupParams lookup,
  }) async {
    if (lookup.provided(TxSignerRole.fileKey) != null) return;
    if (lookup.preferBodyKeys && c.hasKeyRole(TxSignerRole.fileKey)) return;
    // FileGetInfo is typically node-paid; mirror file-contents API does not expose keys.
    if (!client.strategy.allowPaidQuery) {
      c.markMissing(
        TxSignerRole.fileKey,
        'File keys not resolved for $fileId: requires paid node query strategy '
        'or providedKeys[TxSignerRole.fileKey].',
      );
      return;
    }
    c.markMissing(
      TxSignerRole.fileKey,
      'File keys not resolved for $fileId: getFileKeys is not implemented on client yet; '
      'pass providedKeys[TxSignerRole.fileKey].',
    );
  }

  Future<void> _loadScheduleKeys(
    _SignerCollector c, {
    required HederaClient client,
    required TxBodySignerLookupParams lookup,
  }) async {
    if (lookup.provided(TxSignerRole.scheduleAdminKey) != null) return;
    if (lookup.preferBodyKeys && c.hasKeyRole(TxSignerRole.scheduleAdminKey)) {
      return;
    }
    if (!client.strategy.allowPaidQuery) {
      c.markMissing(
        TxSignerRole.scheduleAdminKey,
        'Schedule state keys not resolved: requires paid node query strategy '
        'or providedKeys[TxSignerRole.scheduleAdminKey].',
      );
      return;
    }
    c.markMissing(
      TxSignerRole.scheduleAdminKey,
      'Schedule state keys not resolved: getScheduleKeys not implemented on client; '
      'pass providedKeys[TxSignerRole.scheduleAdminKey].',
    );
  }

  Future<void> _loadReceiverSigRequired(
    _SignerCollector c, {
    required HederaClient client,
    required HederaCryptoTransferTransactionBody transfer,
  }) async {
    if (!client.strategy.allowMirror && !client.strategy.allowPaidQuery) {
      c.markMissing(
        TxSignerRole.cryptoTransferReceiverSigRequired,
        'receiverSigRequired not resolved: enable mirror or paid node query strategy.',
      );
      return;
    }
    final transfers = transfer.transfers?.accountAmounts ?? const [];
    for (final a in transfers) {
      final amt = a.amount;
      if (amt == null || amt <= BigInt.zero || a.accountID == null) continue;
      final addr = _SignerCollector._toAddress(a.accountID!);
      if (addr == null) continue;
      final snap = await client.getAccount(addr);
      if (snap.receiverSigRequired == true) {
        c.account(
          a.accountID,
          role: TxSignerRole.cryptoTransferReceiverSigRequired,
          note: 'Credit account has receiverSigRequired',
        );
      }
    }
  }

  // ── Body field collectors ─────────────────────────────────────────────────
  //
  // Every collector below is safe to call with a body that has *many*
  // matching entries (multiple debits, multiple NFT senders, multiple
  // allowance owners, multiple keys, …). Each call into `_SignerCollector`
  // still shares the same `TxSignerRole`, but the collector now assigns each
  // one a distinct `occurrence`, so every resulting `TxRequiredSigner` has a
  // unique `uniqueRole` even when dozens of entries share one role family.

  static void _cryptoTransfer(
    _SignerCollector c,
    HederaCryptoTransferTransactionBody t,
  ) {
    final hbar = t.transfers?.accountAmounts ?? const <HederaAccountAmount>[];
    for (final a in hbar) {
      final amt = a.amount;
      if (amt != null && amt.isNegative) {
        c.account(
          a.accountID,
          role: TxSignerRole.cryptoTransferDebit,
          note: 'Account with HBAR debit MUST sign',
        );
      }
    }
    for (final list in t.tokenTransfers) {
      for (final a in list.transfers) {
        final amt = a.amount;
        if (amt != null && amt.isNegative) {
          c.account(
            a.accountID,
            role: TxSignerRole.cryptoTransferTokenDebit,
            note: 'Account with fungible token debit MUST sign',
          );
        }
      }
      for (final nft in list.nftTransfers) {
        c.account(
          nft.senderAccountID,
          role: TxSignerRole.cryptoTransferNftSender,
          note: 'NFT sender MUST sign',
        );
      }
    }
  }

  static void _cryptoCreate(
    _SignerCollector c,
    HederaCryptoCreateTransactionBody t,
  ) {
    if (t.receiverSigRequired == true) {
      c.key(
        t.key,
        role: TxSignerRole.cryptoCreateKey,
        note:
            'receiverSigRequired: new account key MUST sign create '
            '(in addition to payer)',
      );
    }
  }

  static void _cryptoUpdate(
    _SignerCollector c,
    HederaCryptoUpdateTransactionBody t,
  ) {
    c.account(
      t.accountIDToUpdate,
      role: TxSignerRole.cryptoUpdateAccount,
      note: 'Account being updated MUST sign',
    );
    c.key(
      t.key,
      role: TxSignerRole.cryptoUpdateNewKey,
      note: 'If key is replaced, new key typically must sign',
    );
  }

  static void _cryptoDelete(
    _SignerCollector c,
    HederaCryptoDeleteTransactionBody t,
  ) {
    c.account(
      t.deleteAccountID,
      role: TxSignerRole.cryptoDeleteAccount,
      note: 'Account being deleted MUST sign',
    );
  }

  static void _cryptoApproveAllowance(
    _SignerCollector c,
    HederaCryptoApproveAllowanceTransactionBody t,
  ) {
    for (final a in t.cryptoAllowances) {
      c.account(a.owner, role: TxSignerRole.approveAllowanceCryptoOwner);
    }
    for (final a in t.tokenAllowances) {
      c.account(a.owner, role: TxSignerRole.approveAllowanceTokenOwner);
    }
    for (final a in t.nftAllowances) {
      c.account(a.owner, role: TxSignerRole.approveAllowanceNftOwner);
    }
  }

  static void _cryptoDeleteAllowance(
    _SignerCollector c,
    HederaCryptoDeleteAllowanceTransactionBody t,
  ) {
    for (final a in t.nftAllowances) {
      c.account(a.owner, role: TxSignerRole.deleteAllowanceNftOwner);
    }
  }

  static void _contractCreate(
    _SignerCollector c,
    HederaContractCreateTransactionBody t,
  ) {
    c.key(t.adminKey, role: TxSignerRole.contractCreateAdminKey);
    c.account(
      t.autoRenewAccountId,
      role: TxSignerRole.contractCreateAutoRenewAccount,
    );
  }

  static void _contractUpdate(
    _SignerCollector c,
    HederaContractUpdateTransactionBody t,
  ) {
    c.key(t.adminKey, role: TxSignerRole.contractUpdateAdminKey);
    c.account(
      t.autoRenewAccountId,
      role: TxSignerRole.contractUpdateAutoRenewAccount,
    );
  }

  static void _fileCreate(
    _SignerCollector c,
    HederaFileCreateTransactionBody t,
  ) {
    final keys = t.keys;
    if (keys != null) {
      for (final k in keys.keys) {
        c.key(k, role: TxSignerRole.fileCreateKey);
      }
    }
  }

  static void _fileUpdate(
    _SignerCollector c,
    HederaFileUpdateTransactionBody t,
  ) {
    final keys = t.keys;
    if (keys != null) {
      for (final k in keys.keys) {
        c.key(k, role: TxSignerRole.fileUpdateKey);
      }
    }
  }

  static void _consensusCreate(
    _SignerCollector c,
    HederaConsensusCreateTopicTransactionBody t,
  ) {
    c.key(t.adminKey, role: TxSignerRole.consensusCreateAdminKey);
    c.key(t.submitKey, role: TxSignerRole.consensusCreateSubmitKey);
    c.account(
      t.autoRenewAccount,
      role: TxSignerRole.consensusCreateAutoRenewAccount,
    );
  }

  static void _consensusUpdate(
    _SignerCollector c,
    HederaConsensusUpdateTopicTransactionBody t,
  ) {
    c.key(t.adminKey, role: TxSignerRole.consensusUpdateAdminKey);
    c.key(t.submitKey, role: TxSignerRole.consensusUpdateSubmitKey);
    c.account(
      t.autoRenewAccount,
      role: TxSignerRole.consensusUpdateAutoRenewAccount,
    );
  }

  static void _tokenCreate(
    _SignerCollector c,
    HederaTokenCreateTransactionBody t,
  ) {
    c.account(t.treasury, role: TxSignerRole.tokenCreateTreasury);
    c.account(
      t.autoRenewAccount,
      role: TxSignerRole.tokenCreateAutoRenewAccount,
    );
    c.key(t.adminKey, role: TxSignerRole.tokenCreateAdminKey);
    c.key(t.kycKey, role: TxSignerRole.tokenCreateKycKey);
    c.key(t.freezeKey, role: TxSignerRole.tokenCreateFreezeKey);
    c.key(t.wipeKey, role: TxSignerRole.tokenCreateWipeKey);
    c.key(t.supplyKey, role: TxSignerRole.tokenCreateSupplyKey);
    c.key(t.feeScheduleKey, role: TxSignerRole.tokenCreateFeeScheduleKey);
    c.key(t.pauseKey, role: TxSignerRole.tokenCreatePauseKey);
    c.key(t.metadataKey, role: TxSignerRole.tokenCreateMetadataKey);
  }

  static void _tokenUpdate(
    _SignerCollector c,
    HederaTokenUpdateTransactionBody t,
  ) {
    c.account(t.treasury, role: TxSignerRole.tokenUpdateTreasury);
    c.account(
      t.autoRenewAccount,
      role: TxSignerRole.tokenUpdateAutoRenewAccount,
    );
    c.key(t.adminKey, role: TxSignerRole.tokenUpdateAdminKey);
    c.key(t.kycKey, role: TxSignerRole.tokenUpdateKycKey);
    c.key(t.freezeKey, role: TxSignerRole.tokenUpdateFreezeKey);
    c.key(t.wipeKey, role: TxSignerRole.tokenUpdateWipeKey);
    c.key(t.supplyKey, role: TxSignerRole.tokenUpdateSupplyKey);
    c.key(t.feeScheduleKey, role: TxSignerRole.tokenUpdateFeeScheduleKey);
    c.key(t.pauseKey, role: TxSignerRole.tokenUpdatePauseKey);
    c.key(t.metadataKey, role: TxSignerRole.tokenUpdateMetadataKey);
  }

  static void _tokenAssociate(
    _SignerCollector c,
    HederaTokenAssociateTransactionBody t,
  ) {
    c.account(t.account, role: TxSignerRole.tokenAssociateAccount);
  }

  static void _tokenDissociate(
    _SignerCollector c,
    HederaTokenDissociateTransactionBody t,
  ) {
    c.account(t.account, role: TxSignerRole.tokenDissociateAccount);
  }

  static void _tokenReject(
    _SignerCollector c,
    HederaTokenRejectTransactionBody t,
  ) {
    c.account(t.owner, role: TxSignerRole.tokenRejectOwner);
  }

  static void _tokenAirdrop(
    _SignerCollector c,
    HederaTokenAirdropTransactionBody t,
  ) {
    for (final list in t.tokenTransfers) {
      for (final a in list.transfers) {
        final amt = a.amount;
        if (amt != null && amt.isNegative) {
          c.account(a.accountID, role: TxSignerRole.tokenAirdropDebit);
        }
      }
      for (final nft in list.nftTransfers) {
        c.account(
          nft.senderAccountID,
          role: TxSignerRole.tokenAirdropNftSender,
        );
      }
    }
  }

  static void _scheduleCreate(
    _SignerCollector c,
    HederaScheduleCreateTransactionBody t,
  ) {
    c.key(t.adminKey, role: TxSignerRole.scheduleCreateAdminKey);
    c.account(t.payerAccountID, role: TxSignerRole.scheduleCreatePayer);
  }

  /// Every pending airdrop being cancelled MUST be signed by its own
  /// `sender_id` — cancelling someone else's outbound airdrop isn't
  /// authorized just because you're the payer. Multiple entries in the same
  /// tx (up to 10, per the proto docs) each get their own signer
  /// requirement; duplicate senders across entries dedupe automatically.
  static void _tokenCancelAirdrop(
    _SignerCollector c,
    HederaTokenCancelAirdropTransactionBody t,
  ) {
    for (final p in t.pendingAirdrops) {
      c.account(
        p.senderId,
        role: TxSignerRole.tokenCancelAirdropSender,
        note: 'Sender of the pending airdrop MUST sign to cancel it',
      );
    }
  }

  /// Every pending airdrop being claimed MUST be signed by its own
  /// `receiver_id`. Same multi-entry handling as cancel.
  static void _tokenClaimAirdrop(
    _SignerCollector c,
    HederaTokenClaimAirdropTransactionBody t,
  ) {
    for (final p in t.pendingAirdrops) {
      c.account(
        p.receiverId,
        role: TxSignerRole.tokenClaimAirdropReceiver,
        note: 'Receiver of the pending airdrop MUST sign to claim it',
      );
    }
  }

  /// `ethereumTransaction` is unusual: the authority that matters
  /// (the Ethereum sender) already signed `ethereumData` itself with its own
  /// ECDSA signature — that signature is validated independently of the HAPI
  /// signature map. So the sender is deliberately NOT added to `required`;
  /// it's surfaced via [TxBodySigners.ethereumSender] for visibility only.
  /// The only HAPI-level signer for this body type is the payer.
  static void _ethereumTransaction(
    _SignerCollector c,
    HederaEthereumTransactionBody t,
  ) {
    final raw = t.ethereumData;
    if (raw == null || raw.isEmpty) {
      c.warn(
        'ethereumTransaction: ethereumData is empty; cannot recover the '
        'wrapped sender.',
      );
      return;
    }
    if (t.callData != null) {
      c.warn(
        'ethereumTransaction: callData points at a HederaFileID holding the '
        'actual call data, so the ethereumData bytes on this body are only '
        'a partial RLP frame — the embedded sender cannot be recovered '
        'without first fetching and reassembling that file\'s content.',
      );
      return;
    }
    try {
      final tx = ETHTransaction.fromSerialized(raw);
      final from = tx.from;
      if (from == null) {
        c.warn(
          'ethereumTransaction: parsed the wrapped Ethereum transaction but '
          'could not recover a sender address from it (unsigned, or the '
          'signature didn\'t resolve to an address).',
        );
        return;
      }
      final ethAddr = HederaAddress(from.address);
      c.ethereumSender = TxRequiredSigner.account(
        account: ethAddr,
        role: TxSignerRole.ethereumSender,
        note:
            'Wrapped Ethereum sender, recovered from ethereumData\'s own '
            'ECDSA signature — already authorized by that signature, so it '
            'is not an additional HAPI signer.',
      );
      c.warn(
        'ethereumTransaction: wrapped Ethereum sender is ${from.address}. '
        'It already authorized ethereumData via its own signature and is '
        'not an additional HAPI signer — see TxBodySigners.ethereumSender.',
      );
    } catch (e) {
      c.warn(
        'ethereumTransaction: failed to parse ethereumData as an Ethereum '
        'transaction ($e).',
      );
    }
  }
}

/// Derives the three [HederaFeeCalculator.calculateHIP1261Fee] usage
/// parameters from a resolved signer-detection result
/// (`detectAllSigningRequirements` / `detectAllSigningRequirementsLocal`).
extension TxSigningRequirementsFeeParams on List<TxSigningRequirement> {
  /// Sum of signatures every authority in this list must contribute.
  ///
  /// Delegates entirely to [TxSigningRequirement.totalSignatures], which
  /// already hardcodes `1` for every unresolved requirement and for every
  /// account-kind requirement, and only computes a real threshold-key count
  /// for *resolved* key-kind requirements. Nothing extra to special-case
  /// here — this is a straight `fold`.
  int get totalSignatureCount =>
      fold<int>(0, (sum, r) => sum + r.totalSignatures());

  /// Approximates `existingKeyCount` — the count of keys that already exist
  /// on the entity being acted on (as opposed to keys newly supplied by the
  /// transaction body itself, e.g. on a *Create).
  ///
  /// Caveat: [TxSigningRequirement.fromState] is only ever set `true` on
  /// *resolved* entries (see `TxSigningRequirement._fromRequired`); the
  /// factory for unresolved entries (`_fromMissing`) always leaves it at its
  /// `false` default, even though every role that lands in
  /// [TxBodySigners.missingKeys] originates from a state lookup that failed
  /// — body-declared roles are collected synchronously and are always
  /// resolved. So this counts `kind == key` where either `fromState` is
  /// true, or the requirement is unresolved (`!resolved`), to catch both
  /// cases. It will still be 0 for pure-body-key transactions (TokenCreate,
  /// CryptoCreate with receiverSigRequired, etc.), which is correct — those
  /// keys aren't "existing" on anything yet.
  int get existingKeyCount =>
      where(
        (r) => r.kind == TxSignerKind.key && (r.fromState || !r.resolved),
      ).length;

  /// Best-effort stand-in for `existingAccountCount` — the fee schedule's
  /// notion of "extra accounts touched beyond the transaction body" (e.g.
  /// auto-created accounts from an unknown-alias transfer).
  ///
  /// This is *not* an accurate mapping: signer detection only tells you
  /// which accounts must sign, not which accounts a transfer will end up
  /// touching. An auto-created recipient account, in particular, is
  /// invisible here — it has no key/account to sign with yet, so it never
  /// appears in [TxBodySigners.required] or [TxBodySigners.missingKeys] at
  /// all. Treat this as a floor (accounts required to *authorize* the tx,
  /// minus the payer), and if you know a CryptoTransfer triggers
  /// auto-creation, add that count in yourself rather than relying on this
  /// getter.
  int get existingAccountCount =>
      where(
        (r) => r.kind == TxSignerKind.account && r.role != TxSignerRole.payer,
      ).length;

  /// Roles from this list that could not be resolved to a concrete
  /// account/key — i.e. the [TxSigningRequirement] entries with
  /// `resolved == false`, which is exactly the set that came from
  /// [TxBodySigners.missingKeys] in the first place (see
  /// `TxSigningRequirement._fromMissing`). Recovers that original list from
  /// `allSigningRequirements`/`detectAllSigningRequirements(...)` output
  /// without needing to hold onto the source [TxBodySigners] separately.
  ///
  /// These roles still legally MUST sign — nothing here means the
  /// authorization requirement went away, only that this collector couldn't
  /// resolve the actual key/account bytes for it (lookup strategy didn't
  /// allow the query, entity/key was missing on state, etc.). Obtain the
  /// missing key out of band (e.g. via
  /// `TxBodySignerLookupParams.providedKeys`) or enable a broader lookup
  /// strategy and re-run detection.
  ///
  /// Note this can contain duplicate roles when more than one occurrence of
  /// the same role family is unresolved (e.g. two different unresolved
  /// `topicSubmitKey` entries) — use [TxSigningRequirement.uniqueRole] on the
  /// unfiltered list instead if you need one entry per requirement.
  List<TxSignerRole> get missingKeys =>
      where((e) => !e.resolved).map((e) => e.role).toList();
}

/// Every [TxSignerRole] a *key* entry in [TxBodySignerLookupParams.providedKeys]
/// could legitimately satisfy for this specific body — the union of roles the
/// body declares inline (create/update key fields) and roles the body would
/// otherwise need resolved from entity state (delete/mutate ops with no
/// inline key).
///
/// Mirrors `_collectBodySigners` / `_resolveStateKeys`'s branching by design —
/// it has to, since that's the only place that knows which roles apply to
/// which body type. Keep this in sync if those methods change; a role added
/// there and not here just means `scopedTo` silently drops a key that would
/// otherwise have been used.
extension TxBodySignerLookupApplicability on HederaTransactionBody {
  Set<TxSignerRole> get applicableProvidedKeyRoles {
    if (tokenCreation != null) {
      return const {
        TxSignerRole.tokenCreateAdminKey,
        TxSignerRole.tokenCreateKycKey,
        TxSignerRole.tokenCreateFreezeKey,
        TxSignerRole.tokenCreateWipeKey,
        TxSignerRole.tokenCreateSupplyKey,
        TxSignerRole.tokenCreateFeeScheduleKey,
        TxSignerRole.tokenCreatePauseKey,
        TxSignerRole.tokenCreateMetadataKey,
      };
    }
    if (tokenUpdate != null) {
      return const {
        TxSignerRole.tokenUpdateAdminKey,
        TxSignerRole.tokenUpdateKycKey,
        TxSignerRole.tokenUpdateFreezeKey,
        TxSignerRole.tokenUpdateWipeKey,
        TxSignerRole.tokenUpdateSupplyKey,
        TxSignerRole.tokenUpdateFeeScheduleKey,
        TxSignerRole.tokenUpdatePauseKey,
        TxSignerRole.tokenUpdateMetadataKey,
        TxSignerRole.tokenAdminKey, // current adminKey, from state
      };
    }
    if (tokenDeletion != null) return const {TxSignerRole.tokenAdminKey};
    if (tokenMint != null || tokenBurn != null) {
      return const {TxSignerRole.tokenSupplyKey};
    }
    if (tokenWipe != null) return const {TxSignerRole.tokenWipeKey};
    if (tokenFreeze != null || tokenUnfreeze != null) {
      return const {TxSignerRole.tokenFreezeKey};
    }
    if (tokenGrantKyc != null || tokenRevokeKyc != null) {
      return const {TxSignerRole.tokenKycKey};
    }
    if (tokenPause != null || tokenUnpause != null) {
      return const {TxSignerRole.tokenPauseKey};
    }
    if (tokenFeeScheduleUpdate != null) {
      return const {TxSignerRole.tokenFeeScheduleKey};
    }
    if (tokenUpdateNfts != null) return const {TxSignerRole.tokenMetadataKey};

    if (contractCreateInstance != null) {
      return const {TxSignerRole.contractCreateAdminKey};
    }
    if (contractUpdateInstance != null) {
      return const {
        TxSignerRole.contractUpdateAdminKey,
        TxSignerRole.contractAdminKey,
      };
    }
    if (contractDeleteInstance != null) {
      return const {TxSignerRole.contractAdminKey};
    }

    if (fileCreate != null) return const {TxSignerRole.fileCreateKey};
    if (fileUpdate != null) {
      return const {TxSignerRole.fileUpdateKey, TxSignerRole.fileKey};
    }
    if (fileAppend != null || fileDelete != null) {
      return const {TxSignerRole.fileKey};
    }

    if (consensusCreateTopic != null) {
      return const {
        TxSignerRole.consensusCreateAdminKey,
        TxSignerRole.consensusCreateSubmitKey,
      };
    }
    if (consensusUpdateTopic != null) {
      return const {
        TxSignerRole.consensusUpdateAdminKey,
        TxSignerRole.consensusUpdateSubmitKey,
        TxSignerRole.topicAdminKey,
        TxSignerRole.topicSubmitKey,
      };
    }
    if (consensusDeleteTopic != null) return const {TxSignerRole.topicAdminKey};
    if (consensusSubmitMessage != null) {
      return const {TxSignerRole.topicSubmitKey};
    }

    if (scheduleCreate != null) {
      return const {TxSignerRole.scheduleCreateAdminKey};
    }
    if (scheduleDelete != null || scheduleSign != null) {
      return const {TxSignerRole.scheduleAdminKey};
    }

    if (cryptoCreateAccount != null) {
      return const {TxSignerRole.cryptoCreateKey};
    }
    if (cryptoUpdateAccount != null) {
      return const {TxSignerRole.cryptoUpdateNewKey};
    }

    return const {};
  }
}

/// Scopes a [TxBodySignerLookupParams] down to only the roles [body] can
/// actually use, so a shared/cached `providedKeys` map can never leak an
/// irrelevant or wrongly-typed key into `TxBodySigners.required`.
/// Scopes a [TxBodySignerLookupParams] down to only the roles [body] can
/// actually use, so a shared/cached `providedKeys` map can never leak an
/// irrelevant or wrongly-typed key into `TxBodySigners.required`.
extension TxBodySignerLookupParamsSafety on TxBodySignerLookupParams {
  TxBodySignerLookupParams scopedTo(HederaTransactionBody body) {
    final applicable = body.applicableProvidedKeyRoles;
    final filtered = <TxSignerRole, HederaKey>{
      for (final e in providedKeys.entries)
        // TxSignerRole.payer is allowed through unconditionally, bypassing
        // both the per-body applicability check and the impliedKind check:
        // every body has exactly one payer, and impliedKind(payer) resolves
        // to TxSignerKind.account (that's what `_fromMissing` should assume
        // if a payer role ever ends up unresolved) — but that says nothing
        // about whether a *key* can be supplied for it. Supplying one here
        // is how a multi-sig/threshold-key payer account gets an accurate
        // TxSigningRequirement.totalSignatures() instead of the flat `1`
        // that a plain account-kind payer entry would otherwise report.
        if (e.key == TxSignerRole.payer ||
            (applicable.contains(e.key) &&
                e.key.impliedKind == TxSignerKind.key))
          e.key: e.value,
    };
    if (filtered.length == providedKeys.length) return this; // nothing dropped
    return TxBodySignerLookupParams(
      resolveStateKeys: resolveStateKeys,
      providedKeys: filtered,
      preferBodyKeys: preferBodyKeys,
    );
  }
}
