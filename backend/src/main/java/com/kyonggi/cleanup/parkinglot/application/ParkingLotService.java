package com.kyonggi.cleanup.parkinglot.application;

import com.kyonggi.cleanup.parkinglot.dto.request.PollutionPredictRequestByCondition;
import com.kyonggi.cleanup.parkinglot.dto.request.PollutionPredictRequestByDateTime;
import com.kyonggi.cleanup.parkinglot.dto.response.NoxPredictionResponseByDateTime;
import com.kyonggi.cleanup.parkinglot.dto.response.ParkingLotInfoResponse;
import com.kyonggi.cleanup.parkinglot.dto.response.NoxPredictionResponseByCondition;
import com.kyonggi.cleanup.parkinglot.domain.ParkingLotData;
import com.kyonggi.cleanup.parkinglot.dto.response.SoxPredictionResponseByCondition;
import com.kyonggi.cleanup.parkinglot.dto.response.SoxPredictionResponseByDateTime;
import com.kyonggi.cleanup.parkinglot.infrastructure.ParkingLotInfoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ParkingLotService {

    private final ParkingLotInfoRepository parkingLotInfoRepository;
    private final PollutionPredictor pollutionPredictor;

    public ParkingLotInfoResponse findParkingLotInfo() {
        return ParkingLotInfoResponse.of(parkingLotInfoRepository.findAll());
    }

    public ParkingLotInfoResponse findParkingLotInfoByDateTime(int month, int day, int hour, int minute) {
        ParkingLotData parkingLotData = parkingLotInfoRepository.findByMonthAndDayAndHourAndMinute(month, day, hour, minute);

        return ParkingLotInfoResponse.of(List.of(parkingLotData));
    }

    public NoxPredictionResponseByDateTime getNoxPrediction24HourByDateTime(PollutionPredictRequestByDateTime request) {

        int month = request.getMonth();
        int day = request.getDay();
        int hour = request.getHour();
        int minute = request.getMinute();

        List<NoxPredictionResponseByDateTime.Result> results = new ArrayList<>();

        for (int i = 0; i < 48; i++) {
            ParkingLotData parkingLotData = parkingLotInfoRepository.findByMonthAndDayAndHourAndMinute(month, day, hour, minute);
            PollutionPredictRequestByCondition predictRequest = PollutionPredictRequestByCondition.of(parkingLotData);
            double actualNox = parkingLotData.getNox();
            double predictedNox = pollutionPredictor.predictNoxAfter30MinuteByDateTime(predictRequest);
            results.add(NoxPredictionResponseByDateTime.Result.of(month, day, hour, minute, actualNox, predictedNox));

            if (minute == 30) {
                if (hour == 23) {
                    hour = -1;
                    day++;
                }
                hour++;
                minute = 0;
            } else {
                minute = 30;
            }
        }

        return NoxPredictionResponseByDateTime.of(results);
    }

    public SoxPredictionResponseByDateTime getSoxPrediction24HourByDateTime(PollutionPredictRequestByDateTime request) {

        int month = request.getMonth();
        int day = request.getDay();
        int hour = request.getHour();
        int minute = request.getMinute();

        List<SoxPredictionResponseByDateTime.Result> results = new ArrayList<>();

        for (int i = 0; i < 48; i++) {
            ParkingLotData parkingLotData = parkingLotInfoRepository.findByMonthAndDayAndHourAndMinute(month, day, hour, minute);
            PollutionPredictRequestByCondition predictRequest = PollutionPredictRequestByCondition.of(parkingLotData);
            double actualSox = parkingLotData.getSox();
            double predictedSox = pollutionPredictor.predictSoxAfter30MinuteByDateTime(predictRequest);
            results.add(SoxPredictionResponseByDateTime.Result.of(month, day, hour, minute, actualSox, predictedSox));

            if (minute == 30) {
                if (hour == 23) {
                    hour = -1;
                    day++;
                }
                hour++;
                minute = 0;
            } else {
                minute = 30;
            }
        }

        return SoxPredictionResponseByDateTime.of(results);
    }

    public NoxPredictionResponseByCondition getNoxPrediction2HourByCondition(PollutionPredictRequestByCondition request) {

        List<NoxPredictionResponseByCondition.Result> results = new ArrayList<>();
        int passedMinute;

        results.add(NoxPredictionResponseByCondition.Result.of(0, request.getActualExternalNox()));

        for (int i = 1; i <= 4; i++) {
            passedMinute = 30 * i;
            double predictedNox = pollutionPredictor.predictNoxByCondition(request, passedMinute);
            results.add(NoxPredictionResponseByCondition.Result.of(passedMinute, predictedNox));
        }

        return NoxPredictionResponseByCondition.of(results);
    }

    public SoxPredictionResponseByCondition getSoxPrediction2HourByCondition(PollutionPredictRequestByCondition request) {

        List<SoxPredictionResponseByCondition.Result> results = new ArrayList<>();
        int passedMinute;

        results.add(SoxPredictionResponseByCondition.Result.of(0, request.getActualExternalSox()));

        for (int i = 1; i <= 4; i++) {
            passedMinute = 30 * i;
            double predictedSox = pollutionPredictor.predictSoxByCondition(request, passedMinute);
            results.add(SoxPredictionResponseByCondition.Result.of(passedMinute, predictedSox));
        }

        return SoxPredictionResponseByCondition.of(results);
    }


}