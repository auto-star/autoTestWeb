package com.cd.autoTest.dao;

import java.util.List;

import com.cd.autoTest.model.Case;

public interface CaseDAO {
	List<Case> findCaseList(Case c);
	Case findCaseById(int id);
	int insertCase(Case executeCase);
	int deleteCase(int id);
	int updateCase(Case executeCase);
	List<Case> findCaseListByUserId(int userId);
	int findCaseCount(Case executeCase);
}
