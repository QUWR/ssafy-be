package com.ssafy.exam.model.service;

import com.ssafy.exam.model.dao.DietDao;
import com.ssafy.exam.model.dao.DietFoodDao;
import com.ssafy.exam.model.dto.Diet;
import com.ssafy.exam.model.dto.DietFood;
import com.ssafy.exam.model.dto.Food;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class DietService {

    private final DietDao dietDao;
    private final DietFoodDao dietFoodDao;
    private final FoodDataService foodDataService;

    public DietService(DietDao dietDao, DietFoodDao dietFoodDao, FoodDataService foodDataService) {
        this.dietDao = dietDao;
        this.dietFoodDao = dietFoodDao;
        this.foodDataService = foodDataService;
    }

    @Transactional
    public Diet createDiet(Diet diet) {
        dietDao.insert(diet);
        int dietId = diet.getDietId();

        for (DietFood dietFood : diet.getDietFoods()) {
            dietFood.setDietId(dietId);
            dietFoodDao.insert(dietFood);
        }
        return getDietById(dietId);
    }

    public Diet getDietById(int dietId) {
        return dietDao.selectById(dietId);
    }

    public List<Diet> getDietsByMember(int memberNo) {
        return dietDao.selectByMemberNo(memberNo);
    }

    public List<Diet> getDietsByMemberAndDate(int memberNo, LocalDate date) {
        return dietDao.selectByMemberNoAndDate(memberNo, date);
    }

    @Transactional
    public boolean updateDiet(Diet diet) {
        if (dietDao.selectById(diet.getDietId()) == null) {
            return false;
        }
        dietDao.update(diet);
        dietFoodDao.deleteByDietId(diet.getDietId());
        for (DietFood dietFood : diet.getDietFoods()) {
            dietFood.setDietId(diet.getDietId());
            dietFoodDao.insert(dietFood);
        }
        return true;
    }

    @Transactional
    public boolean deleteDiet(int dietId) {
        if (dietDao.selectById(dietId) == null) {
            return false;
        }
        dietFoodDao.deleteByDietId(dietId);
        dietDao.delete(dietId);
        return true;
    }

    public Map<String, Double> getDailyNutrition(int memberNo, LocalDate date) {
        Map<String, Double> nutritionMap = new HashMap<>();
        List<Diet> dailyDiets = getDietsByMemberAndDate(memberNo, date);

        double totalCalories = 0, totalCarbohydrate = 0, totalProtein = 0, totalFat = 0;
        double totalSugar = 0, totalSodium = 0, totalCholesterol = 0, totalSaturatedFat = 0, totalTransFat = 0;

        for (Diet diet : dailyDiets) {
            for (DietFood dietFood : diet.getDietFoods()) {
                Food food = dietFood.getFood();
                if (food != null) {
                    double quantity = dietFood.getQuantity();
                    totalCalories += food.getCalories() * quantity;
                    totalCarbohydrate += food.getCarbohydrate() * quantity;
                    totalProtein += food.getProtein() * quantity;
                    totalFat += food.getFat() * quantity;
                    totalSugar += food.getSugar() * quantity;
                    totalSodium += food.getSodium() * quantity;
                    totalCholesterol += food.getCholesterol() * quantity;
                    totalSaturatedFat += food.getSaturatedFat() * quantity;
                    totalTransFat += food.getTransFat() * quantity;
                }
            }
        }

        nutritionMap.put("calories", totalCalories);
        nutritionMap.put("carbohydrate", totalCarbohydrate);
        nutritionMap.put("protein", totalProtein);
        nutritionMap.put("fat", totalFat);
        nutritionMap.put("sugar", totalSugar);
        nutritionMap.put("sodium", totalSodium);
        nutritionMap.put("cholesterol", totalCholesterol);
        nutritionMap.put("saturatedFat", totalSaturatedFat);
        nutritionMap.put("transFat", totalTransFat);

        return nutritionMap;
    }

    public Map<String, Object> analyzeNutrition(Map<String, Double> nutrition) {
        Map<String, Object> analysis = new HashMap<>();
        analysis.put("totalCalories", nutrition.getOrDefault("calories", 0.0));
        analysis.put("totalCarbohydrate", nutrition.getOrDefault("carbohydrate", 0.0));
        analysis.put("totalProtein", nutrition.getOrDefault("protein", 0.0));
        analysis.put("totalFat", nutrition.getOrDefault("fat", 0.0));

        double recommendedCalories = 2000, recommendedCarbohydrate = 300, recommendedProtein = 50, recommendedFat = 65;
        analysis.put("caloriesPercentage", (nutrition.getOrDefault("calories", 0.0) / recommendedCalories) * 100);
        analysis.put("carbohydratePercentage", (nutrition.getOrDefault("carbohydrate", 0.0) / recommendedCarbohydrate) * 100);
        analysis.put("proteinPercentage", (nutrition.getOrDefault("protein", 0.0) / recommendedProtein) * 100);
        analysis.put("fatPercentage", (nutrition.getOrDefault("fat", 0.0) / recommendedFat) * 100);

        List<String> warnings = new ArrayList<>();
        if (nutrition.getOrDefault("sodium", 0.0) > 2000) warnings.add("나트륨 섭취가 권장량을 초과했습니다.");
        if (nutrition.getOrDefault("sugar", 0.0) > 50) warnings.add("당류 섭취가 권장량을 초과했습니다.");
        if (nutrition.getOrDefault("saturatedFat", 0.0) > 20) warnings.add("포화지방 섭취가 권장량을 초과했습니다.");
        if (nutrition.getOrDefault("transFat", 0.0) > 2) warnings.add("트랜스지방 섭취를 줄이세요.");
        analysis.put("warnings", warnings);

        return analysis;
    }
}