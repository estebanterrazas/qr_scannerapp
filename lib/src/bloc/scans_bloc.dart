import 'dart:async';
import 'package:qr_scannerapp/src/bloc/validator.dart';
import 'package:qr_scannerapp/src/providers/db_provider.dart';

import 'package:qr_scannerapp/src/models/scan_model.dart';


class ScansBloc extends Validators {

  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc(){
    return _singleton;
  }
  
  ScansBloc._internal(){

    obtenerScan();

  }


  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scansController.stream.transform(validarGeo);
  Stream<List<ScanModel>> get scansStreamHttp => _scansController.stream.transform(validarHttp);

  dispose(){
    _scansController?.close();
  }


 
  obtenerScan() async{
    _scansController.sink.add( await DBProvider.db.getTodosScan() );
  }

 agregarScan(ScanModel scan) async{
    await DBProvider.db.nuevoScan(scan);
    obtenerScan();
  }
  borrarScan(int id) async{
    await DBProvider.db.deleteScan(id);
    obtenerScan();
  }

  borrarScansTodos() async{

    await DBProvider.db.deleteAll();
    obtenerScan();

  }

}