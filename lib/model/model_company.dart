class Company {
  bool? error;
  String? message;
  List<DataCompany>? data;
  int? statusCode;

  Company({this.error, this.message, this.data, this.statusCode});

  Company.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DataCompany>[];
      json['data'].forEach((v) {
        data!.add(new DataCompany.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class DataCompany {
  String? cCompcode;
  String? cdesc;

  DataCompany({this.cCompcode, this.cdesc});

  DataCompany.fromJson(Map<String, dynamic> json) {
    cCompcode = json['cCompcode'];
    cdesc = json['cdesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cCompcode'] = this.cCompcode;
    data['cdesc'] = this.cdesc;
    return data;
  }
}