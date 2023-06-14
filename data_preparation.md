1. download data from kaggle
    - rename as raw_data
2. rename "random-noisy-test 7" folder to "random-noisy-test-7"
3. resample test data
    - create convert16khz.sh
    - copy test25.2khz to "/home/dl0812509/espnet/egs2/librispeech_hw/asr1/downloads/test/"

    - change cd target location
    e.g. # cd "/home/dl0812509/espnet/egs2/librispeech_hw/asr1/downloads/test/random-noisy-test"
        # cd "/home/dl0812509/espnet/egs2/librispeech_hw/asr1/downloads/noisy-train/"
    - run /home/dl0812509/espnet/egs2/librispeech_hw/asr1/convert16khz.sh:
        `bash ./convert16khz.sh`
4. audiomentate train data
    - create audiomentations folder
    - add noises into folder
    - create augmentation.py
    - run augmentation.py by changing location pointing to audiomentations folder
5. resample train data
    - change cd target location
    e.g. 
        # cd "/home/dl0812509/espnet/egs2/librispeech_hw/asr1/downloads/train/"
    - run /home/dl0812509/espnet/egs2/librispeech_hw/asr1/convert16khz.sh:  
        `bash ./convert16khz.sh`
6. create dev data
    - copy data from noised-train-data
    - run create_dev_data.sh
        `bash ./create_dev_data.sh`

## data structures
    - train
        - 1
            - 11
                - 1-11-0001.wav ~ 1-11-3119.wav
                - 1-11.trans.txt
    - test
        - 2
            - 21
                - 2-21-0007179.wav ~ 2-21-3409841.wav
                - 2-21.trans.txt
    - dev
        - 3
            - 31
                - 3-31-0001.wav ~ 3-31-0010.wav
                - 3-31.tran.txt

1. create folders train/1/11, test/2/21, dev/3/31
2. filenames need to be equal length:
    - `rename_audio.sh`
    - 









## rename_audio.sh

```
#!/bin/bash
train_path="/home/dl0812509/espnet/egs2/librispeech_hw/asr1/downloads/LibriSpeech/train/1/11"
dev_path="/home/dl0812509/espnet/egs2/librispeech_hw/asr1/downloads/LibriSpeech/dev/3/31"
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

# cd $dev_path
# echo PWD
# for x in ./*.wav
# do 
#   b=${x##*/}
#   echo $b
#   # rm -rf $b
#   mv $b 3-31-000$b
# done

# cd $train_path
# echo PWD
# for x in ./*.wav
# do 
#   file_ext=${x##*/}
#   file=${file_ext%.wav}
#   echo "============="
#   echo "file without extension: $file"
#   echo "string length:"
#   echo ${#file}
#   num_of_zeros=$((4-${#file}))
#   prefix=""
#   for (( copy=1; copy<=$num_of_zeros; copy++)) ; do prefix="${prefix}0" ; done
#   echo "1-11-$prefix$file_ext"
#   mv $file_ext "1-11-$prefix$file_ext"
# done

```