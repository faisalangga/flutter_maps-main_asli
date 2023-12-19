import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:koperasimobile/constant/decoration_constant.dart';
import 'package:koperasimobile/constant/text_constant.dart';
import 'package:koperasimobile/screen/auth/login_screen.dart';
import 'package:koperasimobile/screen/home/view/contact_screen.dart';
import 'package:koperasimobile/screen/home/view/update_member_screen.dart';
import 'package:koperasimobile/utils/local_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DetailScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? foto;
  String? username;
  String? base64String = '';
  bool _searchMode = false;

  // @override
  // void initState() {
  //   super.initState();
  //   fetchImageBase64();
  // }

  // Future<String> fetchImageBase64() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String? base64String = prefs.getString('poto');
  //   return base64String!;
  //   // Completer<String> completer = Completer<String>();
  //   // try {
  //   //   Map<String, String> header = {'Content-Type': 'application/json'};
  //   //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   //   String? username = preferences.getString("username");
  //   //   Map<String, dynamic> post = {"user": "$username"};
  //   //   API.basePostGolang(ConstUrl.cekaccount, post, header, true, (result, error) {
  //   //     if (result != null) {
  //   //       Model_profil response = Model_profil.fromJson(result);
  //   //       if (response.error == false) {
  //   //         setState(() {
  //   //           base64String = '${response.data![0].pselfie}';
  //   //         });
  //   //         completer.complete(foto);
  //   //       } else {
  //   //         print('tidak ada foto');
  //   //       }
  //   //     }
  //   //   });
  //   // } catch (error) {
  //   //   print('Error fetching image: $error');
  //   //   completer.completeError(error);
  //   // }
  //   // return completer.future;
  // }

  @override
  Widget build(BuildContext context) {
    Future<Uint8List?> getImageBytes() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? base64Image = prefs.getString('poto');
      if (base64Image != null && base64Image.isNotEmpty) {
        return base64Decode(base64Image);
      }
      return null;
    }

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account',
          style:
              TextConstant.medium.copyWith(color: Colors.black87, fontSize: 18),
        ),
        elevation: 0.5,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: [
          // InkWell(
          //   onTap: () {
          //     // Tindakan yang akan dijalankan saat ikon di tap
          //     // Misalnya, navigasi atau tindakan lainnya
          //   },
          //   child: Icon(
          //     Icons.menu_open_sharp,
          //     color: Colors.black87,
          //   ),
          // ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: 'imageHero',
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailScreen(),
                          ),
                        );
                      },
                      child: FutureBuilder<Uint8List?>(
                        future: getImageBytes(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData &&
                              snapshot.data != null) {
                            return ClipOval(
                              child: Image.memory(
                                snapshot.data!,
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                            );
                          } else {
                            // return SizedBox.shrink();
                            return Center(
                              child: Icon(
                                Icons.account_circle_outlined,
                                size: height / 8,
                                color: Colors.black45,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder<String>(
                            future: LocalData.getData('username'),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error loading username');
                              } else if (snapshot.hasData) {
                                return Text(
                                  snapshot.data!,
                                  style: TextConstant.regular.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                );
                              } else {
                                return Text('No username available');
                              }
                            },
                          ),
                          SizedBox(height: 5),
                          FutureBuilder<String>(
                            future: LocalData.getData('cNikKaryawan'),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error loading cNikKaryawan');
                              } else if (snapshot.hasData) {
                                return Text(
                                  snapshot.data!,
                                  style: TextConstant.regular.copyWith(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                );
                              } else {
                                return Text('No cNikKaryawan available');
                              }
                            },
                          ),
                          SizedBox(height: 2),
                          FutureBuilder<String>(
                            future: LocalData.getData('phone'),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error loading phone');
                              } else if (snapshot.hasData) {
                                return Text(
                                  snapshot.data!,
                                  style: TextConstant.medium.copyWith(
                                    color: Colors.black87,
                                    fontSize: 15,
                                  ),
                                );
                              } else {
                                return Text('No phone available');
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () => Get.to(() => UpdMemberScreen()),
                child:  itemMenu('Account Detail', Icons.person),
              ),
              itemMenu('Security', Icons.lock),
              GestureDetector(
                onTap: () => Get.to(() => ContactScreen()),
                child: itemMenu('Contact Us', Icons.call),
              ),
              // GestureDetector(
              //   onTap: () => Get.to(() => LoginScreen(logout: 'logout')),
              //   child: itemMenu('Log Out', Icons.exit_to_app_rounded),
              // ),
              GestureDetector(
                onTap: () {
                  SharedPreferences.getInstance().then((prefs) {
                    prefs.clear().then((value) {
                      Get.to(() => LoginScreen(logout: 'logout'));
                    });
                  });
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //     // AjuSimpInsScreen(
                  //     //     tipeCheck:
                  //     //         ''),
                  //     LoginScreen(logout: 'logout'),
                  //   ),
                  // );
                },
                child: itemMenu('Log Out', Icons.exit_to_app_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemMenu(String title, IconData icons) {
    return Container(
      decoration: DecorationConstant.boxButtonBorder(
        radius: 8,
        color: Colors.white,
        widthBorder: 1,
        colorBorder: Colors.grey.shade300,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icons),
          SizedBox(width: 15),
          Text(
            title,
            style: TextConstant.medium
                .copyWith(color: Colors.black87, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
