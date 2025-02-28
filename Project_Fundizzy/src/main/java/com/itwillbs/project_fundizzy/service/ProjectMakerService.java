package com.itwillbs.project_fundizzy.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_fundizzy.mapper.ProjectMakerMapper;

@Service
public class ProjectMakerService {
	
	@Autowired
	private ProjectMakerMapper makerMapper;
	
	public void makeNewProject(Map<String, Object> map) {
		makerMapper.insertNewProject(map);
	}

	public String getProjectInfo(String project_code) {
		return makerMapper.selectProjectInfo(project_code);
	}
	
	//AJAX를 활용한 서비스 타입 업데이트
	public void updateServceType(String service_type, String project_code) {
		makerMapper.updateServiceType(service_type, project_code);
	} 

}
