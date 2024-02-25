package com.kyonggi.cleanup.monitor.application.dto.response.weather;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class WeatherInfoResponse {

    private String temperature;
    private String humidity;

    private WeatherInfoResponse(String temperature, String humidity) {
        this.temperature = temperature;
        this.humidity = humidity;
    }

    public static WeatherInfoResponse of(String temperature, String humidity) {
        return new WeatherInfoResponse(temperature, humidity);
    }
}
