package com.cd.autoTest.action;

import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import com.cd.autoTest.model.Element;
import com.cd.autoTest.service.ElementService;
import com.opensymphony.xwork2.Action;

public class ElementAction extends BaseAction {
	private ElementService elementService;
	private Element element;
	private int pageId;

	public String initElement() {
		return Action.SUCCESS;
	}

	public void findElementListByPageId() {

		try {
			element.initPage(request);
			List<Element> elementList = elementService.findElementListByPageId(element);
			int size = elementService.findElementCount(element);
			JSONArray json = new JSONArray();
			for (Element element : elementList) {
				JSONObject jo = new JSONObject();
				jo.put("id", element.getId());
				jo.put("name", element.getName());
				jo.put("xpath", element.getXpath());
				jo.put("isCompare", element.getIsCompare());
				jo.put("contextKey", element.getContextKey());
				json.put(jo);
			}
			this.WriteJson(size, json);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public void deleteElement() {
		int id = Integer.parseInt(request.getParameter("id"));
		int i = elementService.deleteElement(id);

		this.WriteInteger(i);
	}

	public void findElementById() {
		try{
			int id = Integer.parseInt(request.getParameter("id"));
			Element element =elementService.findElementById(id);
			JSONObject jo = new JSONObject();
			jo.put("id", element.getId());
			jo.put("name", element.getName());
			jo.put("xpath", element.getXpath());
			jo.put("isCompare", element.getIsCompare());
			jo.put("contextKey", element.getContextKey());
			this.WriteJson(jo);
		}catch(Exception e){
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
		
	}
	public void updateElement(){
		int i=elementService.updateElement(element);
		this.WriteInteger(i);
	}
	public void insertElement(){
		int i=elementService.insertElement(element);
		this.WriteInteger(i);
	}
	public int getPageId() {
		return pageId;
	}

	public void setPageId(int pageId) {
		this.pageId = pageId;
	}

	

	public ElementService getElementService() {
		return elementService;
	}

	public void setElementService(ElementService elementService) {
		this.elementService = elementService;
	}

	public Element getElement() {
		return element;
	}

	public void setElement(Element element) {
		this.element = element;
	}

}
