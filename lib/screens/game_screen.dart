import 'dart:async';
import 'dart:math';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Juego de parejas'),
          centerTitle: true,
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(height: 50),
              _Container(),
            ],
          ),
        ));
  }
}

List<String> fillSourceArray() {
  return [
    'assets/1.png',
    'assets/1.png',
    'assets/2.png',
    'assets/2.png',
    'assets/3.png',
    'assets/3.png',
    'assets/4.png',
    'assets/4.png',
    'assets/5.png',
    'assets/5.png',
    'assets/6.png',
    'assets/6.png',
    'assets/7.png',
    'assets/7.png',
    'assets/8.png',
    'assets/8.png',
  ];
}

class _Container extends StatefulWidget {
  const _Container({
    super.key,
  });

  @override
  State<_Container> createState() => _ContainerState();
}


class _ContainerState extends State<_Container> {
  List<String> shuffledImages = [];
  List<int> selectedIndices = [];
  bool isMatching = false;
  bool showCards = true;

  @override
  void initState() {
    super.initState();
    shuffledImages = fillSourceArray()..shuffle(Random());
  }

  void _onCardTap(int index) {
    print('Card index: $index');
    if (!showCards) return;

    if (selectedIndices.length < 2 && !selectedIndices.contains(index)) {
      print('entro');
      setState(() {
        selectedIndices.add(index);
        print(selectedIndices);
        if (selectedIndices.length == 2) {

          _checkIfMatching();
        }
      });
    }
  }

  void _checkIfMatching() {
    int index1 = selectedIndices[0];
    int index2 = selectedIndices[1];
    if (shuffledImages[index1] == shuffledImages[index2]) {
      // Cartas iguales
      print('Cartas iguales');
      isMatching = true;
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          selectedIndices.clear();
          isMatching = false;
        });
      });
    } else {
      print('Cartas diferentes');
      // Cartas diferentes
      isMatching = false;
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          selectedIndices.clear();
          showCards =
              true; // Corregir: Mostrar nuevamente las cartas después de 1 segundo
        });
      });
    }
  }

  // void _resetGame() {
  //   setState(() {
  //     shuffledImages = fillSourceArray()..shuffle(Random());
  //     selectedIndices.clear();
  //     isMatching = false;
  //     showCards = true;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
    // hacer una lista de cardsKey
    List<GlobalKey<FlipCardState>> cardKey =
        List.generate(16, (index) => GlobalKey<FlipCardState>());

    final size = MediaQuery.sizeOf(context);
    return Container(
        height: size.height * 0.5,
        width: size.width,
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
          child: GridView.builder(
            itemCount: shuffledImages.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10),
            itemBuilder: (context, index) {
              return FlipCard(
                // key: cardKey[index],
                autoFlipDuration: const Duration(seconds: 2),
                onFlip: () {
                  //cambiamos el estado de la carta para la carta seleccionada
                  // _onCardTap(index);
          _onCardTap(index);
                },
                 onFlipDone: (status) {
          //mostramos el indez de la carta seleccionada y el estado de ella misma
          //cambiamos el estado de la carta para la carta seleccionada
        },
                side: CardSide.BACK,
                direction: FlipDirection.HORIZONTAL,
                front: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(
                    'assets/?.png',
                    fit: BoxFit.fill,
                  ),
                ),
                back: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(
                    shuffledImages[
                        index], // Usar la imagen de la lista barajada
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
          ),
        ));
  }
}
