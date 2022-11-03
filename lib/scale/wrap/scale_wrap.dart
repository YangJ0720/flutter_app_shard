class ScaleWrap {
  String title;
  DateTime sdt;
  DateTime? edt;
  int index;

  ScaleWrap(this.title, this.sdt, this.edt, {this.index = 0});

  DateTime get getSdt => sdt;

  DateTime get getEdt => edt ?? sdt.add(const Duration(hours: 1));

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
    if (e == null) return 1;
    var hours = ((e.hour * 60 + e.minute) - (sdt.hour * 60 + sdt.minute)) / 60;
    if (hours < 1) {
      hours = 1;
    }
    return hours;
  }

  @override
  String toString() {
    return 'ScaleWrap{title: $title, sdt: $sdt, edt: $edt, index: $index}';
  }
}
