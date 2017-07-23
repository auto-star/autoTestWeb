package com.cd.autoTest.dao;

import java.util.List;

import com.cd.autoTest.model.Context;

public interface ContextDAO {
	List<Context> findContextList(Context context);
	int insertContext(Context context);
	int deleteContext(int id);
	Context findContextById(int id);
	int updateContext(Context context);
}
