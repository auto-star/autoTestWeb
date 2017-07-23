package com.cd.autoTest.dao;

import java.util.List;

import com.cd.autoTest.model.RunCaseResult;

public interface RunCaseResultDAO {
	List<RunCaseResult> findRunCaseResultList(RunCaseResult runCaseResult);
	int deleteRunCaseResult(int id);
	RunCaseResult findRunCaseResultById(int id);
	RunCaseResult findRunCaseResult();
	RunCaseResult findRunCaseResultByIp(String ip);
	int insertRunCaseResult(RunCaseResult runCaseResult);
	int updateRunCaseResult(RunCaseResult runCaseResult);
	int updateRunCaseResultIpAndStatus(RunCaseResult runCaseResult);
	int findRunCaseResultCount(RunCaseResult runCaseResult);
}
