#!/usr/bin/env bash
# One-shot setup for the ICP examples: start the local replica, install the
# ICRC ledger, and fund the deterministic faucet account used by icp.dart.
#
# Safe to re-run (reinstall is explicit; funding is idempotent-ish).
# Requires: dfx on PATH, the ledger wasm + did in this folder.
set -euo pipefail

HERE="$(cd "$(dirname "$BASH_SOURCE[0]")" && pwd)"
LEDGER_WASM="${LEDGER_WASM:-$HERE/ic-icrc1-ledger.wasm}"
DID="${DID:-$HERE/icp_ledger.did}"
PROJECT="${PROJECT:-$HERE/.dfx-local}"
# Deterministic faucet used by icp.dart (seed 12).
FAUCET_PRINCIPAL="rvcuz-lc3sv-6rui2-vt6ri-gwf4y-r2lqn-frn5k-wr7be-h7hbi-rfntc-eae"

# 1. ledger wasm/did (download once if missing)
if [[ ! -f "$LEDGER_WASM" ]]; then
  echo "ledger wasm missing at $LEDGER_WASM" >&2
  echo "copy it from ~/.cache/dfinity/versions/<v>/wasms/ic-icrc1-ledger.wasm" >&2
  exit 1
fi

# 2. local dfx project (everything stays inside the repository)
mkdir -p "$PROJECT"
if [[ ! -f "$PROJECT/dfx.json" ]]; then
  cat > "$PROJECT/dfx.json" <<'EOF'
{
  "canisters": {
    "icp_ledger": {
      "type": "custom",
      "wasm": "../ic-icrc1-ledger.wasm",
      "candid": "../icp_ledger.did"
    }
  }
}
EOF
fi

# 2. start the shared local replica (port 4943)
if ! curl -s -m 3 -o /dev/null http://127.0.0.1:4943/api/v2/status; then
  echo "starting local replica..."
  ( cd "$PROJECT" && dfx start --background )
  for _ in $(seq 1 60); do
    curl -s -m 3 -o /dev/null http://127.0.0.1:4943/api/v2/status && break
    sleep 1
  done
fi
echo "replica up at http://127.0.0.1:4943"

# 3. install the ledger if not already running
cd "$PROJECT"
if ! dfx canister call icp_ledger icrc1_symbol >/dev/null 2>&1; then
  echo "installing icp_ledger..."
  DEFAULT_PRINCIPAL="$(dfx identity get-principal 2>/dev/null | tail -1)"
  dfx canister create icp_ledger >/dev/null 2>&1 || true
  dfx canister install icp_ledger --wasm "$LEDGER_WASM" --mode reinstall --yes \
    --argument "(variant { Init = record {
      minting_account = record { owner = principal \"$DEFAULT_PRINCIPAL\"; subaccount = null };
      fee_collector_account = null;
      transfer_fee = 10_000 : nat;
      decimals = opt (8:nat8);
      max_memo_length = null;
      token_symbol = \"LICP\";
      token_name = \"Local ICP\";
      metadata = vec {};
      initial_balances = vec { record { record { owner = principal \"$DEFAULT_PRINCIPAL\"; subaccount = null }; 1_000_000_000_000 : nat } };
      feature_flags = opt record { icrc2 = true };
      archive_options = record { num_blocks_to_archive = 1000:nat64; max_transactions_per_response = null; trigger_threshold = 1000:nat64; max_message_size_bytes = null; cycles_for_archive_creation = null; node_max_memory_size_bytes = null; controller_id = principal \"$DEFAULT_PRINCIPAL\"; more_controller_ids = null };
      index_principal = null } })"
  echo "ledger installed: $(dfx canister id icp_ledger)"
fi

# 4. fund the deterministic faucet (seed 12) if it has no balance
LEDGER_ID="$(dfx canister id icp_ledger)"
BAL="$(dfx canister call "$LEDGER_ID" icrc1_balance_of \
  "(record { owner = principal \"$FAUCET_PRINCIPAL\" })" 2>/dev/null | grep -o '[0-9_]*' | tr -d '_' | head -1)"
if [[ "${BAL:-0}" == "0" || -z "${BAL:-}" ]]; then
  echo "funding faucet $FAUCET_PRINCIPAL ..."
  dfx canister call "$LEDGER_ID" icrc1_transfer \
    "(record { to = record { owner = principal \"$FAUCET_PRINCIPAL\" }; amount = 100_000_000_000 : nat })"
fi

echo "---"
echo "ledger:  $LEDGER_ID  (set this as localLedgerCanisterId in icp.dart if different)"
echo "faucet:  $FAUCET_PRINCIPAL"
echo "run:     cd example && dart run lib/example/icp/icp.dart"