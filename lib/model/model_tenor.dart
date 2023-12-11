class cektenor {
  List<Tenor>? data;
  bool? error;
  Null? message;

  cektenor({this.data, this.error, this.message});

  cektenor.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Tenor>[];
      json['data'].forEach((v) {
        data!.add(new Tenor.fromJson(v));
      });
    }
    error = json['error'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    data['message'] = this.message;
    return data;
  }
}

class Tenor {
  String? bulan;
  String? cBranch;
  String? nbiayajasa;
  String? mbiayaadmin;

  Tenor({this.bulan, this.cBranch, this.nbiayajasa, this.mbiayaadmin});

  Tenor.fromJson(Map<String, dynamic> json) {
    bulan = json['bulan'];
    cBranch = json['cBranch'];
    nbiayajasa = json['nbiayajasa'];
    mbiayaadmin = json['mbiayaadmin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bulan'] = this.bulan;
    data['cBranch'] = this.cBranch;
    data['nbiayajasa'] = this.nbiayajasa;
    data['mbiayaadmin'] = this.mbiayaadmin;
    return data;
  }
}