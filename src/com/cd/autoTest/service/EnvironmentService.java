package com.cd.autoTest.service;

import java.util.List;

import com.cd.autoTest.dao.EnvironmentDAO;
import com.cd.autoTest.model.Environment;

public class EnvironmentService extends IService {
	private EnvironmentDAO environmentDao;

	public List<Environment> findEnvironmentList() {
		return environmentDao.findEnvironmentList();
	}
	public List<Environment> findEnvironmentListByProjectId(int projectId){
		return environmentDao.findEnvironmentListByProjectId(projectId);
	}
	public int insertEnvironment(Environment environment) {
		try {
			return environmentDao.insertEnvironment(environment);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public Environment findEnvironmentById(int id) {
		return environmentDao.findEnvironmentById(id);
	}

	public int deleteEnvironment(int id) {
		try {
			return environmentDao.deleteEnvironment(id);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public int updateEnvironment(Environment environment) {
		try {
			return environmentDao.updateEnvironment(environment);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public EnvironmentDAO getEnvironmentDao() {
		return environmentDao;
	}

	public void setEnvironmentDao(EnvironmentDAO environmentDao) {
		this.environmentDao = environmentDao;
	}

}
