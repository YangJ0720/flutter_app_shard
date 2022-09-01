import 'dart:collection';

import 'package:shard/scale/wrap/scale_wrap.dart';

class ScaleAdapter {
  final double itemHeight;
  final List<ScaleWrap> _list = [];
  final LinkedHashMap<String, int> _map = LinkedHashMap();

  ScaleAdapter(this.itemHeight);

  void add(ScaleWrap scaleWrap) {
    DateTime sdt = scaleWrap.getSdt;
    DateTime edt = scaleWrap.getEdt;
    //
    record(sdt, edt);
    //
    var len = _list.length;
    if (len >= 1) {
      for (int i = len - 1; i >= 0; i--) {
        var item = _list[i];
        var s = item.getSdt;
        var e = item.getEdt;
        // print('sdt = $sdt, s = $s');
        // print('sdt.compareTo(s) = ${sdt.compareTo(s)}');
        if (sdt.compareTo(s) >= 0 && sdt.compareTo(e) <= 0) {
          if (convertToKey(sdt.hour) == convertToKey(s.hour)) {
            if (sdt.compareTo(s) <= 0 && edt.compareTo(e) >= 0 && scaleWrap.differenceInHours() > item.differenceInHours()) {
              scaleWrap.index = item.index;
              item.index++;
            } else {
              scaleWrap.index = item.index + 1;
              break;
            }
          } else {
            scaleWrap.index = checked(sdt, edt) - 1;
            break;
          }
        }
      }
    }
    _list.add(scaleWrap);
  }

  void record(DateTime sdt, DateTime? edt) {
    int hour = sdt.hour;
    if (edt == null) {
      var key = convertToKey(hour);
      int? value = _map[key];
      if (value == null) {
        _map[key] = 1;
      } else {
        _map[key] = value + 1;
      }
    } else {
      int hours = edt.difference(sdt).inHours;
      for (int i = 0; i < hours; i++) {
        var key = convertToKey(hour + i);
        int? value = _map[key];
        if (value == null) {
          _map[key] = 1;
        } else {
          _map[key] = value + 1;
        }
      }
    }
  }

  int checked(DateTime sdt, DateTime edt) {
    var hour = sdt.hour;
    int hours = edt.difference(sdt).inHours;
    int max = 1;
    for (int i = 0; i < hours; i++) {
      var key = convertToKey(hour + i);
      int? value = _map[key];
      if (value == null) continue;
      if (max < value) {
        max = value;
      }
    }
    return max;
  }

  int max() {
    int max = 1;
    var values = _map.values;
    for (var element in values) {
      if (max < element) {
        max = element;
      }
    }
    return max;
  }

  String convertToKey(int hour) {
    return '$hour:00 - ${hour + 1}:00';
  }

  List<ScaleWrap> toList() => _list;

  void mapToString() {
    _map.forEach((key, value) {
      // print('key = $key, value = $value');
    });
  }
}