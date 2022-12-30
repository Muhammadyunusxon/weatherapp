

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../model/weatherModel.dart';

class GetInformationRepository {
  GetInformationRepository._();

  static int? status;
  static String? error;

  static getInformationWeather(String country) async {
    try {
      final url = Uri.parse(
          "https://api.weatherapi.com/v1/forecast.json?key=34756a8dd06a496e9b181309222812%20&q=$country&days=10");
      final res = await http.get(url);
      var data;
      if (res.statusCode == 200) {
        data = convert.jsonDecode(res.body);
        status = res.statusCode;
      } else {
        status = res.statusCode;
      }

      return data;
    } catch (s) {
      error=s.toString();
      print(s);
    }
  }
}
