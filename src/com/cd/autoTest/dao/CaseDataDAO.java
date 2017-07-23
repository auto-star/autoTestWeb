package com.cd.autoTest.dao;

import java.util.List;

import com.cd.autoTest.model.CaseData;

public interface CaseDataDAO {
	List<CaseData> findCaseDataListByCasePageId(int caseScriptId);
	CaseData findCaseData(CaseData caseData);
	int insertCaseData(CaseData caseData);
	int findMaxSort(int casePageId);
	int deleteCaseDataByCasePageId(int casePageId);
	int updateCaseData(CaseData caseData);
	int deleteCaseDataByDataMapId(int dataMapId);
	int updateCaseDataSortMinus(int dataMapId);
	int updateCaseDataSortAdd(int dataMapId);
}
