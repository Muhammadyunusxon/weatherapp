import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../model/weatherModel.dart';

class GetInformationRepository {
  GetInformationRepository._();

  static int? status;

  static getInformation(String country) async {
    try {
      final url = Uri.parse(
          "https://api.weatherapi.com/v1/forecast.json?key=0aafe5ca2dc742cb8d7125331222212&q=${country}");
      final res = await http.get(url);
      var data;
      if (res.statusCode == 200) {
        data = convert.jsonDecode(res.body);
        status = res.statusCode;
      } else {
        status = res.statusCode;
      }
      WeatherModel info = WeatherModel.fromJson(data);
      return info;
    } catch (s) {
      print(s);
    }
  }
}
