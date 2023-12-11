import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:koperasimobile/screen/auth/isitabungan/konfirmasi_isi_tabungan_screen.dart';
import 'package:koperasimobile/utils/utils_dialog.dart';
import 'package:koperasimobile/widget/tabungan/App_recomen_nominal.dart';

import '../../../constant/dialog_constant.dart';
import '../../../constant/image_constant.dart';
import '../../../constant/text_constant.dart';
import '../../../controller/isi_tabungan_controller.dart';
import '../../../utils/utils_formatnumber.dart';
import '../../../widget/material/button_green_widget.dart';

class TopUpPage extends StatefulWidget {
  @override
  State<TopUpPage> createState() => _TopUpPageState();
}

class _TopUpPageState extends State<TopUpPage> {
  final TopUpController toupcontroller = Get.put(TopUpController());

  String? recomenNominal = '';
  String? recomenNominalxx = '';
  DateTime newTime = DateTime.now();
  DateTime oldTime = DateTime.now();

  Future<bool> onBackPress() async {
    return await UtilsDialog.onBackPressConfirm(context);
  }

  @override
  void initState() {
    super.initState();
    toupcontroller.recomenNominal.addListener(_updateRecomenNominal);
    _updateRecomenNominal();
  }

  void _updateRecomenNominal() {
    setState(() {
      final textFieldValue = toupcontroller.recomenNominal.text;
      recomenNominal =
          textFieldValue.isNotEmpty ? textFieldValue.replaceAll(',', '') : '';
      recomenNominalxx = textFieldValue.isNotEmpty ? textFieldValue : null;
    });
  }

  // void _selfie() async {
  //   setState(() async {
  //     try {
  //       if (_imageBase64 == null) {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text('Kesalahan Saat Ambil Gambar'),
  //           ),
  //         );
  //       } else {
  //         toupcontroller.edtfotobukti.value = _imageBase64!;
  //         print('pais $_imageBase64 $recomenNominal');
  //             Map<String, dynamic> data = {
  //               'value': '$recomenNominal'
  //             };
  //           await toupcontroller.validationTabungan(
  //             context: context,
  //             data: data,
  //             callback: (result, error) async {
  //               if (result != null &&
  //                   result['error'] != true) {
  //                 Navigator.pop(context);
  //                 await showPlatformDialog(
  //                   context: context,
  //                   builder: (context) =>
  //                       BasicDialogAlert(
  //                         title: Text(
  //                             'Deposit Ditambahkan',
  //                             textAlign:
  //                             TextAlign.center),
  //                         content: Lottie.asset(
  //                           ImageConstant.berhasil,
  //                           fit: BoxFit.contain,
  //                           height: 150,
  //                           width: 200,
  //                         ),
  //                         actions: <Widget>[
  //                           BasicDialogAction(
  //                             title: Text('Ok',
  //                                 textAlign: TextAlign
  //                                     .center),
  //                             onPressed: () {
  //                               Navigator.pop(
  //                                   context);
  //                               Navigator.pop(
  //                                   context);
  //                               Navigator.push(
  //                                 context,
  //                                 MaterialPageRoute(
  //                                   builder:
  //                                       (context) =>
  //                                       TopUpPage(),
  //                                 ),
  //                               );
  //                             },
  //                           ),
  //                         ],
  //                       ),
  //                 );
  //               }
  //             });
  //       }
  //     } catch (e) {
  //       print(e);
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Maaf, Terjadi sebuah kesalahan'),
  //         ),
  //       );
  //     }
  //   });
  // }

  // void _showConfirmationDialog() async {
  //   await showPlatformDialog(
  //     context: context,
  //     builder: (_) => Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: BasicDialogAlert(
  //         title: Text("Konfirmasi Upload Gambar"),
  //         content: Text("Apakah Anda ingin mengunggah gambar?"),
  //         actions: <Widget>[
  //           BasicDialogAction(
  //             title: Text("Tidak"),
  //             onPressed: () {
  //               Navigator.pop(context);
  //               Navigator.pop(context);
  //             },
  //           ),
  //           BasicDialogAction(
  //             title: Text("Ya"),
  //             onPressed: () async {
  //               Navigator.pop(context);
  //               await _uploadAndConvertImage();
  //             },
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Future<void> _uploadAndConvertImage() async {
  //   final image = await ImagePicker().getImage(source: ImageSource.camera);
  //   setState(() async {
  //     if (image != null) {
  //       _image = File(image.path);
  //       final img.Image? resizedImage = await resizeImage(_image!);
  //
  //       if (resizedImage != null) {
  //         setState(() {
  //           _image = File(image.path);
  //           _imageBase64 = base64Encode(img.encodeJpg(resizedImage));
  //           _selfie();
  //         });
  //       }
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

  Future<img.Image?> resizeImage(File imageFile) async {
    final img.Image? originalImage = img.decodeImage(await imageFile.readAsBytes());
    if (originalImage != null) {
      final img.Image resizedImage = img.copyResize(originalImage, width: 800);
      return resizedImage;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.green,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(CupertinoIcons.back, color: Colors.white),
          ),
          title: Text(
            'Deposit',
            style: TextConstant.regular.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white
            ),
          ),
        ),
        body: SingleChildScrollView(
          // decoration: BoxDecoration(
          //     color: AppColors.primarycolors,
          //     borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 0),
                Text(
                  'Rekomendasi Deposit',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
                SizedBox(height: 10),
                GridView.count(
                  // primary: false,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0),
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  crossAxisCount: 3,
                  children: [
                    AppRecomenNominal(
                        image: ImageConstant.receh,
                        nominal: 'Rp.50.000',
                        onTap: () {
                          setState(() {
                            toupcontroller.recomenNominal.text = '50,000';
                            recomenNominal = '50000';
                            recomenNominalxx = '50,000';
                            _updateRecomenNominal();
                          });
                        }),
                    AppRecomenNominal(
                        image: ImageConstant.recehsedikit,
                        nominal: 'Rp.100.000',
                        onTap: () {
                          setState(() {
                            toupcontroller.recomenNominal.text = '100,000';
                            recomenNominal = '100000';
                            recomenNominalxx = '100,000';
                            _updateRecomenNominal();
                          });
                        }),
                    AppRecomenNominal(
                        image: ImageConstant.uangkertas,
                        nominal: 'Rp.500.000',
                        onTap: () {
                          setState(() {
                            toupcontroller.recomenNominal.text = '500,000';
                            recomenNominal = '500000';
                            recomenNominalxx = '500,000';
                            _updateRecomenNominal();
                          });
                        }),
                    AppRecomenNominal(
                        image: ImageConstant.uangkertasaja,
                        nominal: 'Rp.1.000.000',
                        onTap: () {
                          setState(() {
                            toupcontroller.recomenNominal.text = '1,000,000';
                            recomenNominal = '1000000';
                            recomenNominalxx = '1,000,000';
                            _updateRecomenNominal();
                          });
                        }),
                    AppRecomenNominal(
                        image: ImageConstant.uangkertas2,
                        nominal: 'Rp.5.000.000',
                        onTap: () {
                          setState(() {
                            toupcontroller.recomenNominal.text = '5,000,000';
                            recomenNominal = '5000000';
                            recomenNominalxx = '5,000,000';
                            _updateRecomenNominal();
                          });
                        }),
                    AppRecomenNominal(
                        image: ImageConstant.uangkertasbanyak,
                        nominal: 'Rp.10.000.000',
                        onTap: () {
                          setState(() {
                            toupcontroller.recomenNominal.text = '10,000,000';
                            recomenNominal = '10000000';
                            recomenNominalxx = '10,000,000';
                            _updateRecomenNominal();
                          });
                        }),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Nominal Deposit',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: width,
                  child: TextField(
                    // readOnly: true,
                    // textAlign: TextAlign.right,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      ThousandsFormatter(),
                    ],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                    controller: toupcontroller.recomenNominal,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.payments_outlined,
                        color: Colors.black,
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: recomenNominalxx != null
                          ? recomenNominalxx
                          : 'Ketik Nominal',
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
                ),
                SizedBox(height: 30),
                SizedBox(height: 10),
                ButtonGreenWidget(
                  text: 'Lanjut',
                  onClick: ()
                    async {
                      // print('faisklik $recomenNominal');
                      if (recomenNominalxx == null || recomenNominalxx == '') {
                        DialogConstant.alertError('Nominal tidak boleh kosong');
                        return;
                      } else {
                        Get.to(ConfirmPage(recomenNominal: recomenNominal));
                      }
                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
