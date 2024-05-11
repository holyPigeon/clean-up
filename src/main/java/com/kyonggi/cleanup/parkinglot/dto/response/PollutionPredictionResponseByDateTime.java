package com.kyonggi.cleanup.parkinglot.dto.response;

import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
@Builder
public class PollutionPredictionResponseByDateTime {
    private List<Result> results;

    public static PollutionPredictionResponseByDateTime of(List<PollutionPredictionResponseByDateTime.Result> results) {
        return PollutionPredictionResponseByDateTime.builder()
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
        private double actualSox;
        private double predictedSox;

        public static Result of(
                int month,
                int day,
                int hour,
                int minute,
                double actualNox,
                double predictedNox,
                double actualSox,
                double predictedSox
        ) {
            return Result.builder()
                    .month(month)
                    .day(day)
                    .hour(hour)
                    .minute(minute)
                    .actualNox(actualNox)
                    .predictedNox(predictedNox)
                    .actualSox(actualSox)
                    .predictedSox(predictedSox)
                    .build();
        }
    }
}