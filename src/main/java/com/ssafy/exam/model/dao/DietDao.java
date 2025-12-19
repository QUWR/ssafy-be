package com.ssafy.exam.model.dao;

import com.ssafy.exam.model.dto.Diet;
import org.apache.ibatis.annotations.Mapper;

import java.time.LocalDate;
import java.util.List;

@Mapper
public interface DietDao {
    int insert(Diet diet);
    Diet selectById(int dietId);
    List<Diet> selectByMemberNo(int memberNo);
    List<Diet> selectByMemberNoAndDate(int memberNo, LocalDate date);
    void update(Diet diet);
    void delete(int dietId);
}
