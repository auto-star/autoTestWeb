package com.cd.autoTest.service;

import java.util.List;

import com.cd.autoTest.dao.RunCaseResultDAO;
import com.cd.autoTest.model.RunCaseResult;

public class RunCaseResultService {
	private RunCaseResultDAO runCaseResultDao;

	public List<RunCaseResult> findRunCaseResultList(RunCaseResult runCaseResult) {
		return runCaseResultDao.findRunCaseResultList(runCaseResult);
	}

	public int deleteRunCaseResult(int id) {
		return runCaseResultDao.deleteRunCaseResult(id);
	}

	public RunCaseResult findRunCaseResultById(int id) {
		return runCaseResultDao.findRunCaseResultById(id);
	}

	public RunCaseResult findRunCaseResult() {
		return runCaseResultDao.findRunCaseResult();
	}
	public RunCaseResult findRunCaseResultByIp(String ip){
		return runCaseResultDao.findRunCaseResultByIp(ip);
	}
	public int insertRunCaseResult(RunCaseResult runCaseResult) {
		return runCaseResultDao.insertRunCaseResult(runCaseResult);
	}

	public int updateRunCaseResult(RunCaseResult runCaseResult) {
		return runCaseResultDao.updateRunCaseResult(runCaseResult);
	}

	public int updateRunCaseResultIpAndStatus(RunCaseResult runCaseResult) {
		return runCaseResultDao.updateRunCaseResultIpAndStatus(runCaseResult);
	}

	public RunCaseResultDAO getRunCaseResultDao() {
		return runCaseResultDao;
	}

	public void setRunCaseResultDao(RunCaseResultDAO runCaseResultDao) {
		this.runCaseResultDao = runCaseResultDao;
	}
	public int findRunCaseResultCount(RunCaseResult runCaseResult)
	{
		return runCaseResultDao.findRunCaseResultCount(runCaseResult);
	}
}
