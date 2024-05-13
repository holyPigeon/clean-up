package com.kyonggi.cleanup.parkinglot.domain;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name = "parking_lot_info")
public class ParkingLotData {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private int month;

    private int day;

    private int hour;

    private int minute;

    private double externalTemperature;

    private double externalHumidity;

    private double externalNox;

    private double externalSox;

    private double temperature;

    private double humidity;

    private double nox;

    private double sox;

    private int carCount;
}
