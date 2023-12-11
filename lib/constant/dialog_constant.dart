import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:koperasimobile/constant/text_constant.dart';
import 'package:koperasimobile/screen/home/view/landing_screen.dart';

class DialogConstant {
  static showToast(String message) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
  }

  static void alertSucces(String message, {VoidCallback? function}) {
    showDialog(
        context: Get.context!,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    message,
                    style: TextConstant.regular,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 16),
                Divider(
                  height: 0,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LandingScreen()),
                    );
                  },
                  child: Text(
                    'OKE',
                    style: TextConstant.medium.copyWith(color: Colors.blue),
                  ),
                  // elevation: 0,
                  // disabledElevation: 0,
                  // color: Colors.white,
                ),
                SizedBox(
                  height: 4,
                ),
              ],
            ),
          );
        });
  }

  static void alertError(String message, {VoidCallback? function}) {
    showDialog(
        context: Get.context!,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    message,
                    style: TextConstant.regular,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 16),
                Divider(
                  height: 0,
                ),
                TextButton(
                  child: Text(
                    'OKE',
                    style: TextConstant.medium.copyWith(color: Colors.blue),
                  ),
                  // elevation: 0,
                  // disabledElevation: 0,
                  // color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                    print("message error : $message");
                    if (message.contains("tidak dapat diproses")) {
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(
                          context,
                          "/detail_pesanan_page",
                          (Route<dynamic> route) => false);
                    } else {
                      if (function != null) {
                        function();
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 4,
                ),
              ],
            ),
          );
        });
  }

  static loading(BuildContext context, String text) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 0.0,
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: <Widget>[
                    Column(
                      children: [
                        SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 25, right: 25),
                              child: CircularProgressIndicator(
                                  backgroundColor: Colors.blue),
                            ),
                            Text(
                              text,
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static showConfirmDialog(String title, String message, void callback()) {
    showDialog(
        context: Get.context!,
        //TODO GANTI FALSE
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 16,
                ),
//                Visibility(
//                  visible: title != "",
//                  child: Padding(
//                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
//                    child: AppText.bold(
//                      title,
//                      isCentered: true,
//                      size: 16,
//                    ),
//                  ),
//                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text(
                    message,
                    style: TextConstant.regular.copyWith(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Divider(
                  height: 0,
                ),
                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          "Tidak",
                          textAlign: TextAlign.center,
                          style: TextConstant.regular
                              .copyWith(color: Colors.black87),
                        ),
                      ),
                    )),
                    Container(
                      width: 0.5,
                      height: 40,
                      color: Colors.grey.shade300,
                    ),
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        if (callback != null) {
                          callback();
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          "Ya",
                          textAlign: TextAlign.center,
                          style: TextConstant.regular
                              .copyWith(color: Colors.blue, fontSize: 12),
                        ),
                      ),
                    )),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
              ],
            ),
          );
        });
  }

  static alertMultipleOption(
      String title, String content, List<Widget> widgets, context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
              title: new Text(title),
              content: new Text(content),
              actions: widgets,
            ));
  }

  static showBottomSheet({BuildContext? context, Widget? child}) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context!,
        builder: (BuildContext bc) {
          return child!;
        });
  }

  static bottomSheetScrolled({BuildContext? context, Widget? child}) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.white,
        context: context!,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.2,
            maxChildSize: 0.75,
            expand: false,
            builder: (context, scroll) {
              return child!;
            },
          );
        });
  }

  static showSnackBar(messages) {
    Get.snackbar('', messages,
        snackPosition: SnackPosition.BOTTOM,
        // backgroundColor: ColorConstant.white,
        snackStyle: SnackStyle.FLOATING,
        // borderColor: ColorConstant.primary2,
        borderWidth: 1,
        titleText: Container(),
        borderRadius: 1,
        messageText: Center(
          child: Text(
            messages,
            style: TextConstant.regular
                .copyWith(color: Colors.redAccent, fontSize: 12),
          ),
        ),
        margin: EdgeInsets.only(bottom: 70, left: 10, right: 10));
  }
}
