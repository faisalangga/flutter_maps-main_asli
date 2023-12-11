import 'dart:convert';


Kota kotaFromJson(String str) => Kota.fromJson(json.decode(str));
String kotaToJson(Kota data) => json.encode(data.toJson());

class Kota {
  Kota({
    required this.cKota,
  });
  String cKota;

  factory Kota.fromJson(Map<String, dynamic> json) => Kota(
    cKota: json["cKota"],
  );

  Map<String, dynamic> toJson() => {
    "cKota": cKota,
  };

  @override
  String toString() => cKota;

}