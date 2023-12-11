import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koperasimobile/api/api.dart';

class ChartController extends GetxController{
  RxString nomer = "".obs;
  RxList jsonSample = [].obs;
  // List<ChartData> chartArray = [];
  RxList<ChartData> chartArray = (List<ChartData>.of([])).obs;
  
  getChart({
    BuildContext? context,
    void callback(result, exception)?}) async {
    var post = new Map<String, dynamic>();
    var header = new Map<String, String>();
    nomer.value = "";

    header['Content-Type'] = 'application/json';
    post['tipe'] = 'SO';
    API.basePost('/get-chart.php', post, header, true, (result, error) async {
      if(error != null){
        jsonSample.value = [{"Sales Order#": "-", "Tanggal": "-", "Barang": "-", "Notes": "?", "KG": "0", "Total": "0", "Cek": "?"}];
        callback!(null, error);
      }
      if(result != null){
        jsonSample.value = result['data'] as List;
        await loadSalesData();
        callback!(result, null);
      }
    });
  }

  Future loadSalesData() async {
      chartArray.value=[];
      for (Map<String, dynamic> i in jsonSample) {
        chartArray.add(ChartData.fromJson(i));
      }
      print("array e"+chartArray.toString());
  }
}

class ChartData {
  ChartData(this.bulan, this.total, this.color);

  final String bulan;
  final double total;
  final Color color;
 
  factory ChartData.fromJson(Map<String, dynamic> parsedJson) {
    return ChartData(
      parsedJson['HARI'].toString(),
      double.tryParse(parsedJson['KG'].toString())!,
      parsedJson['HARI'].toString() == 'Sunday'
          ? Colors.red
          : parsedJson['HARI'].toString() == 'Monday'
              ? Colors.pink
              : parsedJson['HARI'].toString() == 'Tuesday'
                  ? Colors.amber
                  : parsedJson['HARI'].toString() == 'Wednesday'
                      ? Colors.blue
                      : parsedJson['HARI'].toString() == 'Thursday'
                          ? Colors.brown
                          : parsedJson['HARI'].toString() == 'Friday'
                              ? Colors.green
                              : Colors.black,
    );
  }
}