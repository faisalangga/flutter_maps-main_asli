import 'dart:convert';

Kodepos2 kodepos2FromJson(String str) => Kodepos2.fromJson(json.decode(str));
String kodepos2ToJson(Kodepos2 data2) => json.encode(data2.toJson());

class Kodepos2 {
  Kodepos2({
    required this.cKodepos,
  });
  String cKodepos;

  factory Kodepos2.fromJson(Map<String, dynamic> json) => Kodepos2(
    cKodepos: json["cKodepos"],
  );

  Map<String, dynamic> toJson() => {
    "cKodepos": cKodepos,
  };

  @override
  String toString() => cKodepos;

}