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
    return e.difference(sdt).inHours;
  }

  @override
  String toString() {
    return 'ScaleWrap{title: $title, sdt: $sdt, edt: $edt, index: $index}';
  }
}
