import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dook/screens/editar_livro.dart';

class MeuLivroScreen extends StatefulWidget {
  @override
  MeuLivro createState() => MeuLivro();
}

class MeuLivro extends State {

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
              SizedBox(
                height: 30.h,
              ),
              InfoLivro(),
              SizedBox(
                height: 30.h,
              ),
              Condicao(),
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

class Superior extends StatefulWidget{
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
          'Livro',
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
            Icons.edit_outlined,
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Titulo',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 25.sp,
          ),
        ),
        SizedBox(
          height: 30.h,
        ),
        Row(
          children: <Widget>[
            Text(
              'ISBN: ',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
            ),
            Text(
              'XXXXXXXXXX',
              style: TextStyle(
                fontSize: 18.sp,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              'Autor: ',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
            ),
            Text(
              'XXXXXXXXXX',
              style: TextStyle(
                fontSize: 18.sp,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              'Editora: ',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
            ),
            Text(
              'XXXXXXXXXX',
              style: TextStyle(
                fontSize: 18.sp,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              'Edição: ',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
            ),
            Text(
              'XXXXXXXXXX',
              style: TextStyle(
                fontSize: 18.sp,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              'Data de Publicação: ',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
            ),
            Text(
              'XX/XX/XXXX',
              style: TextStyle(
                fontSize: 18.sp,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Text(
              'Categoria: ',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
            ),
            Text(
              'XXXXXXXXXX',
              style: TextStyle(
                fontSize: 18.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Condicao extends StatelessWidget {
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
