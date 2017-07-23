package com.cd.autoTest.dao;

import java.util.List;

import com.cd.autoTest.model.Strategy;

public interface StrategyDAO {
	List<Strategy> findStrategyList(Strategy strategy);
	List<Strategy> findStrategyListByExecuteTime(String executeTime);
	int deleteStrategy(int id);
	Strategy findStrategyById(int id);
	int insertStrategy(Strategy strategy);
	int updateStrategy(Strategy strategy);
	int findStrategyCount(Strategy strategy);
}
