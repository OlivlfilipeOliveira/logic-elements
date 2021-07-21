import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logic_elements_pibic/util/Util.dart';

class Configuracoes extends StatefulWidget {
  @override
  _ConfiguracoesState createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  List<bool> isSelected = [false, false];

  List _idiomas = [];
  Util util = Util();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    util.readData().then((data) {
      _idiomas = json.decode(data);
      if(_idiomas.length>0){
  //      List<String> idioma = [];
        print(_idiomas[0]['idioma']);
        //idioma = _idiomas[0]['idioma'].split("_");
        setState(() {
//          print(idioma[0]);
          if(_idiomas[0]['idioma']=='en_US'){
            isSelected[1] = true;
          }else if(_idiomas[0]['idioma']=='pt_BR'){
            isSelected[0] = true;
          }
          print(isSelected[0]);
          print(isSelected[1]);
        });
      }
    });

    print("Olpa, mundo");
    print(isSelected[0]);
    print(isSelected[1]);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(top: 30.0),
        child: ListView(

          children: [
            Center(
                child: Column(
                  children: [
                   Text("Selecione um idioma", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                   Divider(),
                     ToggleButtons(
                      children: <Widget>[
                        Container(
                          width: 120.0,
                          height: 50.0,
                          alignment: Alignment.center,
                          child: Text("Português", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.black),),
                        ),
                        Container(
                          width: 120.0,
                          height: 50.0,
                          alignment: Alignment.center,
                          child: Text("Inglês", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.black),),
                        ),
                      ],
                      isSelected: isSelected,
                      onPressed: (int index) {
                        setState(() {
                          if(index==0){
                            if(isSelected[0]){
                              isSelected[0] = false;
                              isSelected[1] = true;
                            }else{
                              isSelected[0] = true;
                              isSelected[1] = false;
                            }
                          }else {
                            if (isSelected[1]) {
                              isSelected[1] = false;
                              isSelected[0] = true;
                            } else {
                              isSelected[0] = false;
                              isSelected[1] = true;
                            }
                          }

                        });

                        if(isSelected[0]){
                          Get.updateLocale(Locale('pt', 'BR'));
                          Map<String, dynamic> newIdioma = Map();
                          newIdioma['idioma'] = 'pt_BR';
                          if(_idiomas.length > 0){
                            _idiomas.removeAt(0);
                            _idiomas.add(newIdioma);
                          }else{
                            _idiomas.add(newIdioma);
                          }
                          util.saveData(_idiomas);
                        }else if(isSelected[1]){
                          Get.updateLocale(Locale('en', 'US'));
                          Map<String, dynamic> newIdioma = Map();
                          newIdioma['idioma'] = 'en_US';
                          if(_idiomas.length > 0){
                            _idiomas.removeAt(0);
                            _idiomas.add(newIdioma);
                          }else{
                            _idiomas.add(newIdioma);
                          }
                          util.saveData(_idiomas);
                        }
                      },
                      fillColor: Color.fromRGBO(54, 205, 224, 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                  ],
                )

            ),
          ],
        ),
      )
    );
  }
}
