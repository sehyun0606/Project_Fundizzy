package com.itwillbs.project_fundizzy.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ProjectMakerMapper {

	void insertNewProject(Map<String, Object> map);

}
