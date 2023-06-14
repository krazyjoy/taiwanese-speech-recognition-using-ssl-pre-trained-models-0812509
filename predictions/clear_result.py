

raw_pred_path = "./round1/raw_output.txt"
clean_pred_path= "./round1/clean_output.txt"

with open(raw_pred_path, "r") as rf:
  with open(clean_pred_path, "w") as wf:
    column_name = 'id,text'
    wf.write(column_name)
    wf.write('\n')
    for pred in rf.readlines():
      print(pred)
      label = pred.split(' ',1)[0]
      id = label.split('-')[2]
      for i in range(len(id)):
        if id[i] != '0':
          start=i
          break
      print("id",id[start:])
      text = pred.split(' ',1)[1]
      clean_row = [id[start:], text]
      clean_line = ','.join(clean_row)
      print(clean_line)
      wf.write(clean_line)
      print('=========')

      
