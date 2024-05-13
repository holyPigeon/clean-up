// ignore_for_file: public_member_api_docs, sort_constructors_first
class WeatherInfo {
  String temp;
  String humidity;
  WeatherInfo({
    required this.temp,
    required this.humidity,
  });
  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    return WeatherInfo(
      temp: json['data']['temperature'],
      humidity: json['data']['humidity'],
    );
  }
}
