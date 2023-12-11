import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Top Up App',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => TopUpPage()),
        GetPage(name: '/second', page: () => CustomTopUpPage()),
        GetPage(name: '/confirm', page: () => ConfirmPage()),
      ],
    );
  }
}

class TopUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Top Up')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.to(CustomTopUpPage());
          },
          child: Text('Go to Custom Top Up Page'),
        ),
      ),
    );
  }
}

class CustomTopUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Custom Top Up')),
      body: Center(
        child: Text('Custom Top Up Page'),
      ),
    );
  }
}

class ConfirmPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Confirm Top Up')),
      body: Center(
        child: Text('Confirm Top Up Page'),
      ),
    );
  }
}