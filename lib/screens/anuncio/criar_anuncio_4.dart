import 'package:dook/provider/exemplar_provider.dart';
import 'package:dook/screens/menu_inferior.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';

class CriarAnuncio4Screen extends StatefulWidget {
  ExemplarProvider exemplar;
  CriarAnuncio4Screen({this.exemplar});
  @override
  CriarAnuncio4 createState() => CriarAnuncio4(exemplar: exemplar);
}

class CriarAnuncio4 extends State {
  ExemplarProvider exemplar;
  CriarAnuncio4({this.exemplar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 35.r,
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
              height: 40.h,
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
        Text(
          'Fotos',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 33.sp,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            right: 30.r,
          ),
        ),
      ],
    );
  }
}

class Fotos extends StatefulWidget {
  ExemplarProvider exemplar;
  Fotos({this.exemplar});
  @override
  FotosState createState() => FotosState(exemplar: exemplar);
}

class FotosState extends State<Fotos> {
  ExemplarProvider exemplar;
  FotosState({this.exemplar});

  bool carregando = false;

  File _imageCapa = null;
  File _imageContracapa = null;
  File _imageLombada = null;
  File _imageCorteSuperior = null;
  File _imageCorteDianteiro = null;
  File _imageCorteInferior = null;

  String _url =
      'https://www.chocolatebayou.org/wp-content/uploads/No-Image-Person-1536x1536.jpeg';

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

  Widget carregandoButton() {
    if (carregando) {
      return CircularProgressIndicator(
        backgroundColor: Colors.deepPurple[600],
        valueColor: AlwaysStoppedAnimation(Colors.white),
      );
    } else {
      return Text(
        'Próximo',
        style: TextStyle(fontSize: 18.sp),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              'Capa',
              style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            width: 220.w,
            height: 220.h,
            decoration: BoxDecoration(
              border: Border.all(width: 0.5.w),
              borderRadius: BorderRadius.all(Radius.circular(5.0.r)),
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
                        : NetworkImage(_url),
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
              mostrarOpcaoFoto(context, "Capa");
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              'Contracapa',
              style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            width: 220.w,
            height: 220.h,
            decoration: BoxDecoration(
              border: Border.all(width: 0.5.w),
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
                        : NetworkImage(_url),
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
              mostrarOpcaoFoto(context, "Contracapa");
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              'Lombada',
              style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            width: 220.w,
            height: 220.h,
            decoration: BoxDecoration(
              border: Border.all(width: 0.5.w),
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
                        : NetworkImage(_url),
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
              mostrarOpcaoFoto(context, "Lombada");
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              'Corte Superior',
              style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            width: 220.w,
            height: 220.h,
            decoration: BoxDecoration(
              border: Border.all(width: 0.5.w),
              borderRadius: BorderRadius.all(Radius.circular(5.0.r)),
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
                        : NetworkImage(_url),
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
              mostrarOpcaoFoto(context, "Corte Superior");
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              'Corte Dianteiro',
              style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            width: 220.w,
            height: 220.h,
            decoration: BoxDecoration(
              border: Border.all(width: 0.5.w),
              borderRadius: BorderRadius.all(Radius.circular(5.0.r)),
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
                        : NetworkImage(_url),
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
              mostrarOpcaoFoto(context, "Corte Dianteiro");
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              'Corte Inferior',
              style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            width: 220.w,
            height: 220.h,
            decoration: BoxDecoration(
              border: Border.all(width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(5.0.r)),
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
                        : NetworkImage(_url),
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
              mostrarOpcaoFoto(context, "Corte Inferior");
            },
          ),
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
              if (_imageCapa != null &&
                  _imageContracapa != null &&
                  _imageLombada != null &&
                  _imageCorteSuperior != null &&
                  _imageCorteDianteiro != null &&
                  _imageCorteInferior != null) {
                setState(() {
                  carregando = true;
                });

                String fileName = basename(_imageCapa.path);
                UploadTask uploadTask = FirebaseStorage.instance
                    .ref()
                    .child(fileName)
                    .putFile(_imageCapa);

                var imageUrl = await (await uploadTask).ref.getDownloadURL();
                exemplar.changeCapa(imageUrl.toString());

                fileName = basename(_imageContracapa.path);
                uploadTask = FirebaseStorage.instance
                    .ref()
                    .child(fileName)
                    .putFile(_imageContracapa);
                imageUrl = await (await uploadTask).ref.getDownloadURL();
                exemplar.changeContracapa(imageUrl);

                fileName = basename(_imageLombada.path);
                uploadTask = FirebaseStorage.instance
                    .ref()
                    .child(fileName)
                    .putFile(_imageLombada);
                imageUrl = await (await uploadTask).ref.getDownloadURL();
                exemplar.changeLombada(imageUrl);

                fileName = basename(_imageCorteDianteiro.path);
                uploadTask = FirebaseStorage.instance
                    .ref()
                    .child(fileName)
                    .putFile(_imageCorteDianteiro);
                imageUrl = await (await uploadTask).ref.getDownloadURL();
                exemplar.changeCorteDianteiro(imageUrl);

                fileName = basename(_imageCorteInferior.path);
                uploadTask = FirebaseStorage.instance
                    .ref()
                    .child(fileName)
                    .putFile(_imageCorteInferior);
                imageUrl = await (await uploadTask).ref.getDownloadURL();
                exemplar.changeCorteInferior(imageUrl);

                fileName = basename(_imageCorteSuperior.path);
                uploadTask = FirebaseStorage.instance
                    .ref()
                    .child(fileName)
                    .putFile(_imageCorteSuperior);
                imageUrl = await (await uploadTask).ref.getDownloadURL();
                exemplar.changeCorteSuperior(imageUrl);

                exemplar.saveExemplar();

                FirestoreService firestore = FirestoreService();
                firestore.getUsersWithLivrosInt(exemplar.isbn);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            MenuInferiorScreen()));
              } else {}
            },
            child: carregandoButton(),
          ),
        ],
      ),
    );
  }
}
