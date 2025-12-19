package com.ssafy.exam.model.dto;

import java.io.Serializable;

public class DietFood implements Serializable {
    private int dietFoodId;
    private int dietId;
    private String foodCode;
    private Food food;
    private double quantity;

    public DietFood() {}

    public DietFood(int dietId, String foodCode, double quantity) {
        this.dietId = dietId;
        this.foodCode = foodCode;
        this.quantity = quantity;
    }

    public int getDietFoodId() { return dietFoodId; }
    public void setDietFoodId(int dietFoodId) { this.dietFoodId = dietFoodId; }
    public int getDietId() { return dietId; }
    public void setDietId(int dietId) { this.dietId = dietId; }
    public String getFoodCode() { return foodCode; }
    public void setFoodCode(String foodCode) { this.foodCode = foodCode; }
    public Food getFood() { return food; }
    public void setFood(Food food) { this.food = food; }
    public double getQuantity() { return quantity; }
    public void setQuantity(double quantity) { this.quantity = quantity; }

    @Override
    public String toString() {
        return "DietFood [dietFoodId=" + dietFoodId + ", dietId=" + dietId +
               ", foodCode=" + foodCode + ", quantity=" + quantity + "]";
    }
}