class Cabang {
  bool? error;
  Null? message;
  List<Cabang>? data;
  int? statusCode;

  Cabang({this.error, this.message, this.data});

  Cabang.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Cabang>[];
      json['data'].forEach((v) {
        data!.add(new Cabang.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataCabang {
  String? cBranch;
  String? cdesc;

  DataCabang({this.cBranch, this.cdesc});

  DataCabang.fromJson(Map<String, dynamic> json) {
    cBranch = json['cBranch'];
    cdesc = json['cdesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cBranch'] = this.cBranch;
    data['cdesc'] = this.cdesc;
    return data;
  }
}