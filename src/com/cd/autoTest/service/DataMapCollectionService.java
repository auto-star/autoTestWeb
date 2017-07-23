package com.cd.autoTest.service;

import java.util.List;

import com.cd.autoTest.dao.DataMapCollectionDAO;
import com.cd.autoTest.model.DataMapCollection;

public class DataMapCollectionService extends IService {
	private DataMapCollectionDAO dataMapCollectionDao;

	public int insertDataMapCollection(DataMapCollection dataMapCollection) {
		try {
			return dataMapCollectionDao.insertDataMapCollection(dataMapCollection);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public List<DataMapCollection> findDataMapCollectionListByDataMapId(int dataMapId) {
		return dataMapCollectionDao.findDataMapCollectionListByDataMapId(dataMapId);
	}

	public int deleteDataMapCollectionByDataMapId(int dataMapId) {
		try {
			return dataMapCollectionDao.deleteDataMapCollectionByDataMapId(dataMapId);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public DataMapCollectionDAO getDataMapCollectionDao() {
		return dataMapCollectionDao;
	}

	public void setDataMapCollectionDao(DataMapCollectionDAO dataMapCollectionDao) {
		this.dataMapCollectionDao = dataMapCollectionDao;
	}

}
