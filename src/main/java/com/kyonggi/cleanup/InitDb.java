package com.kyonggi.cleanup;

import com.kyonggi.cleanup.parkinglot.domain.ParkingLotData;
import com.kyonggi.cleanup.parkinglot.infrastructure.ParkingLotInfoRepository;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.io.InputStream;

@Component
@RequiredArgsConstructor
public class InitDb {

    private final InitService initService;

    /**
     * 애플리케이션 실행 전에 미리 init() 실행
     */
    @PostConstruct
    public void init() {
        initService.saveExtractedParkingLotData();
    }

    @Component
    @RequiredArgsConstructor
    @Slf4j
    static class InitService {

        private final ParkingLotInfoRepository parkingLotInfoRepository;

        public void saveExtractedParkingLotData() {

            try (InputStream inputStream = new ClassPathResource("data/parkinglot_data.xltx").getInputStream()) {
                XSSFWorkbook workbook = new XSSFWorkbook(inputStream);
                XSSFSheet sheet = workbook.getSheetAt(0);
                int rows = sheet.getPhysicalNumberOfRows();

                extractDataFromFile(rows, sheet);

                workbook.close();
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        }

        private void extractDataFromFile(int rows, XSSFSheet sheet) {

            for (int rowIndex = 1; rowIndex < rows; rowIndex++) {
                XSSFRow row = sheet.getRow(rowIndex);
                if (row == null) {
                    continue; // 행이 null이면 다음 행으로 넘어간다.
                }

                ParkingLotData parkingLotData = new ParkingLotData();

                parkingLotData.setMonth((int) row.getCell(0).getNumericCellValue());
                parkingLotData.setDay((int) row.getCell(1).getNumericCellValue());
                parkingLotData.setHour((int) row.getCell(2).getNumericCellValue());
                parkingLotData.setMinute((int) row.getCell(3).getNumericCellValue());
                parkingLotData.setExternalTemperature(row.getCell(4).getNumericCellValue());
                parkingLotData.setExternalHumidity(row.getCell(5).getNumericCellValue());
                parkingLotData.setExternalNox(Math.round(row.getCell(6).getNumericCellValue() * 1000) / 1000.0);
                parkingLotData.setExternalSox(Math.round(row.getCell(7).getNumericCellValue() * 1000) / 1000.0);
                parkingLotData.setTemperature(row.getCell(8).getNumericCellValue());
                parkingLotData.setHumidity(row.getCell(9).getNumericCellValue());
                parkingLotData.setNox(Math.round(row.getCell(10).getNumericCellValue() * 1000) / 1000.0);
                parkingLotData.setSox(Math.round(row.getCell(11).getNumericCellValue() * 1000) / 1000.0);
                parkingLotData.setCarCount((int) row.getCell(12).getNumericCellValue());

                parkingLotInfoRepository.save(parkingLotData);
            }
        }
    }
}
