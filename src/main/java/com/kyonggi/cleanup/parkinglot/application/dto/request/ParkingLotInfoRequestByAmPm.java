package com.kyonggi.cleanup.parkinglot.application.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class ParkingLotInfoRequestByAmPm {
    @JsonProperty("isPm")
    private boolean isPm;
}
