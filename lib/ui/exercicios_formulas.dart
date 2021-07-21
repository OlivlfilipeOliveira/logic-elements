import 'dart:io';

import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_extend/share_extend.dart';
import 'package:url_launcher/url_launcher.dart';

class ListaFormulas extends StatefulWidget {

  final File pathFormulas;

  ListaFormulas(this.pathFormulas);

  @override
  _ListaFormulasState createState() => _ListaFormulasState();
}

class _ListaFormulasState extends State<ListaFormulas> {
  File formulas;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formulas = widget.pathFormulas;

  }

  Future<String> _getPath() {
    return ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS);
  }

  Future<String> download(String nomeFile) async {
    final folderName = nomeFile;
    _getPath().then((value) async{
      final file = File("$value/$folderName");
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      if ((await file.exists())) {
        file.writeAsBytesSync(formulas.readAsBytesSync());
        showConfirmDownlod(file.path);
        return file.path;
      } else {
        file.create();
        file.writeAsBytesSync(formulas.readAsBytesSync());
        showConfirmDownlod(file.path);
      return file.path;
      }
    });
  }

  void _launchURL(String _url) async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
            top: 100.0,
            left: 40.0,
            right: 40.0
        ),
        color: Colors.white,
        child: ListView(
          children: [
            SizedBox( //diminui o tamanho da imagem
              width: 128,
              height: 128,
              child: Image.asset("images/pdf.png"),
            ),
            SizedBox(
              height: 10,
            ),
            Text(formulas.path.split("/")[6], textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(
              height: 20,
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 10.0, right: 10.0, left: 10.0),
                child: Container(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                            radius: 30,
                            backgroundColor: Color.fromRGBO(54, 205, 224, 1.0),
                            child: IconButton(
                                icon: Icon(
                                    Icons.arrow_back, color: Colors.white),
                                onPressed: () {
                                  Navigator.pop(context);
                                }
                            )
                        ),
                        CircleAvatar(
                            radius: 30,
                            backgroundColor: Color.fromRGBO(54, 205, 224, 1.0),
                            child: IconButton(
                                icon: Icon(Icons.download_rounded,
                                    color: Colors.white),
                                onPressed: ()async {

                                  download(formulas.path.split("/")[6]);
                                }
                            )
                        ),
                        CircleAvatar(
                            radius: 30,
                            backgroundColor: Color.fromRGBO(54, 205, 224, 1.0),
                            child: IconButton(
                                icon: Icon(Icons.share, color: Colors.white),
                                onPressed: () {
                                  print(formulas);
                                  ShareExtend.share(formulas.path, 'file');
                                }
                            )
                        ),
                      ],
                    )
                )
            )
          ],
        ),
      ),
    );
  }

  Future<bool> showConfirmDownlod(String path) async{
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Donwload do arquivo"),
            content: Text("O arqquivo com as questões foi salvo em: $path"),
            actions: [
              FlatButton(
                  onPressed: (){
                    _launchURL(path);
                    Navigator.pop(context);
                  },
                  color: Color.fromRGBO(54, 205, 224, 1.0),
                  child: Text("Ok", style: TextStyle(color: Colors.white),)
              ),
            ],
          );
        }
    );
  }
}
