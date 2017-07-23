package com.cd.autoTest.service;

import java.util.List;

import com.cd.autoTest.dao.RoleDAO;
import com.cd.autoTest.model.Role;

public class RoleService extends IService {
	private RoleDAO roleDao;

	public List<Role> findRoleList() {
		return roleDao.findRoleList();
	}
	public int insertRole(Role role) {
		try {
			return roleDao.insertRole(role);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public int updateRole(Role role) {
		try {
			return roleDao.updateRole(role);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public Role findRoleById(int id) {
		return roleDao.findRoleById(id);
	}

	public int deleteRole(int id) {
		try {
			int i = roleDao.deleteRole(id);
			return i;
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}

	}
	public RoleDAO getRoleDao() {
		return roleDao;
	}

	public void setRoleDao(RoleDAO roleDao) {
		this.roleDao = roleDao;
	}

}
