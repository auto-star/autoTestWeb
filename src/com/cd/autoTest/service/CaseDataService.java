package com.cd.autoTest.service;

import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import com.cd.autoTest.dao.CaseDataDAO;
import com.cd.autoTest.model.CaseData;

public class CaseDataService extends IService {
	private CaseDataDAO caseDataDao;

	public List<CaseData> findCaseDataListByCasePageId(int casePageId) {
		return caseDataDao.findCaseDataListByCasePageId(casePageId);
	}
	public CaseData findCaseData(CaseData caseData){
		return caseDataDao.findCaseData(caseData);
	}
	public int insertCaseData(CaseData caseData) {
		return caseDataDao.insertCaseData(caseData);
	}

	public int findMaxSort(int casePageId) {
		return caseDataDao.findMaxSort(casePageId);
	}

	public int deleteCaseDataByCasePageId(int casePageId) {
		return caseDataDao.deleteCaseDataByCasePageId(casePageId);
	}

	public int updateCaseData(String jsonStr) {
		try {
			JSONArray json = new JSONArray(jsonStr);
			int j = 0;
			for (int i = 0; i < json.length(); i++) {
				JSONObject jo = json.getJSONObject(i);
				CaseData cd = new CaseData();
				cd.setId(jo.getInt("id"));
				cd.setDataValue(jo.getString("dataValue"));
				j += caseDataDao.updateCaseData(cd);
			}
			return j;
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public int updateCaseDataSortMinus(int dataMapId) {
		try {
			return caseDataDao.updateCaseDataSortMinus(dataMapId);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public int updateCaseDataSortAdd(int dataMapId) {
		try {
			return caseDataDao.updateCaseDataSortAdd(dataMapId);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public int deleteCaseDataByDataMapId(int dataMapId) {
		try {
			return caseDataDao.deleteCaseDataByDataMapId(dataMapId);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public CaseDataDAO getCaseDataDao() {
		return caseDataDao;
	}

	public void setCaseDataDao(CaseDataDAO caseDataDao) {
		this.caseDataDao = caseDataDao;
	}

}
