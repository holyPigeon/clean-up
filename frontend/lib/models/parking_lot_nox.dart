class ParkingLotInfoNoxResponse {
  List<ParkingLotInfoNox> results;

  ParkingLotInfoNoxResponse({required this.results});

  factory ParkingLotInfoNoxResponse.fromJson(Map<String, dynamic> json) {
    var resultList = json['data']['results'] as List;
    List<ParkingLotInfoNox> results =
    resultList.map((i) => ParkingLotInfoNox.fromJson(i)).toList();
    return ParkingLotInfoNoxResponse(results: results);
  }

  Map<String, dynamic> toJson() {
    return {
      'results': results.map((e) => e.toJson()).toList(),
    };
  }
}

class ParkingLotInfoNox {
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

  ParkingLotInfoNox({
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

  factory ParkingLotInfoNox.fromJson(Map<String, dynamic> json) {
    return ParkingLotInfoNox(
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
