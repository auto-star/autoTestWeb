package com.cd.autoTest.service;

import java.util.List;

import com.cd.autoTest.dao.CaseDataDAO;
import com.cd.autoTest.dao.DataMapDAO;
import com.cd.autoTest.model.DataMap;

public class DataMapService extends IService {
	private DataMapDAO dataMapDao;
	private CaseDataDAO caseDataDao;

	public List<DataMap> findDataMapListByPageId(int pageId) {
		return dataMapDao.findDataMapListByPageId(pageId);
	}

	public int insertDataMap(DataMap dataMap) {
		try {
			return dataMapDao.insertDataMap(dataMap);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public Integer findActionIdByDataMapId(int dataMapId) {
		return dataMapDao.findActionIdByDataMapId(dataMapId);
	}

	public int findMaxSort(int pageId) {
		return dataMapDao.findMaxSort(pageId);
	}

	public int deleteDataMapByActionId(int actionId) {
		try {
			return dataMapDao.deleteDataMapByActionId(actionId);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public DataMap findDataMapByActionId(int actionId) {
		return dataMapDao.findDataMapByActionId(actionId);
	}

	public DataMap findDataMapById(int id) {
		return dataMapDao.findDataMapById(id);
	}

	public DataMap findDataMap(DataMap dataMap) {
		return dataMapDao.findDataMap(dataMap);
	}

	public int updateDataMapSort(int pageId, int dataMapId, int option) {
		try {
			int i = 0;
			DataMap dataMap = dataMapDao.findDataMapById(dataMapId);
			if (option == 1) {
				DataMap conditionDataMap = new DataMap();
				conditionDataMap.setSort(dataMap.getSort() - 1);
				conditionDataMap.setPageId(pageId);
				DataMap dataMap2 = dataMapDao.findDataMap(conditionDataMap);
				if (dataMap2 != null) {
					dataMap2.setSort(dataMap2.getSort() + 1);
					i += dataMapDao.updateDataMap(dataMap2);
					caseDataDao.updateCaseDataSortAdd(dataMap2.getId());
				}
				dataMap.setSort(dataMap.getSort() - 1);
				i += dataMapDao.updateDataMap(dataMap);
				caseDataDao.updateCaseDataSortMinus(dataMap.getId());
			} else if (option == 2) {
				DataMap conditionDataMap = new DataMap();
				conditionDataMap.setSort(dataMap.getSort() + 1);
				conditionDataMap.setPageId(pageId);
				DataMap dataMap2 = dataMapDao.findDataMap(conditionDataMap);
				if (dataMap2 != null) {
					dataMap2.setSort(dataMap2.getSort() - 1);
					i += dataMapDao.updateDataMap(dataMap2);
					caseDataDao.updateCaseDataSortMinus(dataMap2.getId());
				}
				dataMap.setSort(dataMap.getSort() + 1);
				i += dataMapDao.updateDataMap(dataMap);
				caseDataDao.updateCaseDataSortAdd(dataMap.getId());
			}
			return i;
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public int updateDataMap(DataMap dataMap) {
		try {
			return dataMapDao.updateDataMap(dataMap);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public DataMapDAO getDataMapDao() {
		return dataMapDao;
	}

	public void setDataMapDao(DataMapDAO dataMapDao) {
		this.dataMapDao = dataMapDao;
	}

	public CaseDataDAO getCaseDataDao() {
		return caseDataDao;
	}

	public void setCaseDataDao(CaseDataDAO caseDataDao) {
		this.caseDataDao = caseDataDao;
	}

}
