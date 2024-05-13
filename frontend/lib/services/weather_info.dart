import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kyonggi_project/models/dust_info.dart';
import 'package:kyonggi_project/models/parking_lot_info.dart';
import 'package:kyonggi_project/models/weather_info.dart';

Future<WeatherInfo> fetchWeatherInfo() async {
  final response = await http.get(
    Uri.parse('http://101.101.217.89:8080/weather/info'),
  );
  if (response.statusCode == 200) {
    final data = json.decode(response.body);

    final result = WeatherInfo.fromJson(data);
    return result;
  } else {
    // 에러 처리
    throw Exception('error'); // 에러를 던집니다.
  }
}
