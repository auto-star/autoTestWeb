package com.cd.autoTest.action;

import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import com.cd.autoTest.model.DataMap;
import com.cd.autoTest.service.DataMapService;
import com.opensymphony.xwork2.Action;

public class DataMapAction extends BaseAction{
	private int pageId;
	private int dataMapId;
	private DataMapService dataMapService;
	private DataMap dataMap;
	public String initDataMap()
	{
		return Action.SUCCESS;
	}
	public void findDataMapListByPageId()
	{
		try
		{
			List<DataMap> dataMapList=dataMapService.findDataMapListByPageId(pageId);
			JSONArray json = new JSONArray();
			for (DataMap dataMap : dataMapList) {
				JSONObject jo = new JSONObject();
				jo.put("id", dataMap.getId());
				jo.put("code", dataMap.getCode());
				jo.put("category", getCategoryName(dataMap.getCategory()));
				jo.put("actionId", dataMap.getActionId());
				jo.put("pageId", dataMap.getPageId());
				jo.put("sort", dataMap.getSort());
				jo.put("elementName", dataMap.getElementName());
				jo.put("pageTitle", dataMap.getPageTitle());
				json.put(jo);
			}
			this.WriteJson(dataMapList.size(),json);
		}
		catch(Exception e)
		{
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}
	private String getCategoryName(int i){
		String s="";
		switch(i){
		case 1:
			s="输入框";
			break;
		case 2:
			s="选择框";
			break;
		case 3:
			s="选择框";
			break;
		case 4:
			s="超链接";
			break;
		}
		return s;
	}
	public void updateDataMapSort()
	{
		try{
			int option=Integer.parseInt(request.getParameter("option"));
			int i=dataMapService.updateDataMapSort(pageId,dataMapId,option);
			this.WriteInteger(i);
		}catch(Exception e)
		{
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}
	public void updateDataMapCode(){
		int i=dataMapService.updateDataMap(dataMap);
		this.WriteInteger(i);
	}
	public int getPageId() {
		return pageId;
	}
	public void setPageId(int pageId) {
		this.pageId = pageId;
	}
	public DataMapService getDataMapService() {
		return dataMapService;
	}
	public void setDataMapService(DataMapService dataMapService) {
		this.dataMapService = dataMapService;
	}
	public int getDataMapId() {
		return dataMapId;
	}
	public void setDataMapId(int dataMapId) {
		this.dataMapId = dataMapId;
	}
	public DataMap getDataMap() {
		return dataMap;
	}
	public void setDataMap(DataMap dataMap) {
		this.dataMap = dataMap;
	}
	
}
