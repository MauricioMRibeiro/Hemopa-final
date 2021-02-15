class Checkin {
  final int idCheckin;
  bool check;

  Checkin({
    this.idCheckin,
    this.check,
  });

  factory Checkin.fromJson(Map<String, dynamic> json) {
    return Checkin(idCheckin: json['idCheckin'], check: json['check']);
  }
}
