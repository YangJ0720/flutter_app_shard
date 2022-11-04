import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shard/scale/adapter/scale_adapter.dart';
import 'package:shard/scale/view/scale_event_view.dart';
import 'package:shard/scale/view/scale_hour_view.dart';
import 'package:shard/scale/wrap/scale_wrap.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final double _itemWidth = 60;
  final double _itemHeight = 50;
  final ScrollController _scrollController = ScrollController();
  final StreamController<ScaleAdapter> _controller = StreamController();

  void _jumpTo() {
    DateTime dateTime = DateTime.now();
    int hour = dateTime.hour;
    hour = 7;
    _scrollController.animateTo(
      hour * _itemHeight,
      duration: const Duration(milliseconds: 100),
      curve: Curves.ease,
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      //
      _jumpTo();
      //
      ScaleAdapter adapter = ScaleAdapter(_itemHeight);
      adapter.initialize();
      // adapter.add(ScaleWrap('起床', DateTime(2022, 8, 30, 6), null));
      // //
      // adapter.add(ScaleWrap(
      //   '吃早餐1',
      //   DateTime(2022, 8, 30, 8),
      //   DateTime(2022, 8, 30, 20),
      // ));
      // adapter.add(ScaleWrap('吃早餐2', DateTime(2022, 8, 30, 8), null));
      // adapter.add(ScaleWrap('吃早餐3', DateTime(2022, 8, 30, 8, 10), null));
      // //
      // adapter.add(ScaleWrap(
      //   '去上班1',
      //   DateTime(2022, 8, 30, 10),
      //   DateTime(2022, 8, 30, 12),
      // ));
      // adapter.add(ScaleWrap('去上班2', DateTime(2022, 8, 30, 10), null));
      // adapter.add(ScaleWrap('去上班3', DateTime(2022, 8, 30, 10, 10), null));
      // adapter.add(ScaleWrap('去上班4', DateTime(2022, 8, 30, 10, 20), null));
      // adapter.add(ScaleWrap('去上班5', DateTime(2022, 8, 30, 10, 30), null));
      // //
      // adapter.add(ScaleWrap('喝咖啡1', DateTime(2022, 8, 30, 11), null));
      // adapter.add(ScaleWrap('喝咖啡2', DateTime(2022, 8, 30, 11), null));
      // adapter.add(ScaleWrap('喝咖啡3', DateTime(2022, 8, 30, 11, 30), null));
      //
      // adapter.add(ScaleWrap('吃午餐1', DateTime(2022, 8, 30, 12), null));
      // adapter.add(ScaleWrap(
      //   '吃午餐2',
      //   DateTime(2022, 8, 30, 12, 30),
      //   DateTime(2022, 8, 30, 14, 30),
      // ));
      // adapter.add(ScaleWrap('吃午餐3', DateTime(2022, 8, 30, 12, 30), null));
      // //
      // adapter.add(ScaleWrap('喝奶茶1', DateTime(2022, 8, 30, 15), null));
      // adapter.add(ScaleWrap('喝奶茶2', DateTime(2022, 8, 30, 15, 20), null));
      // //
      // adapter.add(ScaleWrap('下午茶1', DateTime(2022, 8, 30, 16), null));
      // adapter.add(ScaleWrap('下午茶2', DateTime(2022, 8, 30, 16, 5), null));
      // //
      // adapter.add(ScaleWrap('去打架', DateTime(2022, 8, 30, 18), null));
      //
      // adapter.add(ScaleWrap('去洗澡1', DateTime(2022, 8, 30, 22), null));
      // adapter.add(ScaleWrap('去洗澡2', DateTime(2022, 8, 30, 22, 10), null));
      // adapter.add(ScaleWrap('去洗澡3', DateTime(2022, 8, 30, 22, 20), null));
      //
      // adapter.add(ScaleWrap('去睡觉1', DateTime(2022, 8, 30, 23), null));
      //
      adapter.add(ScaleWrap('0800', DateTime(2022, 1, 1, 08, 00), null));
      adapter.add(ScaleWrap('1000', DateTime(2022, 1, 1, 10, 00), DateTime(2022, 1, 1, 16, 00)));
      adapter.add(ScaleWrap('1030', DateTime(2022, 1, 1, 10, 30), null));
      adapter.add(ScaleWrap('1040', DateTime(2022, 1, 1, 10, 40), DateTime(2022, 1, 1, 16, 40)));
      adapter.add(ScaleWrap('1100', DateTime(2022, 1, 1, 11, 00), null));
      adapter.add(ScaleWrap('1100', DateTime(2022, 1, 1, 11, 00), null));
      adapter.add(ScaleWrap('1105', DateTime(2022, 1, 1, 11, 05), null));
      adapter.add(ScaleWrap('1150', DateTime(2022, 1, 1, 11, 50), null));
      adapter.add(ScaleWrap('1200', DateTime(2022, 1, 1, 12, 00), null));
      adapter.add(ScaleWrap('1200', DateTime(2022, 1, 1, 12, 00), DateTime(2022, 1, 1, 16, 50)));
      adapter.add(ScaleWrap('1400', DateTime(2022, 1, 1, 14, 00), null));
      // adapter.add(ScaleWrap('18:00', DateTime(2022, 8, 30, 18), DateTime(2022, 8, 30, 19)));
      // adapter.add(ScaleWrap('6', DateTime(2022, 8, 30, 18), DateTime(2022, 8, 30, 19)));
      // adapter.add(ScaleWrap('6', DateTime(2022, 8, 30, 18, 1), DateTime(2022, 8, 30, 20, 1)));
      // adapter.add(ScaleWrap('6', DateTime(2022, 8, 30, 18, 2), DateTime(2022, 8, 30, 20, 2)));
      // adapter.add(ScaleWrap('6', DateTime(2022, 8, 30, 18, 3), DateTime(2022, 8, 30, 20, 3)));
      // adapter.add(ScaleWrap('6', DateTime(2022, 8, 30, 18, 10), DateTime(2022, 8, 30, 20, 10)));
      // adapter.add(ScaleWrap('6', DateTime(2022, 8, 30, 18, 15), DateTime(2022, 8, 30, 20, 15)));
      _controller.add(adapter);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double maxHeight = 100;
    return Scaffold(
      appBar: AppBar(
        title: Text(DateTime.now().toIso8601String()),
        actions: [
          IconButton(
            onPressed: () => _jumpTo(),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: const Text('全天'),
                    color: Colors.yellow,
                    constraints: BoxConstraints(
                      minHeight: _itemHeight,
                      maxHeight: maxHeight,
                    ),
                    width: _itemWidth,
                  ),
                  Container(color: Colors.grey, width: 1),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: const [
                          Text('data'),
                        ],
                      ),
                    ),
                  ),
                  Container(color: Colors.grey, width: 1),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(children: const []),
                    ),
                  ),
                  Container(color: Colors.grey, width: 1),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: const [],
                      ),
                    ),
                  ),
                  Container(color: Colors.grey, width: 1),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: const [],
                      ),
                    ),
                  ),
                  Container(color: Colors.grey, width: 1),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: const [],
                      ),
                    ),
                  ),
                  Container(color: Colors.grey, width: 1),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: const [],
                      ),
                    ),
                  ),
                  Container(color: Colors.grey, width: 1),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: const [],
                      ),
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            ),
            constraints: BoxConstraints(maxHeight: maxHeight),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 1),
              )
            ),
          ),
          Expanded(child: SingleChildScrollView(
            child: Row(
              children: [
                ScaleHourView(_itemWidth, _itemHeight),
                Expanded(
                  child: StreamBuilder<ScaleAdapter>(
                    builder: (_, snapshot) {
                      var adapter = snapshot.requireData;
                      return ScaleEventView(adapter, _itemWidth, _itemHeight);
                    },
                    stream: _controller.stream,
                    initialData: ScaleAdapter(_itemHeight),
                  ),
                )
              ],
            ),
            controller: _scrollController,
          )),
        ],
      ),
    );
  }
}
