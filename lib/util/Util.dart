
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Util{
  Future<File> getFile() async {
    final directory = await getApplicationDocumentsDirectory();

    return File("${directory.path}/idioma.json");
  }

  Future<File> saveData(List _idiomas) async {
    String data = json.encode(_idiomas);

    final file = await getFile();

    return file.writeAsString(data);
  }

  Future<String> readData() async{

    try{
      final file = await getFile();

      return file.readAsString();

    }catch(e){
      return null;
    }
  }
}