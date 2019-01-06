package org.sang.service;

import java.util.List;

import org.sang.bean.MenuManage;

public interface IResourceService {

	List<MenuManage> selectByName(String name);

	List<MenuManage> selectAllMenuByHrID();

	List<MenuManage> selectAll();

	boolean addMenus(MenuManage menuManage);

	boolean deleteMenuById(String id);

}
