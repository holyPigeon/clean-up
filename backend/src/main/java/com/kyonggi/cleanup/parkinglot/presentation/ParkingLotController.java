package com.kyonggi.cleanup.parkinglot.presentation;

import com.kyonggi.cleanup.common.domain.response.ResponseHandler;
import com.kyonggi.cleanup.parkinglot.application.ParkingLotService;
import com.kyonggi.cleanup.parkinglot.dto.request.ParkingLotInfoRequestByDateTime;
import com.kyonggi.cleanup.parkinglot.dto.request.PollutionPredictRequestByCondition;
import com.kyonggi.cleanup.parkinglot.dto.request.PollutionPredictRequestByDateTime;
import com.kyonggi.cleanup.parkinglot.dto.response.NoxPredictionResponseByDateTime;
import com.kyonggi.cleanup.parkinglot.dto.response.ParkingLotInfoResponse;
import com.kyonggi.cleanup.parkinglot.dto.response.NoxPredictionResponseByCondition;
import com.kyonggi.cleanup.parkinglot.dto.response.SoxPredictionResponseByCondition;
import com.kyonggi.cleanup.parkinglot.dto.response.SoxPredictionResponseByDateTime;
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
    public ResponseEntity<ResponseHandler<ParkingLotInfoResponse>> fetchParkingLotInfo(@RequestBody ParkingLotInfoRequestByDateTime request) {
        return ResponseEntity
                .ok()
                .body(ResponseHandler.<ParkingLotInfoResponse>builder()
                        .message("Success")
                        .statusCode(HttpStatus.OK)
                        .data(parkingLotService.findParkingLotInfoByDateTime(request.getMonth(), request.getDay(), request.getHour(), request.getMinute()))
                        .build()
                );
    }

    /**
     * 특정 시간 입력 후 24시간 동안의 실제/예측 데이터 조회
     */
    @PostMapping("/parkinglot/predictByDateTime/nox")
    public ResponseEntity<ResponseHandler<NoxPredictionResponseByDateTime>> getNoxPrediction24HourByDateTime(@RequestBody PollutionPredictRequestByDateTime request) {
        return ResponseEntity
                .ok()
                .body(ResponseHandler.<NoxPredictionResponseByDateTime>builder()
                        .message("Success")
                        .statusCode(HttpStatus.OK)
                        .data(parkingLotService.getNoxPrediction24HourByDateTime(request))
                        .build()
                );
    }

    @PostMapping("/parkinglot/predictByDateTime/sox")
    public ResponseEntity<ResponseHandler<SoxPredictionResponseByDateTime>> getSoxPrediction24HourByDateTime(@RequestBody PollutionPredictRequestByDateTime request) {
        return ResponseEntity
                .ok()
                .body(ResponseHandler.<SoxPredictionResponseByDateTime>builder()
                        .message("Success")
                        .statusCode(HttpStatus.OK)
                        .data(parkingLotService.getSoxPrediction24HourByDateTime(request))
                        .build()
                );
    }

    /**
     * 특정 주차장 조건 입력 후 2시간 동안의 실제/예측 데이터 조회
     */
    @PostMapping("/parkinglot/predictByCondition/nox")
    public ResponseEntity<ResponseHandler<NoxPredictionResponseByCondition>> getNoxPrediction2HourByCondition(@RequestBody PollutionPredictRequestByCondition request) {
        return ResponseEntity
                .ok()
                .body(ResponseHandler.<NoxPredictionResponseByCondition>builder()
                        .message("Success")
                        .statusCode(HttpStatus.OK)
                        .data(parkingLotService.getNoxPrediction2HourByCondition(request))
                        .build()
                );
    }

    @PostMapping("/parkinglot/predictByCondition/sox")
    public ResponseEntity<ResponseHandler<SoxPredictionResponseByCondition>> getSoxPrediction2HourByCondition(@RequestBody PollutionPredictRequestByCondition request) {
        return ResponseEntity
                .ok()
                .body(ResponseHandler.<SoxPredictionResponseByCondition>builder()
                        .message("Success")
                        .statusCode(HttpStatus.OK)
                        .data(parkingLotService.getSoxPrediction2HourByCondition(request))
                        .build()
                );
    }
}
