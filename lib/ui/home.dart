import 'dart:convert';

import 'package:devicelocale/devicelocale.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logic_elements_pibic/ui/login.dart';
import 'package:logic_elements_pibic/util/Util.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}



class _HomeState extends State<Home> {
  List _idiomas = [];
  Util util = Util();

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    //util.saveData(_idiomas);
    util.readData().then((data) async{
      _idiomas = json.decode(data);
      if(_idiomas.length>0){
        List<String> idioma = [];
        print(_idiomas[0]['idioma']);
        idioma = _idiomas[0]['idioma'].split("_");
        Get.updateLocale(Locale(idioma[0], idioma[1]));
      }else{
        String locale = await Devicelocale.currentLocale;
        Map<String, dynamic> newIdioma = Map();
        List<String> idioma = locale.split('_');
        Get.updateLocale(Locale(idioma[0], idioma[1]));

        newIdioma['idioma'] = locale;
        _idiomas.add(newIdioma);
        util.saveData(_idiomas);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward, color: Colors.white),
        backgroundColor: Color.fromRGBO(0, 107, 194, 1.0),
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Login()));
        },
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
              child: Center(
                child: Image.asset("images/LogicElements.png"),
              ),
          ),
        ],
      )
    );
  }
}
