

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

List<String> fillSourceArray(){
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
    'assets/9.png',
    'assets/9.png',
    'assets/10.png',
    'assets/10.png',

    

  ];
}

getSourceArray(){
  List<String> sourceArray = fillSourceArray();
  sourceArray.shuffle();
  return sourceArray;
}



List<bool> getInitialItemState(){
  List<bool> itemState = [];
  for(int i = 0; i < 20; i++){
    itemState.add(true);
  }
  return itemState;
}

List<GlobalKey<FlipCardState>> getCardStateKeys(){
  List<GlobalKey<FlipCardState>> cardStateKeys = [];
  for(int i = 0; i < 20; i++){
    cardStateKeys.add(GlobalKey<FlipCardState>());
  }
  return cardStateKeys;
}
