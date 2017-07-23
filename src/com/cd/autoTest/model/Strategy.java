package com.cd.autoTest.model;

import java.util.Date;

public class Strategy  extends BaseModel {
	private int id;
	private int caseId;
	private String caseName;
	private int category;
	private String categoryName;
	private String executeTime;
	private int environmentId;
	private String environmentName;
	private int screenShot;
	private int userId;
	private String userName;
	private Date updateTime;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getCaseId() {
		return caseId;
	}
	public void setCaseId(int caseId) {
		this.caseId = caseId;
	}
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
	}
	
	public String getExecuteTime() {
		return executeTime;
	}
	public void setExecuteTime(String executeTime) {
		this.executeTime = executeTime;
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
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public String getCaseName() {
		return caseName;
	}
	public void setCaseName(String caseName) {
		this.caseName = caseName;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getEnvironmentName() {
		return environmentName;
	}
	public void setEnvironmentName(String environmentName) {
		this.environmentName = environmentName;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
}
