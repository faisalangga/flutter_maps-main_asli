import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koperasimobile/constant/text_constant.dart';

import '../../../controller/pengajuan_simp_controller.dart';
import '../../../widget/app_dropdown.dart';

class AjuSimpInsScreen extends StatefulWidget {
  final String tipeCheck;

  const AjuSimpInsScreen({Key? key, required this.tipeCheck}) : super(key: key);

  @override
  State<AjuSimpInsScreen> createState() => _AjuSimpScreenState();
}

class _AjuSimpScreenState extends State<AjuSimpInsScreen> {
  AjuSimpController ajusimpcontroller = AjuSimpController();

  String selectedDuration = '3 Bulan';
  String selectednilai = '0.00';
  int? pinjamanValue = 0;
  int? pokok = 0;
  int? bunga = 0;
  int? biayaadm = 2500;
  int? jumtot = 0;

  int id = 1;
  bool _switchValue = true;
  bool _obscureText = true;

  int hitungpokokAngsuran() {
    if (selectedDuration != null) {
      String selected = selectedDuration.length == 8 ? selectedDuration.substring(0, 2) : selectedDuration.substring(0, 1);
      int lama_angsuran = int.tryParse(selected) ?? 0;
      if (pinjamanValue != null) {
        return (pinjamanValue! ~/ lama_angsuran);
      }
    }
    return 0;
  }

  int hitungbunga() {
    if (pinjamanValue!= null) {
      double bunga = 0.05;
      if (pinjamanValue != null) {
        return (pinjamanValue! * bunga).toInt();
      }
    }
    return 0;
  }

  int viewjml() {
    if (pinjamanValue != null) {
      int pokok = hitungpokokAngsuran();
      int bunga = hitungbunga();
      int biayaAdmin = biayaadm ?? 0;

      int total = pokok + bunga + biayaAdmin;
      return total;
    }
    return 0;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        leading: GestureDetector(
            onTap: () => Get.back(),
            child: Icon(CupertinoIcons.back, color: Colors.black87)),
        title: Text(
          'Pengajuan Pinjaman',
          style: TextConstant.regular.copyWith(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 0),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nominal Pinjaman',
                      style: TextConstant.regular.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            if(value.isEmpty){
                              pinjamanValue=0;
                            }else{
                              pinjamanValue = int.parse(value);
                            }
                          });
                        },
                        keyboardType: TextInputType.number,
                        maxLength: 8,
                        controller: ajusimpcontroller.edtpinjaman,
                        // inputFormatters: [ThousandsFormatter()],
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: 'pinjaman',
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.grey[200],
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lama Pinjaman',
                    style: TextConstant.regular.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    child: AppDropdown<String>(
                      value: selectedDuration,
                      onChanged: (newValue) {
                        setState(() {
                          selectedDuration = newValue!;
                          // print('paisxx $selectedDuration');
                        });
                      },
                      items: <String>['3 Bulan', '6 Bulan', '12 Bulan']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: 'Pilih Durasi',
                    ),
                  ),
                ],
              )),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Info Tagihan',
                        style: TextConstant.regular.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Nominal',
                              style: TextConstant.regular.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Text(
                            pinjamanValue.toString(),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Pokok Angsuran',
                              style: TextConstant.regular.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Text('${hitungpokokAngsuran()}'
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Bunga 5%',
                              style: TextConstant.regular.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Text('${hitungbunga()}'
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Biaya Admin',
                              style: TextConstant.regular.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Text(biayaadm.toString()
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Jumlah Angsuran',
                              style: TextConstant.regular.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Text('${viewjml()}',
                              style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ),
              ),
              SizedBox(height: 25),
              // ButtonGreenWidget(
              //   text: 'Simpan',
              //   onClick: () => ajusimpcontroller.validationSupp(
              //       context: context,
              //       callback: (result, error) {
              //         if (result != null && result['error'] != true) {
              //           Get.back();
              //           DialogConstant.alertError('Pendaftaran Berhasil');
              //           Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => SuppScreen(),
              //               ));
              //           setState(() {});
              //         }
              //         if (error != null) {
              //           DialogConstant.alertError(
              //               'Pendaftaran Gagal, NIK Sudah Terdaftar');
              //         }
              //       }),
              // ),
              // ButtonGreenWidget(
              //   text: 'Simpan',
              //   onClick: () async {
              //     final result = await ajusimpcontroller.validationSupp(
              //       context: context,
              //     );
              //     if (result != null && result['error'] != true) {
              //       await showPlatformDialog(
              //         context: context,
              //         builder: (_) => BasicDialogAlert(
              //           title: Text("Notifikasi"),
              //           content: Text("Pendaftaran Berhasil"),
              //           actions: <Widget>[
              //             BasicDialogAction(
              //               title: Text("Ajukan Sekarang"),
              //               onPressed: () {
              //                 Navigator.pop(context); // Tutup dialog
              //                 Navigator.push(
              //                   context,
              //                   MaterialPageRoute(builder: (context) => SuppScreen()),
              //                 );
              //                 setState(() {});
              //               },
              //             ),
              //             BasicDialogAction(
              //               title: Text("Tidak"),
              //               onPressed: () {
              //                 Navigator.pop(context); // Tutup dialog
              //               },
              //             ),
              //           ],
              //         ),
              //       );
              //     } else {
              //       await showPlatformDialog(
              //         context: context,
              //         builder: (_) => BasicDialogAlert(
              //           title: Text("Notifikasi"),
              //           content: Text("Pinjaman Gagal, Hubungi IT"),
              //           actions: <Widget>[
              //             BasicDialogAction(
              //               title: Text("Ok"),
              //               onPressed: () {
              //                 Navigator.pop(context); // Tutup dialog
              //               },
              //             ),
              //           ],
              //         ),
              //       );
              //     }
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
