import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/Components/BottomNavyBar.dart';
import 'package:weather/Components/backgraund.dart';
import 'package:weather/Pages/bottomPage.dart';
import 'package:weather/model/weatherModel.dart';

import '../Repository/get_Information.dart';
import '../Style/style.dart';

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
  String? error;

  getInformation() async {
    isLoading = true;
    setState(() {});
    weatherInfo =
        await GetInformationRepository.getInformation(widget.location);
    status = GetInformationRepository.status;
    error = GetInformationRepository.error;
    print(status);
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
        child: error == "Failed host lookup: 'api.weatherapi.com'"
            ? Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Text(
                  'Oops! Weather app did not respond: please try again!',
                  style: Style.textStyleSemiBold(size: 28.sp),
              ),
                ))
            :status==400 ? Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                'Oops! Not found please try again!',
                style: Style.textStyleSemiBold(size: 28.sp),
              ),
            ))  :isLoading
                ? const Center(child: CircularProgressIndicator(color: Colors.white,))
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
                                    child: BottomPage( weatherInfo: weatherInfo,)),
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const BottomNavyBar(),
    );
  }
}
