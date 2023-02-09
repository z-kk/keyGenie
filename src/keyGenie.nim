import
  std / [json, rdstdin, terminal],
  xxtea,
  keyGeniepkg / [submodule, datautil]

proc newKey(data: JsonNode, key: string) =
  while true:
    let title = readLineFromStdin("title: ")
    if title in data:
      echo title, " already exists in data."
    else:
      let value = readPasswordFromStdin("value: ")
      data[title] = %value.encrypt(key)
      break
  data.saveData

proc output(src, key: string) =
  stdout.write src.decrypt(key)

when isMainModule:
  var
    data = getData()
  let
    opt = readCmdOpt()
    key = readPasswordFromStdin()
    src = data.encStr(opt.target)

  if src == "":
    data.newKey(key)
  else:
    src.output(key)
