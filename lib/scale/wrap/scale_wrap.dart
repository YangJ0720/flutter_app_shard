import 'package:flutter/material.dart';
import 'package:shard/scale/adapter/scale_adapter.dart';

class ScaleWrap {
  String title;
  DateTime sdt;
  DateTime? edt;
  int index;
  double width;

  ScaleWrap(this.title, this.sdt, this.edt, {this.index = 0, this.width = 0});

  DateTime get getSdt => sdt;

  DateTime getEdt() {
    var sHour = sdt.hour;
    var sMinute = sdt.minute;
    var e = edt;
    if (e == null) {
      if (sHour == 23 && sMinute >= 30) {
        return DateTime(sdt.year, sdt.month, sdt.day, sHour, 59);
      } else {
        return sdt.add(const Duration(minutes: 30));
      }
    } else {
      if (sHour > e.hour) {
        return DateTime(sdt.year, sdt.month, sdt.day, 23, 59);
      }
      return e;
    }
  }

  bool checkAnHour() {
    var sHour = sdt.hour;
    var edt = getEdt();
    var dateTime = edt.add(const Duration(hours: -1));
    var eMinute = edt.minute;
    return sHour == dateTime.hour && eMinute == 0;
  }

  double widthPixels(ScaleAdapter adapter, double width) {
    var map = adapter.toMap();
    var key = sdt.hour;
    var value = map[key] ?? [];
    // 判断这个时段是否没有跨时段事件
    var isAnHour = true;
    // 判断这个时段非跨时段事件的数量
    var isAnHourCount = 0;
    // 判断这个时段的空隙数量
    var isNullCount = 0;
    //
    int diff = adapter.checkedMultipleCount(value.length, getSdt.hour, getEdt().hour, index);
    debugPrint('--->>> title = $title, index = $index, diff = $diff');
    var isMultipleHourCount = adapter.checkedMultipleCount(value.length, getSdt.hour, getEdt().hour, 0);
    var len = value.length;
    for (int i = 0; i < len; i++) {
      var item = value[i];
      if (item == null) {
        isNullCount++;
      } else {
        var sdt = item.getSdt;
        var sHour = sdt.hour;
        var edt = item.getEdt();
        var eHour = edt.hour;
        var eMinute = edt.minute;
        var dateTime = edt.add(const Duration(hours: -1));
        if (sHour == eHour || (sHour == dateTime.hour && eMinute == 0)) {
          // 非跨时段事件数量自增
          isAnHourCount++;
        } else {
          // 发现有跨时段事件
          isAnHour = false;
        }
      }
    }
    //
    if (diff + index == len) {
      var w = width / len;
      this.width = w;
      return w;
    } else {
      var w = width / len + width * ((len - diff - index) / len / (diff + index - 1));
      this.width = w;
      return w;
    }
    //
    // 如果这个事件是非跨时段事件，并且这个事件之后存在空隙，那么这个事件将占满剩余的宽度
    if (isAnHour) {
      // 如果这个时段只有一个事件，并且属于非跨时段事件，那么这个事件需要占满一行
      if (len - 1 == isNullCount) return width;
      // 如果这个时段的所有事件都是非跨时段事件，那么这些事件将平分一整行的宽度
      return width / isAnHourCount;
    } else {
      return width / isMultipleHourCount;
    }
  }

  double heightPixels(double itemHeight) {
    var e = getEdt();
    // if (e == null) return itemHeight * 0.5;
    var s = sdt;
    var sHour = s.hour + s.minute / 60;
    var eHour = e.hour + e.minute / 60;
    return itemHeight * (eHour - sHour);
  }

  double leftPixels(ScaleAdapter adapter, double width) {
    var map = adapter.toMap();
    var key = sdt.hour;
    var value = map[key] ?? [];
    var len = value.length;
    int diff = adapter.checkedMultipleCount(len, getSdt.hour, getEdt().hour, index);
    //
    double left;
    if (diff + index == len) {
      left = width / len * index;
    } else {
      width / len / (len - diff - index);
      // print('--->>> title = $title, v = $v');
      left = width / len * index;
    }
    return left;
  }

  String toJson() {
    return 'ScaleWrap{title: $title, sdt: $sdt, edt: $edt, index: $index}';
  }

  @override
  String toString() {
    return title;
  }
}
