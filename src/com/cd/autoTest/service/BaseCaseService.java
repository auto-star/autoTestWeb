package com.cd.autoTest.service;

import java.util.List;

import com.cd.autoTest.dao.BaseCaseDAO;
import com.cd.autoTest.dao.CaseDataDAO;
import com.cd.autoTest.dao.CasePageDAO;
import com.cd.autoTest.model.BaseCase;
import com.cd.autoTest.model.CaseData;
import com.cd.autoTest.model.CasePage;

public class BaseCaseService extends IService {
	private BaseCaseDAO baseCaseDao;
	private CasePageDAO casePageDao;
	private CaseDataDAO caseDataDao;

	public List<BaseCase> findBaseCaseListByCaseId(int caseId) {
		return baseCaseDao.findBaseCaseListByCaseId(caseId);
	}

	public BaseCase findBaseCaseById(int id) {
		return baseCaseDao.findBaseCaseById(id);
	}

	public List<BaseCase> findBaseCaseList(BaseCase baseCase) {
		return baseCaseDao.findBaseCaseList(baseCase);
	}

	public int insertBaseCase(BaseCase baseCase, int formerBaseCaseId) {
		try {
			int i = baseCaseDao.insertBaseCase(baseCase);
			if (formerBaseCaseId > 0) {
				List<CasePage> casePageList = casePageDao.findParentCasePageListByBaseCaseId(formerBaseCaseId);
				for (CasePage cp : casePageList) {
					int casePageId = cp.getId();
					insertCasePage(cp,baseCase.getUserId(),baseCase.getId(),0,casePageId);
				}
			}
			return i;
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}
	public void insertCasePage(CasePage cp,int userId,int baseCaseId,int parentId,int casePageId){
		cp.setBaseCaseId(baseCaseId);
		cp.setUserId(userId);
		cp.setParentId(parentId);
		int j = casePageDao.insertCasePage(cp);
		if (j > 0) {
			List<CaseData> caseDataList = caseDataDao.findCaseDataListByCasePageId(casePageId);
			for (CaseData cd : caseDataList) {
				cd.setCasePageId(cp.getId());
				caseDataDao.insertCaseData(cd);
			}
			List<CasePage> casePageList=casePageDao.findChildCasePageListByParentId(casePageId);
			for(CasePage casePage:casePageList){
				insertCasePage(casePage,userId,baseCaseId,cp.getId(),casePage.getId());
			}
		}
	}
	public int deleteBaseCase(int id) {
		try {
			List<CasePage> casePageList = casePageDao.findCasePageListByBaseCaseId(id);
			for (CasePage cp : casePageList) {
				caseDataDao.deleteCaseDataByCasePageId(cp.getId());
			}
			casePageDao.deleteCasePageByBaseCaseId(id);
			BaseCase bc = baseCaseDao.findBaseCaseById(id);
			baseCaseDao.updateBaseCaseSortMinus(bc);
			int i = baseCaseDao.deleteBaseCase(id);

			return i;
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}

	}

	public int deleteBaseCaseByCaseId(int caseId) {
		try {
			return baseCaseDao.deleteBaseCaseByCaseId(caseId);
		} catch (Exception e) {
			throw new RuntimeException(e.toString());
		}

	}

	public int updateBaseCase(BaseCase baseCase) {
		try {
			return baseCaseDao.updateBaseCase(baseCase);
		} catch (Exception e) {
			throw new RuntimeException(e.toString());
		}
	}

	public BaseCase findBaseCase(BaseCase baseCase) {
		return baseCaseDao.findBaseCase(baseCase);
	}

	public int updateBaseCaseSortAdd(BaseCase baseCase) {
		try {
			return baseCaseDao.updateBaseCaseSortAdd(baseCase);
		} catch (Exception e) {
			throw new RuntimeException(e.toString());
		}
	}

	public int updateBaseCaseSortMinus(BaseCase baseCase) {
		try {
			return baseCaseDao.updateBaseCaseSortMinus(baseCase);
		} catch (Exception e) {
			throw new RuntimeException(e.toString());
		}
	}

	public int findMaxSort(int caseId) {
		return baseCaseDao.findMaxSort(caseId);
	}

	public int updateBaseCaseSort(int caseId, int baseCaseId, int option) {
		try {
			BaseCase bc = baseCaseDao.findBaseCaseById(baseCaseId);
			int i = 0;
			if (option == 1) {
				BaseCase conditionBaseCase = new BaseCase();
				conditionBaseCase.setSort(bc.getSort() - 1);
				conditionBaseCase.setCaseId(caseId);
				BaseCase bc2 = baseCaseDao.findBaseCase(conditionBaseCase);
				if (bc2 != null) {
					bc2.setSort(bc2.getSort() + 1);
					i += baseCaseDao.updateBaseCase(bc2);
				}
				bc.setSort(bc.getSort() - 1);
				i += baseCaseDao.updateBaseCase(bc);
			} else if (option == 2) {
				BaseCase conditionBaseCase = new BaseCase();
				conditionBaseCase.setSort(bc.getSort() + 1);
				conditionBaseCase.setCaseId(caseId);
				BaseCase bc2 = baseCaseDao.findBaseCase(conditionBaseCase);
				if (bc2 != null) {
					bc2.setSort(bc2.getSort() - 1);
					i += baseCaseDao.updateBaseCase(bc2);
				}
				bc.setSort(bc.getSort() + 1);
				i += baseCaseDao.updateBaseCase(bc);
			}
			return i;
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public BaseCaseDAO getBaseCaseDao() {
		return baseCaseDao;
	}

	public void setBaseCaseDao(BaseCaseDAO baseCaseDao) {
		this.baseCaseDao = baseCaseDao;
	}

	public CasePageDAO getCasePageDao() {
		return casePageDao;
	}

	public void setCasePageDao(CasePageDAO casePageDao) {
		this.casePageDao = casePageDao;
	}

	public CaseDataDAO getCaseDataDao() {
		return caseDataDao;
	}

	public void setCaseDataDao(CaseDataDAO caseDataDao) {
		this.caseDataDao = caseDataDao;
	}

}
