import 'dart:convert';
import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:koperasimobile/constant/const_url.dart';
import 'package:koperasimobile/constant/decoration_constant.dart';
import 'package:koperasimobile/constant/dialog_constant.dart';
import 'package:koperasimobile/constant/text_constant.dart';
import 'package:koperasimobile/controller/member_controller.dart';
import 'package:koperasimobile/model/model_dataProvider.dart';
import 'package:koperasimobile/model/model_kec.dart';
import 'package:koperasimobile/model/model_niknama.dart';
import 'package:koperasimobile/utils/utils_dialog.dart';
import 'package:koperasimobile/widget/material/button_green_widget.dart';

import '../../../model/mode_setupbank.dart';
import '../../../model/model_cabang.dart';
import '../../../model/model_company.dart';
import '../../../model/model_dataProvider2.dart';
import '../../../model/model_desa.dart';
import '../../../model/model_desa2.dart';
import '../../../model/model_kota.dart';
import '../../../model/model_kota2.dart';
import '../../../widget/app_dropdown.dart';
import '../login_screen.dart';

class SuppUpdScreen extends StatefulWidget {
  final String tipeCheck;
  final String memberID;

  const SuppUpdScreen({Key? key, required this.tipeCheck, required this.memberID}) : super(key: key);

  @override
  State<SuppUpdScreen> createState() => _SuppScreenState();
}

class _SuppScreenState extends State<SuppUpdScreen> {
  MemberController membercontroller = MemberController();

  File? _image;
  String? _imageBase64;
  File? _imageFile;
  String? _base64Image;
  String selectedDuration = 'Laki-laki';

  String? Gender() {
    return selectedDuration.substring(0, 1);
  }

  DateTime newTime = DateTime.now();
  DateTime oldTime = DateTime.now();

  Future<bool> onBackPress() async {
    return await UtilsDialog.onBackPressConfirm(context);
  }

  Future<void> _getImage() async {
    // ignore: deprecated_member_use
    final image = await ImagePicker().getImage(source: ImageSource.camera);
    setState(() async {
      if (image != null) {
        _image = File(image.path);
        final img.Image? resizedImage = await resizeImage(_image!);

        if (resizedImage != null) {
          setState(() {
            _image = File(image.path);
            _imageBase64 = base64Encode(img.encodeJpg(resizedImage));
            _selfie();
          });
        }
        // print('bukanpais');
      } else {
        print('No image selected.');
      }
    });
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

  Future<String> getKodepos(String cDesa) async {
    var requestMap = {
      "cPropinsi": provinsiSelected,
      "cKota": kotaselected,
      "cKecamatan": kecamatanselected,
      "cDesa": "$_desa1",
      "cKodepos": ""
    };

    var response = await http.post(
      Uri.parse("${ConstUrl.BASE_URL_GOLANG}${ConstUrl.kodepost}"),
      body: json.encode(requestMap),
      headers: {"Content-Type": "application/json"},
    );

    var data = (json.decode(response.body) as Map<String, dynamic>);
    var cKodepos = data['data'][0]['cKodepos'];
    // print('fais '+ cKodepos);

    return cKodepos;
  }

  Future<String> getKodepos2(String cDesa2) async {
    var requestMap = {
      "cPropinsi": provinsiSelected2,
      "cKota": kotaselected2,
      "cKecamatan": kecamatanselected2,
      "cDesa": "$_desa2",
      "cKodepos": ""
    };

    var response = await http.post(
      Uri.parse("${ConstUrl.BASE_URL_GOLANG}${ConstUrl.kodepost}"),
      body: json.encode(requestMap),
      headers: {"Content-Type": "application/json"},
    );

    var data2 = (json.decode(response.body) as Map<String, dynamic>);
    var cKodepos2 = data2['data'][0]['cKodepos'];
    // print('fais '+ cKodepos2);

    return cKodepos2;
  }

  void _selfie() async {
    setState(() {
      try {
        if (_imageBase64 == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Kesalahan Saat Ambil Gambar'),
            ),
          );
        } else {
          membercontroller.fotoSelfie.value = _imageBase64!;
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

  Future<Map<String, dynamic>> _getValue() async {
    Map<String, dynamic> data = {
      'compcode': _valueCompSelected,
      'cbranch': _valueCbgSelected,
      'inidate': _valueDateSelected,
      'switchValue': _switchValue,
      'jenkel': Gender(),
    };
    // print('fais data : $data');
    return data;
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
          membercontroller.fotoID.value = _base64Image!;
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

  set namaCompany(String? namaCompany) {}
  set namaCabang(String? namaCabang) {}
  set namaProvinsi(String? namaProvinsi) {}
  set namaKota(String? namaKota) {}
  set namaKecamatan(String? namaKecamatan) {}
  set namaKodepos(String? namaKodepos) {}

  DataCompany? _company;
  String? _valueCompSelected;
  String? _valueCbgSelected;
  String? _valueNamaSelected;
  String? _valueDateSelected;
  String? kodepos;
  String? kodepos2;
  DataCabang? _cabang;
  Dataniknama? _nik;
  Provinsi? _provinsi;
  Kota? _kota;
  Kecamatan? _kecamatan;
  Desa? _desa1;
  // Kodepos? _kdpos;

  Provinsi2? _provinsi2;
  Kota2? _kota2;
  Kecamatan2? _kecamatan2;
  Desa2? _desa2;

  // Kodepos2? _kdpos2;
  String? provinsiSelected;
  String? provinsiSelected2;
  String? kotaselected;
  String? kotaselected2;
  String? kecamatanselected;
  String? kecamatanselected2;
  String? desaselected;
  String? desaselected2;
  String? kodeposselected;
  String? kodeposselected2;

  int id = 1;
  bool _switchValue = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    // print(widget.tipeCheck);
  }

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(CupertinoIcons.back, color: Colors.black),
          ),
          centerTitle: true,
          title: Text(
            'Update Data Member',
            style: TextConstant.regular.copyWith(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Karyawan',
                            style: TextConstant.regular.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                                fontSize: 15),
                          ),
                          Row(
                            children: [
                              _switchValue == false
                                  ? Text(
                                'Tidak',
                                style: TextConstant.regular.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 11),
                              )
                                  : Text(
                                'Ya',
                                style: TextConstant.regular.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                    fontSize: 11),
                              ),
                              Switch(
                                value: _switchValue,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    _switchValue = newValue;
                                  });
                                },
                                activeColor: Colors.green,
                                inactiveTrackColor: Colors.red,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: _switchValue,
                  child: SizedBox(height: 8),
                ),
                Visibility(
                    visible: _switchValue,
                    child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Kode Perusahaan',
                              style: TextConstant.regular.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                  fontSize: 15),
                            ),
                            SizedBox(height: 10),
                            DropdownSearch<DataCompany>(
                              popupProps: PopupProps.dialog(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  controller: membercontroller.edtcomp,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.phonelink_erase_outlined),
                                      onPressed: () {
                                        membercontroller.edtcomp.clear();
                                      },
                                    ),
                                  ),
                                ),
                                itemBuilder: (context, item, isSelected) =>
                                    ListTile(
                                      title: Text(item.cdesc.toString()),
                                    ),
                              ),
                              compareFn: (item, _company) =>
                              item.cCompcode == _company.cCompcode,
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(),
                              ),
                              onChanged: (data) {
                                setState(() {
                                  _company = data;
                                  membercontroller.edtcomp.text =
                                      data!.cdesc.toString();
                                  _valueCompSelected = data.cCompcode.toString();
                                  // print('fais $_valueCompSelected');
                                });
                              },
                              selectedItem: _company,
                              itemAsString: (DataCompany item) =>
                                  item.cdesc.toString(),
                              dropdownBuilder: (context, selectedItem) => Text(
                                  selectedItem?.cdesc ?? 'Belum pilih Perusahaan'),
                              asyncItems: (text) async {
                                var requestMap = {"cCompcode": "", "cdesc": ""};
                                var response = await http.post(
                                  Uri.parse(
                                      "${ConstUrl.BASE_URL_GOLANG}${ConstUrl.compcode}"),
                                  body: json.encode(requestMap),
                                  headers: {"Content-Type": "application/json"},
                                );
                                List company = (json.decode(response.body)
                                as Map<String, dynamic>)['data'];
                                List<DataCompany> modelcompany = [];
                                company.forEach((element) {
                                  modelcompany.add(DataCompany(
                                    cCompcode: element['cCompcode'],
                                    cdesc: element['cdesc'],
                                  ));
                                });
                                return modelcompany;
                              },
                            ),
                          ],
                        ))),
                Visibility(
                  visible: _switchValue,
                  child: SizedBox(height: 8),
                ),
                Visibility(
                    visible: _switchValue,
                    child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Kode Cabang',
                              style: TextConstant.regular.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                  fontSize: 15),
                            ),
                            SizedBox(height: 10),
                            DropdownSearch<DataCabang>(
                              popupProps: PopupProps.dialog(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  controller: membercontroller.edtcabang,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.phonelink_erase_outlined),
                                      onPressed: () {
                                        membercontroller.edtcabang.clear();
                                      },
                                    ),
                                  ),
                                ),
                                itemBuilder: (context, item, isSelected) =>
                                    ListTile(
                                      title: Text(item.cdesc.toString()),
                                    ),
                              ),
                              compareFn: (item, _cabang) =>
                              item.cBranch == _cabang.cBranch,
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(),
                              ),
                              onChanged: (data) {
                                setState(() {
                                  _cabang = data;
                                  membercontroller.edtcabang.text =
                                      data!.cdesc.toString();
                                  _valueCbgSelected = data.cBranch.toString();
                                });
                              },
                              selectedItem: _cabang,
                              enabled: _company != null,
                              itemAsString: (DataCabang item) =>
                                  item.cdesc.toString(),
                              dropdownBuilder: (context, selectedItem) => Text(
                                selectedItem?.cdesc ?? 'Belum pilih Cabang',
                                style: TextStyle(
                                    color: _company != null
                                        ? Colors.black
                                        : Colors.grey),
                              ),
                              asyncItems: (text) async {
                                var requestMap = {"cCompcode": _valueCompSelected};
                                var response = await http.post(
                                  Uri.parse(
                                      "${ConstUrl.BASE_URL_GOLANG}${ConstUrl.cabang}"),
                                  body: json.encode(requestMap),
                                  headers: {"Content-Type": "application/json"},
                                );
                                // print( 'fais  ${ConstUrl.BASE_URL_GOLANG}${ConstUrl.cabang}?cCompcode=$_valueCompSelected') ;
                                List cabang = (json.decode(response.body)
                                as Map<String, dynamic>)['data'];
                                List<DataCabang> modelCabang = [];
                                cabang.forEach((element) {
                                  modelCabang.add(DataCabang(
                                    cBranch: element['cBranch'],
                                    cdesc: element['cdesc'],
                                  ));
                                });
                                return modelCabang;
                              },
                            ),
                          ],
                        ))),
                Visibility(
                  visible: _switchValue,
                  child: SizedBox(height: 8),
                ),
                Visibility(
                    visible: _switchValue,
                    child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nik Karyawan',
                              style: TextConstant.regular.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                  fontSize: 15),
                            ),
                            SizedBox(height: 10),
                            DropdownSearch<Dataniknama>(
                              popupProps: PopupProps.dialog(
                                showSearchBox: true,
                                searchFieldProps: TextFieldProps(
                                  controller: membercontroller.edtnikK,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(Icons.phonelink_erase_outlined),
                                      onPressed: () {
                                        membercontroller.edtnikK.clear();
                                      },
                                    ),
                                  ),
                                ),
                                itemBuilder: (context, item, isSelected) =>
                                    ListTile(
                                      title: Text(item.nik.toString()),
                                      subtitle: Text(item.nama.toString()),
                                    ),
                              ),
                              compareFn: (item, _nik) =>
                              (item.nik == _nik.nik) ||
                                  (item.nama == _nik.nama),
                              dropdownDecoratorProps: DropDownDecoratorProps(
                                dropdownSearchDecoration: InputDecoration(),
                              ),
                              onChanged: (data) {
                                setState(() {
                                  _nik = data;
                                  membercontroller.edtnikK.text =
                                      data!.nik.toString();
                                  _valueNamaSelected = data.nama.toString();
                                  // print ('fais nik : $_valueNamaSelected' + data!.nik.toString() );
                                  // print('fais  + $_nik');
                                });
                              },
                              // selectedItem: _nik,
                              selectedItem: _nik,
                              enabled: _cabang != null,
                              itemAsString: (Dataniknama item) {
                                // print('fais item nama ${item.nama}');
                                // print('fais item nik  ${item.nik}');
                                return item.nik.toString();
                              },
                              dropdownBuilder: (context, selectedItem) => Text(
                                selectedItem?.nik ?? 'Belum pilih Nik',
                                style: TextStyle(
                                    color: _cabang != null
                                        ? Colors.black
                                        : Colors.grey),
                              ),
                              asyncItems: (text) async {
                                var requestMap = {"cbranch": _valueCbgSelected};
                                var response = await http.post(
                                  Uri.parse(
                                      "${ConstUrl.BASE_URL_GOLANG}${ConstUrl.nik}"),
                                  body: json.encode(requestMap),
                                  headers: {"Content-Type": "application/json"},
                                );
                                // print( 'fais  ${ConstUrl.BASE_URL_GOLANG}${ConstUrl.cabang}?cbranch=$_valueCbgSelected') ;
                                List niknama = (json.decode(response.body)
                                as Map<String, dynamic>)['data'];
                                List<Dataniknama> modelNiknama = [];
                                niknama.forEach((element) {
                                  modelNiknama.add(Dataniknama(
                                    nik: element['nik'],
                                    nama: element['nama'],
                                  ));
                                });
                                return modelNiknama;
                              },
                            ),
                          ],
                        ))),
                Visibility(
                  visible: _switchValue,
                  child: SizedBox(height: 8),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Username',
                        style: TextConstant.regular.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            fontSize: 15),
                      ),
                      Container(
                        height: 40,
                        child: TextField(
                          maxLength: 15,
                          controller: membercontroller.edtnamapgl,
                          // readOnly: _valueNamaSelected != null,
                          keyboardType: TextInputType.text,
                          decoration: DecorationConstant.inputDecor().copyWith(
                              hintText: "Masukkan Username",
                              counterText: '',
                              contentPadding: EdgeInsets.only(top: 0)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nama Lengkap Anggota',
                        style: TextConstant.regular.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            fontSize: 15),
                      ),
                      Container(
                        height: 40,
                        child: TextField(
                          maxLength: 50,
                          controller: membercontroller.edtnama
                            ..text = _valueNamaSelected ?? '',
                          readOnly: _valueNamaSelected != null,
                          keyboardType: TextInputType.text,
                          decoration: DecorationConstant.inputDecor().copyWith(
                              hintText: "Masukkan Nama",
                              counterText: '',
                              contentPadding: EdgeInsets.only(top: 0)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tempat Lahir',
                        style: TextConstant.regular.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            fontSize: 15),
                      ),
                      Container(
                        height: 40,
                        child: TextField(
                          maxLength: 16,
                          controller: membercontroller.edttempat,
                          keyboardType: TextInputType.text,
                          decoration: DecorationConstant.inputDecor().copyWith(
                              hintText: "Masukkan Tempat lahir",
                              counterText: '',
                              contentPadding: EdgeInsets.only(top: 0)),
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "Tanggal Lahir",
                                style: TextConstant.regular.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              child: TextField(
                                onTap: () async {
                                  var datePicked =
                                  await DatePicker.showSimpleDatePicker(
                                    context,
                                    initialDate: DateTime(1990),
                                    firstDate: DateTime(1950),
                                    lastDate: DateTime(2500),
                                    titleText: 'Pilih Tanggal',
                                    confirmText: 'Pilih',
                                    cancelText: 'Batal',
                                    dateFormat: "dd-MMMM-yyyy",
                                    locale: DateTimePickerLocale.id,
                                    looping: false,
                                  );
                                  if (datePicked != null) {
                                    membercontroller.edttgl.text =
                                        DateFormat('dd/MM/yyyy')
                                            .format(datePicked);
                                    setState(() {
                                      _valueDateSelected =
                                          DateFormat('yyyy-MM-dd')
                                              .format(datePicked);
                                    });
                                  }
                                },
                                maxLength: 16,
                                controller: membercontroller.edttgl,
                                keyboardType: TextInputType.phone,
                                readOnly: true,
                                decoration: DecorationConstant.inputDecor()
                                    .copyWith(
                                    hintText: "Masukkan Tanggal lahir",
                                    counterText: '',
                                    contentPadding:
                                    EdgeInsets.only(top: 0)),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jenis Kelamin',
                        style: TextConstant.regular.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        height: 57,
                        child: AppDropdown<String>(
                          value: selectedDuration,
                          onChanged: (newValue) {
                            setState(() {
                              selectedDuration = newValue!;
                              // print('faisxx $selectedDuration');
                              print(Gender());
                            });
                          },
                          items: <String>['Laki-laki', 'Perempuan']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          hint: 'Pilih jenis Kelamin',
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'NIK KTP',
                        style: TextConstant.regular.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            fontSize: 15),
                      ),
                      Container(
                        height: 40,
                        child: TextField(
                          maxLength: 16,
                          controller: membercontroller.edtnik,
                          keyboardType: TextInputType.phone,
                          decoration: DecorationConstant.inputDecor().copyWith(
                              hintText: "Masukkan No KTP",
                              counterText: '',
                              contentPadding: EdgeInsets.only(top: 0)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Password',
                        style: TextConstant.regular.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            fontSize: 15),
                      ),
                      Container(
                        height: 40,
                        child: TextField(
                          maxLength: 10,
                          controller: membercontroller.edtpassword,
                          obscureText: _obscureText,
                          decoration: DecorationConstant.inputDecor().copyWith(
                            hintText: "Masukkan Kata Sandi",
                            counterText: '',
                            contentPadding: EdgeInsets.only(top: 10),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                            suffixIconColor: Colors.grey.shade500,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Status Pekerjaan',
                        style: TextConstant.regular.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            fontSize: 15),
                      ),
                      Container(
                        height: 40,
                        child: TextField(
                          maxLength: 30,
                          controller: membercontroller.edtpekerjaan,
                          keyboardType: TextInputType.text,
                          decoration: DecorationConstant.inputDecor().copyWith(
                              hintText: "Masukkan Pekerjaan Anda",
                              counterText: '',
                              contentPadding: EdgeInsets.only(top: 0)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Alamat (KTP)',
                        style: TextConstant.regular.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            fontSize: 15),
                      ),
                      Container(
                        height: 40,
                        child: TextField(
                          maxLength: 150,
                          controller: membercontroller.edtalamat,
                          keyboardType: TextInputType.text,
                          decoration: DecorationConstant.inputDecor().copyWith(
                              hintText: "Masukkan Alamat",
                              counterText: '',
                              contentPadding: EdgeInsets.only(top: 0)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Provinsi (KTP)',
                        style: TextConstant.regular.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            fontSize: 15),
                      ),
                      SizedBox(height: 8),
                      Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DropdownSearch<Provinsi>(
                                popupProps: PopupProps.dialog(
                                  showSearchBox: true,
                                  searchFieldProps: TextFieldProps(
                                    controller: membercontroller.edtprovktp,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.phonelink_erase_outlined),
                                        onPressed: () {
                                          membercontroller.edtprovktp.clear();
                                        },
                                      ),
                                    ),
                                  ),
                                  itemBuilder: (context, item, isSelected) =>
                                      ListTile(
                                        title: Text(item.cPropinsi.toString()),
                                      ),
                                ),
                                compareFn: (item, _provinsi) =>
                                item.cPropinsi == _provinsi.cPropinsi,
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
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
                                onChanged: (data) {
                                  setState(() {
                                    //print('fais data : $data');
                                    _provinsi = data;
                                    provinsiSelected = data!.cPropinsi.toString();
                                    membercontroller.edtprovktp.text =
                                        data.cPropinsi.toString();
                                    //print('fais _provinsi111 : $provinsiSelected');
                                  });
                                },
                                selectedItem: _provinsi,
                                itemAsString: (item) => item.cPropinsi.toString(),
                                dropdownBuilder: (context, selectedItem) => Text(
                                    selectedItem?.cPropinsi ??
                                        'Belum pilih Provinsi'),
                                asyncItems: (text) async {
                                  var requestMap = {
                                    "cPropinsi": "",
                                    "cKota": "",
                                    "cKecamatan": "",
                                    "cDesa": "",
                                    "cKodepos": ""
                                  };
                                  var response = await http.post(
                                    Uri.parse(
                                        "${ConstUrl.BASE_URL_GOLANG}${ConstUrl.provinzi}"),
                                    body: json.encode(requestMap),
                                    headers: {"Content-Type": "application/json"},
                                  );
                                  //print('fais wwww $_provinsi');
                                  List provinsi = (json.decode(response.body)
                                  as Map<String, dynamic>)['data'];
                                  List<Provinsi> modelDataprovider = [];
                                  provinsi.forEach((element) {
                                    modelDataprovider.add(
                                        Provinsi(cPropinsi: element['cPropinsi']));
                                  });
                                  return modelDataprovider;
                                },
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kota (KTP)',
                        style: TextConstant.regular.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            fontSize: 15),
                      ),
                      SizedBox(height: 8),
                      Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DropdownSearch<Kota>(
                                popupProps: PopupProps.dialog(
                                  showSearchBox: true,
                                  searchFieldProps: TextFieldProps(
                                    controller: membercontroller.edtkotaktp,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.phonelink_erase_outlined),
                                        onPressed: () {
                                          membercontroller.edtkotaktp.clear();
                                        },
                                      ),
                                    ),
                                  ),
                                  itemBuilder: (context, item, isSelected) =>
                                      ListTile(
                                        title: Text(item.cKota),
                                      ),
                                ),
                                compareFn: (item, _kota) =>
                                item.cKota == _kota.cKota,
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
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
                                onChanged: (data) {
                                  setState(() {
                                    _kota = data;
                                    kotaselected = data!.cKota.toString();
                                    membercontroller.edtkotaktp.text =
                                        data.cKota.toString();
                                  });
                                },
                                selectedItem: _kota,
                                enabled: _provinsi != null,
                                itemAsString: (item) => item.cKota,
                                dropdownBuilder: (context, selectedItem) => Text(
                                  selectedItem?.cKota ?? 'Belum pilih Kota',
                                  style: TextStyle(
                                      color: _provinsi != null
                                          ? Colors.black
                                          : Colors.grey),
                                ),
                                asyncItems: (text) async {
                                  var requestMap = {
                                    "cPropinsi": provinsiSelected,
                                    "cKota": "",
                                    "cKecamatan": "",
                                    "cDesa": "",
                                    "cKodepos": ""
                                  };
                                  //print('fais map: ${json.encode(requestMap)}');
                                  var response = await http.post(
                                      Uri.parse(
                                          "${ConstUrl.BASE_URL_GOLANG}${ConstUrl.kota}"),
                                      body: json.encode(requestMap),
                                      headers: {
                                        "Content-Type": "application/json"
                                      });
                                  //print('fais url : ${ConstUrl.BASE_URL}${ConstUrl.kota}');
                                  //print('fais response : $response');
                                  // print('fais ${ConstUrl.BASE_URL}${ConstUrl.kota}?prov=$_provinsi"))');
                                  List kota = (json.decode(response.body)
                                  as Map<String, dynamic>)['data'];
                                  List<Kota> modelKota = [];
                                  kota.forEach((element) {
                                    modelKota.add(Kota(cKota: element['cKota']));
                                  });
                                  return modelKota;
                                },
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kecamatan (KTP)',
                        style: TextConstant.regular.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            fontSize: 15),
                      ),
                      SizedBox(height: 8),
                      Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DropdownSearch<Kecamatan>(
                                popupProps: PopupProps.dialog(
                                  showSearchBox: true,
                                  searchFieldProps: TextFieldProps(
                                    controller: membercontroller.edtkecktp,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.phonelink_erase_outlined),
                                        onPressed: () {
                                          membercontroller.edtkecktp.clear();
                                        },
                                      ),
                                    ),
                                  ),
                                  itemBuilder: (context, item, isSelected) =>
                                      ListTile(
                                        title: Text(item.cKecamatan),
                                      ),
                                ),
                                compareFn: (item, _kecamatan) =>
                                item.cKecamatan == _kecamatan.cKecamatan,
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
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
                                onChanged: (data) {
                                  setState(() {
                                    _kecamatan = data;
                                    kecamatanselected = data!.cKecamatan.toString();
                                    membercontroller.edtkecktp.text =
                                        data.cKecamatan.toString();
                                  });
                                },
                                selectedItem: _kecamatan,
                                enabled: _kota != null,
                                itemAsString: (item) => item.cKecamatan,
                                dropdownBuilder: (context, selectedItem) => Text(
                                  selectedItem?.cKecamatan ??
                                      'Belum pilih Kecamatan',
                                  style: TextStyle(
                                      color: _kota != null
                                          ? Colors.black
                                          : Colors.grey),
                                ),
                                asyncItems: (text) async {
                                  var requestMap = {
                                    "cPropinsi": provinsiSelected,
                                    "cKota": kotaselected,
                                    "cKecamatan": "",
                                    "cDesa": "",
                                    "cKodepos": ""
                                  };
                                  var response = await http.post(
                                      Uri.parse(
                                          "${ConstUrl.BASE_URL_GOLANG}${ConstUrl.kecamatan}"),
                                      body: json.encode(requestMap),
                                      headers: {
                                        "Content-Type": "application/json"
                                      });
                                  //print('fais ${ConstUrl.BASE_URL}${ConstUrl.kecamatan}?kota=$_kota');
                                  List kecamatan = (json.decode(response.body)
                                  as Map<String, dynamic>)['data'];
                                  List<Kecamatan> modelKec = [];
                                  kecamatan.forEach((element) {
                                    modelKec.add(Kecamatan(
                                        cKecamatan: element['cKecamatan']));
                                  });
                                  return modelKec;
                                },
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kelurahan / Desa (KTP)',
                        style: TextConstant.regular.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            fontSize: 15),
                      ),
                      SizedBox(height: 8),
                      Container(
                        child: DropdownSearch<Desa>(
                          popupProps: PopupProps.dialog(
                            showSearchBox: true,
                            searchFieldProps: TextFieldProps(
                              controller: membercontroller.edtlurah,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.phonelink_erase_outlined),
                                  onPressed: () {
                                    membercontroller.edtlurah.clear();
                                  },
                                ),
                              ),
                            ),
                            itemBuilder: (context, item, isSelected) =>
                                ListTile(
                                  title: Text(item.cDesa),
                                ),
                          ),
                          compareFn: (item, _lurah1) =>
                          item.cDesa == _lurah1.cDesa,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              floatingLabelBehavior:
                              FloatingLabelBehavior.never,
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
                          onChanged: (data) {
                            setState(() {
                              _desa1 = data;
                              desaselected = data!.cDesa.toString();
                              membercontroller.edtlurah.text =
                                  data.cDesa.toString();
                              getKodepos(data.cDesa.toString()).then((kodepos) {
                                membercontroller.edtkdpos.text = kodepos;
                                // print ('faiszz' +kodepos);
                              }).catchError((error) {
                                print("Faisqq Error fetching kodepos: $error");
                              });
                            });
                          },
                          selectedItem: _desa1,
                          enabled: _kecamatan != null,
                          dropdownBuilder: (context, selectedItem) => Text(
                            selectedItem?.cDesa ?? 'Belum pilih Kelurahan',
                            style: TextStyle(
                                color: _kecamatan != null
                                    ? Colors.black
                                    : Colors.grey),
                          ),
                          asyncItems: (text) async {
                            var requestMap = {
                              "cPropinsi": provinsiSelected,
                              "cKota": kotaselected,
                              "cKecamatan": kecamatanselected,
                              "cDesa": "",
                              "cKodepos": ""
                            };
                            var response = await http.post(
                                Uri.parse(
                                    "${ConstUrl.BASE_URL_GOLANG}${ConstUrl.desa}"),
                                body: json.encode(requestMap),
                                headers: {"Content-Type": "application/json"});
                            //print('fais ${ConstUrl.BASE_URL}${ConstUrl.desa}?kecamatan=$_kecamatan');
                            List desa = (json.decode(response.body)
                            as Map<String, dynamic>)['data'];
                            List<Desa> modelDesa = [];
                            desa.forEach((element) {
                              modelDesa.add(Desa(cDesa: element['cDesa']));
                            });
                            return modelDesa;
                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'KodePos (KTP)',
                        style: TextConstant.regular.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            fontSize: 15),
                      ),
                      Container(
                        height: 40,
                        child: TextField(
                          maxLength: 150,
                          controller: membercontroller.edtkdpos..text,
                          readOnly: membercontroller.edtkdpos.text != null,
                          keyboardType: TextInputType.text,
                          decoration: DecorationConstant.inputDecor().copyWith(
                              hintText: "Masukkan Kode Pos",
                              counterText: '',
                              contentPadding: EdgeInsets.only(top: 0)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Alamat Domisili',
                        style: TextConstant.regular.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            fontSize: 15),
                      ),
                      Container(
                        height: 40,
                        child: TextField(
                          maxLength: 150,
                          controller: membercontroller.edtalamatdomisli,
                          keyboardType: TextInputType.text,
                          decoration: DecorationConstant.inputDecor().copyWith(
                              hintText: "Masukkan Alamat",
                              counterText: '',
                              contentPadding: EdgeInsets.only(top: 0)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Provinsi Domisili',
                        style: TextConstant.regular.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            fontSize: 15),
                      ),
                      SizedBox(height: 8),
                      Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DropdownSearch<Provinsi2>(
                                popupProps: PopupProps.dialog(
                                  showSearchBox: true,
                                  searchFieldProps: TextFieldProps(
                                    controller: membercontroller.edtpropinsidomisli,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.phonelink_erase_outlined),
                                        onPressed: () {
                                          membercontroller.edtpropinsidomisli
                                              .clear();
                                        },
                                      ),
                                    ),
                                  ),
                                  itemBuilder: (context, item, isSelected) =>
                                      ListTile(
                                        title: Text(item.cPropinsi),
                                      ),
                                ),
                                compareFn: (item, _provinsi2) =>
                                item.cPropinsi == _provinsi2.cPropinsi,
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
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
                                onChanged: (data2) {
                                  setState(() {
                                    _provinsi2 = data2;
                                    provinsiSelected2 = data2!.cPropinsi.toString();
                                    membercontroller.edtpropinsidomisli.text =
                                        data2.cPropinsi.toString();
                                  });
                                },
                                selectedItem: _provinsi2,
                                enabled: membercontroller.edtalamatdomisli != null,
                                itemAsString: (item) => item.cPropinsi,
                                dropdownBuilder: (context, selectedItem) => Text(
                                  selectedItem?.cPropinsi ?? 'Belum pilih Provinsi',
                                  style: TextStyle(
                                      color:
                                      membercontroller.edtalamatdomisli != null
                                          ? Colors.black
                                          : Colors.grey),
                                ),
                                asyncItems: (text) async {
                                  var requestMap = {
                                    "cPropinsi": "",
                                    "cKota": "",
                                    "cKecamatan": "",
                                    "cDesa": "",
                                    "cKodepos": ""
                                  };
                                  var response = await http.post(
                                      Uri.parse(
                                          "${ConstUrl.BASE_URL_GOLANG}${ConstUrl.provinzi}"),
                                      body: json.encode(requestMap),
                                      headers: {
                                        "Content-Type": "application/json"
                                      });
                                  List provinsi2 = (json.decode(response.body)
                                  as Map<String, dynamic>)['data'];
                                  List<Provinsi2> modelDataprovider2 = [];
                                  provinsi2.forEach((element) {
                                    modelDataprovider2.add(
                                        Provinsi2(cPropinsi: element['cPropinsi']));
                                  });
                                  return modelDataprovider2;
                                },
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kota Domisili',
                        style: TextConstant.regular.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            fontSize: 15),
                      ),
                      SizedBox(height: 8),
                      Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DropdownSearch<Kota2>(
                                popupProps: PopupProps.dialog(
                                  showSearchBox: true,
                                  searchFieldProps: TextFieldProps(
                                    controller: membercontroller.edtkotadomisli,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.phonelink_erase_outlined),
                                        onPressed: () {
                                          membercontroller.edtkotadomisli.clear();
                                        },
                                      ),
                                    ),
                                  ),
                                  itemBuilder: (context, item, isSelected) =>
                                      ListTile(
                                        title: Text(item.cKota),
                                      ),
                                ),
                                compareFn: (item, _kota2) =>
                                item.cKota == _kota2.cKota,
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
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
                                onChanged: (data2) {
                                  setState(() {
                                    _kota2 = data2;
                                    kotaselected2 = data2!.cKota.toString();
                                    membercontroller.edtkotadomisli.text =
                                        data2.cKota.toString();
                                  });
                                },
                                selectedItem: _kota2,
                                enabled: _provinsi2 != null,
                                itemAsString: (item) => item.cKota,
                                dropdownBuilder: (context, selectedItem) => Text(
                                  selectedItem?.cKota ?? 'Belum pilih Kota',
                                  style: TextStyle(
                                      color: _provinsi2 != null
                                          ? Colors.black
                                          : Colors.grey),
                                ),
                                asyncItems: (text) async {
                                  var requestMap = {
                                    "cPropinsi": provinsiSelected2,
                                    "cKota": "",
                                    "cKecamatan": "",
                                    "cDesa": "",
                                    "cKodepos": ""
                                  };
                                  var response = await http.post(
                                    Uri.parse(
                                        "${ConstUrl.BASE_URL_GOLANG}${ConstUrl.kota}"),
                                    body: json.encode(requestMap),
                                    headers: {"Content-Type": "application/json"},
                                  );
                                  List kota2 = (json.decode(response.body)
                                  as Map<String, dynamic>)['data'];
                                  // print(kota2);
                                  List<Kota2> modelKota2 = [];
                                  kota2.forEach((element) {
                                    modelKota2.add(Kota2(cKota: element['cKota']));
                                  });
                                  return modelKota2;
                                },
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kecamatan Domisili',
                        style: TextConstant.regular.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            fontSize: 15),
                      ),
                      SizedBox(height: 8),
                      Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DropdownSearch<Kecamatan2>(
                                popupProps: PopupProps.dialog(
                                  showSearchBox: true,
                                  searchFieldProps: TextFieldProps(
                                    controller: membercontroller.edtkecdomisli,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.phonelink_erase_outlined),
                                        onPressed: () {
                                          membercontroller.edtkecdomisli.clear();
                                        },
                                      ),
                                    ),
                                  ),
                                  itemBuilder: (context, item, isSelected) =>
                                      ListTile(
                                        title: Text(item.cKecamatan),
                                      ),
                                ),
                                compareFn: (item, _kecamatan2) =>
                                item.cKecamatan == _kecamatan2.cKecamatan,
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                  dropdownSearchDecoration: InputDecoration(
                                    floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
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
                                onChanged: (data2) {
                                  setState(() {
                                    _kecamatan2 = data2;
                                    kecamatanselected2 =
                                        data2!.cKecamatan.toString();
                                    membercontroller.edtkecdomisli.text =
                                        data2.cKecamatan.toString();
                                  });
                                },
                                selectedItem: _kecamatan2,
                                enabled: _kota2 != null,
                                itemAsString: (item) => item.cKecamatan,
                                dropdownBuilder: (context, selectedItem) => Text(
                                  selectedItem?.cKecamatan ??
                                      'Belum pilih Kecamatan',
                                  style: TextStyle(
                                      color: _kota2 != null
                                          ? Colors.black
                                          : Colors.grey),
                                ),
                                asyncItems: (text) async {
                                  var requestMap = {
                                    "cPropinsi": provinsiSelected2,
                                    "cKota": kotaselected2,
                                    "cKecamatan": "",
                                    "cDesa": "",
                                    "cKodepos": ""
                                  };
                                  var response = await http.post(
                                      Uri.parse(
                                          "${ConstUrl.BASE_URL_GOLANG}${ConstUrl.desa}"),
                                      body: json.encode(requestMap),
                                      headers: {
                                        "Content-Type": "application/json"
                                      });
                                  List kecamatan2 = (json.decode(response.body)
                                  as Map<String, dynamic>)['data'];
                                  List<Kecamatan2> modelKec2 = [];
                                  kecamatan2.forEach((element) {
                                    modelKec2.add(Kecamatan2(
                                        cKecamatan: element['cKecamatan']));
                                  });
                                  return modelKec2;
                                },
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kelurahan / Desa Domisili',
                        style: TextConstant.regular.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            fontSize: 15),
                      ),
                      SizedBox(height: 8),
                      Container(
                        child: DropdownSearch<Desa2>(
                          popupProps: PopupProps.dialog(
                            showSearchBox: true,
                            searchFieldProps: TextFieldProps(
                              controller: membercontroller.edtlurah1,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.phonelink_erase_outlined),
                                  onPressed: () {
                                    membercontroller.edtlurah1.clear();
                                  },
                                ),
                              ),
                            ),
                            itemBuilder: (context, item, isSelected) =>
                                ListTile(
                                  title: Text(item.cDesa),
                                ),
                          ),
                          compareFn: (item, _lurah2) =>
                          item.cDesa == _lurah2.cDesa,
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              floatingLabelBehavior:
                              FloatingLabelBehavior.never,
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
                          onChanged: (data2) {
                            setState(() {
                              _desa2 = data2;
                              desaselected2 = data2!.cDesa.toString();
                              membercontroller.edtlurah1.text =
                                  data2.cDesa.toString();

                              getKodepos2(data2.cDesa.toString())
                                  .then((kodepos2) {
                                membercontroller.edtkdpos2.text = kodepos2;
                                // print ('faiszz2' +kodepos2);
                              }).catchError((error) {
                                print(
                                    "Faisqq2 Error fetching kodepos2: $error");
                              });
                            });
                          },
                          selectedItem: _desa2,
                          enabled: _kecamatan2 != null,
                          dropdownBuilder: (context, selectedItem) => Text(
                            selectedItem?.cDesa ?? 'Belum pilih Kelurahan',
                            style: TextStyle(
                                color: _kecamatan2 != null
                                    ? Colors.black
                                    : Colors.grey),
                          ),
                          asyncItems: (text) async {
                            var requestMap = {
                              "cPropinsi": provinsiSelected2,
                              "cKota": kotaselected2,
                              "cKecamatan": kecamatanselected2,
                              "cDesa": "",
                              "cKodepos": ""
                            };
                            var response = await http.post(
                                Uri.parse(
                                    "${ConstUrl.BASE_URL_GOLANG}${ConstUrl.desa}"),
                                body: json.encode(requestMap),
                                headers: {"Content-Type": "application/json"});
                            List desa2 = (json.decode(response.body)
                            as Map<String, dynamic>)['data'];
                            List<Desa2> modelDesa2 = [];
                            desa2.forEach((element) {
                              modelDesa2.add(Desa2(cDesa: element['cDesa']));
                            });
                            return modelDesa2;
                          },
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'KodePos Domisili',
                        style: TextConstant.regular.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            fontSize: 15),
                      ),
                      Container(
                        height: 40,
                        child: TextField(
                          maxLength: 150,
                          controller: membercontroller.edtkdpos2..text,
                          readOnly: membercontroller.edtkdpos2.text != null,
                          keyboardType: TextInputType.text,
                          decoration: DecorationConstant.inputDecor().copyWith(
                              hintText: "Masukkan Kode Pos",
                              counterText: '',
                              contentPadding: EdgeInsets.only(top: 0)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'No. Telp',
                        style: TextConstant.regular.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            fontSize: 15),
                      ),
                      Container(
                        height: 40,
                        child: TextField(
                          maxLength: 13,
                          controller: membercontroller.edttlp,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(12),
                            FilteringTextInputFormatter.deny(
                                RegExp('[\\-|\\,|\\.|\\#|\\*]'))
                          ],
                          decoration: DecorationConstant.inputDecor().copyWith(
                              hintText: "Masukkan nomor teleponmu",
                              counterText: '',
                              contentPadding: EdgeInsets.only(top: 0)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Bank Anda',
                  style: TextConstant.regular.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                      fontSize: 15),
                ),
                SizedBox(height: 8),
                DropdownSearch<Data>(
                  popupProps: PopupProps.dialog(
                    showSearchBox: true,
                    searchFieldProps: TextFieldProps(
                      controller: membercontroller.edtbank,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
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
                        suffixIcon: IconButton(
                          icon: Icon(Icons.phonelink_erase_outlined),
                          onPressed: () {
                            membercontroller.edtbank.clear();
                          },
                        ),
                      ),
                    ),
                    itemBuilder: (context, item, isSelected) => ListTile(
                      title: Text(item.cnamabank.toString()),
                    ),
                  ),
                  compareFn: (item, _company) =>
                  item.cnamabank == _company.cnamabank,
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
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
                  onChanged: (data) {
                    setState(() {
                      membercontroller.edtbank.text =
                          data!.cnamabank.toString();
                    });
                  },
                  itemAsString: (Data item) => item.cnamabank.toString(),
                  dropdownBuilder: (context, selectedItem) =>
                      Text(selectedItem?.cnamabank ?? 'Pilih Kode Bank'),
                  asyncItems: (text) async {
                    var requestMap = {"": ""};
                    var response = await http.post(
                      Uri.parse(
                          "${ConstUrl.BASE_URL_GOLANG}${ConstUrl.cekdatabank}"),
                      body: json.encode(requestMap),
                      headers: {"Content-Type": "application/json"},
                    );
                    // print('fais ${ConstUrl.BASE_URL_GOLANG}${ConstUrl.cekdatabank}');
                    List company = (json.decode(response.body)
                    as Map<String, dynamic>)['data'];
                    List<Data> modeldtbank = [];
                    company.forEach((element) {
                      modeldtbank.add(Data(
                        cnamabank: element['cnamabank'],
                        ccode: element['ccode'],
                      ));
                    });
                    return modeldtbank;
                  },
                ),
                SizedBox(height: 20),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nomor Rekening',
                        style: TextConstant.regular.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            fontSize: 15),
                      ),
                      Container(
                        height: 40,
                        child: TextField(
                          maxLength: 20,
                          controller: membercontroller.edtnorek,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(20),
                            FilteringTextInputFormatter.deny(
                                RegExp('[\\-|\\,|\\.|\\#|\\*]'))
                          ],
                          decoration: DecorationConstant.inputDecor().copyWith(
                              hintText: "Masukkan nomor rekening anda",
                              counterText: '',
                              contentPadding: EdgeInsets.only(top: 0)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Foto KTP',
                        style: TextConstant.regular.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            fontSize: 15),
                      ),
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
                SizedBox(height: 20),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Foto Anda',
                        style: TextConstant.regular.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                            fontSize: 15),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[400]!),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 200.0,
                              width: 150.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: _image == null
                                  ? Text('')
                                  : ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.file(
                                  _image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              width: width,
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                onPressed: _getImage,
                                style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.grey.withOpacity(0.5))),
                                child: Text(
                                  'Ambil Foto',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(height: 35),
                ButtonGreenWidget(
                  text: 'Daftar',
                  onClick: () => membercontroller.validationSupp(
                      value: _getValue(),
                      context: context,
                      callback: (result, error) {
                        if (result != null && result['error'] != true) {
                          Get.back();
                          DialogConstant.alertError('Pendaftaran Berhasil');
                          Future.delayed(Duration(milliseconds: 1500), () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(
                                    logout: '',
                                  ),
                                ));
                            setState(() {});
                          });
                        }
                        if (error != null) {
                          DialogConstant.alertError(result['pesan']);
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}