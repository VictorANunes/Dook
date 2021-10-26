import 'package:dook/models/exemplar_models.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

class EditarFotosScreen extends StatefulWidget {
  var exemplar;
  EditarFotosScreen({this.exemplar});
  @override
  EditarFotos createState() => EditarFotos(exemplar: exemplar);
}

File _imageCapa = null;
File _imageContracapa = null;
File _imageLombada = null;
File _imageCorteSuperior = null;
File _imageCorteDianteiro = null;
File _imageCorteInferior = null;

var capa;
var contracapa;
var lombada;
var cortedianteiro;
var corteinferior;
var cortesuperior;

class EditarFotos extends State {
  var exemplar;
  EditarFotos({this.exemplar});
  bool carregando = false;
  FirestoreService firestore = FirestoreService();
  Widget carregandoButton() {
    if (carregando) {
      return CircularProgressIndicator(
        backgroundColor: Colors.deepPurple[600],
        valueColor: AlwaysStoppedAnimation(Colors.white),
      );
    } else {
      return Text(
        'Salvar',
        style: TextStyle(fontSize: 18.sp),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 30.r,
          left: 25.r,
          right: 25.r,
        ),
        child: ListView(
          children: <Widget>[
            Superior(),
            SizedBox(
              height: 35.h,
            ),
            Text(
              '* Corte: parte visível das páginas quando o livro está fechado.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.sp),
            ),
            SizedBox(
              height: 20.h,
            ),
            Fotos(exemplar: exemplar),
            SizedBox(
              height: 30.h,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple[600],
                  minimumSize: Size(382.h, 55.h),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
                onPressed: () async {
                  setState(() {
                    carregando = true;
                  });

                  String fileName;
                  UploadTask uploadTask;
                  var capaUrl = null;
                  var contracapaUrl = null;
                  var lombadaUrl = null;
                  var corteDianteiroUrl = null;
                  var corteInferiorUrl = null;
                  var corteSuperiorUrl = null;

                  if (_imageCapa != null) {
                    fileName = basename(_imageCapa.path);
                    uploadTask = FirebaseStorage.instance
                        .ref()
                        .child(fileName)
                        .putFile(_imageCapa);

                    capaUrl = await (await uploadTask).ref.getDownloadURL();
                  } else {
                    capaUrl = capa;
                  }

                  if (_imageContracapa != null) {
                    fileName = basename(_imageContracapa.path);
                    uploadTask = FirebaseStorage.instance
                        .ref()
                        .child(fileName)
                        .putFile(_imageContracapa);
                    contracapaUrl =
                        await (await uploadTask).ref.getDownloadURL();
                  } else {
                    contracapaUrl = contracapa;
                  }

                  if (_imageLombada != null) {
                    fileName = basename(_imageLombada.path);
                    uploadTask = FirebaseStorage.instance
                        .ref()
                        .child(fileName)
                        .putFile(_imageLombada);
                    lombadaUrl = await (await uploadTask).ref.getDownloadURL();
                  } else {
                    lombadaUrl = lombada;
                  }

                  if (_imageCorteDianteiro != null) {
                    fileName = basename(_imageCorteDianteiro.path);
                    uploadTask = FirebaseStorage.instance
                        .ref()
                        .child(fileName)
                        .putFile(_imageCorteDianteiro);
                    corteDianteiroUrl =
                        await (await uploadTask).ref.getDownloadURL();
                  } else {
                    corteDianteiroUrl = cortedianteiro;
                  }

                  if (_imageCorteInferior != null) {
                    fileName = basename(_imageCorteInferior.path);
                    uploadTask = FirebaseStorage.instance
                        .ref()
                        .child(fileName)
                        .putFile(_imageCorteInferior);
                    corteInferiorUrl =
                        await (await uploadTask).ref.getDownloadURL();
                  } else {
                    corteInferiorUrl = corteinferior;
                  }

                  if (_imageCorteSuperior != null) {
                    fileName = basename(_imageCorteSuperior.path);
                    uploadTask = FirebaseStorage.instance
                        .ref()
                        .child(fileName)
                        .putFile(_imageCorteSuperior);
                    corteSuperiorUrl =
                        await (await uploadTask).ref.getDownloadURL();
                  } else {
                    corteSuperiorUrl = cortesuperior;
                  }

                  firestore.updateFotos(
                      exemplar,
                      capaUrl,
                      contracapaUrl,
                      lombadaUrl,
                      corteSuperiorUrl,
                      corteDianteiroUrl,
                      corteInferiorUrl);

                  Navigator.pop(context);
                },
                child: carregandoButton()),
            SizedBox(
              height: 30.h,
            ),
          ],
        ),
      ),
    );
  }
}

class Superior extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            'assets/images/icons/voltar.png',
            height: 25.h,
            width: 25.w,
          ),
          alignment: Alignment.centerLeft,
        ),
        Center(
          child: Text(
            'Fotos',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 33.sp,
            ),
          ),
        ),
        Container(
          width: 45.w,
        )
      ],
    );
  }
}

class Fotos extends StatefulWidget {
  var exemplar;
  Fotos({this.exemplar});
  @override
  FotosState createState() => FotosState(exemplar: exemplar);
}

class FotosState extends State<Fotos> {
  var exemplar;
  FotosState({this.exemplar});

  final ImagePicker imagePicker = ImagePicker();
  Future getImageGallery(String img) async {
    var image = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (img == "Capa") {
        _imageCapa = File(image.path);
      }
      if (img == "Contracapa") {
        _imageContracapa = File(image.path);
      }
      if (img == "Lombada") {
        _imageLombada = File(image.path);
      }
      if (img == "Corte Superior") {
        _imageCorteSuperior = File(image.path);
      }
      if (img == "Corte Dianteiro") {
        _imageCorteDianteiro = File(image.path);
      }
      if (img == "Corte Inferior") {
        _imageCorteInferior = File(image.path);
      }
    });
  }

  Future getImageCamera(String img) async {
    var image = await imagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      if (img == "Capa") {
        _imageCapa = File(image.path);
      }
      if (img == "Contracapa") {
        _imageContracapa = File(image.path);
      }
      if (img == "Lombada") {
        _imageLombada = File(image.path);
      }
      if (img == "Corte Superior") {
        _imageCorteSuperior = File(image.path);
      }
      if (img == "Corte Dianteiro") {
        _imageCorteDianteiro = File(image.path);
      }
      if (img == "Corte Inferior") {
        _imageCorteInferior = File(image.path);
      }
    });
  }

  void mostrarOpcaoFoto(context, img) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Galeria'),
                      onTap: () {
                        getImageGallery(img);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      getImageCamera(img);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    FirestoreService firestore = FirestoreService();

    return StreamBuilder(
      stream: firestore.getExemplar(exemplar),
      builder: (BuildContext context, AsyncSnapshot<Exemplar> exemplar2) {
        if (exemplar2.hasData) {
          capa = exemplar2.data.capa;
          contracapa = exemplar2.data.contracapa;
          lombada = exemplar2.data.lombada;
          cortedianteiro = exemplar2.data.corteDianteiro;
          corteinferior = exemplar2.data.corteInferior;
          cortesuperior = exemplar2.data.corteSuperior;

          return Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'Capa',
                      style: TextStyle(
                          fontSize: 25.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    width: 220.w,
                    height: 220.h,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.5),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Colors.grey[600],
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(2.r),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.white,
                          image: DecorationImage(
                            fit: BoxFit.scaleDown,
                            image: (_imageCapa != null)
                                ? FileImage(_imageCapa)
                                : NetworkImage(exemplar2.data.capa),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextButton(
                    child: Text(
                      'Adicionar Foto',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17.sp,
                        color: Colors.deepPurple[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: () {
                      mostrarOpcaoFoto(context, 'Capa');
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'Contracapa',
                      style: TextStyle(
                          fontSize: 25.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    width: 220.w,
                    height: 220.h,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.5),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Colors.grey[600],
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(2.r),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.white,
                          image: DecorationImage(
                            fit: BoxFit.scaleDown,
                            image: (_imageContracapa != null)
                                ? FileImage(_imageContracapa)
                                : NetworkImage(exemplar2.data.contracapa),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextButton(
                    child: Text(
                      'Adicionar Foto',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17.sp,
                        color: Colors.deepPurple[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: () {
                      mostrarOpcaoFoto(context, 'Contracapa');
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'Lombada',
                      style: TextStyle(
                          fontSize: 25.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    width: 220.w,
                    height: 220.h,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.5),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Colors.grey[600],
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(2.r),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.white,
                          image: DecorationImage(
                            fit: BoxFit.scaleDown,
                            image: (_imageLombada != null)
                                ? FileImage(_imageLombada)
                                : NetworkImage(exemplar2.data.lombada),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextButton(
                    child: Text(
                      'Adicionar Foto',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17.sp,
                        color: Colors.deepPurple[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: () {
                      mostrarOpcaoFoto(context, 'Lombada');
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'Corte Superior',
                      style: TextStyle(
                          fontSize: 25.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    width: 220.w,
                    height: 220.h,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.5),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Colors.grey[600],
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(2.r),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.white,
                          image: DecorationImage(
                            fit: BoxFit.scaleDown,
                            image: (_imageCorteSuperior != null)
                                ? FileImage(_imageCorteSuperior)
                                : NetworkImage(exemplar2.data.corteSuperior),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextButton(
                    child: Text(
                      'Adicionar Foto',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17.sp,
                        color: Colors.deepPurple[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: () {
                      mostrarOpcaoFoto(context, 'Corte Superior');
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'Corte Dianteiro',
                      style: TextStyle(
                          fontSize: 25.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    width: 220.w,
                    height: 220.h,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.5),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Colors.grey[600],
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(2.r),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.white,
                          image: DecorationImage(
                            fit: BoxFit.scaleDown,
                            image: (_imageCorteDianteiro != null)
                                ? FileImage(_imageCorteDianteiro)
                                : NetworkImage(exemplar2.data.corteDianteiro),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextButton(
                    child: Text(
                      'Adicionar Foto',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17.sp,
                        color: Colors.deepPurple[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: () {
                      mostrarOpcaoFoto(context, 'Corte Dianteiro');
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      'Corte Inferior',
                      style: TextStyle(
                          fontSize: 25.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    width: 220.w,
                    height: 220.h,
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.5),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Colors.grey[600],
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(2.r),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.white,
                          image: DecorationImage(
                            fit: BoxFit.scaleDown,
                            image: (_imageCorteInferior != null)
                                ? FileImage(_imageCorteInferior)
                                : NetworkImage(exemplar2.data.corteInferior),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextButton(
                    child: Text(
                      'Adicionar Foto',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17.sp,
                        color: Colors.deepPurple[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: () {
                      mostrarOpcaoFoto(context, 'Corte Inferior');
                    },
                  ),
                ],
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
