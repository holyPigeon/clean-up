package com.kyonggi.cleanup.monitor.application.dto.response.airQuality;

import java.time.LocalDateTime;

public class AirQuality {

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
    private int pm10Value;
    private int pm10Value24h;
    private int pm10Grade1h;
    private int pm10Grade24h;
    private String pm10Flag;
    private int pm25Value;
    private int pm25Value24h;
    private int pm25Grade1h;
    private int pm25Grade24h;
    private String pm25Flag;

    // 이산화질소
    private int no2Value;
    private int no2Grade;
    private String no2Flag;

    // 아황산가스
    private int so2Value;
    private int so2Grade;
    private String so2Flag;

    // 일산화탄소
    private int coValue;
    private int coGrade;
    private String co2Flag;

    // 오존
    private int o3Value;
    private int o3Grade;
    private String o3Flag;
}
