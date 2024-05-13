import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kyonggi_project/models/predicted_nox.dart';

Future<List<PredictedNox>> fetchNox(
    int month, int day, int hour, int minute) async {
  String url = "http://101.101.217.89:8080/parkinglot/predictByDateTime/nox";
  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
  Map<String, dynamic> body = {
    "month": month,
    "day": day,
    "hour": hour,
    "minute": minute,
  };

  // API 요청 보내기

  http.Response response = await http.post(
    Uri.parse(url),
    headers: headers,
    body: jsonEncode(body),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final result = PredictedNoxResponse.fromJson(data);
    return result.results;
  } else {
    // 에러 처리
    throw Exception('error'); // 에러를 던집니다.
  }
}
