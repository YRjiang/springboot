package org.sang.controller;

import java.util.List;

import org.sang.bean.Hr;
import org.sang.bean.Menu;
import org.sang.common.HrUtils;
import org.sang.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 这是一个只要登录就能访问的Controller 主要用来获取一些配置信息
 */
@RestController
@RequestMapping("/config")
public class ConfigController {
	@Autowired
	MenuService menuService;

	@RequestMapping("/sysmenu")
	public List<Menu> sysmenu() {
		List<Menu> menuList = menuService.getMenusByHrId();
		return menuList;
	}

	@RequestMapping("/hr")
	public Hr currentUser() {
		return HrUtils.getCurrentHr();
	}
}
