class Propinsi {
  List<Provinsi>? data;
  String? pesan;
  String? status;

  Propinsi({this.data, this.pesan, this.status});

  Propinsi.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Provinsi>[];
      json['data'].forEach((v) {
        data!.add(new Provinsi.fromJson(v));
      });
    }
    pesan = json['pesan'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['pesan'] = this.pesan;
    data['status'] = this.status;
    return data;
  }
}

class Provinsi {
  String? cPropinsi;

  Provinsi({this.cPropinsi});

  Provinsi.fromJson(Map<String, dynamic> json) {
    cPropinsi = json['cPropinsi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cPropinsi'] = this.cPropinsi;
    return data;
  }
}