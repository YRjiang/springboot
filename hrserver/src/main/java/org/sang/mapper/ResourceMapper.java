package org.sang.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.sang.bean.MenuManage;

public interface ResourceMapper {// extends BaseMapper<MenuManage>

	List<MenuManage> selectByName(@Param("name") String name);

	List<MenuManage> selectAllMenuByHrID(@Param("hrid") Long hrid);

	List<MenuManage> selectAll();

	int addMenus(@Param("menuManage") MenuManage menuManage);

	int addMenuRole(@Param("mid") Integer mid, @Param("rid") Integer rid);

	int selectRidByHrId(@Param("hrid") Long hrid);

	int deleteMenuById(@Param("id") String id);

	int deleteMenuRoleByMid(@Param("mid") String mid);

}
