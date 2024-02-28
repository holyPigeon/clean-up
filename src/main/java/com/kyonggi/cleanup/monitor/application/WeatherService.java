package com.kyonggi.cleanup.monitor.application;

import com.kyonggi.cleanup.monitor.application.dto.response.airQuality.AirQualityPrimitiveResponse;
import com.kyonggi.cleanup.monitor.application.dto.response.airQuality.AirQualityResponse;
import com.kyonggi.cleanup.monitor.application.dto.response.weather.WeatherCode;
import com.kyonggi.cleanup.monitor.application.dto.response.weather.WeatherInfoPrimitiveResponse;
import com.kyonggi.cleanup.monitor.application.dto.response.weather.WeatherInfoResponse;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.NoSuchElementException;

@Service
public class WeatherService {

    /*
    대기오염정보 요청
     */
    public AirQualityResponse fetchAirQualityInfo() {

        String serviceKey = "loLOWGHUcyqyf9PrOQeg7EzPx8ingWLA/Se/wSX/CZ0TUl3205I0q03halYbawbm1Vs61K/RVGtzHfiG3NbGrw==";

        String apiURL = "https://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty" +
                "?ServiceKey=" + serviceKey +
                "&returnType=" + "json" +
                "&numOfRows=" + 100 +
                "&pageNo=" + 1 +
                "&sidoName=" + "경기" +
                "&ver=" + 1.4;

        String stationName1 = "상대원동";
        String stationName2 = "금곡동";

        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<String> entity = new HttpEntity<>(headers);

        ResponseEntity<AirQualityPrimitiveResponse> response = restTemplate.exchange(apiURL, HttpMethod.GET, entity, AirQualityPrimitiveResponse.class);
        List<AirQualityPrimitiveResponse.ResponseBody.ResponseBodyItems.Item> items = response.getBody()
                .getResponse()
                .getBody()
                .getItems();

        return items.stream()
                .filter(item -> item.getStationName().equals(stationName1))
                .map(AirQualityResponse::of)
                .findFirst()
                .orElseGet(() -> items.stream()
                        .filter(item -> item.getStationName().equals(stationName2))
                        .map(AirQualityResponse::of)
                        .findFirst()
                        .orElseThrow(() -> new NoSuchElementException("해당하는 관측소명이 존재하지 않습니다."))
                );

    }

    /*
    단기기상예보 요청
     */
    public WeatherInfoResponse fetchWeatherInfo() {

        String serviceKey = "loLOWGHUcyqyf9PrOQeg7EzPx8ingWLA/Se/wSX/CZ0TUl3205I0q03halYbawbm1Vs61K/RVGtzHfiG3NbGrw==";

        LocalDateTime currentDateTime = LocalDateTime.now().minusHours(1).withMinute(0);

        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("yyyyMMdd");
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HHmm");

        // 포맷에 맞게 날짜와 시간을 문자열로 변환
        String formattedDate = currentDateTime.format(dateFormatter);
        String formattedTime = currentDateTime.format(timeFormatter);

        String apiURL = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtNcst" +
                "?ServiceKey=" + serviceKey +
                "&pageNo=" + 1 +
                "&numOfRows=" + 100 +
                "&dataType=" + "JSON" +
                "&base_date=" + formattedDate +
                "&base_time=" + formattedTime +
                "&nx=" + "63" + // 성남시 중원구 상대원동 좌표
                "&ny=" + "24";

        RestTemplate restTemplate = new RestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<String> entity = new HttpEntity<>(headers);

        ResponseEntity<WeatherInfoPrimitiveResponse> response = restTemplate.exchange(apiURL, HttpMethod.GET, entity, WeatherInfoPrimitiveResponse.class);
        List<WeatherInfoPrimitiveResponse.Item> items = response.getBody()
                .getResponse()
                .getBody()
                .getItems()
                .getItem();

        String temperature = "unknown";
        String humidity = "unknown";

        for (WeatherInfoPrimitiveResponse.Item item : items) {
            if (item.getCategory().equals(WeatherCode.TEMPERATURE.getCode())) {
                temperature = item.getObsrValue();
            }
            if (item.getCategory().equals(WeatherCode.HUMIDITY.getCode())) {
                humidity = item.getObsrValue();
            }
        }

        return WeatherInfoResponse.of(temperature, humidity);
    }
}
