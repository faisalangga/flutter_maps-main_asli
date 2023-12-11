import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:koperasimobile/screen/home/landing_home.dart';
import 'package:lottie/lottie.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../constant/image_constant.dart';
import '../../../constant/text_constant.dart';
import '../../../constant/utils_rp.dart';

class CetakTabunganPage extends StatefulWidget {
  final String? docno;
  final Future<Map<String, dynamic>> value;

  CetakTabunganPage({this.docno, required this.value});

  @override
  State<CetakTabunganPage> createState() => _CetakTabunganPageState();
}

class _CetakTabunganPageState extends State<CetakTabunganPage> {
  String? member, Value1, tgl, input;
  String? saldo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
  }

  void fetch() async {
    Map<String, dynamic> result = await widget.value;
    setState(() {
      DateTime dateTime = DateTime.now();
      member = result['member'];
      Value1 = result['value'];
      input = result['cinput'];
      tgl = DateFormat('dd-MM-yyyy').format(dateTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = MediaQuery.of(context).size.width;
    // var saldoString  = saldo;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        // leading: GestureDetector(
        //   onTap: () {
        //     Navigator.pop(context);
        //   },
        //   child: Icon(CupertinoIcons.back, color: Colors.white),
        // ),
        title: Text(
          'Detail Tabungan #${widget.docno}',
          style: TextConstant.regular.copyWith(
              fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Lottie.asset(
              ImageConstant.berhasil,
              fit: BoxFit.contain,
              height: 200,
              width: width,
            ),
            Text(
              'Terima Kasih!',
              style: TextConstant.regular.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlue.shade500,
                  fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Tabungan anda berhasil Ditambahkan...',
              style: TextConstant.regular.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                  fontSize: 18),
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Colors.grey.shade300,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          'Detail Transaksi',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: size.height * 0.018,
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
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tanggal Transaksi',
                      style: TextConstant.regular.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade500,
                          fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '$tgl',
                      style: TextConstant.regular.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ID Document',
                      style: TextConstant.regular.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade500,
                          fontSize: 18),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '${widget.docno}',
                      style: TextConstant.regular.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ID Nasabah',
                      style: TextConstant.regular.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade500,
                          fontSize: 18),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '$member',
                      style: TextConstant.regular.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nama Nasabah',
                      style: TextConstant.regular.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade500,
                          fontSize: 18),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '$input',
                      style: TextConstant.regular.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nilai Transaksi',
                      style: TextConstant.regular.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade500,
                          fontSize: 18),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '${rupiah(Value1!)}',
                      style: TextConstant.regular.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: width*0.5,
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),//
                    onPressed: () {
                      _printPDF(context);
                    },
                    child: Text('Cetak PDF'),
                  ),
                ),
                Container(
                  width: width*0.5,
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),//
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => LandingHome()),
                            (route) => false,
                      );
                    },
                    child: Text('Tutup Halaman'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _printPDF(BuildContext context) async {
    final pdf = pw.Document();
    var width = MediaQuery.of(context).size.width;
    final Uint8List svgData = (await rootBundle.load('assets/images/logokoperasihtmpth.png'))
        .buffer
        .asUint8List();
    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Center(
            child: pw.Column(
              children: [
                pw.SizedBox(height: 20),
                pw.Container(
                  width: width,
                  child: pw.Padding(
                    padding: pw.EdgeInsets.symmetric(horizontal: 20),
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Image(
                          pw.MemoryImage(svgData),
                          width: width * 0.2,
                          height: width * 0.2,
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          'Sukses Prima Sejahtera',
                          style: pw.TextStyle(
                            fontSize: 20,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                        pw.SizedBox(height: 30),
                        pw.Container(
                          alignment: pw.Alignment.center,
                          child:
                          pw.Text('Tanda bukti transaksi',style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold,)),
                        ),
                        pw.Divider(height: 1),
                        pw.SizedBox(height: 30),
                        pw.Text('Hi, $input'),
                        pw.SizedBox(height: 3),
                        pw.Text('Terima kasih telah menabung di koperasi Sukses prima sejahtera'),
                        pw.SizedBox(height: 20),
                        pw.Container(width: width,padding:pw.EdgeInsets.symmetric(vertical: 10,horizontal: 5),color: PdfColors.grey300,child: pw.Text('Detail transaksi tabungan'),),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          'Tanggal Transaksi',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromInt(Colors.grey.shade500.value),
                            fontSize: 18,
                          ),
                        ),
                        pw.SizedBox(height: 5),
                        pw.Text(
                          '$tgl',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromInt(Colors.black87.value),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Container(
                  width: width,
                  child: pw.Padding(
                    padding: pw.EdgeInsets.symmetric(horizontal: 20),
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'ID Document',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromInt(Colors.grey.shade500.value),
                            fontSize: 18,
                          ),
                        ),
                        pw.SizedBox(height: 5),
                        pw.Text(
                          '${widget.docno}',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromInt(Colors.black87.value),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Container(
                  width: width,
                  child: pw.Padding(
                    padding: pw.EdgeInsets.symmetric(horizontal: 20),
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'ID Nasabah',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromInt(Colors.grey.shade500.value),
                            fontSize: 18,
                          ),
                        ),
                        pw.SizedBox(height: 5),
                        pw.Text(
                          '$member',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromInt(Colors.black87.value),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Container(
                  width: width,
                  child: pw.Padding(
                    padding: pw.EdgeInsets.symmetric(horizontal: 20),
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Nama Nasabah',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromInt(Colors.grey.shade500.value),
                            fontSize: 18,
                          ),
                        ),
                        pw.SizedBox(height: 5),
                        pw.Text(
                          '$input',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromInt(Colors.black87.value),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Container(
                  width: width,
                  child: pw.Padding(
                    padding: pw.EdgeInsets.symmetric(horizontal: 20),
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Nilai Transaksi',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromInt(Colors.grey.shade500.value),
                            fontSize: 18,
                          ),
                        ),
                        pw.SizedBox(height: 5),
                        pw.Text(
                          '${rupiah(Value1!)}',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromInt(Colors.black87.value),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Container(
                  width: width,
                  child: pw.Padding(
                    padding: pw.EdgeInsets.symmetric(horizontal: 20),
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Text(
                          'Jl.Ahmad Yani No. C-09',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromInt(Colors.grey.shade500.value),
                            fontSize: 10,
                          ),
                        ),
                        pw.Text(
                          'Keboansikep, Gedangan, Sidoarjo, Jawa Timur (61254)',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromInt(Colors.grey.shade500.value),
                            fontSize: 10,
                          ),
                        ),
                        pw.Text(
                          'HP 082144492236, Email: koperasi.sps8@gmail.com',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColor.fromInt(Colors.grey.shade500.value),
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
    // Mencetak PDF
    final output = await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );

    if (output != null) {
      final uint8list = Uint8List.fromList(output as List<int>);
      await Printing.sharePdf(bytes: uint8list);
    }
  }
}
