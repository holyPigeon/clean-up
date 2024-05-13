class ParkingLotInfoResponse {
  List<ParkingLotInfo> results;

  ParkingLotInfoResponse({required this.results});

  factory ParkingLotInfoResponse.fromJson(Map<String, dynamic> json) {
    var resultList = json['data']['results'] as List;
    List<ParkingLotInfo> results =
        resultList.map((i) => ParkingLotInfo.fromJson(i)).toList();
    return ParkingLotInfoResponse(results: results);
  }

  Map<String, dynamic> toJson() {
    return {
      'results': results.map((e) => e.toJson()).toList(),
    };
  }
}

class ParkingLotInfo {
  int month;
  int day;
  int hour;
  int minute;
  int carCount;
  double temperature;
  double humidity;
  double nox;
  double sox;
  double exTemperature;
  double exHumidity;
  double exNox;
  double exSox;

  ParkingLotInfo({
    required this.month,
    required this.day,
    required this.hour,
    required this.minute,
    required this.carCount,
    required this.temperature,
    required this.humidity,
    required this.nox,
    required this.sox,
    required this.exTemperature,
    required this.exHumidity,
    required this.exNox,
    required this.exSox,
  });

  factory ParkingLotInfo.fromJson(Map<String, dynamic> json) {
    return ParkingLotInfo(
      month: json['month'],
      day: json['day'],
      hour: json['hour'],
      minute: json['minute'],
      carCount: json['carCount'],
      temperature: json['temperature'].toDouble(),
      humidity: json['humidity'].toDouble(),
      nox: json['nox'].toDouble(),
      sox: json['sox'].toDouble(),
      exTemperature: json['externalTemperature'].toDouble(),
      exHumidity: json['externalHumidity'].toDouble(),
      exNox: json['externalNox'].toDouble(),
      exSox: json['externalSox'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'day': day,
      'hour': hour,
      'minute': minute,
      'carCount': carCount,
      'temperature': temperature,
      'humidity': humidity,
      'nox': nox,
      'sox': sox,
      'externalTemperature': exTemperature,
      'externalHumidity': exHumidity,
      'externalNox': exNox,
      'externalSox': exSox,
    };
  }
}
