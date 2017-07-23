package com.cd.autoTest.service;

import java.util.List;

import com.cd.autoTest.dao.ContextDAO;
import com.cd.autoTest.model.Context;

public class ContextService extends IService {
	private ContextDAO contextDao;

	public List<Context> findContextList(Context context) {
		return contextDao.findContextList(context);
	}

	public int insertContext(Context context) {
		try {
			return contextDao.insertContext(context);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public int deleteContext(int id) {
		try {
			return contextDao.deleteContext(id);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public Context findContextById(int id) {
		return contextDao.findContextById(id);
	}

	public int updateContext(Context context) {
		try {
			return contextDao.updateContext(context);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public ContextDAO getContextDao() {
		return contextDao;
	}

	public void setContextDao(ContextDAO contextDao) {
		this.contextDao = contextDao;
	}

}
