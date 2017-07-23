package com.cd.autoTest.action;

import java.util.Date;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import com.cd.autoTest.model.Project;
import com.cd.autoTest.model.User;
import com.cd.autoTest.service.ProjectService;
import com.opensymphony.xwork2.Action;

public class ProjectAction extends BaseAction {
	private ProjectService projectService;
	private Project project;
	private int pageId;

	public String initProject() {
		return Action.SUCCESS;
	}

	public void findProjectList() {

		try {
			project.initPage(request);
			List<Project> projectList = projectService.findProjectList(project);
			int size = projectService.findProjectCount(project);
			JSONArray json = new JSONArray();
			for (Project project : projectList) {
				JSONObject jo = new JSONObject();
				jo.put("id", project.getId());
				jo.put("name", project.getName());
				jo.put("code", project.getCode());
				json.put(jo);
			}
			this.WriteJson(size, json);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public void deleteProject() {
		int id = Integer.parseInt(request.getParameter("id"));
		int i = projectService.deleteProject(id);

		this.WriteInteger(i);
	}

	public void findProjectById() {
		try{
			int id = Integer.parseInt(request.getParameter("projectId"));
			Project project =projectService.findProjectById(id);
			JSONObject jo = new JSONObject();
			jo.put("id", project.getId());
			jo.put("name", project.getName());
			jo.put("code", project.getCode());
			this.WriteJson(jo);
		}catch(Exception e){
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
		
	}
	public void updateProject(){
		int i=projectService.updateProject(project);
		this.WriteInteger(i);
	}
	public void insertProject(){
		User user = (User) request.getSession().getAttribute("user");
		project.setInsertUser(user.getId());
		project.setUpdateUser(user.getId());
		Date date = new Date();
		project.setInsertTime(date);
		project.setUpdateTime(date);
		int i=projectService.insertProject(project);
		this.WriteInteger(i);
	}
	public int getPageId() {
		return pageId;
	}

	public void setPageId(int pageId) {
		this.pageId = pageId;
	}

	

	public ProjectService getProjectService() {
		return projectService;
	}

	public void setProjectService(ProjectService projectService) {
		this.projectService = projectService;
	}

	public Project getProject() {
		return project;
	}

	public void setProject(Project project) {
		this.project = project;
	}

}
