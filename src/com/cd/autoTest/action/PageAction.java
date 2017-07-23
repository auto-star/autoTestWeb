package com.cd.autoTest.action;

import java.util.Date;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import com.cd.autoTest.model.Context;
import com.cd.autoTest.model.Group;
import com.cd.autoTest.model.Page;
import com.cd.autoTest.model.Project;
import com.cd.autoTest.model.User;
import com.cd.autoTest.service.ActionService;
import com.cd.autoTest.service.ContextService;
import com.cd.autoTest.service.DataMapCollectionService;
import com.cd.autoTest.service.DataMapService;
import com.cd.autoTest.service.GroupService;
import com.cd.autoTest.service.PageService;
import com.cd.autoTest.service.ProjectService;
import com.opensymphony.xwork2.Action;

public class PageAction extends BaseAction {
	private ActionService actionService;
	private PageService pageService;
	private GroupService groupService;
	private ProjectService projectService;
	private DataMapService dataMapService;
	private DataMapCollectionService dataMapCollectionService;
	private ContextService contextService;
	private List<Group> groupList;
	private List<Project> projectList;
	private Page page;
	private Context context;
	private int projectId;
	private int pageId;
	private int parentGroupId;
	private int contextId;

	public String execute() {
		return Action.SUCCESS;
	}

	public String initPage() {
		projectList = projectService.findProjectList();
		return Action.SUCCESS;
	}

	public void findPageList() {
		page.initPage(request);
		List<Page> pageList = pageService.findPageList(page);
		int size=pageService.findPageCount(page);
		try {
			JSONArray json = new JSONArray();
			for (Page page : pageList) {
				JSONObject jo = new JSONObject();
				jo.put("id", page.getId());
				jo.put("title", page.getTitle());
				jo.put("comment", page.getComment());
				jo.put("code", page.getCode());
				jo.put("groupName", page.getGroupName());
				jo.put("parentGroupName", page.getParentGroupName());
				jo.put("projectName", page.getProjectName());
				jo.put("isVisible", page.getIsVisible()==1?"可见":"不可见");
				json.put(jo);
			}
			this.WriteJson(size, json);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public void insertPage() {
		User user = (User) request.getSession().getAttribute("user");
		page.setInsertUser(user.getId());
		page.setUpdateUser(user.getId());
		Date date=new Date();
		page.setInsertTime(date);
		page.setUpdateTime(date);
		int i = pageService.insertPage(page);
		this.WriteInteger(page.getId());
	}

	public void copyPage() {
		User user = (User) request.getSession().getAttribute("user");
		int i = pageService.insertPage(page,user.getId());
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
			jsonObject.put("isVisible", page.getIsVisible());
			jsonObject.put("projectId", page.getProjectId());
			this.WriteJson(jsonObject);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public void updatePage() {
		User user = (User) request.getSession().getAttribute("user");
		page.setUpdateUser(user.getId());
		Date date=new Date();
		page.setUpdateTime(date);
		int i = pageService.updatePage(page);
		this.WriteInteger(i);
	}

	public void deletePageById() {
		int i = pageService.deletePageById(pageId);
		this.WriteInteger(i);
	}

	public void findGroupList() {
		try {
			Group g1 = new Group();
			g1.setProjectId(projectId);
			g1.setParentGroupId(parentGroupId);
			List<Group> groupList = groupService.findGroupList(g1);
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

	public String initContext() {
		return Action.SUCCESS;
	}

	public void findContextList() {
		try {
			List<Context> contextList = contextService.findContextList(context);
			JSONArray json = new JSONArray();
			for (Context c : contextList) {
				JSONObject jo = new JSONObject();
				jo.put("id", c.getId());
				jo.put("name", c.getName());
				jo.put("contextKey", c.getContextKey());
				json.put(jo);
			}
			this.WriteJson(contextList.size(), json);

		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public void insertContext() {
		try {
			int i = contextService.insertContext(context);
			this.WriteInteger(i);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public void deleteContext() {
		try {
			int i = contextService.deleteContext(contextId);
			this.WriteInteger(i);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public void findContextById() {
		Context c = contextService.findContextById(contextId);
		JSONObject jsonObject = new JSONObject();
		try {
			jsonObject.put("id", c.getId());
			jsonObject.put("name", c.getName());
			jsonObject.put("contextKey", c.getContextKey());
			this.WriteJson(jsonObject);
		} catch (Exception e) {

			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public void updateContext() {
		try {
			int i = contextService.updateContext(context);
			this.WriteInteger(i);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public PageService getPageService() {
		return pageService;
	}

	public void setPageService(PageService pageService) {
		this.pageService = pageService;
	}

	public GroupService getGroupService() {
		return groupService;
	}

	public void setGroupService(GroupService groupService) {
		this.groupService = groupService;
	}

	public List<Group> getGroupList() {
		return groupList;
	}

	public void setGroupList(List<Group> groupList) {
		this.groupList = groupList;
	}

	public ProjectService getProjectService() {
		return projectService;
	}

	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}

	public List<Project> getProjectList() {
		return projectList;
	}

	public void setProjectList(List<Project> projectList) {
		this.projectList = projectList;
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}

	public int getProjectId() {
		return projectId;
	}

	public void setProjectId(int projectId) {
		this.projectId = projectId;
	}

	public int getPageId() {
		return pageId;
	}

	public void setPageId(int pageId) {
		this.pageId = pageId;
	}

	public ActionService getActionService() {
		return actionService;
	}

	public void setActionService(ActionService actionService) {
		this.actionService = actionService;
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

	public int getParentGroupId() {
		return parentGroupId;
	}

	public void setParentGroupId(int parentGroupId) {
		this.parentGroupId = parentGroupId;
	}

	public ContextService getContextService() {
		return contextService;
	}

	public void setContextService(ContextService contextService) {
		this.contextService = contextService;
	}

	public Context getContext() {
		return context;
	}

	public void setContext(Context context) {
		this.context = context;
	}

	public int getContextId() {
		return contextId;
	}

	public void setContextId(int contextId) {
		this.contextId = contextId;
	}

}
