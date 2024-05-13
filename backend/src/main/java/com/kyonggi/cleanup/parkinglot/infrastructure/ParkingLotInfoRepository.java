package com.kyonggi.cleanup.parkinglot.infrastructure;

import com.kyonggi.cleanup.parkinglot.domain.ParkingLotData;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ParkingLotInfoRepository extends JpaRepository<ParkingLotData, Long> {
    ParkingLotData findByMonthAndDayAndHourAndMinute(int month, int day, int hour, int minute);
}
