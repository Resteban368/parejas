// ignore_for_file: avoid_print

import 'package:animate_do/animate_do.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:parejas/data.dart';

class FlipCardGane extends StatefulWidget {
  const FlipCardGane({Key? key}) : super(key: key);

  @override
  State<FlipCardGane> createState() => _FlipCardGaneState();
}

class _FlipCardGaneState extends State<FlipCardGane> {
  int _previousIndex = -1;
  bool _flip = false;
  bool _start = false;
  int _tries = 0;

  bool _wait = false;
  Timer _timer = Timer.periodic(Duration(milliseconds: 10), (t) {});
  int _time = 5;
  int _left = 8;
  bool _isFinished = false;

  Timer? _timer2;
  int _milisegundos = 0;
  bool _estaFuncionando = false;

  bool _isWon = false;

  void _iniciarCronometro() {
    if (!_estaFuncionando) {
      _estaFuncionando = true;
      _timer2 = Timer.periodic(Duration(milliseconds: 10), (Timer timer2) {
        setState(() {
          _milisegundos += 10;
        });
      });
    }
  }

  void _pausarCronometro() {
    if (_timer2 != null && _timer2!.isActive) {
      _timer2!.cancel();
      _estaFuncionando = false;
    }
  }

  void _reiniciarCronometro() {
    _pausarCronometro();
    setState(() {
      _milisegundos = 0;
    });
  }

  String _formatearTiempo(int milliseconds) {
    int minutos = (milliseconds ~/ 60000) % 60;
    int segundos = (milliseconds ~/ 1000) % 60;
    int horas = (milliseconds ~/ 3600000) % 24;
    // int milisegundos = milliseconds % 1000;

    return '${horas.toString().padLeft(2, '0')}:${minutos.toString().padLeft(2, '0')}:${segundos.toString().padLeft(2, '0')}';
  }

  //hacemos una variable de tipo tiempo para el cronometro
  List<String> _data = getSourceArray();

  List<bool> _cardFlips = getInitialItemState();
  List<GlobalKey<FlipCardState>> _cardStateKeys = getCardStateKeys();

  Widget getItem(int index) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100],
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 3,
              spreadRadius: 0.8,
              offset: Offset(2.0, 1),
            )
          ],
          borderRadius: BorderRadius.circular(5)),
      margin: EdgeInsets.all(4.0),
      child: Image.asset(_data[index]),
    );
  }

  startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        _time = _time - 1;
      });
    });
  }

  void restart() {
    startTimer();
    _data = getSourceArray();
    _cardFlips = getInitialItemState();
    _cardStateKeys = getCardStateKeys();
    _time = 5;
    _left = (_data.length ~/ 2);

    _isFinished = false;
    Future.delayed(const Duration(seconds: 6), () {
      setState(() {
        _start = true;
        _timer.cancel();
      });
    });
  }

  @override
  void initState() {
    super.initState();

    restart();
  }

  // @override
  // void dispose() async {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return _isFinished
        ? Scaffold(
            appBar: AppBar(
                title: const Text('Juego de parejas'),
                centerTitle: true,
                backgroundColor: Colors.purple),
            body: SafeArea(
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        margin: const EdgeInsets.only(
                          top: 80,
                          bottom: 20,
                          left: 20,
                          right: 20,
                        ),
                        elevation: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/pair.png'),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Tu tiempo fue de: ",
                              style:
                                  TextStyle(fontSize: 25, color: Colors.purple),
                            ),
                            Text(_formatearTiempo((_milisegundos)),
                                style: const TextStyle(fontSize: 25)),
                            Text(
                              "Tus errores: $_tries",
                              style: const TextStyle(
                                  fontSize: 25, color: Colors.purple),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                 
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 50),
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {
                        setState(() {
                          restart();
                          _tries = 0;
                          _left = 10;
                          _reiniciarCronometro();
                        });
                      },
                      child: Text('Reiniciar'),
                    )
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
                title: const Text('Juego de parejas'),
                centerTitle: true,
                backgroundColor: Colors.purple),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    // Padding(
                    //   padding: const EdgeInsets.all(16.0),
                    //   child: _time > 0
                    //       ? Text(
                    //           '$_time',
                    //           style: Theme.of(context).textTheme.displaySmall,
                    //         )
                    //       : Text(
                    //           'Left:$_left',
                    //           style: Theme.of(context).textTheme.displaySmall,
                    //         ),
                    // ),

                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 120,
                      child:
                          //pondemos un cronometro
                          Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.timer_sharp,
                                  size: 30,
                                  color: Colors.purple,
                                ),
                                const Text(
                                  "Tiempo: ",
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.purple),
                                ),
                                Text(_formatearTiempo((_milisegundos)),
                                    style: const TextStyle(fontSize: 25)),
                              ],
                            ),
                            Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                child: Text(
                                  "Errores: $_tries",
                                  style: const TextStyle(
                                      fontSize: 25, color: Colors.purple),
                                ))
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 20),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                        ),
                        itemBuilder: (context, index) => _start
                            ? FlipCard(
                                key: _cardStateKeys[index],
                                onFlip: _wait
                                    ? null
                                    : () {
                                        print('is won $_isWon');
                                        _iniciarCronometro();
                                        if (!_flip) {
                                          _flip = true;
                                          _previousIndex = index;
                                        } else {
                                          _flip = false;
                                          if (_previousIndex != index) {
                                            if (_data[_previousIndex] !=
                                                _data[index]) {
                                              print("Lost");
                                              _isWon = false;
                                              _wait = true;
                                              _tries += 1;

                                              Future.delayed(
                                                  const Duration(
                                                      milliseconds: 1500), () {
                                                _cardStateKeys[_previousIndex]
                                                    .currentState!
                                                    .toggleCard();
                                                _previousIndex = index;
                                                _cardStateKeys[_previousIndex]
                                                    .currentState!
                                                    .toggleCard();

                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 160), () {
                                                  setState(() {
                                                    _wait = false;
                                                  });
                                                });
                                              });
                                            } else {
                                              _isWon = true;
                                              print("Won");
                                              _cardFlips[_previousIndex] =
                                                  false;
                                              _cardFlips[index] = false;
                                              print(_cardFlips);

                                              setState(() {
                                                _left -= 1;
                                              });
                                              if (_cardFlips
                                                  .every((t) => t == false)) {
                                                print("Won");
                                                Future.delayed(
                                                    const Duration(
                                                        milliseconds: 160), () {
                                                  setState(() {
                                                    _isFinished = true;
                                                    _start = false;
                                                  });
                                                  _pausarCronometro();
                                                });
                                              }
                                            }
                                          }
                                        }
                                        setState(() {});
                                        print('iswon $_isWon');
                                      },
                                flipOnTouch: _wait
                                    ? false
                                    : _cardFlips[
                                        index], //todo mostramos solo la carta que no se ha volteado
                                direction: FlipDirection.HORIZONTAL,
                                front: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.purple,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black45,
                                          blurRadius: 3,
                                          spreadRadius: 0.8,
                                          offset: Offset(2.0, 1),
                                        )
                                      ]),
                                  margin: const EdgeInsets.all(4.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      "assets/?.png",
                                    ),
                                  ),
                                ),
                                back: _isWon
                                    //solo a la carta que se ha volteado le mostramos la imagen
                                    ? BounceInDown(
                                        duration:
                                            const Duration(milliseconds: 1500),
                                        child: getItem(index))
                                    : getItem(index))
                            : getItem(index),
                        itemCount: _data.length,
                      ),
                    ),

                    Visibility(
                      visible: _start,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              print('esta pausado $_estaFuncionando');
                              if (_estaFuncionando) {
                                print("pausar");
                                _pausarCronometro();
                                _showDialog();
                              } else {
                                print("reanudar");
                                _iniciarCronometro();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(100, 40),
                              backgroundColor: Colors.purple,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.play_arrow),
                                Text("Pausar"),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _showDialogFinish();
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(100, 40),
                              backgroundColor: Colors.purple,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.stop),
                                Text("Terminar"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }

  //hacemos un alert dialog para mostrar el tiempo
  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          final int parejas = 10 - _left;
          return AlertDialog(
            //no cerramos el dialogo al tocar fuera de el
            title: const Text("El juego esta pausado"),
            content: Text(
                'Parejas encontradas: $parejas de 10 \nErrores: $_tries \nTiempo: ${_formatearTiempo((_milisegundos))}'),
            actions: [
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _iniciarCronometro();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 40),
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    child: const Text("Reanudar")),
              )
            ],
          );
        });
  }

  void _showDialogFinish() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          final int parejas = 10 - _left;
          return AlertDialog(
            //no cerramos el dialogo al tocar fuera de el
            title: const Text("El juego ha terminado"),
            content: Text(
                'Parejas encontradas: $parejas de 10 \nErrores: $_tries \nTiempo: ${_formatearTiempo((_milisegundos))}'),
            actions: [
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 40),
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    child: const Text("Terminar")),
              )
            ],
          );
        });
  }
}
