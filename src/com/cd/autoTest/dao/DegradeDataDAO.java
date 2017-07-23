package com.cd.autoTest.dao;

import java.util.List;

import com.cd.autoTest.model.DegradeData;

public interface DegradeDataDAO {
	List<DegradeData> findDegradeDataList(int degradeId);
}
