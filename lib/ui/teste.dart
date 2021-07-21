
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logic_elements_pibic/ui/cadastrar.dart';
import 'package:logic_elements_pibic/ui/drawer.dart';
import 'package:logic_elements_pibic/ui/recuperar_senha.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {


  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount  conta;

  Future<GoogleSignInAccount> _getUser() async{

    try{
      final GoogleSignInAccount  googleSignInAccount = await googleSignIn.signIn();

      if(googleSignInAccount!=null){
        print("Não está vazio");
      }
      return googleSignInAccount;
      //return googleSignInAccount;
//      final googleSignInAuthentication = await googleSignInAccount.authentication;

      // final credential = GoogleAuthProvider.getCredential(
      //   idToken: googleSignInAuthentication.idToken,
      //   accessToken: googleSignInAuthentication.accessToken,
      // );

    }catch(error){
      print(error);
      return null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(
              top: 60.0,
              left: 40.0,
              right: 40.0
          ),
          color: Colors.white,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView(
                    children: [
                      SizedBox(//diminui o tamanho da imagem
                        width: 128,
                        height: 128,
                        child: Image.asset("images/LogicElements.png"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // TextFormField(
                      //   keyboardType: TextInputType.emailAddress,
                      //   decoration: InputDecoration(
                      //     labelText: "EMAIL".tr,
                      //     labelStyle: TextStyle(
                      //       color: Colors.black38,
                      //       fontWeight: FontWeight.w400,
                      //       fontSize: 20
                      //     )
                      //   ),
                      //   style: TextStyle(fontSize: 20),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // TextFormField(
                      //   obscureText: true,
                      //   keyboardType: TextInputType.text,
                      //   decoration: InputDecoration(
                      //       labelText: "SENHA".tr,
                      //       labelStyle: TextStyle(
                      //           color: Colors.black38,
                      //           fontWeight: FontWeight.w400,
                      //           fontSize: 20
                      //       )
                      //   ),
                      //   style: TextStyle(fontSize: 20),
                      // ),

                      // SizedBox(
                      //   height: 30,
                      // ),
                      // Container(
                      //   height: 60,
                      //   alignment: Alignment.centerLeft,
                      //   decoration: BoxDecoration(
                      //     gradient: LinearGradient(
                      //       begin: Alignment.topLeft,
                      //       end: Alignment.bottomRight,
                      //       stops: [0.3, 1],
                      //       colors: [
                      //         Color.fromRGBO(54, 205, 224, 1.0),
                      //         Color.fromRGBO(0, 107, 194, 1.0)
                      //       ]
                      //     ),
                      //     borderRadius: BorderRadius.all(
                      //         Radius.circular(5)
                      //     ),
                      //   ),
                      //   child: SizedBox.expand(
                      //     child: FlatButton(
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Text(
                      //             "LOGIN".tr,
                      //             style: TextStyle(
                      //               fontWeight: FontWeight.bold,
                      //               color: Colors.white,
                      //               fontSize: 20
                      //             ),
                      //             textAlign: TextAlign.left,
                      //           ),
                      //           Container(
                      //             child: SizedBox(
                      //               child: Icon(Icons.login, color: Colors.white,),//Image.asset("images/login.jpeg"),
                      //               height: 28,
                      //               width: 28,
                      //             ),
                      //           )
                      //         ],
                      //       ),
                      //       onPressed: (){
                      //         Navigator.push(context, MaterialPageRoute(builder: (context) => DrawerPage(currentePage: 0, )));
                      //       },
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      // Container(
                      //   height: 40,
                      //   alignment: Alignment.centerRight,
                      //   child: FlatButton(
                      //     child: Text(
                      //       "RECUPERAR".tr,
                      //       textAlign: TextAlign.right,
                      //     ),
                      //     onPressed: (){
                      //       Navigator.push(context, MaterialPageRoute(builder: (context) => RecuperarSenha()));
                      //     },
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      // Container(
                      //   height: 60,
                      //   alignment: Alignment.centerLeft,
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     border: Border.all(color: Colors.black38),
                      //     borderRadius: BorderRadius.all(
                      //         Radius.circular(5)
                      //     ),
                      //   ),
                      //   child: SizedBox.expand(
                      //     child: FlatButton(
                      //       child: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Text(
                      //             "LOGINGOOGLE".tr,
                      //             style: TextStyle(
                      //                 fontWeight: FontWeight.bold,
                      //                 color: Colors.black,
                      //                 fontSize: 20
                      //             ),
                      //             textAlign: TextAlign.left,
                      //           ),
                      //           Container(
                      //             child: SizedBox(
                      //               child: Image.asset("images/google.png"),
                      //               height: 28,
                      //               width: 28,
                      //             ),
                      //           )
                      //         ],
                      //       ),
                      //       onPressed: (){
                      //         _getUser().then((c){
                      //           setState(() {
                      //             conta = c;
                      //           });
                      //           if(conta==null){
                      //             print("ta vazio");
                      //           }
                      //           Navigator.push(context, MaterialPageRoute(builder: (context) => DrawerPage(currentePage: 0, conta: conta, googleSignIn: googleSignIn,)));
                      //         });
                      //       },
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Container(
                      //   height: 40,
                      //    child: FlatButton(
                      //      child: Text(
                      //        "CADASTRAR".tr,
                      //        textAlign: TextAlign.center,
                      //      ),
                      //      onPressed: (){
                      //        Navigator.push(context, MaterialPageRoute(builder: (context) => Cadastrar()));
                      //      },
                      //    ),
                      // )
                    ],
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}
