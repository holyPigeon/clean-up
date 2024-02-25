package com.kyonggi.cleanup.monitor.presentation;

import com.kyonggi.cleanup.common.domain.response.ResponseHandler;
import com.kyonggi.cleanup.monitor.application.WeatherService;
import com.kyonggi.cleanup.monitor.application.dto.response.airQuality.AirQualityResponse;
import com.kyonggi.cleanup.monitor.application.dto.response.weather.WeatherInfoResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class WeatherController {

    private final WeatherService weatherService;

    @GetMapping("/weather/airQuality/forecast")
    public ResponseEntity<ResponseHandler<AirQualityResponse>> fetchAirQuality() {
        return ResponseEntity
                .ok()
                .body(ResponseHandler.<AirQualityResponse>builder()
                        .message("Success")
                        .statusCode(HttpStatus.OK)
                        .data(weatherService.fetchAirQualityInfo())
                        .build()
                );
    }

    @GetMapping("/weather/info")
    public ResponseEntity<ResponseHandler<WeatherInfoResponse>> fetchWeatherInfo() {
        return ResponseEntity
                .ok()
                .body(ResponseHandler.<WeatherInfoResponse>builder()
                        .message("Success")
                        .statusCode(HttpStatus.OK)
                        .data(weatherService.fetchWeatherInfo())
                        .build()
                );
    }
}
