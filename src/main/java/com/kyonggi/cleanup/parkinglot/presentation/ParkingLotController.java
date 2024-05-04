package com.kyonggi.cleanup.parkinglot.presentation;

import com.kyonggi.cleanup.common.domain.response.ResponseHandler;
import com.kyonggi.cleanup.parkinglot.application.ParkingLotService;
import com.kyonggi.cleanup.parkinglot.application.dto.request.ParkingLotInfoRequestByAmPm;
import com.kyonggi.cleanup.parkinglot.application.dto.request.PollutionPredictRequestByCondition;
import com.kyonggi.cleanup.parkinglot.application.dto.request.PollutionPredictRequestByDateTime;
import com.kyonggi.cleanup.parkinglot.application.dto.response.ParkingLotInfoResponse;
import com.kyonggi.cleanup.parkinglot.application.dto.response.PollutionDataResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@Controller
@RequiredArgsConstructor
public class ParkingLotController {

    private final ParkingLotService parkingLotService;

    @GetMapping("/parkinglot/info")
    public ResponseEntity<ResponseHandler<ParkingLotInfoResponse>> fetchParkingLotInfo() {
        return ResponseEntity
                .ok()
                .body(ResponseHandler.<ParkingLotInfoResponse>builder()
                        .message("Success")
                        .statusCode(HttpStatus.OK)
                        .data(parkingLotService.findParkingLotInfo())
                        .build()
                );
    }

    @PostMapping("/parkinglot/info")
    public ResponseEntity<ResponseHandler<ParkingLotInfoResponse>> fetchParkingLotInfoByAmPm(@RequestBody ParkingLotInfoRequestByAmPm request) {
        System.out.println("as;ldhsaljdhlsajkdhlsak -> " + request.isPm());
        return ResponseEntity
                .ok()
                .body(ResponseHandler.<ParkingLotInfoResponse>builder()
                        .message("Success")
                        .statusCode(HttpStatus.OK)
                        .data(parkingLotService.findParkingLotInfoByAmPm(request.isPm()))
                        .build()
                );
    }

    @PostMapping("/parkinglot/predictByDateTime")
    public ResponseEntity<ResponseHandler<PollutionDataResponse>> predictPollutionDataByDateTime(@RequestBody PollutionPredictRequestByDateTime request) {
        return ResponseEntity
                .ok()
                .body(ResponseHandler.<PollutionDataResponse>builder()
                        .message("Success")
                        .statusCode(HttpStatus.OK)
                        .data(parkingLotService.predictPollutionDataByDateTime(
                                request.getMonth(),
                                request.getDay(),
                                request.getHour(),
                                request.getMinute()
                        ))
                        .build()
                );
    }

    @PostMapping("/parkinglot/predictByCondition")
    public ResponseEntity<ResponseHandler<PollutionDataResponse>> predictPollutionDataByCondition(@RequestBody PollutionPredictRequestByCondition request) {
        return ResponseEntity
                .ok()
                .body(ResponseHandler.<PollutionDataResponse>builder()
                        .message("Success")
                        .statusCode(HttpStatus.OK)
                        .data(parkingLotService.predictPollutionDataByCondition(
                                request.getCarCount(),
                                request.getTemperature(),
                                request.getHumidity(),
                                request.getCurrentNox(),
                                request.getCurrentSox()
                        ))
                        .build()
                );
    }
}
