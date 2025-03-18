package com.itwillbs.project_fundizzy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.project_fundizzy.mapper.AdminProjectMapper;
import com.itwillbs.project_fundizzy.vo.ProjectListVO;
import com.itwillbs.project_fundizzy.vo.RewardVO;

@Service
public class AdminProjectService {
	
	@Autowired
	private AdminProjectMapper projectMapper;
	
	//총 프로젝트 리스트 개수
	public int getprojectListCount() {
		return projectMapper.selectProjectListCount();
	}
	
	public int getAllProjectListCount() {
		return projectMapper.selectALLProjectListCount();
	}

	public List<ProjectListVO> getProjectList(int startRow, int listLimit) {
		return projectMapper.selectProjectList(startRow,listLimit);
	}
	
	//ajax를 활용한 기본 정보 조회
	public Map<String, Object> getProjectInfo(String projectCode) {
		return projectMapper.selectProjectInfo(projectCode);
	}

	public List<RewardVO> getRewardInfo(String projectCode) {
		return projectMapper.selectRewardInfo(projectCode);
	}

	public Map<String, Object> getMakerInfo(String projectCode) {
		return projectMapper.selectMakerInfo(projectCode);
	}

	public void projectAccept(String project_code) {
		projectMapper.projectAccept(project_code);
	}

	public void projectDeny(String project_code) {
		projectMapper.projectDeny(project_code);
	}

	public List<Map<String, Object>> getAllProjectList(int startRow, int listLimit) {
		return projectMapper.selectAllProjectList(startRow,listLimit);
	}
	
	@Transactional
	public void deleteProject(String projectCode) {
		projectMapper.updateDeleteStat(projectCode);
	}

	public void restoreProject(String project_code) {
		projectMapper.restoreProject(project_code);
	}
}
