
class ModelSetupBank {
  List<Data>? data;
  bool? error;
  dynamic message;

  ModelSetupBank({this.data, this.error, this.message});

  ModelSetupBank.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    error = json["error"];
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    _data["error"] = error;
    _data["message"] = message;
    return _data;
  }
}

class Data {
  String? ccode;
  String? cnamabank;
  String? mbiayaadmin;

  Data({this.ccode, this.cnamabank, this.mbiayaadmin});

  Data.fromJson(Map<String, dynamic> json) {
    ccode = json["ccode"];
    cnamabank = json["cnamabank"];
    mbiayaadmin = json["mbiayaadmin"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["ccode"] = ccode;
    _data["cnamabank"] = cnamabank;
    _data["mbiayaadmin"] = mbiayaadmin;
    return _data;
  }
}