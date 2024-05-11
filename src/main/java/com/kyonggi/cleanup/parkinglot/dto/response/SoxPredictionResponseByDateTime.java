package com.kyonggi.cleanup.parkinglot.dto.response;

import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
@Builder
public class SoxPredictionResponseByDateTime {
    private List<Result> results;

    public static SoxPredictionResponseByDateTime of(List<SoxPredictionResponseByDateTime.Result> results) {
        return SoxPredictionResponseByDateTime.builder()
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
        private double actualSox;
        private double predictedSox;

        public static Result of(
                int month,
                int day,
                int hour,
                int minute,
                double actualSox,
                double predictedSox
        ) {
            return Result.builder()
                    .month(month)
                    .day(day)
                    .hour(hour)
                    .minute(minute)
                    .actualSox(actualSox)
                    .predictedSox(predictedSox)
                    .build();
        }
    }
}