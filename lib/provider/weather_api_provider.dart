import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app_with_api_and_provider/utils/app_urls.dart';

import '../models/WeatherModel.dart';

class WeatherApiProvider with ChangeNotifier {
  List<WeatherModel> weatherList = [];

  // Future<void> getWeatherData() async {
  //   final response = await http.get(Uri.parse(AppUrl.apiUri));
  //
  //   var data = jsonDecode(response.body.toString());
  //
  //   try {
  //     if (response.statusCode == 200) {
  //       weatherList.add(WeatherModel.fromJson(data));
  //     } else {
  //       print('Error ');
  //     }
  //   } catch (e) {
  //     print("Exception Occurs : ${e.toString()}");
  //   }
  //   notifyListeners();
  // }

  Future<List<WeatherModel>> getWeatherData(
      {required String countryName}) async {
    String apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$countryName&appid=83cc810c3b412f2e290a695a9d327f95';
    // final response = await http.get(Uri.parse(AppUrl.apiUri));
    final response = await http.get(Uri.parse(apiUrl));

    var data = jsonDecode(response.body.toString());

    try {
      if (response.statusCode == 200) {
        weatherList.add(WeatherModel.fromJson(data));
        return weatherList;
      } else {
        print('Error ');
        return weatherList;
      }
    } catch (e) {
      print("Exception Occurs : ${e.toString()}");
    }
    return weatherList;
    notifyListeners();
  }
}
