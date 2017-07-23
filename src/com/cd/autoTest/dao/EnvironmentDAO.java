package com.cd.autoTest.dao;

import java.util.List;

import com.cd.autoTest.model.Environment;

public interface EnvironmentDAO{
	List<Environment> findEnvironmentList();
	int insertEnvironment(Environment environment);
	Environment findEnvironmentById(int id);
	int deleteEnvironment(int id);
	int updateEnvironment(Environment environment);
	List<Environment> findEnvironmentListByProjectId(int projectId);
}
