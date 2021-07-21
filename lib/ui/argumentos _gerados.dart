import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:logic_elements_pibic/util/pdf.dart';
import 'package:share_extend/share_extend.dart';
import 'drawer.dart';

class Argumentos extends StatefulWidget {

  final String regras;
  final String atomos;
  final String listas;
  final String argumentos;

  List<dynamic> arguments = [];

  Argumentos({this.arguments, this.regras, this.atomos, this.listas, this.argumentos});

  @override
  _ArgumentosState createState() => _ArgumentosState();
}

class _ArgumentosState extends State<Argumentos> {

  Future<List> _getArguments() async{
    http.Response response;

    response = await http.get("http://10.0.0.101:8080/api-logic/arguments");
    return json.decode(response.body);
  }
  String regras;
  String atomos;
  String listas;
  String argumentos;

  List<dynamic> arguments = [];

  PDF pdf = PDF();
  File file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    arguments = widget.arguments;
    regras = widget.regras[widget.regras.length-1] == "," ? widget.regras.substring(0, widget.regras.length-1) : widget.regras;
    atomos = widget.atomos;
    listas = widget.listas;
    argumentos = widget.argumentos;
    pdf.geraPdfArgumentos(arguments, regras, atomos, listas, argumentos).then((valor) {
      file = valor;
    });
    print(arguments.length);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: Text("Informações"),
      //   centerTitle: true,
      //   backgroundColor: Color.fromRGBO(54, 205, 224, 1.0),
      // ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0, bottom: 5.0),
              width: 400,
              height: 150,
              child: Column(
//                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text("CONFIGREAL".tr, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),textAlign: TextAlign.center,),
                  ),
                  Divider(),
                  Text("REGRASESCOLHIDAS".tr+": [$regras]", textAlign: TextAlign.start, maxLines: 2,),
                  Text("ATOMOS".tr+": $atomos", textAlign: TextAlign.start,),
                  Text("QUANTARG".tr+": $argumentos", textAlign: TextAlign.start,),
                  Text("LISTAEXERC".tr+": $listas", textAlign: TextAlign.start,)
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: _getArguments(),
                builder: (context, snapshot){
                  switch (snapshot.connectionState){
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Container(
                        width: 200.0,
                        height: 200.0,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.black
                          ),
                          strokeWidth: 5.0,
                        ),
                      );
                    default:
                      if(snapshot.hasError)
                        return Container();
                      else
                        return ListView.builder(
                            itemCount: int.parse(argumentos),
                            itemBuilder: (context, index){
                              return _argumentoCard(context, index);
                            }
                        );
                  }
                },
              ),
              // child: ListView.builder(
              //   padding: EdgeInsets.all(10.0),
              //   itemCount: argumentos.length,
              //   itemBuilder: (context, index) {
              //     return _argumentoCard(context, index);
              //   },
              // ),
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
                                icon: Icon(Icons.arrow_back, color: Colors.white),
                                onPressed: (){
                                  Navigator.pop(context);
                                }
                            )
                        ),
                        CircleAvatar(
                            radius: 30,
                            backgroundColor: Color.fromRGBO(54, 205, 224, 1.0),
                            child: IconButton(
                                icon: Icon(Icons.save, color: Colors.white),
                                onPressed: (){}
                            )
                        ),
                        CircleAvatar(
                            radius: 30,
                            backgroundColor: Color.fromRGBO(54, 205, 224, 1.0),
                            child: IconButton(
                                icon: Icon(Icons.arrow_forward, color: Colors.white),
                                onPressed: (){
                                  //ShareExtend.share(file.path, 'file');
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => DrawerPage(currentePage: 8, pathArguments: file,)));
                                }
                            )
                        ),
                      ],
                    )
                )
            )
          ],
        ));
  }

  _argumentoCard(BuildContext context, int index) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 350.0,
              height: 50.0,
              alignment: Alignment.center,
              child: Text(
                arguments[index]['argument'],
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
