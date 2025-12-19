package com.ssafy.exam.model.service;

import com.ssafy.exam.model.dao.FoodDao;
import com.ssafy.exam.model.dto.Food;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class FoodDataService {

    private final FoodDao foodDao;

    public FoodDataService(FoodDao foodDao) {
        this.foodDao = foodDao;
    }

    public List<Food> getAllFoods() {
        return foodDao.selectAll();
    }

    public Food getFoodByCode(String code) {
        return foodDao.selectByCode(code);
    }

    public List<Food> searchFoodByName(String name) {
        return foodDao.selectByName(name);
    }

    public List<Food> getFoodsByCategory(String category) {
        return foodDao.selectByCategory(category);
    }
}