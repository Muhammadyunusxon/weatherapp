import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../Style/style.dart';

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
        baseColor: Style.shimmerBaseColor,
        highlightColor:  Style.shimmerHighlightColor,
        child: Container(
          width: width,
          height: height,
          color: Style.shimmerColor

        ),
      ),
    );
  }
}