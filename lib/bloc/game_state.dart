part of 'game_bloc.dart';

enum GameStatus { initial, running, over, success }

@immutable
class GameState extends Equatable {
  const GameState(
      {required this.status, required this.size, required this.data});

  final GameStatus status;
  final List<int> data;
  final int size;

  factory GameState.makeNew(int size) {
    return GameState(
        status: GameStatus.initial,
        size: size,
        data: List.filled(size * size, 0));
  }

  GameState copyWith({GameStatus? status, int? size, List<int>? data}) {
    return GameState(
      status: status ?? this.status,
      size: size ?? this.size,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [status, data];
}
