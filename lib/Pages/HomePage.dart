import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:osm_nominatim/osm_nominatim.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../Components/BottomNavyBar.dart';
import '../Components/ShimmerItem.dart';
import '../Components/background.dart';
import '../Repository/get_Information.dart';
import '../Style/style.dart';
import '../Style/textStyle.dart';
import '../model/weatherModel.dart';
import '../store/local_store.dart';
import 'bottomPage.dart';

class HomePage extends StatefulWidget {
  final int changePage;

  const HomePage({Key? key, this.changePage = 0}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  RefreshController controller = RefreshController();
  List<WeatherModel> listOfWeather = [];
  bool isLoading = true;
  double lat = 0;
  double lon = 0;
  List<String> listOfCountry = [];
  int changePage = 0;
  int? status;
  String? error;
  final RefreshController _refreshController = RefreshController();

  Future<bool> _determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      } else if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        var a = await Geolocator.getCurrentPosition();
        final reverseSearchResult = await Nominatim.reverseSearch(
          lat: a.latitude,
          lon: a.longitude,
          addressDetails: true,
          extraTags: true,
          nameDetails: true,
        );
        await LocalStore.setCountry(reverseSearchResult.address?["state"]);
        return true;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    var a = await Geolocator.getCurrentPosition();
    lat = a.latitude;
    lon = a.longitude;
    final reverseSearchResult = await Nominatim.reverseSearch(
      lat: a.latitude,
      lon: a.longitude,
      addressDetails: true,
      extraTags: true,
      nameDetails: true,
    );
    print(reverseSearchResult.address?["town"]);
    await LocalStore.setCountry(reverseSearchResult.address?["town"]);
    return true;
  }

  Future<WeatherModel> getWeatherInfo(String country) async {
    var data = await GetInformationRepository.getInformationWeather(country);
    return WeatherModel.fromJson(data);
  }

  getLocalStore() async {
    isLoading = true;
    setState(() {});
    await _determinePosition();
    List<String> listOfCountry = await LocalStore.getCountry();
    listOfWeather.clear();
    for (int i = 0; i < listOfCountry.length; i++) {
      WeatherModel model = await getWeatherInfo(listOfCountry[i]);
      listOfWeather.add(model);
    }
    _pageController.animateToPage(widget.changePage,
        duration: const Duration(seconds: 500), curve: Curves.bounceInOut);
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
    controller.dispose();
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
            await getLocalStore();
            _refreshController.refreshCompleted();
          },
          child: SafeArea(
            child: Column(
              children: [
                18.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0;
                        i <= (isLoading ? 1 : listOfWeather.length - 1);
                        i++)
                      i == 0
                          ? Icon(
                              Icons.near_me_rounded,
                              size: 12,
                              color: changePage == i
                                  ? Style.whiteColor
                                  : Style.shimmerBaseColor,
                            )
                          : AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              height: 6,
                              width: changePage == i ? 12 : 6,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                color: changePage == i
                                    ? Style.whiteColor
                                    : Style.shimmerBaseColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                  ],
                ),
                18.verticalSpace,
                Expanded(
                  child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (i) {
                        changePage = i;
                        setState(() {});
                      },
                      itemCount: isLoading ? 2 : listOfWeather.length,
                      itemBuilder: (context, index) {
                        return error ==
                                "Failed host lookup: 'api.weatherapi.com'"
                            ? Center(
                                child: Text(
                                'Oops!Weather app did not respond: please try again!',
                                style: PrimaryTextStyle.semiBold(size: 36.sp),
                              ))
                            : status == 400
                                ? Center(
                                    child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 18.w),
                                    child: Text(
                                      'Oops! Not found please try again!',
                                      style: PrimaryTextStyle.semiBold(
                                          size: 32.sp),
                                    ),
                                  ))
                                : Column(
                                    children: [
                                      isLoading
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 12, bottom: 2),
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(26),
                                                  child: const ShimmerItem(
                                                      height: 36, width: 175)),
                                            )
                                          : Text(
                                              listOfWeather[index]
                                                      .location
                                                      ?.name ??
                                                  "",
                                              style: PrimaryTextStyle.semiBold(
                                                  size: 28.sp),
                                            ),
                                      isLoading
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 12,
                                                  bottom: 12,
                                                  top: 12),
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  child: const ShimmerItem(
                                                      height: 90, width: 80)),
                                            )
                                          : Text(
                                              '${listOfWeather[index].current?.tempC.toString().split('.')[0] ?? ""}°',
                                              style: PrimaryTextStyle.thin(
                                                  size: 92.sp),
                                            ),
                                      isLoading
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 12, bottom: 2, top: 2),
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(26),
                                                  child: const ShimmerItem(
                                                      height: 24, width: 120)),
                                            )
                                          : Text(
                                              listOfWeather[index]
                                                      .current
                                                      ?.condition
                                                      ?.text ??
                                                  "",
                                              style: PrimaryTextStyle.semiBold(
                                                  size: 20.sp,
                                                  textColor: Style.whiteColor
                                                      .withOpacity(0.5)),
                                            ),
                                      isLoading
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 12, top: 2),
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(26),
                                                  child: const ShimmerItem(
                                                      height: 22, width: 100)),
                                            )
                                          : Text(
                                              'H:${listOfWeather[index].forecast?.forecastday?.first.day?.maxtempC.toString().split('.').first ?? " "}° '
                                              ' L:${listOfWeather[index].forecast?.forecastday?.first.day?.mintempC.toString().split('.').first ?? " "}°',
                                              style: PrimaryTextStyle.semiBold(
                                                  size: 18.sp),
                                            ),
                                      Expanded(
                                          child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                                left: 10.w,
                                                right: 10.w,
                                                child: Image.asset(
                                                    'assets/image/House.png')),
                                            Positioned(
                                              bottom: 0,
                                              child: Container(
                                                height: 500.h,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                    top: Radius.circular(30),
                                                  ),
                                                  gradient:
                                                      Style.primaryGradient,
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
                                                    weatherInfo: isLoading
                                                        ? null
                                                        : listOfWeather[index],
                                                    isLoading: isLoading,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      )),
                                    ],
                                  );
                      }),
                ),
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
