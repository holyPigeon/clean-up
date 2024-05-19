import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/parking_lot_predicted_nox.dart';
import '../models/parking_lot_predicted_sox.dart';

Future<List<PrakingLotPredictedNox>> fetchParkingLotPredictNox(
    int hour,
    int minute,
    int carCount,
    double dieselRatio,
    double temperature,
    double humidity,
    double actualNox,
    double actualSox,
    double externalTemperature,
    double externalHumidity,
    double actualExternalNox,
    double actualExternalSox,
    ) async {
  var headers = {'Content-Type': 'application/json'};

  final body = jsonEncode({
    "hour": hour,
    "minute": minute,
    "carCount": carCount,
    "dieselRatio": dieselRatio,
    "temperature": temperature,
    "humidity": humidity,
    "actualNox": actualNox,
    "actualSox": actualSox,
    "externalTemperature": externalTemperature,
    "externalHumidity": externalHumidity,
    "actualExternalNox": actualExternalNox,
    "actualExternalSox": actualExternalSox,
  });

  final response = await http.post(
      Uri.parse('http://101.101.217.89:8080/parkinglot/predictByCondition/nox'),
      headers: headers,
      body: body);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final result = PrakingLotPredictedNoxResponse.fromJson(data);
    return result.results;
  } else {
    throw Exception('error');
  }
}

Future<List<PrakingLotPredictedSox>> fetchParkingLotPredictSox(
    int hour,
    int minute,
    int carCount,
    double dieselRatio,
    double temperature,
    double humidity,
    double actualNox,
    double actualSox,
    double externalTemperature,
    double externalHumidity,
    double actualExternalNox,
    double actualExternalSox,
    ) async {
  var headers = {'Content-Type': 'application/json'};

  final body = jsonEncode({
    "hour": hour,
    "minute": minute,
    "carCount": carCount,
    "dieselRatio": dieselRatio,
    "temperature": temperature,
    "humidity": humidity,
    "actualNox": actualNox,
    "actualSox": actualSox,
    "externalTemperature": externalTemperature,
    "externalHumidity": externalHumidity,
    "actualExternalNox": actualExternalNox,
    "actualExternalSox": actualExternalSox,
  });

  final response = await http.post(
      Uri.parse('http://101.101.217.89:8080/parkinglot/predictByCondition/sox'),
      headers: headers,
      body: body);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final result = PrakingLotPredictedSoxResponse.fromJson(data);
    return result.results;
  } else {
    throw Exception('error');
  }
}
