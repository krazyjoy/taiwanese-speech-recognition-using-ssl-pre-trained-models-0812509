[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/DAvmMcSJ)
# RUN COMMAND:
```
conda activate espnet
cd espnet
cd egs2
cd librispeech_hw
cd asr1
./run.sh
```


- 根據 run.sh 裡的設定，相當於執行以下指令:
```
./asr.sh --lang en --ngpu 1 --nbpe 5000 --max_wav_duration 30 --speed_perturb_factors 0.9 1.0 1.1 --feats_normalize uttmvn --asr_config conf/tuning/test/train_asr_conformer7_wavlm_large.yaml --lm_config conf/tuning/train_lm_transformer2.yaml --inference_config conf/decode_asr.yaml --train_set train --valid_set dev --test_sets test --lm_train_text data/train/text --bpe_train_text data/train/text
```

## Models
asr model: conf/tuning/test/train_asr_conformer7_wavlm_large.yaml

lm model: conf/tuning/train_lm_transformer2.yaml

inference model: conf/decode_asr.yaml

### ASR MODEL
https://espnet.github.io/espnet/espnet2_tutorial.html#usage-of-self-supervised-learning-representations-as-feature
說明了如何使用self-supervised Learning Representation 取代傳統的頻譜特徵

1. 到 espnet/tools/installers
- install S3PRL: run install_s3prl.sh
- install fairseq: run install_fairseq.sh

2. run.sh 檔案中增加 `--feats_normalize uttmvn` 參數以減少collect_stats 所耗費時間
3. 在 asr config 檔案中註明 `frontend` 和 `preencoder`
4. 根據使用 Hubert, Wa2Vec2.0改變 `preencoder_conf`的 `input_size`
5. 為了避免動到上方的pretrain模型，添加 `freeze_param: ["frontend.upstream"]`
6. 我使用的上層模型為: https://huggingface.co/s3prl/converted_ckpts/resolve/main/wavlm_base_plus.pt，
將儲存在 wavlm 的資料夾中

```
batch_type: numel
batch_bins: 1000000      #  40000000 原本的 batch_bins 大小
accum_grad: 3     # 加速gradient運算速度
max_epoch: 80           # 總訓練時長
patience: none
init: none
best_model_criterion:
-   - valid
    - acc
    - max
keep_nbest_models: 10
unused_parameters: true
freeze_param: [
"frontend.upstream"
]

frontend: s3prl
frontend_conf:
    frontend_conf:
        upstream: wavlm_url
        path_or_url: https://huggingface.co/s3prl/converted_ckpts/resolve/main/wavlm_base_plus.pt
    # download_dir: ./hub
    download_dir: ./wavlm
    multilayer_feature: True
```

**我的asr_config的重要參數**
- preencoder: linear 
    - input_size: 768
    - output_size: 80
- encoder: conformer 
    - output_size: 512
    - attention_heads: 8
    - linear_units: 2048
    - num_blocks: 12
    - dropout_rate: 0.1
- decoder: transformer
    - attention_heads: 8
    - linear_units: 2048
    - num_blocks: 6
    - dropout_rate: 0.1

## Audio Augmentations

放置雜訊音檔資料夾
- Audiomentation
    - Background_noise
    - Room_Inpulse_Response
    - Short_Noises

**在`downloads`資料夾中的音檔已經是加過雜訊的**

- `Augmentation.py` 添加雜訊到40%音檔中
    - 標示音檔的來源: InPath = "raw_data/archive/kaldi-taiwanese-asr/train"
    - 音檔處理後輸出位置: OutPath = "raw_data/archive/kaldi-taiwanese-asr/noisy-train"

- 在`sound_path`和 `ir_path`參數中標明雜訊音檔位置

### sampling frequency change
`convert16khz.sh`: 將頻率由22050轉為16000hz

### DATA STRUCTURE (follow Librispeech Format)

/home/dl0812509/espnet/egs2/librispeech_hw/asr1

1. LICENSE.TXT
2. SPEAKERS.TXT
3. 
    - Librispeech folder
        - train (檔案未全部上傳，檔案過大)
            - 1 (reader -- 需對應 SPEAKERS.TXT 的 ID)
                - 11
                    - 1-11-0001.wav~ 1-11-3119.wav
                    - 1-11.trans.txt (轉譯檔需與音檔放在一起)

        - test
            - 2
                - 21
                    - 2-21-0007179.wav ~ 2-21-3409841.wav
                    - 2-21.trans.txt
        
        - dev
            - 3
                - 31
                    - 3-31-0001.wav ~ 3-31-0010.wav
                    - 3-31.trans.txt

### RENAME AUDIOS
- `rename_audio.sh` 
- `{reader}-{chapter}-{id_}`: `id_` 須維持相同數字長度，假如總共有3119個音檔，則最高位數 = 4 ， id = 3 也要改成 id_ = 0003
- 依照編號重新排序
```
test_path="/home/dl0812509/espnet/egs2/librispeech_hw/asr1/downloads/LibriSpeech/test/2/21"

cd $test_path
echo PWD
for x in ./*.wav
do 
    file_ext=${x##*/}
    file=${file_ext%.wav}
    echo "============="
    echo "file without extension: $file"
    echo "string length:"
    echo ${#file}
    num_of_zeros=$((7-${#file}))
    prefix=""
    for (( copy=1; copy<=$num_of_zeros; copy++)) ; do prefix="${prefix}0" ; done
    echo "2-21-$prefix$file_ext"
    mv $file_ext "2-21-$prefix$file_ext"
done
```
- Accuracy
![image](https://github.com/MachineLearningNTUT/taiwanese-speech-recognition-using-ssl-pre-trained-models-0812509/blob/main/images/acc.png)

- Loss
![image](https://github.com/MachineLearningNTUT/taiwanese-speech-recognition-using-ssl-pre-trained-models-0812509/blob/main/images/loss.png)

- WER
![image](https://github.com/MachineLearningNTUT/taiwanese-speech-recognition-using-ssl-pre-trained-models-0812509/blob/main/images/wer.png)


## 心得
這次作業花比較多時間在準備資料集與尋找雜訊音檔，因為我是在助教報告之前找的，所以
沒有參考助教講的就實作，包括librispeech資料集也是看data.sh一步步實驗完成的，過程
不容易。但也因此沒有留太多時間給我測試不同模型，我只有試過不同的epoch數的收斂效果，
加上gpu的RAM限制，能使用的模型只有7b選擇並不多，因此在幾番嘗試之後選擇了wavlm_base_plus這個上層模型。