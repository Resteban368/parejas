part of 'game_bloc.dart';

@immutable
sealed class GameEvent {
  final int previousIndex;
  final bool flip;
  final bool start;
  final bool wait;
  final Timer timer;
  final int time;
  final int left;
  final bool isFinished;

  const GameEvent({
    required this.previousIndex,
    required this.flip,
    required this.start,
    required this.wait,
    required this.timer,
    required this.time,
    required this.left,
    required this.isFinished,
  });
}

class GameStartEvent extends GameEvent {
  const GameStartEvent({
    required super.previousIndex,
    required super.flip,
    required super.start,
    required super.wait,
    required super.timer,
    required super.time,
    required super.left,
    required super.isFinished,
  });
}
class GameStartEvent2 extends GameEvent {
  const GameStartEvent2({
    required super.previousIndex,
    required super.flip,
    required super.start,
    required super.wait,
    required super.timer,
    required super.time,
    required super.left,
    required super.isFinished,
  });
}
