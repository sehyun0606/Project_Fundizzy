package com.itwillbs.project_fundizzy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.project_fundizzy.mapper.ProjectMakerMapper;
import com.itwillbs.project_fundizzy.vo.MakerInfoVO;
import com.itwillbs.project_fundizzy.vo.ProjectInfoVO;
import com.itwillbs.project_fundizzy.vo.ProjectStoryVO;
import com.itwillbs.project_fundizzy.vo.RewardVO;

@Service
public class ProjectMakerService {
	
	@Autowired
	private ProjectMakerMapper makerMapper;
	
	public void makeNewProject(Map<String, Object> map) {
		makerMapper.insertNewProject(map);
	}

	//프로젝트 전체 설정 여부 확인
	public Map<String, String> getSettingInfo(String project_code) {
		return makerMapper.selectSettingInfo(project_code);
	} 
	
	//AJAX를 활용한 서비스 타입 업데이트
	public void updateServceType(String service_type, String project_code) {
		makerMapper.updateServiceType(service_type, project_code);
	}

	public String getServiceType(String projectCode) {
		return makerMapper.selectServiceType(projectCode);
	}
	
	//프로젝트 정보 저장
	//프로젝트 리스트에 설정 스텟 업데이트
	@Transactional
	public void registProjectInfo(ProjectInfoVO projectInfo) {
		
	 	String projectCode = projectInfo.getProject_code();
		
		makerMapper.updateProjcetInfoConfig(projectCode);
		
		makerMapper.insertProjcetInfo(projectInfo);
	}
	
	//프로젝트 리워드 저장
	@Transactional
	public void registReward(RewardVO reward) {
		
		String projcetCode = reward.getProject_code();
		
		makerMapper.updateRewardConfig(projcetCode);
		
		makerMapper.insertReward(reward);
	}

	//리워드 불러오기
	public List<RewardVO> getReward(String projectCode) {
		return makerMapper.selectReward(projectCode);
	}
	
	//메이커 정보 저장
	@Transactional
	public void registMakerInfo(MakerInfoVO makerInfo) {
		String projectCode = makerInfo.getProject_code();
		makerMapper.updateMakerInfoConfig(projectCode);
		makerMapper.insertMakerInfo(makerInfo);
	}
	
	//메이커 정보 수정을 위한 불러오기 메서드
	public MakerInfoVO getMakerInfo(String projectCode) {
		return makerMapper.selectMakerInfo(projectCode);
	}
	
	//프로젝트 정보 수정을 위한 불러오기 메서드
	public ProjectInfoVO getProjectinfo(String project_code) {
		return makerMapper.selectProjcetInfo(project_code);
	}

	public void updateMakerInfo(MakerInfoVO makerInfo) {
		makerMapper.updateMakerInfo(makerInfo);
	}
	
	//프로젝트 스토리 저장을 위한 메서드
	@Transactional
	public void registProjectStory(ProjectStoryVO projectStory) {
		String projectCode = projectStory.getProject_code();
		makerMapper.updatProjectStorySetting(projectCode);
		makerMapper.insertProjectStory(projectStory);
	}

	public ProjectStoryVO getProjectStory(String project_code) {
		return makerMapper.selectProjectStory(project_code);
	}
	

}
