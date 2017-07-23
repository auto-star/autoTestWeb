package com.cd.autoTest.dao;

import java.util.List;

import com.cd.autoTest.model.RoleMenu;

public interface RoleMenuDAO {
	List<RoleMenu> findRoleMenuList();
	List<RoleMenu> findRoleMenuListByRoleId(int roleId);
	int insertRoleMenu(RoleMenu roleMenu);
	int deleteRoleMenuByRoleId(int roleId);
}
