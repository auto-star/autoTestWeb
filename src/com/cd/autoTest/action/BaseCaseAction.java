package com.cd.autoTest.action;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import com.cd.autoTest.model.ActionInfo;
import com.cd.autoTest.model.BaseCase;
import com.cd.autoTest.model.Case;
import com.cd.autoTest.model.CaseData;
import com.cd.autoTest.model.CasePage;
import com.cd.autoTest.model.DataMap;
import com.cd.autoTest.model.DataMapCollection;
import com.cd.autoTest.model.Group;
import com.cd.autoTest.model.Page;
import com.cd.autoTest.model.Project;
import com.cd.autoTest.model.User;
import com.cd.autoTest.service.ActionService;
import com.cd.autoTest.service.BaseCaseService;
import com.cd.autoTest.service.CaseDataService;
import com.cd.autoTest.service.CasePageService;
import com.cd.autoTest.service.CaseService;
import com.cd.autoTest.service.DataMapCollectionService;
import com.cd.autoTest.service.DataMapService;
import com.cd.autoTest.service.GroupService;
import com.cd.autoTest.service.PageService;
import com.cd.autoTest.service.ProjectService;
import com.opensymphony.xwork2.Action;

public class BaseCaseAction extends BaseAction {
	private CaseService caseService;
	private BaseCaseService baseCaseService;
	private GroupService groupService;
	private ProjectService projectService;
	private CasePageService casePageService;
	private CaseDataService caseDataService;
	private DataMapService dataMapService;
	private ActionService actionService;
	private DataMapCollectionService dataMapCollectionService;
	private PageService pageService;
	private List<Group> groupList;
	private List<Project> projectList;
	private List<CasePage> casePageList;
	private Case executeCase;
	private BaseCase baseCase;
	private CasePage casePage;
	private Page page;
	private int baseCaseId;
	private int caseId;
	private int projectId;
	private int casePageId;
	private int parentGroupId;

	public String initBaseCase() {
		executeCase = caseService.findCaseById(caseId);
		projectList = projectService.findProjectList();
		return Action.SUCCESS;
	}

	public void findBaseCaseList() {
		try {
			if(baseCase.getCaseId()>0){
				baseCase.setUserId(0);
			}
			List<BaseCase> baseCaseList = baseCaseService.findBaseCaseList(baseCase);
			JSONArray json = new JSONArray();
			for (BaseCase bc : baseCaseList) {
				JSONObject jo = new JSONObject();
				jo.put("id", bc.getId());
				jo.put("name", bc.getName());
				jo.put("comment", bc.getComment());
				jo.put("groupId", bc.getGroupId());
				jo.put("groupName", bc.getGroupName());
				jo.put("parentGroupName", bc.getParentGroupName());
				jo.put("projectId", bc.getProjectId());
				jo.put("projectName", bc.getProjectName());
				jo.put("userName", bc.getUserName());
				jo.put("status", bc.getStatus() == 1 ? "关闭" : "打开");
				jo.put("caseId", bc.getCaseId());
				jo.put("sort", bc.getSort());
				jo.put("kind", bc.getKind()==1?"前台":"后台");
				jo.put("userId", bc.getUserId());
				json.put(jo);
			}
			this.WriteJson(baseCaseList.size(), json);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public void findGroupList() {
		try {
			Group g2 = new Group();
			g2.setProjectId(projectId);
			g2.setParentGroupId(parentGroupId);
			List<Group> groupList = groupService.findGroupList(g2);
			JSONArray json = new JSONArray();
			for (Group g : groupList) {
				JSONObject jo = new JSONObject();
				jo.put("id", g.getId());
				jo.put("name", g.getName());
				json.put(jo);
			}
			this.WriteJson(groupList.size(), json);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public void findPageList() {
		try {
			List<Page> pageList = pageService.findPageList(page);
			JSONArray json = new JSONArray();
			for (Page page : pageList) {
				JSONObject jo = new JSONObject();
				jo.put("id", page.getId());
				jo.put("title", page.getTitle());
				json.put(jo);
			}
			this.WriteJson(pageList.size(), json);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public void findCasePageList() {
		try {
			casePageList = casePageService.findParentCasePageListByBaseCaseId(baseCaseId);

			this.WriteJson(showCasePage(casePageList));
			baseCase = baseCaseService.findBaseCaseById(baseCaseId);
			projectList = projectService.findProjectList();
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	private JSONArray showCasePage(List<CasePage> casePageList) {
		try {
			JSONArray json = new JSONArray();
			for (CasePage cp : casePageList) {
				JSONObject jo = new JSONObject();
				jo.put("id", cp.getId());
				jo.put("pageId", cp.getPageId());
				jo.put("name", cp.getName());
				jo.put("comment", cp.getComment());
				jo.put("baseCaseId", baseCaseId);
				jo.put("sort", cp.getSort());
				jo.put("userId", cp.getUserId());
				jo.put("parentId", cp.getParentId());
				
				List<DataMap> dataMapList = dataMapService.findDataMapListByPageId(cp.getPageId());
				List<DataMap> lastDataMapList = new ArrayList<DataMap>();
				List<DataMap> tempDataMapList = new ArrayList<DataMap>();
				JSONArray jsonDataMap = new JSONArray();
				for (DataMap dataMap : dataMapList) {
					JSONObject joDataMap = new JSONObject();
					if (dataMap.getCategory() != 4) {
						joDataMap.put("id", dataMap.getId());
						joDataMap.put("category", dataMap.getCategory());
						joDataMap.put("actionId", dataMap.getActionId());
						joDataMap.put("pageId", dataMap.getPageId());
						joDataMap.put("sort", dataMap.getSort());
						joDataMap.put("refPageId", dataMap.getRefPageId());
						
						
						CaseData cd = new CaseData();
						cd.setCasePageId(cp.getId());
						cd.setDataMapId(dataMap.getId());
						cd = caseDataService.findCaseData(cd);
						JSONObject joCaseData = new JSONObject();
						joCaseData.put("id", cd.getId());
						joCaseData.put("category", cd.getCategory());
						joCaseData.put("dataValue", cd.getDataValue()==null?"":cd.getDataValue());
						joCaseData.put("dataMapId", cd.getDataMapId());
						joCaseData.put("casePageId", cd.getCasePageId());
						joCaseData.put("sort", cd.getSort());
						joDataMap.put("caseData", joCaseData);
						
						JSONObject joAction = new JSONObject();
						ActionInfo action = actionService.findActionById(dataMap.getActionId());
						joAction.put("id", action.getId());
						joAction.put("name", action.getName());
						joAction.put("elementName", action.getElementName());
						joAction.put("elementXpath", action.getElementXpath());
						joAction.put("commandCategory", action.getCommandCategory());
						joAction.put("commandName", action.getCommandName());
						joAction.put("contextKey", action.getContextKey());
						joAction.put("valueCategory", action.getValueCategory());
						joAction.put("defaultValue", action.getDefaultValue());
						joAction.put("sort", action.getSort());
						joAction.put("pageId", action.getPageId());
						cd.setAction(action);
						joDataMap.put("action", joAction);
						
						JSONArray jsonDataMapCollection = new JSONArray();
						List<DataMapCollection> dataMapCollectionList = dataMapCollectionService.findDataMapCollectionListByDataMapId(cd.getDataMapId());
						for(DataMapCollection dataMapCollection :dataMapCollectionList){
							JSONObject joDataMapCollection = new JSONObject();
							joDataMapCollection.put("id", dataMapCollection.getId());
							joDataMapCollection.put("value", dataMapCollection.getValue());
							joDataMapCollection.put("name", dataMapCollection.getName());
							joDataMapCollection.put("dataMapId", dataMapCollection.getDataMapId());
							joDataMapCollection.put("sort", dataMapCollection.getSort());
							jsonDataMapCollection.put(joDataMapCollection);
						}
						joDataMap.put("dataMapCollection", jsonDataMapCollection);
						cd.setDataMapCollectionList(dataMapCollectionList);
						
						dataMap.setCaseData(cd);
						lastDataMapList.add(dataMap);
						
						jsonDataMap.put(joDataMap);
					} else {
						tempDataMapList.add(dataMap);
					}

				}
				
				for (DataMap dataMap : tempDataMapList) {
					JSONObject joDataMap = new JSONObject();
					joDataMap.put("id", dataMap.getId());
					joDataMap.put("category", dataMap.getCategory());
					joDataMap.put("actionId", dataMap.getActionId());
					joDataMap.put("pageId", dataMap.getPageId());
					joDataMap.put("sort", dataMap.getSort());
					joDataMap.put("refPageId", dataMap.getRefPageId());
					
					JSONObject joCaseData = new JSONObject();
					joDataMap.put("caseData", joCaseData);
					
					JSONObject joAction = new JSONObject();
					ActionInfo action = actionService.findActionById(dataMap.getActionId());
					joAction.put("id", action.getId());
					joAction.put("name", action.getName());
					joAction.put("elementName", action.getElementName());
					joAction.put("elementXpath", action.getElementXpath());
					joAction.put("commandCategory", action.getCommandCategory());
					joAction.put("commandName", action.getCommandName());
					joAction.put("contextKey", action.getContextKey());
					joAction.put("valueCategory", action.getValueCategory());
					joAction.put("defaultValue", action.getDefaultValue());
					joAction.put("sort", action.getSort());
					joAction.put("pageId", action.getPageId());
					joDataMap.put("action", joAction);
					
					jsonDataMap.put(joDataMap);
					
					JSONArray jsonDataMapCollection = new JSONArray();
					joDataMap.put("dataMapCollection", jsonDataMapCollection);
					lastDataMapList.add(dataMap);
					
				}
				List<CasePage> childCasePageList = casePageService.findChildCasePageListByParentId(cp.getId());
				jo.put("childCasePageList", showCasePage(childCasePageList));;
				jo.put("dataMapList", jsonDataMap);
				cp.setDataMapList(dataMapList);
				json.put(jo);
			}
			return json;
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}
	private JSONObject showDataMap(DataMap dataMap){
		JSONObject joDataMap = new JSONObject();
		return joDataMap;
	}
	public String initBaseCaseDetail() {
		try {
			baseCase = baseCaseService.findBaseCaseById(baseCaseId);
			projectList = projectService.findProjectList();
			return Action.SUCCESS;
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}

	}

	public void findBaseCaseListByCaseId() {
		try {
			List<BaseCase> baseCaseList = baseCaseService.findBaseCaseListByCaseId(caseId);
			JSONArray json = new JSONArray();
			for (BaseCase bc : baseCaseList) {
				JSONObject jo = new JSONObject();
				jo.put("id", bc.getId());
				jo.put("name", bc.getName());
				jo.put("comment", bc.getComment());
				jo.put("groupId", bc.getGroupId());
				jo.put("groupName", bc.getGroupName());
				jo.put("parentGroupName", bc.getParentGroupName());
				jo.put("projectId", bc.getProjectId());
				jo.put("projectName", bc.getProjectName());
				jo.put("userName", bc.getUserName());
				jo.put("status", bc.getStatus() == 1 ? "关闭" : "打开");
				jo.put("caseId", bc.getCaseId());
				jo.put("sort", bc.getSort());
				jo.put("kind", baseCase.getKind()==1?"前台":"后台");
				jo.put("userId", bc.getUserId());
				json.put(jo);
			}
			this.WriteJson(baseCaseList.size(), json);

		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public void insertCasePage() {
		int userId = Integer.parseInt(request.getSession().getAttribute("userId").toString());
		casePage.setUserId(userId);
		int i = casePageService.insertCasePage(casePage, casePageId);
		this.WriteInteger(i);
	}

	public void insertBaseCase() {
		this.insertBaseCaseCommon(caseId);
	}

	public void insertBaseCaseCommon(int id) {
		User user = (User) request.getSession().getAttribute("user");
		baseCase.setCaseId(id);
		baseCase.setUserId(user.getId());
		int maxSort = baseCaseService.findMaxSort(id);
		if (id > 0) {
			baseCase.setSort(maxSort + 1);
		} else {
			baseCase.setSort(0);
		}
		int i = baseCaseService.insertBaseCase(baseCase, baseCaseId);
		this.WriteInteger(i);
	}

	public void copyBaseCase() {
		BaseCase formerBaseCase = baseCaseService.findBaseCaseById(baseCaseId);
		baseCase = new BaseCase();
		baseCase.setName(formerBaseCase.getName() + "_copy");
		baseCase.setComment(formerBaseCase.getComment());
		baseCase.setGroupId(formerBaseCase.getGroupId());
		baseCase.setProjectId(formerBaseCase.getProjectId());
		baseCase.setKind(formerBaseCase.getKind());
		this.insertBaseCaseCommon(0);
	}

	public void deleteBaseCase() {
		int i = baseCaseService.deleteBaseCase(baseCaseId);
		this.WriteInteger(i);
	}

	public void updateCaseData() {
		String jsonStr = request.getParameter("dataJson");
		int i = caseDataService.updateCaseData(jsonStr);
		this.WriteInteger(i);
	}

	public void updateBaseCaseSort() {
		try {
			int option = Integer.parseInt(request.getParameter("option"));
			int i = baseCaseService.updateBaseCaseSort(caseId, baseCaseId, option);
			this.WriteInteger(i);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public void findBaseCaseById() {
		try {
			baseCase = baseCaseService.findBaseCaseById(baseCaseId);
			JSONArray json = new JSONArray();
			JSONObject jo = new JSONObject();
			jo.put("id", baseCase.getId());
			jo.put("name", baseCase.getName());
			jo.put("comment", baseCase.getComment());
			jo.put("groupId", baseCase.getGroupId());
			jo.put("parentGroupId", baseCase.getParentGroupId());
			jo.put("projectId", baseCase.getProjectId());
			jo.put("status", baseCase.getStatus());
			jo.put("kind", baseCase.getKind());
			json.put(jo);
			this.WriteJson(1, json);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public void updateBaseCase() {
		int i = baseCaseService.updateBaseCase(baseCase);
		this.WriteInteger(i);
	}

	public void deleteCasePage() {
		int i = casePageService.deleteCasePage(casePageId);
		this.WriteInteger(i);
	}

	public void findPageById() {
		int id = Integer.parseInt(request.getParameter("id"));
		page = pageService.findPageById(id);
		JSONObject jsonObject = new JSONObject();
		try {
			jsonObject.put("id", page.getId());
			jsonObject.put("code", page.getCode());
			jsonObject.put("title", page.getTitle());
			jsonObject.put("comment", page.getComment());
			jsonObject.put("groupId", page.getGroupId());
			jsonObject.put("parentGroupId", page.getParentGroupId());
			jsonObject.put("projectId", page.getProjectId());
			this.WriteJson(jsonObject);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public BaseCase getBaseCase() {
		return baseCase;
	}

	public void setBaseCase(BaseCase baseCase) {
		this.baseCase = baseCase;
	}

	public int getBaseCaseId() {
		return baseCaseId;
	}

	public void setBaseCaseId(int baseCaseId) {
		this.baseCaseId = baseCaseId;
	}

	public GroupService getGroupService() {
		return groupService;
	}

	public void setGroupService(GroupService groupService) {
		this.groupService = groupService;
	}

	public ProjectService getProjectService() {
		return projectService;
	}

	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}

	public List<Group> getGroupList() {
		return groupList;
	}

	public void setGroupList(List<Group> groupList) {
		this.groupList = groupList;
	}

	public List<Project> getProjectList() {
		return projectList;
	}

	public void setProjectList(List<Project> projectList) {
		this.projectList = projectList;
	}

	public CasePageService getCasePageService() {
		return casePageService;
	}

	public void setCasePageService(CasePageService casePageService) {
		this.casePageService = casePageService;
	}

	public CasePage getCasePage() {
		return casePage;
	}

	public void setCasePage(CasePage casePage) {
		this.casePage = casePage;
	}

	public CaseDataService getCaseDataService() {
		return caseDataService;
	}

	public void setCaseDataService(CaseDataService caseDataService) {
		this.caseDataService = caseDataService;
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

	public int getCaseId() {
		return caseId;
	}

	public void setCaseId(int caseId) {
		this.caseId = caseId;
	}

	public BaseCaseService getBaseCaseService() {
		return baseCaseService;
	}

	public void setBaseCaseService(BaseCaseService baseCaseService) {
		this.baseCaseService = baseCaseService;
	}

	public Case getExecuteCase() {
		return executeCase;
	}

	public void setExecuteCase(Case executeCase) {
		this.executeCase = executeCase;
	}

	public CaseService getCaseService() {
		return caseService;
	}

	public void setCaseService(CaseService caseService) {
		this.caseService = caseService;
	}

	public PageService getPageService() {
		return pageService;
	}

	public void setPageService(PageService pageService) {
		this.pageService = pageService;
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}

	public List<CasePage> getCasePageList() {
		return casePageList;
	}

	public void setCasePageList(List<CasePage> casePageList) {
		this.casePageList = casePageList;
	}

	public ActionService getActionService() {
		return actionService;
	}

	public void setActionService(ActionService actionService) {
		this.actionService = actionService;
	}

	public int getProjectId() {
		return projectId;
	}

	public void setProjectId(int projectId) {
		this.projectId = projectId;
	}

	public int getCasePageId() {
		return casePageId;
	}

	public void setCasePageId(int casePageId) {
		this.casePageId = casePageId;
	}

	public int getParentGroupId() {
		return parentGroupId;
	}

	public void setParentGroupId(int parentGroupId) {
		this.parentGroupId = parentGroupId;
	}

}
