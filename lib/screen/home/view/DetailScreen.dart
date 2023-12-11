import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
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
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: InteractiveViewer(
            panEnabled: true,
            boundaryMargin: EdgeInsets.all(20.0),
            minScale: 0.5,
            maxScale: 5.0,
            child: Hero(
              tag: 'imageHero',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: FutureBuilder<Uint8List?>(
                  future: getImageBytes(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData && snapshot.data != null) {
                      return Image.memory(
                        snapshot.data!,
                        height: width,
                        width: width,
                        fit: BoxFit.cover,
                      );
                    } else {
                      return SizedBox.shrink();
                      // return Center(
                      //   child: Icon(
                      //     Icons.account_circle_outlined,
                      //     size: height / 8,
                      //     color: Colors.black45,
                      //   ),
                      // );
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
