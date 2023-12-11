
class LandingpageModel {
  List<Data>? data;
  String? pesan;
  String? status;

  LandingpageModel({this.data, this.pesan, this.status});

  LandingpageModel.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
    pesan = json["pesan"];
    status = json["status"];
  }

  static List<LandingpageModel> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => LandingpageModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    _data["pesan"] = pesan;
    _data["status"] = status;
    return _data;
  }
}

class Data {
  String? saldopinj;
  String? saldosimp;

  Data({this.saldopinj, this.saldosimp});

  Data.fromJson(Map<String, dynamic> json) {
    saldopinj = json["saldopinj"];
    saldosimp = json["saldosimp"];
  }

  static List<Data> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => Data.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["saldopinj"] = saldopinj;
    _data["saldosimp"] = saldosimp;
    return _data;
  }
}