import 'dart:convert';

Kecamatan2 kecamatan2FromJson(String str) => Kecamatan2.fromJson(json.decode(str));
String kecamatan2oJson(Kecamatan2 data2) => json.encode(data2.toJson());

class Kecamatan2 {
  Kecamatan2({
    required this.cKecamatan,
  });
  String cKecamatan;

  factory Kecamatan2.fromJson(Map<String, dynamic> json) => Kecamatan2(
    cKecamatan: json["cKecamatan"],
  );

  Map<String, dynamic> toJson() => {
    "cKecamatan": cKecamatan,
  };

  @override
  String toString() => cKecamatan;

}