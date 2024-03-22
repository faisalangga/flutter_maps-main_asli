class ModelSearchPinjaman {
  List<DataView>? data;
  bool? error;
  dynamic message;

  ModelSearchPinjaman({this.data, this.error, this.message});

  ModelSearchPinjaman.fromJson(Map<String, dynamic> json) {
    data = json["data"] == null
        ? null
        : (json["data"] as List).map((e) => DataView.fromJson(e)).toList();
    error = json["error"];
    message = json["message"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    _data["error"] = error;
    _data["message"] = message;
    return _data;
  }
}

class DataView {
  String? angsuran;
  String? cBranch;
  String? cDocno;
  String? cStatus;
  String? cdocno;
  String? cjaminan;
  String? cnote;
  String? jasa;
  String? mBadmin;
  String? mNilaiPinjaman;
  String? mPokok;
  String? mSisa1;
  String? mSisa2;
  String? mValue1;
  String? mValue2;
  String? nJasaPinjaman;
  String? pinjaman;
  String? tenor;
  String? tgl;
  String? duedate;

  DataView(
      {this.angsuran,
      this.cBranch,
      this.cDocno,
      this.cStatus,
      this.cdocno,
      this.cjaminan,
      this.cnote,
      this.jasa,
      this.mBadmin,
      this.mNilaiPinjaman,
      this.mPokok,
      this.mSisa1,
      this.mSisa2,
      this.mValue1,
      this.mValue2,
      this.nJasaPinjaman,
      this.pinjaman,
      this.tenor,
      this.tgl, this.duedate});

  DataView.fromJson(Map<String, dynamic> json) {
    angsuran = json["angsuran"];
    cBranch = json["cBranch"];
    cDocno = json["cDocno"];
    cStatus = json["cStatus"];
    cdocno = json["cdocno"];
    cjaminan = json["cjaminan"];
    cnote = json["cnote"];
    jasa = json["jasa"];
    mBadmin = json["mBadmin"];
    mNilaiPinjaman = json["mNilaiPinjaman"];
    mPokok = json["mPokok"];
    mSisa1 = json["mSisa1"];
    mSisa2 = json["mSisa2"];
    mValue1 = json["mValue1"];
    mValue2 = json["mValue2"];
    nJasaPinjaman = json["nJasaPinjaman"];
    pinjaman = json["pinjaman"];
    tenor = json["tenor"];
    tgl = json["tgl"];
    duedate = json["duedate"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["angsuran"] = angsuran;
    _data["cBranch"] = cBranch;
    _data["cDocno"] = cDocno;
    _data["cStatus"] = cStatus;
    _data["cdocno"] = cdocno;
    _data["cjaminan"] = cjaminan;
    _data["cnote"] = cnote;
    _data["jasa"] = jasa;
    _data["mBadmin"] = mBadmin;
    _data["mNilaiPinjaman"] = mNilaiPinjaman;
    _data["mPokok"] = mPokok;
    _data["mSisa1"] = mSisa1;
    _data["mSisa2"] = mSisa2;
    _data["mValue1"] = mValue1;
    _data["mValue2"] = mValue2;
    _data["nJasaPinjaman"] = nJasaPinjaman;
    _data["pinjaman"] = pinjaman;
    _data["tenor"] = tenor;
    _data["tgl"] = tgl;
    _data["duedate"] = duedate;
    return _data;
  }
}
