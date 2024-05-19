class PrakingLotPredictedNoxResponse {
  List<PrakingLotPredictedNox> results;

  PrakingLotPredictedNoxResponse({required this.results});

  factory PrakingLotPredictedNoxResponse.fromJson(Map<String, dynamic> json) {
    var resultList = json['data']['results'] as List;
    List<PrakingLotPredictedNox> results =
    resultList.map((i) => PrakingLotPredictedNox.fromJson(i)).toList();
    return PrakingLotPredictedNoxResponse(results: results);
  }

  Map<String, dynamic> toJson() {
    return {
      'results': results.map((e) => e.toJson()).toList(),
    };
  }
}

class PrakingLotPredictedNox {
  double passedMinute;
  double predictedNox;
  PrakingLotPredictedNox({
    required this.passedMinute,
    required this.predictedNox,
  });
  factory PrakingLotPredictedNox.fromJson(Map<String, dynamic> json) {
    return PrakingLotPredictedNox(
      passedMinute: json["passedMinute"].toDouble(),
      predictedNox: json["predictedNox"].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'passedMinute': passedMinute,
      'predictedNox': predictedNox,
    };
  }
}
