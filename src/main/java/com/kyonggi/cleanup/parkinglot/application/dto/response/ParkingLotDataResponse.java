package com.kyonggi.cleanup.parkinglot.application.dto.response;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@NoArgsConstructor
public class ParkingLotDataResponse {

    private List<Item> items;

    private ParkingLotDataResponse(List<Item> items) {
        this.items = items;
    }

    public static ParkingLotDataResponse of(List<Item> items) {
        return new ParkingLotDataResponse(items);
    }

    @Getter
    @NoArgsConstructor
    public static class Item {

        @JsonFormat(pattern = "yyyy.MM.dd HH:mm:ss")
        private LocalDateTime dateTime;
        private String carCount;
        private String temperature;
        private String humidity;
        private String pm10;
        private String pm25;
        private String so2;
        private String no2;

        private Item(
                LocalDateTime dateTime,
                String carCount,
                String temperature,
                String humidity,
                String pm10,
                String pm25,
                String so2,
                String no2
        ) {
            this.dateTime = dateTime;
            this.carCount = carCount;
            this.temperature = temperature;
            this.humidity = humidity;
            this.pm10 = pm10;
            this.pm25 = pm25;
            this.so2 = so2;
            this.no2 = no2;
        }

        public static Item of(
                LocalDateTime dateTime,
                String carCount,
                String temperature,
                String humidity,
                String pm10,
                String pm25,
                String so2,
                String no2
        ) {
            return new Item(dateTime, carCount, temperature, humidity, pm10, pm25, so2, no2);
        }
    }
}
