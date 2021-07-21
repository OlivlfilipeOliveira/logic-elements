import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'drawer.dart';

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.only(top: 150, left: 20.0, right: 20.0),
          color: Colors.white,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 5.0, left: 15.0, right: 15.0),
                child: Container(
                  height: 120,
                  width: 180,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 107, 194, 1.0),
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: SizedBox.expand(
                    child: FlatButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "FORMULA".tr,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DrawerPage(
                                      currentePage: 1,
                                    )));
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5.0, top: 5.0, left: 15.0, right: 15.0),
                child: Container(
                  height: 120,
                  width: 180,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(54, 205, 224, 1.0),
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: SizedBox.expand(
                    child: FlatButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "ARGUMENTO".tr,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DrawerPage(currentePage: 2)));
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0, left: 15.0, right: 15.0),
                child: Container(
                  height: 120,
                  width: 180,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(250, 235, 30, 1.0),
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: SizedBox.expand(
                    child: FlatButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "SINTESESALVA".tr,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DrawerPage(
                                  currentePage: 3,
                                )));
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
