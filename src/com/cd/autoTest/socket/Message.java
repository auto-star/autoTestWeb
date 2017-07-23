package com.cd.autoTest.socket;

import java.io.Serializable;

public class Message implements Serializable{
	private int caseId;
	private int runCaseResultId;
	private String status;
	private String ip;
	private int environmentId;
	private int screenShot;
	public int getCaseId() {
		return caseId;
	}
	public void setCaseId(int caseId) {
		this.caseId = caseId;
	}
	public int getRunCaseResultId() {
		return runCaseResultId;
	}
	public void setRunCaseResultId(int runCaseResultId) {
		this.runCaseResultId = runCaseResultId;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
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
	public int getScreenShot() {
		return screenShot;
	}
	public void setScreenShot(int screenShot) {
		this.screenShot = screenShot;
	}
	
	
}
