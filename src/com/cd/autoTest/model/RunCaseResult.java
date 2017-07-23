package com.cd.autoTest.model;

import java.util.Date;

public class RunCaseResult extends BaseModel {
	private int id;
	private int caseId;
	private String caseName;
	private int categoryId;
	private String caseCategory;
	private int status;
	private String resultFile;
	private String logFile;
	private String ip;
	private int environmentId;
	private String environmentName;
	private int screenShot;
	private int insertUser;
	private String userName;
	private int updateUser;
	private Date insertTime;
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
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getResultFile() {
		return resultFile;
	}
	public void setResultFile(String resultFile) {
		this.resultFile = resultFile;
	}
	public String getCaseName() {
		return caseName;
	}
	public void setCaseName(String caseName) {
		this.caseName = caseName;
	}
	public String getCaseCategory() {
		return caseCategory;
	}
	public void setCaseCategory(String caseCategory) {
		this.caseCategory = caseCategory;
	}
	public int getInsertUser() {
		return insertUser;
	}
	public void setInsertUser(int insertUser) {
		this.insertUser = insertUser;
	}
	public int getUpdateUser() {
		return updateUser;
	}
	public void setUpdateUser(int updateUser) {
		this.updateUser = updateUser;
	}
	public Date getInsertTime() {
		return insertTime;
	}
	public void setInsertTime(Date insertTime) {
		this.insertTime = insertTime;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}

	public int getEnvironmentId() {
		return environmentId;
	}
	public void setEnvironmentId(int environmentId) {
		this.environmentId = environmentId;
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
	public int getScreenShot() {
		return screenShot;
	}
	public void setScreenShot(int screenShot) {
		this.screenShot = screenShot;
	}
	public String getLogFile() {
		return logFile;
	}
	public void setLogFile(String logFile) {
		this.logFile = logFile;
	}
	public int getCategoryId() {
		return categoryId;
	}
	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}
	
}
