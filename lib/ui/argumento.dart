import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logic_elements_pibic/ui/drawer.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class Argumento extends StatefulWidget {
  @override
  _ArgumentoState createState() => _ArgumentoState();
}

class _ArgumentoState extends State<Argumento> {

  final _atomosDiferentesController = TextEditingController();
  final _quantArgumentosController = TextEditingController();
  final _listasController = TextEditingController();
  String _regrasArg;

  bool NEVal = false;
  bool NIVal = false;
  bool CIVal = false;
  bool CEVal = false;
  bool DIVal = false;
  bool DEVal = false;
  bool BIVal = false;
  bool BEVal = false;
  bool MPVal = false;
  bool MTVal = false;
  bool SDVal = false;


  int currentStep = 0;
  bool complete = false;
  String textContinue = "CONTINUAR".tr;

  // Future<List> _getArguments(String regras, String atomos, String listas) async{
  //   http.Response response;
  //
  //   response = await http.get("http://192.168.0.102:8080/api-logic/arguments/$regras/$atomos/$listas");
  //
  //   return json.decode(response.body);
  // }

  Future<List> _getInfors() async{
    String _regras = "";
    String _atomos = "";
    String _quantArguments = "";
    String _listas = "";

    if(NEVal){
      _regras += "NE,";
    }
    if(NIVal){
      _regras += "NI,";
    }
    if(CIVal){
      _regras += "CI,";
    }
    if(CEVal){
      _regras += "CE,";
    }
    if(DIVal){
      _regras = "DI,";
    }
    if(DEVal){
      _regras += "DE,";
    }
    if(BIVal){
      _regras += "BI,";
    }
    if(BEVal){
      _regras += "BE,";
    }
    if(MPVal){
      _regras += "MP,";
    }
    if(MTVal){
      _regras += "MT,";
    }
    if(SDVal){
      _regras += "SD,";
    }

    _regrasArg = _regras;
    _atomos = _atomosDiferentesController.text;
    _listas = _listasController.text;
    _quantArguments = _quantArgumentosController.text;

    http.Response response;

    response = await http.get("http://10.0.0.101:8080/api-logic/arguments/$_regras/$_atomos/$_quantArguments/$_listas");

    return json.decode(response.body);

  }


  next() {
    if(currentStep + 1 != 4){
      goTo(currentStep + 1);
      if(currentStep == 3){
        setState(() {
          textContinue = "CONCLUIR".tr;
        });
      }
    }else{
      complete = true;
      List<dynamic> arguments = [];
      _getInfors().then((args){
        arguments = args;
        Navigator.push(context, MaterialPageRoute(builder: (context) => DrawerPage(currentePage: 7, arguments: arguments, regras: _regrasArg, atomos: _atomosDiferentesController.text, argumentos: _quantArgumentosController.text, listas: _listasController.text,)));
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

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listasController.text = "1";
    setState(() {
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
                          isActive: true,
                          state: StepState.complete,
                          title: Text("SELECTREGRAS".tr),
                          content: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text("NE", style: TextStyle(fontWeight: FontWeight.bold),),
                                          Checkbox(
                                              activeColor: Color.fromRGBO(54, 205, 224, 1.0),
                                              value: NEVal,
                                              onChanged: (bool value){
                                                setState(() {
                                                  NEVal = value;
                                                });
                                              }
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text("NI", style: TextStyle(fontWeight: FontWeight.bold),),
                                          Checkbox(
                                              activeColor: Color.fromRGBO(54, 205, 224, 1.0),
                                              value: NIVal,
                                              onChanged: (bool value){
                                                setState(() {
                                                  NIVal = value;
                                                });
                                              }
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text("CI", style: TextStyle(fontWeight: FontWeight.bold),),
                                          Checkbox(
                                              activeColor: Color.fromRGBO(54, 205, 224, 1.0),
                                              value: CIVal,
                                              onChanged: (bool value){
                                                setState(() {
                                                  CIVal = value;
                                                });
                                              }
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text("CE", style: TextStyle(fontWeight: FontWeight.bold),),
                                          Checkbox(
                                              activeColor: Color.fromRGBO(54, 205, 224, 1.0),
                                              value: CEVal,
                                              onChanged: (bool value){
                                                setState(() {
                                                  CEVal = value;
                                                });
                                              }
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text("DI", style: TextStyle(fontWeight: FontWeight.bold),),
                                          Checkbox(
                                              activeColor: Color.fromRGBO(54, 205, 224, 1.0),
                                              value: DIVal,
                                              onChanged: (bool value){
                                                setState(() {
                                                  DIVal = value;
                                                });
                                              }
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Text("DE", style: TextStyle(fontWeight: FontWeight.bold),),
                                          Checkbox(
                                              activeColor: Color.fromRGBO(54, 205, 224, 1.0),
                                              value: DEVal,
                                              onChanged: (bool value){
                                                setState(() {
                                                  DEVal = value;
                                                });
                                              }
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text("BI", style: TextStyle(fontWeight: FontWeight.bold),),
                                          Checkbox(
                                              activeColor: Color.fromRGBO(54, 205, 224, 1.0),
                                              value: BIVal,
                                              onChanged: (bool value){
                                                setState(() {
                                                  BIVal = value;
                                                });
                                              }
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text("BE", style: TextStyle(fontWeight: FontWeight.bold),),
                                          Checkbox(
                                              activeColor: Color.fromRGBO(54, 205, 224, 1.0),
                                              value: BEVal,
                                              onChanged: (bool value){
                                                setState(() {
                                                  BEVal = value;
                                                });
                                              }
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text("MP", style: TextStyle(fontWeight: FontWeight.bold),),
                                          Checkbox(
                                              activeColor: Color.fromRGBO(54, 205, 224, 1.0),
                                              value: MPVal,
                                              onChanged: (bool value){
                                                setState(() {
                                                  MPVal = value;
                                                });
                                              }
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text("MT", style: TextStyle(fontWeight: FontWeight.bold),),
                                          Checkbox(
                                              activeColor: Color.fromRGBO(54, 205, 224, 1.0),
                                              value: MTVal,
                                              onChanged: (bool value){
                                                setState(() {
                                                  MTVal = value;
                                                });
                                              }
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text("SD", style: TextStyle(fontWeight: FontWeight.bold),),
                                          Checkbox(
                                              activeColor: Color.fromRGBO(54, 205, 224, 1.0),
                                              value: SDVal,
                                              onChanged: (bool value){
                                                setState(() {
                                                  SDVal = value;
                                                });
                                              }
                                          )
                                        ],
                                      ),
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
                        title: Text("ATOMOSDIF".tr),
                        content: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                              child: TextField(
//              controller: c,
                              controller: _atomosDiferentesController,
                                decoration: InputDecoration(
                                  labelText: "ATOMOS".tr,
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
                        title: Text("QUANTARG".tr),
                        content: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                              child: TextField(
//              controller: c,
                                controller: _quantArgumentosController,
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
                        title: Text("LISTA".tr),
                        content: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                              child: TextField(
//              controller: c,
                              controller: _listasController,
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
                    },
                    currentStep: currentStep,
//                    onStepContinue: next,
                    onStepTapped: (step) => goTo(step),
  //                  onStepCancel: cancel
                ))
          ],
        ));
  }

}
