import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kyonggi_project/models/predicted_sox.dart';

Future<List<PredictedSox>> fetchSox(
    int month, int day, int hour, int minute) async {
  var headers = {'Content-Type': 'application/json'};

  final body = jsonEncode({
    'month': month.toString(),
    'day': day.toString(),
    'hour': hour.toString(),
    'minute': minute.toString(),
  });
  final response = await http.post(
      Uri.parse('http://101.101.217.89:8080/parkinglot/predictByDateTime/sox'),
      headers: headers,
      body: body);
  if (response.statusCode == 200) {
    final data = json.decode(response.body);

    final result = PredictedSoxResponse.fromJson(data);
    return result.results;
  } else {
    // 에러 처리
    throw Exception('error'); // 에러를 던집니다.
  }
}
