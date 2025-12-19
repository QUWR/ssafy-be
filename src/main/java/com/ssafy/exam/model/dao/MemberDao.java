package com.ssafy.exam.model.dao;

import com.ssafy.exam.model.dto.Member;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MemberDao {
    void insert(Member member);
    Member selectByEmail(String email);
    Member selectByMno(int mno);
    List<Member> selectAll();
    void update(Member member);
    void delete(int mno);
    Member login(String email, String password);
}
