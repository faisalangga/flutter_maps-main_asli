
class ModelUser{

  ModelUser();
  String? username;
  String? email;
  String? first_name;
  String? last_name;
  String? address;
  String? phone;

  factory ModelUser.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}

ModelUser _$fromJson(Map<String, dynamic> json) {
  return ModelUser()
    ..username = json['username'] as String
    ..email = json['email'] as String
    ..first_name = json['first_name'] as String
    ..last_name = json['last_name'] as String
    ..address = json['address'] as String
    ..phone = json['phone'] as String
  ;
}

Map<String, dynamic> _$toJson(ModelUser cartCheckoutProduct) =>
    <String, dynamic> {
      'username': cartCheckoutProduct.username,
      'email': cartCheckoutProduct.email,
      'first_name': cartCheckoutProduct.first_name,
      'last_name': cartCheckoutProduct.last_name,
      'address': cartCheckoutProduct.address,
      'phone': cartCheckoutProduct.phone,
    };