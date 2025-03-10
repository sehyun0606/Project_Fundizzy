package com.itwillbs.project_fundizzy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project_fundizzy.vo.ProjectListVO;

@Mapper
public interface AdminProjectMapper {

	int selectProjectListCount();

	List<ProjectListVO> selectProjectList(@Param("startRow") int startRow, 
										  @Param("listLimit") int listLimit);
	
}
