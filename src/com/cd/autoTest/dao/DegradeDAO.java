package com.cd.autoTest.dao;

import java.util.List;

import com.cd.autoTest.model.Degrade;



public interface DegradeDAO {
	List<Degrade> findDegradeList(Degrade degrade);
	int findDegradeCount(Degrade degrade);
	Degrade findDegradeById(int id);
}
