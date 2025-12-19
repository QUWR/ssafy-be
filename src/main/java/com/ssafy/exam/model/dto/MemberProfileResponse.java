package com.ssafy.exam.model.dto;

public class MemberProfileResponse {
    private Member member;
    private String error;

    public MemberProfileResponse(Member member, String error) {
        this.member = member;
        this.error = error;
    }

    public Member getMember() {
        return member;
    }

    public void setMember(Member member) {
        this.member = member;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }
}
