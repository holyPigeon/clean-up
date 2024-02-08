package com.kyonggi.cleanup.monitor.application.dto.response.airQuality;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class AirQualityPrimitiveResponse {

    private List<Item> itemList;

    @Getter
    @NoArgsConstructor
    @AllArgsConstructor
    public static class Item {

        // 미세먼지
        private Integer pm10Value;
        private Integer pm10Value24;
        private Integer pm10Grade;
        private Integer pm10Grade1h;

        private Integer pm25Value;
        private Integer pm25Value24;
        private Integer pm25Grade;
        private Integer pm25Grade1h;

        // 기타
        private Double so2Value;
        private Integer so2Grade;

        private Double o3Value;
        private Integer o3Grade;

        private Integer khaiValue;
        private Integer khaiGrade;

        private Double no2Value;
        private Integer no2Grade;

        private Double coValue;
        private Integer coGrade;

        private String stationName;
        private String stationCode;

        private String mangName;
        private String sidoName;
        private String dataTime;
    }
}
