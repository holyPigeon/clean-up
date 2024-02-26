package com.kyonggi.cleanup.parkinglot.application;

import com.kyonggi.cleanup.parkinglot.application.dto.response.ParkingLotDataResponse;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
public class ParkingLotService {

    /*
    주차장 정보 조회
    */
    public ParkingLotDataResponse extractParkingLotData() {

        List<ParkingLotDataResponse.Item> items = new ArrayList<>();

        try (InputStream inputStream = new ClassPathResource("data/parking_lot_data.xlsx").getInputStream()) {
            XSSFWorkbook workbook = new XSSFWorkbook(inputStream);
            XSSFSheet sheet = workbook.getSheetAt(0);
            int rows = sheet.getPhysicalNumberOfRows();

            extractDataFromFile(rows, sheet, items);

            workbook.close();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return ParkingLotDataResponse.of(items);
    }

    private void extractDataFromFile(int rows, XSSFSheet sheet, List<ParkingLotDataResponse.Item> items) {

        for (int rowIndex = 1; rowIndex < rows; rowIndex++) {
            XSSFRow row = sheet.getRow(rowIndex);
            if (row == null) {
                continue; // 행이 null이면 다음 행으로 넘어간다
            }

            items.add(ParkingLotDataResponse.Item.of(
                    LocalDateTime.parse(getValueByCellType(row.getCell(0))),
                    getValueByCellType(row.getCell(1)),
                    getValueByCellType(row.getCell(2)),
                    getValueByCellType(row.getCell(3)),
                    getValueByCellType(row.getCell(4)),
                    getValueByCellType(row.getCell(5)),
                    getValueByCellType(row.getCell(6)),
                    getValueByCellType(row.getCell(7))
            ));
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