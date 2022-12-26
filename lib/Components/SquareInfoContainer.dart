import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Style/style.dart';
class SquareInfoContainer extends StatelessWidget {
  final List<Widget>? children;
  const SquareInfoContainer({Key? key, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 164.r,
      width: 164.r,
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: Style.secondaryColor.withOpacity(0.85),
        border: Border.all(
            style: BorderStyle.solid,
            color: Style.whiteColor.withOpacity(0.25),
            width: 0.5),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children ?? [],
      ),
    );
  }
}
