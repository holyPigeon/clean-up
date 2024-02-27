package com.kyonggi.cleanup.parkinglot.application.dto.response;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Builder;
import lombok.Getter;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@Builder
public class ParkingLotDataResponse {

    private List<Item> items;

    public static ParkingLotDataResponse of(List<Item> items) {
        return ParkingLotDataResponse.builder()
                .items(items)
                .build();
    }

    @Getter
    @Builder
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

        public static Item of(String[] cellValues) {
            return Item.builder()
                    .dateTime(LocalDateTime.parse(cellValues[0]))
                    .carCount(cellValues[1])
                    .temperature(cellValues[2])
                    .humidity(cellValues[3])
                    .pm10(cellValues[4])
                    .pm25(cellValues[5])
                    .so2(cellValues[6])
                    .no2(cellValues[7])
                    .build();
        }
    }
}
