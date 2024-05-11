package com.kyonggi.cleanup.parkinglot.dto.request;

import com.kyonggi.cleanup.parkinglot.domain.ParkingLotData;
import lombok.Getter;

@Getter
public class PollutionPredictRequestByCondition {
    private int hour;
    private int minute;
    private double externalTemperature;
    private double externalHumidity;
    private double actualExternalNox;
    private double actualExternalSox;
    private double actualNox;
    private double actualSox;
    private double temperature;
    private double humidity;
    private int carCount;

    public static PollutionPredictRequestByCondition of(ParkingLotData parkingLotData) {
        PollutionPredictRequestByCondition request = new PollutionPredictRequestByCondition();

        request.hour = parkingLotData.getHour();
        request.minute = parkingLotData.getMinute();
        request.externalTemperature = parkingLotData.getExternalTemperature();
        request.externalHumidity = parkingLotData.getExternalHumidity();
        request.actualExternalNox = parkingLotData.getExternalNox();
        request.actualExternalSox = parkingLotData.getExternalSox();
        request.actualNox = parkingLotData.getNox();
        request.actualSox = parkingLotData.getSox();
        request.temperature = parkingLotData.getTemperature();
        request.humidity = parkingLotData.getHumidity();
        request.carCount = parkingLotData.getCarCount();

        return request;
    }
}
