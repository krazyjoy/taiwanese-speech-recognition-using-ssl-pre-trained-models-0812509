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