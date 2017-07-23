package com.cd.autoTest.dao;

import java.util.List;

import com.cd.autoTest.model.Project;

public interface ProjectDAO{
	List<Project> findProjectList(Project project);
	List<Project> findProjectList();
	int findProjectCount(Project project);
	int insertProject(Project project);
	Project findProjectById(int id);
	int deleteProject(int id);
	int updateProject(Project project);
}
