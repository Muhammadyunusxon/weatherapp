import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weather/Pages/HomePage.dart';
import 'Style/style.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return RefreshConfiguration(
              headerBuilder: ()=> const WaterDropMaterialHeader(
                color: Style.primaryColor,
                backgroundColor: Style.brandColor,
              ),
          child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Weather app',
          home: HomePage(),
          ));
        });
  }
}

