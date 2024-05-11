package com.kyonggi.cleanup.parkinglot.dto.request;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class ParkingLotInfoRequestByDateTime {
    private int month;
    private int day;
    private int hour;
    private int minute;
}
