package com.cd.autoTest.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import com.cd.autoTest.model.Case;
import com.cd.autoTest.model.Category;
import com.cd.autoTest.model.Client;
import com.cd.autoTest.model.Environment;
import com.cd.autoTest.model.Group;
import com.cd.autoTest.model.Project;
import com.cd.autoTest.model.RunCaseResult;
import com.cd.autoTest.model.User;
import com.cd.autoTest.service.BaseCaseService;
import com.cd.autoTest.service.CaseDataService;
import com.cd.autoTest.service.CasePageService;
import com.cd.autoTest.service.CaseService;
import com.cd.autoTest.service.CategoryService;
import com.cd.autoTest.service.ClientService;
import com.cd.autoTest.service.EnvironmentService;
import com.cd.autoTest.service.GroupService;
import com.cd.autoTest.service.ProjectService;
import com.cd.autoTest.service.RunCaseResultService;
import com.opensymphony.xwork2.Action;

public class CaseAction extends BaseAction {
	private CaseService caseService;
	private GroupService groupService;
	private ProjectService projectService;
	private CategoryService categoryService;
	private BaseCaseService baseCaseService;
	private CasePageService casePageService;
	private CaseDataService caseDataService;
	private RunCaseResultService runCaseResultService;
	private EnvironmentService environmentService;
	private ClientService clientService;
	private List<Group> groupList;
	private List<Project> projectList;
	private List<Category> categoryList;
	private List<Environment> environmentList;
	private List<Client> clientList;
	private Case executeCase;
	private int caseId;
	private int runCaseResultId;
	private int environmentId;
	private InputStream downloadFileStream;
	private String downloadFileName;
	private int screenShot;
	private RunCaseResult runCaseResult;

	public String initCase() {
		// groupList = groupService.findGroupList();
		User user = (User) request.getSession().getAttribute("user");
		categoryList = categoryService.findCategoryListByUserId(user.getId());
		projectList = projectService.findProjectList();
		environmentList = environmentService.findEnvironmentList();
		clientList = clientService.findClientList();
		return Action.SUCCESS;
	}

	public void findCaseList() {
		try {
			executeCase.initPage(request);
			List<Case> caseList = caseService.findCaseList(executeCase);
			int size = caseService.findCaseCount(executeCase);
			JSONArray json = new JSONArray();
			for (Case c : caseList) {
				JSONObject jo = new JSONObject();
				jo.put("id", c.getId());
				jo.put("name", c.getName());
				jo.put("comment", c.getComment());
				jo.put("projectId", c.getProjectId());
				jo.put("projectName", c.getProjectName());
				jo.put("category", c.getCategory());
				jo.put("categoryName", c.getCategory() == 0 ? "未区分" : c.getCategoryName());
				jo.put("userId", c.getUserId());
				jo.put("userName", c.getUserName());
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				jo.put("insertTime", sdf.format(c.getInsertTime()));
				jo.put("updateTime", sdf.format(c.getUpdateTime()));
				json.put(jo);
			}
			this.WriteJson(size, json);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.getMessage(), e.getCause());
		}
	}

	public void insertCase() {
		try {
			User user = (User) request.getSession().getAttribute("user");
			executeCase.setUserId(user.getId());
			Date date = new Date();
			executeCase.setUpdateTime(date);
			executeCase.setInsertTime(date);
			int i = caseService.insertCase(executeCase, 0);
			this.WriteInteger(i);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public void deleteCase() {
		int i = caseService.deleteCase(caseId);
		this.WriteInteger(i);
	}

	public void findCaseById() {
		try {
			Case c = caseService.findCaseById(caseId);
			JSONArray json = new JSONArray();
			JSONObject jo = new JSONObject();
			jo.put("id", c.getId());
			jo.put("name", c.getName());
			jo.put("comment", c.getComment());
			jo.put("projectId", c.getProjectId());
			jo.put("category", c.getCategory());
			json.put(jo);
			this.WriteJson(1, json);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public void updateCase() {
		try {
			Date date = new Date();
			executeCase.setUpdateTime(date);
			int i = caseService.updateCase(executeCase);
			this.WriteInteger(i);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public String initRunCaseResult() {
		environmentList = environmentService.findEnvironmentList();
		clientList = clientService.findClientList();
		return Action.SUCCESS;
	}

	public void findRunCaseResultList() {
		try {
			runCaseResult.initPage(request);
			List<RunCaseResult> list = runCaseResultService.findRunCaseResultList(runCaseResult);
			int size = runCaseResultService.findRunCaseResultCount(runCaseResult);
			JSONArray json = new JSONArray();
			for (RunCaseResult r : list) {
				JSONObject jo = new JSONObject();
				jo.put("id", r.getId());
				jo.put("caseId", r.getCaseId());
				String status = "";
				if (r.getStatus() == 0) {
					jo.put("status", "等待执行中");
				}
				if (r.getStatus() == 1) {
					jo.put("status", "执行中");
				}
				if (r.getStatus() == 2) {
					jo.put("status", "执行失败");
				}
				if (r.getStatus() == 3) {
					jo.put("status", "执行成功");
				}
				if (r.getStatus() == 4) {
					jo.put("status", "执行成功,一致");
				}
				if (r.getStatus() == 5) {
					jo.put("status", "执行成功,不一致");
				}
				if (r.getStatus() == 6) {
					jo.put("status", "执行失败,一致");
				}
				if (r.getStatus() == 7) {
					jo.put("status", "执行失败,不一致");
				}
				jo.put("caseName", r.getCaseName());
				jo.put("caseCategory", r.getCaseCategory());
				jo.put("resultFile", r.getResultFile());
				jo.put("logFile", r.getLogFile());
				jo.put("ip", r.getIp());
				jo.put("environmentName", r.getEnvironmentName());
				jo.put("userName", r.getUserName());
				jo.put("insertUser", r.getInsertUser());
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				jo.put("insertTime", sdf.format(r.getInsertTime()));
				jo.put("updateTime", sdf.format(r.getUpdateTime()));
				json.put(jo);
			}
			this.WriteJson(size, json);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public String downloadFile() {
		try {
			runCaseResult = runCaseResultService.findRunCaseResultById(runCaseResultId);
			downloadFileStream = new FileInputStream(new File(runCaseResult.getResultFile()));
			downloadFileName = runCaseResult.getResultFile()
					.substring(runCaseResult.getResultFile().lastIndexOf("\\") + 1);

		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
		return Action.SUCCESS;
	}

	public String downloadLogFile() {
		try {
			runCaseResult = runCaseResultService.findRunCaseResultById(runCaseResultId);
			downloadFileStream = new FileInputStream(new File(runCaseResult.getLogFile()));
			downloadFileName = runCaseResult.getLogFile().substring(runCaseResult.getLogFile().lastIndexOf("\\") + 1);

		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
		return Action.SUCCESS;
	}

	

	public void insertRunCaseResult() {
		String caseIdArr = request.getParameter("caseIds");
		String[] arr = caseIdArr.split(",");
		User user = (User) request.getSession().getAttribute("user");
		String ip = request.getParameter("ip");
		int i = 0;
		try {
			for (String caseId : arr) {
				runCaseResult = new RunCaseResult();
				runCaseResult.setCaseId(Integer.valueOf(caseId));
				runCaseResult.setStatus(0);
				runCaseResult.setEnvironmentId(environmentId);
				runCaseResult.setScreenShot(screenShot);
				if (ip != null) {
					runCaseResult.setIp(ip);
				}
				runCaseResult.setInsertUser(user.getId());
				runCaseResult.setUpdateUser(user.getId());
				Date date = new Date();
				runCaseResult.setUpdateTime(date);
				runCaseResult.setInsertTime(date);
				i += runCaseResultService.insertRunCaseResult(runCaseResult);
			}
			this.WriteInteger(i);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public void copyCase() {
		try {
			int i = this.copyCase(executeCase);
			this.WriteInteger(i);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public void copyCheckCase() {
		String caseIds = request.getParameter("caseIds");
		String[] arr = caseIds.split(",");
		try {
			int i = 0;
			for (String caseId : arr) {
				i += this.copyCase(executeCase, Integer.parseInt(caseId));
			}
			this.WriteInteger(i);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public int copyCase(Case c) {
		try {
			User user = (User) request.getSession().getAttribute("user");
			c.setUserId(user.getId());
			Date date = new Date();
			c.setInsertTime(date);
			c.setUpdateTime(date);
			int i = caseService.insertCase(c, c.getId());

			return i;
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}

	}

	public int copyCase(Case casePart, int formerCaseId) {
		try {
			User user = (User) request.getSession().getAttribute("user");
			Case c = caseService.findCaseById(formerCaseId);
			c.setProjectId(casePart.getProjectId());
			c.setCategory(casePart.getCategory());
			Project project = projectService.findProjectById(casePart.getProjectId());

			c.setName(c.getName() + "_" + project.getCode());
			c.setUserId(user.getId());
			Date date = new Date();
			c.setInsertTime(date);
			c.setUpdateTime(date);
			int i = caseService.insertCase(c, formerCaseId);

			return i;
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}

	}

	public void deleteRunCaseResult() {
		int i = runCaseResultService.deleteRunCaseResult(runCaseResultId);
		this.WriteInteger(i);
	}

	public CaseService getCaseService() {
		return caseService;
	}

	public void setCaseService(CaseService caseService) {
		this.caseService = caseService;
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

	public Case getExecuteCase() {
		return executeCase;
	}

	public void setExecuteCase(Case executeCase) {
		this.executeCase = executeCase;
	}

	public CategoryService getCategoryService() {
		return categoryService;
	}

	public void setCategoryService(CategoryService categoryService) {
		this.categoryService = categoryService;
	}

	public List<Category> getCategoryList() {
		return categoryList;
	}

	public void setCategoryList(List<Category> categoryList) {
		this.categoryList = categoryList;
	}

	public BaseCaseService getBaseCaseService() {
		return baseCaseService;
	}

	public void setBaseCaseService(BaseCaseService baseCaseService) {
		this.baseCaseService = baseCaseService;
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

	public int getCaseId() {
		return caseId;
	}

	public void setCaseId(int caseId) {
		this.caseId = caseId;
	}

	public RunCaseResultService getRunCaseResultService() {
		return runCaseResultService;
	}

	public void setRunCaseResultService(RunCaseResultService runCaseResultService) {
		this.runCaseResultService = runCaseResultService;
	}

	public int getRunCaseResultId() {
		return runCaseResultId;
	}

	public void setRunCaseResultId(int runCaseResultId) {
		this.runCaseResultId = runCaseResultId;
	}

	public InputStream getDownloadFileStream() {
		return downloadFileStream;
	}

	public void setDownloadFileStream(InputStream downloadFileStream) {
		this.downloadFileStream = downloadFileStream;
	}

	public String getDownloadFileName() {
		try {
			downloadFileName = new String(downloadFileName.getBytes("GB2312"), "ISO8859-1");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return downloadFileName;
	}

	public void setDownloadFileName(String downloadFileName) {
		this.downloadFileName = downloadFileName;
	}

	public List<Environment> getEnvironmentList() {
		return environmentList;
	}

	public void setEnvironmentList(List<Environment> environmentList) {
		this.environmentList = environmentList;
	}

	public EnvironmentService getEnvironmentService() {
		return environmentService;
	}

	public void setEnvironmentService(EnvironmentService environmentService) {
		this.environmentService = environmentService;
	}

	public int getEnvironmentId() {
		return environmentId;
	}

	public void setEnvironmentId(int environmentId) {
		this.environmentId = environmentId;
	}

	public int getScreenShot() {
		return screenShot;
	}

	public void setScreenShot(int screenShot) {
		this.screenShot = screenShot;
	}

	public ClientService getClientService() {
		return clientService;
	}

	public void setClientService(ClientService clientService) {
		this.clientService = clientService;
	}

	public List<Client> getClientList() {
		return clientList;
	}

	public void setClientList(List<Client> clientList) {
		this.clientList = clientList;
	}

	public RunCaseResult getRunCaseResult() {
		return runCaseResult;
	}

	public void setRunCaseResult(RunCaseResult runCaseResult) {
		this.runCaseResult = runCaseResult;
	}

}
