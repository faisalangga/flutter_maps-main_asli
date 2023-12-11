import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:json_table/json_table.dart';
import 'package:koperasimobile/constant/dialog_constant.dart';
import 'package:koperasimobile/controller/kas_controller.dart';
import 'package:koperasimobile/screen/home/kas_home.dart';

// import 'package:confirm_dialog/confirm_dialog.dart';

import '../../../constant/text_constant.dart';
import '../../auth/kas/kas_edit_screen.dart';

class KasScreen extends StatefulWidget {
  const KasScreen({Key? key}) : super(key: key);

  @override
  State<KasScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<KasScreen> {
  KasController kascontroller = Get.put(KasController());

  @override
  void initState() {
    kascontroller.getSO(
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
      JsonTableColumn("NO_BUKTI", label: "NO_BUKTI"),
      JsonTableColumn("TGL",      label: "TGL"),
      JsonTableColumn("KET",      label: "KET"),
      JsonTableColumn("JUMLAH",   label: "JUMLAH"),
      JsonTableColumn("POSTED",   label: "POSTED"),
      JsonTableColumn("USRNM",    label: "USRNM"),
    ];
    setState(() {
      tabelKosong =
          JsonTable(
            onRowSelect: (index, map) {
              Widget okButton = TextButton(
                child: Text("Edit Data",style: TextConstant.regular.copyWith(fontWeight: FontWeight.w500, color: Colors.blueAccent, fontSize: 15),),
                onPressed: () {
                  print(index);
                  //print(map);
                  // print(map['kodes']);
                  Navigator.pop(context);
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>KasEdtScreen(tipeCheck: 'ini edit',
                    bkt: map['kodes'], tgl:map['namas'], ket:map['alamat'], tot:map['email'], acno:map['tlp'],nacno:map['tlp'],uraian:map['tlp'],jml:map['tlp'],reff:map['tlp']),));
                  setState(() {
                  });
                },
              );
              Widget noButton = TextButton(
                child: Text("Hapus Data",style: TextConstant.regular.copyWith(fontWeight: FontWeight.w500, color: Colors.blueAccent, fontSize: 15),),
                onPressed: () => kascontroller.hps_supp(kodes: map['kodes'],
                    context: context,
                    callback: (result, error) {
                      if (result != null && result['error'] != true) {
                        Navigator.pop(context);
                        Get.to(KasHome());
                        Get.to(KasScreen());
                        DialogConstant.alertError('Data Berhasil Dihapus');
                      }
                      if (error != null) {
                        DialogConstant.alertError('Hapus Data Gagal');
                        Navigator.pop(context);
                      }
                    }),
              );
              // set up the AlertDialog
              AlertDialog alert = AlertDialog(
                title: Text("Peringatan !!", style: TextConstant.regular.copyWith(fontWeight: FontWeight.w500, color: Colors.redAccent, fontSize: 15),),
                content: Text("Tentukan Pilihan Anda !!", style: TextConstant.regular.copyWith(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 15),),
                actions: [
                  okButton,
                  noButton
                ],
              );
              // show the dialog
              showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return alert;
                },
              );
            },
            kascontroller.jsonSample,
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
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15.0,color: Colors.black87),
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
                      value: kascontroller.checkedAccept.contains(value.substring(1)) ? true : false,
                      checkColor: Colors.red,
                      shape: CircleBorder(),
                      onChanged: (selected) {
                        if (selected == true) {
                          if (!kascontroller.checkedAccept.contains(value.substring(1))) {
                            kascontroller.checkedAccept.add(value.substring(1));
                          }
                        } else {
                          kascontroller.checkedAccept.removeWhere((item) => item == value.substring(1));
                        }
                        setState(() {
                          tabelSO();
                        });
                        // print(kascontroller.checkedAccept);
                      },
                    )
                ):
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
        title: Text("Journal Kas Masuk"),
        centerTitle: true,
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
      ),
      body: Obx( () => ListView.builder(
        itemCount: kascontroller.jsonSample.length,
        itemBuilder: (context, i) {
          final data = kascontroller.jsonSample[i];
          return ListTile(
            shape : OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.5),
            ),
            onTap: () => {
              // Navigator.pop(context),
            Navigator.push(context,MaterialPageRoute(builder: (context)=>KasEdtScreen(tipeCheck: 'ini edit',
            bkt: data['kodes'], tgl:data['namas'], ket:data['alamat'], tot:data['email'], acno:data['tlp'],nacno:data['tlp'],uraian:data['tlp'],jml:data['tlp'],reff:data['tlp'],),))
          },
            leading: CircleAvatar(
              backgroundImage: AssetImage("assets/images/cart_logo.jpg"),
            ),
            title: Text(data['NO_BUKTI']),
            subtitle: Text(data['TGL'],textAlign: TextAlign.left),

            trailing: IconButton(
              onPressed: () { kascontroller.hps_supp(kodes: data['kodes'],
                  context: context,
                  callback: (result, error) {
                    if (result != null && result['error'] != true) {
                      Navigator.pop(context);
                      Get.to(KasHome());
                      Get.to(KasScreen());
                      DialogConstant.alertError('Data Berhasil Dihapus');
                    }
                    if (error != null) {
                      DialogConstant.alertError('Hapus Data Gagal');
                      Navigator.pop(context);
                    }
                  });
              },
              icon: Icon(Icons.delete_forever_outlined),
            ),
          );
        },
        // prototypeItem: SizedBox(height: 50),
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
