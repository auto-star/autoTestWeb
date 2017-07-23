package com.cd.autoTest.action;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.json.JSONArray;
import org.json.JSONObject;

import com.cd.autoTest.model.Degrade;
import com.cd.autoTest.model.DegradeData;
import com.cd.autoTest.model.Environment;
import com.cd.autoTest.service.DegradeDataService;
import com.cd.autoTest.service.DegradeService;
import com.cd.autoTest.service.EnvironmentService;
import com.cd.autoTest.util.ExcelUtil;
import com.opensymphony.xwork2.Action;

@SuppressWarnings("serial")
public class DegradeAction extends BaseAction {
	private DegradeService degradeService;
	private DegradeDataService degradeDataService;
	private EnvironmentService environmentService;
	private Degrade degrade;
	private InputStream downloadFileStream;
	private String downloadFileName;
	private List<Environment> environmentList;
	public String initDegrade() {
		environmentList = environmentService.findEnvironmentList();
		return Action.SUCCESS;
	}

	public void findDegradeList() {

		try {
			if(degrade==null){
				degrade=new Degrade();
			}
			degrade.initPage(request);
			List<Degrade> degradeList = degradeService.findDegradeList(degrade);
			int size = degradeService.findDegradeCount(degrade);
			JSONArray json = new JSONArray();
			for (Degrade degrade : degradeList) {
				JSONObject jo = new JSONObject();
				jo.put("caseId", degrade.getCaseId());
				jo.put("caseName", degrade.getCaseName());
				jo.put("leftRunCaseResultId", degrade.getLeftRunCaseResultId());
				jo.put("rightRunCaseResultId", degrade.getRightRunCaseResultId());
				jo.put("leftEnvironmentId", degrade.getLeftRunCaseResultId());
				jo.put("leftEnvrionmentName", degrade.getLeftEnvrionmentName());
				jo.put("rightEnvironmentId", degrade.getLeftRunCaseResultId());
				jo.put("rightEnvironmentName", degrade.getRightEnvironmentName());
				jo.put("leftExecuteDate", degrade.getLeftExecuteDate());
				jo.put("rightExecuteDate", degrade.getRightExecuteDate());
				json.put(jo);
			}
			this.WriteJson(size, json);
		} catch (Exception e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
		
	}
	public void compare(){
		int val=1;
		int leftRunCaseResultId=Integer.valueOf(request.getParameter("leftRunCaseResultId"));
		int rightRunCaseResultId=Integer.valueOf(request.getParameter("rightRunCaseResultId"));
		
		List<DegradeData> leftDegradeDataList=degradeDataService.findDegradeDataList(leftRunCaseResultId);
		List<DegradeData> rightDegradeDataList=degradeDataService.findDegradeDataList(rightRunCaseResultId);
		int size=leftDegradeDataList.size();
		if(size==rightDegradeDataList.size()){
			for(int i=0;i<size;i++){
				if(leftDegradeDataList.get(i).getIsCompare()==1){
					if(!leftDegradeDataList.get(i).getPageValue().equals(rightDegradeDataList.get(i).getPageValue())){
						val=0;
						break;
					}
				}
			}
		}else{
			val=0;
		}
		this.WriteInteger(val);
	}
	public String downloadDegradeFile() {
		int leftRunCaseResultId=Integer.valueOf(request.getParameter("leftRunCaseResultId"));
		int rightRunCaseResultId=Integer.valueOf(request.getParameter("rightRunCaseResultId"));
		Degrade leftDegrade=degradeService.findDegradeById(leftRunCaseResultId);
		Degrade rightDegrade=degradeService.findDegradeById(rightRunCaseResultId);
		List<DegradeData> leftDegradeDataList=degradeDataService.findDegradeDataList(leftRunCaseResultId);
		List<DegradeData> rightDegradeDataList=degradeDataService.findDegradeDataList(rightRunCaseResultId);
		int size=leftDegradeDataList.size();
		
		downloadFileName = leftDegrade.getCaseName()+".xlsx";
		try {
			downloadFileName = new String(downloadFileName.getBytes("GBK"), "ISO8859-1");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		SXSSFWorkbook wb = ExcelUtil.getInstance().init();
		ExcelUtil.getInstance().createSheet(leftDegrade.getCaseName());
		Object[] titleArr = { "Page", "Element", new HSSFRichTextString(leftDegrade.getEnvironmentName()+"\r "+leftDegrade.getExecuteDate()), new HSSFRichTextString(rightDegrade.getEnvironmentName()+"\r "+rightDegrade.getExecuteDate()),"是否一致" };
		ExcelUtil.getInstance().createRow(0,1000, titleArr);
		if(size==rightDegradeDataList.size()){
			for(int i=0;i<size;i++){
				String[] arr = new String[5];
				arr[0] =leftDegradeDataList.get(i).getCasePageName();
				arr[1] = leftDegradeDataList.get(i).getItemName();
				arr[2] = leftDegradeDataList.get(i).getPageValue()==null?"":leftDegradeDataList.get(i).getPageValue();
				arr[3] = rightDegradeDataList.get(i).getPageValue()==null?"":rightDegradeDataList.get(i).getPageValue();
				arr[4] = arr[2].equals(arr[3])?"":"不一致";
				ExcelUtil.getInstance().createRow(1, arr);
			}
		}
		ByteArrayOutputStream baos = new ByteArrayOutputStream();  
		try {
			wb.write(baos);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}  
		  
		downloadFileStream = new ByteArrayInputStream(baos.toByteArray()); 
		return Action.SUCCESS;
		
		
	}


	

	public DegradeService getDegradeService() {
		return degradeService;
	}

	public void setDegradeService(DegradeService degradeService) {
		this.degradeService = degradeService;
	}

	public Degrade getDegrade() {
		return degrade;
	}

	public void setDegrade(Degrade degrade) {
		this.degrade = degrade;
	}

	public InputStream getDownloadFileStream() {
		return downloadFileStream;
	}

	public void setDownloadFileStream(InputStream downloadFileStream) {
		this.downloadFileStream = downloadFileStream;
	}

	public String getDownloadFileName() {
		return downloadFileName;
	}

	public void setDownloadFileName(String downloadFileName) {
		this.downloadFileName = downloadFileName;
	}

	public DegradeDataService getDegradeDataService() {
		return degradeDataService;
	}

	public void setDegradeDataService(DegradeDataService degradeDataService) {
		this.degradeDataService = degradeDataService;
	}

	public EnvironmentService getEnvironmentService() {
		return environmentService;
	}

	public void setEnvironmentService(EnvironmentService environmentService) {
		this.environmentService = environmentService;
	}

	public List<Environment> getEnvironmentList() {
		return environmentList;
	}

	public void setEnvironmentList(List<Environment> environmentList) {
		this.environmentList = environmentList;
	}
	
}
