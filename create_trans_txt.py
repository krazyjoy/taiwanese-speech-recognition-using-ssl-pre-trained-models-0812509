import os

root = "/home/dl0812509/espnet/egs2/librispeech_hw/asr1/"
dev_path = "downloads/LibriSpeech/dev" # 3,31
test_path =  "downloads/LibriSpeech/test" # 2,21
train_path =  "downloads/LibriSpeech/train" # 1, 11


def create_trans_txt(root, folder_path, mode):
    if mode == "train":
        chapter_ = "1-11"
    if mode == "test":
        chapter_ = "2-21"
    if mode == "dev":
        chapter_ = "3-31"
    print(chapter_)
    if chapter_ == "1-11":
        with open(os.path.join(root, "downloads", "filtered_alpha.txt"),"r") as rf:
          with open(os.path.join(root,folder_path,"1","11","1-11.trans.txt"), "w") as wf:
                next(rf)
                for file in rf.readlines():
                    if file[:4] == "test":
                        break
                    print(file)
                    id = file.split(" ",1)[0]
                    text = file.split(" ",1)[1]
                    print(id)
                    print(text)
                    # cause validate issues
                    # new_id = chapter_ + "-" + "0" * (4-len(id)) + id
                    new_id = chapter_
                    new_id+="-"
                    for count in range(4-len(id)):
                        new_id+="0"
                    new_id+=id
                    new_file = [new_id, text]
                    line = ' '.join(new_file)
                    print(line)
                    wf.write(line)
    if chapter_ == "3-31":
        print("dev")
        with open(os.path.join(root, "downloads", "filtered_alpha.txt"),"r") as rf:
          with open(os.path.join(root,folder_path,"3","31","3-31.trans.txt"), "w") as wf:
                next(rf)
                cnt = 0
                for file in rf.readlines():
                    cnt+=1
                    if cnt <= 10:
                        # file = file.decode('utf-8')
                        print(file)
                        id = file.split(" ",1)[0]
                        text = file.split(" ",1)[1]
                        print(id)
                        print(text)
                        # cause validate issues
                        # new_id = chapter_ + "-" + "0" * (4-len(id)) + id
                        new_id = ""
                        for count in range(4-len(id)):
                            new_id+="0"
                        new_id+=id
                        line = "{}-{} {}".format(chapter_,new_id,text)
                        #new_file = [new_id, text]
                        #line = ' '.join(new_file)
                        print(line)
                        wf.write(line)
    if chapter_=="2-21":
        test_dir = os.path.join(root,test_path,"2","21")
        print("test_dir",test_dir)
        files = [name[:-4] for name in os.listdir(test_dir)]
        print("files:\n",files[:10])
        sorted_files = sorted(files, key=lambda name: int(name))
        print("sorted_files:\n",sorted_files[:10])
        with open(os.path.join(test_dir,"2-21.trans.txt"), "w") as wf:
            for i in range(0, len(sorted_files)):
                if 7-len(files[i]) >= 0:
                    new_id = ""
                    for count in range(7-len(sorted_files[i])):
                        new_id+="0"
                    new_id+=sorted_files[i]
                    line = "{}-{} a e i o u ".format(chapter_,new_id)
                else:
                    print("greater than 7:",sorted_files[i])
                print(line)
                wf.write(line)
                wf.write('\n')
                
            wf.close()
create_trans_txt(root, train_path, "train")