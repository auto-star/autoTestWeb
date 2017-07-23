package com.cd.autoTest.model;

import java.util.List;

public class CaseData {
	private int id;
	private int category;
	private String dataValue;
	private int dataMapId;
	private int casePageId;
	private int sort;
	private ActionInfo action;
	private List<DataMapCollection> dataMapCollectionList;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getDataValue() {
		return dataValue;
	}
	public void setDataValue(String dataValue) {
		this.dataValue = dataValue;
	}
	public int getDataMapId() {
		return dataMapId;
	}
	public void setDataMapId(int dataMapId) {
		this.dataMapId = dataMapId;
	}
	public int getCasePageId() {
		return casePageId;
	}
	public void setCasePageId(int casePageId) {
		this.casePageId = casePageId;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public List<DataMapCollection> getDataMapCollectionList() {
		return dataMapCollectionList;
	}
	public void setDataMapCollectionList(List<DataMapCollection> dataMapCollectionList) {
		this.dataMapCollectionList = dataMapCollectionList;
	}
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
	}
	public ActionInfo getAction() {
		return action;
	}
	public void setAction(ActionInfo action) {
		this.action = action;
	}

	
}
