import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:koperasimobile/constant/dialog_constant.dart';
import 'package:koperasimobile/constant/image_constant.dart';
import 'package:koperasimobile/model/model_search_pinjaman.dart';
import 'package:koperasimobile/screen/auth/pengajuan_simp/pengajuan_simp_ins_screen.dart';
import 'package:koperasimobile/utils/utils_dialog.dart';
import 'package:koperasimobile/widget/app_nodata.dart';
import 'package:lottie/lottie.dart';

import '../../../api/api.dart';
import '../../../constant/const_url.dart';
import '../../../constant/text_constant.dart';
import '../../../constant/utils_rp.dart';
import '../../../controller/pengajuan_simp_controller.dart';
import '../../auth/pengajuan_simp/pengajuan_simp_edit_screen.dart';

class AjuSimpScreen extends StatefulWidget {
  const AjuSimpScreen({Key? key}) : super(key: key);

  @override
  State<AjuSimpScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<AjuSimpScreen> {
  AjuSimpController AjuSimpcontroller = Get.put(AjuSimpController());
  bool isNodata = false;
  var data;
  List<DataView> dataList = [];
  String _searchQuery = '';
  String ? cDocno ;
  DateTime newTime = DateTime.now();
  DateTime oldTime = DateTime.now();

  String responseData = "";

  Future<Future<DataView>> fetchRekening() async {
    Completer<DataView> completer = Completer<DataView>();
    try {
      Map<String, String> header = {'Content-Type': 'application/json'};
      Map<String, dynamic> post = {"input": "HIMA"};
      API.basePostGolang(ConstUrl.viewpinjaman, post, header, true,
          (result, error) {
        if (error != null) {
          print('fais Error fetching rekening inifais: $error');
          completer.complete(null);
        }
        if (result != null) {
          ModelSearchPinjaman response = ModelSearchPinjaman.fromJson(result);
          final viewpinjaman = response.data![0];
          completer.complete(viewpinjaman);
          // print('faiszz ${viewpinjaman.cDocno}');
          // print('faiszz ${viewpinjaman.mValue2}');
        }
      });
    } catch (error) {
      print(' fais Error fetching rekening : $error');
      completer.complete(null);
    }
    return completer.future;
  }

  Future<bool> onBackPress() async {
    return await UtilsDialog.onBackPressConfirm(context);
  }

  bool _searchMode = false;

  @override
  void initState() {
    fetchRekening();
    AjuSimpcontroller.getSO(
      context: context,
      callback: (result, error) {
        if (result != null && result['error'] != true) {
          setState(() {
            isNodata = false;
          });
        } else {
          setState(() {
            isNodata = true;
          });
        }
      },
    );
    super.initState();
  }

  void performSearch(String value) {
    fetchRekening();
    setState(() {
      _searchQuery = value;
      if (fetchRekening() != null) {
        Iterable filteredData = AjuSimpcontroller.jsonSample
            .where((Data1) => Data1['cdocno'] == _searchQuery);
        data = filteredData.isNotEmpty ? filteredData.first : null;
      }
    });
  }

  Widget tabelKosong = CircularProgressIndicator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _searchMode
            ? TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Cari...',
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.white),
                onChanged: performSearch,
              )
            : Text(
                'Data Pengajuan',
                style: TextConstant.regular.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
        elevation: 0,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _searchMode = !_searchMode;
              });
            },
            icon: Icon(
              _searchMode ? Icons.close : Icons.search,
              color: Colors.white,
            ),
          ),
        ],
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(CupertinoIcons.back, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: isNodata
            ? AppNoData(ket: 'Data tidak ditemukkan',)
            : Obx(
                () => ListView.builder(
                  itemCount: AjuSimpcontroller.jsonSample.length,
                  itemBuilder: (context, i) {
                    data = AjuSimpcontroller.jsonSample[i];
                    RxList data1 = AjuSimpcontroller.jsonSample;
                    List<Map<String, dynamic>> dataList =
                        List<Map<String, dynamic>>.from(data1);
                    // final search = getFilteredData(dataList);
                    Iterable<Map<String, dynamic>> a = dataList
                        .where((data) => data['cdocno'] == _searchQuery);

                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ListTile(
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.5),
                        ),
                        onTap: () => {
                          Navigator.pop(context),
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PengajuanEdtScreen(
                                    tipeCheck: 'ini edit',
                                    cdocno: data['cdocno'],
                                    pokok: data['mPokok'],
                                    jasa: data['jasa'],
                                    pinjaman: data['pinjaman'],
                                    tenor: data['tenor'],
                                    badmin: data['mBadmin'],
                                    angsuran: data['mValue1'],
                                    keperluan: data['cnote'],
                                    jaminan: data['cjaminan'],
                                    mvalue1: data['mValue1'] ),
                              ))
                        },
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(data['cStatus'] != '0'
                              ? "assets/images/checklist.png"
                              : "assets/images/rejected.png"),
                          backgroundColor: data['cStatus'] != '0'
                              ? Colors.green.shade200
                              : Colors.lightBlue.shade100,
                          radius: 20,
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(data['cdocno']),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(data['tgl']),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text('Tenor : ${data['tenor']} Bulan'),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(rupiah(data['pinjaman'])),
                            ),
                          ],
                        ),
                        textColor: Colors.black,
                        trailing: data['cStatus'] != '0'
                            ? SizedBox.shrink()
                            : IconButton(
                                onPressed: () {
                                  // Tambahkan logika penghapusan di sini
                                  // Pastikan Anda menampilkan pesan atau melakukan tindakan yang sesuai jika diperlukan
                                  // {
                                  //   AjuSimpcontroller.hps_supp(
                                  //       kodes: data['cdocno'],
                                  //       context: context,
                                  //       callback: (result, error) {
                                  //         if (result != null &&
                                  //             result['error'] != true) {
                                  //           Navigator.pop(context);
                                  //           Get.to(AjuSimpHome());
                                  //           // Get.to(SuppScreen());
                                  //           DialogConstant.alertError(
                                  //               'Data Berhasil Dihapus');
                                  //         }
                                  //         if (error != null) {
                                  //           DialogConstant.alertError(
                                  //               'Hapus Data Gagal');
                                  //           Navigator.pop(context);
                                  //         }
                                  //       });
                                  // }
                                  DialogConstant.alertError(
                                      'Tidak Bisa Hapus Data...');
                                },
                                icon: Icon(
                                  Icons.delete_forever_sharp,
                                  color: Colors.red,
                                  size: 35.0,
                                ),
                              ),
                      ),
                    );
                  },
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AjuSimpInsScreen(
                tipeCheck: 'ini create',
              ),
            ),
          );
        },
        icon: Icon(Icons.add),
        label: Text('Add'),
        backgroundColor: Colors.green,
      ),
    );
  }
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
// }
