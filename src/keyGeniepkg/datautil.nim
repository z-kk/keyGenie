import
  std / [os, json],
  cliSeqSelector

when defined(release):
  import
    submodule

const
  DataFile = "data.json"

proc dataFileName(): string =
  when defined(release):
    getConfigDir() / appName / DataFile
  else:
    DataFile

proc getData*(): JsonNode =
  ## Get key data from data file.
  let path = dataFileName()
  if path.fileExists:
    path.parseFile
  else:
    return %*{}

proc saveData*(data: JsonNode) =
  ## Save key data to data file.
  let path = dataFileName()
  path.parentDir.createDir
  path.writeFile(data.pretty)

proc encStr*(data: JsonNode, target: string): string =
  ## Select target and return the data.
  if target in data:
    return data[target].getStr

  var list = @["new item"]
  for key, node in data:
    list.add key

  let res = list.select
  if res.idx == 0:
    return
  return data[res.val].getStr
