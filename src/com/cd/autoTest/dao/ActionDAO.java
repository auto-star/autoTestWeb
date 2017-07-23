package com.cd.autoTest.dao;

import java.util.List;

import com.cd.autoTest.model.ActionInfo;


public interface ActionDAO {
	List<ActionInfo> findActionList(ActionInfo action);
	List<ActionInfo> findChildActionListByParentActionId(int parentActionId);
	int insertAction(ActionInfo action);
	int findMaxSort(int pageId);
	int findMaxSortByParentActionId(int parentActionId);
	ActionInfo findActionById(int id);
	int updateActionSort(ActionInfo action);
	int deleteAction(int id);
	int updateAction(ActionInfo action);
	int updateActionSortMinus(ActionInfo action);
}
