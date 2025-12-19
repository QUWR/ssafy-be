package com.ssafy.exam.controller;

import com.ssafy.exam.model.dto.Food;
import com.ssafy.exam.model.dto.FoodSearchRequest;
import com.ssafy.exam.model.service.ExcelService;
import com.ssafy.exam.model.service.FoodDataService;
import com.ssafy.exam.model.service.FoodSearchService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.List;

@RestController
@RequestMapping("/api/food")
public class FoodController {

    private final FoodDataService foodDataService;
    private final FoodSearchService foodSearchService;
    private final ExcelService excelService;

    public FoodController(FoodDataService foodDataService, FoodSearchService foodSearchService, ExcelService excelService) {
        this.foodDataService = foodDataService;
        this.foodSearchService = foodSearchService;
        this.excelService = excelService;
    }

    @GetMapping("/upload")
    public ResponseEntity<String> uploadExcelData() {
        try {
            InputStream inputStream = new FileInputStream("/Users/kdh/Desktop/IntelliJ_Projects/yumyumcoach_final_be/20250408_음식DB.xlsx");
            int processedCount = excelService.saveExcelDataToDatabase(inputStream);
            return ResponseEntity.ok("Successfully processed " + processedCount + " records.");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.internalServerError().body("Error during upload: " + e.getMessage());
        }
    }

    @GetMapping("/search")
    public ResponseEntity<List<Food>> handleSearch(FoodSearchRequest request) {
        if (request.getKeyword() == null || request.getKeyword().trim().isEmpty()) {
            return ResponseEntity.badRequest().build();
        }

        List<Food> results;
        if (request.isAutocomplete()) {
            results = foodSearchService.searchFoodAutoComplete(request.getKeyword(), request.getMax());
        } else {
            results = foodSearchService.searchFoodWithKMP(request.getKeyword());
        }

        return ResponseEntity.ok(results);
    }

    @GetMapping("/list")
    public ResponseEntity<List<Food>> handleList() {
        List<Food> allFoods = foodDataService.getAllFoods();
        return ResponseEntity.ok(allFoods);
    }
}