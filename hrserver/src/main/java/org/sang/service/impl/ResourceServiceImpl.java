package org.sang.service.impl;

import java.util.List;

import org.sang.bean.MenuManage;
import org.sang.common.HrUtils;
import org.sang.mapper.ResourceMapper;
import org.sang.service.IResourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class ResourceServiceImpl implements IResourceService {

	@Autowired
	ResourceMapper resourceMapper;

	@Override
	public List<MenuManage> selectByName(String name) {
		List<MenuManage> menuList = resourceMapper.selectByName(name);
		return menuList;
	}

	@Override
	public List<MenuManage> selectAllMenuByHrID() {
		List<MenuManage> menuList = resourceMapper.selectAllMenuByHrID(HrUtils.getCurrentHr().getId());
		return menuList;
	}

	@Override
	public List<MenuManage> selectAll() {
		List<MenuManage> menuManageList = resourceMapper.selectAll();
		return menuManageList;
	}

	@Override
	public boolean addMenus(MenuManage menuManage) {
		int i = resourceMapper.addMenus(menuManage);
		int rid = resourceMapper.selectRidByHrId(HrUtils.getCurrentHr().getId());
		int m = resourceMapper.addMenuRole(menuManage.getId(), rid);
		if (i > 0 && m > 0) {
			return true;
		}
		return false;
	}

	@Override
	public boolean deleteMenuById(String id) {
		// String[] split = ids.split(",");
		// return resourceMapper.deleteMenuById(split)* == split.length;
		int i = resourceMapper.deleteMenuRoleByMid(id);
		int m = resourceMapper.deleteMenuById(id);
		if (i > 0 && m > 0) {
			return true;
		}
		return false;
	}

}
