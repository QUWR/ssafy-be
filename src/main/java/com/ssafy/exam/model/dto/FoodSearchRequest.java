package com.ssafy.exam.model.dto;

public class FoodSearchRequest {

    private String keyword;
    private boolean autocomplete;
    private int max = 10; // Default value for autocomplete results

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public boolean isAutocomplete() {
        return autocomplete;
    }

    public void setAutocomplete(boolean autocomplete) {
        this.autocomplete = autocomplete;
    }

    public int getMax() {
        return max;
    }

    public void setMax(int max) {
        this.max = max;
    }
}
