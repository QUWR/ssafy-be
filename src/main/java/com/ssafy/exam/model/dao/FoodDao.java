package com.ssafy.exam.model.dao;

import com.ssafy.exam.model.dto.Food;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface FoodDao {
    void insert(Food food);
    Food selectByCode(String code);
    List<Food> selectAll();
    List<Food> selectByName(String name);
    List<Food> selectByCategory(String category);
    void update(Food food);
    void delete(String code);
    void deleteAll();
}
