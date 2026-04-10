# SP1024 + Depth Recurrence (L3-5) + Parallel Residuals + Legal Score-First TTT

**Result: 1.07451312 BPB** (quantized_sliding_etlb)

**Lane: SAFE_SUBMISSION** — Clean legal result with no pre-quant TTT concerns.

## Architecture

- **Tokenizer:** SP1024 (saves ~4M params vs baseline)
- **Depth:** 11 layers with 3-layer depth recurrence (L3-5) → 14 virtual layers
- **Parallel Residuals:** From layer 7+ (parallel residual stream for improved gradient flow)
- **QK-Gain:** 5.25 initialization
- **Warmdown:** 0.095 WD, 0.72 warmdown ratio

## Legal TTT Configuration

- **Technique:** Score-first chunk-based TTT (PR #461/#549 pattern)
- **Epochs:** 3
- **Learning Rate:** 0.005
- **Freeze Blocks:** 0 (all blocks adapted)
- **No pre-quant TTT** — fully compliant with SAFE_SUBMISSION lane

## Results

| Metric | Value |
|--------|-------|
| Pre-quant BPB | 1.1131 |
| Post-TTT Pre-quant BPB | 1.0787 |
| Quantized BPB | 1.0964 |
| Quantized + Sliding Window BPB | 1.0748 |
| **Quantized + Sliding + ETLB BPB** | **1.0745** |
| Submission Size | 13.87 MB |
| Steps Completed | 5408 |
| Stopping Reason | Wallclock cap (588s) |

## Comparison

- **vs Our PR #1489 (BORDERLINE, 1.07389 BPB):** +0.0006 BPB worse, but CLEAN legality
- **vs Official SOTA (1.0810 BPB):** -0.0065 BPB (better)
- **vs PR #1514 (Legal TTT, 1.07983 BPB):** -0.0053 BPB (better)

## Significance

This result demonstrates that legal score-first TTT can achieve competitive performance without the legality concerns of pre-quant TTT. The 1.0745 BPB result:
1. Beats the official merged SOTA (1.0810 BPB)
2. Is submission-eligible in the clean SAFE_SUBMISSION lane
3. Validates the score-first TTT approach from PR #461/#549

## Files

- `submission.json` — Submission metadata
- `RESULTS.md` — Detailed results
- `train_gpt.py` — Training script
- `run_all_seeds.sh` — Seed runner script
- `run_seed314.sh` — Single-seed runner
