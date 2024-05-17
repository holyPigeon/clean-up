import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kyonggi_project/models/parking_lot_info.dart';

Future<List<ParkingLotInfo>> fetchParkingInfo(
    int month, int day, int hour, int minute
    ) async {
  var headers = {'Content-Type': 'application/json'};

  final body = jsonEncode({
    'month': month,
    'day': day,
    'hour': hour,
    'minute': minute,
  });
  final response = await http.post(
      Uri.parse('http://101.101.217.89:8080/parkinglot/info'),
      headers: headers,
      body: body);
  if (response.statusCode == 200) {
    final data = json.decode(response.body);

    final result = ParkingLotInfoResponse.fromJson(data);
    return result.results;
  } else {
    // 에러 처리
    throw Exception('error'); // 에러를 던집니다.
  }
}
