import 'dart:convert';


Username usernameFromJson(String str) => Username.fromJson(json.decode(str));
String usernameToJson(Username data) => json.encode(data.toJson());

class Username {
  Username({
    required this.cusername,
  });
  String cusername;

  factory Username.fromJson(Map<String, dynamic> json) => Username(
    cusername: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "cusername": cusername,
  };

  @override
  String toString() => cusername;

}