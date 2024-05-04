package com.kyonggi.cleanup.parkinglot.application.dto.response;

import com.kyonggi.cleanup.parkinglot.domain.ParkingLotData;
import lombok.Builder;
import lombok.Getter;

import java.util.List;

@Getter
@Builder
public class ParkingLotInfoResponse {

    private List<ParkingLotDataResponse> items;

    public static ParkingLotInfoResponse of(List<ParkingLotData> items) {
        List<ParkingLotDataResponse> list = items.stream()
                .map(ParkingLotDataResponse::of)
                .toList();

        return ParkingLotInfoResponse.builder()
                .items(list)
                .build();
    }

    @Getter
    @Builder
    public static class ParkingLotDataResponse {

        private int month;
        private int day;
        private int hour;
        private int minute;
        private int carCount;
        private double temperature;
        private double humidity;
        private double nox;
        private double sox;
        private double dieselVehiclePercentage;

        public static ParkingLotDataResponse of(ParkingLotData parkingLotData) {
            return ParkingLotDataResponse.builder()
                    .month(parkingLotData.getMonth())
                    .day(parkingLotData.getDay())
                    .hour(parkingLotData.getHour())
                    .minute(parkingLotData.getMinute())
                    .carCount(parkingLotData.getCarCount())
                    .temperature(parkingLotData.getTemperature())
                    .humidity(parkingLotData.getHumidity())
                    .nox(parkingLotData.getNox())
                    .sox(parkingLotData.getSox())
                    .dieselVehiclePercentage(parkingLotData.getDieselVehiclePercentage())
                    .build();
        }
    }
}
