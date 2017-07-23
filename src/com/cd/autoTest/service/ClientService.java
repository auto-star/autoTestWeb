package com.cd.autoTest.service;

import java.util.List;

import com.cd.autoTest.dao.ClientDAO;
import com.cd.autoTest.model.Client;

public class ClientService extends IService {
	private ClientDAO clientDao;

	public List<Client> findClientList() {
		return clientDao.findClientList();
	}
	public int insertClient(Client client) {
		try {
			return clientDao.insertClient(client);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public int updateClient(Client client) {
		try {
			return clientDao.updateClient(client);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public Client findClientById(int id) {
		return clientDao.findClientById(id);
	}

	public int deleteClient(int id) {
		try {
			int i = clientDao.deleteClient(id);
			return i;
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}

	}
	public ClientDAO getClientDao() {
		return clientDao;
	}

	public void setClientDao(ClientDAO clientDao) {
		this.clientDao = clientDao;
	}

}
