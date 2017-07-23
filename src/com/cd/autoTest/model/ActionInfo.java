package com.cd.autoTest.model;

import java.util.List;

public class ActionInfo {
	private int id;
	private String name;
	private int actionCategory;
	private int commandCategory;
	private String commandName;
	private String elementName;
	private String elementXpath;
	private String contextKey;
	private int valueCategory;
	private String defaultValue;
	private int parentActionId;
	private int pageId;
	private int sort;
	private List<ActionInfo> actionList;
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

	public String getDefaultValue() {
		return defaultValue;
	}

	public void setDefaultValue(String defaultValue) {
		this.defaultValue = defaultValue;
	}

	public int getSort() {
		return sort;
	}

	public void setSort(int sort) {
		this.sort = sort;
	}

	public int getCommandCategory() {
		return commandCategory;
	}

	public void setCommandCategory(int commandCategory) {
		this.commandCategory = commandCategory;
	}

	public String getCommandName() {
		return commandName;
	}

	public void setCommandName(String commandName) {
		this.commandName = commandName;
	}

	public String getContextKey() {
		return contextKey;
	}

	public void setContextKey(String contextKey) {
		this.contextKey = contextKey;
	}

	

	public int getValueCategory() {
		return valueCategory;
	}

	public void setValueCategory(int valueCategory) {
		this.valueCategory = valueCategory;
	}

	public String getElementName() {
		return elementName;
	}

	public void setElementName(String elementName) {
		this.elementName = elementName;
	}


	public int getActionCategory() {
		return actionCategory;
	}

	public void setActionCategory(int actionCategory) {
		this.actionCategory = actionCategory;
	}

	public String getElementXpath() {
		return elementXpath;
	}

	public void setElementXpath(String elementXpath) {
		this.elementXpath = elementXpath;
	}

	public List<ActionInfo> getActionList() {
		return actionList;
	}

	public void setActionList(List<ActionInfo> actionList) {
		this.actionList = actionList;
	}

	public int getParentActionId() {
		return parentActionId;
	}

	public void setParentActionId(int parentActionId) {
		this.parentActionId = parentActionId;
	}

}
