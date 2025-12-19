package com.ssafy.exam.model.service;

import com.ssafy.exam.model.dto.Food;
import org.springframework.stereotype.Service;
import java.util.ArrayList;
import java.util.List;

@Service
public class FoodSearchService {

    private final FoodDataService foodDataService;

    public FoodSearchService(FoodDataService foodDataService) {
        this.foodDataService = foodDataService;
    }

    private int[] computeKMPTable(String pattern) {
        int m = pattern.length();
        int[] lps = new int[m];
        int len = 0;
        int i = 1;

        while (i < m) {
            if (pattern.charAt(i) == pattern.charAt(len)) {
                len++;
                lps[i] = len;
                i++;
            } else {
                if (len != 0) {
                    len = lps[len - 1];
                } else {
                    lps[i] = 0;
                    i++;
                }
            }
        }
        return lps;
    }

    private boolean kmpSearch(String text, String pattern) {
        if (pattern.isEmpty()) return true;

        text = text.toLowerCase();
        pattern = pattern.toLowerCase();

        int n = text.length();
        int m = pattern.length();

        if (m > n) return false;

        int[] lps = computeKMPTable(pattern);

        int i = 0;
        int j = 0;

        while (i < n) {
            if (text.charAt(i) == pattern.charAt(j)) {
                i++;
                j++;
            }

            if (j == m) {
                return true;
            } else if (i < n && text.charAt(i) != pattern.charAt(j)) {
                if (j != 0) {
                    j = lps[j - 1];
                } else {
                    i++;
                }
            }
        }
        return false;
    }

    public List<Food> searchFoodWithKMP(String keyword) {
        List<Food> results = new ArrayList<>();

        if (keyword == null || keyword.trim().isEmpty()) {
            return results;
        }

        List<Food> allFoods = foodDataService.getAllFoods();

        for (Food food : allFoods) {
            if (kmpSearch(food.getName(), keyword)) {
                results.add(food);
            }
        }

        return results;
    }

    public List<Food> searchFoodAutoComplete(String prefix, int maxResults) {
        List<Food> results = new ArrayList<>();

        if (prefix == null || prefix.trim().isEmpty()) {
            return results;
        }

        String lowerPrefix = prefix.toLowerCase();
        List<Food> allFoods = foodDataService.getAllFoods();

        for (Food food : allFoods) {
            if (results.size() >= maxResults) {
                break;
            }

            String lowerName = food.getName().toLowerCase();
            if (lowerName.startsWith(lowerPrefix) || kmpSearch(lowerName, lowerPrefix)) {
                results.add(food);
            }
        }

        return results;
    }

    public List<Food> searchFoods(List<Food> foods, String keyword) {
        List<Food> results = new ArrayList<>();

        if (keyword == null || keyword.trim().isEmpty()) {
            return foods;
        }

        for (Food food : foods) {
            if (kmpSearch(food.getName(), keyword)) {
                results.add(food);
            }
        }

        return results;
    }
}