package com.cd.autoTest.socket;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.TimerTask;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.cd.autoTest.model.RunCaseResult;
import com.cd.autoTest.model.Strategy;
import com.cd.autoTest.service.RunCaseResultService;
import com.cd.autoTest.service.StrategyService;

public class CaseStrategyTask extends TimerTask {
	ApplicationContext ac;
	@Override
	public void run() {
		// TODO Auto-generated method stub
		if(ac==null){
			ac = new ClassPathXmlApplicationContext("applicationContext.xml");
		}
		this.insertStrategyToRunCaseResult();
	}
	public void insertStrategyToRunCaseResult(){
		StrategyService strategyService=(StrategyService)ac.getBean("strategyService");
		RunCaseResultService runCaseResultService=(RunCaseResultService) ac.getBean("runCaseResultService");
		Date date=new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String currentTime=sdf.format(date.getTime());
		List<Strategy> strategyList=strategyService.findStrategyListByExecuteTime(currentTime);
		for(Strategy strategy : strategyList){
			RunCaseResult runCaseResult=this.getRunCaseResult(strategy);
			runCaseResultService.insertRunCaseResult(runCaseResult);
		}
		sdf = new SimpleDateFormat("HH:mm");
		currentTime=sdf.format(date.getTime());
		strategyList=strategyService.findStrategyListByExecuteTime(currentTime);
		for(Strategy strategy : strategyList){
			RunCaseResult runCaseResult=this.getRunCaseResult(strategy);
			runCaseResultService.insertRunCaseResult(runCaseResult);
		}
	}
	public RunCaseResult getRunCaseResult(Strategy strategy)
	{
		RunCaseResult runCaseResult=new RunCaseResult();
		runCaseResult.setCaseId(strategy.getCaseId());
		runCaseResult.setEnvironmentId(strategy.getEnvironmentId());
		runCaseResult.setScreenShot(strategy.getScreenShot());
		runCaseResult.setUpdateUser(strategy.getUserId());
		runCaseResult.setInsertUser(strategy.getUserId());
		Date date=new Date();
		runCaseResult.setUpdateTime(date);
		runCaseResult.setInsertTime(date);
		return runCaseResult;
	}
}
