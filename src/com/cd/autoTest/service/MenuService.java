package com.cd.autoTest.service;

import java.util.List;

import com.cd.autoTest.dao.MenuDAO;
import com.cd.autoTest.model.Menu;

public class MenuService extends IService {
	private MenuDAO menuDao;

	public List<Menu> findMenuList() {
		return menuDao.findMenuList();
	}
	public List<Menu> findParentMenuList()
	{
		return menuDao.findParentMenuList();
	}
	public List<Menu> findMenuListByParentId(int parentMenuId)
	{
		return menuDao.findMenuListByParentId(parentMenuId);
	}
	public List<Menu> findParentRoleMenuList(Menu menu){
		return menuDao.findParentRoleMenuList(menu);
	}
	public int insertMenu(Menu menu) {
		try {
			return menuDao.insertMenu(menu);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public int updateMenu(Menu menu) {
		try {
			return menuDao.updateMenu(menu);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public Menu findMenuById(int id) {
		return menuDao.findMenuById(id);
	}

	public int deleteMenu(int id) {
		try {
			int i = menuDao.deleteMenu(id);
			return i;
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}

	}
	public MenuDAO getMenuDao() {
		return menuDao;
	}

	public void setMenuDao(MenuDAO menuDao) {
		this.menuDao = menuDao;
	}

}
