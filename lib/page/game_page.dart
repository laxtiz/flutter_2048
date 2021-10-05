import 'package:flutter/material.dart';
import 'package:flutter_2048/bloc/game_bloc.dart';
import 'package:flutter_2048/widget/game_box_widget.dart';
import 'package:flutter_2048/widget/game_over_widget.dart';
import 'package:flutter_2048/widget/game_success_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game 2048'),
        actions: [
          IconButton(
              onPressed: () =>
                  context.read<GameBloc>().add(GameRestart(size: 4)),
              icon: const Icon(Icons.replay))
        ],
      ),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Column(
            children: const [
              GameScore(),
              Expanded(child: GameContent()),
            ],
          ),
        ),
      ),
    );
  }
}

class GameContent extends StatelessWidget {
  const GameContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        var v = details.primaryVelocity ?? 0.0;
        if (v > 0) {
          context.read<GameBloc>().add(GameMoveRight());
        } else if (v < 0) {
          context.read<GameBloc>().add(GameMoveLeft());
        }
      },
      onVerticalDragEnd: (details) {
        var v = details.primaryVelocity ?? 0.0;
        if (v > 0) {
          context.read<GameBloc>().add(GameMoveDown());
        } else if (v < 0) {
          context.read<GameBloc>().add(GameMoveUp());
        }
      },
      child: Center(
        child: AspectRatio(
          aspectRatio: 1.0,
          child: BlocBuilder<GameBloc, GameState>(
            builder: (context, state) {
              return Stack(children: [
                GameBox(
                  size: state.size,
                  data: state.data,
                ),
                if (state.status == GameStatus.over) const GameOverWidget(),
                if (state.status == GameStatus.success)
                  const GameSuccessWidget(),
              ]);
            },
          ),
        ),
      ),
    );
  }
}

class GameScore extends StatelessWidget {
  const GameScore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        child: Container(
          color: Colors.cyan[200],
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<GameBloc, GameState>(
            builder: (context, state) {
              var score = state.data.fold<int>(0, (s, e) => s + e);
              return Text(
                '分数: $score',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              );
            },
          ),
        ),
      ),
    );
  }
}
