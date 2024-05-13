class PredictedNoxResponse {
  List<PredictedNox> results;

  PredictedNoxResponse({required this.results});

  factory PredictedNoxResponse.fromJson(Map<String, dynamic> json) {
    var resultList = json['data']['results'] as List;
    List<PredictedNox> results =
        resultList.map((i) => PredictedNox.fromJson(i)).toList();
    return PredictedNoxResponse(results: results);
  }

  Map<String, dynamic> toJson() {
    return {
      'results': results.map((e) => e.toJson()).toList(),
    };
  }
}

class PredictedNox {
  int month;
  int day;
  int hour;
  int minute;
  double actualNox;
  double predictedNox;
  PredictedNox({
    required this.month,
    required this.day,
    required this.hour,
    required this.minute,
    required this.actualNox,
    required this.predictedNox,
  });
  factory PredictedNox.fromJson(Map<String, dynamic> json) {
    return PredictedNox(
      month: json["month"],
      day: json["day"],
      hour: json["hour"],
      minute: json["minute"],
      actualNox: json["actualNox"].toDouble(),
      predictedNox: json["predictedNox"].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'day': day,
      'hour': hour,
      'minute': minute,
      'actualNox': actualNox,
      'predictedNox': predictedNox,
    };
  }
}
