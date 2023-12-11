import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:json_table/json_table.dart';
import 'package:koperasimobile/constant/dialog_constant.dart';
import 'package:koperasimobile/controller/cust_controller.dart';
import 'package:koperasimobile/screen/home/cust_home.dart';

import '../../../constant/text_constant.dart';
import '../../auth/cust/cust_edit_screen.dart';

class CustScreen extends StatefulWidget {
  const CustScreen({Key? key}) : super(key: key);

  @override
  State<CustScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<CustScreen> {
  CustController custcontroller = Get.put(CustController());

  @override
  void initState() {
    custcontroller.getSO(
        context: context,
        callback: (result, error) {
          if (result != null && result['error'] != true) {
            tabelSO();
          } else {
            DialogConstant.alertError('Data tidak ada');
          }
        });
    super.initState();
  }

  Widget tabelKosong = CircularProgressIndicator();

  tabelSO() {
    var columns = [
      JsonTableColumn("kodes", label: "Kode_Supp"),
      JsonTableColumn("namas", label: "Nama_Supp"),
      JsonTableColumn("alamat", label: "Alamat"),
      JsonTableColumn("kota", label: "Kota"),
      JsonTableColumn("golongan", label: "Golongan"),
      JsonTableColumn("tlp", label: "Telp"),
      JsonTableColumn("usrnm", label: "UserInput"),
    ];
    setState(() {
      tabelKosong = JsonTable(
        onRowSelect: (index, map) {
          Widget okButton = TextButton(
            child: Text(
              "Edit Data",
              style: TextConstant.regular.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.blueAccent,
                  fontSize: 15),
            ),
            onPressed: () {
              //print(index);
              //print(map);
              // print(map['kodes']);
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustEdtScreen(
                      tipeCheck: 'ini edit',
                      kodes: map['kodes'],
                      namas: map['namas'],
                      alamat: map['alamat'],
                      email: map['email'],
                      tlp: map['tlp'],
                    ),
                  ));
              setState(() {});
            },
          );
          Widget noButton = TextButton(
            child: Text(
              "Hapus Data",
              style: TextConstant.regular.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.blueAccent,
                  fontSize: 15),
            ),
            onPressed: () => custcontroller.hps_supp(
                kodes: map['kodes'],
                context: context,
                callback: (result, error) {
                  if (result != null && result['error'] != true) {
                    Navigator.pop(context);
                    // Get.back();
                    // Get.off(SuppHome());
                    Get.to(CustHome());
                    Get.to(CustScreen());
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
            title: Text(
              "Peringatan !!",
              style: TextConstant.regular.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.redAccent,
                  fontSize: 15),
            ),
            content: Text(
              "Tentukan Pilihan Anda !!",
              style: TextConstant.regular.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 15),
            ),
            actions: [okButton, noButton],
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
        custcontroller.jsonSample,
        columns: columns,
        allowRowHighlight: true,
        rowHighlightColor: Colors.green.withOpacity(0.3),
        paginationRowCount: 10,
        tableHeaderBuilder: (header) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
                border: Border.all(width: 0.5), color: Colors.grey[300]),
            child: Text(
              header!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15.0,
                  color: Colors.black87),
            ),
          );
        },
        tableCellBuilder: (value) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 10.0),
            decoration: BoxDecoration(
                border: Border.all(
                    width: 0.5, color: Colors.grey.withOpacity(0.5))),
            child: value.contains("*")
                ? Transform.scale(
                    scale: 1.5,
                    child: Checkbox(
                      value: custcontroller.checkedAccept
                              .contains(value.substring(1))
                          ? true
                          : false,
                      checkColor: Colors.red,
                      shape: CircleBorder(),
                      onChanged: (selected) {
                        if (selected == true) {
                          if (!custcontroller.checkedAccept
                              .contains(value.substring(1))) {
                            custcontroller.checkedAccept
                                .add(value.substring(1));
                          }
                        } else {
                          custcontroller.checkedAccept.removeWhere(
                              (item) => item == value.substring(1));
                        }
                        setState(() {
                          tabelSO();
                        });
                        // print(custcontroller.checkedAccept);
                      },
                    ))
                : Text(
                    value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        height: 3.4, fontSize: 14.0, color: Colors.grey[900]),
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
        title: Text("Master Customer"),
        centerTitle: true,
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: custcontroller.jsonSample.length,
          itemBuilder: (context, i) {
            final data = custcontroller.jsonSample[i];
            return ListTile(
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.5),
              ),
              onTap: () => {
                // Navigator.pop(context),
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CustEdtScreen(
                        tipeCheck: 'ini edit',
                        kodes: data['kodes'],
                        namas: data['namas'],
                        alamat: data['alamat'],
                        email: data['email'],
                        tlp: data['tlp'],
                      ),
                    ))
              },
              leading: CircleAvatar(
                backgroundImage: AssetImage("assets/images/cart_logo.jpg"),
              ),
              title: Text(data['namas']),
              subtitle: Text(data['kodes']),
              trailing: IconButton(
                onPressed: () {
                  custcontroller.hps_supp(
                      kodes: data['kodes'],
                      context: context,
                      callback: (result, error) {
                        if (result != null && result['error'] != true) {
                          Navigator.pop(context);
                          Get.to(CustHome());
                          Get.to(CustScreen());
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
    if (value != "") {
      var dateTime = DateFormat("yyyy-MM-dd").parse(value.toString());
      return DateFormat("dd/MM/yyyy").format(dateTime);
    } else {
      return "";
    }
  }

  String formatRibuan(value) {
    if (value != "") {
      final formatter = new NumberFormat("#,##0");
      return formatter.format(double.parse(value));
    } else {
      return 0.toString();
    }
  }
}
