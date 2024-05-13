package com.kyonggi.cleanup.parkinglot.dto.response;

import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
@Builder
public class PollutionPredictionResponseByCondition {
    private List<PollutionPredictionResponseByCondition.Result> results;

    public static PollutionPredictionResponseByCondition of(List<PollutionPredictionResponseByCondition.Result> results) {
        return PollutionPredictionResponseByCondition.builder()
                .results(results)
                .build();
    }

    @Getter
    @Builder
    public static class Result {
        private int passedMinute;
        private double predictedNox;
        private double predictedSox;

        public static PollutionPredictionResponseByCondition.Result of(int minute, double predictedNox, double predictedSox) {
            return PollutionPredictionResponseByCondition.Result.builder()
                    .passedMinute(minute)
                    .predictedNox(predictedNox)
                    .predictedSox(predictedSox)
                    .build();
        }
    }
}
