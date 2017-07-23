package com.cd.autoTest.service;

import java.util.List;

import com.cd.autoTest.dao.DegradeDataDAO;
import com.cd.autoTest.model.DegradeData;

public class DegradeDataService extends IService {
	private DegradeDataDAO degradeDataDao = null;



	public List<DegradeData> findDegradeDataList(int degradeId) {
		return degradeDataDao.findDegradeDataList(degradeId);
	}


	public DegradeDataDAO getDegradeDataDao() {
		return degradeDataDao;
	}

	public void setDegradeDataDao(DegradeDataDAO degradeDataDao) {
		this.degradeDataDao = degradeDataDao;
	}
}
