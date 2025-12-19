package com.ssafy.exam.model.service;

import com.ssafy.exam.model.dao.FoodDao;
import com.ssafy.exam.model.dto.Food;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ExcelService {

    private final FoodDao foodDao;

    public ExcelService(FoodDao foodDao) {
        this.foodDao = foodDao;
    }

    public int saveExcelDataToDatabase(InputStream inputStream) throws Exception {
        List<Map<String, String>> excelData = parseExcel(inputStream);
        int processedCount = 0;

        for (Map<String, String> rowData : excelData) {
            Food food = new Food();
            food.setCode(rowData.get("식품코드"));
            food.setName(rowData.get("식품명"));
            food.setCategory(rowData.get("분류"));
            food.setServingSize(rowData.get("1회제공량"));
            food.setCalories(parseDouble(rowData.get("에너지(kcal)")));
            food.setCarbohydrate(parseDouble(rowData.get("탄수화물(g)")));
            food.setProtein(parseDouble(rowData.get("단백질(g)")));
            food.setFat(parseDouble(rowData.get("지방(g)")));
            food.setSugar(parseDouble(rowData.get("당류(g)")));
            food.setSodium(parseDouble(rowData.get("나트륨(mg)")));
            food.setCholesterol(parseDouble(rowData.get("콜레스테롤(mg)")));
            food.setSaturatedFat(parseDouble(rowData.get("포화지방(g)")));
            food.setTransFat(parseDouble(rowData.get("트랜스지방(g)")));

            System.out.println("Processing food: " + food);

            if (food.getCode() == null || food.getCode().trim().isEmpty()) {
                continue; // Skip row if code is empty
            }

            if (foodDao.selectByCode(food.getCode()) != null) {
                foodDao.update(food);
            } else {
                foodDao.insert(food);
            }
            processedCount++;
        }
        return processedCount;
    }

    private List<Map<String, String>> parseExcel(InputStream inputStream) throws Exception {
        List<Map<String, String>> data = new ArrayList<>();

        try (Workbook workbook = new XSSFWorkbook(inputStream)) {
            Sheet sheet = workbook.getSheetAt(0);

            Row headerRow = sheet.getRow(0);
            if (headerRow == null) {
                return data;
            }

            List<String> headers = new ArrayList<>();
            for (Cell cell : headerRow) {
                headers.add(getCellValue(cell).toLowerCase().replace(" ", "_"));
            }
            if (!headers.isEmpty() && headers.get(0).startsWith("\uFEFF")) {
                headers.set(0, headers.get(0).substring(1));
            }
            System.out.println("Parsed headers: " + headers);

            for (int i = 1; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                if (row == null) continue;

                Map<String, String> rowData = new HashMap<>();
                for (int j = 0; j < headers.size(); j++) {
                    Cell cell = row.getCell(j);
                                    String value = cell != null ? getCellValue(cell) : "";
                                    rowData.put(headers.get(j), value);
                                }
                                System.out.println("Row data: " + rowData);
                                data.add(rowData);            }
        }

        return data;
    }

    private String getCellValue(Cell cell) {
        if (cell == null) return "";

        System.out.println("Cell Type: " + cell.getCellType());
        switch (cell.getCellType()) {
            case STRING:
                System.out.println("Cell Value: " + cell.getStringCellValue());
                return cell.getStringCellValue();
            case NUMERIC:
                if (DateUtil.isCellDateFormatted(cell)) {
                    System.out.println("Cell Value: " + cell.getDateCellValue());
                    return cell.getDateCellValue().toString();
                }
                double numericValue = cell.getNumericCellValue();
                if (numericValue == (long) numericValue) {
                    System.out.println("Cell Value: " + (long) numericValue);
                    return String.format("%d", (long) numericValue);
                } else {
                    System.out.println("Cell Value: " + numericValue);
                    return String.valueOf(numericValue);
                }
            case BOOLEAN:
                System.out.println("Cell Value: " + cell.getBooleanCellValue());
                return String.valueOf(cell.getBooleanCellValue());
            case FORMULA:
                try {
                    System.out.println("Cell Value: " + cell.getNumericCellValue());
                    return String.valueOf(cell.getNumericCellValue());
                } catch (IllegalStateException e) {
                    System.out.println("Cell Value: " + cell.getStringCellValue());
                    return cell.getStringCellValue();
                }
            default:
                return "";
        }
    }

    private double parseDouble(String value) {
        if (value == null || value.trim().isEmpty()) {
            return 0.0;
        }
        try {
            return Double.parseDouble(value);
        } catch (NumberFormatException e) {
            return 0.0;
        }
    }
}