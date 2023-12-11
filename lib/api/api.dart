// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:koperasimobile/constant/const_url.dart';


class API{

  static String BASE_URL = 'http://192.168.100.206/tokool';

  static basePost(
      String module,
      Map<String, dynamic> post,
      Map<String, String> headers,
      bool encode,
      void callback(dynamic, Exception)) async {

    String ada = json.encode(post);

    var mapError = new Map();
    try{
      final response = await http.post(Uri.parse('${ConstUrl.BASE_URL}$module'),
          // ignore: missing_return
          headers: headers, body: encode ? json.encode(post) : post).timeout(Duration(seconds: 50),
          // onTimeout: (){
          //   mapError.putIfAbsent('message', () => 'Koneksi timout, gagal terhubung dengan service');
          //   recallback(null, mapError);
          // }
      );
      print(response);
      if(response != null){
        int responseCode = response.statusCode;
        var sdad = response.body;
        var mapJson = json.decode(response.body);
        var dads = jsonEncode(mapJson);
        // print("FAIS POST RESULT ${json.encode(mapJson)}");
        if (responseCode == 200) {
          // print('FAIS1');
          callback(mapJson, null);
        } else if (responseCode == 401 ||
            responseCode == 403 ||
            responseCode == 401 ||
            responseCode == 403) {
          // print('FAIS2');
          callback(null, mapJson);
        } else {
          // print('FAIS3');
          callback(null, mapJson);
        }
      }else{
        mapError.putIfAbsent('message', () => 'Gagal memuat data.');
        callback(null, mapError);
      }
    } on SocketException catch(e){
      mapError.putIfAbsent('message', () => 'Gagal memuat data.'+e.message);
      callback(null, mapError);
    } catch (e){
      mapError.putIfAbsent('message', () => 'Gagal memuat data.'+e.toString());
      callback(null, mapError);
    }
  }

  static basePost2(
      String url,
      Map<String, dynamic> post,
      Map<String, String> headers,
      bool encode,
      void callback(dynamic, Exception)) async {

    print("URL ${url}");
    print("POST Header ${json.encode(headers)}");
    print("POST VALUE ${json.encode(post)}");

    var mapError = new Map();
    try{

      final response = await http.post( Uri.parse(url),
          // ignore: missing_return
          headers: headers, body: encode ? json.encode(post) : post).timeout(Duration(seconds: 50),
        //   onTimeout: (){
        // // callback(null, HTTPStatusFailedException('Koneksi terputus, silahkan coba lagi'));
        //     mapError.putIfAbsent('message', () => 'Koneksi timout, Gagal memuat data.');
        //     callback(null, mapError);
        //   }
      );
      if(response != null){
        int responseCode = response.statusCode;
        var mapJson = json.decode(response.body);
        print("POST RESULT ${json.encode(mapJson)}");
        if (mapJson['code'] == 200) {
          callback(mapJson, null);
        } else if (responseCode == 401 ||
            responseCode == 403 ||
            mapJson['code'] == 401 ||
            mapJson['code'] == 403) {
          callback(null, mapJson);
        } else {
          callback(null, mapJson);
        }
      }else{
        mapError.putIfAbsent('message', () => 'Gagal memuat data.');
        callback(null, mapError);
      }
    } on SocketException catch(e){
      mapError.putIfAbsent('message', () => 'Gagal memuat data.');
      callback(null, mapError);
    } catch (e){
      mapError.putIfAbsent('message', () => 'Gagal memuat data.');
      callback(null, mapError);
    }
  }

  static basePostGolang(
      String module,
      Map<String, dynamic> post,
      Map<String, String> headers,
      bool encode,
      void callback(dynamic, Exception)) async {

    // print("FAISGOL URL ${ConstUrl.BASE_URL_GOLANG + module}");
    // print("FAISGOL POST Header ${json.encode(headers)}");
    // print("FAISGOL POST VALUE ${json.encode(post)}");
    String ada = json.encode(post);

    var mapError = new Map();
    try{
      final response = await http.post(Uri.parse(ConstUrl.BASE_URL_GOLANG + module),
          // ignore: missing_return
          headers: headers, body: encode ? json.encode(post) : post).timeout(Duration(seconds: 50),
        // onTimeout: (){
        //   mapError.putIfAbsent('message', () => 'Koneksi timout, gagal terhubung dengan service');
        //   recallback(null, mapError);
        // }
      );
      // print('fais response : $response');
      if(response != null){
        int responseCode = response.statusCode;
        var sdad = response.body;
        var mapJson = json.decode(response.body);
        var dads = jsonEncode(mapJson);
        // print("FAISGOL POST RESULT ${json.encode(mapJson)}");
        // print('FAIS responseCode $responseCode');
        // print('FAIS mapJson $mapJson');
        if (responseCode == 200) {
          // print('FAIS GOL1');
          callback(mapJson, null);
        } else if (responseCode == 401 ||
            responseCode == 403 ||
            responseCode == 401 ||
            responseCode == 403) {
          // print('FAIS GOL2');
          callback(null, mapJson);
        } else {
          // print('FAIS GOL3');
          callback(null, mapJson);
        }
      }else{
        // print('FAIS GOL4');
        mapError.putIfAbsent('message', () => 'Gagal memuat data.');
        callback(null, mapError);
      }
    } on SocketException catch(e){
      mapError.putIfAbsent('message', () => 'Gagal memuat data.'+e.message);
      callback(null, mapError);
    } catch (e){
      mapError.putIfAbsent('message', () => 'Gagal memuat data.'+e.toString());
      callback(null, mapError);
    }
  }

  static getKota(void callback(Map, Exception)) async {
    var header = new Map<String, String>();
    var post = new Map<String, dynamic>();
    header['Content-Type'] = 'application/json';
    basePost('/provinsi', post, header, true, (result, error){
      callback(result, error);
    });
  }

  static getProvinsi(void callback(Map, Exception)) async {
    var header = new Map<String, String>();
    var post = new Map<String, dynamic>();
    header['Content-Type'] = 'application/json';
    basePost('/provinsi', post, header, true, (result, error){
      callback(result, error);
    });
  }

  static getKelurahan(String kecId, void callback(Map, Exception)) async {
      var header = new Map<String, String>();
      var post = new Map<String, dynamic>();
      header['Content-Type'] = 'application/json';
      post['kecamatan_code'] = kecId;
      basePost('/kelurahan', post, header, true, (result, error){
        callback(result, error);
      });
    }

  static baseGetFile(String module,
      Map<String, String> headers,
      String namaFile,
      void callback(File file)) async {
    // Utils.log("URL ${BASE_URL + module}");
    try {
      final response = await http.get(Uri.parse('${ConstUrl.BASE_URL}$module'), headers: headers);
      if (response.contentLength == 0){
        return callback(File(''));
      }
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      File file = new File('$tempPath/$namaFile');
      await file.writeAsBytes(response.bodyBytes);
      callback(file);
    } catch (e) {
      // callback(null, HTTPStatusFailedException('Koneksi sedang tidak stabil'));
    }
  }

  static baseGet(String module, Map<String, String> headers,
      void callback(dynamic, exception)) async {
    // Utils.log("URL ${BASE_URL + module}");

    var mapError = new Map();
    try {
      // ignore: missing_return
      final response = await http.get(Uri.parse('${ConstUrl.BASE_URL}$module'), headers: headers ).timeout(Duration(seconds: 50),
        //   onTimeout: (){
        //   callback(null, HTTPStatusFailedException('Koneksi terputus, silahkan coba lagi'));
        //   mapError.putIfAbsent('message', () => 'Koneksi timout, Gagal memuat data.');
        //   callback(null, mapError);
        // }
      );
      int responseCode = response.statusCode;
      var mapJson = json.decode(response.body);

      // Utils.log("RESPONSE ${mapJson.toString()}");

      if (mapJson['code'] == 200) {
        callback(mapJson, null);
      } else if (responseCode == 401 ||
          responseCode == 403 ||
          mapJson['code'] == 401 ||
          mapJson['code'] == 403 || mapJson['code'] == 422) {
        callback(null, mapJson);
      } else {
        mapError.putIfAbsent('message', () => 'Gagal memuat data.');
        callback(null, mapError);
      }
    } catch (e) {
      mapError.putIfAbsent('message', () => 'Gagal memuat data.');
      callback(null, mapError);
    }
  }

  // static getUserProfile(void callback(Map, Exception)) {
  //   var header = new Map<String, String>();
  //   header['Content-Type'] = 'application/json';
  //   baseGet('/user', header, (result, error) {
  //     callback(result, error);
  //   });
  // }
  //
  // static getChatType(int id, void callback(Map, Exception)) {
  //   var header = new Map<String, String>();
  //   header['Content-Type'] = 'application/json';
  //   baseGet('/chattype?id=${id}', header, (result, error) {
  //     callback(result, error);
  //   });
  // }
  //
  // static getStatusHamil(int id, void callback(Map, Exception)) {
  //   var header = new Map<String, String>();
  //   header['Content-Type'] = 'application/json';
  //   baseGet('/hamil/checkstatus/${id}', header, (result, error) {
  //     callback(result, error);
  //   });
  // }
  //
  // static getStatusBaduta(int id, void callback(Map, Exception)) {
  //   var header = new Map<String, String>();
  //   header['Content-Type'] = 'application/json';
  //   baseGet('/baduta/checkstatus/${id}', header, (result, error) {
  //     callback(result, error);
  //   });
  // }
  //
  // static Future<bool> isConnected() async {
  //   try {
  //     final result = await InternetAddress.lookup('google.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       return true;
  //     }
  //   } on SocketException catch (_) {
  //     return false;
  //   }
  //   return false;
  // }
  //
  // // static Future<bool> isConnected2() async {
  // //   var connectivityResult = await (Connectivity().checkConnectivity());
  // //   // if (connectivityResult == ConnectivityResult.none) {
  // //   //   setState(() {
  // //   //     isInternetOn = false;
  // //   //   });
  // //   // }
  // //   return false;
  // // }
  //
  // static baseDelete(String module, Map<String, String> headers,
  //     void callback(dynamic, exception)) async {
  //   Utils.log("URL ${BASE_URL + module}");
  //   Utils.log("Header ${json.encode(headers)}");
  //   // var connect = await isConnected();
  //   // if(!connect){
  //   //   callback(null, 'Tidak ada koneksi');
  //   //   return;
  //   // }
  //
  //   try {
  //     final response = await http.delete(Uri.parse(BASE_URL + module), headers: headers);
  //     int responseCode = response.statusCode;
  //     var mapJson = json.decode(response.body);
  //
  //     Utils.log("RESPONSE ${mapJson.toString()}");
  //
  //     if (mapJson['code'] == 200) {
  //       callback(mapJson, null);
  //     } else if (responseCode == 401 ||
  //         responseCode == 403 ||
  //         mapJson['code'] == 401 ||
  //         mapJson['code'] == 403 ||
  //         mapJson['code'] == 422) {
  //       // callback(null, TokenException());
  //     } else {
  //       // callback(null, HTTPStatusFailedException(mapJson['message']));
  //     }
  //   } catch (e) {
  //     // callback(null, HTTPStatusFailedException('Koneksi sedang tidak stabil'));
  //   }
  // }
  //
  //
  //
  // static basePut(
  //     String module,
  //     Map<String, dynamic> post,
  //     Map<String, String> headers,
  //     bool encode,
  //     void callback(dynamic, Exception)) async {
  //
  //   Utils.log("URL ${BASE_URL + module}");
  //   Utils.log("POST Header ${json.encode(headers)}");
  //   Utils.log("POST VALUE ${json.encode(post)}");
  //
  //   var mapError = new Map();
  //   try{
  //         final response = await http.put(Uri.parse(BASE_URL+module),
  //         // ignore: missing_return
  //       //   headers: headers, body: encode ? json.encode(post) : post).timeout(Duration(seconds: 30),
  //       //       onTimeout: (){
  //       // // callback(null, HTTPStatusFailedException('Koneksi terputus, silahkan coba lagi'));
  //       //     mapError.putIfAbsent('message', () => 'Koneksi terputus, silahkan coba lagi');
  //       //     callback(null, mapError);
  //       //   }
  //     );
  //     if(response != null){
  //       int responseCode = response.statusCode;
  //       var mapJson = json.decode(response.body);
  //       Utils.log("POST RESULT ${json.encode(mapJson)}");
  //       if (mapJson['code'] == 200) {
  //         callback(mapJson, null);
  //       } else if (responseCode == 401 ||
  //           responseCode == 403 ||
  //           mapJson['code'] == 401 ||
  //           mapJson['code'] == 403) {
  //         callback(null, mapJson);
  //       } else {
  //         callback(null, mapJson);
  //       }
  //     }else{
  //       mapError.putIfAbsent('message', () => 'Gagal memuat data.');
  //       callback(null, mapError);
  //     }
  //   } on SocketException catch(e){
  //     mapError.putIfAbsent('message', () => 'Gagal memuat data.');
  //     callback(null, mapError);
  //   } catch (e){
  //     mapError.putIfAbsent('message', () => 'Gagal memuat data.');
  //     callback(null, mapError);
  //   }
  // }
  //
  // static getDeliveryOrder(String doCode, String uniqueCode, void callback(Map, Exception)) {
  //   var header = new Map<String, String>();
  //   header['Content-Type'] = 'application/json';
  //   header['unique_code'] = uniqueCode;
  //   baseGet('/deliveryorder/${doCode}', header, (result, error) {
  //     callback(result, error);
  //   });
  // }
}