
for sound in ./downloads/train/*.wav
do
  # take only the file name + ext
  file_ext=${sound##*/} 
  # get file name
  file=${file_ext%.wav}
  
  # convert to integer
  zero=0
  filenum=$(($file - $zero)) 
  
  # if filename is less than 10 -> save as dev
  if [ "${filenum}" -le 10 ]; then
    echo $filenum
    cp $sound ./downloads/dev/
  fi
done
