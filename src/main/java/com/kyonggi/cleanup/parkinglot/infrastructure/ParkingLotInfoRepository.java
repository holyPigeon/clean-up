package com.kyonggi.cleanup.parkinglot.infrastructure;

import com.kyonggi.cleanup.parkinglot.domain.ParkingLotData;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ParkingLotInfoRepository extends JpaRepository<ParkingLotData, Long> {
}
