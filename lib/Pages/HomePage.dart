import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/Components/backgraund.dart';
import 'package:weather/model/weatherModel.dart';

import '../Repository/get_Information.dart';
import '../Style/style.dart';
import 'addLocationPage.dart';

class HomePage extends StatefulWidget {
  final String location;

  const HomePage({Key? key, this.location = 'Tashkent'}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherModel? weatherInfo;
  bool isLoading = true;
  int? status;

  getInformation() async {
    isLoading = true;
    setState(() {});
    weatherInfo =
        await GetInformationRepository.getInformation(widget.location);
    status = GetInformationRepository.status;
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getInformation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: Column(
                  children: [
                    50.verticalSpace,
                    Text(
                      weatherInfo?.location?.name ?? "",
                      style: Style.textStyleSemiBold(size: 28.sp),
                    ),
                    Text(
                      '${weatherInfo?.current?.tempC.toString().split('.')[0] ?? ""}°',
                      style: Style.textStyleThin(size: 96.sp),
                    ),
                    Text(
                      weatherInfo?.current?.condition?.text ?? "",
                      style: Style.textStyleSemiBold(
                          size: 20.sp,
                          textColor: Style.whiteColor.withOpacity(0.5)),
                    ),
                    Text(
                      'H:${weatherInfo?.forecast?.forecastday?.first.day?.maxtempC.toString().split('.').first ?? " "}° '
                      ' L:${weatherInfo?.forecast?.forecastday?.first.day?.mintempC.toString().split('.').first ?? " "}°',
                      style: Style.textStyleSemiBold(size: 18.sp),
                    ),
                    Expanded(
                        child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          Positioned(
                              left: 10.w,
                              right: 10.w,
                              child: Image.asset('assets/image/House.png')),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              height: 500.h,
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30),
                                ),
                                gradient: Style.primaryGradient,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -10,
                            left: 0,
                            right: 0,
                            child: SizedBox(
                                height: 350.h,
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      'assets/image/Modal.png',
                                      fit: BoxFit.cover,
                                    ),
                                    Column(
                                      children: [
                                        49.verticalSpace,
                                        20.verticalSpace,
                                        SizedBox(
                                          height: 146,
                                          child: ListView.builder(
                                              itemCount: weatherInfo
                                                      ?.forecast
                                                      ?.forecastday
                                                      ?.first
                                                      .hour
                                                      ?.length ??
                                                  0,
                                              padding:
                                                  EdgeInsets.only(left: 20.w),
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    print(weatherInfo
                                                            ?.forecast
                                                            ?.forecastday
                                                            ?.first
                                                            .hour?[index]
                                                            .time
                                                            ?.substring(
                                                                10, 13) ==
                                                        weatherInfo?.current
                                                            ?.lastUpdated
                                                            ?.substring(
                                                                10, 13));
                                                  },
                                                  child: Container(
                                                    height: 146.h,
                                                    width: 60.w,
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 16),
                                                    margin: EdgeInsets.only(
                                                        right: 12.w),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30.r),
                                                        color: weatherInfo
                                                                    ?.forecast
                                                                    ?.forecastday
                                                                    ?.first
                                                                    .hour?[
                                                                        index]
                                                                    .time
                                                                    ?.substring(
                                                                        10,
                                                                        13) ==
                                                                weatherInfo
                                                                    ?.current
                                                                    ?.lastUpdated
                                                                    ?.substring(
                                                                        10, 13)
                                                            ? Color(0xff48319D)
                                                            : Color(0xff48319D)
                                                                .withOpacity(
                                                                    0.55)),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          weatherInfo
                                                                      ?.forecast
                                                                      ?.forecastday
                                                                      ?.first
                                                                      .hour?[
                                                                          index]
                                                                      .time
                                                                      ?.substring(
                                                                          10,
                                                                          13) ==
                                                                  weatherInfo
                                                                      ?.current
                                                                      ?.lastUpdated
                                                                      ?.substring(
                                                                          10,
                                                                          13)
                                                              ? 'Now'
                                                              : weatherInfo
                                                                      ?.forecast
                                                                      ?.forecastday
                                                                      ?.first
                                                                      .hour?[
                                                                          index]
                                                                      .time
                                                                      ?.substring(
                                                                          10) ??
                                                                  '',
                                                          style: Style
                                                              .textStyleNormal(
                                                                  size: 15.sp),
                                                        ),
                                                        Text(
                                                          weatherInfo
                                                                  ?.forecast
                                                                  ?.forecastday
                                                                  ?.first
                                                                  .hour?[index]
                                                                  .condition
                                                                  ?.text ??
                                                              '',
                                                          style: Style
                                                              .textStyleNormal(
                                                                  size: 15.sp),
                                                        ),
                                                        Text(
                                                          '${weatherInfo?.forecast?.forecastday?.first.hour?[index].tempC?.toString().split('.')[0] ?? ''}°',
                                                          style: Style
                                                              .textStyleNormal(
                                                                  size: 20.sp),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
          child: SizedBox(
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
              child:  SizedBox(
                  height: 102.h,
                  child: Image.asset('assets/image/Subtract.png')),
            ),
            Positioned(
              left: 66.w,
              right: 66.w,
              bottom: 0,
              child:  GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_)=>AddLocationPage()));
                },
                child: SizedBox(
                    height: 102.h,
                    child: Image.asset('assets/image/button.png')),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
