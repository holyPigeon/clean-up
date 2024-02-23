package com.kyonggi.cleanup.monitor.application.dto.response.airQuality;

import lombok.Getter;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Getter
public class AirQualityResponse {

    private LocalDateTime dateTime;
    private String sidoName; // 시도 이름 -> ex) 서울 부산 대구 인천 광주 대전 울산 경기 강원
    private String mangName; // 측정망 정보 -> 도시대기, 도로변대기, 국가배경농도, 교외대기, 항만

    /*
    value: 농도
    value24h: 24시간 예측 이동 농도
    grade: 지수 (미세먼지의 경우 24시간 등급 -> pm10/pm25)
    grade1h: 1시간 지수
    flag: 측정 자료의 상태 -> 점검및교정, 장비점검, 자료이상, 통신장애
     */

    // 미세먼지
    private String pm10Value;
    private String pm10Value24h;
    private String pm10Grade1h;
    private String pm10Grade24h;
    private String pm10Flag;
    private String pm25Value;
    private String pm25Value24h;
    private String pm25Grade1h;
    private String pm25Grade24h;
    private String pm25Flag;

    // 이산화질소
    private String no2Value;
    private String no2Grade;
    private String no2Flag;

    // 아황산가스
    private String so2Value;
    private String so2Grade;
    private String so2Flag;

    // 일산화탄소
    private String coValue;
    private String coGrade;
    private String coFlag;

    // 오존
    private String o3Value;
    private String o3Grade;
    private String o3Flag;

    private AirQualityResponse(AirQualityPrimitiveResponse.ResponseBody.ResponseBodyItems.Item response) {

        this.dateTime = LocalDateTime.parse(response.getDataTime(), DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
        this.sidoName = response.getSidoName();
        this.mangName = response.getMangName();
        this.pm10Value = response.getPm10Value();
        this.pm10Value24h = response.getPm10Value24();
        this.pm10Grade1h = response.getPm10Grade1h();
        this.pm10Grade24h = response.getPm10Grade();
        this.pm10Flag = response.getPm10Flag();
        this.pm25Value = response.getPm25Value();
        this.pm25Value24h = response.getPm25Value24();
        this.pm25Grade1h = response.getPm25Grade1h();
        this.pm25Grade24h = response.getPm25Grade();
        this.pm25Flag = response.getPm25Flag();
        this.no2Value = response.getNo2Value();
        this.no2Grade = response.getNo2Grade();
        this.no2Flag = response.getNo2Flag();
        this.so2Value = response.getSo2Value();
        this.so2Grade = response.getSo2Grade();
        this.so2Flag = response.getSo2Flag();
        this.coValue = response.getCoValue();
        this.coGrade = response.getCoGrade();
        this.coFlag = response.getCoFlag();
        this.o3Value = response.getO3Value();
        this.o3Grade = response.getO3Grade();
        this.o3Flag = response.getO3Flag();
    }

    public static AirQualityResponse of(AirQualityPrimitiveResponse.ResponseBody.ResponseBodyItems.Item response) {
        return new AirQualityResponse(response);
    }
}
