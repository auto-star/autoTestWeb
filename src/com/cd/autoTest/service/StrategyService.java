package com.cd.autoTest.service;

import java.util.List;

import com.cd.autoTest.dao.StrategyDAO;
import com.cd.autoTest.model.Strategy;

public class StrategyService extends IService {
	private StrategyDAO strategyDao;

	public List<Strategy> findStrategyList(Strategy strategy) {
		return strategyDao.findStrategyList(strategy);
	}

	public int deleteStrategy(int id) {
		try {
			return strategyDao.deleteStrategy(id);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public Strategy findStrategyById(int id) {
		return strategyDao.findStrategyById(id);
	}

	public int insertStrategy(Strategy strategy) {
		try {
			return strategyDao.insertStrategy(strategy);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public int updateStrategy(Strategy strategy) {
		try {
			return strategyDao.updateStrategy(strategy);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public List<Strategy> findStrategyListByExecuteTime(String executeTime) {
		return strategyDao.findStrategyListByExecuteTime(executeTime);
	}
	public int findStrategyCount(Strategy strategy){
		return strategyDao.findStrategyCount(strategy);
	}
	public StrategyDAO getStrategyDao() {
		return strategyDao;
	}

	public void setStrategyDao(StrategyDAO strategyDao) {
		this.strategyDao = strategyDao;
	}

}
