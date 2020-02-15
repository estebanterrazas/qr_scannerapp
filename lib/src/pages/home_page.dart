import 'package:flutter/material.dart';
import 'package:qr_scannerapp/src/pages/direcciones_pages.dart';
import 'package:qr_scannerapp/src/pages/mapas_pages.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.delete_forever), onPressed: (){})
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: (){},
        backgroundColor: Theme.of(context).primaryColor,
        ),

    );
  }

  Widget _callPage( int paginaActual ){

    switch(paginaActual){

      case 0: return MapasPage();
      case 1: return DireccionesPage();

      default : 
          return MapasPage();

    }

  }

  Widget _crearBottomNavigationBar() {
    return BottomNavigationBar(
      
      currentIndex: currentIndex,
      onTap: (index){
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon( Icons.map  ),
          title: Text('Maps')
          ),
          BottomNavigationBarItem(
          icon: Icon( Icons.brightness_5  ),
          title: Text('Addresses')
          )
      ],
      
      );
  }
}