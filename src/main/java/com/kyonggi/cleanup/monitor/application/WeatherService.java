package com.kyonggi.cleanup.monitor.application;

import com.kyonggi.cleanup.monitor.application.dto.response.airQuality.AirQualityResponse;
import com.kyonggi.cleanup.monitor.application.dto.response.airQuality.AirQualityPrimitiveResponse;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Objects;

@Service
public class WeatherService {

    /*
    대기오염정보 요청
     */
    public AirQualityResponse fetchAirQualityInfo() {

        String serviceKey = "loLOWGHUcyqyf9PrOQeg7EzPx8ingWLA%2FSe%2FwSX%2FCZ0TUl3205I0q03halYbawbm1Vs61K%2FRVGtzHfiG3NbGrw%3D%3D";

        String apiURL = "https://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getCtprvnRltmMesureDnsty" +
                "?ServiceKey=" + serviceKey +
                "&returnType=" + "json" +
                "&numOfRows=" + 100 +
                "&pageNo=" + 1 +
                "&sidoName=" + "경기" +
                "&ver=" + 1.2;

        // 장소 목록 검색 API 요청
        WebClient client = WebClient.builder()
                .baseUrl(apiURL)
                .defaultHeader(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_JSON_VALUE)
                .build();

        Mono<AirQualityPrimitiveResponse> response = client.get()
                .uri(apiURL)
                .accept(MediaType.APPLICATION_JSON)
                .retrieve()
                .bodyToMono(AirQualityPrimitiveResponse.class);

        List<AirQualityPrimitiveResponse.ResponseBody.ResponseBodyItems.Item> items = Objects.requireNonNull(response.block())
                .getResponse()
                .getBody()
                .getItems();

        return items.stream()
                .filter(item -> item.getStationName().equals("금곡동"))
                .map(AirQualityResponse::of)
                .findFirst()
                .orElseThrow(() -> new NoSuchElementException("해당하는 관측소명이 존재하지 않습니다."));
    }
}
