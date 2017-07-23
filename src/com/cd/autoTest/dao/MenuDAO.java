package com.cd.autoTest.dao;

import java.util.List;

import com.cd.autoTest.model.Menu;

public interface MenuDAO {
	List<Menu> findMenuList();
	List<Menu> findParentMenuList();
	List<Menu> findMenuListByParentId(int parentMenuId);
	List<Menu> findParentRoleMenuList(Menu menu);
	int insertMenu(Menu menu);
	int updateMenu(Menu menu);
	Menu findMenuById(int id);
	int deleteMenu(int id);
}
