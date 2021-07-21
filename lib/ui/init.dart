import 'package:flutter/material.dart';
import 'package:logic_elements_pibic/ui/hist%C3%B3rico.dart';
import 'package:logic_elements_pibic/ui/informa%C3%A7oes.dart';
import 'package:logic_elements_pibic/ui/principal.dart';

class Inicial extends StatefulWidget {
  @override
  _InicialState createState() => _InicialState();
}


class _InicialState extends State<Inicial> {

  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    Principal(),
    Historico(),
    Informacoes(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

    });
  }
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Principal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Histórico',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Informações',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromRGBO(54, 205, 224, 1.0),
        onTap: _onItemTapped,
      ),
      body: _widgetOptions.elementAt(_selectedIndex)
    );
  }
}
