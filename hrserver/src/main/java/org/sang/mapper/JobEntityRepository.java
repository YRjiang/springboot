package org.sang.mapper;

import org.sang.bean.JobEntity;
import org.springframework.data.repository.CrudRepository;

/**
 * Created by EalenXie on 2018/6/4 14:27
 */
public interface JobEntityRepository extends CrudRepository<JobEntity, Long> {

    JobEntity getById(Integer id);

}
