package com.itwillbs.project_fundizzy.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.project_fundizzy.vo.MakerInfoVO;
import com.itwillbs.project_fundizzy.vo.ProjectDateVO;
import com.itwillbs.project_fundizzy.vo.ProjectInfoVO;
import com.itwillbs.project_fundizzy.vo.ProjectStoryVO;
import com.itwillbs.project_fundizzy.vo.RewardVO;

@Mapper
public interface ProjectMakerMapper {

	void insertNewProject(Map<String, Object> map);

	//프로젝트 설정 여부
	Map<String, String> selectSettingInfo(String project_code);

	void updateServiceType(@Param("service_type") String service_type,
							@Param("project_code") String project_code);

	String selectServiceType(String projectCode);

	void insertProjcetInfo(ProjectInfoVO projectInfo);

	void insertReward(RewardVO reward);

	List<RewardVO> selectReward(String projectCode);
	
	void updateProjcetInfoConfig(String projectCode);

	void updateRewardConfig(String projcetCode);

	void updateMakerInfoConfig(String projectCode);

	void insertMakerInfo(MakerInfoVO makerInfo);

	MakerInfoVO selectMakerInfo(String projectCode);

	ProjectInfoVO selectProjcetInfo(String project_code);

	void updateMakerInfo(MakerInfoVO makerInfo);

	void insertProjectStory(ProjectStoryVO projectStory);

	void updatProjectStorySetting(@Param("projectCode") String projectCode, 
								  @Param("projectTitle") String projectTitle,
								  @Param("representativePicture") String representativePicture);

	ProjectStoryVO selectProjectStory(String project_code);

	RewardVO selectRewardInfo(int reward_code);

	void updateReward(RewardVO reward);

	void deleteReward(String reward_code);

	void updateProjectStory(ProjectStoryVO projectStory);

	void updateProjectList(String projectCode);

	Map<String, Object> selectDate(String projectCode);

	String selectRequestInfo(String projectCode);

	void updateProjectInfo(ProjectInfoVO projectInfo);

	void insertProjectDate(ProjectDateVO date);

	void updateDateConfig(String projectCode);


}
