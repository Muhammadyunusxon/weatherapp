import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weather/Components/BottomNavyBar.dart';
import 'package:weather/Components/backgraund.dart';
import 'package:weather/Pages/bottomPage.dart';
import 'package:weather/model/weatherModel.dart';

import '../Components/ShimmerItem.dart';
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
  RefreshController _refreshController = RefreshController();

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
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImage(
        child: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          enablePullUp: false,
          onLoading: () {},
          onRefresh: () async {
            await getInformation();
            _refreshController.refreshCompleted();
          },
          child: error == "Failed host lookup: 'api.weatherapi.com'"
              ? Center(
                  child: Text(
                  'Oops!Weather app did not respond: please try again!',
                  style: Style.textStyleSemiBold(size: 36.sp),
                ))
              : status == 400
                  ? Center(
                      child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      child: Text(
                        'Oops! Not found please try again!',
                        style: Style.textStyleSemiBold(size: 32.sp),
                      ),
                    ))
                  : SafeArea(
                      child: Column(
                        children: [
                          50.verticalSpace,
                          isLoading
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      right: 12, bottom: 2),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(26),
                                      child: const ShimmerItem(
                                          height: 36, width: 175)),
                                )
                              : Text(
                                  weatherInfo?.location?.name ?? "",
                                  style: Style.textStyleSemiBold(size: 28.sp),
                                ),
                          isLoading
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      right: 12, bottom: 12, top: 12),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: const ShimmerItem(
                                          height: 90, width: 80)),
                                )
                              : Text(
                                  '${weatherInfo?.current?.tempC.toString().split('.')[0] ?? ""}°',
                                  style: Style.textStyleThin(size: 92.sp),
                                ),
                          isLoading
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      right: 12, bottom: 2, top: 2),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(26),
                                      child: const ShimmerItem(
                                          height: 24, width: 120)),
                                )
                              : Text(
                                  weatherInfo?.current?.condition?.text ?? "",
                                  style: Style.textStyleSemiBold(
                                      size: 20.sp,
                                      textColor:
                                          Style.whiteColor.withOpacity(0.5)),
                                ),
                          isLoading
                              ? Padding(
                                  padding:
                                      const EdgeInsets.only(right: 12, top: 2),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(26),
                                      child: const ShimmerItem(
                                          height: 22, width: 100)),
                                )
                              : Text(
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
                                    child:
                                        Image.asset('assets/image/House.png')),
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
                                      child: BottomPage(
                                        weatherInfo: weatherInfo,
                                        isLoading: isLoading,
                                      )),
                                ),
                              ],
                            ),
                          )),
                        ],
                      ),
                    ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const BottomNavyBar(),
    );
  }
}
