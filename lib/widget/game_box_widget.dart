import 'package:flutter/material.dart';
import 'package:flutter_2048/widget/number_box_widget.dart';

class GameBox extends StatelessWidget {
  final int size;
  final List<int> data;
  const GameBox({Key? key, required this.size, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      child: Container(
        color: Colors.grey[200],
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: Iterable.generate(size)
              .map((y) => _buildRow(data.skip(y * size).take(size).toList()))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildRow(List<int> list) {
    return Flexible(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: list.map((e) => _buildBox(e)).toList(),
      ),
    );
  }

  Widget _buildBox(int num) {
    return Flexible(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: NumberBox(num),
      ),
    );
  }
}
