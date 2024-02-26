package com.kyonggi.cleanup.parkinglot.presentation;

import com.kyonggi.cleanup.common.domain.response.ResponseHandler;
import com.kyonggi.cleanup.parkinglot.application.ParkingLotService;
import com.kyonggi.cleanup.parkinglot.application.dto.response.ParkingLotDataResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class ParkingLotController {

    private final ParkingLotService parkingLotService;

    @GetMapping("/parkinglot/data")
    public ResponseEntity<ResponseHandler<ParkingLotDataResponse>> fetchParkingLotData() {
        return ResponseEntity
                .ok()
                .body(ResponseHandler.<ParkingLotDataResponse>builder()
                        .message("Success")
                        .statusCode(HttpStatus.OK)
                        .data(parkingLotService.extractParkingLotData())
                        .build()
                );
    }
}
