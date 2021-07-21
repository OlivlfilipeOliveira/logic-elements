import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logic_elements_pibic/ui/drawer.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class Formula extends StatefulWidget {
  @override
  _FormulaState createState() => _FormulaState();
}

class _FormulaState extends State<Formula> {

  int selectOperator;

  setSelectOperator(int val){
    setState(() {
      selectOperator = val;
    });
  }

  final _atomosMaxController = TextEditingController();
  final _atomosMinController = TextEditingController();
  final _atomosQuantidadeController = TextEditingController();
  final _quantidadeFbfsController = TextEditingController();
  final _listaController = TextEditingController();
  //String _operadores = "";

  String _atomosMax = "";
  String _atomosMin = "";
  String _atomosQuantidade = "";
  String _quantidadeFbfs = "";
  String _listasExercicios = "";
  String _operadoresLista = "";


  bool _andVal = false;
  bool _orVal = false;
  bool _implyVal = false;
  bool _byImplyVal = false;
  bool _notVal = false;

  Future<List> _getInfors() async{
    if(_atomosQuantidadeController.text == ""){
      _atomosQuantidade = "0";
      _atomosMin = _atomosMinController.text;
      _atomosMax = _atomosMaxController.text;
    }else{
      _atomosQuantidade = _atomosQuantidadeController.text;
      _atomosMin = "0";
      _atomosMax = "0";
    }
    _quantidadeFbfs = _quantidadeFbfsController.text;
    _listasExercicios = _listaController.text;
    _operadoresLista = "";

    if(_andVal==true){
      _operadoresLista += "And,";
    }
    if(_orVal==true){
      _operadoresLista += "Or,";
    }
    if(_implyVal==true){
      _operadoresLista += "Imply,";
    }
    if(_byImplyVal==true){
      _operadoresLista += "BiImply,";
    }
    if(_notVal==true){
      _operadoresLista += "Not";
    }

    List<dynamic> formulas = [];

    http.Response response;

    response = await http.get("http://10.0.0.101:8080/api-logic/fbfs/$_atomosMin/$_atomosMax/$_atomosQuantidade/$_quantidadeFbfs/$selectOperator/$_operadoresLista/$_listasExercicios");

    return json.decode(response.body);
  }

  int currentStep = 0;
  bool complete = false;
  String textContinue = "CONTINUAR".tr;



  next() {
    print(currentStep);
    if(currentStep + 1 != 4){
      goTo(currentStep + 1);
      if(currentStep == 3){
        setState(() {
          textContinue = "CONCLUIR".tr;
        });
      }
    }else{

      print("tpa errrad");
      complete = true;
      List<dynamic> formulas = [];
      String selectOpe = "$selectOperator";

      _getInfors().then((fbfs){
          formulas = fbfs;
          print(formulas.length);
          Navigator.push(context, MaterialPageRoute(builder: (context) => DrawerPage(currentePage: 5, formulas: formulas, atomosMin: _atomosMinController.text, atomosMax: _atomosMaxController.text, quantidadeAtomos: _atomosQuantidadeController.text, operadores: _operadoresLista, quantidadeFbfs: _quantidadeFbfsController.text, quantidadeListas: _listaController.text, selectOperator: selectOpe,)));
      });

    }
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
      setState(() {
        textContinue = "CONTINUAR".tr;
      });

    }
  }

  goTo(int step) {
    setState(() {
      currentStep = step;
      // if(currentStep == 4){
      //   Navigator.push(context, MaterialPageRoute(builder: (context) => Formulas()));
      //   print(currentStep);
      // }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectOperator = 1;
    setState(() {
     _listaController.text = "1";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
                child: Stepper(
              steps: [
                Step(
                    title: Text('QUANTATOMOS'.tr),
                    isActive: true,
                    state: StepState.complete,
                    content: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: TextField(
                            controller: _atomosMinController,
//              controller: c,
                            decoration: InputDecoration(
                              labelText: "MINIMO".tr,
                              labelStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(),
                              //prefixText: ,
                            ),
                            style: TextStyle(color: Colors.black, fontSize: 15.0),
                            //onChanged: f,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: TextField(
                            controller: _atomosMaxController,
//              controller: c,
                            decoration: InputDecoration(
                              labelText: "MAXIMO".tr,
                              labelStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(),
                              //prefixText: ,
                            ),
                            style: TextStyle(color: Colors.black, fontSize: 15.0),
                            //onChanged: f,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Center(
                            child: Text("OU".tr),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: TextField(
                            controller: _atomosQuantidadeController,
//              controller: c,
                            decoration: InputDecoration(
                              labelText: "QUANT".tr,
                              labelStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(),
                              //prefixText: ,
                            ),
                            style: TextStyle(color: Colors.black, fontSize: 15.0),
                            //onChanged: f,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    )),
                Step(
                  isActive: false,
                  state: StepState.editing,
                  title: Text("QUANTFBF".tr),
                  content: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: TextField(
                          controller: _quantidadeFbfsController,
//              controller: c,
                          decoration: InputDecoration(
                            labelText: "QUANT".tr,
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(),
                            //prefixText: ,
                          ),
                          style: TextStyle(color: Colors.black, fontSize: 15.0),
                          //onChanged: f,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ),
                Step(
                  isActive: false,
                  state: StepState.editing,
                  title: Text("SELECTOPERATOR".tr),
                  content: Column(
                    children: [
                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: 1,
                                groupValue: selectOperator,
                                activeColor: Color.fromRGBO(54, 205, 224, 1.0),
                                onChanged: (val){
                                  setSelectOperator(val);
                                  print("Exatamente $val");
                                },
                              ),
                              Text("EXATO".tr)
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 2,
                                groupValue: selectOperator,
                                activeColor: Color.fromRGBO(54, 205, 224, 1.0),
                                onChanged: (val){
                                  setSelectOperator(val);
                                  print("pelo menos $val");
                                },
                              ),
                              Text("PELOMENOS".tr)
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text("<->", style: TextStyle(fontWeight: FontWeight.bold),),
                                  Checkbox(
                                      activeColor: Color.fromRGBO(54, 205, 224, 1.0),
                                      value: _byImplyVal,
                                      onChanged: (bool value){
                                        setState(() {
                                          _byImplyVal = value;
                                        });
                                      }
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text("->", style: TextStyle(fontWeight: FontWeight.bold),),
                                  Checkbox(
                                      activeColor: Color.fromRGBO(54, 205, 224, 1.0),
                                      value: _implyVal,
                                      onChanged: (bool value){
                                        setState(() {
                                          _implyVal = value;
                                        });
                                      }
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text("v", style: TextStyle(fontWeight: FontWeight.bold),),
                                  Checkbox(
                                      activeColor: Color.fromRGBO(54, 205, 224, 1.0),
                                      value: _orVal,
                                      onChanged: (bool value){
                                        setState(() {
                                          _orVal = value;
                                        });
                                      }
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text("^", style: TextStyle(fontWeight: FontWeight.bold),),
                                  Checkbox(
                                      activeColor: Color.fromRGBO(54, 205, 224, 1.0),
                                      value: _andVal,
                                      onChanged: (bool value){
                                        setState(() {
                                          _andVal = value;
                                        });
                                      }
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text("~", style: TextStyle(fontWeight: FontWeight.bold),),
                                  Checkbox(
                                      activeColor: Color.fromRGBO(54, 205, 224, 1.0),
                                      value: _notVal,
                                      onChanged: (bool value){
                                        setState(() {
                                          _notVal = value;
                                        });
                                      }
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  )
                ),
                Step(
                  isActive: false,
                  state: StepState.editing,
                  title: Text("LISTA".tr),
                  content: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: TextField(
                          controller: _listaController,
//              controller: c,
                          decoration: InputDecoration(
                            labelText: "QUANT".tr,
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(),
                            //prefixText: ,
                          ),
                          style: TextStyle(color: Colors.black, fontSize: 15.0),
                          //onChanged: f,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}){
                return Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      RaisedButton.icon(
                        icon: Icon(Icons.navigate_next),
                        onPressed: next,
                        label: Text("$textContinue"),
                        color: Color.fromRGBO(54, 205, 224, 1.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: FlatButton.icon(
                          icon: Icon(Icons.delete_forever),
                          label: Text("CANCELAR".tr),
                          onPressed: cancel,
                        ),
                      )
                    ],
                  ),
                );
              } ,
              currentStep: currentStep,
  //            onStepContinue: next,
              onStepTapped: (step) => goTo(step),
//              onStepCancel: cancel,
            ))
          ],
        ));
  }

}
