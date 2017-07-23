package com.cd.autoTest.service;

import java.util.List;

import com.cd.autoTest.dao.RoleMenuDAO;
import com.cd.autoTest.model.RoleMenu;

public class RoleMenuService extends IService {
	private RoleMenuDAO roleMenuDao;

	public List<RoleMenu> findRoleMenuList() {
		return roleMenuDao.findRoleMenuList();
	}
	public List<RoleMenu> findRoleMenuListByRoleId(int roleId){
		return roleMenuDao.findRoleMenuListByRoleId(roleId);
	}
	public int insertRoleMenu(String[] menuIds,int roleId) {
		try {
			roleMenuDao.deleteRoleMenuByRoleId(roleId);
			int i=0;
			for(String menuId:menuIds)
			{
				RoleMenu roleMenu=new RoleMenu();
				roleMenu.setMenuId(Integer.valueOf(menuId));
				roleMenu.setRoleId(roleId);
				i+=roleMenuDao.insertRoleMenu(roleMenu);
			}
			return i;
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	

	public RoleMenuDAO getRoleMenuDao() {
		return roleMenuDao;
	}

	public void setRoleMenuDao(RoleMenuDAO roleMenuDao) {
		this.roleMenuDao = roleMenuDao;
	}

}
