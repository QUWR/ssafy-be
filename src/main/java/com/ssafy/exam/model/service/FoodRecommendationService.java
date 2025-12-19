package com.ssafy.exam.model.service;

import com.ssafy.exam.model.dto.Food;
import com.ssafy.exam.model.dto.Member;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class FoodRecommendationService {

    private final FoodDataService foodDataService;

    public FoodRecommendationService(FoodDataService foodDataService) {
        this.foodDataService = foodDataService;
    }

    private static class FoodScore implements Comparable<FoodScore> {
        Food food;
        double score;

        FoodScore(Food food, double score) {
            this.food = food;
            this.score = score;
        }

        @Override
        public int compareTo(FoodScore other) {
            return Double.compare(other.score, this.score);
        }
    }

    public List<Food> recommendFoods(Member member, int topN) {
        List<Food> allFoods = foodDataService.getAllFoods();
        List<FoodScore> scoredFoods = new ArrayList<>();

        for (Food food : allFoods) {
            double score = calculateFoodScore(food, member);
            scoredFoods.add(new FoodScore(food, score));
        }

        // Using Java's built-in sort which is highly optimized (Timsort)
        Collections.sort(scoredFoods);

        List<Food> recommendations = new ArrayList<>();
        for (int i = 0; i < Math.min(topN, scoredFoods.size()); i++) {
            recommendations.add(scoredFoods.get(i).food);
        }

        return recommendations;
    }

    private double calculateFoodScore(Food food, Member member) {
        double score = 100.0;

        String healthCondition = member.getHealthCondition();
        String goal = member.getGoal();

        if (healthCondition != null && !healthCondition.isEmpty()) {
            switch (healthCondition.toLowerCase()) {
                case "당뇨":
                case "당뇨 전단계":
                    score -= food.getSugar() * 3.0;
                    score -= food.getCarbohydrate() * 1.5;
                    score += food.getProtein() * 1.2;
                    break;
                case "고혈압":
                    score -= food.getSodium() * 0.05;
                    score -= food.getCholesterol() * 2.0;
                    score += food.getProtein() * 1.0;
                    break;
                case "비만":
                    score -= food.getCalories() * 0.3;
                    score -= food.getFat() * 2.0;
                    score -= food.getSaturatedFat() * 3.0;
                    score += food.getProtein() * 1.5;
                    break;
            }
        }

        if (goal != null && !goal.isEmpty()) {
            switch (goal.toLowerCase()) {
                case "다이어트":
                case "체중감량":
                    score -= food.getCalories() * 0.4;
                    score -= food.getFat() * 2.5;
                    score += food.getProtein() * 2.0;
                    break;
                case "근육증가":
                case "벌크업":
                    score += food.getProtein() * 3.0;
                    score += food.getCalories() * 0.1;
                    score -= food.getSaturatedFat() * 1.5;
                    break;
                case "건강유지":
                    double balanceScore = Math.abs(food.getCarbohydrate() - 50) +
                                         Math.abs(food.getProtein() - 20) +
                                         Math.abs(food.getFat() - 15);
                    score -= balanceScore * 0.5;
                    break;
            }
        }

        if (food.getTransFat() > 0) {
            score -= food.getTransFat() * 10.0;
        }

        return Math.max(0, score);
    }
}