package com.itwillbs.project_fundizzy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project_fundizzy.vo.ProjectListVO;
import com.itwillbs.project_fundizzy.vo.RewardVO;

@Mapper
public interface AdminProjectMapper {

	int selectProjectListCount();

	List<ProjectListVO> selectProjectList(@Param("startRow") int startRow, 
										  @Param("listLimit") int listLimit);

	Map<String, Object> selectProjectInfo(String projectCode);

	List<RewardVO> selectRewardInfo(String projectCode);

	Map<String, Object> selectMakerInfo(String projectCode);

	void projectAccept(String project_code);

	void projectDeny(String project_code);

	List<Map<String, Object>> selectAllProjectList(@Param("startRow") int startRow, 
										  @Param("listLimit") int listLimit);


	void updateDeleteStat(String projectCode);

	void restoreProject(String project_code);
	
}
