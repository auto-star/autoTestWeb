package com.cd.autoTest.dao;

import java.util.List;

import com.cd.autoTest.model.Category;

public interface CategoryDAO {
	List<Category> findCategoryListByUserId(int userId);
	int insertCategory(Category category);
	Category findCategoryById(int id);
	int updateCategory(Category category);
	int deleteCategory(int id);
	List<Category> findCategoryList(Category category);
}
