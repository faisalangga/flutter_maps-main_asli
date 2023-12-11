
import 'dart:convert';

import 'package:get/get.dart';
import 'package:koperasimobile/model/sku/model_sku.dart';
import 'package:koperasimobile/utils/local_data.dart';

class ProductController extends GetxController{

  RxList<ModelSKU> dataCart = <ModelSKU>[].obs;

  loadCart() async {
    var data = await LocalData.getData('cart');
    if(data != ''){
      var json = jsonDecode(data);
      var carts = (json as List<dynamic>?)?.map((e) => ModelSKU.fromJson(e as Map<String, dynamic>)).toList();
      if(carts!.length > 0){
        dataCart.value = carts;
      }
    }
  }

  saveToCart(ModelSKU modelCart) async {
    var data = await LocalData.getData('cart');
    if(data != ''){
      var json = jsonDecode(data);
      var carts = (json as List<dynamic>?)?.map((e) => ModelSKU.fromJson(e as Map<String, dynamic>)).toList();
      if(carts!.length > 0){
        var dataCheck = carts.where((element) => element.id! == modelCart.id!).toList();
        if(dataCart.length > 0){
          modelCart.qty = modelCart.qty!+dataCheck[0].qty!;
          carts.removeWhere((element) => element.id! == modelCart.id!);
        }
      }
      await LocalData.removeData('cart');
      carts.add(modelCart);
      LocalData.saveData('cart', jsonEncode(carts));

    }else{
      List<ModelSKU> carts = [];
      carts.add(modelCart);
      LocalData.saveData('cart', jsonEncode(carts));
    }
    loadCart();
  }
}