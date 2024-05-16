package com.kyonggi.cleanup.parkinglot.dto.response;

import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
@Builder
public class SoxPredictionResponseByCondition {
    private List<SoxPredictionResponseByCondition.Result> results;

    public static SoxPredictionResponseByCondition of(List<SoxPredictionResponseByCondition.Result> results) {
        return SoxPredictionResponseByCondition.builder()
                .results(results)
                .build();
    }

    @Getter
    @Builder
    public static class Result {
        private int passedMinute;
        private double predictedSox;

        public static SoxPredictionResponseByCondition.Result of(int minute, double predictedSox) {
            return SoxPredictionResponseByCondition.Result.builder()
                    .passedMinute(minute)
                    .predictedSox(predictedSox)
                    .build();
        }
    }
}
