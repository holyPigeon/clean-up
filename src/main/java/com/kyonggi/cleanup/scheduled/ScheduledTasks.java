package com.kyonggi.cleanup.scheduled;

import com.kyonggi.cleanup.parkinglot.domain.ParkingLotData;
import com.kyonggi.cleanup.parkinglot.infrastructure.ParkingLotInfoRepository;
import lombok.RequiredArgsConstructor;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.core.io.ClassPathResource;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

@Component
@EnableScheduling
@RequiredArgsConstructor
public class ScheduledTasks {

    private final ParkingLotInfoRepository parkingLotInfoRepository;

    /*
    주차장 정보 조회
    */
    @Scheduled(fixedRate = 24, timeUnit = TimeUnit.HOURS)
    public void saveExtractedParkingLotData() {

        try (InputStream inputStream = new ClassPathResource("data/dirt.xlsx").getInputStream()) {
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
            parkingLotData.setTemperature(row.getCell(4).getNumericCellValue());
            parkingLotData.setHumidity(row.getCell(5).getNumericCellValue());
            parkingLotData.setNox(Math.round(row.getCell(6).getNumericCellValue() * 1000) / 1000.0);
            parkingLotData.setSox(row.getCell(7).getNumericCellValue());
            parkingLotData.setCarCount((int) row.getCell(8).getNumericCellValue());

            parkingLotInfoRepository.save(parkingLotData);
        }
    }

    private String getValueByCellType(XSSFCell cell) {
        String value;
        switch (cell.getCellType()) {
            case FORMULA:
                value = cell.getCellFormula();
                break;
            case NUMERIC:
                value = String.valueOf(cell.getNumericCellValue());
                break;
            case STRING:
                value = cell.getStringCellValue();
                break;
            case BLANK:
                value = "";
                break;
            case BOOLEAN:
                value = String.valueOf(cell.getBooleanCellValue());
                break;
            case ERROR:
                value = String.valueOf(cell.getErrorCellValue());
                break;
            default:
                value = "Unknown Cell Type";
                break;
        }
        return value;
    }
}
