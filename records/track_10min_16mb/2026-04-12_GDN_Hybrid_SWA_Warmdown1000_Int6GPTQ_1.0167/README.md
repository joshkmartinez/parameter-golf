# GDN-Hybrid + Sliding Window Attention + Warmdown1000 + Int6 GPTQ (3-seed mean val_bpb 1.01671233)

- 3-seed mean val_bpb: 1.01671233
- 3-seed std (sample): 0.00134386
- Best seed val_bpb: 1.015700 (seed 1337)
- Worst seed val_bpb: 1.018237 (seed 2024)
- Counted artifact size range: 15,740,145 to 15,930,088 bytes

## Per-seed authoritative results

| Seed | Steps | EMA val_bpb | Quantized val_bpb | XSA val_bpb | Counted artifact bytes |
|------|------:|------------:|------------------:|------------:|-----------------------:|
| 42 | 2227 | 1.007164 | 1.016200 | 1.021202 | 15,760,602 |
| 1337 | 2242 | 1.007164 | 1.015700 | 1.020105 | 15,930,088 |
| 2024 | 2227 | 1.009032 | 1.018237 | 1.024111 | 15,740,145 |
| Mean | — | 1.007787 | 1.01671233 | 1.021806 | 15,810,278.33 |
| Std (sample) | — | — | 0.00134386 | — | — |

## Technique stack

1. SP1024 tokenizer with a GDN-Hybrid backbone ([GDN×5] -> SWA -> [GDN×5] -> SWA_shared).
2. Fixed-predictor / no-TTT lane: no eval-time adaptation, no pre-quant adaptation, no SLOT, and no RLS in the scored artifact.
3. MuonEq-R + AdamW training mix, EMA 0.997, late QAT threshold 0.15, and warmdown=1000.
4. Int6 GPTQ quantization with zstd-22 compression for the final model artifact.
5. Self-contained record packaging: train_gpt.py plus local dependencies (architectures.py, configs.py, requirements.txt) all live in this record folder and compile from within the folder.
6. Submission authority is the pulled quantized val_bpb values above. XSA telemetry is included for completeness only.

All three seeds stayed below the 16,000,000-byte counted artifact cap and hit the 590s wallclock stop used for the 10-minute track. This submission is intended as a clean fixed-predictor record with quantized val_bpb as the submission metric.
