package com.cd.autoTest.service;

import java.util.List;

import com.cd.autoTest.dao.CategoryDAO;
import com.cd.autoTest.model.Category;

public class CategoryService extends IService {
	private CategoryDAO categoryDao;

	public List<Category> findCategoryListByUserId(int userId) {
		return categoryDao.findCategoryListByUserId(userId);
	}

	public int insertCategory(Category category) {
		try {
			return categoryDao.insertCategory(category);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public Category findCategoryById(int id) {
		return categoryDao.findCategoryById(id);
	}

	public int updateCategory(Category category) {
		try {
			return categoryDao.updateCategory(category);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public int deleteCategory(int id) {
		try {
			return categoryDao.deleteCategory(id);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}
	public List<Category> findCategoryList(Category category){
		return categoryDao.findCategoryList(category);
	}
	public CategoryDAO getCategoryDao() {
		return categoryDao;
	}

	public void setCategoryDao(CategoryDAO categoryDao) {
		this.categoryDao = categoryDao;
	}

}
