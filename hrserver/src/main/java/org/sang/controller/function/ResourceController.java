package org.sang.controller.function;

import java.util.List;

import org.sang.bean.MenuManage;
import org.sang.bean.RespBean;
import org.sang.service.IResourceService;
import org.sang.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * @Description
 * @author []
 * @date 2018年12月17日 下午10:12:46
 */
@RestController
@RequestMapping("/function/resource")
public class ResourceController {

    @Autowired
    IResourceService resourceService;

    @Autowired
    MenuService menuService;
    /*
     * 创建菜单 - 1.新建 一级 目录 ---------------- - 2.新建 二级 目录 ---------------- - 3.新建 按钮
     * ----------------
     */

    @RequestMapping(value = "/loadMenu", method = RequestMethod.GET)
    public Object addResource(Long hrid) {
        // List<Menu> menuList = resourceService.selectByName(menuManage.getMenuName());
        // List<Menu> menuList = menuService.getMenusByHrId();
        List<MenuManage> menuList = resourceService.selectAll();
        // List<MenuManage> menuList = resourceService.selectAllMenuByHrID();
        return menuList;
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public RespBean addMenu(MenuManage menuManage) {
        boolean i = resourceService.addMenus(menuManage);
        if (i) {
            return RespBean.ok("添加成功!");
        }
        return RespBean.error("添加失败!");
    }

    @RequestMapping(value = "/delete/{ids}", method = RequestMethod.DELETE)
    public RespBean deleteMenuById(@PathVariable String ids) {
        if (resourceService.deleteMenuById(ids)) {
            return RespBean.ok("删除成功!");
        }
        return RespBean.error("删除失败!");
    }

}
