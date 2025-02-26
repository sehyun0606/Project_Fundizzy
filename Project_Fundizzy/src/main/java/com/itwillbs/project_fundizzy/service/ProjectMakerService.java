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

}
