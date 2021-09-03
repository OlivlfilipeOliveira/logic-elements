import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Informacoes extends StatefulWidget {
  @override
  _InformacoesState createState() => _InformacoesState();
}

class _InformacoesState extends State<Informacoes> {
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                    child:Text("universidade".tr,
                      style: TextStyle(color: Color.fromRGBO(54, 205, 224, 1.0),
                          fontSize: 20.0), textAlign: TextAlign.center,),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 10.0),
                      child:Text("campus".tr,
                        style: TextStyle(color: Color.fromRGBO(54, 205, 224, 1.0), fontStyle: FontStyle.italic,
                            fontSize: 16.0), textAlign: TextAlign.center, )
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 10.0),
                      child:Text("cidade".tr,
                        style: TextStyle(color: Color.fromRGBO(54, 205, 224, 1.0),
                            fontSize: 16.0), textAlign: TextAlign.center, )
                  ),
                ],
              ),
              SingleChildScrollView(scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('bolsista'.tr, style: TextStyle(color: Colors.black, fontSize: 18.0), textAlign: TextAlign.start,),
                        Text("Filipe da Silva Oliveira", style: TextStyle(color: Colors.black, fontSize: 16.0), textAlign: TextAlign.start,),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text('coordenador'.tr, style: TextStyle(color: Colors.black, fontSize: 18.0), textAlign: TextAlign.start,),
                        Text("Prof.Dr. Elthon Allex da Silva Oliveira", style: TextStyle(color: Colors.black, fontSize: 16.0), textAlign: TextAlign.start,),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text('resumo'.tr, style: TextStyle(color: Colors.black, fontSize: 18.0), textAlign: TextAlign.start,),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text('textResumo'.tr,
                  style: TextStyle(color: Colors.cyan[800], fontSize: 16.0), textAlign: TextAlign.justify,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

