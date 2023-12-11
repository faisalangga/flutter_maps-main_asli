import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/isi_tabungan_controller.dart';

class CustomTopUpPage extends StatefulWidget {
  @override
  State<CustomTopUpPage> createState() => _CustomTopUpPageState();
}

class _CustomTopUpPageState extends State<CustomTopUpPage> {
  final TopUpController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Custom Top Up')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                controller.setCustomAmount(value);
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Custom Amount'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.toNamed('/confirm');
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}
