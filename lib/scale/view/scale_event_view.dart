import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shard/scale/adapter/scale_adapter.dart';

class ScaleEventView extends StatelessWidget {
  final ScaleAdapter adapter;
  final double itemWidth;
  final double itemHeight;

  const ScaleEventView(this.adapter, this.itemWidth, this.itemHeight, {Key? key}) : super(key: key);

  List<Widget> _createDivider() {
    return List.generate(24, (index) {
      return Positioned(
        child: const Divider(color: Colors.black, height: 1),
        left: 0,
        top: itemHeight * index + itemHeight / 2,
        right: 0,
      );
    });
  }

  List<Widget> _createEvent(double width) {
    List<Widget> list = [];
    adapter.mapToString();
    int max = adapter.max();
    adapter.toList().forEach((element) {
      var sdt = element.getSdt;
      var h = sdt.hour;
      var m = sdt.minute;
      var edt = element.getEdt;
      var len = adapter.checked(sdt, edt);
      debugPrint('element = $element -> len = $len');
      var index = element.index;
      var random = Random();
      var r = random.nextInt(256);
      var g = random.nextInt(256);
      var b = random.nextInt(256);
      double opacity = 0.5;
      //
      double left;
      double right;
      if (len == 1) {
        left = 0;
        right = 0;
      } else if (len == max) {
        left = width / max * index;
        right = width / max * (max - index - 1);
      } else {
        int diff = max - len;
        print('title = ${element.title}, diff = $diff, index = $index -> ${index % diff}');
        left = width / max * index;
        right = width / max * (max - index - 1);
      }
      list.add(Positioned(
        child: Container(
          alignment: Alignment.centerLeft,
          child: Text(element.title, overflow: TextOverflow.ellipsis),
          color: Color.fromRGBO(r, g, b, opacity),
          padding: const EdgeInsets.only(left: 10),
          height: itemHeight * element.differenceInHours(),
        ),
        left: left,
        top: itemHeight / 2 + (h + m / 60) * itemHeight,
        right: right,
      ));
    });
    return list;
  }

  Widget _createCurrentDateTime() {
    DateTime dateTime = DateTime.now();
    var h = dateTime.hour;
    var m = dateTime.minute;
    return Positioned(
      child: Container(color: Colors.red, height: 2.5),
      left: 0,
      top: itemHeight / 2 + (h + m / 60) * itemHeight,
      right: 0,
    );
  }

  List<Widget> _createListView(double width) {
    List<Widget> list = [];
    list.addAll(_createDivider());
    list.addAll(_createEvent(width));
    list.add(_createCurrentDateTime());
    return list;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width - itemWidth;
    return SizedBox(
      child: Stack(children: _createListView(width)),
      width: double.infinity,
      height: itemHeight * 24,
    );
  }
}
