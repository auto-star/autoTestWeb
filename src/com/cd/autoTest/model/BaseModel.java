package com.cd.autoTest.model;

import javax.servlet.http.HttpServletRequest;

public abstract class BaseModel {
	private int pageStart;
	private int pageSize;
	public int getPageStart() {
		return pageStart;
	}
	public void setPageStart(int pageStart) {
		this.pageStart = pageStart;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public void initPage(HttpServletRequest request){
		String sStart=request.getParameter("start");
		String sSize=request.getParameter("length");
		int pageStart=0;
		int pageSize=10;
		if(sSize!=null){
			pageSize= Integer.valueOf(sSize);
		}
		if(sStart!=null){
			pageStart=Integer.valueOf(sStart);
		}
		this.setPageSize(pageSize);
		this.setPageStart(pageStart);
		
	}
}
