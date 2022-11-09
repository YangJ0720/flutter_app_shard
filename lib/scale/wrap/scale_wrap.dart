import 'package:shard/scale/adapter/scale_adapter.dart';

class ScaleWrap {
  String title;
  DateTime sdt;
  DateTime? edt;
  int index;

  ScaleWrap(this.title, this.sdt, this.edt, {this.index = 0});

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

  bool isAnHour(ScaleAdapter adapter) {
    var map = adapter.toMap();
    var key = sdt.hour;
    var value = map[key] ?? [];
    var len = value.length;
    var isAnHour = true;
    for (int i = 0; i < len; i++) {
      var item = value[i];
      if (item == null) continue;
      if (item.getEdt().difference(item.getSdt).inMinutes > 60) {
        isAnHour = false;
        break;
      }
    }
    return isAnHour;
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
    var isAfterNullCount = 0;
    var len = value.length;
    for (int i = 0; i < len; i++) {
      var item = value[i];
      if (item == null) {
        isNullCount++;
        if (index < i) {
          isAfterNullCount++;
        }
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
    // 如果这个事件是非跨时段事件，并且这个事件之后存在空隙，那么这个事件将占满剩余的宽度
    if (isAnHour) {
      // 如果这个时段只有一个事件，并且属于非跨时段事件，那么这个事件需要占满一行
      if (len - 1 == isNullCount) return width;
      // 如果这个时段的所有事件都是非跨时段事件，那么这些事件将平分一整行的宽度
      return width / isAnHourCount;
    }
    // else if (isAfterNullCount > 1 && getEdt().difference(getSdt).inMinutes <= 60 && len - 1 == index + isAfterNullCount) {
    //   // 如果这个事件是该时段最后一个非跨时段事件，并且这个事件之后存在空隙，那么这个事件将占满剩余的宽度
    //   return width / len * (isAfterNullCount + 1);
    // }
    else if (isAfterNullCount > 0 && len - 1 == index + isAfterNullCount) {
      // 如果这个事件是该时段最后一个事件，并且这个事件之后存在空隙，那么这个事件将占满剩余的宽度
      var sHour = sdt.hour;
      var edt = getEdt();
      var eHour = edt.hour;
      var eMinute = edt.minute;
      var dateTime = edt.add(const Duration(hours: -1));
      if (sHour == eHour || (sHour == dateTime.hour && eMinute == 0)) {
        // 非跨时段事件数量自增
        return width / len * (isAfterNullCount + 1);
      } else {
        // 发现有跨时段事件
        
      }
    }
    //
    return width / len;
  }

  double heightPixels(double itemHeight) {
    var e = getEdt();
    // if (e == null) return itemHeight * 0.5;
    var s = sdt;
    var sHour = s.hour + s.minute / 60;
    var eHour = e.hour + e.minute / 60;
    return itemHeight * (eHour - sHour);
  }

  String toJson() {
    return 'ScaleWrap{title: $title, sdt: $sdt, edt: $edt, index: $index}';
  }

  @override
  String toString() {
    return title;
  }
}
