package com.cd.autoTest.dao;

import java.util.List;


public interface IDAO {
	<T> List findList(T t);
}
