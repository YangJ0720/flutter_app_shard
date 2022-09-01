import 'package:flutter/material.dart';

class ScaleHourView extends StatelessWidget {
  final double itemWidth;
  final double itemHeight;

  const ScaleHourView(this.itemWidth, this.itemHeight, {Key? key})
      : super(key: key);

  Widget _createItemView(int index) {
    return Container(
      alignment: Alignment.centerRight,
      child: Text('${index.toString().padLeft(2, '0')}:00'),
      color: Colors.grey[200],
      padding: const EdgeInsets.only(right: 10),
      width: itemWidth,
      height: itemHeight,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    var child = Container(
      color: Colors.grey[200],
      width: itemWidth,
      height: itemHeight / 2,
    );
    children.add(child);
    children.addAll(List.generate(24, (index) => _createItemView(index)));
    children.add(child);
    return Column(children: children, mainAxisSize: MainAxisSize.min);
  }
}
