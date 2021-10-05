import 'dart:math';

import 'package:flutter/material.dart';

class NumberBox extends StatelessWidget {
  static const colors = <MaterialColor>[
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.cyan,
    Colors.blue,
    Colors.purple,
  ];

  final int number;
  const NumberBox(this.number, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var text = number > 0 ? number.toString() : '';
    var color = Colors.grey;
    if (number > 0) color = colors[(log(number) ~/ ln2) % colors.length];
    var style = Theme.of(context).textTheme.headline4;
    if (number.toString().length > 3) {
      style = Theme.of(context).textTheme.headline5;
    }
    return AspectRatio(
      aspectRatio: 1.0,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        child: Container(
          color: color,
          constraints: const BoxConstraints(minHeight: 32, minWidth: 32),
          child: Center(
            child: Text(
              text,
              style: style,
            ),
          ),
        ),
      ),
    );
  }
}
