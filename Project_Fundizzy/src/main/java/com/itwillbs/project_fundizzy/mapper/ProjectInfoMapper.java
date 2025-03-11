package com.itwillbs.project_fundizzy.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ProjectInfoMapper {

	String selectBusinessName(String project_code);

}
