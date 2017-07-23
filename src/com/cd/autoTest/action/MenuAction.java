package com.cd.autoTest.action;

import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import com.cd.autoTest.model.Menu;
import com.cd.autoTest.service.MenuService;
import com.opensymphony.xwork2.Action;

public class MenuAction  extends BaseAction {
	private MenuService menuService;
	private List<Menu> parentMenuList;
	private Menu menu;
	private int menuId;
	public String initMenu(){
		parentMenuList=menuService.findParentMenuList();
		return Action.SUCCESS;
	}
	public void findMenuList(){
		try{
			List<Menu> menuList=menuService.findMenuList();
			JSONArray json = new JSONArray();
			for (Menu r : menuList) {
				JSONObject jo = new JSONObject();
				jo.put("id", r.getId());
				jo.put("name", r.getName());
				jo.put("action", r.getAction());
				jo.put("level", r.getLevel());
				jo.put("parentMenuId", r.getParentMenuId());
				json.put(jo);
			}
			this.WriteJson(menuList.size(),json);
		}catch(Exception e){
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
		
	}
	public void findMenuById(){
		try {
			Menu r = menuService.findMenuById(menuId);
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("id", r.getId());
			jsonObject.put("name", r.getName());
			jsonObject.put("action", r.getAction());
			jsonObject.put("level", r.getLevel());
			jsonObject.put("parentMenuId", r.getParentMenuId());
			this.WriteJson(jsonObject);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}
	public void updateMenu(){
		int i=menuService.updateMenu(menu);
		this.WriteInteger(i);
	}
	public void deleteMenu(){
		int i=menuService.deleteMenu(menuId);
		this.WriteInteger(i);
	}
	public void insertMenu(){
		int i=menuService.insertMenu(menu);
		this.WriteInteger(i);
	}
	public MenuService getMenuService() {
		return menuService;
	}
	public void setMenuService(MenuService menuService) {
		this.menuService = menuService;
	}
	public int getMenuId() {
		return menuId;
	}
	public void setMenuId(int menuId) {
		this.menuId = menuId;
	}
	public Menu getMenu() {
		return menu;
	}
	public void setMenu(Menu menu) {
		this.menu = menu;
	}
	public List<Menu> getParentMenuList() {
		return parentMenuList;
	}
	public void setParentMenuList(List<Menu> parentMenuList) {
		this.parentMenuList = parentMenuList;
	}
	
}
