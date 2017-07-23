package com.cd.autoTest.service;

import java.util.List;

import com.cd.autoTest.dao.DegradeDAO;
import com.cd.autoTest.model.Degrade;


public class DegradeService extends IService {
	private DegradeDAO degradeDao;

	public List<Degrade> findDegradeList(Degrade degrade){
		return degradeDao.findDegradeList(degrade);
	}
	public int findDegradeCount(Degrade degrade){
		return degradeDao.findDegradeCount(degrade);
	}
	public Degrade findDegradeById(int id){
		return degradeDao.findDegradeById(id);
	}
	public DegradeDAO getDegradeDao() {
		return degradeDao;
	}
	public void setDegradeDao(DegradeDAO degradeDao) {
		this.degradeDao = degradeDao;
	}
	

}
