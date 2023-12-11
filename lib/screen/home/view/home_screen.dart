import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:json_table/json_table.dart';
import 'package:koperasimobile/constant/dialog_constant.dart';
import 'package:koperasimobile/constant/text_constant.dart';
import 'package:koperasimobile/controller/home_controller.dart';
import 'package:koperasimobile/screen/home/landing_home.dart';
import 'package:koperasimobile/widget/material/button_orange_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homecontroller = Get.put(HomeController());

  @override
  void initState() {
    homecontroller.getSO(
      context: context,
      callback: (result, error){
        if(result != null && result['error'] != true){
          tabelSO();
        }else{
          DialogConstant.alertError('Data tidak ada');
        }
      }
    );
    super.initState();
  }

  Widget tabelKosong = CircularProgressIndicator();
  tabelSO() {
    var columns = [
      JsonTableColumn("NO_BUKTI", label: "Sales Order#"),
      JsonTableColumn("TGL", label: "Tanggal", valueBuilder: formatTanggal),
      JsonTableColumn("NA_BRG", label: "Barang"),
      JsonTableColumn("NOTES", label: "Notes"),
      JsonTableColumn("KG", label: "KG", valueBuilder: formatRibuan),
      JsonTableColumn("TOTAL", label: "Total", valueBuilder: formatRibuan),
      JsonTableColumn("CEK", label: "Accept"),
    ];
    setState(() {
      tabelKosong =
        JsonTable(
          onRowSelect: (index, map) {
            homecontroller.nomorSo.value = map['NO_BUKTI'];
            setState(() {
              
            });
          },
          homecontroller.jsonSample,
          columns: columns,
          allowRowHighlight: true,
          rowHighlightColor: Colors.green.withOpacity(0.3),
          paginationRowCount: 10,
          tableHeaderBuilder: (header) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(border: Border.all(width: 0.5),color: Colors.grey[300]),
              child: Text(
                header!,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0,color: Colors.black87),
              ),
            );
          },
          tableCellBuilder: (value) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 10.0),
              decoration: BoxDecoration(border: Border.all(width: 0.5, color: Colors.grey.withOpacity(0.5))),
              child: value.contains("*")
              ?
              Transform.scale(
                scale: 1.5,
                child : Checkbox(
                  value: homecontroller.checkedAccept.contains(value.substring(1)) ? true : false,
                  checkColor: Colors.red,
                  shape: CircleBorder(),
                  onChanged: (selected) {
                    if (selected == true) {
                      if (!homecontroller.checkedAccept.contains(value.substring(1))) {
                        homecontroller.checkedAccept.add(value.substring(1));
                      }
                    } else {
                      homecontroller.checkedAccept.removeWhere((item) => item == value.substring(1));
                    }
                    setState(() {
                      tabelSO();
                    });
                    // print(homecontroller.checkedAccept);
                  },
                )
              )
              :
              Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(height:3.4, fontSize: 14.0, color: Colors.grey[900]),
              ),
            );
          },
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Accept Job"),
          centerTitle: true,
          backgroundColor: Colors.green,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          // alignment: Alignment.center,
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Container(
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text('Sales Order#', style: TextConstant.regular.copyWith(fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 15),),
                //       Container(
                //         height: 40,
                //         child: TextField(
                //           maxLength: 50,
                //           controller: homecontroller.nomorSo,
                //           keyboardType: TextInputType.emailAddress,
                //           decoration: DecorationConstant.inputDecor().copyWith(hintText: "Sales Order#",counterText: '', contentPadding: EdgeInsets.only(top: 0)),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                Text('Sales Order# : '+homecontroller.nomorSo.value, style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 18),),
                SizedBox(height: 20),
                tabelKosong,
                SizedBox(height: 20),
                ButtonOrangeWidget(
                  text: 'Accept', 
                  onClick: ()=>homecontroller.validationAcceptJob(
                    context: context,
                    callback: (result, error){
                      if(result != null && result['error'] != true){
                        homecontroller.getSO(
                          context: context,
                          callback: (result, error){
                            if(result != null && result['error'] != true){
                              tabelSO();
                            }else{
                              DialogConstant.alertError('Data tidak ada');
                            }
                          }
                        );
                        // DialogConstant.alertError('SO# diterima');
                        showDialog(
                          context: Get.context!,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: 16),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Text("SO# diterima", style: TextConstant.regular,),
                                ),
                                SizedBox(height: 16),
                                Divider(height: 0),
                                TextButton(
                                  child: Text('OKE', style: TextConstant.medium.copyWith(color: Colors.blue),),
                                  onPressed: ()=>Get.offAll(LandingHome()), 
                                ),
                                SizedBox(height: 4),
                              ],
                            ),
                          );
                        });
                      }
                      if(error != null){
                        tabelKosong = CircularProgressIndicator();
                        DialogConstant.alertError('Kesalahan accept SO#');
                      }
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
  
  String formatTanggal(value) {
    if (value!=""){
      var dateTime = DateFormat("yyyy-MM-dd").parse(value.toString());
      return DateFormat("dd/MM/yyyy").format(dateTime);
    }else{
      return "";
    }
  }
  String formatRibuan(value) {
    if (value!=""){
      final formatter = new NumberFormat("#,##0");
      return formatter.format(double.parse(value));
    }else{
      return 0.toString();
    }
  }
}
