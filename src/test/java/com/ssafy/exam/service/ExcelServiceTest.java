package com.ssafy.exam.service;

import com.ssafy.exam.model.service.ExcelService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.io.FileInputStream;
import java.io.InputStream;

import static org.junit.jupiter.api.Assertions.assertTrue;

@SpringBootTest
public class ExcelServiceTest {

    @Autowired
    private ExcelService excelService;

    @Test
    public void testSaveExcelDataToDatabase() {
        try {
            InputStream inputStream = new FileInputStream("/Users/kdh/Desktop/IntelliJ_Projects/yumyumcoach_final_be/20250408_음식DB.xlsx");
            int processedCount = excelService.saveExcelDataToDatabase(inputStream);
            System.out.println("Processed " + processedCount + " records.");
            assertTrue(processedCount > 0);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
