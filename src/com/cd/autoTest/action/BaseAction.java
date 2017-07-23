package com.cd.autoTest.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.opensymphony.xwork2.ActionSupport;

public class BaseAction extends ActionSupport implements ServletRequestAware, ServletResponseAware{
	Logger log =LoggerFactory.getLogger(BaseAction.class);
	protected HttpServletRequest request;
	protected HttpServletResponse response;
	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
	}


	protected String toJson(int sEcho, int count, JSONArray json) {
		String jsonStr = "";
		jsonStr += "{\"sEcho\":" + sEcho + ",\"iTotalRecords\":" + count + ",\"iTotalDisplayRecords\":" + count
				+ ",\"aaData\":" + json.toString() + "}";
		log.info(jsonStr);
		return jsonStr;
	}

	@Override
	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
	}

	protected void WriteJson(int size, JSONArray json) {
		try {
			response.setContentType("text/json");
			response.setCharacterEncoding("UTF-8");
			PrintWriter writer;

			writer = response.getWriter();

			writer.print(toJson(0, size, json));
			writer.flush();
			writer.close();
		} catch (IOException e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}
	protected void WriteJson(JSONArray json) {
		try {
			log.info(json.toString());
			response.setContentType("text/json");
			response.setCharacterEncoding("UTF-8");
			PrintWriter writer;

			writer = response.getWriter();

			writer.print(json.toString());
			writer.flush();
			writer.close();
		} catch (IOException e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
	}
	protected void WriteJson(JSONObject  jsonObject) {
		response.setContentType("text/json");
		response.setCharacterEncoding("UTF-8");
		PrintWriter writer;
		try {
			writer = response.getWriter();
			writer.print(jsonObject.toString());
			writer.flush();
			writer.close();
		} catch (IOException e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
		
	}
	protected void WriteInteger(int i)
	{
		PrintWriter writer;
		try {
			writer = response.getWriter();
			writer.print(i);
			writer.flush();
			writer.close();
		} catch (IOException e) {
			log.info(e.toString());
			throw new RuntimeException(e.toString());
		}
		
	}
	
}
