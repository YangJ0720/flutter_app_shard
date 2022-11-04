import 'package:shard/scale/adapter/scale_adapter.dart';

class ScaleWrap {
  String title;
  DateTime sdt;
  DateTime? edt;
  int index;

  ScaleWrap(this.title, this.sdt, this.edt, {this.index = 0});

  DateTime get getSdt => sdt;

  DateTime get getEdt => edt ?? sdt.add(const Duration(minutes: 30));

  double widthPixels(ScaleAdapter adapter, double width) {
    var map = adapter.toMap();
    var key = sdt.hour;
    var value = map[key] ?? [];
    var isFull = true;
    var len = value.length;
    for (int i = 0; i < len; i++) {
      var item = value[i];
      if (index == i) continue;
      if (item != null) {
        isFull = false;
        break;
      }
    }
    if (isFull) return width;
    return width / len;
  }

  double heightPixels(double itemHeight) {
    var e = edt;
    if (e == null) return itemHeight * 0.5;
    var s = sdt;
    var sHour = s.hour + s.minute / 60;
    var eHour = e.hour + e.minute / 60;
    return itemHeight * (eHour - sHour);
  }

  int differenceInHours() {
    DateTime? e = edt;
    if (e == null) return 1;
    var hours = e.hour - sdt.hour;
    if (hours <= 0) {
      // if (e.minute > 0) {
      //   hours = 2;
      // } else {
      //   hours = 1;
      // }
      //
      hours = 1;
    }
    return hours;
  }

  double differenceInHoursToDouble() {
    DateTime? e = edt;
    if (e == null) return 0.5;
    var hours = ((e.hour * 60 + e.minute) - (sdt.hour * 60 + sdt.minute)) / 60;
    // if (hours < 1) {
    //   hours = 1;
    // }
    //
    if (hours < 0.5) {
      hours = 0.5;
    }
    //
    return hours;
  }

  String toJson() {
    return 'ScaleWrap{title: $title, sdt: $sdt, edt: $edt, index: $index}';
  }

  @override
  String toString() {
    return title;
  }
}
