import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_scannerapp/src/bloc/scans_bloc.dart';
import 'package:qr_scannerapp/src/models/scan_model.dart';
import 'package:qr_scannerapp/src/pages/direcciones_pages.dart';
import 'package:qr_scannerapp/src/pages/mapas_pages.dart';
import 'package:qr_scannerapp/src/utils/utils.dart' as utils;
import 'package:barcode_scan/barcode_scan.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final scansBloc = new ScansBloc();

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.delete_forever), 
          onPressed: scansBloc.borrarScansTodos,)
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed:() => _qrScan(context),
        backgroundColor: Theme.of(context).primaryColor,
        ),

    );
  }
  _qrScan(BuildContext context) async {


    // https://hablemosdeecommerce.com
    // geo:40.677382360119466,-73.9716090246094
    //  String futureString = '';
     String futureString;
    
    try {
      futureString = await BarcodeScanner.scan();
    } catch (e) {
      futureString = e.toString();
    }

   


    if ( futureString != null ) {

      final scan = ScanModel(valor: futureString);
      scansBloc.agregarScan(scan);


      if ( Platform.isIOS ) {

        Future.delayed(Duration(milliseconds: 750),(){
          utils.abrirScan(context, scan);
        } );
        
      }else{
          utils.abrirScan(context, scan);
      }
      
    }

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