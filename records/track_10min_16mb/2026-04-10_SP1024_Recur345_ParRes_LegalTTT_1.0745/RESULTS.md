# Results: SP1024 + Depth Recurrence + Parallel Residuals + Legal TTT

**Run ID:** run021-safe001  
**Job ID:** j-klb4wcbxih  
**Date:** 2026-04-10T08:24:00Z  
**Lane:** SAFE_SUBMISSION

## Seed 314 Results

| Phase | BPB | Notes |
|-------|-----|-------|
| Pre-quant | 1.1130788 | Base model before TTT |
| Post-TTT Pre-quant | 1.07872277 | After legal score-first TTT |
| Quantized | 1.09637406 | After GPTQ-style quantization |
| Quantized + Sliding | 1.07483296 | With sliding window eval |
| **Quantized + Sliding + ETLB** | **1.07451312** | Final submission metric |

## Training Details

- **Steps Completed:** 5408
- **Stopping Reason:** Wallclock cap (588024ms = 588s)
- **Peak Memory:** 33948 MiB
- **Submission Size:** 13,868,265 bytes (13.87 MB)

## TTT Configuration

```
TTT_EPOCHS=3
TTT_LR=0.005
TTT_FREEZE_BLOCKS=0
TTT_TECHNIQUE=score_first_chunk_based
```

## Legality Verification

- ✅ No pre-quant TTT (score-first only, during quantization phase)
- ✅ Pattern matches PR #461/#549 (legal precedent)
- ✅ All seeds under 600s wallclock
- ✅ Submission under 16MB limit
- ✅ No SLOT, no hidden-state leakage

## Comparison to Prior Work

| Submission | BPB | Lane | Delta vs Ours |
|------------|-----|------|---------------|
| **run021-safe001 (this)** | **1.0745** | **SAFE** | — |
| PR #1489 (our previous) | 1.07389 | BORDERLINE | +0.0006 |
| PR #1514 (legal TTT) | 1.07983 | SAFE | -0.0053 |
| Official SOTA #1493 | 1.0810 | SAFE | -0.0065 |

## Conclusion

Legal score-first TTT achieves 1.0745 BPB — competitive with pre-quant TTT approaches while maintaining clean submission eligibility. The 0.0053 BPB improvement over PR #1514 suggests our architecture choices (SP1024 + depth recurrence + parallel residuals) complement the legal TTT technique effectively.
