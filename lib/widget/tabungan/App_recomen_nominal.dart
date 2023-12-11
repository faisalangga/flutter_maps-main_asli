import 'package:flutter/material.dart';

class AppRecomenNominal extends StatelessWidget {
  const AppRecomenNominal({
    Key? key,
    required this.nominal,
    required this.onTap,
    required this.image,
  }) : super(key: key);

  final String nominal;
  final String image;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(width: 2, color: Colors.grey.shade500),
              bottom: BorderSide(width: 2, color: Colors.grey.shade500),
              left: BorderSide(width: 2, color: Colors.grey.shade500),
              right: BorderSide(width: 2, color: Colors.grey.shade500),
            ),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(image, height: 50),
            SizedBox(
              height: 8,
            ),
            Text(
              nominal,
              style: TextStyle(fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}

class AppRecomenNominalTarik extends StatelessWidget {
  const AppRecomenNominalTarik({
    Key? key,
    required this.nominal,
    required this.onTap,
    required this.image,
  }) : super(key: key);

  final String nominal;
  final String image;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(width: 3, color: Colors.grey.shade500),
              bottom: BorderSide(width: 3, color: Colors.grey.shade500),
              left: BorderSide(width: 3, color: Colors.grey.shade500),
              right: BorderSide(width: 3, color: Colors.grey.shade500),
            ),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(image, height: 50),
            SizedBox(
              height: 5,
            ),
            Text(
              nominal,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
