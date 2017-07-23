package com.cd.autoTest.action;

import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import com.cd.autoTest.model.Menu;
import com.cd.autoTest.model.RoleMenu;
import com.cd.autoTest.service.MenuService;
import com.cd.autoTest.service.RoleMenuService;
import com.opensymphony.xwork2.Action;

public class RoleMenuAction  extends BaseAction {
	private MenuService menuService;
	private List<Menu> menuList;
	private RoleMenuService roleMenuService;
	private RoleMenu roleMenu;
	private int roleMenuId;
	private int roleId;
	public String initRoleMenu(){
		menuList=menuService.findParentMenuList();
		for(Menu m:menuList){
			List<Menu> mList=menuService.findMenuListByParentId(m.getId());
			m.setMenuList(mList);
		}
		return Action.SUCCESS;
	}
	public void findRoleMenuListByRoleId(){
		try{
			List<RoleMenu> roleMenuList=roleMenuService.findRoleMenuListByRoleId(roleId);
			JSONArray json = new JSONArray();
			for (RoleMenu r : roleMenuList) {
				JSONObject jo = new JSONObject();
				jo.put("id", r.getId());
				jo.put("roleId", r.getRoleId());
				jo.put("menuId", r.getMenuId());
				json.put(jo);
			}
			this.WriteJson(json);
		}catch(Exception e){
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
		
	}
	
	public void insertRoleMenu(){
		String[] menuIds=request.getParameter("menuId").split(",");

		int i=roleMenuService.insertRoleMenu(menuIds,roleId);
		this.WriteInteger(i);
	}
	public RoleMenuService getRoleMenuService() {
		return roleMenuService;
	}
	public void setRoleMenuService(RoleMenuService roleMenuService) {
		this.roleMenuService = roleMenuService;
	}
	public int getRoleMenuId() {
		return roleMenuId;
	}
	public void setRoleMenuId(int roleMenuId) {
		this.roleMenuId = roleMenuId;
	}
	public RoleMenu getRoleMenu() {
		return roleMenu;
	}
	public void setRoleMenu(RoleMenu roleMenu) {
		this.roleMenu = roleMenu;
	}
	public MenuService getMenuService() {
		return menuService;
	}
	public void setMenuService(MenuService menuService) {
		this.menuService = menuService;
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
