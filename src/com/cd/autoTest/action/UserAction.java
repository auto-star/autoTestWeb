package com.cd.autoTest.action;

import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import com.cd.autoTest.model.Menu;
import com.cd.autoTest.model.Role;
import com.cd.autoTest.model.User;
import com.cd.autoTest.model.UserGroup;
import com.cd.autoTest.service.MenuService;
import com.cd.autoTest.service.RoleService;
import com.cd.autoTest.service.UserGroupService;
import com.cd.autoTest.service.UserService;
import com.opensymphony.xwork2.Action;

public class UserAction extends BaseAction {
	private UserService userService;
	private UserGroupService userGroupService;
	private RoleService roleService;
	private MenuService menuService;
	private List<UserGroup> userGroupList;
	private List<Menu> menuList;
	private List<Role> roleList;
	private User user;
	private UserGroup userGroup;
	private int userGroupId;
	private int userId;
	

	public String welcome() {
		return Action.SUCCESS;
	}

	public String login() {
		user = (User) request.getSession().getAttribute("user");
		if(user!=null){
			return Action.SUCCESS;
		}else{
			String userName = request.getParameter("userName");
			String password = request.getParameter("password");
			user = userService.findUserByName(userName);
			if (user == null) {
				return Action.LOGIN;
			} else {
				if (password.equals(user.getPassword())) {
					request.getSession().setAttribute("user", user);
					
					return Action.SUCCESS;
				}
			}
		}
		
		return Action.LOGIN;
	}

	public String redirectToMain() {
		user = (User) request.getSession().getAttribute("user");
		
		if (user != null) {
			request.getSession().setAttribute("userId", user.getId());
			request.getSession().setAttribute("userName", user.getName());
			Role role=roleService.findRoleById(user.getRoleId());
			request.getSession().setAttribute("isAdmin", role.getIsAdmin());
			Menu conditionMenu=new Menu();
			conditionMenu.setParentMenuId(-1);
			conditionMenu.setRoleId(user.getRoleId());
			menuList=menuService.findParentRoleMenuList(conditionMenu);
			for(Menu m:menuList){
				conditionMenu.setParentMenuId(m.getId());
				List<Menu> childMenuList=menuService.findParentRoleMenuList(conditionMenu);
				m.setMenuList(childMenuList);
			}
			return Action.SUCCESS;
		}
		return Action.LOGIN;
	}

	public String initUser() {
		userGroupList= userGroupService.findUserGroupList();
		roleList=roleService.findRoleList();
		return Action.SUCCESS;
	}

	public void findUserList() {
		List<User> userList = userService.findUserList();
		try {
			JSONArray json = new JSONArray();
			for (User user : userList) {
				JSONObject jo = new JSONObject();
				jo.put("id", user.getId());
				jo.put("name", user.getName());
				jo.put("password", user.getPassword());
				jo.put("userGroupName", user.getUserGroupName());
				jo.put("roleName", user.getRoleName());
				json.put(jo);
			}

			this.WriteJson(userList.size(), json);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.getMessage(),e.getCause());
		}
	}

	public void deleteUser() {
		try {
			int i = userService.deleteUser(userId);
			this.WriteInteger(i);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.getMessage(),e.getCause());
		}
	}

	public void insertUser() {
		try {
			int i = userService.insertUser(user);
			this.WriteInteger(i);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.getMessage(),e.getCause());
		}
	}

	public void updateUser() {
		try {
			int i = userService.updateUser(user);
			this.WriteInteger(i);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.getMessage(),e.getCause());
		}
	}
	public void findUserById()
	{
		try {
			User u=userService.findUserById(userId);
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("id", u.getId());
			jsonObject.put("name", u.getName());
			jsonObject.put("password", u.getPassword());
			jsonObject.put("userGroupId", u.getUserGroupId());
			jsonObject.put("roleId", u.getRoleId());
			this.WriteJson(jsonObject);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.getMessage(),e.getCause());
		}
	}
	public String initUserGroup() {
		return Action.SUCCESS;
	}

	public void findUserGroupList() {
		try {
			List<UserGroup> groupList = userGroupService.findUserGroupList();
			JSONArray json = new JSONArray();
			for (UserGroup ug : groupList) {
				JSONObject jo = new JSONObject();
				jo.put("id", ug.getId());
				jo.put("name", ug.getName());
				json.put(jo);
			}
			this.WriteJson(groupList.size(), json);

		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.getMessage(),e.getCause());
		}

	}
	public void insertUserGroup()
	{
		try
		{
			int i=userGroupService.insertUserGroup(userGroup);
			this.WriteInteger(i);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.getMessage(),e.getCause());
		}
	}
	public void deleteUserGroup()
	{
		int i=userGroupService.deleteUserGroup(userGroupId);
		this.WriteInteger(i);
	}
	public void updateUserGroup()
	{
		try
		{
			int i=userGroupService.updateUserGroup(userGroup);
			this.WriteInteger(i);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.getMessage(),e.getCause());
		}
	}
	public void findUserGroupById()
	{
		try
		{
			UserGroup ug=userGroupService.findUserGroupById(userGroupId);
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("id", ug.getId());
			jsonObject.put("name", ug.getName());
			this.WriteJson(jsonObject);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.getMessage(),e.getCause());
		}
	}
	public void logout()
	{
		try
		{
			request.getSession().removeAttribute("user");
			this.WriteInteger(1);
		}catch(Exception e)
		{
			log.info(e.toString());
			throw new RuntimeException(e.getMessage(),e.getCause());
		}
		
		
	}
	public UserService getUserService() {
		return userService;
	}

	public void setUserService(UserService userService) {
		this.userService = userService;
	}

	

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public UserGroupService getUserGroupService() {
		return userGroupService;
	}

	public void setUserGroupService(UserGroupService userGroupService) {
		this.userGroupService = userGroupService;
	}

	public UserGroup getUserGroup() {
		return userGroup;
	}

	public void setUserGroup(UserGroup userGroup) {
		this.userGroup = userGroup;
	}

	public int getUserGroupId() {
		return userGroupId;
	}

	public void setUserGroupId(int userGroupId) {
		this.userGroupId = userGroupId;
	}

	public List<UserGroup> getUserGroupList() {
		return userGroupList;
	}

	public void setUserGroupList(List<UserGroup> userGroupList) {
		this.userGroupList = userGroupList;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public RoleService getRoleService() {
		return roleService;
	}

	public void setRoleService(RoleService roleService) {
		this.roleService = roleService;
	}

	public List<Role> getRoleList() {
		return roleList;
	}

	public void setRoleList(List<Role> roleList) {
		this.roleList = roleList;
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

}
