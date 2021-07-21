import 'package:flutter/material.dart';
import 'package:get/get.dart';


class RecuperarSenha extends StatefulWidget {
  @override
  _RecuperarSenhaState createState() => _RecuperarSenhaState();
}

class _RecuperarSenhaState extends State<RecuperarSenha> {

  String email = "filipeo444@gmail.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("RECUPERAR".tr, style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromRGBO(54, 205, 224, 1.0),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.only(
            top: 60.0,
            left: 40.0,
            right: 40.0
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: "EMAILCADASTRO".tr,
                  labelStyle: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 20
                  )
              ),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: "NOVASENHA".tr,
                  labelStyle: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 20
                  )
              ),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: "REPETIRSENHA".tr,
                  labelStyle: TextStyle(
                      color: Colors.black38,
                      fontWeight: FontWeight.w400,
                      fontSize: 20
                  )
              ),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.3, 1],
                    colors: [
                      Color.fromRGBO(54, 205, 224, 1.0),
                      Color.fromRGBO(0, 107, 194, 1.0)
                    ]
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(5)
                ),
              ),
              child: SizedBox.expand(
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ALTERAR".tr,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  onPressed: (){

                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Future<void> _alert(String email) async{
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Alteração de senha"),
  //         content: Text("Um e-mail foi enviado para $email com um link para alterar sua senha."),
  //         actions: [
  //           FlatButton(
  //             textColor: Color.fromRGBO(54, 205, 224, 1.0),
  //               onPressed: (){
  //                 Navigator.pop(context);
  //                 Navigator.pop(context);
  //               },
  //               child: Text("Ok")
  //           ),
  //         ],
  //       );
  //     }
  //   );
  //
  // }
}
