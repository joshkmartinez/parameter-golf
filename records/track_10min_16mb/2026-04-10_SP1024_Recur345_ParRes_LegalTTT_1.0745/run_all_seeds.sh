#!/bin/bash
set -euxo pipefail
# Run 020 (safe-001): Run all 3 seeds

for seed in 314 42 1337; do
  echo "=== Seed $seed ==="
  export SEED=$seed
  bash records/track_10min_16mb/2026-04-10_SP1024_Recur345_ParRes_LegalTTT/run_seed314.sh 2>&1 | tee -a logs/run020_s${seed}.log
done
echo "=== All seeds complete ==="
