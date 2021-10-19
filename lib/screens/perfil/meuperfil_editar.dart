import 'dart:io';
import 'package:dook/screens/perfil/meuperfil.dart';
import 'package:dook/services/firestore_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class EditarPerfilScreen extends StatefulWidget {
  var usuario;
  EditarPerfilScreen({this.usuario});
  EditarPerfil createState() => EditarPerfil(usuario: usuario);
}

class EditarPerfil extends State {
  var usuario;
  EditarPerfil({this.usuario});
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            EditarPerfilCabecalhoState(usuario: usuario),
            EditarPerfilCorpoState(usuario: usuario),
          ],
        ),
      ),
    );
  }
}

class EditarPerfilCabecalhoState extends StatefulWidget {
  var usuario;
  EditarPerfilCabecalhoState({this.usuario});
  EditarPerfilCabecalho createState() =>
      EditarPerfilCabecalho(usuario: usuario);
}

File _image;

class EditarPerfilCabecalho extends State {
  var usuario;
  EditarPerfilCabecalho({this.usuario});

  FirestoreService firestore = new FirestoreService();

  final ImagePicker imagePicker = ImagePicker();
  Future getImageGallery() async {
    var image = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image.path);
    });
  }

  Future getImageCamera() async {
    var image = await imagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = File(image.path);
    });
  }

  void mostrarOpcaoFoto(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Galeria'),
                      onTap: () {
                        getImageGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      getImageCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        //Stack usado para fazer este efeito da cor roxa
        clipBehavior: Clip.none,
        children: <Widget>[
          Container(
            //Criado Container da cor roxa e seu tamanho
            color: Colors.deepPurple[600],
            height: 220.0.h,
          ),
          Row(
            //Linhas para colocar os Icones e o Texto centralizados
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                //Botão de voltar para a página anterior
                padding: EdgeInsets.only(
                  top: 25.r,
                  left: 25.r,
                  right: 25.r,
                ),
                child: IconButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Image.asset(
                    'assets/images/icons/voltarbranco.png',
                    height: 25.h,
                    width: 25.w,
                  ),
                  alignment: Alignment.centerLeft,
                ),
                width: 90.w,
              ),
              Container(
                //Texto central 'Perfil'
                padding: EdgeInsets.only(
                  top: 25.r,
                  left: 25.r,
                  right: 25.r,
                ),
                child: Text(
                  'Perfil',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 35.sp,
                  ),
                ),
              ),
              Container(
                //Icone que vai para a tela de editar perfil
                width: 90.w,
              ),
            ],
          ),
          Center(
            child:
                //Verifica se tem data
                Container(
              padding: EdgeInsets.only(top: 100.r),
              child: Container(
                //Mostrar foto de perfil redonda
                width: 170.w,
                height: 170.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(2.r),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: (_image != null)
                            ? FileImage(_image)
                            : NetworkImage(
                                usuario.url), //Pegar imagem através de um link
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.only(top: 270.r),
              child: TextButton(
                child: Text(
                  'Editar Foto',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17.sp,
                    color: Colors.deepPurple[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {
                  mostrarOpcaoFoto(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EditarPerfilCorpoState extends StatefulWidget {
  var usuario;
  EditarPerfilCorpoState({this.usuario});
  EditarPerfilCorpo createState() => EditarPerfilCorpo(usuario: usuario);
}

class EditarPerfilCorpo extends State {
  var usuario;
  EditarPerfilCorpo({this.usuario});

  FirestoreService firestore = FirestoreService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController datanascController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController cepController = TextEditingController();
  final TextEditingController ruaController = TextEditingController();
  final TextEditingController bairroController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();
  final TextEditingController complementoController = TextEditingController();
  final TextEditingController cidadeController = TextEditingController();
  final TextEditingController ufController = TextEditingController();

  Widget build(BuildContext context) {
    String aviso = '';
    var urlPhoto = usuario.url;
    nameController.text = usuario.nome;
    cpfController.text = usuario.cpf;
    datanascController.text = usuario.datanasc;
    telefoneController.text = usuario.telefone;
    cepController.text = usuario.cep;
    ruaController.text = usuario.rua;
    bairroController.text = usuario.bairro;
    numeroController.text = usuario.numero;
    complementoController.text = usuario.complemento;
    cidadeController.text = usuario.cidade;
    ufController.text = usuario.uf;

    return Container(
      padding: EdgeInsets.only(
        left: 25.r,
        right: 25.r,
      ),
      child: Column(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.only(
                left: 30.r,
                right: 30.r,
              ),
              child: TextField(
                textInputAction: TextInputAction.next,
                controller: nameController,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22.sp),
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: cpfController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                top: 20.r,
                bottom: 20.r,
                left: 15.r,
                right: 15.r,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: Colors.yellow)),
              labelText: "CPF",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: datanascController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                top: 20.r,
                bottom: 20.r,
                left: 15.r,
                right: 15.r,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: Colors.yellow)),
              labelText: "Data Nascimento",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: telefoneController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                top: 20.r,
                bottom: 20.r,
                left: 15.r,
                right: 15.r,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: Colors.yellow)),
              labelText: "Telefone",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Center(
            child: Text(
              'Endereço',
              style: TextStyle(fontSize: 24.sp),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: cepController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                top: 20.r,
                bottom: 20.r,
                left: 15.r,
                right: 15.r,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: Colors.yellow)),
              labelText: "CEP",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: ruaController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                top: 20.r,
                bottom: 20.r,
                left: 15.r,
                right: 15.r,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: Colors.yellow)),
              labelText: "Rua",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: bairroController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                top: 20.r,
                bottom: 20.r,
                left: 15.r,
                right: 15.r,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: Colors.yellow)),
              labelText: "Bairro",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: numeroController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                top: 20.r,
                bottom: 20.r,
                left: 15.r,
                right: 15.r,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: Colors.yellow)),
              labelText: "Numero",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: complementoController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                top: 20.r,
                bottom: 20.r,
                left: 15.r,
                right: 15.r,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: Colors.yellow)),
              labelText: "Complemento",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: cidadeController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                top: 20.r,
                bottom: 20.r,
                left: 15.r,
                right: 15.r,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: Colors.yellow)),
              labelText: "Cidade",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          TextFormField(
            textInputAction: TextInputAction.none,
            controller: ufController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                top: 20.r,
                bottom: 20.r,
                left: 15.r,
                right: 15.r,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: Colors.yellow)),
              labelText: "UF",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
            ),
          ),
          SizedBox(
            height: 50.h,
          ),
          ElevatedButton(
            onPressed: () async {
              if (!GetUtils.isCpf(cpfController.text)) {
                cpfController.text = usuario.cpf;
              }
              if (cepController.text.length != 9) {
                cepController.text = usuario.cep;
              }
              if (ufController.text.length != 2) {
                ufController.text = usuario.uf;
              }
              if (cidadeController.text == '') {
                cidadeController.text = usuario.cidade;
              }
              if (_image != null) {
                String fileName = basename(_image.path);
                UploadTask uploadTask = FirebaseStorage.instance
                    .ref()
                    .child(fileName)
                    .putFile(_image);

                var imageUrl = await (await uploadTask).ref.getDownloadURL();
                urlPhoto = imageUrl;
                _image = null;
              }
              firestore.updateUser(
                  nameController.text,
                  cpfController.text,
                  datanascController.text,
                  telefoneController.text,
                  cepController.text,
                  ruaController.text,
                  bairroController.text,
                  numeroController.text,
                  complementoController.text,
                  cidadeController.text,
                  ufController.text,
                  urlPhoto);

              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple[600],
              minimumSize: Size(600.h, 55.h),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
            ),
            child: Text(
              'Salvar',
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }
}
