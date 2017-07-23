package com.cd.autoTest.action;

import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import com.cd.autoTest.model.Role;
import com.cd.autoTest.service.RoleService;
import com.opensymphony.xwork2.Action;

public class RoleAction  extends BaseAction {
	private RoleService roleService;
	private Role role;
	private int roleId;
	public String initRole(){
		return Action.SUCCESS;
	}
	public void findRoleList(){
		try{
			List<Role> roleList=roleService.findRoleList();
			JSONArray json = new JSONArray();
			for (Role r : roleList) {
				JSONObject jo = new JSONObject();
				jo.put("id", r.getId());
				jo.put("name", r.getName());
				jo.put("comment", r.getComment());
				jo.put("isAdmin",  r.getIsAdmin()==2?"有":"无");
				json.put(jo);
			}
			this.WriteJson(roleList.size(),json);
		}catch(Exception e){
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
		
	}
	public void findRoleById(){
		try {
			Role r = roleService.findRoleById(roleId);
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("id", r.getId());
			jsonObject.put("name", r.getName());
			jsonObject.put("comment", r.getComment());
			jsonObject.put("isAdmin", r.getIsAdmin());
			this.WriteJson(jsonObject);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}
	public void updateRole(){
		int i=roleService.updateRole(role);
		this.WriteInteger(i);
	}
	public void deleteRole(){
		int i=roleService.deleteRole(roleId);
		this.WriteInteger(i);
	}
	public void insertRole(){
		int i=roleService.insertRole(role);
		this.WriteInteger(i);
	}
	public RoleService getRoleService() {
		return roleService;
	}
	public void setRoleService(RoleService roleService) {
		this.roleService = roleService;
	}
	public int getRoleId() {
		return roleId;
	}
	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}
	public Role getRole() {
		return role;
	}
	public void setRole(Role role) {
		this.role = role;
	}
	
}
