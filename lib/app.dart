import 'package:flutter/material.dart';
import 'package:flutter_2048/page/game_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/game_bloc.dart';

class GameApp extends StatelessWidget {
  const GameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameBloc(4),
      child: const MaterialApp(
        title: 'Game 2048',
        debugShowCheckedModeBanner: false,
        home: GamePage(),
      ),
    );
  }
}
