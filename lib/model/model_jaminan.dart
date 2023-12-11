class cekjaminan {
  List<Jaminan>? data;
  bool? error;
  Null? message;

  cekjaminan({this.data, this.error, this.message});

  cekjaminan.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Jaminan>[];
      json['data'].forEach((v) {
        data!.add(new Jaminan.fromJson(v));
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

class Jaminan {
  String? jaminan;
  String? cBranch;

  Jaminan({this.jaminan,this.cBranch});

  Jaminan.fromJson(Map<String, dynamic> json) {
    jaminan = json['cJaminan'];
    cBranch = json['cBranch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> datajaminan = new Map<String, dynamic>();
    datajaminan['cJaminan'] = this.jaminan;
    datajaminan['cBranch'] = this.cBranch;
    return datajaminan;
  }
}