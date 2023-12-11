import 'dart:convert';

Kecamatan kecamatanFromJson(String str) => Kecamatan.fromJson(json.decode(str));
String kecamatanToJson(Kecamatan data) => json.encode(data.toJson());

class Kecamatan {
  Kecamatan({
    required this.cKecamatan,
  });
  String cKecamatan;

  factory Kecamatan.fromJson(Map<String, dynamic> json) => Kecamatan(
    cKecamatan: json["cKecamatan"],
  );

  Map<String, dynamic> toJson() => {
    "cKecamatan": cKecamatan,
  };

  @override
  String toString() => cKecamatan;

}

Kecamatan2 kecamatan2FromJson(String str) => Kecamatan2.fromJson(json.decode(str));
String kecamatan2ToJson(Kecamatan data) => json.encode(data.toJson());

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