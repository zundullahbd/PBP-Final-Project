class Matkul {
  int id;
  String nama = "";
  String hari = "";
  String pukulMulai = "";
  String pukulSelesai = "";

  Matkul ({
    required this.id,
    required this.nama,
    required this.hari,
    required this.pukulMulai,
    required this.pukulSelesai,
  });

  factory Matkul.fromJson(Map<String, dynamic> json) {
    return Matkul(
      id: json['id'],
      nama: json['name'],
      hari: json['day'],
      pukulMulai: json['start_time'],
      pukulSelesai: json['end_time'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.nama;
    data['day'] = this.hari;
    data['start_time'] = this.pukulMulai;
    data['end_time'] = this.pukulSelesai;
    return data;
  }
}