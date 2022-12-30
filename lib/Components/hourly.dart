import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/model/weatherModel.dart';

import '../Style/style.dart';
import '../Style/textStyle.dart';
class HourlyComponent extends StatelessWidget {
  final WeatherModel? weatherInfo;
  final int index;
  const HourlyComponent({Key? key, required this.weatherInfo, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 146.h,
        width: 60.w,
        padding: EdgeInsets.symmetric(
            vertical: 16.h, horizontal: 7.w),
        margin: EdgeInsets.only(right: 12.w),
        decoration: BoxDecoration(
            boxShadow: Style.hourlyShadow,
            border: Border.all(
                width: 1,
                color: weatherInfo?.forecast?.forecastday
                    ?.first.hour?[index].time
                    ?.substring(10, 13) ==
                    weatherInfo?.current?.lastUpdated?.substring(10, 13)
                    ? Style.whiteColor.withOpacity(0.5)
                    : Style.whiteColor.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(30.r),
            color: weatherInfo?.forecast?.forecastday
                ?.first.hour?[index].time
                ?.substring(10, 13) ==
                weatherInfo?.current?.lastUpdated?.substring(10, 13)
                ? const Color(0xff48319D)
                : const Color(0xff48319D).withOpacity(0.2)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              weatherInfo?.forecast?.forecastday?.first
                  .hour?[index].time
                  ?.substring(10, 13) ==
                  weatherInfo?.current?.lastUpdated
                      ?.substring(10, 13)
                  ? 'Now'
                  : weatherInfo?.forecast?.forecastday
                  ?.first.hour?[index].time
                  ?.substring(10) ??
                  '',
              style: PrimaryTextStyle.normal(size: 15.sp),
            ),
            Image.network(
                "https:${weatherInfo?.forecast?.forecastday?.first.hour?[index].condition?.icon?? ''}",
            ),
            Text(
              '${weatherInfo?.forecast?.forecastday?.first.hour?[index].tempC?.toString().split('.')[0] ?? ''}°',
              style: PrimaryTextStyle.normal(size: 20.sp),
            ),
          ],
        ),
      ),
    );
  }
}
