import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:koperasimobile/widget/app_nodata.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';
import '../../../../api/api.dart';
import '../../../../constant/const_url.dart';
import '../../../../constant/dialog_constant.dart';
import '../../../../constant/image_constant.dart';
import '../../../../constant/utils_date.dart';
import '../../../../constant/utils_rp.dart';

class ReportSimpGlobalScreen extends StatefulWidget {
  final String ccustcode;
  final String branch;
  final String nama;
  final String nmlengkap;

  ReportSimpGlobalScreen(
      {required this.ccustcode,
        required this.branch,
        required this.nama,
        required this.nmlengkap});

  @override
  State<ReportSimpGlobalScreen> createState() => _ReportSimpGlobalScreenState();
}

class _ReportSimpGlobalScreenState extends State<ReportSimpGlobalScreen> {
  late String ccustcode;
  late String cdocno;
  late String cnama;
  late String netto;
  late String payment;
  late String sisa;
  late String tgltrans;
  double totalNetto = 0.0;
  double totalPayment = 0.0;
  double totalSisa = 0.0;
  bool isFetch = false;
  List<Map<String, dynamic>> dataList = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      fetchData();
    });
  }

  Future<void> fetchData() async {
    try {
      DialogConstant.loading(context!, 'Mohon Tunggu...');
      Map<String, String> header = {'Content-Type': 'application/json'};
      Map<String, dynamic> post = {
        "ccustcode": "${widget.ccustcode}",
        "branch": "${widget.branch}",
        "nama": "${widget.nama}"
      };
      await API.basePostGolang(
        ConstUrl.cetaksimpanan,
        post,
        header,
        true,
            (result, error) {
          if (error != null) {
            Navigator.pop(context);
            print('Error fetching saldo inifais: $error');
          } else {
            if (result != null) {
              if (result['status'] == '1') {
                final item = result['data'][0];
                if (item != null) {
                  Navigator.pop(context);
                  setState(() {
                    isFetch = true;
                    dataList = List.from(result['data']); // Update dataList
                    for (int i = 0; i < dataList.length; i++) {
                      final item = dataList[i];
                      ccustcode = item['ccustcode'];
                      cdocno = item['cdocno'];
                      cnama = item['cnama'];
                      netto = item['netto'];
                      payment = item['payment'];
                      sisa = item['sisa'];
                      tgltrans = item['tgltrans'];

                      // Menghitung subtotal
                      totalNetto += double.parse(netto);
                      totalPayment += double.parse(payment);
                      totalSisa += double.parse(sisa);
                    }
                  });
                } else {
                  Navigator.pop(context);
                  setState(() {
                    isFetch = false;
                  });
                }
              } else {
                print('fais cust Failed to fetch data: ${result['pesan']}');
              }
            } else {
              print('fais cust Failed to fetch data. Result is null.');
            }
          }
        },
      );
    } catch (error) {
      Navigator.pop(context);
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Report Simpanan Global',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf_rounded, color: Colors.green),
            onPressed: () {
              _printPDF(context);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: width,
            height: height,
            // color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.all(70.0),
              child: Image.asset(
                ImageConstant.cart_logo,
                color: Colors.white10.withOpacity(0.1),
                colorBlendMode: BlendMode.dstATop,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: isFetch
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Divider(
                    height: 1,
                    color: Colors.black,
                  ),
                  DataTable(
                    columnSpacing: width / height * 15,
                    horizontalMargin: 5.0,
                    columns: [
                      DataColumn(
                        label: Container(
                          width: width * 0.15,
                          child: Center(child: Text('No. Dok')),
                        ),
                      ),
                      DataColumn(
                        label: Container(
                          width: width * 0.15,
                          child: Center(child: Text('Tgl Trans')),
                        ),
                      ),
                      DataColumn(
                        label: Container(
                          width: width * 0.1,
                          child: Center(child: Text('Netto')),
                        ),
                        numeric: true,
                      ),
                      DataColumn(
                        label: Container(
                          width: width * 0.1,
                          child: Center(child: Text('Pay')),
                        ),
                        numeric: true,
                      ),
                      DataColumn(
                        label: Container(
                          width: width * 0.1,
                          child: Center(child: Text('Sisa')),
                        ),
                        numeric: true,
                      ),
                    ],
                    rows: [
                      for (var i = 0; i < dataList.length; i++)
                        DataRow(cells: [
                          DataCell(
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                dataList[i]['cdocno'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                UtilsDate.tanggalHariIni(
                                    dataList[i]['tgltrans']),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                duet(dataList[i]['netto']),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                duet(dataList[i]['payment']),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                duet(dataList[i]['sisa']),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ),
                        ]),
                      DataRow(cells: [
                        DataCell(
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Subtotal',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        DataCell(Container()),
                        DataCell(
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              duet(totalNetto.toString()),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              duet(totalPayment.toString()),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        DataCell(
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              duet(totalSisa.toString()),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ],
                  ),
                  Divider(
                    height: 1,
                    color: Colors.black,
                  ),
                ],
              )
                  : AppNoData(ket: 'Tidak ada data'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _printPDF(BuildContext context) async {
    if (dataList.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Peringatan",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            content: Text("Tidak ada data untuk dicetak.",style: TextStyle(
              fontSize: 15,)),
            contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
            actions: [
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(height: 1),
                    SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Center(
                          child: Text(
                            "OK",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
      return;
    }
    final pdf = pw.Document();
    var width = MediaQuery.of(context).size.width + 200;
    var height = MediaQuery.of(context).size.height;
    final Uint8List svgData =
    (await rootBundle.load('assets/images/15-koperasi.png'))
        .buffer
        .asUint8List();
    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Stack(children: [
            pw.Container(
              // color: PdfColors.red,
                height: height,
                width: width,
                child: pw.Padding(
                  padding: pw.EdgeInsets.symmetric(horizontal: 60),
                  child: pw.Image(
                    pw.MemoryImage(svgData),
                    fit: pw.BoxFit.fitWidth,
                    alignment: pw.Alignment.center,
                  ),
                )),
            // for (var i = 0; i < dataList.length; i++)
            pw.Container(
              // margin: pw.EdgeInsets.only(top: i == 0 ? 0 : 30),
              margin: pw.EdgeInsets.only(top: 0),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.SizedBox(height: 20),
                  pw.Text(
                    'Nama Member : ${widget.nmlengkap}',
                    style: pw.TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  pw.SizedBox(height: 5),
                  pw.Text(
                    'Member Code  : ${widget.ccustcode}',
                    style: pw.TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  pw.SizedBox(height: 5),
                  pw.Text(
                    'Tanggal Cetak : ${DateFormat('dd-MM-yyyy').format(DateTime.now())}',
                    style: pw.TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  pw.SizedBox(height: 5),
                ],
              ),
            ),
            pw.Center(
              child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Text('** Report Simpanan **',
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                      )),
                  pw.SizedBox(height: 60),
                  pw.Table(
                    border: pw.TableBorder.all(),
                    columnWidths: {
                      0: pw.FixedColumnWidth(width * 0.15),
                      1: pw.FixedColumnWidth(width * 0.15),
                      2: pw.FixedColumnWidth(width * 0.1),
                      3: pw.FixedColumnWidth(width * 0.1),
                      4: pw.FixedColumnWidth(width * 0.1),
                    },
                    children: [
                      pw.TableRow(
                        children: [
                          pw.Center(child: pw.Text('No. Dokumen')),
                          pw.Center(child: pw.Text('Tgl Trans')),
                          pw.Center(child: pw.Text('Netto')),
                          pw.Center(child: pw.Text('Pay')),
                          pw.Center(child: pw.Text('Sisa')),
                        ],
                      ),
                      for (var i = 0; i < dataList.length; i++)
                        pw.TableRow(
                          children: [
                            pw.Center(
                              child: pw.Text(
                                dataList[i]['cdocno'],
                                style: pw.TextStyle(
                                  color: PdfColor.fromInt(Colors.black.value),
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                            pw.Center(
                              child: pw.Text(
                                UtilsDate.tanggalHariIni(
                                  dataList[i]['tgltrans'],
                                ),
                                style: pw.TextStyle(
                                  color: PdfColor.fromInt(Colors.black.value),
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                            pw.Center(
                              child: pw.Text(
                                duet(dataList[i]['netto']),
                                style: pw.TextStyle(
                                  color: PdfColor.fromInt(Colors.black.value),
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                            pw.Center(
                              child: pw.Text(
                                duet(dataList[i]['payment']),
                                style: pw.TextStyle(
                                  color: PdfColor.fromInt(Colors.black.value),
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                            pw.Center(
                              child: pw.Text(
                                duet(dataList[i]['sisa']),
                                style: pw.TextStyle(
                                  color: PdfColor.fromInt(Colors.black.value),
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      pw.TableRow(
                        children: [
                          pw.Center(child: pw.Text('')),
                          pw.Center(child: pw.Text('Subtotal')),
                          pw.Center(
                            child: pw.Text(
                              duet(totalNetto.toString()),
                              style: pw.TextStyle(
                                color: PdfColor.fromInt(Colors.black.value),
                                fontSize: 12.0,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                          pw.Center(
                            child: pw.Text(
                              duet(totalPayment.toString()),
                              style: pw.TextStyle(
                                color: PdfColor.fromInt(Colors.black.value),
                                fontSize: 12.0,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                          pw.Center(
                            child: pw.Text(
                              duet(totalSisa.toString()),
                              style: pw.TextStyle(
                                color: PdfColor.fromInt(Colors.black.value),
                                fontSize: 12.0,
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]);
        },
      ),
    );
    final output = await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );

    if (output != null) {
      final uint8list = Uint8List.fromList(output as List<int>);
      await Printing.sharePdf(bytes: uint8list);
    }
  }
}
