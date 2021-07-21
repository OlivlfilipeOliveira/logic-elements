import 'package:flutter/material.dart';

class Principal extends StatefulWidget {
  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Color.fromRGBO(54, 205, 224, 1.0),
      //   title: Text("Olá, Filipe!"),
      //   centerTitle: true,
      //   actions: [
      //     IconButton(
      //         icon: Icon(Icons.exit_to_app),
      //         onPressed: (){
      //           Navigator.pop(context);
      //           _globalKey.currentState.showSnackBar(
      //               SnackBar(content: Text("Você saiu com sucesso!", ))
      //           );
      //         }
      //     )
      //   ],
      // ),
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
                        "Gerar Fórmulas",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  onPressed: (){},
                ),
              ),
            ),
            SizedBox(
              height: 10,
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
                        "Gerar Argumentos",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  onPressed: (){},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
