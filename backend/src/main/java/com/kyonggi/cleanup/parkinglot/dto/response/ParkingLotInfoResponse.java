package com.kyonggi.cleanup.parkinglot.dto.response;

import com.kyonggi.cleanup.parkinglot.domain.ParkingLotData;
import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
@Builder
public class ParkingLotInfoResponse {

    private List<Result> results;

    public static ParkingLotInfoResponse of(List<ParkingLotData> items) {
        List<Result> list = items.stream()
                .map(Result::of)
                .toList();

        return ParkingLotInfoResponse.builder()
                .results(list)
                .build();
    }

    @Getter
    @Builder
    public static class Result {

        private int month;
        private int day;
        private int hour;
        private int minute;
        private double externalTemperature;
        private double externalHumidity;
        private double externalNox;
        private double externalSox;
        private double temperature;
        private double humidity;
        private double nox;
        private double sox;
        private int carCount;

        public static Result of(ParkingLotData parkingLotData) {
            return Result.builder()
                    .month(parkingLotData.getMonth())
                    .day(parkingLotData.getDay())
                    .hour(parkingLotData.getHour())
                    .minute(parkingLotData.getMinute())
                    .temperature(parkingLotData.getTemperature())
                    .humidity(parkingLotData.getHumidity())
                    .nox(parkingLotData.getNox())
                    .sox(parkingLotData.getSox())
                    .externalTemperature(parkingLotData.getExternalTemperature())
                    .externalHumidity(parkingLotData.getExternalHumidity())
                    .externalNox(parkingLotData.getExternalNox())
                    .externalSox(parkingLotData.getExternalSox())
                    .carCount(parkingLotData.getCarCount())
                    .build();
        }
    }
}
