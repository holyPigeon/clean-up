package com.kyonggi.cleanup.parkinglot.application;

import com.kyonggi.cleanup.parkinglot.application.dto.response.ParkingLotInfoResponse;
import com.kyonggi.cleanup.parkinglot.application.dto.response.PollutionDataResponse;
import com.kyonggi.cleanup.parkinglot.domain.ParkingLotData;
import com.kyonggi.cleanup.parkinglot.infrastructure.ParkingLotInfoRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ParkingLotService {

    private final ParkingLotInfoRepository parkingLotInfoRepository;

    public ParkingLotInfoResponse findParkingLotInfo() {
        return ParkingLotInfoResponse.of(parkingLotInfoRepository.findAll());
    }

    public ParkingLotInfoResponse findParkingLotInfoByAmPm(boolean isPm) {
        List<ParkingLotData> parkingLotInfo = parkingLotInfoRepository.findAll();
        if (isPm) {
            return ParkingLotInfoResponse.of(
                    parkingLotInfo
                            .stream()
                            .filter(parkingLotData -> parkingLotData.getHour() >= 12 && parkingLotData.getHour() <= 23)
                            .toList()
            );
        } else {
            return ParkingLotInfoResponse.of(
                    parkingLotInfo
                            .stream()
                            .filter(parkingLotData -> parkingLotData.getHour() >= 0 && parkingLotData.getHour() <= 11)
                            .toList()
            );
        }
    }

    public PollutionDataResponse predictPollutionDataByDateTime(
            int month,
            int day,
            int hour,
            int minute
    ) {

        // ...
        // algorithm
        // ...

        double predictionNox = 1.0;
        double predictionSox = 2.0;

        return PollutionDataResponse.builder()
                .nox(predictionNox)
                .sox(predictionSox)
                .build();
    }

    public PollutionDataResponse predictPollutionDataByCondition(
            int carCount,
            double temperature,
            double humidity,
            double currentNox,
            double currentSox
    ) {

        // ...
        // algorithm
        // ...

        double predictionNox = 3.0;
        double predictionSox = 4.0;

        return PollutionDataResponse.builder()
                .nox(predictionNox)
                .sox(predictionSox)
                .build();
    }
}