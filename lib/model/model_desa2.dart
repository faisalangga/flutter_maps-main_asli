import 'dart:convert';


Desa2 desa2FromJson(String str) => Desa2.fromJson(json.decode(str));
String desa2ToJson(Desa2 data2) => json.encode(data2.toJson());

class Desa2 {
  Desa2({
    required this.cDesa,
  });
  String cDesa;

  factory Desa2.fromJson(Map<String, dynamic> json) => Desa2(
    cDesa: json["cDesa"],
  );

  Map<String, dynamic> toJson() => {
    "cDesa": cDesa,
  };

  @override
  String toString() => cDesa;

}