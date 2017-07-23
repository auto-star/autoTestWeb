package com.cd.autoTest.dao;

import java.util.List;

import com.cd.autoTest.model.Client;

public interface ClientDAO{
	List<Client> findClientList();
	int insertClient(Client client);
	int updateClient(Client client);
	Client findClientById(int id);
	int deleteClient(int id);
}
