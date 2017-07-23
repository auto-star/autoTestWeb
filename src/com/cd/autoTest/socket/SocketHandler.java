package com.cd.autoTest.socket;


import org.apache.mina.core.service.IoHandlerAdapter;
import org.apache.mina.core.session.IoSession;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.cd.autoTest.model.RunCaseResult;
import com.cd.autoTest.service.RunCaseResultService;

public class SocketHandler  extends IoHandlerAdapter  {
	ApplicationContext ac;
	@Override  
    public void exceptionCaught(IoSession arg0, Throwable arg1)  
            throws Exception {  
        arg1.printStackTrace();  
  
    }  
  
    @Override  
    public void messageReceived(IoSession session, Object message) throws Exception {  
    	if(message instanceof Message)
    	{
    		if("idle".equals(((Message) message).getStatus()))
    		{
    			try
    			{
    				if(ac==null)
        			{
        				ac = new ClassPathXmlApplicationContext("applicationContext.xml");
        			}
    	    		RunCaseResultService runCaseResultService=(RunCaseResultService) ac.getBean("runCaseResultService");
    	    		RunCaseResult runCaseResult=null;
    	    		runCaseResult=runCaseResultService.findRunCaseResultByIp(((Message) message).getIp());
    	    		if(null==runCaseResult){
    	    			runCaseResult=runCaseResultService.findRunCaseResult();
    	    		}
    	    		if(runCaseResult!=null)
    	    		{
    		    		((Message) message).setCaseId(runCaseResult.getCaseId());
    		    		((Message) message).setRunCaseResultId(runCaseResult.getId());
    		    		((Message) message).setEnvironmentId(runCaseResult.getEnvironmentId());
    		    		((Message) message).setScreenShot(runCaseResult.getScreenShot());
    		    		runCaseResult.setStatus(1);
    		    		runCaseResult.setIp(((Message) message).getIp());
    		    		runCaseResultService.updateRunCaseResultIpAndStatus(runCaseResult);
    		    		session.write(message); 
    	    		}
    			}
    			catch(Exception e)
    			{
    				System.out.println(e.toString());
    			}
    			
    		}
    	}
        
    }  
  
}
