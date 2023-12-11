import 'dart:convert';

Kodepos kodeposFromJson(String str) => Kodepos.fromJson(json.decode(str));
String kodeposToJson(Kodepos data) => json.encode(data.toJson());

class Kodepos {
  Kodepos({
    required this.cKodepos,
  });
  String cKodepos;

  factory Kodepos.fromJson(Map<String, dynamic> json) => Kodepos(
    cKodepos: json["cKodepos"],
  );

  Map<String, dynamic> toJson() => {
    "cKodepos": cKodepos,
  };

  @override
  String toString() => cKodepos;

}