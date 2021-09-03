import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:logic_elements_pibic/util/pdf.dart';

import 'drawer.dart';

class Formulas extends StatefulWidget {

  final List<dynamic> formulas;
  final String atomosMin;
  final String atomosMax;
  final String quantidadeAtomos;
  final String quantidadeFbfs;
  final String operadores;
  final String quantidadeListas;
  final String selectOperator;


  Formulas({this.formulas, this.atomosMin, this.atomosMax, this.quantidadeAtomos, this.quantidadeFbfs, this.operadores, this.quantidadeListas, this.selectOperator});

  @override
  _FormulasState createState() => _FormulasState();
}

class _FormulasState extends State<Formulas> {

  String atomosMin;
  String atomosMax;
  String quantidadeAtomos;
  String quantidadeFbfs;
  String operadores;
  String quantidadeListas;
  String selectOperator;

  Future<List> _getFormulas() async{
    http.Response response;

    response = await http.get("http://10.0.0.101:8080/api-logic/fbfs");
    return json.decode(response.body);
  }

  List<dynamic> formulas = [];
  PDF pdf = PDF();
  File file;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formulas = widget.formulas;
    atomosMin = widget.atomosMin;
    atomosMax = widget.atomosMax;
    quantidadeAtomos = widget.quantidadeAtomos;
    quantidadeFbfs = widget.quantidadeFbfs;
    operadores = widget.operadores[widget.operadores.length-1] == "," ? widget.operadores.substring(0, widget.operadores.length-1): widget.operadores;
    print(operadores);
    quantidadeListas = widget.quantidadeListas;
    selectOperator = widget.selectOperator;
    print(formulas);
    pdf.geraPdfFormulas(formulas, atomosMin, atomosMax, quantidadeAtomos, quantidadeFbfs, operadores, quantidadeListas, selectOperator).then((value){
      file = value;
    });
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
                  quantidadeAtomos != "" ? Text("QUANTATOMOS".tr+": $quantidadeAtomos", textAlign: TextAlign.start,) : atomos(),
                  // Text("Mínimo de átomos: 0", textAlign: TextAlign.start,),
                  // Text("Máximo de átomos: 0", textAlign: TextAlign.start,),
                  // Text("Quantidade de átomos: 0", textAlign: TextAlign.start,),
                  Text("QUANTFBF".tr+": $quantidadeFbfs", textAlign: TextAlign.start,),
                  Text("OPERECOLHIDOS".tr+": [$operadores]", textAlign: TextAlign.start,),
                  Text("LISTAEXERC".tr+": $quantidadeListas", textAlign: TextAlign.start,)
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: _getFormulas(),
                builder: (context, snapshot){
                  if (snapshot.connectionState == ConnectionState.none &&
                      snapshot.hasData == null) {
                    //print('project snapshot data is: ${projectSnap.data}');
                    return Container();
                  }
                  return ListView.builder(
                      itemCount: int.parse(quantidadeFbfs),
                      itemBuilder: (context, index){
                        return _formulaCard(context, index);
                      }
                  );
                },
              )
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
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DrawerPage(currentePage: 6, pathFormulas: file,)));

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

  _formulaCard(BuildContext context, int index) {
    print("cheguei aqui");
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
                formulas[index]['fbf'],
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget atomos(){
    return Column(
      children: [
        Text("MINATOMOS".tr+": $atomosMin", textAlign: TextAlign.start,),
        Text("MAXATOMOS".tr+": $atomosMax", textAlign: TextAlign.start,),
      ],
    );
  }
}
