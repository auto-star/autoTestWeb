package com.cd.autoTest.interceptor;

import java.util.Map;

import com.cd.autoTest.model.User;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

public class SessionIterceptor extends AbstractInterceptor {
	@Override
	public String intercept(ActionInvocation actionInvocation) throws Exception {  
        ActionContext ctx = ActionContext.getContext();  
        Map session = ctx.getSession();  
        Action action = (Action) actionInvocation.getAction(); 
        User user = (User) session.get("user"); 
        if(!actionInvocation.getProxy().getActionName().equals("loginAction"))
        {
        	if(user==null){
        		return Action.LOGIN; 
        	}else{
        		return actionInvocation.invoke(); 
        	}
        	
        }
        return actionInvocation.invoke(); 
    }

}
