import 'dart:convert';

Provinsi2 provinsiFromJson(String str) => Provinsi2.fromJson(json.decode(str));
String provinsi2ToJson(Provinsi2 data2) => json.encode(data2.toJson());

class Provinsi2 {
  Provinsi2({
    required this.cPropinsi,
  });
  String cPropinsi;


  factory Provinsi2.fromJson(Map<String, dynamic> json) => Provinsi2(
    cPropinsi: json["cPropinsi"],
  );

  Map<String, dynamic> toJson() => {
    "cPropinsi": cPropinsi,
  };

  @override
  String toString() => cPropinsi;

}