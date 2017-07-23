package com.cd.autoTest.action;

import java.util.Date;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import com.cd.autoTest.model.Strategy;
import com.cd.autoTest.model.User;
import com.cd.autoTest.service.StrategyService;
import com.opensymphony.xwork2.Action;

public class StrategyAction extends BaseAction{
	private StrategyService strategyService;
	private Strategy strategy;
	private String caseIds;
	private int strategyId;
	public String initStrategy(){
		return Action.SUCCESS;
	}
	public void findStrategyList(){
		try{
			strategy.initPage(request);
			List<Strategy> strategyList=strategyService.findStrategyList(strategy);
			int size=strategyService.findStrategyCount(strategy);
			JSONArray json = new JSONArray();
			for (Strategy s : strategyList) {
				JSONObject jo = new JSONObject();
				jo.put("id", s.getId());
				jo.put("caseId", s.getCaseId());
				jo.put("caseName", s.getCaseName());
				jo.put("category", s.getCategory()==1?"定时":"每天");
				jo.put("categoryName", s.getCategoryName());
				jo.put("executeTime", s.getExecuteTime());
				jo.put("environmentId", s.getEnvironmentId());
				jo.put("environmentName", s.getEnvironmentName());
				jo.put("screenShot", s.getScreenShot()==1?"截图":"不截图");
				jo.put("userId", s.getUserId());
				jo.put("userName", s.getUserName());
				json.put(jo);
			}
			this.WriteJson(size, json);
		}catch(Exception e){
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}
	public void insertStrategy()
	{
		try{
			String[] arr=caseIds.split(",");
			User user=(User)request.getSession().getAttribute("user");
			int i=0;
			for(String caseId:arr){
				strategy.setCaseId(Integer.valueOf(caseId));
				strategy.setUserId(user.getId());
				Date date=new Date();
				strategy.setUpdateTime(date);
				i+=strategyService.insertStrategy(strategy);
			}
			this.WriteInteger(i);
		}catch(Exception e){
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}
	public void deleteStrategy(){
		try{
			int i=strategyService.deleteStrategy(strategyId);
			this.WriteInteger(i);
		}catch(Exception e)
		{
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}
	public StrategyService getStrategyService() {
		return strategyService;
	}
	public void setStrategyService(StrategyService strategyService) {
		this.strategyService = strategyService;
	}
	public Strategy getStrategy() {
		return strategy;
	}
	public void setStrategy(Strategy strategy) {
		this.strategy = strategy;
	}
	public String getCaseIds() {
		return caseIds;
	}
	public void setCaseIds(String caseIds) {
		this.caseIds = caseIds;
	}
	public int getStrategyId() {
		return strategyId;
	}
	public void setStrategyId(int strategyId) {
		this.strategyId = strategyId;
	}
	
}
