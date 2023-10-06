## Start with the core data structures and info
- [x] CIDs Table
- [x] IPLD Blockstore
- [x] Tipset
- [x] Headers
- [x] Messages
- [x] Receipts
- [x] Deal proposals
- [x] Actors
- [x] Actor State
- [x] Actor Events
- [x] Miner info
- [x] Miner sector deals
- [x] Miner sector infos
- [x] Miner sector proofs/posts

## Ensure adequate coverage of the different actor types
Some of these are not in lily, others are (e.g. power_actor_claims, multisig tables, id_addresses).
Some of these might be better derived at a secondary layer/cache by a "watcher".
- [x] Init Actor (id_addresses)
- [x] Cron Actor
- [x] Reward Actor
- [x] Account Actor
- [x] Storage Marker Actor
- [x] Storage Miner Actor
- [x] MultiSig Actor
- [x] Payment Channel Actor
- [x] Storage Power Actor
- [x] Verified Registry Actor
- [x] System Actor (NA)
- [ ] User Actors

## Move on to more auxiliary/meta (TBD) data
For the below, determine the relevancy before adding back in. We want our DB to be **much** lighter than Lily, if needed
secondary caches/layers/watcher can derive missing information from the core data.

### Summaries:
* Chain economics
* Chain powers
* Chain rewards
* Message gas economies

### More miner meta:
* Miner current deadline infos
* Miner debts
* Miner locked funds
* Miner pre-commit infos

## More message details
* Derived gas outputs

## DB scripts and utils
- [x] Makefile
- [x] Dockerfile and compose files
- [x] Sanity checking scripts
- [ ] Github actions
- [x] UML

## Create and apply indexes
- [ ] Indexes

## Create migration(s) for hypertable conversions
- [x] Hypertable conversions
