import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logic_elements_pibic/ui/argumento.dart';
import 'package:logic_elements_pibic/ui/config.dart';
import 'package:logic_elements_pibic/ui/exercicios_argumentos.dart';
import 'package:logic_elements_pibic/ui/exercicios_formulas.dart';
import 'package:logic_elements_pibic/ui/formula.dart';
import 'package:logic_elements_pibic/ui/hist%C3%B3rico.dart';
import 'package:logic_elements_pibic/ui/informa%C3%A7oes.dart';
import 'package:logic_elements_pibic/ui/inicio.dart';
import 'argumentos _gerados.dart';
import 'formulas_geradas.dart';
import 'package:get/get.dart';

class DrawerPage extends StatefulWidget {

  final int currentePage;
  final List<dynamic> formulas;
  final List<dynamic> arguments;
  final String atomosMin;
  final String atomosMax;
  final String quantidadeAtomos;
  final String quantidadeFbfs;
  final String operadores;
  final String quantidadeListas;
  final String selectOperator;

  final String regras;
  final String atomos;
  final String listas;
  final String argumentos;
  final GoogleSignInAccount  conta;
  final GoogleSignIn googleSignIn;
  final bool anonimo;
  final File pathFormulas;
  final File pathArguments;

  DrawerPage({this.currentePage, this.formulas, this.arguments, this.atomosMin, this.atomosMax, this.quantidadeAtomos, this.operadores, this.quantidadeListas, this.selectOperator, this.quantidadeFbfs, this.regras, this.atomos, this.argumentos, this.listas, this.conta, this.googleSignIn, this.anonimo, this.pathFormulas, this.pathArguments});

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  List<dynamic> formulas = [];
  List<dynamic> arguments = [];
  String atomosMin = "";
  String atomosMax = "";
  String quantidadeAtomos = "";
  String quantidadeFbfs = "";
  String operadores = "";
  String quantidadeListas = "";
  String selectOperator = "";
  String regras;
  String atomosArg;
  String listas;
  String argumentosArg;
  File pathFormulas;
  File pathArguments;

  bool f = false;
  bool argumentos = false;

  int _selectedIndex = 0;
  String titulo = "";

  List<Widget> _widgetOptions = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("FORMULASINTESE".tr);
      setState(() {

        _selectedIndex = widget.currentePage != 0 ? widget.currentePage : _selectedIndex;
        print(_selectedIndex);
        if(_selectedIndex == 0){
          if(widget.anonimo){
            titulo = "OLA".tr+"!";
          }else{
            titulo = "OLA".tr+", "+widget.conta.displayName.split(' ')[0]+"!";
          }

        }else if(_selectedIndex == 1){
          titulo = "SINTESEFORMULA".tr;
        }else if(_selectedIndex == 2){
          titulo = "SINTESEARGUMENTOS".tr;
          argumentos = true;
        }else if(_selectedIndex == 3){
          titulo = "SINTESESALVA".tr;
        }else if(_selectedIndex == 4){
          titulo = "INFOR".tr;
        }else if(_selectedIndex == 5){
          print("chegou no 5");
          titulo = "FORMULASINTESE".tr;
          print(titulo);
          f = true;
          formulas = widget.formulas;
          atomosMin = widget.atomosMin;
          atomosMax = widget.atomosMax;
          quantidadeAtomos = widget.quantidadeAtomos;
          operadores = widget.operadores;
          quantidadeFbfs = widget.quantidadeFbfs;
          quantidadeListas = widget.quantidadeListas;
          selectOperator = widget.selectOperator;
        }else if(_selectedIndex == 6){
          print("tô aqui ");
          titulo = "FORMULASINTESE".tr;
          pathFormulas = widget.pathFormulas;
          print("Fórmulas " +titulo);
        }else if(_selectedIndex == 7){
          titulo = "ARGUMENTOSSINTETIZADOS".tr;
          argumentos = true;
          arguments = widget.arguments;
          regras = widget.regras;
          atomosArg = widget.atomos;
          argumentosArg = widget.argumentos;
          listas = widget.listas;
        }else if(_selectedIndex == 8){
          titulo = "ARGUMENTOSSINTETIZADOS".tr;
          print("Argumentos " +titulo);
          pathArguments = widget.pathArguments;
        }else if(_selectedIndex == 9){
          titulo = "CONFIG".tr;
        }
      });
    _widgetOptions = [
      Inicio(),
      Formula(),
      Argumento(),
      Historico(),
      Informacoes(),
      Formulas(formulas: formulas, atomosMin: atomosMin, atomosMax: atomosMax, quantidadeAtomos: quantidadeAtomos, operadores: operadores ,quantidadeFbfs: quantidadeFbfs, quantidadeListas: quantidadeListas, selectOperator: selectOperator),
      ListaFormulas(pathFormulas),
      Argumentos(arguments: arguments, regras: regras, atomos: atomosArg, argumentos: argumentosArg, listas: listas,),
      ExerciciosArgumento(pathArguments),
      Configuracoes()
    ];

    print("ṕassei por aqui");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$titulo", style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromRGBO(54, 205, 224, 1.0),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          argumentos==true? IconButton(
              icon: Icon(Icons.info),
              onPressed: (){
                showAlertDiag();
              }
          ) : Container()
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      backgroundColor: Colors.white,
      drawer: Container(
        width: 220.0,
        child: Drawer(

          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: 95.0,
                child: DrawerHeader(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Logic Elements",
                        style: TextStyle(fontSize: 20),
                      ),
                      IconButton(icon: Icon(Icons.settings), onPressed: () {
                        setState(() {
                          titulo = "CONFIG".tr;
                          _selectedIndex = 9;
                          Navigator.pop(context);
                        });
                      }, iconSize: 25.0,)
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(54, 205, 224, 1.0),
                  ),
                ),
              ),
              ListTile(
                title: Text('INICIO'.tr),
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                    titulo = "OLA".tr+"Filipe";
                    Navigator.pop(context);
                  });
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => Historico()));
                },
              ),
              ListTile(
                title: Text('FORMULA'.tr),
                onTap: () {
                  setState(() {
                    _selectedIndex = 1;
                    titulo = "SINTESEFORMULA".tr;
                    Navigator.pop(context);
                  });
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => Historico()));
                },
              ),
              ListTile(
                title: Text('ARGUMENTO'.tr),
                onTap: () {
                  setState(() {
                    _selectedIndex = 2;
                    titulo = "SINTESEARGUMENTOS".tr;
                    Navigator.pop(context);
                  });
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => Historico()));
                },
              ),
              ListTile(
                title: Text('SINTESESALVA'.tr),
                onTap: () {
                  setState(() {
                    _selectedIndex = 3;
                    titulo = "SINTESESALVA".tr;
                    Navigator.pop(context);
                  });
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => Historico()));
                },
              ),
              ListTile(
                title: Text('INFOR'.tr),
                onTap: () {
                  setState(() {
                    _selectedIndex = 4;
                    titulo = "INFOR".tr;
                    Navigator.pop(context);
                  });
//                Navigator.push(context, MaterialPageRoute(builder: (context) => Informacoes()));
                },
              ),
              ListTile(
                title: Text('CONFIG'.tr),
                onTap: () {
                  setState(() {
                    _selectedIndex = 9;
                    titulo = "CONFIG".tr;
                    Navigator.pop(context);
                  });
//                Navigator.push(context, MaterialPageRoute(builder: (context) => Informacoes()));
                },
              ),
              ListTile(
                title: Text('SAIR'.tr),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  widget.googleSignIn.signOut();
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      )
    );
  }

  Future<bool> showAlertDiag() async{
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Regras de inferência"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text("NE".tr),
                  Text("NI".tr),
                  Text("CI".tr),
                  Text("CE".tr),
                  Text("DI".tr),
                  Text("DE".tr),
                  Text("BE".tr),
                  Text("BI".tr),
                  Text("MP".tr),
                  Text("MT".tr),
                  Text("SD".tr),
                ],
              ),
            ),
            actions: [
              FlatButton(
                  onPressed: (){
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
