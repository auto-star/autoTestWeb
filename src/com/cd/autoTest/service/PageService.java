package com.cd.autoTest.service;

import java.util.Date;
import java.util.List;

import com.cd.autoTest.dao.ActionDAO;
import com.cd.autoTest.dao.CaseDataDAO;
import com.cd.autoTest.dao.ContextDAO;
import com.cd.autoTest.dao.DataMapCollectionDAO;
import com.cd.autoTest.dao.DataMapDAO;
import com.cd.autoTest.dao.GroupDAO;
import com.cd.autoTest.dao.PageDAO;
import com.cd.autoTest.dao.ProjectDAO;
import com.cd.autoTest.model.ActionInfo;
import com.cd.autoTest.model.DataMap;
import com.cd.autoTest.model.DataMapCollection;
import com.cd.autoTest.model.Group;
import com.cd.autoTest.model.Page;
import com.cd.autoTest.model.Project;

public class PageService extends IService {
	private PageDAO pageDao;
	private GroupDAO groupDao;
	private ProjectDAO projectDao;
	private ActionDAO actionDao;
	private DataMapDAO dataMapDao;
	private DataMapCollectionDAO dataMapCollectionDao;
	private CaseDataDAO caseDataDao;
	private ContextDAO contextDao;

	public List<Page> findPageList(Page page) {
		return pageDao.findPageList(page);
	}

	public int insertPage(Page page) {
		try {
			int i = pageDao.insertPage(page);
			Group g = groupDao.findGroupById(page.getGroupId());
			Group parentGroup = groupDao.findGroupById(g.getParentGroupId());
			Project c = projectDao.findProjectById(page.getProjectId());
			String code = c.getCode() + "_" + parentGroup.getCode() + "_" + g.getCode() + "_" + page.getId();
			page.setCode(code);
			i += pageDao.updatePage(page);
			return i;
		} catch (Exception e) {
			throw new RuntimeException(e.toString());
		}
	}

	public int insertPage(Page page, int userId) {
		try {
			int formerPageId=page.getId();
			page.setInsertUser(userId);
			page.setUpdateUser(userId);
			Date date = new Date();
			page.setInsertTime(date);
			page.setUpdateTime(date);
			int i = this.insertPage(page);
			ActionInfo action = new ActionInfo();
			action.setPageId(formerPageId);
			List<ActionInfo> actionList = actionDao.findActionList(action);
			insertAction(actionList,page,0);
			return i;
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}

	}
	public void insertAction(List<ActionInfo> actionList,Page page,int parentActionId){
		for (ActionInfo ai : actionList) {
			ai.setPageId(page.getId());
			if(null!=ai.getCommandName()&&ai.getCommandName().equals("logical.refPage")){
				
				Page childPage=this.findPageById(Integer.parseInt(ai.getElementXpath()));
				childPage.setGroupId(page.getGroupId());
				childPage.setProjectId(page.getProjectId());
				childPage.setTitle(childPage.getTitle()+"_copy");
				this.insertPage(childPage, page.getInsertUser());
				ai.setElementXpath(String.valueOf(childPage.getId()));
			}
			int formerActionId = ai.getId();
			ai.setParentActionId(parentActionId);
			actionDao.insertAction(ai);
			if (ai.getActionCategory() != 4) {
				DataMap dataMap = dataMapDao.findDataMapByActionId(formerActionId);
				if (dataMap != null) {
					dataMap.setPageId(page.getId());
					dataMap.setActionId(ai.getId());
					int formerDataMapId = dataMap.getId();
					dataMapDao.insertDataMap(dataMap);
					if (ai.getActionCategory() == 2 || ai.getActionCategory() == 3) {
						List<DataMapCollection> dList = dataMapCollectionDao.findDataMapCollectionListByDataMapId(formerDataMapId);
						for (DataMapCollection d : dList) {
							d.setDataMapId(dataMap.getId());
							dataMapCollectionDao.insertDataMapCollection(d);
						}
					}
				}
			}
			if("logical.refPage".equals(ai.getCommandName())){
				Integer dataMapSort = dataMapDao.findMaxSort(ai.getPageId());
				DataMap dataMap = new DataMap();
				dataMap.setCategory(ai.getActionCategory());
				dataMap.setActionId(ai.getId());
				dataMap.setPageId(ai.getPageId());
				dataMap.setSort(++dataMapSort);
				dataMap.setRefPageId(Integer.parseInt(ai.getElementXpath()));
				dataMapDao.insertDataMap(dataMap);
			}
			List<ActionInfo> childActionList = actionDao.findChildActionListByParentActionId(formerActionId);
			if(childActionList.size()>0){
				insertAction(childActionList,page,ai.getId());
			}
		}
	}
	public Page findPageById(int id) {
		return pageDao.findPageById(id);
	}

	public int updatePage(Page page) {
		try {
			return pageDao.updatePage(page);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public int deletePageById(int id) {
		try {
			ActionInfo action = new ActionInfo();
			action.setPageId(id);
			List<ActionInfo> actionList = actionDao.findActionList(action);
			for (ActionInfo ai : actionList) {
				DataMap dataMap = dataMapDao.findDataMapByActionId(ai.getId());
				if (dataMap != null) {
					caseDataDao.deleteCaseDataByDataMapId(dataMap.getId());
					dataMapCollectionDao.deleteDataMapCollectionByDataMapId(dataMap.getId());
					dataMapDao.deleteDataMapByActionId(ai.getId());
				}
				actionDao.deleteAction(ai.getId());
			}
			
			int i = pageDao.deletePageById(id);
			return i;
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}
	public int findPageCount(Page page){
		return pageDao.findPageCount(page);
	}
	public PageDAO getPageDao() {
		return pageDao;
	}

	public void setPageDao(PageDAO pageDao) {
		this.pageDao = pageDao;
	}

	public GroupDAO getGroupDao() {
		return groupDao;
	}

	public void setGroupDao(GroupDAO groupDao) {
		this.groupDao = groupDao;
	}

	public ProjectDAO getProjectDao() {
		return projectDao;
	}

	public void setProjectDao(ProjectDAO projectDao) {
		this.projectDao = projectDao;
	}

	public ActionDAO getActionDao() {
		return actionDao;
	}

	public void setActionDao(ActionDAO actionDao) {
		this.actionDao = actionDao;
	}

	public DataMapDAO getDataMapDao() {
		return dataMapDao;
	}

	public void setDataMapDao(DataMapDAO dataMapDao) {
		this.dataMapDao = dataMapDao;
	}

	public DataMapCollectionDAO getDataMapCollectionDao() {
		return dataMapCollectionDao;
	}

	public void setDataMapCollectionDao(DataMapCollectionDAO dataMapCollectionDao) {
		this.dataMapCollectionDao = dataMapCollectionDao;
	}

	public CaseDataDAO getCaseDataDao() {
		return caseDataDao;
	}

	public void setCaseDataDao(CaseDataDAO caseDataDao) {
		this.caseDataDao = caseDataDao;
	}

	public ContextDAO getContextDao() {
		return contextDao;
	}

	public void setContextDao(ContextDAO contextDao) {
		this.contextDao = contextDao;
	}

}
