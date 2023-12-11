
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:koperasimobile/api/api.dart';
import 'package:koperasimobile/constant/dialog_constant.dart';
import 'package:koperasimobile/utils/local_data.dart';

class ChecksoController extends GetxController{
  RxString tipe = "".obs;
  RxString latitude = "".obs;
  RxString longitude = "".obs;

  TextEditingController nomorSo = TextEditingController();

  checkInOut({
    BuildContext? context,
    void callback(result, exception)?}) async {
    var post = new Map<String, dynamic>();
    var header = new Map<String, String>();

    header['Content-Type'] = 'application/form-data';
    post['nobukti'] = "APA";
    await LocalData.getData('user').then((user) {
      post['username'] = user;
    });
    post['tipe'] = tipe.value;
    post['lat'] = latitude.value;
    post['lng'] = longitude.value;

    DialogConstant.loading(context!, 'Proses...');

    API.basePost('/check-so.php', post, header, true, (result, error) {
      Get.back();
      if(error != null){
        callback!(null, error);
      }
      if(result != null){
        callback!(result, null);
      }
    });
  }

}