package com.cd.autoTest.model;

public class Element   extends BaseModel{
	private int id;
	private String name;
	private String xpath;
	private int pageId;
	private int isCompare;
	private String contextKey;

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

	public int getPageId() {
		return pageId;
	}

	public void setPageId(int pageId) {
		this.pageId = pageId;
	}


	public String getXpath() {
		return xpath;
	}

	public void setXpath(String xpath) {
		this.xpath = xpath;
	}

	public int getIsCompare() {
		return isCompare;
	}

	public void setIsCompare(int isCompare) {
		this.isCompare = isCompare;
	}

	public String getContextKey() {
		return contextKey;
	}

	public void setContextKey(String contextKey) {
		this.contextKey = contextKey;
	}

}
