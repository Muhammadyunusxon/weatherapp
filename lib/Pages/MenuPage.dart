import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weather/Components/ShimmerItem.dart';
import 'package:weather/Pages/HomePage.dart';
import 'package:weather/Style/style.dart';
import 'package:weather/Style/textStyle.dart';

import '../Repository/get_Information.dart';
import '../model/weatherModel.dart';
import '../store/local_store.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  bool isLoading = false;
  List<String> listOfCountry = [];
  List<WeatherModel> listOfWeather = [];
  final RefreshController _refreshController =RefreshController();

  Future<WeatherModel> getWeatherInfo(String country) async {
    var data = await GetInformationRepository.getInformationWeather(country);
    return WeatherModel.fromJson(data);
  }

  getLocalStore() async {
    isLoading = true;
    setState(() {});
    List<String> listOfCountry = await LocalStore.getCountry();
    listOfWeather.clear();
    for (int i = 0; i < listOfCountry.length; i++) {
      WeatherModel model = await getWeatherInfo(listOfCountry[i]);
      listOfWeather.add(model);
    }
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getLocalStore();
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: false,
      onLoading: () {},
      onRefresh: () async {
        await getLocalStore();
        _refreshController.refreshCompleted();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 35.w,
        ),
        decoration: const BoxDecoration(gradient: Style.backgroundGradient),
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: isLoading ? 4 : listOfWeather.length,
            padding: EdgeInsets.only(
                left: 12.w, right: 12.w, top: 100.h, bottom: 10.h),
            itemBuilder: (context, index) {
              return isLoading
                  ? Padding(
                padding:
                const EdgeInsets.only(right: 12, bottom: 20, top: 2),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: const ShimmerItem(
                        height: 184, width: double.infinity)),
              )
                  : GestureDetector(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => HomePage(changePage: index,)), (
                      route) => false);
                },
                child: Container(
                  height: 184.h,
                  padding: EdgeInsets.only(
                    left: 20.sp,
                    bottom: 20.sp,
                  ),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/image/container.png'),
                      )),
                  margin: EdgeInsets.only(bottom: 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          24.verticalSpace,
                          Text(
                            "${listOfWeather[index].current?.tempC?.floor()}°",
                            style: PrimaryTextStyle.thin(size: 56.sp),
                          ),
                          const Spacer(),
                          Text(
                            'H:${listOfWeather[index].forecast?.forecastday?.first
                                .day?.maxtempC
                                .toString()
                                .split('.')
                                .first ?? " "}° '
                                ' L:${listOfWeather[index].forecast?.forecastday
                                ?.first.day?.mintempC
                                .toString()
                                .split('.')
                                .first ?? " "}°',
                            style: PrimaryTextStyle.semiBold(
                                size: 15.sp, textColor: Style.textColor),
                          ),
                          Text(
                            '${listOfWeather[index].location?.name},'
                                ' ${listOfWeather[index].location?.country}',
                            style: PrimaryTextStyle.semiBold(size: 15.sp),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          7.verticalSpace,
                          SizedBox(
                            height: 125.r,
                            width: 125.r,
                            child: Image.network(
                              "https:${listOfWeather[index].forecast?.forecastday
                                  ?.first.hour?[index].condition?.icon ?? ''}",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 6.sp),
                            child: SizedBox(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 3.6,
                              child: Text(
                                listOfWeather[index]
                                    .forecast
                                    ?.forecastday
                                    ?.first
                                    .hour?[index]
                                    .condition
                                    ?.text ??
                                    '',
                                overflow: TextOverflow.ellipsis,
                                style: PrimaryTextStyle.normal(size: 14),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
