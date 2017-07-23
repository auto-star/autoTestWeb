package com.cd.autoTest.dao;

import java.util.List;

import com.cd.autoTest.model.DataMapCollection;

public interface DataMapCollectionDAO {
	int insertDataMapCollection(DataMapCollection dataMapCollection);
	List<DataMapCollection> findDataMapCollectionListByDataMapId(int dataMapId);
	int deleteDataMapCollectionByDataMapId(int dataMapId);
}
