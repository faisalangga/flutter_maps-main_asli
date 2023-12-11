import 'dart:convert';


Desa desaFromJson(String str) => Desa.fromJson(json.decode(str));
String desaToJson(Desa data) => json.encode(data.toJson());

class Desa {
  Desa({
    required this.cDesa,
  });
  String cDesa;

  factory Desa.fromJson(Map<String, dynamic> json) => Desa(
    cDesa: json["cDesa"],
  );

  Map<String, dynamic> toJson() => {
    "cDesa": cDesa,
  };

  @override
  String toString() => cDesa;

}