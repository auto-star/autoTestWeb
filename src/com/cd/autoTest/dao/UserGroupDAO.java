package com.cd.autoTest.dao;

import java.util.List;

import com.cd.autoTest.model.UserGroup;

public interface UserGroupDAO {
	List<UserGroup> findUserGroupList();
	int insertUserGroup(UserGroup userGroup);
	int updateUserGroup(UserGroup userGroup);
	UserGroup findUserGroupById(int id);
	int deleteUserGroup(int id);
}
