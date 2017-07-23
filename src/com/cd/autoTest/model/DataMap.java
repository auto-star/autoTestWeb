package com.cd.autoTest.model;

public class DataMap {
	private int id;
	private String code;
	private int category;
	private int actionId;
	private int pageId;
	

	private int sort;
	private int refPageId;
	private String elementName;
	private String pageTitle;
	private CaseData caseData;
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	
	public int getSort() {
		return sort;
	}

	public void setSort(int sort) {
		this.sort = sort;
	}

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}

	public int getActionId() {
		return actionId;
	}

	public void setActionId(int actionId) {
		this.actionId = actionId;
	}

	public int getPageId() {
		return pageId;
	}

	public void setPageId(int pageId) {
		this.pageId = pageId;
	}

	public String getElementName() {
		return elementName;
	}

	public void setElementName(String elementName) {
		this.elementName = elementName;
	}

	public String getPageTitle() {
		return pageTitle;
	}

	public void setPageTitle(String pageTitle) {
		this.pageTitle = pageTitle;
	}


	public int getRefPageId() {
		return refPageId;
	}

	public void setRefPageId(int refPageId) {
		this.refPageId = refPageId;
	}

	public CaseData getCaseData() {
		return caseData;
	}

	public void setCaseData(CaseData caseData) {
		this.caseData = caseData;
	}
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
}
