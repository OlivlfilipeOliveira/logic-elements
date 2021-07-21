import 'package:flutter/material.dart';
import 'package:logic_elements_pibic/translations/app_translations.dart';
import 'package:logic_elements_pibic/ui/drawer.dart';
import 'package:logic_elements_pibic/ui/home.dart';
import 'package:get/get.dart';
import 'package:devicelocale/devicelocale.dart';

// void main(){
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: Home(),
//     theme: ThemeData(
//         accentColor: Colors.white,
//         hintColor: Color.fromRGBO(54, 205, 224, 1.0),
//         primaryColor: Color.fromRGBO(54, 205, 224, 1.0),
//         inputDecorationTheme: InputDecorationTheme(
//   //      enabledBorder:
//     //      OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
//           focusedBorder:
//          OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
//          /// hintStyle: TextStyle(color: Colors.white),
//           )
//     ),
//   ));
// }

void main() async{
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    translationsKeys: AppTranslation.translations,
    home: Home(),
    theme: ThemeData(
        accentColor: Colors.white,
        hintColor: Color.fromRGBO(54, 205, 224, 1.0),
        primaryColor: Color.fromRGBO(54, 205, 224, 1.0),
        inputDecorationTheme: InputDecorationTheme(
          //      enabledBorder:
          //      OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          /// hintStyle: TextStyle(color: Colors.white),
        )
    ),
  ));
  String locale = await Devicelocale.currentLocale;
  List<String> idioma = [];
  idioma = locale.split("_");
  Get.updateLocale(Locale(idioma[0], idioma[1]));
  print(idioma);
}

