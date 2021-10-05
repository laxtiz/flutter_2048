import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_2048/app.dart';
import 'package:flutter_2048/my_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const GameApp());
}
