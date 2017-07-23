package com.cd.autoTest.model;

public class Degrade extends BaseModel{
	private int caseId;
	private String caseName;
	private int leftRunCaseResultId;
	private int rightRunCaseResultId;
	private int leftEnvironmentId;
	private String leftEnvrionmentName;
	private int rightEnvironmentId;
	private String rightEnvironmentName;
	private String leftExecuteDate;
	private String rightExecuteDate;
	
	
	private int runCaseResultId;
	private int environmentId;
	private String environmentName;
	private String executeDate;
	
	public int getCaseId() {
		return caseId;
	}
	public void setCaseId(int caseId) {
		this.caseId = caseId;
	}

	public int getLeftRunCaseResultId() {
		return leftRunCaseResultId;
	}
	public void setLeftRunCaseResultId(int leftRunCaseResultId) {
		this.leftRunCaseResultId = leftRunCaseResultId;
	}
	public int getRightRunCaseResultId() {
		return rightRunCaseResultId;
	}
	public void setRightRunCaseResultId(int rightRunCaseResultId) {
		this.rightRunCaseResultId = rightRunCaseResultId;
	}
	public String getCaseName() {
		return caseName;
	}
	public void setCaseName(String caseName) {
		this.caseName = caseName;
	}
	public int getLeftEnvironmentId() {
		return leftEnvironmentId;
	}
	public void setLeftEnvironmentId(int leftEnvironmentId) {
		this.leftEnvironmentId = leftEnvironmentId;
	}
	public int getRightEnvironmentId() {
		return rightEnvironmentId;
	}
	public void setRightEnvironmentId(int rightEnvironmentId) {
		this.rightEnvironmentId = rightEnvironmentId;
	}
	public String getLeftExecuteDate() {
		return leftExecuteDate;
	}
	public void setLeftExecuteDate(String leftExecuteDate) {
		this.leftExecuteDate = leftExecuteDate;
	}
	public String getRightExecuteDate() {
		return rightExecuteDate;
	}
	public void setRightExecuteDate(String rightExecuteDate) {
		this.rightExecuteDate = rightExecuteDate;
	}

	public String getLeftEnvrionmentName() {
		return leftEnvrionmentName;
	}
	public void setLeftEnvrionmentName(String leftEnvrionmentName) {
		this.leftEnvrionmentName = leftEnvrionmentName;
	}
	public String getRightEnvironmentName() {
		return rightEnvironmentName;
	}
	public void setRightEnvironmentName(String rightEnvironmentName) {
		this.rightEnvironmentName = rightEnvironmentName;
	}

	public int getRunCaseResultId() {
		return runCaseResultId;
	}
	public void setRunCaseResultId(int runCaseResultId) {
		this.runCaseResultId = runCaseResultId;
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
	public String getExecuteDate() {
		return executeDate;
	}
	public void setExecuteDate(String executeDate) {
		this.executeDate = executeDate;
	}
	
}
