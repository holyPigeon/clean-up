package com.kyonggi.cleanup.parkinglot.dto.response;

import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
@Builder
public class NoxPredictionResponseByCondition {
    private List<NoxPredictionResponseByCondition.Result> results;

    public static NoxPredictionResponseByCondition of(List<NoxPredictionResponseByCondition.Result> results) {
        return NoxPredictionResponseByCondition.builder()
                .results(results)
                .build();
    }

    @Getter
    @Builder
    public static class Result {
        private int passedMinute;
        private double predictedNox;

        public static NoxPredictionResponseByCondition.Result of(int minute, double predictedNox) {
            return NoxPredictionResponseByCondition.Result.builder()
                    .passedMinute(minute)
                    .predictedNox(predictedNox)
                    .build();
        }
    }
}
