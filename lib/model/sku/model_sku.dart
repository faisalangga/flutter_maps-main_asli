
class ModelSKU{

  ModelSKU();
  int? id;
  int? category_id;
  String? sku_name;
  double? price;
  int? dicount;
  String? detail;
  int? qty;

  factory ModelSKU.fromJson(Map<String, dynamic> json) => _$fromJson(json);
  Map<String, dynamic> toJson() => _$toJson(this);
}

ModelSKU _$fromJson(Map<String, dynamic> json) {
  return ModelSKU()
    ..id = json['id'] as int
    ..category_id = json['category_id'] as int
    ..sku_name = json['sku_name'] as String
    ..price = json['price'] as double
    ..dicount = json['dicount'] as int
    ..detail = json['detail'] as String
    ..qty = json['qty'] as int
  ;
}

Map<String, dynamic> _$toJson(ModelSKU cartCheckoutProduct) =>
    <String, dynamic> {
      'id': cartCheckoutProduct.id,
      'category_id': cartCheckoutProduct.category_id,
      'sku_name': cartCheckoutProduct.sku_name,
      'price': cartCheckoutProduct.price,
      'dicount': cartCheckoutProduct.dicount,
      'detail': cartCheckoutProduct.detail,
      'qty': cartCheckoutProduct.qty,
    };