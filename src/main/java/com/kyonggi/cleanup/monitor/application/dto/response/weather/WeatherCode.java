package com.kyonggi.cleanup.monitor.application.dto.response.weather;

public enum WeatherCode {

    TEMPERATURE("T1H", "기온"),
    HUMIDITY("REH", "습도"),
    PRECIPITATION_FORM("PTY", "강수형태"),
    WIND_DIRECTION("VEC","풍향"),
    WIND_SPEED("WSD","풍속");
//    RN1("1시간 강수량"),
//    UUU("동서바람성분"),
//    VVV("남북바람성분");


    private final String code;
    private final String name;

    WeatherCode(String code, String name) {
        this.code = code;
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public String getName() {
        return name;
    }
}
