package com.kyonggi.cleanup.parkinglot.application.dto.response;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class PollutionDataResponse {
    private double nox;
    private double sox;
}
