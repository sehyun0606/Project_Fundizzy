package com.itwillbs.project_fundizzy.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.project_fundizzy.vo.ProjectListVO;

@Mapper
public interface MypageMapper {

	List<ProjectListVO> selectMyProjectList(String id);

}
