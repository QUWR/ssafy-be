package com.ssafy.exam.model.dto;

import java.util.ArrayList;
import java.util.List;

public class RecommendFoodResponse {

    private List<String> foodList = new ArrayList<>();

    private String reason;

    public List<String> getFoodList() {
        return foodList;
    }

    public void setFoodList(List<String> foodList) {
        this.foodList = foodList;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public RecommendFoodResponse() {
    }

    public RecommendFoodResponse(List<String> foodList, String reason) {
        this.foodList = foodList;
        this.reason = reason;
    }
}
