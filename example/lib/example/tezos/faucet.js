#!/usr/bin/env node
// Fund a Shadownet address from the PoW faucet.
//
//   node lib/example/tezos/faucet.js <tz-address> [amount]
//
// Uses `curl` for the HTTP calls so the local proxy (HTTPS_PROXY) is honored;
// the PoW is solved locally with SHA-256. Requires Node 18+ and curl.

const crypto = require('crypto');
const { execFileSync } = require('child_process');

const FAUCET = 'https://faucet.shadownet.teztnets.com';

function post(path, body) {
  const out = execFileSync(
    'curl',
    [
      '-s',
      '-m',
      '60',
      '-X',
      'POST',
      FAUCET + path,
      '-H',
      'content-type: application/json',
      '-d',
      JSON.stringify(body),
    ],
    { encoding: 'utf8' },
  );
  return JSON.parse(out);
}

function solve(challenge, difficulty) {
  let nonce = 0;
  while (true) {
    const hash = crypto
      .createHash('sha256')
      .update(`${challenge}:${nonce}`)
      .digest('hex');
    if (hash.startsWith('0'.repeat(difficulty))) return { nonce, solution: hash };
    nonce++;
  }
}

(async () => {
  const address = process.argv[2];
  const amount = Number(process.argv[3] || '100');
  if (!address) {
    console.error('usage: node faucet.js <tz-address> [amount]');
    process.exit(1);
  }
  let c = post('/challenge', { address, amount });
  if (!c.challenge) {
    console.error('challenge failed:', JSON.stringify(c));
    process.exit(1);
  }
  let challenge = c.challenge;
  let difficulty = c.difficulty;
  let counter = c.challengeCounter;
  const needed = c.challengesNeeded;
  console.log(`${address}: ${amount} tez (${needed} challenges)`);
  while (challenge) {
    const { nonce, solution } = solve(challenge, difficulty);
    const v = post('/verify', { address, amount, nonce, solution });
    if (v.txHash) {
      console.log('tx:', v.txHash);
      return;
    }
    if (!v.challenge) {
      console.error('verify failed:', JSON.stringify(v));
      process.exit(1);
    }
    challenge = v.challenge;
    difficulty = v.difficulty;
    counter = v.challengeCounter;
    process.stderr.write(`  ${counter}/${needed}\n`);
  }
})().catch((e) => {
  console.error('error:', e.message);
  process.exit(1);
});