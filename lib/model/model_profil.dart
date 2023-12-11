class Model_profil {
  bool? error;
  String? message;
  List<Data>? data;

  Model_profil({this.error, this.message, this.data});

  Model_profil.fromJson(Map<String, dynamic> json) {
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
  String? pselfie;

  Data({this.pselfie});

  Data.fromJson(Map<String, dynamic> json) {
    pselfie = json['pselfie'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pselfie'] = this.pselfie;
    return data;
  }
}
