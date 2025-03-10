package com.itwillbs.project_fundizzy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.project_fundizzy.mapper.AdminProjectMapper;
import com.itwillbs.project_fundizzy.vo.ProjectListVO;

@Service
public class AdminProjectService {
	
	@Autowired
	private AdminProjectMapper projectMapper;
	
	//총 프로젝트 리스트 개수
	public int getprojectListCount() {
		return projectMapper.selectProjectListCount();
	}

	public List<ProjectListVO> getProjectList(int startRow, int listLimit) {
		return projectMapper.selectProjectList(startRow,listLimit);
	}

}
