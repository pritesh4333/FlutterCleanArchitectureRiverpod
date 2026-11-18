class GetSetIndex {
  String? label;
  int? id;
  int? underLyingIdS;
  int? volume;
  String? ltp;
  String change;
  String perChange;
  String? open;
  String? low;
  String? high;
  String? close;
  String? exch;
  String? segment;
  bool? selected;
  String? indicesList;

  GetSetIndex({
    this.label = '',
    this.id = 0,
    this.ltp = '0.00',
    this.change = '0.00',
    this.volume = 0,
    this.perChange = '0.00',
    this.open = '0.00',
    this.low = '0.00',
    this.close = '0.00',
    this.exch = '0.00',
    this.segment = '',
    this.selected = false,
    this.indicesList = "",
    this.underLyingIdS = 0,
  });

  factory GetSetIndex.fromJson(Map<String, dynamic> json) => GetSetIndex(
    label: json['label'],
    id: json['id'],
    underLyingIdS: json['underLyingIdS'],
    selected: json['selected'],
    exch: json['exch'],
    segment: json['segment'],
  );
}
