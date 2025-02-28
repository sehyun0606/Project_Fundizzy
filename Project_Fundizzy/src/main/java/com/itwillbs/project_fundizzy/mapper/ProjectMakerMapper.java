package com.itwillbs.project_fundizzy.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface ProjectMakerMapper {

	void insertNewProject(Map<String, Object> map);

	String selectProjectInfo(String project_code);

	void updateServiceType(@Param("service_type") String service_type,
							@Param("project_code") String project_code);

}
