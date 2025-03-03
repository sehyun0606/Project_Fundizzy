package com.itwillbs.project_fundizzy.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_fundizzy.mapper.ProjectMakerMapper;
import com.itwillbs.project_fundizzy.vo.ProjectInfoVO;

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
	public void registProjectInfo(ProjectInfoVO projectInfo) {
		makerMapper.insertProjcetInfo(projectInfo);
	}
	

}
