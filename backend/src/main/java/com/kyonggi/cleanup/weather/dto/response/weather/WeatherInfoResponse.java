package com.kyonggi.cleanup.weather.dto.response.weather;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class WeatherInfoResponse {

    private String temperature;
    private String humidity;

    public static WeatherInfoResponse of(String temperature, String humidity) {
        return WeatherInfoResponse.builder()
                .temperature(temperature)
                .humidity(humidity)
                .build();
    }
}