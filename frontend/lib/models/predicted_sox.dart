class PredictedSoxResponse {
  List<PredictedSox> results;

  PredictedSoxResponse({required this.results});

  factory PredictedSoxResponse.fromJson(Map<String, dynamic> json) {
    var resultList = json['data']['results'] as List;
    List<PredictedSox> results =
        resultList.map((i) => PredictedSox.fromJson(i)).toList();
    return PredictedSoxResponse(results: results);
  }

  Map<String, dynamic> toJson() {
    return {
      'results': results.map((e) => e.toJson()).toList(),
    };
  }
}

class PredictedSox {
  int month;
  int day;
  int hour;
  int minute;
  double actualSox;
  double predictedSox;
  PredictedSox({
    required this.month,
    required this.day,
    required this.hour,
    required this.minute,
    required this.actualSox,
    required this.predictedSox,
  });
  factory PredictedSox.fromJson(Map<String, dynamic> json) {
    return PredictedSox(
      month: json["month"],
      day: json["day"],
      hour: json["hour"],
      minute: json["minute"],
      actualSox: json["actualSox"],
      predictedSox: json["predictedSox"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'day': day,
      'hour': hour,
      'minute': minute,
      'actualSox': actualSox,
      'predictedSox': predictedSox,
    };
  }
}
