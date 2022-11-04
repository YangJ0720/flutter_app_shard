import 'dart:collection';
import 'dart:math';

import 'package:shard/scale/wrap/scale_wrap.dart';

class ScaleAdapter {
  final double itemHeight;
  final List<ScaleWrap> _list = [];
  final LinkedHashMap<int, List<ScaleWrap?>> _hashMap = LinkedHashMap();

  ScaleAdapter(this.itemHeight);

  void initialize() {
    for (int i = 0; i < 24; i++) {
      _hashMap[i] = [];
    }
  }

  void add(ScaleWrap scaleWrap) {
    DateTime sdt = scaleWrap.getSdt;
    DateTime edt = scaleWrap.getEdt;
    //
    var sHour = sdt.hour;
    var eHour = edt.hour;
    //
    var value = _hashMap[sHour];
    if (value == null || value.isEmpty) {
      // 如果是第一个事件，就可以直接添加
      if (sHour == eHour) {
        _hashMap.forEach((key, value) {
          if (sHour == key) {
            _hashMap[key] = [scaleWrap];
          } else {
            _hashMap[key]?.add(null);
          }
        });
      } else {
        for (int i = 0; i < 24; i++) {
          if (sHour <= i && i <= eHour) {
            var value = _hashMap[i];
            if (value == null || value.isEmpty) {
              _hashMap[i] = [scaleWrap];
            } else {
              var length = value.length;
              scaleWrap.index = length;
              value.add(scaleWrap);
            }
          } else {
            _hashMap[i]?.add(null);
          }
        }
      }
      _list.add(scaleWrap);
      return;
    }
    //
    if (sHour == eHour) {
      // 不是第一个事件，需要对这个时段的事件集合进行遍历，查看是否满足插入条件
      var index = value.indexWhere((element) => element == null);
      if (index >= 0) {
        // 找到空隙，直接插入空隙
        value.removeAt(index);
        scaleWrap.index = index;
        value.insert(index, scaleWrap);
      } else {
        // 没有找到空隙，插入集合末尾
        _hashMap.forEach((k, v) {
          if (k == sHour) {
            var value = _hashMap[k];
            if (value == null) {
              _hashMap[k] = [scaleWrap];
            } else {
              scaleWrap.index = value.length;
              value.add(scaleWrap);
            }
          } else {
            _hashMap[k]?.add(null);
          }
        });
      }
    } else {
      var index = value.indexWhere((element) => element == null);
      if (index >= 0) {
        // 找到空隙，直接插入空隙
        for (int i = sHour; i <= eHour; i++) {
          var value = _hashMap[i];
          if (value == null || value.isEmpty) {
            _hashMap[i] = [scaleWrap];
          } else {
            value.removeAt(index);
            scaleWrap.index = index;
            value.insert(index, scaleWrap);
          }
        }
      } else {
        // 没有找到空隙，只能在所有集合增加一列，并插入集合末尾
        for (int i = 0; i < 24; i++) {
          if (sHour <= i && i <= eHour) {
            var value = _hashMap[i];
            if (value == null || value.isEmpty) {
              _hashMap[i] = [scaleWrap];
            } else {
              var length = value.length;
              scaleWrap.index = length;
              value.add(scaleWrap);
            }
          } else {
            _hashMap[i]?.add(null);
          }
        }
      }
    }
    //
    _list.add(scaleWrap);
  }

  int length(int key) {
    List<ScaleWrap?>? list = _hashMap[key];
    if (list == null) return 0;
    return list.where((element) => element != null).length;
  }

  int checked(DateTime sdt, DateTime edt) {
    var hour = sdt.hour - 1;
    int hours = edt.difference(sdt).inHours + 1;
    int max = 1;
    for (int i = 0; i <= hours; i++) {
      var key = hour + i;
      List<ScaleWrap?>? value = _hashMap[key];
      if (value == null) continue;
      var length = value.length;
      if (max < length) {
        max = length;
      }
    }
    return max;
  }

  int max(int hour) {
    int prevMax = _hashMap[hour - 1]?.length ?? 1;
    int max = 1;
    var values = _hashMap.values;
    for (var element in values) {
      var length = element.length;
      if (max < length) {
        max = length;
      }
    }
    return max;
  }

  List<ScaleWrap> toList() => _list;

  LinkedHashMap<int, List<ScaleWrap?>> toMap() => _hashMap;
}