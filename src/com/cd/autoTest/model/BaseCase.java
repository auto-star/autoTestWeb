package com.cd.autoTest.model;

public class BaseCase {
	private int id;
	private String name;
	private String comment;
	private int groupId;
	private String groupName;
	private int parentGroupId;
	private String parentGroupName;
	private int ProjectId;
	private String ProjectName;
	private int userId;
	private String userName;
	private int status;
	private int caseId;
	private int kind;
	private int sort;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public int getGroupId() {
		return groupId;
	}
	public void setGroupId(int groupId) {
		this.groupId = groupId;
	}
	public int getProjectId() {
		return ProjectId;
	}
	public void setProjectId(int ProjectId) {
		this.ProjectId = ProjectId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	
	public int getCaseId() {
		return caseId;
	}
	public void setCaseId(int caseId) {
		this.caseId = caseId;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	public String getProjectName() {
		return ProjectName;
	}
	public void setProjectName(String ProjectName) {
		this.ProjectName = ProjectName;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getParentGroupName() {
		return parentGroupName;
	}
	public void setParentGroupName(String parentGroupName) {
		this.parentGroupName = parentGroupName;
	}
	public int getParentGroupId() {
		return parentGroupId;
	}
	public void setParentGroupId(int parentGroupId) {
		this.parentGroupId = parentGroupId;
	}
	public int getKind() {
		return kind;
	}
	public void setKind(int kind) {
		this.kind = kind;
	}
	
}
