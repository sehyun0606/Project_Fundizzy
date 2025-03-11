package com.itwillbs.project_fundizzy.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ProjectStoryMapper {

	String selectProjectTitle(String project_code);

	String selectRepresentativePicture(String project_code);

}
