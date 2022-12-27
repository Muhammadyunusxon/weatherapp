import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerItem extends StatelessWidget {
  final double height;
  final double width;
  const ShimmerItem({Key? key, required this.height, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Shimmer.fromColors(
        baseColor: Colors.white.withOpacity(0.5),
        highlightColor:  Colors.white.withOpacity(0.2),
        child: Container(
          width: width,
          height: height,
          color: const Color(0xff48319D).withOpacity(0.2)

        ),
      ),
    );
  }
}