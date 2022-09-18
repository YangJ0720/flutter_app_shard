import 'dart:collection';

import 'package:shard/scale/wrap/scale_wrap.dart';

class ScaleAdapter {
  final double itemHeight;
  final List<ScaleWrap> _list = [];
  final LinkedHashMap<int, List<ScaleWrap?>> _hashMap = LinkedHashMap();

  ScaleAdapter(this.itemHeight);

  void add(ScaleWrap scaleWrap) {
    DateTime sdt = scaleWrap.getSdt;
    //
    var hour = sdt.hour;
    var prevKey = hour - 1;
    List<ScaleWrap?>? prevValue = _hashMap[prevKey];
    var currentKey = hour;
    List<ScaleWrap?>? currentValue = _hashMap[currentKey];
    if (prevValue == null) {
      if (currentValue == null) {
        scaleWrap.index = 0;
        _put(currentKey, scaleWrap);
      } else {
        scaleWrap.index = _length(currentValue);
        _put(currentKey, scaleWrap);
      }
    } else {
      int prevLen = prevValue.length;
      int currentLen = _length(currentValue);
      if (prevLen <= currentLen) {
        if (currentValue == null) {
          scaleWrap.index = 0;
          _put(currentKey, scaleWrap);
        } else {
          scaleWrap.index = _length(currentValue);
          _put(currentKey, scaleWrap);
        }
      } else {
        bool isFind = false;
        for (int i = currentLen; i < prevLen; i++) {
          ScaleWrap? item = prevValue[i];
          if (item == null || sdt.compareTo(item.getEdt) >= 0) {
            if (currentValue == null) {
              scaleWrap.index = 0;
              _put(currentKey, scaleWrap);
            } else {
              scaleWrap.index = i;
              _put(currentKey, scaleWrap);
            }
            isFind = true;
            break;
          } else {
            if (currentValue == null) {
              scaleWrap.index = 0;
              _hashMap[currentKey] = [null];
            } else {
              scaleWrap.index = prevValue.length;
              currentValue.add(null);
            }
          }
        }
        if (!isFind) {
          _put(currentKey, scaleWrap);
        }
      }
    }
    //
    _list.add(scaleWrap);
  }

  void _put(int key, ScaleWrap value) {
    int hour = value.getSdt.hour;
    int diff = value.differenceInHours();
    if (diff > 1) {
      for (int i = 0; i < diff; i++) {
        int key = hour + i;
        List<ScaleWrap?>? list = _hashMap[key];
        if (list == null) {
          _hashMap[key] = [value];
        } else {
          list.add(value);
        }
      }
    } else {
      List<ScaleWrap?>? list = _hashMap[key];
      if (list == null) {
        _hashMap[key] = [value];
      } else {
        int index = value.index;
        if (list.length - 1 > index && list[index] == null) {
          list.removeAt(index);
          list.insert(index, value);
        } else {
          list.add(value);
        }
      }
    }
  }

  int _length(List<ScaleWrap?>? list) {
    if (list == null) return 0;
    return list.where((element) => element != null).length;
  }

  int length(int key) {
    List<ScaleWrap?>? list = _hashMap[key];
    if (list == null) return 0;
    return list.where((element) => element != null).length;
  }

  int checked(DateTime sdt, DateTime edt) {
    var hour = sdt.hour;
    int hours = edt.difference(sdt).inHours;
    int max = 1;
    for (int i = 0; i < hours; i++) {
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

  int max() {
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