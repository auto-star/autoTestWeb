package com.cd.autoTest.dao;

import java.util.List;

import com.cd.autoTest.model.BaseCase;


public interface BaseCaseDAO {
	List<BaseCase> findBaseCaseListByCaseId(int caseId);
	BaseCase findBaseCaseById(int id);
	List<BaseCase> findBaseCaseList(BaseCase baseCase);
	int insertBaseCase(BaseCase baseCase);
	int deleteBaseCase(int id);
	int deleteBaseCaseByCaseId(int caseId);
	int updateBaseCase(BaseCase baseCase);
	BaseCase findBaseCase(BaseCase baseCase);
	int updateBaseCaseSortAdd(BaseCase baseCase);
	int updateBaseCaseSortMinus(BaseCase baseCase);
	int findMaxSort(int caseId);
}
