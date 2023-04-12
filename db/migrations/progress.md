## Start with the core data structures and info
- [x] Tipset
- [x] Headers
- [x] Messages
- [x] Receipts
- [x] Deal proposals
- [x] Actors
- [x] Actor State
- [x] Miner info
- [x] Miner sector deals
- [x] Miner sector infos
- [x] Miner sector proofs/posts

## Ensure adequate coverage of the different actor types
Some of these are not in lily, others are (e.g. power_actor_claims, multisig tables, id_addresses).
Some of these might be better derived at a secondary layer/cache by a "watcher".
- [x] Init Actor (id_addresses)
- [] Cron Actor
- [] Reward Actor
- [] Account Actor
- [] Storage Marker Actor
- [] Storage Miner Actor
- [] MultiSig Actor
- [] Payment Channel Actor
- [] Storage Power Actor
- [] Verified Registry Actor
- [] System Actor

## Move on to more auxiliary/meta (TBD) data
For the below, determine the relevancy before adding back in. We want our DB to be **much** lighter than Lily, if needed
secondary caches/layers/watcher can derive missing information from the core data.

### Summaries:
TODO: ask Riba which of these are critical (from consensus perpsective and also from end-user/utility perspective)
Chain economics
Chain powers
Chain rewards
Message gas economies

### More miner meta:
TODO: ask Riba which of these are critical (from consensus perpsective and also from end-user/utility perspective)
Miner current deadline infos
Miner debts
Miner locked funds
Miner pre-commit infos

## More message details
Derived gas outputs

## Create and apply indexes
- [] Indexes

## Create migration(s) for hypertable conversions
- [] Hypertable conversions
