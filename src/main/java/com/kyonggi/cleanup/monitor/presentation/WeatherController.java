package com.kyonggi.cleanup.monitor.presentation;

import com.kyonggi.cleanup.common.domain.response.ResponseHandler;
import com.kyonggi.cleanup.monitor.application.WeatherService;
import com.kyonggi.cleanup.monitor.application.dto.response.airQuality.AirQualityResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class WeatherController {

    private final WeatherService weatherService;

    @GetMapping(value = "/weather/airQuality/forecast", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<ResponseHandler<AirQualityResponse>> fetchAirQuality() {

        AirQualityResponse airQualityResponse = weatherService.fetchAirQualityInfo();

        return ResponseEntity
                .ok()
                .body(ResponseHandler.<AirQualityResponse>builder()
                        .message("Success")
                        .statusCode(HttpStatus.OK)
                        .data(airQualityResponse)
                        .build()
                );
    }
}
