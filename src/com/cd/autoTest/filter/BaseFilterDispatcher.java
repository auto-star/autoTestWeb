package com.cd.autoTest.filter;

import java.util.Timer;

import javax.servlet.FilterConfig;
import javax.servlet.ServletException;

import org.apache.struts2.dispatcher.ng.filter.StrutsPrepareAndExecuteFilter;

import com.cd.autoTest.socket.CaseStrategyTask;
import com.cd.autoTest.socket.SocketServer;


public class BaseFilterDispatcher extends StrutsPrepareAndExecuteFilter  {
	 @Override    
	    public void init(FilterConfig arg0) throws ServletException {    
	        super.init(arg0);
	        Timer timer = new Timer();  
	        timer.schedule(new CaseStrategyTask(), 0, 60000);
	        SocketServer.getInstance().init();
	    }    
}
