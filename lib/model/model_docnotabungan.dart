
class DocnoTabModel {
  bool? error;
  dynamic message;
  String? pesan;
  String? status;

  DocnoTabModel({this.error, this.message, this.pesan, this.status});

  DocnoTabModel.fromJson(Map<String, dynamic> json) {
    error = json["error"];
    message = json["message"];
    pesan = json["pesan"];
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["error"] = error;
    _data["message"] = message;
    _data["pesan"] = pesan;
    _data["status"] = status;
    return _data;
  }
}