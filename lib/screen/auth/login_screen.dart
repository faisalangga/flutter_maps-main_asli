import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

// import 'package:koperasimobile/utils/utils_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:koperasimobile/constant/decoration_constant.dart';
import 'package:koperasimobile/constant/dialog_constant.dart';
import 'package:koperasimobile/constant/image_constant.dart';
import 'package:koperasimobile/constant/text_constant.dart';
import 'package:koperasimobile/controller/auth_controller.dart';

// import 'package:koperasimobile/screen/auth/forgot_password_screen.dart';
// import 'package:koperasimobile/screen/auth/register_screen.dart';
import 'package:koperasimobile/screen/auth/member/supp_ins_screen.dart';
import 'package:koperasimobile/screen/home/landing_home.dart';

// import 'package:koperasimobile/screen/home/view/supp_screen.dart';
import 'package:koperasimobile/widget/material/button_green_widget.dart';

// import 'package:double_back_to_close_app/double_back_to_close_app.dart';
// import '../../utils/local_data.dart';

class LoginScreen extends StatefulWidget {
  final String logout;

  const LoginScreen({Key? key, required this.logout}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthController logincontroller = new AuthController();
  DateTime newTime = DateTime.now();
  DateTime oldTime = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefs();
    // clearCart();
  }

  getPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var islogin = preferences.getBool("islogin");
    var logout = widget.logout as bool;
    // print('inifais $islogin');
    if (logout = true) {
      final pref = await SharedPreferences.getInstance();
      pref.clear();
      Navigator.pushAndRemoveUntil(
        context,
        new MaterialPageRoute(builder: (context) => new LandingHome()),
        (Route<dynamic> route) => false,
      );
    } else {
      if (islogin == true) {
        LandingHome();
        // final pref= await SharedPreferences.getInstance();
        // pref.clear();
        // Navigator.push(context,
        //     new MaterialPageRoute(builder: (context) => new LandingHome()));
        // print("fais xxxxxzzzzzxxxxx");
      } else {
        // final pref = await SharedPreferences.getInstance();
        // pref.clear();
        LoginScreen(logout: 'logout');
        // print("fais zzzzz");
      }
    }
  }

  Future<bool> onBackPress() async {
    newTime = DateTime.now();
    int difference = newTime.difference(oldTime).inMilliseconds;
    oldTime = newTime;
    if (difference < 2000) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      SystemNavigator.pop();
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                ImageConstant.closeexit,
                fit: BoxFit.contain,
                width: 50,
                height: 50,
              ),
              Text(
                'Tap 2 kali untuk keluar',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ],
          ),
        ),
      );
      return false;
    }
  }

  // Future<bool> onBackPress() async {
  //   return await UtilsDialogApp.onBackPressConfirm(context);
  // }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        body: Obx(() => Container(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.10),
                    Center(
                        child: Image.asset(ImageConstant.cart_logo,
                            height: size.height * 0.20)),
                    SizedBox(height: 40),
                    Center(
                      child: Text(
                        'Selamat Datang',
                        style: TextConstant.regular.copyWith(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),
                    ),
                    SizedBox(height: 45),
                    Container(
                      child: Row(
                        children: [
                          Icon(Icons.phone_android_rounded,
                              size: 24, color: Colors.grey.shade500),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              height: 40,
                              child: TextField(
                                maxLength: 25,
                                controller: logincontroller.edtNohp,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(13),
                                  FilteringTextInputFormatter.deny(
                                      RegExp('[\\-|\\,|\\.|\\#|\\*]'))
                                ],
                                decoration: DecorationConstant.inputDecor()
                                    .copyWith(
                                        hintText: "Masukkan nomor teleponmu",
                                        counterText: '',
                                        contentPadding:
                                            EdgeInsets.only(top: 0)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.https,
                            size: 24,
                            color: Colors.grey.shade500,
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              height: 40,
                              child: TextField(
                                maxLength: 25,
                                controller: logincontroller.edtPass,
                                obscureText:
                                    logincontroller.openPassLogin.value,
                                decoration:
                                    DecorationConstant.inputDecor().copyWith(
                                  hintText: "Masukkan Kata Sandi",
                                  counterText: '',
                                  contentPadding: EdgeInsets.only(top: 10),
                                  suffixIcon: GestureDetector(
                                      onTap: () => logincontroller
                                          .changeOpenPassLogin(!logincontroller
                                              .openPassLogin.value),
                                      child: Icon(
                                        logincontroller.openPassLogin.value
                                            ? CupertinoIcons.eye_slash
                                            : CupertinoIcons.eye,
                                        size: 20,
                                        color: Colors.grey.shade500,
                                      )),
                                  suffixIconColor: Colors.grey.shade500,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    // Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     children: [
                    //       GestureDetector(
                    //           onTap: () => Get.to(() => ForgotPasswordScreen()),
                    //           child: Text(
                    //             'Lupa Kata Sandi?',
                    //             style: TextConstant.regular.copyWith(
                    //                 fontWeight: FontWeight.bold,
                    //                 color: Colors.orange),
                    //           ))
                    //     ],
                    //   ),
                    // ),
                    SizedBox(height: 15),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: ButtonGreenWidget(
                          text: 'Submit',
                          onClick: () => logincontroller.validation(
                              context: context,
                              callback: (result, error) {
                                // print('fais result1212 $result');
                                // print('fais error rerror');
                                if (result != null && result['error'] != true) {
                                  Get.to(() => LandingHome());
                                } else {
                                  // print('fais result121aaaa2 $error');
                                  // print('fais message1111 ${error['message']}');
                                  DialogConstant.alertError(
                                      '${error['message']}');
                                  // Future.delayed(Duration(seconds: 1), () {
                                  //   Get.to(() => LoginScreen(logout: ''));
                                  // });
                                  // Future.delayed(Duration(seconds: 5), () {
                                  //   Get.offAll(() => Scaffold(
                                  //     backgroundColor: Colors.white, // Warna latar belakang putih
                                  //     body: Container(),
                                  //   ));
                                  //   Get.to(() => LoginScreen(logout: ''));
                                  // });
                                }
                              }),
                        )),
                    SizedBox(height: 15),
                    Center(
                      child: GestureDetector(
                        // onTap: ()=>Get.to(()=>RegisterScreen()),
                        onTap: () => Get.to(() => SuppInsScreen(
                              tipeCheck: '',
                            )),
                        child: RichText(
                          text: TextSpan(
                            text: 'Belum punya akun ? Daftar',
                            style: TextConstant.regular,
                            children: <TextSpan>[
                              TextSpan(
                                  text: ' Disini',
                                  style: TextConstant.regular
                                      .copyWith(color: Colors.green)),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
