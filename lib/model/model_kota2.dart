import 'dart:convert';


Kota2 kotaFromJson(String str) => Kota2.fromJson(json.decode(str));
String kota2ToJson(Kota2 data2) => json.encode(data2.toJson());

class Kota2 {
  Kota2({
    required this.cKota,
  });
  String cKota;

  factory Kota2.fromJson(Map<String, dynamic> json) => Kota2(
    cKota: json["cKota"],
  );

  Map<String, dynamic> toJson() => {
    "cKota": cKota,
  };

  @override
  String toString() => cKota;

}