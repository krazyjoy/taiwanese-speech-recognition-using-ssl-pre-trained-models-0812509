#!/usr/bin/env bash
# Set bash to 'debug' mode, it will exit on :
# -e 'error', -u 'undefined variable', -o ... 'error in pipeline', -x 'print commands',
set -e
set -u
set -o pipefail

train_set="train"
valid_set="dev"
test_sets="test"

# asr_config=conf/train_asr_conformer.yaml
asr_config=conf/tuning/test/train_asr_conformer7_wavlm_large.yaml
lm_config=conf/tuning/train_lm_transformer2.yaml
inference_config=conf/decode_asr.yaml
# --lm_train_text "data/${train_set}/text data/local/other_text/text" \
./asr.sh \
    --lang en \
    --ngpu 1 \
    --nbpe 5000 \
    --max_wav_duration 30 \
    --speed_perturb_factors "0.9 1.0 1.1" \
    --feats_normalize uttmvn \
    --asr_config "${asr_config}" \
    --lm_config "${lm_config}" \
    --inference_config "${inference_config}" \
    --train_set "${train_set}" \
    --valid_set "${valid_set}" \
    --test_sets "${test_sets}" \
    --lm_train_text "data/${train_set}/text" \
    --bpe_train_text "data/${train_set}/text" "$@"
