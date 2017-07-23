package com.cd.autoTest.model;

import java.util.List;

public class Menu {
	private int id;
	private String name;
	private String action;
	private int level;
	private int parentMenuId;
	private int roleId;//这个东西就是当查询条件用的，和这个model其实没什么关系，不应该出现在这里
	private List<Menu> menuList;
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
	
	public String getAction() {
		return action;
	}
	public void setAction(String action) {
		this.action = action;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	public int getParentMenuId() {
		return parentMenuId;
	}
	public void setParentMenuId(int parentMenuId) {
		this.parentMenuId = parentMenuId;
	}
	public List<Menu> getMenuList() {
		return menuList;
	}
	public void setMenuList(List<Menu> menuList) {
		this.menuList = menuList;
	}
	public int getRoleId() {
		return roleId;
	}
	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}
	
}
