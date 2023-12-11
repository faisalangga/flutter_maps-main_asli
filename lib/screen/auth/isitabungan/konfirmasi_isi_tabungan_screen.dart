import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:koperasimobile/model/model_docnotabungan.dart';
import 'package:koperasimobile/model/model_rekening.dart';
import 'package:koperasimobile/screen/auth/isitabungan/cetak_tabungan.dart';
import 'package:koperasimobile/utils/Utils.dart';
import 'package:koperasimobile/widget/app_shimmer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../api/api.dart';
import '../../../constant/const_url.dart';
import '../../../constant/dialog_constant.dart';
import '../../../constant/text_constant.dart';
import '../../../constant/utils_rp.dart';
import '../../../controller/isi_tabungan_controller.dart';
import '../../../widget/material/button_green_widget.dart';

class ConfirmPage extends StatefulWidget {
  final String? recomenNominal;

  ConfirmPage({Key? key, required this.recomenNominal}) : super(key: key);

  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  final TopUpController controller = Get.put(TopUpController());

  List<DataRekening> dataList = [];
  File? _imageFile;
  String? _base64Image;
  String? ininorex;
  String? namaBank;
  String? atasnama;
  late final String? docno;

  Future<DataRekening> fetchRekening() async {
    Completer<DataRekening> completer = Completer<DataRekening>();
    try {
      Map<String, String> header = {'Content-Type': 'application/json'};
      Map<String, dynamic> post = {"branch": "7000"};
      API.basePostGolang(ConstUrl.rekening, post, header, true,
          (result, error) {
        if (error != null) {
          // print('Error fetching rekening inifais: $error');
          completer.complete(null);
        }
        if (result != null) {
          Rekening response = Rekening.fromJson(result);
          final rekening = response.data![0];
          completer.complete(rekening);
        }
      });
    } catch (error) {
      // print('Error fetching rekening : $error');
      completer.complete(null);
    }
    return completer.future;
  }

  Future<img.Image?> resizeImage(File imageFile) async {
    final img.Image? originalImage =
        img.decodeImage(await imageFile.readAsBytes());
    if (originalImage != null) {
      final img.Image resizedImage = img.copyResize(originalImage, width: 800);
      return resizedImage;
    }
    return null;
  }

  void _stateupload() async {
    setState(() {
      try {
        if (_base64Image == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Kesalahan Saat Upload Gambar'),
            ),
          );
        } else {
          controller.edtfotobukti.value = _base64Image!;
          // print('fafais $_base64Image');
        }
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Maaf, Terjadi sebuah kesalahan'),
          ),
        );
      }
    });
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile =
        // ignore: deprecated_member_use
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _base64Image = base64Encode(_imageFile!.readAsBytesSync());
        _stateupload();
      });
    }
  }

  Future<Map<String, dynamic>> _getValue() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map<String, dynamic> data = {
      'value': widget.recomenNominal,
      'poto': _base64Image,
      'cinput': preferences.getString("username"),
      'branch': preferences.getString("cbranch"),
      'member': preferences.getString("cmember"),
    };
    // print('fais data : $data');
    return data;
  }

  @override
  void initState() {
    super.initState();
    fetchRekening().then((value) {
      setState(() {
        atasnama = value.cAtasNama.toString();
        ininorex = value.mRekening.toString();
        namaBank = value.cNamaBank.toString();
        // print('Saldo Rekening inifais: $ininorex');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    String? nominal = widget.recomenNominal;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(CupertinoIcons.back, color: Colors.white),
        ),
        title: Text(
          'Konfirmasi Deposit',
          style: TextConstant.regular.copyWith(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Colors.grey.shade300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'LAKUKAN TRANSFER KE REKENING KOPERASI',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: height * 0.018,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.info_outline,
                    color: Colors.red,
                    size: 20,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Rekening Koperasi',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    child: (atasnama != null &&
                            ininorex != null &&
                            namaBank != null)
                        ? Column(
                            children: [
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Container(
                                    child: Image.asset(
                                      getLogoBank('$namaBank'),
                                      height: size.height * 0.030,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Bank ${namaBank}',
                                        style: TextConstant.medium.copyWith(
                                          color: Colors.black87,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        '$atasnama',
                                        style: TextConstant.medium.copyWith(
                                          color: Colors.black87,
                                          fontSize: size.height * 0.018,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'No. Rekening',
                                    style: TextStyle(fontSize: 15),
                                  )),
                              Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                    child: Text(
                                      '$ininorex',
                                      style: TextConstant.medium.copyWith(
                                        color: Colors.black87,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )),
                                  IconButton(
                                    icon: Icon(
                                      Icons.content_copy,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      Clipboard.setData(
                                          ClipboardData(text: '$ininorex'));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content:
                                              Text('Teks berhasil disalin'),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  AppShimmer(
                                      width: width * 0.1, height: width * 0.1),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppShimmer(width: width * 0.4),
                                      SizedBox(height: 5),
                                      AppShimmer(width: width * 0.6),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Container(
                                alignment: Alignment.topLeft,
                                child: AppShimmer(width: width * 0.3),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                    child: AppShimmer(width: width * 0.5),
                                  )),
                                  SizedBox(height: 60),
                                ],
                              ),
                            ],
                          ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Nominal Deposit',
                    style: TextConstant.regular.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            rupiah(nominal!),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.blue,
                              fontSize: 30,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.content_copy,
                            size: 30,
                          ),
                          onPressed: () {
                            Clipboard.setData(
                                ClipboardData(text: rupiah(nominal)));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Teks berhasil disalin'),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    color: Colors.yellow.shade100,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(
                            Icons.info_outline,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                        Text('Pastikan Nominal Sesuai Dengan Transfer Anda...',
                            style: TextStyle(color: Colors.grey.shade700,fontSize: width*0.031)),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Unggah Bukti Transfer',
                          style: TextConstant.regular.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                              fontSize: 15),
                        ),
                        SizedBox(height: 10),
                        Text(
                            'Jika Sudah Transfer, Unggah Bukti Transfer Anda Disini...',
                            style: TextStyle(color: Colors.grey.shade700,fontSize: width*0.032)),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: _getImageFromGallery,
                          child: Container(
                            height: 200.0,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[400]!),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: _imageFile != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.file(
                                      _imageFile!,
                                      height: 200.0,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Center(
                                    child: Icon(Icons.image,
                                        size: 80.0, color: Colors.grey[400]),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  ButtonGreenWidget(
                    text: 'Transfer',
                    onClick: () => (atasnama != null &&
                            ininorex != null &&
                            namaBank != null)
                        ? controller.validationTabungan(
                        value: _getValue(),
                        context: context,
                        callback: (result, error) {
                          if (result != null && result['error'] != true) {
                            Get.back();
                            // DialogConstant.alertError('Deposit Berhasil');
                            DocnoTabModel response =
                            DocnoTabModel.fromJson(result);
                            setState(() {
                              docno = response.pesan;
                            });
                            // print ('fais docno : $docno');
                            // print ('fais ${result['pesan']}');
                            // print('fais getvalue : ${_getValue()}');
                            // Navigator.pop(context);
                            // Navigator.pop(context);
                            // Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  // builder: (context) => TopUpPage(),
                                  // builder: (context) => SubMenuTabungan(),
                                  builder: (context) => CetakTabunganPage(
                                      docno: docno, value: _getValue()),
                                ));
                          }
                          if (error != null) {
                            DialogConstant.alertError(
                                'Deposit Gagal, Hubungi IT');
                          }
                        })
                        : DialogConstant.loading(
                        context!, 'Jaringan Ke Server Bermasalah...'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
