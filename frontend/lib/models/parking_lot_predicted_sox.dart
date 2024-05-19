class PrakingLotPredictedSoxResponse {
  List<PrakingLotPredictedSox> results;

  PrakingLotPredictedSoxResponse({required this.results});

  factory PrakingLotPredictedSoxResponse.fromJson(Map<String, dynamic> json) {
    var resultList = json['data']['results'] as List;
    List<PrakingLotPredictedSox> results =
    resultList.map((i) => PrakingLotPredictedSox.fromJson(i)).toList();
    return PrakingLotPredictedSoxResponse(results: results);
  }

  Map<String, dynamic> toJson() {
    return {
      'results': results.map((e) => e.toJson()).toList(),
    };
  }
}

class PrakingLotPredictedSox {
  double passedMinute;
  double predictedNox;
  PrakingLotPredictedSox({
    required this.passedMinute,
    required this.predictedNox,
  });
  factory PrakingLotPredictedSox.fromJson(Map<String, dynamic> json) {
    return PrakingLotPredictedSox(
      passedMinute: json["passedMinute"].toDouble(),
      predictedNox: json["predictedSox"].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'passedMinute': passedMinute,
      'predictedSox': predictedNox,
    };
  }
}
