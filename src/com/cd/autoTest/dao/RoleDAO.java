package com.cd.autoTest.dao;

import java.util.List;

import com.cd.autoTest.model.Role;

public interface RoleDAO {
	List<Role> findRoleList();
	int insertRole(Role role);
	int updateRole(Role role);
	Role findRoleById(int id);
	int deleteRole(int id);
}
