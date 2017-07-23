package com.cd.autoTest.dao;

import java.util.List;

import com.cd.autoTest.model.Page;

public interface PageDAO {
	List<Page> findPageList(Page page);
	int insertPage(Page page);
	Page findPageById(int id);
	int updatePage(Page page);
	int deletePageById(int id);
	int findPageCount(Page page);
}
