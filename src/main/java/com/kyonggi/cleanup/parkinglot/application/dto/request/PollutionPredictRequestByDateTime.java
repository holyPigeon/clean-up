package com.kyonggi.cleanup.parkinglot.application.dto.request;

import lombok.Getter;

@Getter
public class PollutionPredictRequestByDateTime {
    private int month;
    private int day;
    private int hour;
    private int minute;
}
