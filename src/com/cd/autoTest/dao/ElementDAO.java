package com.cd.autoTest.dao;

import java.util.List;

import com.cd.autoTest.model.Element;



public interface ElementDAO {
	List<Element> findElementList(Element element);
	int findElementCount(Element element);
	List<Element> findElementListByPageId(Element element);
	int deleteElement(int id);
	Element findElementById(int id);
	int updateElement(Element element);
	int insertElement(Element element);
}
