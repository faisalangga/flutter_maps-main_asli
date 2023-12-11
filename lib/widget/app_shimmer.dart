import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatelessWidget {
  final double width;
  final double? height;
  const AppShimmer({super.key, required this.width,  this.height=15});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade100!,
      highlightColor: Colors.blueGrey[100]!,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey.shade100,
        ),
        width: width,
        height: height,
      ),
    );
  }
}
