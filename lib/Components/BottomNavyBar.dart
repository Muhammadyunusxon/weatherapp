import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather/Pages/MapPage.dart';
import 'package:weather/store/local_store.dart';

import '../Pages/addLocationPage.dart';

class BottomNavyBar extends StatelessWidget {
  const BottomNavyBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: SizedBox(
      height: 102.h,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
                height: 88.h,
                child: Image.asset(
                  'assets/image/bottom.png',
                  fit: BoxFit.cover,
                )),
          ),
          Positioned(
            left: 66.w,
            right: 66.w,
            bottom: 0,
            child: SizedBox(
                height: 102.h, child: Image.asset('assets/image/Subtract.png')),
          ),
          Positioned(
            left: 140.w,
            right: 140.w,
            bottom: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const AddLocationPage()));
                },
                child: SizedBox(
                    height: 102.h,
                    child: Image.asset('assets/image/button.png')),
              ),
            ),
          ),
          Positioned(
            left: 33.w,
            top: 33.h,
            bottom: 25.h,
            child: InkWell(
              onTap: () async {
                double lat= await LocalStore.getLat();
                double lon= await LocalStore.getLon();
                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>MapPage(lat: lat, lon: lon)));
              },
              child: SizedBox(
                  height: 102.h,
                  child: SvgPicture.asset('assets/svg/Symbol.svg')),
            ),
          ),
          Positioned(
            right: 33.w,
            top: 33.h,
            bottom: 25.h,
            child: InkWell(
              onTap: () {},
              child: SizedBox(
                height: 102.h,
                child: SvgPicture.asset('assets/svg/Hover.svg'),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
