// ignore_for_file: must_be_immutable

part of 'game_bloc.dart';

@immutable
sealed class GameState {
   int previousIndex;
   bool flip;
   bool start;
   bool wait;
   Timer timer;
   int time;
   int left;
   bool isFinished;

   GameState(
      {required this.previousIndex,
      required this.flip,
      required this.start,
      required this.wait,
      required this.timer,
      required this.time,
      required this.left,
      required this.isFinished});
}

class GameInitial extends GameState {
   GameInitial(
      {required super.previousIndex,
      required super.flip,
      required super.start,
      required super.wait,
      required super.timer,
      required super.time,
      required super.left,
      required super.isFinished});
}
class StartGame extends GameState {
   StartGame(
      {required super.previousIndex,
      required super.flip,
      required super.start,
      required super.wait,
      required super.timer,
      required super.time,
      required super.left,
      required super.isFinished});
}


