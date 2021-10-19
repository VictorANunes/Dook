import 'package:dook/screens/editar_fotos.dart';
import 'package:dook/screens/editar_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';

class EditarLivroScreen extends StatefulWidget {
  @override
  EditarLivro createState() => EditarLivro();
}

class EditarLivro extends State {

  void telaEditarFotos() {
    Navigator.push(
        //Mudar para a tela de confirmação dos dados
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => EditarFotosScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(
          top: 40.r,
          left: 25.r,
          right: 25.r,
        ),
        children: <Widget>[
          Column(
            children: <Widget>[
              Superior(),
              SizedBox(
                height: 35.h,
              ),
              Carrossel(),
              TextButton(
                onPressed: () {
                  telaEditarFotos();
                },
                child: Text(
                  'Editar Fotos',
                  style: TextStyle(
                    color: Colors.deepPurple[600],
                    fontSize: 18.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              InfoLivro(),
              SizedBox(
                height: 30.h,
              ),
              Condicao(),
              SizedBox(
                height: 50.h,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple[600],
                  minimumSize: Size(382.h, 55.h),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Salvar',
                  style: TextStyle(fontSize: 18.sp),
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Superior extends StatefulWidget {
  @override
  SuperiorState createState() => SuperiorState();
}

class SuperiorState extends State {
  void telaEditarLivro() {
    Navigator.push(
        //Mudar para a tela de confirmação dos dados
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => EditarLivroScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            size: 30,
          ),
        ),
        Text(
          'Editar Livro',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 33.sp,
          ),
        ),
        IconButton(
          color: Colors.black,
          onPressed: () {
            telaEditarLivro();
          },
          icon: Icon(
            Icons.delete_outline,
            size: 30,
          ),
        ),
      ],
    );
  }
}

class Carrossel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Carrossel de imagens
        CarouselSlider(
          options: CarouselOptions(height: 200.0, reverse: false),
          items: [1, 2, 3, 4, 5, 6].map((i) {
            // Itens
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(color: Colors.grey),
                    child: Text(
                      // Exibição do Conteúdo
                      'imagem $i',
                      style: TextStyle(fontSize: 16.0),
                    ));
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}

class InfoLivro extends StatelessWidget {
  final TextEditingController _controladorTitulo = TextEditingController();
  final TextEditingController _controladorISBN = TextEditingController();
  final TextEditingController _controladorAutor = TextEditingController();
  final TextEditingController _controladorEdicao = TextEditingController();
  final TextEditingController _controladorEditora = TextEditingController();
  final TextEditingController _controladorDtPublicacao =
      TextEditingController();
  final TextEditingController _controladorCategoria = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: _controladorTitulo,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 30.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: TextFormField(
            controller: _controladorISBN,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                top: 20.r,
                bottom: 20.r,
                left: 15.r,
                right: 15.r,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.yellow)),
              labelText: "ISBN",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: TextFormField(
            controller: _controladorAutor,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                top: 20.r,
                bottom: 20.r,
                left: 15.r,
                right: 15.r,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.yellow)),
              labelText: "Autor",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: TextFormField(
            controller: _controladorEditora,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                top: 20.r,
                bottom: 20.r,
                left: 15.r,
                right: 15.r,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.yellow)),
              labelText: "Editora",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: TextFormField(
            controller: _controladorEdicao,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                top: 20.r,
                bottom: 20.r,
                left: 15.r,
                right: 15.r,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.yellow)),
              labelText: "Edição",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: TextFormField(
            controller: _controladorDtPublicacao,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                top: 20.r,
                bottom: 20.r,
                left: 15.r,
                right: 15.r,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.yellow)),
              labelText: "Data de Publicação",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: TextFormField(
            controller: _controladorCategoria,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                top: 20.r,
                bottom: 20.r,
                left: 15.r,
                right: 15.r,
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.yellow)),
              labelText: "Categoria",
              labelStyle: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: 18.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Condicao extends StatefulWidget{
  @override
  CondicaoState createState() => CondicaoState();
  
}

class CondicaoState extends State {

  void telaEditarForm() {
    Navigator.push(
        //Mudar para a tela de confirmação dos dados
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => EditarFormScreen()));
  }

  double _currentSliderValue1 = 5;
  double _currentSliderValue2 = 3;
  double _currentSliderValue3 = 4;
  double _currentSliderValue4 = 2;
  double _currentSliderValue5 = 5;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Condição do Livro',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 25.sp,
          ),
        ),
        IconButton(
          color: Colors.black,
          onPressed: () {
            telaEditarForm();
          },
          icon: Icon(
            Icons.edit_outlined,
            size: 30,
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.1),
              child: Text(
                'O livro está em excelente estado geral',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.sp),
              ),
            ),
            Slider(
              activeColor: Colors.deepPurple[600],
              value: _currentSliderValue1,
              min: 1,
              max: 5,
              divisions: 4,
              label: _currentSliderValue1.round().toString(),
              onChanged: (double value) {},
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                'O livro não possui nenhum sinal de uso',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.sp),
              ),
            ),
            Slider(
              activeColor: Colors.deepPurple[600],
              value: _currentSliderValue2,
              min: 1,
              max: 5,
              divisions: 4,
              label: _currentSliderValue2.round().toString(),
              onChanged: (double value) {},
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                'O livro não possui nenhuma rasura',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.sp),
              ),
            ),
            Slider(
              activeColor: Colors.deepPurple[600],
              value: _currentSliderValue3,
              min: 1,
              max: 5,
              divisions: 4,
              label: _currentSliderValue3.round().toString(),
              onChanged: (double value) {},
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                'O livro não possui nenhuma pagina rasgada ou faltando',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.sp),
              ),
            ),
            Slider(
              activeColor: Colors.deepPurple[600],
              value: _currentSliderValue4,
              min: 1,
              max: 5,
              divisions: 4,
              label: _currentSliderValue4.round().toString(),
              onChanged: (double value) {},
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                'O livro tem menos de um ano desde que foi adquirido.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.sp),
              ),
            ),
            Slider(
              activeColor: Colors.deepPurple[600],
              value: _currentSliderValue5,
              min: 1,
              max: 5,
              divisions: 4,
              label: _currentSliderValue5.round().toString(),
              onChanged: (double value) {},
            ),
          ],
        ),
      ],
    );
  }
}
