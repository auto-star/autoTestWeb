package com.cd.autoTest.service;

import java.util.List;

import com.cd.autoTest.dao.GroupDAO;
import com.cd.autoTest.model.Group;

public class GroupService extends IService {
	private GroupDAO groupDao;

	public List<Group> findGroupList(Group group) {
		return groupDao.findGroupList(group);
	}

	public List<Group> findGroupListByProjectId(int projectId) {
		return groupDao.findGroupListByProjectId(projectId);
	}

	public int insertGroup(Group group) {
		try {
			return groupDao.insertGroup(group);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public int updateGroup(Group group) {
		try {
			return groupDao.updateGroup(group);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public Group findGroupById(int id) {
		return groupDao.findGroupById(id);
	}

	public int deleteGroup(int id) {
		try {
			int i = groupDao.deleteGroup(id);
			return i;
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}

	}
	public Group findGroupByCode(String code){
		return groupDao.findGroupByCode(code);
	}
	public GroupDAO getGroupDao() {
		return groupDao;
	}

	public void setGroupDao(GroupDAO groupDao) {
		this.groupDao = groupDao;
	}

}
