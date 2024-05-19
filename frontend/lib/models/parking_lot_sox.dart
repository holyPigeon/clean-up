class ParkingLotInfoSoxResponse {
  List<ParkingLotInfoSox> results;

  ParkingLotInfoSoxResponse({required this.results});

  factory ParkingLotInfoSoxResponse.fromJson(Map<String, dynamic> json) {
    var resultList = json['data']['results'] as List;
    List<ParkingLotInfoSox> results =
    resultList.map((i) => ParkingLotInfoSox.fromJson(i)).toList();
    return ParkingLotInfoSoxResponse(results: results);
  }

  Map<String, dynamic> toJson() {
    return {
      'results': results.map((e) => e.toJson()).toList(),
    };
  }
}

class ParkingLotInfoSox {
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

  ParkingLotInfoSox({
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

  factory ParkingLotInfoSox.fromJson(Map<String, dynamic> json) {
    return ParkingLotInfoSox(
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
