// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc()
      : super(
        GameInitial(
            previousIndex: -1,
            flip: false,
            start: false,
            wait: false,
            timer: Timer.periodic(const Duration(milliseconds: 10), (t) {}),
            time: 5,
            left: 8,
            isFinished: false)) {
    on<GameStartEvent>((event, emit) {
      //esperamos 5 segundos para empezar
      // Future.delayed(const Duration(seconds: 5), () {
        print('GameStartEvent 2');
        emit(StartGame(
            previousIndex: event.previousIndex,
            flip: event.flip,
            start: event.start,
            wait: event.wait,
            timer: event.timer,
            time: event.time,
            left: event.left,
            isFinished: event.isFinished));
      

     
    // });
      
      });
    add(GameStartEvent( previousIndex: -1,
          flip: false,
          start: true,
          wait: false,
          timer: Timer.periodic(const Duration(milliseconds: 10), (t) {}),
          time: 5,
          left: 8,
          isFinished: false));
  }
}
