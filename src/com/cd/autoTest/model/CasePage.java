package com.cd.autoTest.model;

import java.util.List;

public class CasePage {
	private int id;
	private int pageId;
	private String name;
	private String comment;
	private int baseCaseId;
	private int sort;
	private int pageCategory;
	private int userId;
	private int parentId;
	private List<CaseData> caseDataList;
	private List<DataMap> dataMapList;
	private List<CasePage> childCasePageList;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public int getPageId() {
		return pageId;
	}
	public void setPageId(int pageId) {
		this.pageId = pageId;
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
	
	public int getBaseCaseId() {
		return baseCaseId;
	}
	public void setBaseCaseId(int baseCaseId) {
		this.baseCaseId = baseCaseId;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public List<CaseData> getCaseDataList() {
		return caseDataList;
	}
	public void setCaseDataList(List<CaseData> caseDataList) {
		this.caseDataList = caseDataList;
	}
	public int getPageCategory() {
		return pageCategory;
	}
	public void setPageCategory(int pageCategory) {
		this.pageCategory = pageCategory;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public List<DataMap> getDataMapList() {
		return dataMapList;
	}
	public void setDataMapList(List<DataMap> dataMapList) {
		this.dataMapList = dataMapList;
	}
	public int getParentId() {
		return parentId;
	}
	public void setParentId(int parentId) {
		this.parentId = parentId;
	}
	public List<CasePage> getChildCasePageList() {
		return childCasePageList;
	}
	public void setChildCasePageList(List<CasePage> childCasePageList) {
		this.childCasePageList = childCasePageList;
	}
	
}
