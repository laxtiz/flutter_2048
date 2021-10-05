import 'package:flutter/material.dart';

class GameOverWidget extends StatelessWidget {
  const GameOverWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        child: Container(
          color: Colors.blue[300],
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'GameOver!',
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
      ),
    );
  }
}
