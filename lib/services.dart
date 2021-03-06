Future<List> fetchTvFolders(basicDeatials) async {
  final sshClient = basicDeatials["client"];
  var array;
  List<String> folderList = [];
  try {
    String result = await sshClient.connect();
    if (result == "session_connected") {
      result = await sshClient.connectSFTP();
      if (result == "sftp_connected") {
        array = await sshClient.sftpLs(basicDeatials["tvPath"]);
        // print(array);
        if (array != null) {
          for (var i = 0; i < array.length; i++) {
            if (array[i]["isDirectory"]) {
              folderList.add(array[i]["filename"].toString());
            }
          }
        }
      }
    }
  } on Exception catch (e) {
    print(e);
  }
  return folderList;
}

Future<List> movieList(basicDeatials) async {
  final sshClient = basicDeatials["client"];
  var array;
  List<Map<String, dynamic>> folderList = [];
  try {
    String result = await sshClient.connect();
    if (result == "session_connected") {
      result = await sshClient.connectSFTP();
      if (result == "sftp_connected") {
        array = await sshClient.sftpLs(basicDeatials["moviePath"]);
        // print(array);
        if (array != null) {
          for (var i = 0; i < array.length; i++) {
            if (!array[i]["isDirectory"]) {
              folderList.add({
                "filename": array[i]["filename"].toString(),
                "size": array[i]["fileSize"]
              });
            }
          }
        }
      }
    }
  } on Exception catch (e) {
    print(e);
  }
  return folderList;
}

Future<List> tvFileList(basicDeatials, foldername) async {
  final sshClient = basicDeatials["client"];
  var array;
  List<Map<String, dynamic>> folderList = [];
  try {
    String result = await sshClient.connect();
    if (result == "session_connected") {
      result = await sshClient.connectSFTP();
      if (result == "sftp_connected") {
        array =
            await sshClient.sftpLs(basicDeatials["tvPath"] + '/' + foldername);
        if (array != null) {
          for (var i = 0; i < array.length; i++) {
            if (!array[i]["isDirectory"]) {
              folderList.add({
                "filename": array[i]["filename"].toString(),
                "size": array[i]["fileSize"]
              });
            }
          }
        }
      }
    }
  } on Exception catch (e) {
    print(e);
  }
  return folderList;
}
