import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  final random = Random();

  GameBloc(int size) : super(GameState.makeNew(size)) {
    on<GameRestart>(onRestart);
    on<GameMoveUp>(onUp);
    on<GameMoveDown>(onDown);
    on<GameMoveLeft>(onLeft);
    on<GameMoveRight>(onRight);
  }

  void check(List<int> data, Emitter<GameState> emit) {
    var zeros = <int>[];
    for (var i = 0; i < data.length; i++) {
      if (data[i] >= 2048) {
        emit(state.copyWith(status: GameStatus.success, data: data));
        return;
      }
      if (data[i] == 0) zeros.add(i);
    }

    if (zeros.isEmpty) {
      emit(state.copyWith(status: GameStatus.over, data: data));
      return;
    }

    var r = random.nextInt(zeros.length);
    data[zeros[r]] = 1;
    emit(state.copyWith(status: GameStatus.running, data: data));
  }

  Future<void> onDown(GameMoveDown event, Emitter<GameState> emit) async {
    if (state.status == GameStatus.over) return;
    if (state.status == GameStatus.success) return;
    var size = state.size;
    var data = List<int>.from(state.data);
    for (var x = 0; x < size; x++) {
      var l = <int>[];
      for (var y = size - 1; y >= 0; y--) {
        l.add(data[y * size + x]);
      }
      l = tidy(l);
      for (var y = size - 1; y >= 0; y--) {
        data[y * size + x] = l[size - y - 1];
      }
    }

    check(data, emit);
  }

  Future<void> onLeft(GameEvent event, Emitter<GameState> emit) async {
    if (state.status == GameStatus.over) return;
    if (state.status == GameStatus.success) return;

    var size = state.size;
    var data = List<int>.from(state.data);

    for (var y = 0; y < size; y++) {
      var l = <int>[];
      for (var x = 0; x < size; x++) {
        l.add(data[y * size + x]);
      }
      l = tidy(l);
      for (var x = 0; x < size; x++) {
        data[y * size + x] = l[x];
      }
    }
    check(data, emit);
  }

  Future<void> onRestart(GameRestart event, Emitter<GameState> emit) async {
    emit(GameState.makeNew(event.size ?? state.size));
  }

  Future<void> onRight(GameEvent event, Emitter<GameState> emit) async {
    if (state.status == GameStatus.over) return;
    if (state.status == GameStatus.success) return;
    var size = state.size;
    var data = List<int>.from(state.data);
    for (var y = 0; y < size; y++) {
      var l = <int>[];
      for (var x = size - 1; x >= 0; x--) {
        l.add(data[y * size + x]);
      }
      l = tidy(l);
      for (var x = size - 1; x >= 0; x--) {
        data[y * size + x] = l[size - x - 1];
      }
    }

    check(data, emit);
  }

  Future<void> onUp(GameMoveUp event, Emitter<GameState> emit) async {
    if (state.status == GameStatus.over) return;
    if (state.status == GameStatus.success) return;
    var size = state.size;
    var data = List<int>.from(state.data);
    for (var x = 0; x < size; x++) {
      var l = <int>[];
      for (var y = 0; y < size; y++) {
        l.add(data[y * size + x]);
      }
      l = tidy(l);
      for (var y = 0; y < size; y++) {
        data[y * size + x] = l[y];
      }
    }

    check(data, emit);
  }

  List<int> tidy(List<int> list) {
    while (true) {
      var t = <int>[];
      for (var v in list) {
        if (v == 0) continue;
        if (t.isNotEmpty && t.last == v) {
          t.last += v;
          continue;
        }
        t.add(v);
      }
      if (t.length == list.length) break;
      list = t;
    }
    list.addAll(List.filled(state.size - list.length, 0));
    return list;
  }
}
