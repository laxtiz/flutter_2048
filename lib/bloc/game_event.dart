part of 'game_bloc.dart';

@immutable
abstract class GameEvent {}

class GameRestart extends GameEvent {
  GameRestart({required this.size});
  final int? size;
}

class GameMoveUp extends GameEvent {}

class GameMoveDown extends GameEvent {}

class GameMoveLeft extends GameEvent {}

class GameMoveRight extends GameEvent {}
