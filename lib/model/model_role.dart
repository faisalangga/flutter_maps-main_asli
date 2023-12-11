class Cek {
  bool? error;
  Null? message;
  List<Data>? data;

  Cek({this.error, this.message, this.data, required ccek});

  Cek.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  String? akses;
  String? cek;

  Data({this.akses, this.cek});

  Data.fromJson(Map<String, dynamic> json) {
    akses = json['akses'];
    cek = json['cek'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['akses'] = this.akses;
    data['cek'] = this.cek;
    return data;
  }
}