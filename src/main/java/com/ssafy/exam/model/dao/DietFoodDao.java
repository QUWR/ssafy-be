package com.ssafy.exam.model.dao;

import com.ssafy.exam.model.dto.DietFood;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface DietFoodDao {
    void insert(DietFood dietFood);
    List<DietFood> selectByDietId(int dietId);
    void deleteByDietId(int dietId);
}
