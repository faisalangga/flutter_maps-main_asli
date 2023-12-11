class niknama {
  List<Dataniknama>? data;

  niknama({this.data});

  niknama.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Dataniknama>[];
      json['data'].forEach((v) {
        data!.add(new Dataniknama.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dataniknama {
  String? nama;
  String? nik;

  Dataniknama({this.nama, this.nik});

  Dataniknama.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    nik = json['nik'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama'] = this.nama;
    data['nik'] = this.nik;
    return data;
  }
}