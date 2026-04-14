# GDN-Hybrid + Sliding Window Attention + Warmdown1000 + Int6 GPTQ (corrected 3-seed mean val_bpb 1.19671450)

This record was re-evaluated after fixing the SentencePiece byte-accounting bug identified on PR #1576. The authoritative val_bpb values below come from a fresh TensorPool re-evaluation job (`run055-reeval-gdn-bpbfix`) over the saved run051-safe031 int6 artifacts, using the corrected canonical LUT logic.

- Corrected 3-seed mean val_bpb: 1.19671450
- Corrected 3-seed mean XSA val_bpb: 1.20270994
- Best corrected quantized val_bpb: 1.19552275 (seed 1337)
- Worst corrected quantized val_bpb: 1.19850950 (seed 2024)
- Counted artifact size range: 15,740,230 to 15,930,173 bytes
- Re-eval TensorPool job: j-cc0ro8n61o on cluster c-8fb7887u9z (completed successfully)

## Corrected authoritative results

| Seed | Quantized val_bpb | XSA val_bpb | Counted artifact bytes |
|------|------------------:|------------:|-----------------------:|
| 42 | 1.19611126 | 1.20199938 | 15,760,687 |
| 1337 | 1.19552275 | 1.20070722 | 15,930,173 |
| 2024 | 1.19850950 | 1.20542323 | 15,740,230 |
| Mean | 1.19671450 | 1.20270994 | 15,810,363.33 |

## Technique stack

1. SP1024 tokenizer with a GDN-Hybrid backbone ([GDN×5] -> SWA -> [GDN×5] -> SWA_shared).
2. Fixed-predictor / no-TTT lane: no eval-time adaptation, no pre-quant adaptation, no SLOT, and no RLS in the scored artifact.
3. MuonEq-R + AdamW training mix, EMA 0.997, late QAT threshold 0.15, and warmdown=1000.
4. Int6 GPTQ quantization with zstd-22 compression for the final model artifact.
5. Self-contained record packaging: train_gpt.py plus local dependencies (architectures.py, configs.py, requirements.txt) all live in this record folder and compile from within the folder.
6. Submission authority is the corrected quantized val_bpb values above. XSA telemetry is included for completeness only.

## Important provenance note

The included `train_seed42.log`, `train_seed1337.log`, and `train_seed2024.log` files are the original run051-safe031 training logs and therefore still contain the pre-fix buggy BPB printouts. They remain useful as training/wallclock provenance, but they are not the source of truth for submission metrics.

The authoritative corrected metric provenance is the TensorPool re-evaluation of the saved `.ptz` artifacts from run051-safe031. See the accompanying `re_eval_results.json` and `re_eval_summary.txt` files for the corrected scorer outputs.
