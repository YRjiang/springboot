package org.sang.service.quartz;

import java.util.List;

import org.sang.bean.quartz.QuartzEntity;

public interface IJobService {
	
    List<QuartzEntity> listQuartzEntity(QuartzEntity quartz,Integer pageNo,Integer pageSize);	
    
    Long listQuartzEntity(QuartzEntity quartz);	
}
