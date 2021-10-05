import 'package:flutter/material.dart';

class GameSuccessWidget extends StatelessWidget {
  const GameSuccessWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
        child: Container(
          color: Colors.pink[300],
          padding: const EdgeInsets.all(16.0),
          child: Text(
            '成功过关!',
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
      ),
    );
  }
}
