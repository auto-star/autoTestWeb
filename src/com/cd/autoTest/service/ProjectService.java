package com.cd.autoTest.service;

import java.util.List;

import com.cd.autoTest.dao.ProjectDAO;
import com.cd.autoTest.model.Project;

public class ProjectService extends IService {
	private ProjectDAO projectDao;

	public List<Project> findProjectList(Project project) {
		return projectDao.findProjectList(project);
	}
	public List<Project> findProjectList(){
		return projectDao.findProjectList();
	}
	public int findProjectCount(Project project) {
		return projectDao.findProjectCount(project);
	}
	public int insertProject(Project project) {
		try {
			return projectDao.insertProject(project);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public Project findProjectById(int id) {
		return projectDao.findProjectById(id);
	}

	public int deleteProject(int id) {
		try {
			return projectDao.deleteProject(id);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public int updateProject(Project project) {
		try {
			return projectDao.updateProject(project);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public ProjectDAO getProjectDao() {
		return projectDao;
	}

	public void setProjectDao(ProjectDAO projectDao) {
		this.projectDao = projectDao;
	}

}
