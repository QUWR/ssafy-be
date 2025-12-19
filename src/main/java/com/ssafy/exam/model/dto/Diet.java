package com.ssafy.exam.model.dto;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class Diet implements Serializable {
    private int dietId;
    private int memberNo;
    private LocalDateTime mealTime;
    private String mealType;
    private List<DietFood> dietFoods;
    private String memo;

    public Diet() {
        this.dietFoods = new ArrayList<>();
    }

    public Diet(int memberNo, LocalDateTime mealTime, String mealType) {
        this.memberNo = memberNo;
        this.mealTime = mealTime;
        this.mealType = mealType;
        this.dietFoods = new ArrayList<>();
    }

    public int getDietId() { return dietId; }
    public void setDietId(int dietId) { this.dietId = dietId; }
    public int getMemberNo() { return memberNo; }
    public void setMemberNo(int memberNo) { this.memberNo = memberNo; }
    public LocalDateTime getMealTime() { return mealTime; }
    public void setMealTime(LocalDateTime mealTime) { this.mealTime = mealTime; }
    public String getMealType() { return mealType; }
    public void setMealType(String mealType) { this.mealType = mealType; }
    public List<DietFood> getDietFoods() { return dietFoods; }
    public void setDietFoods(List<DietFood> dietFoods) { this.dietFoods = dietFoods; }
    public String getMemo() { return memo; }
    public void setMemo(String memo) { this.memo = memo; }

    public double getTotalCalories() {
        if (dietFoods == null) return 0;
        return dietFoods.stream()
                .filter(df -> df.getFood() != null)
                .mapToDouble(df -> df.getFood().getCalories() * df.getQuantity())
                .sum();
    }

    public double getTotalCarbohydrate() {
        if (dietFoods == null) return 0;
        return dietFoods.stream()
                .filter(df -> df.getFood() != null)
                .mapToDouble(df -> df.getFood().getCarbohydrate() * df.getQuantity())
                .sum();
    }

    public double getTotalProtein() {
        if (dietFoods == null) return 0;
        return dietFoods.stream()
                .filter(df -> df.getFood() != null)
                .mapToDouble(df -> df.getFood().getProtein() * df.getQuantity())
                .sum();
    }

    public double getTotalFat() {
        if (dietFoods == null) return 0;
        return dietFoods.stream()
                .filter(df -> df.getFood() != null)
                .mapToDouble(df -> df.getFood().getFat() * df.getQuantity())
                .sum();
    }

    @Override
    public String toString() {
        return "Diet [dietId=" + dietId + ", memberNo=" + memberNo + ", mealTime=" + mealTime +
               ", mealType=" + mealType + ", memo=" + memo + "]";
    }
}