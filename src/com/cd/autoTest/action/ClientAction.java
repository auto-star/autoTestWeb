package com.cd.autoTest.action;

import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import com.cd.autoTest.model.Client;
import com.cd.autoTest.model.User;
import com.cd.autoTest.service.ClientService;
import com.cd.autoTest.service.UserService;
import com.opensymphony.xwork2.Action;

public class ClientAction  extends BaseAction {
	private ClientService clientService;
	private UserService userService;
	private List<User> userList;
	private Client client;
	private int clientId;
	public String initClient(){
		userList=userService.findUserList();
		return Action.SUCCESS;
	}
	public void findClientList(){
		try{
			List<Client> clientList=clientService.findClientList();
			JSONArray json = new JSONArray();
			for (Client r : clientList) {
				JSONObject jo = new JSONObject();
				jo.put("id", r.getId());
				jo.put("name", r.getName());
				jo.put("ip", r.getIp());
				jo.put("userName", r.getUserName());
				json.put(jo);
			}
			this.WriteJson(clientList.size(),json);
		}catch(Exception e){
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
		
	}
	public void findClientById(){
		try {
			Client r = clientService.findClientById(clientId);
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("id", r.getId());
			jsonObject.put("name", r.getName());
			jsonObject.put("ip", r.getIp());
			jsonObject.put("userId", r.getUserId());
			jsonObject.put("userName", r.getUserName());
			this.WriteJson(jsonObject);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}
	public void updateClient(){
		int i=clientService.updateClient(client);
		this.WriteInteger(i);
	}
	public void deleteClient(){
		int i=clientService.deleteClient(clientId);
		this.WriteInteger(i);
	}
	public void insertClient(){
		int i=clientService.insertClient(client);
		this.WriteInteger(i);
	}
	public ClientService getClientService() {
		return clientService;
	}
	public void setClientService(ClientService clientService) {
		this.clientService = clientService;
	}
	public int getClientId() {
		return clientId;
	}
	public void setClientId(int clientId) {
		this.clientId = clientId;
	}
	public Client getClient() {
		return client;
	}
	public void setClient(Client client) {
		this.client = client;
	}
	public UserService getUserService() {
		return userService;
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	public List<User> getUserList() {
		return userList;
	}
	public void setUserList(List<User> userList) {
		this.userList = userList;
	}
	
}
