package com.kyonggi.cleanup.monitor.application.dto.response.airQuality;

import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@NoArgsConstructor
public class AirQualityPrimitiveResponse {

    private ResponseBody response;

    @Getter
    @NoArgsConstructor
    public static class ResponseBody {

        private ResponseBodyItems body;

        @Getter
        @NoArgsConstructor
        public static class ResponseBodyItems {

            private int totalCount;
            private List<Item> items;

            @Getter
            @NoArgsConstructor
            public static class Item {

                // 미세먼지
                private String pm10Flag;
                private String pm10Value;
                private String pm10Value24;
                private String pm10Grade;
                private String pm10Grade1h;

                private String pm25Flag;
                private String pm25Value;
                private String pm25Value24;
                private String pm25Grade;
                private String pm25Grade1h;

                // 기타
                private String so2Flag;
                private String so2Value;
                private String so2Grade;

                private String o3Flag;
                private String o3Value;
                private String o3Grade;

                private String khaiValue;
                private String khaiGrade;

                private String no2Flag;
                private String no2Value;
                private String no2Grade;

                private String coFlag;
                private String coValue;
                private String coGrade;

                private String stationName;
                private String stationCode;

                private String mangName;
                private String sidoName;
                private String dataTime;
            }
        }
    }
}
