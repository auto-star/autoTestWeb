package com.cd.autoTest.service;

import java.util.List;

import com.cd.autoTest.dao.ElementDAO;
import com.cd.autoTest.model.Element;


public class ElementService extends IService {
	private ElementDAO elementDao;

	public List<Element> findElementListByPageId(Element element) {
		return elementDao.findElementListByPageId(element);
	}

	public int findElementCount(Element element) {
		return elementDao.findElementCount(element);
	}

	public int deleteElement(int id) {
		return elementDao.deleteElement(id);
	}

	public Element findElementById(int id) {
		return elementDao.findElementById(id);
	}

	public int updateElement(Element element) {
		return elementDao.updateElement(element);
	}

	public int insertElement(Element element) {
		int i = 0;
		try {
			i = elementDao.insertElement(element);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException();
		}
		return i;
	}

	public ElementDAO getElementDao() {
		return elementDao;
	}

	public void setElementDao(ElementDAO elementDao) {
		this.elementDao = elementDao;
	}

}
