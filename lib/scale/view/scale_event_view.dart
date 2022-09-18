import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shard/scale/adapter/scale_adapter.dart';
import 'package:shard/show.dart';

class ScaleEventView extends StatelessWidget {
  final ScaleAdapter adapter;
  final double itemWidth;
  final double itemHeight;

  const ScaleEventView(this.adapter, this.itemWidth, this.itemHeight,
      {Key? key})
      : super(key: key);

  List<Widget> _createDivider() {
    return List.generate(25, (index) {
      return Positioned(
        child: InkWell(
          child: Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
            ),
            height: itemHeight,
          ),
          onTap: () {
            debugPrint('index = $index');
          },
        ),
        left: 0,
        top: itemHeight * index,
        right: 0,
      );
    });
  }

  List<Widget> _createEvent(BuildContext context, double width) {
    List<Widget> list = [];
    int max = adapter.max();
    debugPrint('max = $max');
    adapter.toList().forEach((element) {
      var sdt = element.getSdt;
      var h = sdt.hour;
      var m = sdt.minute;
      // var edt = element.getEdt;
      // var len = adapter.checked(sdt, edt);
      // debugPrint('element = $element -> len = $len');
      var index = element.index;
      var random = Random();
      var r = random.nextInt(256);
      var g = random.nextInt(256);
      var b = random.nextInt(256);
      double opacity = 0.5;
      // 事件
      list.add(Positioned(
        child: InkWell(
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(element.title, overflow: TextOverflow.ellipsis),
            color: Color.fromRGBO(r, g, b, opacity),
            padding: const EdgeInsets.only(left: 10),
            width: width / max,
            height: itemHeight * element.differenceInHours(),
          ),
          onTap: () {
            var route = MaterialPageRoute(builder: (_) => Show(element.title));
            Navigator.push(context, route);
          },
        ),
        left: width / max * index,
        top: itemHeight / 2 + (h + m / 60) * itemHeight + itemHeight / 2,
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
      top: itemHeight / 2 + (h + m / 60) * itemHeight + itemHeight / 2,
      right: 0,
    );
  }

  List<Widget> _createListView(BuildContext context, double width) {
    List<Widget> list = [];
    list.addAll(_createDivider());
    list.addAll(_createEvent(context, width));
    list.add(_createCurrentDateTime());
    return list;
  }

  @override
  Widget build(BuildContext context) {
    adapter.toMap().forEach((key, value) {
      // debugPrint('key = $key');
      // for (var element in value) {
      //   debugPrint('element = $element');
      // }
    });
    var width = MediaQuery.of(context).size.width - itemWidth;
    return SizedBox(
      child: Stack(children: _createListView(context, width)),
      width: double.infinity,
      height: itemHeight * 24 + itemHeight,
    );
  }
}
