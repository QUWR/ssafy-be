package com.ssafy.exam.model.dto;

public class MemberLoginResponse {
    private String token;
    private String error;

    public MemberLoginResponse(String token, String error) {
        this.token = token;
        this.error = error;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }
}
