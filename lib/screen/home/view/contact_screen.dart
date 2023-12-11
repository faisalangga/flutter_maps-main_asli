import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {

  String url() {
    var phone = "+62-XXX-XXX-XXX";
    if (Platform.isIOS) {
      return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse("Hello")}";
    } else {
      return "https://wa.me/$phone/?text=${Uri.parse("Hello")}";
    }
  }

  Future<void> launchPhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> launchEmail(String emailAddress) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      query: 'subject=Contact Koperasi SPS&body=Hello,',
    );
    await launchUrl(launchUri);
  }
  
  Future<void> launchWebView(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw Exception('Could not launch webview $url');
    }
  }
  
  Future<void> launchWebBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch browser $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Us"),
        centerTitle: true,
        backgroundColor: Colors.green,
        // automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
                GestureDetector(
                  onTap: () {
                    // launch("tel://878-5144-1879");
                    launchPhoneCall('123-4567-890');
                  },
                  child: Row(
                    children: [
                      Icon(Icons.phone),
                      SizedBox(height: 10),
                      Text("Layanan Pelanggan\n123-4567-890"),
                      Icon(Icons.arrow_right),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // launch(url());
                    launchWebBrowser(Uri.parse(url()));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.chat),
                      SizedBox(height: 10),
                      Text("Whatsapp"),
                      Icon(Icons.arrow_right),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // launch("mailto:bola.bonanza@fksgroup.com");
                    launchEmail("Xno@gmail.com");
                  },
                  child: Row(
                    children: [
                      Icon(Icons.email),
                      SizedBox(height: 10),
                      Text("Email\ndarderdor"),
                      Icon(Icons.arrow_right),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // launch("https://bola.bonanza@fksgroup.com");
                    launchWebView(Uri.parse("https://xxxx.id/"));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.web_stories),
                      SizedBox(height: 10),
                      Text("Website\nxxxx.id"),
                      Icon(Icons.arrow_right),
                    ],
                  ),
                ),
            ],
          ),
        ),
      )
    );
  }
}
