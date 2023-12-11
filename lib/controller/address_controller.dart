
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddressController extends GetxController{
  RxString userName = "".obs;
  RxInt lengthDetailAddress = 0.obs;
  RxBool setMainAddress = false.obs;

  final detailAddress = TextEditingController();

  getLength(){
    lengthDetailAddress.value = detailAddress.text.length;
  }

  changeSetMainAddress(bool val){
    setMainAddress.value = val;
  }
}