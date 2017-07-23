package com.cd.autoTest.service;

import java.util.Iterator;
import java.util.List;

import org.json.JSONObject;

import com.cd.autoTest.dao.ActionDAO;
import com.cd.autoTest.dao.CaseDataDAO;
import com.cd.autoTest.dao.CasePageDAO;
import com.cd.autoTest.dao.DataMapCollectionDAO;
import com.cd.autoTest.dao.DataMapDAO;
import com.cd.autoTest.dao.ElementDAO;
import com.cd.autoTest.model.ActionInfo;
import com.cd.autoTest.model.CaseData;
import com.cd.autoTest.model.CasePage;
import com.cd.autoTest.model.DataMap;
import com.cd.autoTest.model.DataMapCollection;
import com.cd.autoTest.model.Element;

public class ActionService extends IService {
	private ActionDAO actionDao;
	private DataMapDAO dataMapDao;
	private DataMapCollectionDAO dataMapCollectionDao;
	private CasePageDAO casePageDao;
	private CaseDataDAO caseDataDao;
	private ElementDAO elementDao;
	public List<ActionInfo> findActionList(ActionInfo action) {
		return actionDao.findActionList(action);
	}
	public List<ActionInfo> findChildActionListByParentActionId(int parentActionId){
		return actionDao.findChildActionListByParentActionId(parentActionId);
	}
	public int insertAction(ActionInfo action) {
		return actionDao.insertAction(action);
	}

	public int insertAction(ActionInfo action, String jsonDataMapCollection) {
		try {
			int i = actionDao.insertAction(action);
			if (action.getActionCategory() != 4) {
				Integer dataMapSort = dataMapDao.findMaxSort(action.getPageId());
				DataMap dataMap = new DataMap();
				dataMap.setCategory(action.getActionCategory());
				dataMap.setActionId(action.getId());
				dataMap.setPageId(action.getPageId());
				dataMap.setSort(++dataMapSort);
				dataMapDao.insertDataMap(dataMap);
				if (action.getActionCategory() == 2 || action.getActionCategory() == 3) {
					DataMapCollection dataMapCollection = null;
					// 多选操作型和选择型同使用一个json格式
					String jsonStr = jsonDataMapCollection;
					JSONObject jsonObject = new JSONObject(jsonStr);
					Iterator it = null;
					it = jsonObject.keys();
					int j = 0;
					while (it.hasNext()) {
						j++;
						String key = it.next().toString();
						dataMapCollection = new DataMapCollection();
						dataMapCollection.setValue(key);
						dataMapCollection.setName(jsonObject.getString(key));
						dataMapCollection.setDataMapId(dataMap.getId());
						dataMapCollection.setSort(j);
						dataMapCollectionDao.insertDataMapCollection(dataMapCollection);
					}
				}
				
				CasePage casePage = new CasePage();
				casePage.setPageId(action.getPageId());
				// 同步更新所有使用到该页面的case
				List<CasePage> casePageList = casePageDao.findCasePageList(casePage);
				for (CasePage cp : casePageList) {
					Integer caseDataSort = caseDataDao.findMaxSort(cp.getId());
					CaseData caseData = new CaseData();
					caseData.setCategory(dataMap.getCategory());
					caseData.setDataMapId(dataMap.getId());
					caseData.setCasePageId(cp.getId());
					caseData.setSort(++caseDataSort);
					caseDataDao.insertCaseData(caseData);
				}
			}
			if("logical.refPage".equals(action.getCommandName())){
				Integer dataMapSort = dataMapDao.findMaxSort(action.getPageId());
				DataMap dataMap = new DataMap();
				dataMap.setCategory(action.getActionCategory());
				dataMap.setActionId(action.getId());
				dataMap.setPageId(action.getPageId());
				dataMap.setSort(++dataMapSort);
				dataMap.setRefPageId(Integer.parseInt(action.getElementXpath()));
				dataMapDao.insertDataMap(dataMap);
			}
			if("html.gatherData".equals(action.getCommandName())){
				Element element=new Element();
				element.setId(action.getId());
				element.setIsCompare(1);
				element.setName(action.getElementName());
				element.setPageId(action.getPageId());
				element.setXpath(action.getElementXpath());
				elementDao.insertElement(element);
			}
			return i;
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public int findMaxSort(int pageId) {
		return actionDao.findMaxSort(pageId);
	}
	public int findMaxSortByParentActionId(int parentActionId){
		return actionDao.findMaxSortByParentActionId(parentActionId);
	}
	public ActionInfo findActionById(int id) {
		return actionDao.findActionById(id);
	}

	public int updateActionSort(ActionInfo action) {
		try {
			return actionDao.updateActionSort(action);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public int deleteAction(int id) {
		try {
			List<ActionInfo> actionList=actionDao.findChildActionListByParentActionId(id);
			int i=0;
			if(actionList.size()==0){
				ActionInfo ai = this.findActionById(id);
				DataMap dataMap = dataMapDao.findDataMapByActionId(id);
				if (dataMap != null) {
					caseDataDao.deleteCaseDataByDataMapId(dataMap.getId());
					dataMapCollectionDao.deleteDataMapCollectionByDataMapId(dataMap.getId());
					dataMapDao.deleteDataMapByActionId(id);
				}
				i = actionDao.deleteAction(id);
				this.updateActionSortMinus(ai);
			}
			return i;
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}

	}

	public int updateAction(ActionInfo action, String jsonDataMapCollection) {
		try {
			int i = actionDao.updateAction(action);
			
			DataMap dataMap = dataMapDao.findDataMapByActionId(action.getId());
			
			if (dataMap != null) {
				
				dataMapCollectionDao.deleteDataMapCollectionByDataMapId(dataMap.getId());
				if (action.getActionCategory() == 2 || action.getActionCategory() == 3) {
					DataMapCollection dataMapCollection = null;
					String jsonStr = jsonDataMapCollection;
					JSONObject jsonObject = new JSONObject(jsonStr);
					Iterator it = null;
					it = jsonObject.keys();
					int j = 0;
					while (it.hasNext()) {
						j++;
						String key = it.next().toString();
						dataMapCollection = new DataMapCollection();
						dataMapCollection.setValue(key);
						dataMapCollection.setName(jsonObject.getString(key));
						dataMapCollection.setDataMapId(dataMap.getId());
						dataMapCollection.setSort(j);
						dataMapCollectionDao.insertDataMapCollection(dataMapCollection);
					}
				}
				if(null!=action.getCommandName()&&"logical.refPage".equals(action.getCommandName())){
					int j=dataMapDao.deleteDataMapByActionId(action.getId());
					if(j>0){
						Integer dataMapSort = dataMapDao.findMaxSort(action.getPageId());
						dataMap = new DataMap();
						dataMap.setCategory(action.getActionCategory());
						dataMap.setActionId(action.getId());
						dataMap.setPageId(action.getPageId());
						dataMap.setSort(++dataMapSort);
						dataMap.setRefPageId(Integer.parseInt(action.getElementXpath()));
						dataMapDao.insertDataMap(dataMap);
					}
				}
				if(null!=action.getCommandName()&&"html.gatherData".equals(action.getCommandName())){
					elementDao.deleteElement(action.getId());
					Element element=new Element();
					element.setId(action.getId());
					element.setIsCompare(1);
					element.setName(action.getElementName());
					element.setPageId(action.getPageId());
					element.setXpath(action.getElementXpath());
					elementDao.insertElement(element);
				}
			}
			return i;
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}

	public int updateActionSortMinus(ActionInfo action) {
		try {
			return actionDao.updateActionSortMinus(action);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
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

	public CasePageDAO getCasePageDao() {
		return casePageDao;
	}

	public void setCasePageDao(CasePageDAO casePageDao) {
		this.casePageDao = casePageDao;
	}

	public CaseDataDAO getCaseDataDao() {
		return caseDataDao;
	}

	public void setCaseDataDao(CaseDataDAO caseDataDao) {
		this.caseDataDao = caseDataDao;
	}
	public ElementDAO getElementDao() {
		return elementDao;
	}
	public void setElementDao(ElementDAO elementDao) {
		this.elementDao = elementDao;
	}

}
