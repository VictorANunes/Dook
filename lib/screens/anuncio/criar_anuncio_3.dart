import 'package:dook/models/exemplar_models.dart';
import 'package:dook/provider/exemplar_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dook/screens/anuncio/criar_anuncio_4.dart';

class CriarAnuncio3Screen extends StatefulWidget {
  @override
  ExemplarProvider exemplar;
  CriarAnuncio3Screen({this.exemplar});
  CriarAnuncio3 createState() => CriarAnuncio3(exemplar: exemplar);
}

class CriarAnuncio3 extends State {
  ExemplarProvider exemplar;
  CriarAnuncio3({this.exemplar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 60.r,
          left: 25.r,
          right: 25.r,
        ),
        child: Column(
          children: <Widget>[
            Superior(),
            SizedBox(
              height: 35.h,
            ),
            Center(
              child: Text(
                'De acordo com a condição do seu livro, responda as afirmações em uma escala de 1 a 5. Sendo 1 discordo totalmente e 5 concordo totalmente.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.sp),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            FormCondicao(exemplar: exemplar),
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
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
          ),
        ),
        Text(
          'Condição do Livro',
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

class FormCondicao extends StatefulWidget {
  ExemplarProvider exemplar;
  FormCondicao({this.exemplar});
  @override
  FormCondicaoState createState() => FormCondicaoState(exemplar: exemplar);
}

class FormCondicaoState extends State<FormCondicao> {
  ExemplarProvider exemplar;
  FormCondicaoState({this.exemplar});

  double _currentSliderValue1 = 1;
  double _currentSliderValue2 = 1;
  double _currentSliderValue3 = 1;
  double _currentSliderValue4 = 1;
  double _currentSliderValue5 = 1;

  void telaCriarAnuncio4(ExemplarProvider exemplar) {
    Navigator.push(
        //Mudar para a tela de confirmação dos dados
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                CriarAnuncio4Screen(exemplar: exemplar)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue1 = value;
                });
              },
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
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue2 = value;
                });
              },
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
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue3 = value;
                });
              },
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                'O livro não possui nenhuma página rasgada ou faltando',
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
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue4 = value;
                });
              },
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                'O livro não possui marcas de desgate do tempo',
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
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue5 = value;
                });
              },
            ),
            SizedBox(
              height: 65.h,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple[600],
                minimumSize: Size(382.h, 55.h),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
              onPressed: () {
                exemplar.changeResp1(_currentSliderValue1.toString());
                exemplar.changeResp2(_currentSliderValue2.toString());
                exemplar.changeResp3(_currentSliderValue3.toString());
                exemplar.changeResp4(_currentSliderValue4.toString());
                exemplar.changeResp5(_currentSliderValue5.toString());

                telaCriarAnuncio4(exemplar);
              },
              child: Text(
                'Próximo',
                style: TextStyle(fontSize: 18.sp),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
