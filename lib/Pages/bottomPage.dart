import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/Components/SquareInfoContainer.dart';
import 'package:weather/Components/hourly.dart';
import 'package:weather/model/weatherModel.dart';

import '../Style/style.dart';

class BottomPage extends StatelessWidget {
  final WeatherModel? weatherInfo;

  const BottomPage({Key? key, required this.weatherInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/image/Modal.png',
          fit: BoxFit.cover,
        ),
        ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(top: 5.h),
          children: [
            Container(
              height: 49.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/image/SegmentedControl.png'),
                fit: BoxFit.cover,
              )),
            ),
            SizedBox(
              height: 180,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount:
                      weatherInfo?.forecast?.forecastday?.first.hour?.length ??
                          0,
                  padding: EdgeInsets.only(left: 20.w, bottom: 22.h, top: 12.h),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return HourlyComponent(
                        weatherInfo: weatherInfo, index: index);
                  }),
            ),
            SizedBox(
                height: 350,
                child: GridView(
                  physics: const BouncingScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 164,
                    crossAxisSpacing: 22,
                    mainAxisSpacing: 16,
                  ),
                  children: [
                    SquareInfoContainer(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/svg/fi_sun.svg'),
                            6.horizontalSpace,
                            Text(
                              'UV INDEX',
                              style: Style.textStyleNormal(
                                size: 14.sp,
                                textColor: Style.whiteColor.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          weatherInfo?.current?.uv
                                  .toString()
                                  .split('.')
                                  .first ??
                              '',
                          style: Style.textStyleNormal(
                            size: 30.sp,
                          ),
                        ),
                        Text(
                          'Moderate',
                          style: Style.textStyleNormal(
                            size: 20.sp,
                          ),
                        ),
                      ],
                    ),
                    SquareInfoContainer(children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/svg/fi_sunrise.svg'),
                          6.horizontalSpace,
                          Text(
                            'SUNRISE',
                            style: Style.textStyleNormal(
                              size: 14.sp,
                              textColor: Style.whiteColor.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        weatherInfo?.forecast?.forecastday?.first.astro
                            ?.sunrise ??
                            '',
                        style: Style.textStyleNormal(
                          size: 30.sp,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Sunset ${weatherInfo?.forecast?.forecastday?.first.astro?.sunset}',
                        style: Style.textStyleNormal(
                          size: 14.sp,
                        ),
                      ),
                    ]),
                    const SquareInfoContainer(),
                    const SquareInfoContainer(),
                    const SquareInfoContainer(),
                    const SquareInfoContainer(),
                  ],
                ))
          ],
        ),
      ],
    );
  }
}
