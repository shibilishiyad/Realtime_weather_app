import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/wether_model.dart';
import 'package:weather_app/screts/api_endpoints.dart';

class WeatherServiceProvider extends ChangeNotifier {
  WeatherModel? _weather;

  WeatherModel? get weather => _weather;

  bool _isloding = false;
  bool get isloding => _isloding;

  String _error = '';

  String get error => _error;
  Future<void> fechDataByCity(String city) async {
    _isloding = true;
    _error = '';
    try {
      final String apiurl =
          // ignore: unnecessary_brace_in_string_interps
          '${ApiEndpoints().cityurl}${city}&appid=${ApiEndpoints().apikey}${ApiEndpoints().unit}';
      

      //hitting the url like this
      final response = await http.get(Uri.parse(apiurl));
      // 200 means the data feching sucessfull
      if (response.statusCode == 200) {
        //http hold the data in the body of http thats why we call thebody heare

        final data = jsonDecode(response.body);
       
        _weather = WeatherModel.fromJson(data);
        notifyListeners();
      } else {
        _error = 'Data Feching Failed';
      }
    } catch (e) {
      _error = 'Data Feching Failed$e';
    } finally {
      _isloding = false;
      notifyListeners();
    }
  }
}
