package com.cd.autoTest.service;

import java.util.List;

import com.cd.autoTest.dao.CaseDataDAO;
import com.cd.autoTest.dao.CasePageDAO;
import com.cd.autoTest.dao.DataMapDAO;
import com.cd.autoTest.model.CaseData;
import com.cd.autoTest.model.CasePage;
import com.cd.autoTest.model.DataMap;

public class CasePageService extends IService {
	private CasePageDAO casePageDao;
	private DataMapDAO dataMapDao;
	private CaseDataDAO caseDataDao;

	public List<CasePage> findCasePageListByBaseCaseId(int baseCaseId) {
		return casePageDao.findCasePageListByBaseCaseId(baseCaseId);
	}
	public List<CasePage> findParentCasePageListByBaseCaseId(int baseCaseId){
		return casePageDao.findParentCasePageListByBaseCaseId(baseCaseId);
	}
	public List<CasePage> findChildCasePageListByParentId(int parentId){
		return casePageDao.findChildCasePageListByParentId(parentId);
	}
	public int insertCasePage(CasePage casePage, int casePageId) {
		try {
			Integer maxSort = 0;
			if (casePageId > 0) {
				CasePage cp = casePageDao.findCasePageById(casePageId);
				maxSort = cp.getSort();
				casePageDao.updateCasePageSort(cp);
				casePage.setSort(++maxSort);
			} else {
				maxSort = casePageDao.findMaxSort(casePage);
				casePage.setSort(++maxSort);
			}
			int i = casePageDao.insertCasePage(casePage);
			List<DataMap> dataMapList = dataMapDao.findDataMapListByPageId(casePage.getPageId());
			CaseData caseData = new CaseData();
			int j = 0;
			for (DataMap dataMap : dataMapList) {
				j++;
				if(dataMap.getCategory()!=4){
					caseData = new CaseData();
					caseData.setCategory(dataMap.getCategory());
					caseData.setDataMapId(dataMap.getId());
					caseData.setCasePageId(casePage.getId());
					caseData.setSort(j);
					caseDataDao.insertCaseData(caseData);
				}
				
			}
			return i;
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public List<CasePage> findCasePageList(CasePage casePage) {
		return casePageDao.findCasePageList(casePage);
	}

	public int deleteCasePageByBaseCaseId(int baseCaseId) {
		try {
			return casePageDao.deleteCasePageByBaseCaseId(baseCaseId);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public int findMaxSort(CasePage casePage) {
		return casePageDao.findMaxSort(casePage);
	}

	public CasePage findCasePageById(int id) {
		return casePageDao.findCasePageById(id);
	}

	public int updateCasePageSort(CasePage casePage) {
		try {
			return casePageDao.updateCasePageSort(casePage);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public int deleteCasePage(int id) {
		try {
			CasePage cp = casePageDao.findCasePageById(id);
			casePageDao.updateCasePageSortMinus(cp);
			caseDataDao.deleteCaseDataByCasePageId(id);
			int i = casePageDao.deleteCasePage(id);
			return i;
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}

	}

	public int updateCasePageSortMinus(CasePage casePage) {
		try {
			return casePageDao.updateCasePageSortMinus(casePage);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public CasePageDAO getCasePageDao() {
		return casePageDao;
	}

	public void setCasePageDao(CasePageDAO casePageDao) {
		this.casePageDao = casePageDao;
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
