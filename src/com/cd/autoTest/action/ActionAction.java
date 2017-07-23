package com.cd.autoTest.action;

import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import com.cd.autoTest.model.ActionInfo;
import com.cd.autoTest.model.DataMap;
import com.cd.autoTest.model.DataMapCollection;
import com.cd.autoTest.model.Page;
import com.cd.autoTest.service.ActionService;
import com.cd.autoTest.service.CaseDataService;
import com.cd.autoTest.service.CasePageService;
import com.cd.autoTest.service.DataMapCollectionService;
import com.cd.autoTest.service.DataMapService;
import com.cd.autoTest.service.PageService;
import com.opensymphony.xwork2.Action;

public class ActionAction extends BaseAction {
	private ActionService actionService;
	private DataMapService dataMapService;
	private CasePageService casePageService;
	private DataMapCollectionService dataMapCollectionService;
	private CaseDataService caseDataService;
	private PageService pageService;
	private ActionInfo action;
	private Page page;
	private int pageId;
	private int actionId;
	private String jsonDataMapCollection;

	public String initAction() {
		page = pageService.findPageById(pageId);
		return Action.SUCCESS;
	}

	public void findActionList() {

		try {
			List<ActionInfo> actionList = actionService.findActionList(action);
			JSONArray json = new JSONArray();
			for (ActionInfo action : actionList) {
				JSONObject jo = new JSONObject();
				jo.put("id", action.getId());
				jo.put("name", action.getName());
				jo.put("elementName", action.getElementName());
				jo.put("actionCategory", action.getActionCategory());
				jo.put("actionCategoryName", getActionCategory(action.getActionCategory()));
				jo.put("elementXpath", action.getElementXpath());
				jo.put("commandCategory", action.getCommandCategory());
				jo.put("commandCategoryName", getCommandCategory(action.getCommandCategory()));
				jo.put("commandName", action.getCommandName());
				jo.put("contextKey", action.getContextKey());
				jo.put("valueCategory", action.getValueCategory());
				jo.put("valueCategoryName", getValueCategory(action.getValueCategory()));
				jo.put("defaultValue", action.getDefaultValue());
				jo.put("sort", action.getSort());
				jo.put("pageId", action.getPageId());
				List<ActionInfo> childActionList = actionService.findChildActionListByParentActionId(action.getId());
				if (childActionList.size() > 0) {
					jo.put("childActionList", findChildActionListByParentActionId(childActionList));
				}
				json.put(jo);
			}
			this.WriteJson(json);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public JSONArray findChildActionListByParentActionId(List<ActionInfo> actionList) {
		try {
			JSONArray json = new JSONArray();
			for (ActionInfo action : actionList) {
				JSONObject jo = new JSONObject();
				jo.put("id", action.getId());
				jo.put("name", action.getName());
				jo.put("elementName", action.getElementName());
				jo.put("actionCategory", getActionCategory(action.getActionCategory()));
				jo.put("actionCategoryName", getActionCategory(action.getActionCategory()));
				jo.put("elementXpath", action.getElementXpath());
				jo.put("commandCategory", action.getCommandCategory());
				jo.put("commandCategoryName", getCommandCategory(action.getCommandCategory()));
				jo.put("commandName", action.getCommandName());
				jo.put("contextKey", action.getContextKey());
				jo.put("valueCategory", action.getValueCategory());
				jo.put("valueCategoryName", getValueCategory(action.getValueCategory()));
				jo.put("defaultValue", action.getDefaultValue());
				jo.put("sort", action.getSort());
				jo.put("pageId", action.getPageId());
				List<ActionInfo> childActionList = actionService.findChildActionListByParentActionId(action.getId());
				if (childActionList.size() > 0) {
					jo.put("childActionList", findChildActionListByParentActionId(childActionList));
				}
				json.put(jo);
			}
			return json;
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	private String getActionCategory(int actionCategory) {
		String actionCategoryName = "";
		switch (actionCategory) {
		case 1:
			actionCategoryName = "输入型";
			break;
		case 2:
			actionCategoryName = "多选操作型";
			break;
		case 3:
			actionCategoryName = "选择型";
			break;
		case 4:
			actionCategoryName = "动作型";
			break;
		}
		return actionCategoryName;
	}
	private String getCommandCategory(int commandCategory) {
		String commandCategoryName = "";
		switch (commandCategory) {
		case 1:
			commandCategoryName = "html";
			break;
		case 2:
			commandCategoryName = "logical";
			break;
		case 3:
			commandCategoryName = "function";
			break;
		}
		return commandCategoryName;
	}
	private String getValueCategory(int commandCategory) {
		String valueCategoryName = "";
		switch (commandCategory) {
		case 1:
			valueCategoryName = "静态值";
			break;
		case 2:
			valueCategoryName = "内存值";
			break;
		case 3:
			valueCategoryName = "动态生成值";
			break;
		}
		return valueCategoryName;
	}
	public void findActionById() {
		try {
			action = actionService.findActionById(actionId);
			DataMap dataMap = dataMapService.findDataMapByActionId(action.getId());

			JSONArray json = new JSONArray();
			JSONObject jo = new JSONObject();
			jo.put("id", action.getId());
			jo.put("name", action.getName());
			jo.put("elementName", action.getElementName());
			jo.put("actionCategory", action.getActionCategory());
			jo.put("elementXpath", action.getElementXpath());
			jo.put("commandCategory", action.getCommandCategory());
			jo.put("commandName", action.getCommandName());
			jo.put("contextKey", action.getContextKey());
			jo.put("valueCategory", action.getValueCategory());
			jo.put("defaultValue", action.getDefaultValue());
			jo.put("sort", action.getSort());
			jo.put("pageId", action.getPageId());
			JSONObject jo2 = new JSONObject();
			if (dataMap != null) {
				List<DataMapCollection> dataMapCollectionList = dataMapCollectionService
						.findDataMapCollectionListByDataMapId(dataMap.getId());
				for (DataMapCollection dataMapCollection : dataMapCollectionList) {
					jo2.put(dataMapCollection.getValue(), dataMapCollection.getName());
				}
				jo.put("dataMapCollection", jo2.toString());
			}

			json.put(jo);
			this.WriteJson(1, json);
		} catch (Exception e) {
			log.info(e.getMessage(), e.getCause());
			throw new RuntimeException(e.toString());
		}
	}

	public void insertAction() {
		Integer actionSort = 0;
		// 此actionId为插入action之前的那个action的id
		if (actionId > 0 && action.getParentActionId() >= 0) {
			ActionInfo ai = actionService.findActionById(actionId);
			actionSort = ai.getSort();
			actionService.updateActionSort(ai);
		} else if (actionId == 0 && action.getParentActionId() > 0) {
			actionSort = actionService.findMaxSortByParentActionId(action.getParentActionId());
		} else {
			actionSort = actionService.findMaxSort(action.getPageId());
		}
		action.setSort(++actionSort);
		int i = actionService.insertAction(action, jsonDataMapCollection);
		this.WriteInteger(i);
	}

	public void deleteAction() {
		int i = actionService.deleteAction(actionId);
		this.WriteInteger(i);
	}

	public void updateAction() {
		int i = actionService.updateAction(action, jsonDataMapCollection);
		this.WriteInteger(i);
	}

	public void deleteCheckAction() {
		String[] actionIdArr = request.getParameterValues("actionIdArr[]");
		int i = 0;
		for (String ai : actionIdArr) {
			i += actionService.deleteAction(Integer.parseInt(ai));
		}
		this.WriteInteger(i);
	}

	public ActionService getActionService() {
		return actionService;
	}

	public void setActionService(ActionService actionService) {
		this.actionService = actionService;
	}

	public int getPageId() {
		return pageId;
	}

	public void setPageId(int pageId) {
		this.pageId = pageId;
	}

	public ActionInfo getAction() {
		return action;
	}

	public void setAction(ActionInfo action) {
		this.action = action;
	}

	public DataMapService getDataMapService() {
		return dataMapService;
	}

	public void setDataMapService(DataMapService dataMapService) {
		this.dataMapService = dataMapService;
	}

	public DataMapCollectionService getDataMapCollectionService() {
		return dataMapCollectionService;
	}

	public void setDataMapCollectionService(DataMapCollectionService dataMapCollectionService) {
		this.dataMapCollectionService = dataMapCollectionService;
	}

	public CasePageService getCasePageService() {
		return casePageService;
	}

	public void setCasePageService(CasePageService casePageService) {
		this.casePageService = casePageService;
	}

	public CaseDataService getCaseDataService() {
		return caseDataService;
	}

	public void setCaseDataService(CaseDataService caseDataService) {
		this.caseDataService = caseDataService;
	}

	public int getActionId() {
		return actionId;
	}

	public void setActionId(int actionId) {
		this.actionId = actionId;
	}

	public PageService getPageService() {
		return pageService;
	}

	public void setPageService(PageService pageService) {
		this.pageService = pageService;
	}

	public String getJsonDataMapCollection() {
		return jsonDataMapCollection;
	}

	public void setJsonDataMapCollection(String jsonDataMapCollection) {
		this.jsonDataMapCollection = jsonDataMapCollection;
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}

}
