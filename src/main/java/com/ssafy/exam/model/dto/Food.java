package com.ssafy.exam.model.dto;

public class Food {
    private String code;
    private String name;
    private String category;
    private String servingSize;
    private double calories;
    private double carbohydrate;
    private double protein;
    private double fat;
    private double sugar;
    private double sodium;
    private double cholesterol;
    private double saturatedFat;
    private double transFat;

    public Food() {}

    public Food(String code, String name, String category, String servingSize,
                double calories, double carbohydrate, double protein, double fat,
                double sugar, double sodium, double cholesterol,
                double saturatedFat, double transFat) {
        this.code = code;
        this.name = name;
        this.category = category;
        this.servingSize = servingSize;
        this.calories = calories;
        this.carbohydrate = carbohydrate;
        this.protein = protein;
        this.fat = fat;
        this.sugar = sugar;
        this.sodium = sodium;
        this.cholesterol = cholesterol;
        this.saturatedFat = saturatedFat;
        this.transFat = transFat;
    }

    public String getCode() { return code; }
    public void setCode(String code) { this.code = code; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    public String getServingSize() { return servingSize; }
    public void setServingSize(String servingSize) { this.servingSize = servingSize; }
    public double getCalories() { return calories; }
    public void setCalories(double calories) { this.calories = calories; }
    public double getCarbohydrate() { return carbohydrate; }
    public void setCarbohydrate(double carbohydrate) { this.carbohydrate = carbohydrate; }
    public double getProtein() { return protein; }
    public void setProtein(double protein) { this.protein = protein; }
    public double getFat() { return fat; }
    public void setFat(double fat) { this.fat = fat; }
    public double getSugar() { return sugar; }
    public void setSugar(double sugar) { this.sugar = sugar; }
    public double getSodium() { return sodium; }
    public void setSodium(double sodium) { this.sodium = sodium; }
    public double getCholesterol() { return cholesterol; }
    public void setCholesterol(double cholesterol) { this.cholesterol = cholesterol; }
    public double getSaturatedFat() { return saturatedFat; }
    public void setSaturatedFat(double saturatedFat) { this.saturatedFat = saturatedFat; }
    public double getTransFat() { return transFat; }
    public void setTransFat(double transFat) { this.transFat = transFat; }

    @Override
    public String toString() {
        return "Food{" +
                "code='" + code + '\'' +
                ", name='" + name + '\'' +
                ", category='" + category + '\'' +
                ", servingSize='" + servingSize + '\'' +
                ", calories=" + calories +
                ", carbohydrate=" + carbohydrate +
                ", protein=" + protein +
                ", fat=" + fat +
                ", sugar=" + sugar +
                ", sodium=" + sodium +
                ", cholesterol=" + cholesterol +
                ", saturatedFat=" + saturatedFat +
                ", transFat=" + transFat +
                '}';
    }
}