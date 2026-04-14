# GDN-Hybrid + Sliding Window Attention + Warmdown1000 + Int6 GPTQ

Status: code patched for the SentencePiece byte-accounting bug identified on PR #1576. The previously reported val_bpb values from the original run051-safe031 logs were computed with the buggy LUT and are not authoritative for this staged submission folder.

## Current status

- Fixed issue: SentencePiece byte LUT no longer double-counts leading-space bytes for ▁-prefixed tokens.
- Affected metric: val_bpb in the original logs and metadata.
- Current authoritative val_bpb: pending corrected re-score from the saved run051-safe031 artifacts.
- Training legality lane remains unchanged: fixed predictor, no TTT, no SLOT, no RLS in the scored artifact.
- Artifact-size evidence remains unchanged: all three saved model artifacts are under the 16,000,000-byte cap even when counted with local code bytes.

## Technique stack

1. SP1024 tokenizer with a GDN-Hybrid backbone ([GDN×5] -> SWA -> [GDN×5] -> SWA_shared).
2. Fixed-predictor / no-TTT lane: no eval-time adaptation, no pre-quant adaptation, no SLOT, and no RLS in the scored artifact.
3. MuonEq-R + AdamW training mix, EMA 0.997, late QAT threshold 0.15, and warmdown=1000.
4. Int6 GPTQ quantization with zstd-22 compression for the final model artifact.
5. Self-contained record packaging: train_gpt.py plus local dependencies (architectures.py, configs.py, requirements.txt) all live in this record folder and compile from within the folder.

## Saved artifact evidence from run051-safe031

- seed 42 artifact bytes: 15,733,879
- seed 1337 artifact bytes: 15,903,365
- seed 2024 artifact bytes: 15,713,422
- counted artifact totals including local code bytes remain below 16,000,000 bytes for all three seeds.

## Notes

This folder is now staged as a corrected-code submission candidate, not a final score claim. Before any upstream submission or PR update, the quantized val_bpb must be recomputed with the patched byte-accounting logic and the submission metadata/log summary must be refreshed from that corrected evaluation.
