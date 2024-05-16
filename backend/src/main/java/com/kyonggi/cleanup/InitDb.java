package com.kyonggi.cleanup;

import com.kyonggi.cleanup.parkinglot.domain.ParkingLotData;
import com.kyonggi.cleanup.parkinglot.infrastructure.ParkingLotInfoRepository;
import jakarta.annotation.PostConstruct;
import java.io.IOException;
import java.io.InputStream;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;

@Component
public class InitDb {
    private final InitDb.InitService initService;

    @PostConstruct
    public void init() {
        this.initService.saveExtractedParkingLotData();
    }

    public InitDb(final InitDb.InitService initService) {
        this.initService = initService;
    }

    @Component
    static class InitService {
        private static final Logger log = LoggerFactory.getLogger(InitDb.InitService.class);
        private final ParkingLotInfoRepository parkingLotInfoRepository;

        public void saveExtractedParkingLotData() {
            try {
                InputStream inputStream = (new ClassPathResource("data/parkinglot_data.xltx")).getInputStream();

                try {
                    XSSFWorkbook workbook = new XSSFWorkbook(inputStream);
                    XSSFSheet sheet = workbook.getSheetAt(0);
                    int rows = sheet.getPhysicalNumberOfRows();
                    this.extractDataFromFile(rows, sheet);
                    workbook.close();
                } catch (Throwable var6) {
                    if (inputStream != null) {
                        try {
                            inputStream.close();
                        } catch (Throwable var5) {
                            var6.addSuppressed(var5);
                        }
                    }

                    throw var6;
                }

                if (inputStream != null) {
                    inputStream.close();
                }

            } catch (IOException var7) {
                throw new RuntimeException(var7);
            }
        }

        private void extractDataFromFile(int rows, XSSFSheet sheet) {
            for(int rowIndex = 1; rowIndex < rows; ++rowIndex) {
                XSSFRow row = sheet.getRow(rowIndex);
                if (row != null) {
                    ParkingLotData parkingLotData = new ParkingLotData();
                    parkingLotData.setMonth((int)row.getCell(0).getNumericCellValue());
                    parkingLotData.setDay((int)row.getCell(1).getNumericCellValue());
                    parkingLotData.setHour((int)row.getCell(2).getNumericCellValue());
                    parkingLotData.setMinute((int)row.getCell(3).getNumericCellValue());
                    parkingLotData.setExternalTemperature(row.getCell(4).getNumericCellValue());
                    parkingLotData.setExternalHumidity(row.getCell(5).getNumericCellValue());
                    parkingLotData.setExternalNox((double)Math.round(row.getCell(6).getNumericCellValue() * 1000.0D) / 1000.0D);
                    parkingLotData.setExternalSox((double)Math.round(row.getCell(7).getNumericCellValue() * 1000.0D) / 1000.0D);
                    parkingLotData.setTemperature(row.getCell(8).getNumericCellValue());
                    parkingLotData.setHumidity(row.getCell(9).getNumericCellValue());
                    parkingLotData.setNox((double)Math.round(row.getCell(10).getNumericCellValue() * 1000.0D) / 1000.0D);
                    parkingLotData.setSox((double)Math.round(row.getCell(11).getNumericCellValue() * 1000.0D) / 1000.0D);
                    parkingLotData.setCarCount((int)row.getCell(12).getNumericCellValue());
                    this.parkingLotInfoRepository.save(parkingLotData);
                }
            }

        }

        public InitService(final ParkingLotInfoRepository parkingLotInfoRepository) {
            this.parkingLotInfoRepository = parkingLotInfoRepository;
        }
    }
}