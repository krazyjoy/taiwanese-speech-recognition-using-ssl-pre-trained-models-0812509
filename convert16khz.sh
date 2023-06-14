# cd "/home/dl0812509/espnet/egs2/librispeech_hw/asr1/downloads/test/random-noisy-test"
cd "/home/dl0812509/espnet/egs2/librispeech_hw/asr1/downloads/noisy-train/"
echo PWD
for x in ./*.wav
do 
  b=${x##*/}
  sox $b -r 16000 -e signed-integer -b 16 tmp_$b
  sox --i tmp_$b # check samplerate
  rm -rf $b
  mv tmp_$b $b
done
