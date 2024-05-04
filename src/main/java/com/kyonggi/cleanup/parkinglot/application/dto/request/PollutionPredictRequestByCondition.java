package com.kyonggi.cleanup.parkinglot.application.dto.request;

import lombok.Getter;

@Getter
public class PollutionPredictRequestByCondition {
    private double temperature;
    private double humidity;
    private int carCount;
    double currentNox;
    double currentSox;
}
