package com.ssafy.exam.controller;

import com.ssafy.exam.model.dto.Food;
import com.ssafy.exam.model.dto.FoodSearchRequest;
import com.ssafy.exam.model.dto.RecommendFoodResponse;
import com.ssafy.exam.model.service.ExcelService;
import com.ssafy.exam.model.service.FoodDataService;
import com.ssafy.exam.model.service.FoodSearchService;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.io.InputStream;
import java.util.List;

@RestController
@RequestMapping("/api/food")
public class FoodController {

    private final FoodDataService foodDataService;
    private final FoodSearchService foodSearchService;
    private final ExcelService excelService;
    private final ResourceLoader resourceLoader;

    public FoodController(FoodDataService foodDataService, FoodSearchService foodSearchService, ExcelService excelService, ResourceLoader resourceLoader) {
        this.foodDataService = foodDataService;
        this.foodSearchService = foodSearchService;
        this.excelService = excelService;
        this.resourceLoader = resourceLoader;
    }

    @GetMapping("/upload")
    public ResponseEntity<String> uploadExcelData() {
        try {
            InputStream inputStream = resourceLoader.getResource("classpath:20250408_음식DB.xlsx").getInputStream();
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

    @GetMapping("/recommend")
    public ResponseEntity<RecommendFoodResponse> getRecommend() {
        RecommendFoodResponse response = foodSearchService.getRecommend();
        return ResponseEntity.ok(response);
    }
}