import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_mac/get_mac.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logic_elements_pibic/ui/drawer.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount conta;

  Future<GoogleSignInAccount> _getUser() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        print("Não está vazio");
      }
      return googleSignInAccount;
      //return googleSignInAccount;
//      final googleSignInAuthentication = await googleSignInAccount.authentication;

      // final credential = GoogleAuthProvider.getCredential(
      //   idToken: googleSignInAuthentication.idToken,
      //   accessToken: googleSignInAuthentication.accessToken,
      // );

    } catch (error) {
      print(error);
      return null;
    }
  }
  String _platformVersion = "null";

  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await GetMac.macAddress;
    } on PlatformException {
      platformVersion = 'Failed to get Device MAC Address.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      print(_platformVersion);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(top: 60.0, left: 40.0, right: 40.0),
          color: Colors.white,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    //diminui o tamanho da imagem
                    width: 230,
                    height: 230,
                    child: Image.asset("images/LogicElements.png"),
                  ),
                  Container(
                    height: 60,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black38),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: SizedBox.expand(
                      child: FlatButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "LOGINGOOGLE".tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20),
                              textAlign: TextAlign.left,
                            ),
                            Container(
                              child: SizedBox(
                                child: Image.asset("images/google.png"),
                                height: 28,
                                width: 28,
                              ),
                            )
                          ],
                        ),
                        onPressed: () {
                          _getUser().then((c) {
                            setState(() {
                              conta = c;
                            });
                            if (conta != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DrawerPage(
                                        currentePage: 0,
                                        conta: conta,
                                        googleSignIn: googleSignIn,
                                        anonimo: false,
                                      )));
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 60,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [
                            0.3,
                            1
                          ],
                          colors: [
                            Color.fromRGBO(54, 205, 224, 1.0),
                            Color.fromRGBO(0, 107, 194, 1.0)
                          ]),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: SizedBox.expand(
                      child: FlatButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "LOGIN".tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20),
                              textAlign: TextAlign.left,
                            ),
                            Container(
                              child: SizedBox(
                                child: Icon(
                                  Icons.login,
                                  color: Colors.white,
                                ),
                                //Image.asset("images/login.jpeg"),
                                height: 28,
                                width: 28,
                              ),
                            )
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DrawerPage(
                                        currentePage: 0,
                                        anonimo: true,
                                      )));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
