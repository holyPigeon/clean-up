package com.kyonggi.cleanup.parkinglot.dto.response;

import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
@Builder
public class NoxPredictionResponseByDateTime {
    private List<Result> results;

    public static NoxPredictionResponseByDateTime of(List<NoxPredictionResponseByDateTime.Result> results) {
        return NoxPredictionResponseByDateTime.builder()
                .results(results)
                .build();
    }

    @Getter
    @Builder
    public static class Result {

        private int month;
        private int day;
        private int hour;
        private int minute;
        private double actualNox;
        private double predictedNox;

        public static Result of(
                int month,
                int day,
                int hour,
                int minute,
                double actualNox,
                double predictedNox
        ) {
            return Result.builder()
                    .month(month)
                    .day(day)
                    .hour(hour)
                    .minute(minute)
                    .actualNox(actualNox)
                    .predictedNox(predictedNox)
                    .build();
        }
    }
}