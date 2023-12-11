
class Rekening {
  List<DataRekening>? data;
  bool? error;
  dynamic message;

  Rekening({this.data, this.error, this.message});

  Rekening.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null ? null : (json["data"] as List).map((e) => DataRekening.fromJson(e)).toList();
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

class DataRekening {
  String? cAtasNama;
  String? cNamaBank;
  String? mRekening;

  DataRekening({this.cAtasNama, this.cNamaBank, this.mRekening});

  DataRekening.fromJson(Map<String, dynamic> json) {
    cAtasNama = json["cAtasNama"];
    cNamaBank = json["cNamaBank"];
    mRekening = json["mRekening"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["cAtasNama"] = cAtasNama;
    _data["cNamaBank"] = cNamaBank;
    _data["mRekening"] = mRekening;
    return _data;
  }
}